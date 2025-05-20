package local.example.demo.service;

import local.example.demo.model.entity.Product;
import local.example.demo.model.entity.ProductImage;
import local.example.demo.repository.ProductImageRepository;
import local.example.demo.repository.ProductRepository;
import lombok.RequiredArgsConstructor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import jakarta.servlet.ServletContext;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ProductImageService {

    private final ProductImageRepository productImageRepository;
    private final ProductRepository productRepository;
    private final FileService fileService;
    private final ServletContext servletContext;
    private static final String IMAGE_UPLOAD_FOLDER = "products";

    public List<ProductImage> getProductImagesByProductId(Integer productId) {
        return productImageRepository.findByProduct_ProductId(productId);
    }

    public Optional<ProductImage> findById(Integer productImageId) {
        return productImageRepository.findById(productImageId);
    }

    @Transactional
    public ProductImage saveProductImage(Integer productId, MultipartFile imageFile, boolean isDefault)
            throws IOException {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found with id: " + productId));

        String imageName = fileService.handleSaveUploadFile(imageFile, IMAGE_UPLOAD_FOLDER);
        if (imageName.isEmpty()) {
            throw new IOException("Could not save image file.");
        }

        ProductImage productImage = new ProductImage();
        productImage.setProduct(product);
        productImage.setImageUrl("/resources/images-upload/" + IMAGE_UPLOAD_FOLDER + "/" + imageName);
        productImage.setPriority(isDefault);

        if (isDefault) {
            productImageRepository.clearDefaultImageFlagByProductIdAndExclude(productId, null);
        }

        ProductImage savedImage = productImageRepository.save(productImage);

        // Nếu isDefault là true, và sau khi save, cần đảm bảo các ảnh khác không phải
        // là default
        // (Phòng trường hợp save không thành công ở bước trên hoặc cần cập nhật lại sau
        // khi có ID)
        if (isDefault && savedImage.getProductImageId() != null) {
            productImageRepository.clearDefaultImageFlagByProductIdAndExclude(productId,
                    savedImage.getProductImageId());
        }

        return savedImage;
    }

    @Transactional
    public void deleteProductImage(Integer productImageId) throws IOException {
        ProductImage productImage = productImageRepository.findById(productImageId)
                .orElseThrow(() -> new RuntimeException("ProductImage not found with id: " + productImageId));

        String realPath = servletContext.getRealPath("/resources/");
        if (realPath != null && productImage.getImageUrl() != null) {
            Path filePathToDelete = Paths.get(realPath, productImage.getImageUrl());
            try {
                Files.deleteIfExists(filePathToDelete);
            } catch (IOException e) {
                System.err.println("Failed to delete image file: " + filePathToDelete + " - " + e.getMessage());
            }
        } else {
            System.err.println("Could not get real path or image URL is null for resource deletion.");
        }

        boolean wasDefault = productImage.isPriority();
        Integer productId = productImage.getProduct().getProductId();
        productImageRepository.delete(productImage);

        // Nếu ảnh bị xóa là ảnh default, và còn ảnh khác, chọn một ảnh làm default mới
        if (wasDefault) {
            List<ProductImage> remainingImages = productImageRepository.findByProduct_ProductId(productId);
            if (!remainingImages.isEmpty()) {
                ProductImage newDefault = remainingImages.get(0); // Chọn ảnh đầu tiên trong danh sách còn lại
                newDefault.setPriority(true);
                productImageRepository.save(newDefault);
            }
        }
    }

    @Transactional
    public void setDefaultImage(Integer productId, Integer productImageId) {
        // Bỏ cờ default của tất cả các ảnh khác của sản phẩm này
        productImageRepository.clearDefaultImageFlagByProductIdAndExclude(productId, productImageId);

        // Đặt ảnh được chọn làm default
        ProductImage newDefaultImage = productImageRepository.findById(productImageId)
                .orElseThrow(() -> new RuntimeException("ProductImage not found with id: " + productImageId));
        newDefaultImage.setPriority(true);
        productImageRepository.save(newDefaultImage);
    }
}
