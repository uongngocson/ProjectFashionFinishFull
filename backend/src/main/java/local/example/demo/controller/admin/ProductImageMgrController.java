package local.example.demo.controller.admin;

import local.example.demo.model.entity.Product;
import local.example.demo.model.entity.ProductImage;
import local.example.demo.service.ProductImageService;
import local.example.demo.service.ProductService;
import lombok.RequiredArgsConstructor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;

@RequiredArgsConstructor
@Controller
@RequestMapping("/admin/product-image-mgr")
public class ProductImageMgrController {

    private final ProductImageService productImageService;
    private final ProductService productService;

    @GetMapping("/add/{productId}")
    public String showAddImageForm(@PathVariable("productId") Integer productId, Model model) {
        Product product = productService.findProductById(productId);
        model.addAttribute("product", product);
        model.addAttribute("productImage", new ProductImage());
        return "admin/product-mgr/form-image";
    }

    @PostMapping("/add/{productId}")
    public String addProductImage(@PathVariable("productId") Integer productId,
            @RequestParam("imageFile") MultipartFile imageFile,
            @RequestParam(value = "isDefault", required = false) boolean isDefault,
            RedirectAttributes redirectAttributes) {
        if (imageFile.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Vui lòng chọn một file ảnh.");
            return "redirect:/admin/product-image-mgr/add/" + productId;
        }

        try {
            productImageService.saveProductImage(productId, imageFile, isDefault);
            redirectAttributes.addFlashAttribute("successMessage", "Thêm ảnh sản phẩm thành công!");
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi lưu ảnh: " + e.getMessage());
            return "redirect:/admin/product-image-mgr/add/" + productId;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
            return "redirect:/admin/product-image-mgr/add/" + productId;
        }
        return "redirect:/admin/product-mgr/detail/" + productId;
    }

    @GetMapping("/delete/{productImageId}/{productId}")
    public String deleteProductImage(@PathVariable("productImageId") Integer productImageId,
            @PathVariable("productId") Integer productId,
            RedirectAttributes redirectAttributes) {
        try {
            productImageService.deleteProductImage(productImageId);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa ảnh sản phẩm thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi xóa ảnh: " + e.getMessage());
        }
        return "redirect:/admin/product-mgr/detail/" + productId;
    }

    @GetMapping("/set-default/{productImageId}/{productId}")
    public String setDefaultImage(@PathVariable("productImageId") Integer productImageId,
            @PathVariable("productId") Integer productId,
            RedirectAttributes redirectAttributes) {
        try {
            productImageService.setDefaultImage(productId, productImageId);
            redirectAttributes.addFlashAttribute("successMessage", "Đặt ảnh làm mặc định thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi đặt ảnh làm mặc định: " + e.getMessage());
        }
        return "redirect:/admin/product-mgr/detail/" + productId;
    }
}
