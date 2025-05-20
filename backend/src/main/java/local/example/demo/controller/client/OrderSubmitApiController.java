package local.example.demo.controller.client;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import local.example.demo.model.dto.SummaryOrderDTO;
import local.example.demo.service.SummaryService;

@RestController
@RequestMapping("/api/orders")
public class OrderSubmitApiController {

    @Autowired
    private SummaryService summaryService;

    /**
     * API endpoint to submit orders via AJAX
     * 
     * @param orderDTO Order data from client
     * @return JSON response with order ID and status
     */
    @PostMapping("/submit")
    public ResponseEntity<Map<String, Object>> submitOrder(@RequestBody SummaryOrderDTO orderDTO) {
        try {
            // Log received data in complete detail
            System.out.println("\n\n============ RECEIVED ORDER DATA VIA API ============");
            System.out.println("Customer ID: " + orderDTO.getCustomerId());

            // Customer Info
            if (orderDTO.getCustomerInfo() != null) {
                System.out.println("\n----- CUSTOMER INFO -----");
                System.out.println("Full Name: " + orderDTO.getCustomerInfo().getFullName());
                System.out.println("Email: " + orderDTO.getCustomerInfo().getEmail());
                System.out.println("Phone: " + orderDTO.getCustomerInfo().getPhone());
            }

            // Shipping Address
            if (orderDTO.getShippingAddress() != null) {
                System.out.println("\n----- SHIPPING ADDRESS -----");
                System.out.println("Recipient Name: " + orderDTO.getShippingAddress().getRecipientName());
                System.out.println("Recipient Phone: " + orderDTO.getShippingAddress().getRecipientPhone());
                System.out.println("Province ID: " + orderDTO.getShippingAddress().getProvinceId());
                System.out.println("District ID: " + orderDTO.getShippingAddress().getDistrictId());
                System.out.println("District Name: " + orderDTO.getShippingAddress().getDistrictName());
                System.out.println("Ward Code: " + orderDTO.getShippingAddress().getWardCode());
                System.out.println("Ward Name: " + orderDTO.getShippingAddress().getWardName());
            }

            // Payment
            if (orderDTO.getPayment() != null) {
                System.out.println("\n----- PAYMENT INFO -----");
                System.out.println("Payment Method: " + orderDTO.getPayment().getMethod());
            }

            // Shipping
            if (orderDTO.getShipping() != null) {
                System.out.println("\n----- SHIPPING INFO -----");
                System.out.println("Shipping Fee: " + orderDTO.getShipping().getFee());
                System.out.println("Service ID: " + orderDTO.getShipping().getServiceId());
                System.out.println("Estimated Delivery Time: " + orderDTO.getShipping().getEstimatedDeliveryTime());
            }

            // Note
            System.out.println("\n----- ORDER NOTE -----");
            System.out.println("Note: " + orderDTO.getNote());

            // Tax Info
            if (orderDTO.getTaxInfo() != null) {
                System.out.println("\n----- TAX INFO -----");
                System.out.println("Include VAT: " + orderDTO.getTaxInfo().isIncludeVat());
                System.out.println("VAT Rate: " + orderDTO.getTaxInfo().getVatRate());
                System.out.println("VAT Amount: " + orderDTO.getTaxInfo().getVatAmount());
            }

            // Order Calculation
            if (orderDTO.getOrderCalculation() != null) {
                System.out.println("\n----- ORDER CALCULATION (CLIENT VALUES) -----");
                System.out.println("Subtotal: " + orderDTO.getOrderCalculation().getSubtotal());
                System.out.println("Total Discount Amount: " + orderDTO.getOrderCalculation().getTotalDiscountAmount());
                System.out.println("Shipping Fee: " + orderDTO.getOrderCalculation().getShippingFee());
                System.out.println("Tax Amount: " + orderDTO.getOrderCalculation().getTaxAmount());
                System.out.println("Total After Discount: " + orderDTO.getOrderCalculation().getTotalAfterDiscount());
                System.out.println("Final Total: " + orderDTO.getOrderCalculation().getFinalTotal());

                if (orderDTO.getOrderCalculation().getAppliedDiscounts() != null) {
                    System.out.println("Applied Discounts: " + orderDTO.getOrderCalculation().getAppliedDiscounts());
                }
            }

            // Try to get access to the orderItems field - look for a getter method
            try {
                java.lang.reflect.Method method = orderDTO.getClass().getMethod("getOrderItems");
                if (method != null) {
                    Object orderItems = method.invoke(orderDTO);
                    System.out.println("\n----- ORDER ITEMS -----");
                    System.out.println("Order Items: " + orderItems);

                    if (orderItems instanceof List<?>) {
                        List<?> itemsList = (List<?>) orderItems;
                        System.out.println("Number of items: " + itemsList.size());

                        for (int i = 0; i < itemsList.size(); i++) {
                            Object item = itemsList.get(i);
                            System.out.println("Item " + (i + 1) + ": " + item);

                            // Try to access common fields
                            if (item != null) {
                                System.out.println("  Item details:");
                                for (java.lang.reflect.Method itemMethod : item.getClass().getMethods()) {
                                    if (itemMethod.getName().startsWith("get") &&
                                            itemMethod.getParameterCount() == 0 &&
                                            !itemMethod.getName().equals("getClass")) {
                                        try {
                                            Object value = itemMethod.invoke(item);
                                            System.out
                                                    .println("    " + itemMethod.getName().substring(3) + ": " + value);
                                        } catch (Exception e) {
                                            // Skip if we can't access the value
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } catch (Exception e) {
                System.out.println("\n----- ORDER ITEMS (Using toString) -----");
                System.out.println("Could not access orderItems through getter: " + e.getMessage());
                System.out.println("Full orderDTO: " + orderDTO.toString());
            }

            System.out.println("\n============ END OF ORDER DATA ============\n");

            // Calculate and validate all amounts using our detailed calculation method
            System.out.println("\n============ RECALCULATING ORDER AMOUNTS ============");
            summaryService.recalculateOrderAmounts(orderDTO);
            System.out.println("============ CALCULATION COMPLETE ============\n");

            // Process the order through the service
            String orderId = summaryService.processOrderSummary(orderDTO);

            // Prepare response
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("orderId", orderId);
            response.put("message", "Order submitted successfully");

            // Also return the recalculated values for client verification
            if (orderDTO.getOrderCalculation() != null) {
                Map<String, Object> calculationDetails = new HashMap<>();
                calculationDetails.put("subtotal", orderDTO.getOrderCalculation().getSubtotal());
                calculationDetails.put("totalDiscount", orderDTO.getOrderCalculation().getTotalDiscountAmount());
                calculationDetails.put("taxAmount", orderDTO.getOrderCalculation().getTaxAmount());
                calculationDetails.put("finalTotal", orderDTO.getOrderCalculation().getFinalTotal());
                response.put("orderCalculation", calculationDetails);
            }

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            // Log the error
            System.out.println("\n----- ERROR PROCESSING ORDER -----");
            e.printStackTrace();

            // chuẩn bị bắn lỗi ở đâyđây
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("error", e.getMessage());

            return ResponseEntity.badRequest().body(errorResponse);
        }
    }
}