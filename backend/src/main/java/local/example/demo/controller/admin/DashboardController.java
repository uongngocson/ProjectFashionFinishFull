package local.example.demo.controller.admin;

import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import local.example.demo.service.InventoryService;
import local.example.demo.service.RevenueService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("admin/dashboard/")
public class DashboardController {

    private final RevenueService revenueService;
    private final InventoryService inventoryService;
    private final ObjectMapper objectMapper;

    @GetMapping("index")
    public String getDashboardPage(
            Model model,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
            @RequestParam(required = false) Integer year,
            @RequestParam(required = false) Integer month) {

        // --- Thiết lập giá trị mặc định cho bộ lọc ---
        LocalDate today = LocalDate.now();
        if (startDate == null) {
            startDate = today.minusDays(30);
        }
        if (endDate == null) {
            endDate = today;
        }
        if (year == null) {
            year = today.getYear();
        }
        if (month == null) {
            month = today.getMonthValue();
        }

        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("selectedYear", year);
        model.addAttribute("selectedMonth", month);
        model.addAttribute("currentYear", today.getYear());

        // --- Dữ liệu tổng quan ---
        Object totalRevenueObj = revenueService.getTotalRevenue();
        BigDecimal totalRevenue = (totalRevenueObj instanceof Number) ? BigDecimal.valueOf(((Number) totalRevenueObj).doubleValue()) : BigDecimal.ZERO;
        model.addAttribute("totalRevenue", totalRevenue);

        Object totalImportValueObj = inventoryService.getTotalImportValue();
        BigDecimal totalImportValue = (totalImportValueObj instanceof Number) ? BigDecimal.valueOf(((Number) totalImportValueObj).doubleValue()) : BigDecimal.ZERO;
        model.addAttribute("totalImportValue", totalImportValue);

        BigDecimal profit = totalRevenue.subtract(totalImportValue);
        model.addAttribute("profit", profit);

        // --- Lấy dữ liệu biểu đồ sử dụng các phương thức static helper ---
        model.addAttribute("monthlyRevenueJson", convertDataToJsonMapIntKey(revenueService.getMonthlyRevenue(today.getYear()), objectMapper));
        List<Object[]> dailyRevenueData = revenueService.getRevenueBetween(Date.valueOf(startDate), Date.valueOf(endDate));
        model.addAttribute("dailyRevenueJson", convertDataToJsonMapStringKey(dailyRevenueData, objectMapper)); // Dùng cho biểu đồ theo ngày cũ nếu cần
        model.addAttribute("rangeRevenueJson", convertDataToJsonMapStringKey(dailyRevenueData, objectMapper)); // Dùng cho biểu đồ theo khoảng ngày
        model.addAttribute("weeklyRevenueJson", convertDataToJsonMapIntKey(revenueService.getWeeklyRevenue(year, month), objectMapper));

        model.addAttribute("monthlyImportJson", convertDataToJsonMapIntKey(inventoryService.getImportValueByMonth(today.getYear()), objectMapper));
        List<Object[]> dailyImportData = inventoryService.getImportValueByDateRange(startDate, endDate);
        model.addAttribute("dailyImportJson", convertDataToJsonMapStringKey(dailyImportData, objectMapper)); // Dùng cho biểu đồ theo ngày cũ nếu cần
        model.addAttribute("rangeImportJson", convertDataToJsonMapStringKey(dailyImportData, objectMapper)); // Dùng cho biểu đồ theo khoảng ngày
        model.addAttribute("weeklyImportJson", convertDataToJsonMapIntKey(inventoryService.getImportValueByWeekInMonth(year, month), objectMapper));

        return "admin/dashboard/index";
    }

    // --- Phương thức trợ giúp static để chuyển đổi dữ liệu sang JSON Map<String, Double> ---
    private static String convertDataToJsonMapStringKey(List<Object[]> dataList, ObjectMapper mapper) {
        if (dataList == null || dataList.isEmpty()) {
            return "{}";
        }
        try {
            Map<String, Double> map = dataList.stream()
                    .filter(data -> data != null && data.length >= 2 && data[0] != null && data[1] instanceof Number) // Thêm kiểm tra null và kiểu dữ liệu
                    .collect(Collectors.toMap(
                            data -> data[0].toString(), // Key (Ngày, Tuần, Tháng dạng String)
                            data -> ((Number) data[1]).doubleValue(), // Value
                            (value1, value2) -> value1 // Xử lý trùng key (giữ giá trị đầu tiên)
                    ));
            return mapper.writeValueAsString(map);
        } catch (JsonProcessingException e) {
            return "{}"; // Trả về JSON rỗng nếu lỗi
        } catch (Exception e) {
             return "{}";
        }
    }

    // --- Phương thức trợ giúp static để chuyển đổi dữ liệu sang JSON Map<Integer, Double> ---
    private static String convertDataToJsonMapIntKey(List<Object[]> dataList, ObjectMapper mapper) {
        if (dataList == null || dataList.isEmpty()) {
            return "{}";
        }
        try {
            Map<Integer, Double> map = dataList.stream()
                    .filter(data -> data != null && data.length >= 2 && data[0] instanceof Integer && data[1] instanceof Number) // Thêm kiểm tra null và kiểu dữ liệu
                    .collect(Collectors.toMap(
                            data -> (Integer) data[0], // Key (Tháng/Tuần số dạng Integer)
                            data -> ((Number) data[1]).doubleValue(), // Value
                            (value1, value2) -> value1 // Xử lý trùng key (giữ giá trị đầu tiên)
                    ));
            return mapper.writeValueAsString(map);
        } catch (JsonProcessingException e) {
            return "{}"; // Trả về JSON rỗng nếu lỗi
        } catch (Exception e) {
             return "{}";
        }
    }
}
