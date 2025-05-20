package local.example.demo.controller.client;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import local.example.demo.service.ProductLoadRandom;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/products")
public class ProductRestController {

    @Autowired
    private ProductLoadRandom productLoadRandom;

    @GetMapping("/search")
    public ResponseEntity<Map<String, Object>> searchProducts(
            @RequestParam(value = "keyword", defaultValue = "") String keyword,
            @RequestParam(value = "page", defaultValue = "1") int pageNumber,
            @RequestParam(value = "size", defaultValue = "20") int pageSize,
            @RequestParam(value = "minResults", defaultValue = "40") int minRequiredResults) {

        try {
            // Call the service to get the search results
            Map<String, Object> results = productLoadRandom.searchProductsByName(keyword, pageNumber, pageSize,
                    minRequiredResults);

            // Get total records from the results
            int totalRecords = productLoadRandom.getTotalRecords(results);

            // Get product list from the results
            List<Map<String, Object>> products = productLoadRandom.getProductResults(results);

            // Create response map
            Map<String, Object> response = new HashMap<>();
            response.put("products", products);
            response.put("totalRecords", totalRecords);
            response.put("currentPage", pageNumber);
            response.put("pageSize", pageSize);

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("error", e.getMessage());
            errorResponse.put("products", List.of());
            errorResponse.put("totalRecords", 0);
            return ResponseEntity.ok(errorResponse);
        }
    }
}