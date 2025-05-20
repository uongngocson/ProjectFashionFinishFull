package local.example.demo.controller.shipper;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import local.example.demo.model.entity.Employee;
import local.example.demo.model.entity.Order;
import local.example.demo.model.entity.OrderDetail;
import local.example.demo.model.entity.Shipment;
import local.example.demo.service.EmployeeService;
import local.example.demo.service.ShipperService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/shipper/")
public class ShipperController {

    private final ShipperService shipperService;
    private final EmployeeService employeeService;

    // Hiển thị trang danh sách đơn hàng và vận đơn
    @GetMapping("order/list")
    public String getOrderList(Model model) {
        // Lấy danh sách đơn hàng có trạng thái CONFIRMED
        List<Order> confirmedOrders = shipperService.getConfirmedOrders();
        model.addAttribute("confirmedOrders", confirmedOrders);
        return "shipper/order/list";
    }

    // Hiển thị chi tiết đơn hàng
    @GetMapping("order/detail")
    public String getOrderDetail(@RequestParam("orderId") String orderId, Model model,
            RedirectAttributes redirectAttributes) {
        Optional<Order> orderOpt = shipperService.getOrderById(orderId);
        if (!orderOpt.isPresent()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy đơn hàng!");
            return "redirect:/shipper/order/list";
        }

        Order order = orderOpt.get();
        List<OrderDetail> orderDetails = shipperService.getOrderDetails(orderId);

        model.addAttribute("order", order);
        model.addAttribute("orderDetails", orderDetails);

        return "shipper/order/detail"; // Trả về view detail.jsp
    }

    // Hiển thị trang danh sách vận đơn của shipper
    @GetMapping("shipment/list")
    public String getShipmentList(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession();
        Integer employeeId = (Integer) session.getAttribute("employeeId");

        if (employeeId == null) {
            return "redirect:/login";
        }
        Employee shipper = employeeService.getEmployeeById(employeeId);
        List<Shipment> shipments = shipperService.getShipmentsByShipper(shipper);
        model.addAttribute("shipments", shipments);

        return "shipper/shipment/list";
    }

    // Tạo vận đơn mới
    @GetMapping("shipment/create")
    public String createShipment(HttpServletRequest request,
            @RequestParam("orderId") String orderId,
            RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession();
        Integer employeeId = (Integer) session.getAttribute("employeeId");
        Employee shipper = employeeService.getEmployeeById(employeeId);

        try {
            // Tạo vận đơn mới
            Shipment shipment = shipperService.createShipment(orderId, shipper);
            if (shipment != null) { // Kiểm tra shipment có được tạo thành công không
                redirectAttributes.addFlashAttribute("successMessage", "Đã nhận đơn hàng thành công!");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy đơn hàng để tạo vận đơn.");
            }
        } catch (Exception e) {
            System.out.println("lỗi" + e.getMessage());
            // Log chi tiết ngoại lệ
            // e.printStackTrace(); // In stack trace ra console/log
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi tạo vận đơn: " + e.getMessage());

        }

        return "redirect:/shipper/order/list";
    }

    // Hiển thị form cập nhật vận đơn
    @GetMapping("shipment/edit")
    public String showUpdateForm(@RequestParam("shipmentId") Integer shipmentId,
            Model model, RedirectAttributes redirectAttributes) {

        try {
            Optional<Shipment> shipmentOpt = shipperService.getShipmentById(shipmentId);
            if (shipmentOpt.isPresent()) {
                Shipment shipment = shipmentOpt.get();
                model.addAttribute("shipment", shipment);
                return "shipper/shipment/update";
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy vận đơn!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi tải thông tin vận đơn: " + e.getMessage());
        }

        return "redirect:/shipper/shipment/list";
    }

    // Cập nhật trạng thái vận đơn
    @PostMapping("shipment/update")
    public String updateShipment(
            @RequestParam("shipmentId") Integer shipmentId,
            @RequestParam("status") String status,
            RedirectAttributes redirectAttributes) {

        try {
            Optional<Shipment> shipmentOpt = shipperService.getShipmentById(shipmentId);
            if (shipmentOpt.isPresent()) {
                Shipment shipment = shipmentOpt.get();
                Order order = shipment.getOrder();

                // Cập nhật trạng thái shipment
                shipment.setStatus(status);

                // Cập nhật trạng thái order tương ứng
                switch (status) {
                    case "COMPLETED":
                        order.setOrderStatus("COMPLETED");
                        break;
                    case "RETURNED":
                        order.setOrderStatus("RETURNED");
                        break;
                    case "SHIPPING":
                        order.setOrderStatus("SHIPPING");
                        break;
                }

                // Lưu order sau khi cập nhật trạng thái
                shipperService.saveOrder(order);

                // Lưu shipment
                shipperService.updateShipment(shipment);

                redirectAttributes.addFlashAttribute("successMessage", "Cập nhật trạng thái vận đơn thành công!");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy vận đơn!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi cập nhật vận đơn: " + e.getMessage());
        }

        return "redirect:/shipper/shipment/list";
    }

    // Xóa vận đơn
    @GetMapping("shipment/delete")
    public String deleteShipment(@RequestParam("shipmentId") Integer shipmentId,
            RedirectAttributes redirectAttributes) {

        try {
            Optional<Shipment> shipmentOpt = shipperService.getShipmentById(shipmentId);
            if (shipmentOpt.isPresent()) {
                Shipment shipment = shipmentOpt.get();
                Order order = shipment.getOrder();

                // Đặt lại trạng thái order thành CONFIRMED
                order.setOrderStatus("CONFIRMED");

                // Lưu order trước khi xóa shipment
                shipperService.saveOrder(order);

                // Xóa shipment
                shipperService.deleteShipment(shipmentId);
                redirectAttributes.addFlashAttribute("successMessage",
                        "Xóa vận đơn thành công và đặt lại trạng thái đơn hàng!");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy vận đơn!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi xóa vận đơn: " + e.getMessage());
        }

        return "redirect:/shipper/shipment/list";
    }
}
