// package local.example.demo;

// import org.springframework.boot.CommandLineRunner;
// import org.springframework.context.annotation.Bean;
// import org.springframework.context.annotation.Configuration;

// import local.example.demo.model.entity.ProductVariant;
// import local.example.demo.repository.ProductVariantRepository;

// import java.util.List;

// @Configuration
// public class TestProductVariantQuantity {

//     @Bean
//     public CommandLineRunner testQuantityStock(ProductVariantRepository productVariantRepository) {
//         return args -> {
//             // Find all product variants for product_id = 13
//             List<ProductVariant> variants = productVariantRepository.findByProduct_ProductId(14);

//             System.out.println("=== Quantity Stock for Product ID 13 ===");
//             if (variants.isEmpty()) {
//                 System.out.println("No variants found for product_id = 13");
//             } else {
//                 for (ProductVariant variant : variants) {
//                     System.out.println("Product Variant ID: " + variant.getProductVariantId());
//                     System.out.println("SKU: " + variant.getSKU());
//                     System.out.println("Quantity Stock: " + variant.getQuantityStock());
//                     System.out.println("Size: " + variant.getSize().getSizeName());
//                     System.out.println("Color: " + variant.getColor().getColorName());
//                     System.out.println("---------------------");
//                 }
//             }
//         };
//     }
// }