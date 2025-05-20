package local.example.demo.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import local.example.demo.model.entity.Customer;
import local.example.demo.service.CartDetailService;
import local.example.demo.service.CartService;
import local.example.demo.service.CustomerService;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class OrderController {

    private final CartDetailService cartDetailService;
    private final CustomerService customerService;
    private final CartService cartService;

    @GetMapping("/user/checkout")
    public String showOrderPage(Model model) {
        try {
            // Get current authenticated user
            Customer customer = customerService.getCurrentLoggedInCustomer();
            if (customer == null) {
                return "redirect:/login";
            }

            // Add customer details to model
            model.addAttribute("customer", customer);

            // Get cart details
            var cart = cartService.getCartByCustomer(customer);
            if (cart != null) {
                var cartDetails = cartDetailService.getCartDetailsByCart(cart);
                model.addAttribute("cartDetails", cartDetails);

                // Calculate total price
                double totalPrice = 0;
                for (var item : cartDetails) {
                    totalPrice += item.getQuantity() * item.getProductVariant().getProduct().getPrice().doubleValue();
                }
                model.addAttribute("totalPrice", totalPrice);
            }

            return "client/user/order";
        } catch (Exception e) {
            // Log the error
            e.printStackTrace();
            return "redirect:/user/cart?error=Failed+to+load+order+page";
        }
    }
}