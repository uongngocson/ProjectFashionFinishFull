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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import local.example.demo.service.ProductDiscount;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/api/products/discounts")
@Slf4j
public class ProductDiscountController {

    @Autowired
    private ProductDiscount productDiscountService;

    /**
     * Get all variant discounts with account information for a specific product
     * 
     * @param productId  the ID of the product
     * @param customerId optional ID of the customer to filter by
     * @return ResponseEntity with a list of variants with discounts and customer
     *         info or error message
     */
    @GetMapping("/variants-with-accounts/{productId}")
    public ResponseEntity<?> getVariantsWithAccountsByProductId(
            @PathVariable int productId,
            @RequestParam(required = false) Integer customerId) {

        log.info("Fetching variants with discounts and customer info for product ID: {}, customer ID: {}",
                productId, customerId);

        try {
            List<Map<String, Object>> variantsWithAccounts = productDiscountService
                    .getVariantsWithAccountsByProductId(productId, customerId);

            if (variantsWithAccounts.isEmpty()) {
                log.info("No variants with discounts found for product ID: {}, customer ID: {}",
                        productId, customerId);
                return new ResponseEntity<>(
                        Map.of("message", "No variants with discounts found for the specified product"),
                        HttpStatus.NOT_FOUND);
            }

            // Log the results for terminal output
            logVariantsWithAccountsToTerminal(productId, customerId, variantsWithAccounts);

            Map<String, Object> response = new HashMap<>();
            response.put("productId", productId);
            if (customerId != null) {
                response.put("customerId", customerId);
            }
            response.put("variantCount", variantsWithAccounts.size());
            response.put("variantsWithAccounts", variantsWithAccounts);

            return new ResponseEntity<>(response, HttpStatus.OK);

        } catch (Exception e) {
            log.error("Error fetching variants with accounts for product ID {}, customer ID {}: {}",
                    productId, customerId, e.getMessage(), e);
            return new ResponseEntity<>(
                    Map.of("error", "Failed to fetch variants with accounts for the specified product"),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Log variant discount and customer information to terminal for debugging and
     * verification
     */
    private void logVariantsWithAccountsToTerminal(int productId, Integer customerId,
            List<Map<String, Object>> variantsWithAccounts) {
        log.info("Found {} variant(s) with discount and customer info for product ID {}, customer ID {}",
                variantsWithAccounts.size(), productId, customerId);
        variantsWithAccounts.forEach(variant -> {
            log.info("---------------------------------------");
            log.info("Product Variant ID: {}", variant.get("product_variant_id"));
            log.info("Discount ID: {}", variant.get("discount_id"));
            log.info("Discount Name: {}", variant.get("discount_name"));
            log.info("Discount Code: {}", variant.get("discount_code"));
            log.info("Discount Percentage: {}%", variant.get("discount_percentage"));
            log.info("Start Date: {}", variant.get("start_date"));
            log.info("End Date: {}", variant.get("end_date"));
            log.info("Min Total Money: {}", variant.get("totalminmoney"));
            log.info("Customer ID: {}", variant.get("customer_id"));
            log.info("Used At: {}", variant.get("used_at"));
            log.info("Status: {}", variant.get("status"));
        });
        log.info("---------------------------------------");
    }

    /**
     * Sample endpoint that demonstrates fetching variants with accounts for product
     * ID 1
     * Used for quick testing and verification
     */
    @GetMapping("/variants-with-accounts/sample")
    public ResponseEntity<?> getSampleVariantsWithAccounts() {
        log.info("Fetching sample variants with accounts for product ID 1");
        return getVariantsWithAccountsByProductId(1, null);
    }

    /**
     * Sample endpoint that demonstrates fetching variants with accounts for product
     * ID 1 and customer ID 7
     * Used for quick testing and verification with customer filtering
     */
    @GetMapping("/variants-with-accounts/sample-with-account")
    public ResponseEntity<?> getSampleVariantsWithAccountsForAccount() {
        log.info("Fetching sample variants with accounts for product ID 1 and customer ID 7");
        return getVariantsWithAccountsByProductId(1, 7);
    }
}