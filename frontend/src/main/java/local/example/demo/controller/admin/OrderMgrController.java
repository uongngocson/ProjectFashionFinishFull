package local.example.demo.controller.admin;


import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.Order;
import local.example.demo.model.entity.OrderDetail;
import local.example.demo.model.entity.Payment;

import local.example.demo.service.CustomerService;
import local.example.demo.service.OrderService;
import local.example.demo.service.PaymentService;
import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@Controller
@RequestMapping("/admin/order-mgr/")
public class OrderMgrController {

    private final OrderService orderService;
    private final CustomerService customerService;
    private final PaymentService paymentService;

    @GetMapping("list")
    public String getAllOrders(Model model) {
        List<Order> orders = orderService.getAllOrders();
        model.addAttribute("orders", orders);
        return "admin/order-mgr/all-orders";
    }

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

    @GetMapping("detail/{orderId}")
    public String getOrderById(@PathVariable("orderId") String orderId, Model model) {
        Order order = orderService.getOrderById(orderId);
        List<OrderDetail> orderDetails = orderService.getOrderDetailByOrderId(orderId);
        model.addAttribute("order", order);
        model.addAttribute("orderDetails", orderDetails);
        return "admin/order-mgr/detail-order";
    }

    @GetMapping("create")
    public String showCreate(Model model) {
        // Create a new order without setting an ID
        // The ID will be automatically generated in the service layer
        model.addAttribute("order", new Order());
        model.addAttribute("isNewOrder", true);
        return "admin/order-mgr/form-order";
    }

    @GetMapping("update/{orderId}")
    public String updateOrder(@PathVariable("orderId") String orderId, Model model) {
        Order order = orderService.getOrderById(orderId);
        model.addAttribute("order", order);
        model.addAttribute("isNewOrder", false);
        return "admin/order-mgr/form-order";
    }

    @PostMapping("save")
    public String saveOrder(@ModelAttribute("order") Order order) {
        // The service will handle generating an ID if this is a new order
        orderService.saveOrder(order);
        return "redirect:/admin/order-mgr/list";
    }

    @GetMapping("delete/{orderId}")
    public String deleteOrder(@PathVariable("orderId") String orderId) {
        orderService.deleteOrder(orderId);
        return "redirect:/admin/order-mgr/list";
    }
}
