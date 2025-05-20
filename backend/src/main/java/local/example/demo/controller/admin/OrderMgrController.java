package local.example.demo.controller.admin;

import local.example.demo.exception.OrderInUseException;
import local.example.demo.model.dto.OrderDetailDTO;
import local.example.demo.model.entity.Address; // Import Address
import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.Order;
import local.example.demo.model.entity.OrderDetail;
import local.example.demo.model.entity.Payment;
import local.example.demo.service.AddressService; // Import AddressService
import local.example.demo.service.CustomerService;
import local.example.demo.service.OrderService;
import local.example.demo.service.PaymentService;
import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList; // Import ArrayList
import java.util.List; // Import List
import java.util.Map;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Controller
@RequestMapping("/admin/order-mgr/")
public class OrderMgrController {

    private final OrderService orderService;
    private final CustomerService customerService;
    private final PaymentService paymentService;
    private final AddressService addressService;

    // find all customer
    @ModelAttribute("customers")
    public List<Customer> getAllCustomers() {
        return customerService.findAllCustomers();
    }

    // find all payment
    @ModelAttribute("payments")
    public List<Payment> getAllPayments() {
        return paymentService.getAllPayments();
    }

    @GetMapping("list")
    public String getAllOrders(Model model) {
        List<Order> orders = orderService.getAllOrders();
        // Group orders by status
        Map<String, List<Order>> ordersByStatus = orders.stream()
                .collect(Collectors.groupingBy(Order::getOrderStatus));
        model.addAttribute("ordersByStatus", ordersByStatus);
        // Define possible statuses for rendering tabs (in case some statuses have no
        // orders)
        List<String> possibleStatuses = List.of("PENDING", "CONFIRMED", "SHIPPING", "COMPLETED", "CANCELLED",
                "RETURNED");
        model.addAttribute("possibleStatuses", possibleStatuses);
        return "admin/order-mgr/all-orders";
    }

    @GetMapping("detail/{orderId}")
    public String getOrderById(@PathVariable("orderId") String orderId, Model model) {
        List<OrderDetailDTO> orderDetails = orderService.getOrderDetails(orderId);
        if (orderDetails == null || orderDetails.isEmpty()) {
            model.addAttribute("errorMessage", "Order not found or no details available.");
            return "admin/order-mgr/detail-order";
        }
        model.addAttribute("orderDetails", orderDetails);
        model.addAttribute("order", orderDetails.get(0));
        return "admin/order-mgr/detail-order";
    }

    @GetMapping("create")
    public String showCreate(Model model) {
        // Create a new order without setting an ID
        // The ID will be automatically generated in the service layer
        model.addAttribute("order", new Order());
        model.addAttribute("isNewOrder", true);
        // Add an empty list for customer addresses for new orders
        model.addAttribute("customerAddresses", new ArrayList<Address>());
        return "admin/order-mgr/form-order";
    }

    @GetMapping("update/{orderId}")
    public String updateOrder(@PathVariable("orderId") String orderId, Model model) {
        System.out.println("Fetching order with ID: " + orderId);
        Order order = orderService.getOrderById(orderId);
        if (order == null) {
            System.out.println("Order not found for ID: " + orderId);
            model.addAttribute("order", new Order());
            model.addAttribute("errorMessage", "Order with ID " + orderId + " not found.");
        } else {
            System.out.println("Order found: ID=" + order.getOrderId() + ", Status=" + order.getOrderStatus()
                    + ", PaymentStatus=" + order.getPaymentStatus());
            model.addAttribute("order", order);
        }
        model.addAttribute("isNewOrder", false);
        List<String> possibleStatuses = List.of("PENDING", "CONFIRMED", "SHIPPING", "COMPLETED", "CANCELLED",
                "RETURNED");
        model.addAttribute("possibleStatuses", possibleStatuses);
        List<Map<String, Object>> paymentStatuses = List.of(
                Map.of("value", true, "label", "Paid"),
                Map.of("value", false, "label", "Unpaid"));
        model.addAttribute("paymentStatuses", paymentStatuses);
        return "admin/order-mgr/form-order";
    }

    @PostMapping("save")
    public String saveOrder(@ModelAttribute("order") Order order, RedirectAttributes redirectAttributes) {
        try {
            Order existingOrder = orderService.getOrderById(order.getOrderId());
            if (existingOrder == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Order not found.");
                return "redirect:/admin/order-mgr/list";
            }
            orderService.updateOrderStatusAndPayment(order.getOrderId(), order.getOrderStatus(),
                    order.getPaymentStatus());
            redirectAttributes.addFlashAttribute("successMessage", "Order updated successfully.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating order: " + e.getMessage());
        }
        return "redirect:/admin/order-mgr/list";
    }

    @GetMapping("delete/{orderId}")
    public String deleteOrder(@PathVariable("orderId") String orderId, RedirectAttributes redirectAttributes) {
        Order order = orderService.getOrderById(orderId);
        if (order != null && !order.getOrderStatus().equals("CANCELLED")) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Cannot delete. The order is in sales or in process..");
            return "redirect:/admin/order-mgr/list";
        }
        try {
            orderService.deleteOrder(orderId);
            redirectAttributes.addFlashAttribute("successMessage", "Order deleted successfully.");
        } catch (OrderInUseException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "An error occurred while deleting the order.");
        }
        return "redirect:/admin/order-mgr/list";
    }
}
