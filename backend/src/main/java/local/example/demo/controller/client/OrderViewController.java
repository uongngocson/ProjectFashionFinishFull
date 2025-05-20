package local.example.demo.controller.client;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import local.example.demo.model.dto.OrderItemDTO;
import local.example.demo.model.entity.Address;
import local.example.demo.model.entity.CartDetail;
import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.ProductVariant;
import local.example.demo.service.AddressService;
import local.example.demo.service.CartDetailService;
import local.example.demo.service.CustomerService;
import local.example.demo.service.ProductVariantService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/user/order-view")
@RequiredArgsConstructor
@Slf4j
public class OrderViewController {

    private final CustomerService customerService;
    private final ProductVariantService productVariantService;
    private final AddressService addressService;
    private final CartDetailService cartDetailService;

    // Helper method to get current customer from session
    private Customer getCurrentCustomer(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("customerId") != null) {
            Customer customer = new Customer();
            customer.setCustomerId((Integer) session.getAttribute("customerId"));
            return customer;
        }
        return null;
    }

    @GetMapping
    public String showOrderPageWithAddresses(
            @RequestParam(value = "variantId", required = false) Integer variantId,
            @RequestParam(value = "quantity", required = false) Integer quantity,
            @RequestParam(value = "variantIds", required = false) List<Integer> variantIds,
            @RequestParam(value = "quantities", required = false) List<Integer> quantities,
            Model model, HttpServletRequest request) {
        List<OrderItemDTO> items = new ArrayList<>();

        // Case: Order a single product from detail page
        if (variantId != null && quantity != null) {
            ProductVariant variant = productVariantService.findById(variantId);
            if (variant != null) {
                items.add(new OrderItemDTO(variant, quantity));
            }
        }

        // Case: Multiple products from cart
        if (variantIds != null && quantities != null && variantIds.size() == quantities.size()) {
            for (int i = 0; i < variantIds.size(); i++) {
                Integer vId = variantIds.get(i);
                Integer qty = quantities.get(i);

                if (vId != null && qty != null && qty > 0) {
                    ProductVariant variant = productVariantService.findById(vId);
                    if (variant != null) {
                        items.add(new OrderItemDTO(variant, qty));
                    }
                }
            }
        }

        // Get customer information
        Customer currentCustomer = getCurrentCustomer(request);
        if (currentCustomer != null) {
            // Get customer details from DB
            Customer customerDetails = customerService.findCustomerById(currentCustomer.getCustomerId());
            model.addAttribute("customer", customerDetails);

            // Get customer addresses and pass them directly to the view
            List<Address> addresses = addressService.getAddressesForCustomer(customerDetails.getCustomerId());
            model.addAttribute("customerAddresses", addresses);

            // Format addresses for display in the view
            String formattedAddresses = formatAddressesForView(addresses);
            model.addAttribute("formattedAddresses", formattedAddresses);

            // Truy vấn địa chỉ từ bảng mới để in ra terminal kiểm tra
            List<Address> addressesv2 = addressService.getAddressesv2ForCustomer(customerDetails.getCustomerId());
            log.info("Addressesv2 information for testing:");
            for (Address address : addressesv2) {
                log.info("Address ID: {}, Street: {}, Full Address: {}",
                        address.getAddressId(),
                        address.getStreet(),
                        address.getFullAddress());

                log.info("Ward: ID={}, Name={}",
                        address.getWard().getWardId(),
                        address.getWard() != null ? address.getWard().getWardName() : "N/A");

                log.info("District: ID={}, Name={}",
                        address.getDistrict().getDistrictId(),
                        address.getDistrict() != null ? address.getDistrict().getDistrictName() : "N/A");

                log.info("Province: ID={}, Name={}",
                        address.getProvince().getProvinceId(),
                        address.getProvince() != null ? address.getProvince().getProvinceName() : "N/A");
            }

            // Add addressesv2 to model
            model.addAttribute("customerAddressesv2", addressesv2);

            log.info("Retrieved {} addresses for customer ID: {}", addresses.size(), customerDetails.getCustomerId());
        } else {
            return "redirect:/login"; // Redirect if not logged in
        }

        model.addAttribute("items", items);

        // Calculate total for the order page
        BigDecimal orderTotal = BigDecimal.ZERO;
        for (OrderItemDTO item : items) {
            if (item.getVariant() != null && item.getVariant().getProduct() != null
                    && item.getVariant().getProduct().getPrice() != null) {
                orderTotal = orderTotal.add(
                        item.getVariant().getProduct().getPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
            }
        }
        model.addAttribute("orderTotal", orderTotal);

        return "client/user/order";
    }

    @PostMapping
    public String processCheckout(@RequestParam("selectedItems") List<Integer> selectedCartDetailIds,
            Model model, HttpServletRequest request) {
        Customer currentCustomer = getCurrentCustomer(request);
        if (currentCustomer == null) {
            return "redirect:/login";
        }

        // This method follows the same logic as in UserController.processCheckout()
        List<Integer> variantIds = new ArrayList<>();
        List<Integer> quantities = new ArrayList<>();

        // Get selected cart details and convert to the format needed for the order page
        for (Integer cartDetailId : selectedCartDetailIds) {
            try {
                CartDetail cartDetail = cartDetailService.findById(cartDetailId);
                if (cartDetail != null) {
                    variantIds.add(cartDetail.getProductVariant().getProductVariantId());
                    quantities.add(cartDetail.getQuantity());
                }
            } catch (Exception e) {
                log.error("Error finding cart detail with ID: {}", cartDetailId, e);
            }
        }

        // Debug logging
        log.info("Selected Cart Detail IDs: {}", selectedCartDetailIds);
        log.info("Variant IDs: {}", variantIds);
        log.info("Quantities: {}", quantities);

        // Redirect to the GET method with parameters
        StringBuilder redirectUrl = new StringBuilder("redirect:/user/order-view");

        // Add variantIds
        if (!variantIds.isEmpty()) {
            redirectUrl.append("?");
            for (int i = 0; i < variantIds.size(); i++) {
                if (i > 0) {
                    redirectUrl.append("&");
                }
                redirectUrl.append("variantIds=").append(variantIds.get(i));
            }

            // Add quantities
            for (int i = 0; i < quantities.size(); i++) {
                redirectUrl.append("&quantities=").append(quantities.get(i));
            }
        }

        log.info("Redirect URL: {}", redirectUrl.toString());
        return redirectUrl.toString();
    }

    /**
     * Format addresses for display in the view
     * This method replaces the API endpoint functionality
     * 
     * @param addresses List of customer addresses
     * @return Formatted string with address details
     */
    private String formatAddressesForView(List<Address> addresses) {
        StringBuilder result = new StringBuilder();

        for (Address address : addresses) {
            result.append("\nAddress ID: ").append(address.getAddressId())
                    .append("\nStreet: ").append(address.getStreet())
                    .append("\nWard: ").append(address.getWard())
                    .append("\nDistrict: ").append(address.getDistrict())
                    .append("\nProvince: ").append(address.getProvince())
                    .append("\nCountry: ").append(address.getCountry())
                    .append("\n-----------------------");

            log.info("Address formatted: ID={}, Street={}, Ward={}, District={}, Province={}, Country={}",
                    address.getAddressId(),
                    address.getStreet(),
                    address.getWard(),
                    address.getDistrict(),
                    address.getProvince(),
                    address.getCountry());
        }

        if (addresses.isEmpty()) {
            result.append("No addresses found for this customer.");
        }

        return result.toString();
    }
}