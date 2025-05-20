package local.example.demo.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest; // Thêm import này
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.JoinType;
import local.example.demo.model.entity.Brand;
import local.example.demo.model.entity.Product;
import local.example.demo.model.entity.ProductVariant;
import local.example.demo.repository.ProductRepository;
import local.example.demo.repository.ProductVariantRepository;
import lombok.RequiredArgsConstructor;

import java.math.BigDecimal; // Thêm import này
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import local.example.demo.model.entity.*;
import local.example.demo.repository.ProductRepository;

import jakarta.persistence.criteria.Predicate; // Thêm import này

@RequiredArgsConstructor
@Service
public class ProductService {

    private final ProductRepository productRepository;
    private final ProductVariantRepository productVariantRepository ;



    // get all product
    public List<Product> findAllProducts() {
        return productRepository.findAllProducts();
    }

    // get all product by page
    public Page<Product> fetchProducts(Pageable pageable) {
        return productRepository.findAll(pageable);
    }

    // public Page<Product> fetchProducts(String name, Pageable pageable) {
    //     return productRepository.findAll(this.nameLike(name), pageable);
    // }
    
    // private Specification<Product> nameLike(String name){
    //     return (root, query, criteriaBuilder) -> criteriaBuilder.like(root.get(Product_.PRODUCT_NAME), "%"+name+"%");

    // }



    // save product
    public void saveProduct(Product product) {
        productRepository.save(product);
    }

    public Product findProductById(Integer productId) {
        return productRepository.findById(productId).orElse(null);
    }

    // find product by id
    public Page<Product> findFilteredAndSortedProducts(
            Optional<Integer> brandId,
            Optional<Integer> categoryId,
            Optional<Integer> sizeId,
            Optional<Integer> colorId,
            Optional<BigDecimal> minPrice, // Thay đổi thành BigDecimal
            Optional<BigDecimal> maxPrice, // Thay đổi thành BigDecimal
            Optional<Boolean> type, // Thêm tham số type
            Optional<String> sortByOpt,
            Pageable pageable) {

        Specification<Product> spec = Specification.where(null); // Start with an empty specification

        // Chain the .and() conditions, reassigning to spec
        if (brandId.isPresent()) {
            spec = spec.and(brandIdEquals(brandId.get()));
        }
        if (categoryId.isPresent()) {
            spec = spec.and(categoryIdEquals(categoryId.get()));
        }
        // Lọc qua ProductVariant
        if (sizeId.isPresent()) {
            spec = spec.and(hasVariantWithSize(sizeId.get()));
        }
        if (colorId.isPresent()) {
            spec = spec.and(hasVariantWithColor(colorId.get()));
        }
        // Lọc theo giá (sử dụng BigDecimal)
        if (minPrice.isPresent()) {
            spec = spec.and(priceGreaterThanOrEqualTo(minPrice.get()));
        }
        if (maxPrice.isPresent()) {
            spec = spec.and(priceLessThanOrEqualTo(maxPrice.get()));
        }
        // Thêm lọc theo type
        if (type.isPresent()) {
            spec = spec.and(typeEquals(type.get()));
        }


        // Xử lý sắp xếp
        String sortBy = sortByOpt.orElse("newest"); // Mặc định là newest
        Sort sort;
        switch (sortBy) {
            case "priceAsc":
                sort = Sort.by(Sort.Direction.ASC, "price");
                break;
            case "priceDesc":
                sort = Sort.by(Sort.Direction.DESC, "price");
                break;
            case "bestSellers":
                 sort = Sort.by(Sort.Direction.DESC, "quantitySold");
                 break;
            case "newest":
            default:
                sort = Sort.by(Sort.Direction.DESC, "productId"); // Sắp xếp theo ID giảm dần (mới nhất)
                break;
        }

        Pageable sortedPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);

        // Create a final variable for the spec to be used in the lambda
        final Specification<Product> finalSpec = spec;

        // Define the specification, using the finalSpec variable
        Specification<Product> specification = (root, query, cb) -> {
            Predicate predicate = null;
            if (finalSpec != null) {
                 predicate = finalSpec.toPredicate(root, query, cb);
            }

            // Apply distinct only if filtering by size or color to avoid duplicates from joins
            // if (sizeId.isPresent() || colorId.isPresent()) {
            //      query.distinct(true);
            // }

            return predicate;
        };


        // Pass the specification to the repository
        return productRepository.findAll(specification, sortedPageable);
    }

    // --- Specification Helper Methods ---

    private Specification<Product> brandIdEquals(Integer brandId) {
        return (root, query, cb) -> cb.equal(root.get("brand").get("brandId"), brandId);
    }

    private Specification<Product> categoryIdEquals(Integer categoryId) {
        return (root, query, cb) -> cb.equal(root.get("category").get("categoryId"), categoryId);
    }

    // Specification để kiểm tra Product có variant với sizeId cụ thể
    private Specification<Product> hasVariantWithSize(Integer sizeId) {
        return (root, query, cb) -> {
            // Join Product với ProductVariant
            Join<Product, ProductVariant> variantJoin = root.join("productVariant", JoinType.INNER);
            // Join ProductVariant với Size
            Join<ProductVariant, Size> sizeJoin = variantJoin.join("size", JoinType.INNER);
            // Điều kiện lọc theo sizeId
            return cb.equal(sizeJoin.get("sizeId"), sizeId);
        };
    }

    // Specification để kiểm tra Product có variant với colorId cụ thể
    private Specification<Product> hasVariantWithColor(Integer colorId) {
        return (root, query, cb) -> {
            // Join Product với ProductVariant
            Join<Product, ProductVariant> variantJoin = root.join("productVariant", JoinType.INNER);
            // Join ProductVariant với Color
            Join<ProductVariant, Color> colorJoin = variantJoin.join("color", JoinType.INNER);
            // Điều kiện lọc theo colorId
            return cb.equal(colorJoin.get("colorId"), colorId);
        };
    }

    // Specification để kiểm tra giá >= minPrice (sử dụng BigDecimal)
    private Specification<Product> priceGreaterThanOrEqualTo(BigDecimal minPrice) {
        return (root, query, cb) -> cb.greaterThanOrEqualTo(root.get("price"), minPrice);
    }

    // Specification để kiểm tra giá <= maxPrice (sử dụng BigDecimal)
    private Specification<Product> priceLessThanOrEqualTo(BigDecimal maxPrice) {
        return (root, query, cb) -> cb.lessThanOrEqualTo(root.get("price"), maxPrice);
    }

    // Specification để lọc theo type (Boolean)
    private Specification<Product> typeEquals(Boolean type) {
        return (root, query, cb) -> cb.equal(root.get("type"), type);
    }


    // delete product by id
    public void deleteProductById(Integer productId) {
        productRepository.deleteById(productId);
    }

    // get product by supplierId
    public List<Product> findProductsBySupplierId(Integer supplierId) {
        return productRepository.findProductsBySupplierId(supplierId);
    }

    // get product type men
    public List<Product> findProductsByTypeMen() {
        return productRepository.findProductsByTypeMen();
    }
    // get product type men by page
    public Page<Product> findProductsByTypeMen(Pageable pageable) {
        return productRepository.findProductsByTypeMen(pageable);
    }

    // get product type women
    public List<Product> findProductsByTypeWomen() {
        return productRepository.findProductsByTypeWomen();
    }
    // get product type women by page
    public Page<Product> findProductsByTypeWomen(Pageable pageable) {
        return productRepository.findProductsByTypeWomen(pageable);
    }

    public List<ProductVariant> findVariantsByProductId(Integer productId) {
        return productVariantRepository.findByProduct_ProductId(productId);
    }
   
}
