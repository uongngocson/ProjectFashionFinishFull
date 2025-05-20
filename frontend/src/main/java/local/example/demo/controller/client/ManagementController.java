package local.example.demo.controller.client;

import local.example.demo.model.dto.OrderDetailDTO;
import local.example.demo.model.entity.Address;
import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.Order;
import local.example.demo.service.CustomerService;
import local.example.demo.service.OrderService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import jakarta.validation.Valid;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

@Controller
@RequestMapping("/management")
public class ManagementController {

    private static final Logger logger = LoggerFactory.getLogger(ManagementController.class);

    @Autowired
    private CustomerService customerService;

    @Autowired
    private OrderService orderService;

    @GetMapping("/profile")
    public String getProfilePage(Model model) {
        logger.debug("Processing GET /management/profile");
        Customer customer = customerService.getCurrentLoggedInCustomer();
        if (customer == null) {
            logger.warn("No authenticated customer found, redirecting to login");
            return "redirect:/login";
        }
        logger.debug("Found customer ID: {}", customer.getCustomerId());

        List<Address> addresses = customerService.findAddressesByCustomer(customer);
        customer.setAddresses(addresses);
        model.addAttribute("customer", customer);

        logger.debug("Customer data: firstName={}, lastName={}, email={}, dateOfBirth={}",
                customer.getFirstName(), customer.getLastName(), customer.getEmail(), customer.getDateOfBirth());

        return "client/auth/profile";
    }

    @GetMapping("/profile/update")
    public String getUpdateProfilePage(Model model) {
        logger.debug("Processing GET /management/profile/update");
        Customer customer = customerService.getCurrentLoggedInCustomer();
        if (customer == null) {
            logger.warn("No authenticated customer found, redirecting to login");
            return "redirect:/login";
        }
        logger.debug("Found customer ID: {}", customer.getCustomerId());

        model.addAttribute("customer", customer);
        return "client/auth/update_profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(@Valid @ModelAttribute("customer") Customer updatedCustomer,
            BindingResult bindingResult,
            @RequestParam("image") MultipartFile image,
            RedirectAttributes redirectAttributes,
            Model model) {
        logger.debug("Processing POST /management/profile/update for customer ID: {}", updatedCustomer.getCustomerId());

        if (bindingResult.hasErrors()) {
            logger.warn("Validation failed for customer: {}", bindingResult.getAllErrors());
            model.addAttribute("error", "Vui lòng sửa các lỗi trong form trước khi gửi.");
            return "client/auth/update_profile";
        }

        try {
            Customer updated = customerService.updateCustomerProfile(updatedCustomer, image);
            logger.info("Profile updated successfully for customer ID: {}", updated.getCustomerId());
            redirectAttributes.addFlashAttribute("success", "Cập nhật hồ sơ thành công!");
        } catch (IOException e) {
            logger.error("Failed to update profile due to IO error: {}", e.getMessage());
            model.addAttribute("error", "Cập nhật hồ sơ thất bại: Lỗi khi xử lý ảnh.");
            return "client/auth/update_profile";
        } catch (Exception e) {
            logger.error("Failed to update profile: {}", e.getMessage());
            model.addAttribute("error", "Cập nhật hồ sơ thất bại: " + e.getMessage());
            return "client/auth/update_profile";
        }
        return "redirect:/management/profile";
    }

    @GetMapping("/profile/change-password")
    public String getChangePasswordPage() {
        logger.debug("Processing GET /management/profile/change-password");
        return "client/auth/change_password";
    }

    @PostMapping("/profile/change-password")
    public String changePassword(@RequestParam("oldPassword") String oldPassword,
            @RequestParam("newPassword") String newPassword,
            @RequestParam("confirmPassword") String confirmPassword,
            RedirectAttributes redirectAttributes) {
        logger.debug("Processing POST /management/profile/change-password");
        try {
            customerService.changePassword(oldPassword, newPassword, confirmPassword);
            logger.info("Password changed successfully");
            redirectAttributes.addFlashAttribute("passwordSuccess", "Thay đổi mật khẩu thành công!");
        } catch (IllegalArgumentException e) {
            logger.error("Failed to change password: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("passwordError", "Thay đổi mật khẩu thất bại: " + e.getMessage());
        } catch (Exception e) {
            logger.error("Unexpected error during password change: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("passwordError", "Thay đổi mật khẩu thất bại: Lỗi không xác định.");
        }
        return "redirect:/management/profile";
    }

    @GetMapping("/historyorder")
    public String getHistoryOrderPage(Model model) {
        Customer customer = customerService.fetchCurrentLoggedInCustomer();
        if (customer == null) {
            System.out
                    .println("Không tìm thấy khách hàng đăng nhập cho /historyorder, chuyển hướng đến trang đăng nhập");
            return "redirect:/login";
        }
        System.out.println("Lấy danh sách đơn hàng cho khách hàng ID: " + customer.getCustomerId());
        List<Order> orders = orderService.findOrdersByCustomer(customer);
        model.addAttribute("orders", orders);
        return "client/auth/orderhis";
    }

    @PostMapping("/order/cancel/{orderId}")
    public String cancelOrder(@PathVariable String orderId, RedirectAttributes redirectAttributes) {
        try {
            System.out.println("Nhận yêu cầu hủy đơn hàng: /management/order/cancel/" + orderId);
            Customer customer = customerService.fetchCurrentLoggedInCustomer();
            if (customer == null) {
                System.out.println(
                        "Không tìm thấy khách hàng đăng nhập cho /order/cancel, chuyển hướng đến trang đăng nhập");
                return "redirect:/login";
            }
            System.out.println("Hủy đơn hàng " + orderId + " cho khách hàng ID: " + customer.getCustomerId());
            orderService.cancelOrder(orderId, customer);
            redirectAttributes.addFlashAttribute("error", "Đơn hàng đã được hủy thành công!");
            return "redirect:/management/historyorder";
        } catch (IllegalArgumentException e) {
            System.out.println("Lỗi khi hủy đơn hàng: " + e.getMessage());
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/management/historyorder";
        }
    }

    @GetMapping("/order/details/{orderId}")
    public String getOrderDetails(@PathVariable String orderId, Model model) {
        System.out.println("Xử lý yêu cầu cho /management/order/details/" + orderId);
        Customer customer = customerService.fetchCurrentLoggedInCustomer();
        if (customer == null) {
            System.out.println("Không tìm thấy khách hàng đăng nhập, chuyển hướng đến trang đăng nhập");
            return "redirect:/login";
        }
        System.out.println("ID khách hàng đăng nhập: " + customer.getCustomerId());

        List<OrderDetailDTO> orderDetails = orderService.getOrderDetails(orderId);
        if (orderDetails.isEmpty()) {
            System.out.println("Không tìm thấy chi tiết đơn hàng cho orderId: " + orderId);
            model.addAttribute("errorMessage", "Không tìm thấy đơn hàng với mã: " + orderId);
            return "client/auth/error";
        }

        boolean isAuthorized = orderDetails.stream()
                .anyMatch(detail -> detail.getCustomerId().equals(customer.getCustomerId()));
        if (!isAuthorized) {
            System.out.println("Khách hàng " + customer.getCustomerId() + " không có quyền xem đơn hàng " + orderId);
            model.addAttribute("errorMessage", "Bạn không có quyền xem chi tiết đơn hàng này.");
            return "client/auth/error";
        }

        System.out.println("Lấy chi tiết đơn hàng thành công cho orderId: " + orderId);
        model.addAttribute("orderDetails", orderDetails);
        return "client/auth/order-details";
    }
}