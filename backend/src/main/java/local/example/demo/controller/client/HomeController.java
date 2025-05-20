package local.example.demo.controller.client;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import local.example.demo.service.ProductLoadRandom;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/")
public class HomeController {

    @Autowired
    private ProductLoadRandom productLoadRandom;

    @GetMapping("")
    public String getHomePage(Model model) {
        // Luôn load dữ liệu từ procedure với keyword mặc định rỗng
        String defaultKeyword = "";
        int defaultPageNumber = 1;
        int defaultPageSize = 20;
        int defaultMinRequiredResults = 40;

        // Gọi service để lấy dữ liệu sản phẩm
        Map<String, Object> results = productLoadRandom.searchProductsByName(defaultKeyword, defaultPageNumber,
                defaultPageSize, defaultMinRequiredResults);

        // Lấy tổng số bản ghi
        int totalRecords = productLoadRandom.getTotalRecords(results);

        // Lấy danh sách sản phẩm
        List<Map<String, Object>> products = productLoadRandom.getProductResults(results);

        // Thêm dữ liệu vào model với prefix "featured" để tránh xung đột với dữ liệu
        // tìm kiếm
        model.addAttribute("featuredProducts", products);
        model.addAttribute("featuredTotalRecords", totalRecords);

        // Đánh dấu là không phải kết quả tìm kiếm
        model.addAttribute("isSearchResult", false);

        return "client/auth/login";
    }

    @GetMapping("about")
    public String getAboutPage() {
        return "client/auth/login";
    }

    @GetMapping("faq")
    public String getFAQFAQPage() {
        return "client/auth/login";
    }

    @GetMapping("test")
    public String getAboutPageTest() {
        return "client/auth/login";
    }

    @GetMapping("blog")
    public String getBlogPage() {
        return "client/auth/login";
    }

    @GetMapping("blogpage")
    public String getBlogPagePage() {
        return "client/auth/login";
    }

    @GetMapping("testapithanhtoan")
    public String getTestApiThanhToan() {
        return "client/auth/login";
    }

}
