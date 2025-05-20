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
import local.example.demo.model.entity.Addressv2;
import local.example.demo.model.entity.CartDetail;
import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.ProductVariant;
import local.example.demo.service.AddressService;
import local.example.demo.service.CartDetailService;
import local.example.demo.service.CustomerService;
import local.example.demo.service.ProductVariantService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import local.example.demo.model.entity.Order;
import local.example.demo.model.entity.OrderDetail;
import local.example.demo.model.dto.OrderConfirmItemDTO;
import local.example.demo.service.OrderService;

@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
@Slf4j
public class OrderViewController {

    private final CustomerService customerService;
    private final ProductVariantService productVariantService;
    private final AddressService addressService;
    private final CartDetailService cartDetailService;
    private final OrderService orderService;

    private final ObjectMapper objectMapper = new ObjectMapper();

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

    @GetMapping("/order-view")
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
            List<Addressv2> addressesv2 = addressService.getAddressesv2ForCustomer(customerDetails.getCustomerId());
            log.info("Addressesv2 information for testing:");
            for (Addressv2 address : addressesv2) {
                log.info("Address ID: {}, Street: {}, Full Address: {}",
                        address.getAddressId(),
                        address.getStreet(),
                        address.getFullAddress());

                log.info("Ward: ID={}, Name={}",
                        address.getWardId(),
                        address.getWard() != null ? address.getWard().getWardName() : "N/A");

                log.info("District: ID={}, Name={}",
                        address.getDistrictId(),
                        address.getDistrict() != null ? address.getDistrict().getDistrictName() : "N/A");

                log.info("Province: ID={}, Name={}",
                        address.getProvinceId(),
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

    @PostMapping("/order-view")
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
                    .append("\nCity: ").append(address.getCity())
                    .append("\n-----------------------");

            log.info("Address formatted: ID={}, Street={}, Ward={}, District={}, Province={}, City={}",
                    address.getAddressId(),
                    address.getStreet(),
                    address.getWard(),
                    address.getDistrict(),
                    address.getProvince(),
                    address.getCity());
        }

        if (addresses.isEmpty()) {
            result.append("No addresses found for this customer.");
        }

        return result.toString();
    }

    /**
     * Handles POST request to order confirmation page
     * Receives order data from form submission and passes it to the view
     */
    @PostMapping("/orderconfirm")
    public String showOrderConfirmation(
            @RequestParam(required = false) String orderId,
            @RequestParam(required = false) String orderDate,
            @RequestParam(required = false) String customerName,
            @RequestParam(required = false) String customerEmail,
            @RequestParam(required = false) String shippingAddress,
            @RequestParam(required = false) String subtotal,
            @RequestParam(required = false) String discount,
            @RequestParam(required = false) String shipping,
            @RequestParam(required = false) String total,
            @RequestParam(required = false) String orderItemsJson,
            Model model) {

        try {
            // Format order ID with a prefix if needed
            if (orderId == null || orderId.isEmpty()) {
                orderId = "ORD" + System.currentTimeMillis();
            }

            // Parse order date
            LocalDateTime parsedOrderDate = null;
            if (orderDate != null && !orderDate.isEmpty()) {
                try {
                    parsedOrderDate = LocalDateTime.parse(orderDate);
                } catch (Exception e) {
                    // Fallback to current time if parsing fails
                    parsedOrderDate = LocalDateTime.now();
                }
            } else {
                parsedOrderDate = LocalDateTime.now();
            }

            // Format date for display
            String formattedDate = parsedOrderDate.format(
                    DateTimeFormatter.ofPattern("dd MMM yyyy 'at' hh:mm a"));

            // Parse monetary values
            BigDecimal subtotalValue = parseDecimal(subtotal, BigDecimal.ZERO);
            BigDecimal discountValue = parseDecimal(discount, BigDecimal.ZERO);
            BigDecimal shippingValue = parseDecimal(shipping, BigDecimal.ZERO);
            BigDecimal totalValue = parseDecimal(total, BigDecimal.ZERO);

            // Calculate discount percentage if both subtotal and discount are provided
            int discountPercentage = 0;
            if (subtotalValue.compareTo(BigDecimal.ZERO) > 0 && discountValue.compareTo(BigDecimal.ZERO) > 0) {
                discountPercentage = discountValue.multiply(new BigDecimal(100))
                        .divide(subtotalValue, 0, BigDecimal.ROUND_HALF_UP).intValue();
            }

            // Parse order items
            List<OrderConfirmItemDTO> orderItems = new ArrayList<>();
            if (orderItemsJson != null && !orderItemsJson.isEmpty()) {
                try {
                    orderItems = objectMapper.readValue(orderItemsJson,
                            new TypeReference<List<OrderConfirmItemDTO>>() {
                            });
                } catch (Exception e) {
                    System.err.println("Error parsing order items JSON: " + e.getMessage());
                }
            }

            // If we have an order ID but no items, try to fetch them from the database
            if (orderId != null && !orderId.isEmpty() && orderItems.isEmpty()) {
                try {
                    Order order = orderService.getOrderById(orderId);
                    if (order != null) {
                        List<OrderDetail> orderDetails = orderService.getOrderDetailByOrderId(orderId);
                        for (OrderDetail detail : orderDetails) {
                            OrderConfirmItemDTO item = new OrderConfirmItemDTO();

                            // Check if productVariant and its product exist
                            if (detail.getProductVariant() != null && detail.getProductVariant().getProduct() != null) {
                                item.setName(detail.getProductVariant().getProduct().getProductName());

                                // Try to get variant details if available
                                if (detail.getProductVariant().getImageUrl() != null) {
                                    item.setImageUrl(detail.getProductVariant().getImageUrl());
                                }

                                // Set color and size if available
                                if (detail.getProductVariant().getColor() != null) {
                                    item.setColor(detail.getProductVariant().getColor().getColorName());
                                }

                                if (detail.getProductVariant().getSize() != null) {
                                    item.setSize(detail.getProductVariant().getSize().getSizeName());
                                }
                            } else {
                                item.setName("Unknown Product");
                            }

                            item.setPrice(detail.getPrice());
                            item.setQuantity(detail.getQuantity());
                            item.setSubtotal(detail.getPrice().multiply(new BigDecimal(detail.getQuantity())));

                            orderItems.add(item);
                        }

                        // Update other order data from the database
                        customerName = order.getCustomer().getFirstName() + " " + order.getCustomer().getLastName();
                        totalValue = order.getTotalAmount();
                        formattedDate = order.getOrderDate().format(
                                DateTimeFormatter.ofPattern("dd MMM yyyy 'at' hh:mm a"));
                    }
                } catch (Exception e) {
                    System.err.println("Error fetching order details: " + e.getMessage());
                }
            }

            // Add all data to the model
            model.addAttribute("orderId", orderId);
            model.addAttribute("orderDate", formattedDate);
            model.addAttribute("customerName", customerName);
            model.addAttribute("customerEmail", customerEmail);
            model.addAttribute("shippingAddress", shippingAddress);
            model.addAttribute("subtotal", subtotalValue);
            model.addAttribute("discount", discountValue);
            model.addAttribute("discountPercentage", discountPercentage);
            model.addAttribute("shipping", shippingValue);
            model.addAttribute("total", totalValue);
            model.addAttribute("orderItems", orderItems);

            return "client/user/orderconfirm";

        } catch (Exception e) {
            // Log error and add error message to model
            System.err.println("Error processing order confirmation: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "An error occurred while processing your order confirmation");
            return "client/user/orderconfirm";
        }
    }

    /**
     * GET endpoint for order confirmation page
     * Used when redirected from payment gateway or for direct access with order ID
     */
    @GetMapping("/orderconfirm")
    public String viewOrderConfirmation(
            @RequestParam(required = false) String orderId,
            @RequestParam(required = false) String paymentId,
            @RequestParam(required = false) String paymentStatus,
            Model model) {

        // Check if we have an order ID
        if (orderId == null || orderId.isEmpty()) {
            model.addAttribute("error", "Không tìm thấy thông tin đơn hàng. Vui lòng kiểm tra lại.");
            return "client/user/orderconfirm";
        }

        try {
            // Fetch order details from database
            Order order = orderService.getOrderById(orderId);

            if (order == null) {
                model.addAttribute("error", "Đơn hàng #" + orderId + " không tồn tại.");
                return "client/user/orderconfirm";
            }

            // Fetch order items
            List<OrderDetail> orderDetails = orderService.getOrderDetailByOrderId(orderId);
            List<OrderConfirmItemDTO> orderItems = new ArrayList<>();

            for (OrderDetail detail : orderDetails) {
                OrderConfirmItemDTO item = new OrderConfirmItemDTO();

                // Check if productVariant and its product exist
                if (detail.getProductVariant() != null && detail.getProductVariant().getProduct() != null) {
                    item.setName(detail.getProductVariant().getProduct().getProductName());

                    // Try to get variant details if available
                    try {
                        item.setImageUrl(detail.getProductVariant().getImageUrl());

                        // Set color and size if available
                        if (detail.getProductVariant().getColor() != null) {
                            item.setColor(detail.getProductVariant().getColor().getColorName());
                        }

                        if (detail.getProductVariant().getSize() != null) {
                            item.setSize(detail.getProductVariant().getSize().getSizeName());
                        }
                    } catch (Exception e) {
                        // Continue if we can't get additional details
                        System.err.println("Error getting variant details: " + e.getMessage());
                    }
                } else {
                    item.setName("Unknown Product");
                }

                item.setPrice(detail.getPrice());
                item.setQuantity(detail.getQuantity());
                item.setSubtotal(detail.getPrice().multiply(new BigDecimal(detail.getQuantity())));

                orderItems.add(item);
            }

            // Get customer name
            String customerName = "";
            if (order.getCustomer() != null) {
                customerName = order.getCustomer().getFirstName() + " " + order.getCustomer().getLastName();
            }

            // Get customer email if available
            String customerEmail = "";
            if (order.getCustomer() != null) {
                customerEmail = order.getCustomer().getEmail();
            }

            // Format order date
            String formattedDate = order.getOrderDate() != null
                    ? order.getOrderDate().format(DateTimeFormatter.ofPattern("dd MMM yyyy 'at' hh:mm a"))
                    : LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd MMM yyyy 'at' hh:mm a"));

            // Get shipping address if available
            String shippingAddress = "Không có thông tin địa chỉ";
            // You would need to get the shipping address from your order or address model

            // Calculate discount percentage if applicable
            BigDecimal subtotal = BigDecimal.ZERO;
            BigDecimal discount = BigDecimal.ZERO;
            BigDecimal shipping = new BigDecimal("8.00"); // Default shipping cost
            BigDecimal total = order.getTotalAmount();

            // If we have order details, calculate subtotal
            if (!orderItems.isEmpty()) {
                for (OrderConfirmItemDTO item : orderItems) {
                    subtotal = subtotal.add(item.getSubtotal());
                }

                // Calculate estimated discount (if total < subtotal)
                if (total.compareTo(subtotal) < 0) {
                    discount = subtotal.subtract(total);
                }
            }

            // Add payment status message if available
            if (paymentStatus != null && !paymentStatus.isEmpty()) {
                if ("success".equalsIgnoreCase(paymentStatus)) {
                    model.addAttribute("paymentMessage", "Thanh toán thành công!");
                } else if ("pending".equalsIgnoreCase(paymentStatus)) {
                    model.addAttribute("paymentMessage",
                            "Thanh toán đang xử lý. Chúng tôi sẽ cập nhật trạng thái khi hoàn tất.");
                } else if ("failed".equalsIgnoreCase(paymentStatus)) {
                    model.addAttribute("paymentMessage", "Thanh toán thất bại. Vui lòng liên hệ hỗ trợ khách hàng.");
                    model.addAttribute("paymentError", true);
                }
            }

            // Calculate discount percentage
            int discountPercentage = 0;
            if (subtotal.compareTo(BigDecimal.ZERO) > 0 && discount.compareTo(BigDecimal.ZERO) > 0) {
                discountPercentage = discount.multiply(new BigDecimal(100))
                        .divide(subtotal, 0, BigDecimal.ROUND_HALF_UP).intValue();
            }

            // Add all data to the model
            model.addAttribute("orderId", orderId);
            model.addAttribute("orderDate", formattedDate);
            model.addAttribute("customerName", customerName);
            model.addAttribute("customerEmail", customerEmail);
            model.addAttribute("shippingAddress", shippingAddress);
            model.addAttribute("subtotal", subtotal);
            model.addAttribute("discount", discount);
            model.addAttribute("discountPercentage", discountPercentage);
            model.addAttribute("shipping", shipping);
            model.addAttribute("total", total);
            model.addAttribute("orderItems", orderItems);
            model.addAttribute("paymentId", paymentId);

            return "client/user/orderconfirm";

        } catch (Exception e) {
            // Log error and add error message to model
            System.err.println("Error processing order confirmation: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Đã xảy ra lỗi khi tải thông tin đơn hàng. Vui lòng thử lại sau.");
            return "client/user/orderconfirm";
        }
    }

    /**
     * Helper method to safely parse decimal values
     */
    private BigDecimal parseDecimal(String value, BigDecimal defaultValue) {
        if (value == null || value.isEmpty()) {
            return defaultValue;
        }

        try {
            // Remove any currency symbols and handle different formats
            String cleanValue = value.replaceAll("[^\\d.,\\-]", "").trim();
            return new BigDecimal(cleanValue);
        } catch (Exception e) {
            return defaultValue;
        }
    }
}