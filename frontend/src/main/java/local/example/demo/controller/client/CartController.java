package local.example.demo.controller.client;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import local.example.demo.model.dto.CartQuantityUpdateRequest;
import local.example.demo.model.dto.CartQuantityUpdateResponse;
import local.example.demo.model.entity.CartDetail;
import local.example.demo.service.CartDetailService;
import lombok.RequiredArgsConstructor;
import java.math.BigDecimal;
import local.example.demo.service.CustomerService;
import local.example.demo.model.entity.Cart;
import local.example.demo.model.entity.Customer;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequiredArgsConstructor
public class CartController {

    private final CartDetailService cartDetailService;
    private final CustomerService customerService;

    @GetMapping("/cart/remove/{cartDetailId}")
    public String removeCartItem(@PathVariable Integer cartDetailId, RedirectAttributes redirectAttributes,
            HttpServletRequest request) {
        try {
            HttpSession session = request.getSession(false);
            Integer customerId = (session != null) ? (Integer) session.getAttribute("customerId") : null;

            cartDetailService.removeCartItem(cartDetailId);
            redirectAttributes.addFlashAttribute("successMessage", "Item removed successfully");

            if (customerId != null && session != null) {
                Customer customer = new Customer();
                customer.setCustomerId(customerId);
                Cart cart = customerService.getCartByCustomer(customer);
                int cartItemCount = (cart != null && cart.getCartDetails() != null) ? cart.getCartDetails().size() : 0;
                session.setAttribute("cartItemCount", cartItemCount);
            }

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to remove item: " + e.getMessage());
        }
        return "redirect:/user/cart";
    }

    @PostMapping("/cart/update-quantity")
    @ResponseBody
    public ResponseEntity<CartQuantityUpdateResponse> updateCartItemQuantity(
            @RequestBody CartQuantityUpdateRequest request) {
        try {
            CartDetail updatedCartDetail = cartDetailService.updateCartItemQuantity(
                    request.getCartDetailId(),
                    request.getQuantity());

            // Calculate the total price for this item
            BigDecimal unitPrice = updatedCartDetail.getProductVariant().getProduct().getPrice();
            BigDecimal quantity = new BigDecimal(updatedCartDetail.getQuantity());
            BigDecimal totalPrice = unitPrice.multiply(quantity);

            return ResponseEntity.ok(CartQuantityUpdateResponse.builder()
                    .cartDetailId(updatedCartDetail.getCartDetailId())
                    .quantity(updatedCartDetail.getQuantity())
                    .totalPrice(totalPrice.doubleValue())
                    .success(true)
                    .message("Quantity updated successfully")
                    .build());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(CartQuantityUpdateResponse.builder()
                    .success(false)
                    .message("Failed to update quantity: " + e.getMessage())
                    .build());
        }
    }
}