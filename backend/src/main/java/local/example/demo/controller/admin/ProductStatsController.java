package local.example.demo.controller.admin;

import local.example.demo.service.ProductStatsPdfService;
import local.example.demo.service.RevenueService;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/admin/product-stats")
public class ProductStatsController {

    private final RevenueService revenueService;
    private final ProductStatsPdfService pdfService;

    public ProductStatsController(RevenueService revenueService, ProductStatsPdfService pdfService) {
        this.revenueService = revenueService;
        this.pdfService = pdfService;
    }

    @GetMapping
    public String showProductStats(Model model) {
        // Default values for year and month (e.g., current year and month)
        int defaultYear = java.time.Year.now().getValue();
        int defaultMonth = java.time.MonthDay.now().getMonthValue();

        model.addAttribute("defaultYear", defaultYear);
        model.addAttribute("defaultMonth", defaultMonth);
        return "admin/product-stats";
    }

    @PostMapping("/generate-report")
    public Object generateProductStatsReport(
            @RequestParam("year") int year,
            @RequestParam("month") int month,
            @RequestParam(value = "action", defaultValue = "preview") String action,
            Model model) throws Exception {

        // Fetch product-wise revenue for the specified month
        List<Object[]> productStats = revenueService.getProductRevenueByMonth(year, month);

        // Debug the types of the query results
        if (!productStats.isEmpty()) {
            Object[] firstRow = productStats.get(0);
            System.out.println("product_id: "
                    + (firstRow[0] != null ? firstRow[0] + " (type: " + firstRow[0].getClass().getName() + ")"
                            : "null"));
            System.out.println("product_name: "
                    + (firstRow[1] != null ? firstRow[1] + " (type: " + firstRow[1].getClass().getName() + ")"
                            : "null"));
            System.out.println("total_revenue: "
                    + (firstRow[2] != null ? firstRow[2] + " (type: " + firstRow[2].getClass().getName() + ")"
                            : "null"));
            System.out.println("total_quantity: "
                    + (firstRow[3] != null ? firstRow[3] + " (type: " + firstRow[3].getClass().getName() + ")"
                            : "null"));
        } else {
            System.out.println("No product stats found for year " + year + " and month " + month);
        }

        if ("download".equals(action)) {
            // Generate PDF report
            byte[] pdfBytes = pdfService.generateProductStatsReport(productStats, year, month);

            // Set headers for PDF download
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_PDF);
            headers.setContentDispositionFormData("attachment", "product-stats-report-" + year + "-" + month + ".pdf");
            headers.setCacheControl("must-revalidate, post-check=0, pre-check=0");

            return ResponseEntity.ok()
                    .headers(headers)
                    .body(pdfBytes);
        } else {
            // Preview mode: Pass data to JSP for rendering
            model.addAttribute("productStats", productStats);
            model.addAttribute("year", year);
            model.addAttribute("month", month);
            return "admin/product-stats";
        }
    }
}