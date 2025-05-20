package local.example.demo.controller.api; // Đặt trong package api hoặc tương tự

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import local.example.demo.service.CartDetailService;
import local.example.demo.service.CustomerService;
import local.example.demo.model.entity.Cart;
import local.example.demo.model.entity.Customer;
import lombok.RequiredArgsConstructor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@RestController // Sử dụng @RestController cho API trả về JSON
@RequestMapping("/api/cart") // Đường dẫn cơ sở cho API giỏ hàng
@RequiredArgsConstructor
public class CartApiController {

    private final CartDetailService cartDetailService;
    private final CustomerService customerService;

    @DeleteMapping("/item/{cartDetailId}")
    public ResponseEntity<Map<String, String>> removeCartItem(@PathVariable Integer cartDetailId) {
        try {
            // Use the service to remove the cart item
            cartDetailService.removeCartItem(cartDetailId);

            // Return success response
            Map<String, String> response = new HashMap<>();
            response.put("message", "Item removed successfully");
            return ResponseEntity.ok(response);
        } catch (IllegalArgumentException e) {
            // Handle case where item isn't found
            Map<String, String> response = new HashMap<>();
            response.put("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
        } catch (Exception e) {
            // Handle other exceptions
            Map<String, String> response = new HashMap<>();
            response.put("error", "Failed to remove item. Please try again.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @PostMapping("/remove/{cartDetailId}")
    public ResponseEntity<Map<String, String>> removeCartItemPost(@PathVariable Integer cartDetailId) {
        try {
            // Use the service to remove the cart item
            cartDetailService.removeCartItem(cartDetailId);

            // Return success response
            Map<String, String> response = new HashMap<>();
            response.put("message", "Item removed successfully");
            return ResponseEntity.ok(response);
        } catch (IllegalArgumentException e) {
            // Handle case where item isn't found
            Map<String, String> response = new HashMap<>();
            response.put("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
        } catch (Exception e) {
            // Handle other exceptions
            Map<String, String> response = new HashMap<>();
            response.put("error", "Failed to remove item. Please try again.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @GetMapping("/count")
    public ResponseEntity<Map<String, Object>> getCartCount(HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();
        try {
            HttpSession session = request.getSession(false);
            if (session == null) {
                response.put("count", 0);
                return ResponseEntity.ok(response);
            }

            Integer customerId = (Integer) session.getAttribute("customerId");
            if (customerId == null) {
                response.put("count", 0);
                return ResponseEntity.ok(response);
            }

            Customer customer = new Customer();
            customer.setCustomerId(customerId);
            Cart cart = customerService.getCartByCustomer(customer);
            int cartItemCount = (cart != null && cart.getCartDetails() != null) ? cart.getCartDetails().size() : 0;

            // Update session attribute
            session.setAttribute("cartItemCount", cartItemCount);

            response.put("count", cartItemCount);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("count", 0);
            response.put("error", "Failed to get cart count: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
}