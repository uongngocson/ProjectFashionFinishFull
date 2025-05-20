package local.example.demo.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import local.example.demo.service.ProductVariantService;
import local.example.demo.service.CustomerService;
import lombok.RequiredArgsConstructor;
import local.example.demo.model.entity.Cart;
import local.example.demo.model.entity.Customer;

@RequiredArgsConstructor
@Controller
@RequestMapping("/product-variant/")
public class ProductVariantController {
    private final ProductVariantService productVariantService;
    private final CustomerService customerService;

    @PostMapping("/add-to-cart")
    public String addToCart(
            @RequestParam("variantId") Integer productVariantId,
            @RequestParam("quantity") Integer quantity,
            HttpServletRequest request) {

        HttpSession session = request.getSession(false);
        if (session != null) {
            String email = (String) session.getAttribute("email");
            Integer customerId = (Integer) session.getAttribute("customerId");

            if (email != null && customerId != null) {
                productVariantService.handleAddToCart(
                        email,
                        productVariantId,
                        quantity);

                Customer customer = new Customer();
                customer.setCustomerId(customerId);
                Cart cart = customerService.getCartByCustomer(customer);
                int cartItemCount = (cart != null && cart.getCartDetails() != null) ? cart.getCartDetails().size() : 0;
                session.setAttribute("cartItemCount", cartItemCount);
            }
        }

        return "redirect:/user/cart";
    }

}
