
// test không dùng

package local.example.demo.controller.client;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import local.example.demo.service.DiscountProduct;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/api/discounts")
@Slf4j
public class DiscountController {

    @Autowired
    private DiscountProduct discountProductService;

    /**
     * Get all discounts for a specific product
     * 
     * @param productId the ID of the product
     * @return ResponseEntity with a list of discounts or error message
     */
    @GetMapping("/product/{productId}")
    public ResponseEntity<?> getDiscountsByProductId(@PathVariable int productId) {
        log.info("Fetching discounts for product ID: {}", productId);

        try {
            List<Map<String, Object>> discounts = discountProductService.getDiscountsByProductId(productId);

            if (discounts.isEmpty()) {
                log.info("No discounts found for product ID: {}", productId);
                return new ResponseEntity<>(
                        Map.of("message", "No discounts found for the specified product"),
                        HttpStatus.NOT_FOUND);
            }

            // Log the results for terminal output as requested
            logDiscountsToTerminal(productId, discounts);

            Map<String, Object> response = new HashMap<>();
            response.put("productId", productId);
            response.put("discountCount", discounts.size());
            response.put("discounts", discounts);

            return new ResponseEntity<>(response, HttpStatus.OK);

        } catch (Exception e) {
            log.error("Error fetching discounts for product ID {}: {}", productId, e.getMessage(), e);
            return new ResponseEntity<>(
                    Map.of("error", "Failed to fetch discounts for the specified product"),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Log discount information to terminal for debugging and verification
     */
    private void logDiscountsToTerminal(int productId, List<Map<String, Object>> discounts) {
        log.info("Found {} discount(s) for product ID {}", discounts.size(), productId);
        discounts.forEach(discount -> {
            log.info("---------------------------------------");
            log.info("Product Variant ID: {}", discount.get("product_variant_id"));
            log.info("Discount ID: {}", discount.get("discount_id"));
            log.info("Discount Name: {}", discount.get("discount_name"));
            log.info("Discount Code: {}", discount.get("discount_code"));
            log.info("Discount Percentage: {}%", discount.get("discount_percentage"));
            log.info("Start Date: {}", discount.get("start_date"));
            log.info("End Date: {}", discount.get("end_date"));
            log.info("Min Total Money: {}", discount.get("totalminmoney"));
        });
        log.info("---------------------------------------");
    }

    /**
     * Sample endpoint that demonstrates fetching discounts for product ID 2
     * Used for quick testing and verification
     */
    @GetMapping("/product/sample")
    public ResponseEntity<?> getSampleDiscounts() {
        log.info("Fetching sample discounts for product ID 2");
        return getDiscountsByProductId(2);
    }
}
