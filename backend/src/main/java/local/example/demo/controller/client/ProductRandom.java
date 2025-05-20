package local.example.demo.controller.client;

import local.example.demo.service.ProductLoadRandom;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/products")
public class ProductRandom {

    @Autowired
    private ProductLoadRandom productLoadRandom;

    @GetMapping("/search")
    public String searchProducts(
            @RequestParam(value = "keyword", defaultValue = "") String keyword,
            @RequestParam(value = "page", defaultValue = "1") int pageNumber,
            @RequestParam(value = "size", defaultValue = "20") int pageSize,
            @RequestParam(value = "minResults", defaultValue = "40") int minRequiredResults,
            Model model) {

        // Call the service to get the search results
        Map<String, Object> results = productLoadRandom.searchProductsByName(keyword, pageNumber, pageSize,
                minRequiredResults);

        // Get total records from the results
        int totalRecords = productLoadRandom.getTotalRecords(results);

        // Get product list from the results
        List<Map<String, Object>> products = productLoadRandom.getProductResults(results);

        // Add attributes to the model
        model.addAttribute("searchProducts", products);
        model.addAttribute("searchTotalRecords", totalRecords);
        model.addAttribute("searchKeyword", keyword);
        model.addAttribute("searchCurrentPage", pageNumber);
        model.addAttribute("searchPageSize", pageSize);
        model.addAttribute("isSearchResult", true);

        // Return the home view instead of a separate search view
        return "client/home";
    }
}
