package local.example.demo.service;

import local.example.demo.model.dto.SummaryOrderDTO;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;

@Service
public class SummaryService {

    /**
     * Process order summary and save it to the database
     * 
     * @param orderDTO The order data from client
     * @return The saved order ID
     */
    public String processOrderSummary(SummaryOrderDTO orderDTO) {
        System.out.println("=== Starting Order Processing in Service ===");

        // Validate order data
        validateOrderData(orderDTO);
        System.out.println("✓ Order data validated successfully");

        // Process order data (in a real application, this would interact with
        // repositories)
        // For example: save to database, generate order number, etc.
        System.out.println("✓ Processing order for customer: " + orderDTO.getCustomerId());

        // Calculate final amounts with detailed logic
        recalculateOrderAmounts(orderDTO);
        System.out.println("✓ Final amounts calculated");

        // Generate order ID
        String orderId = "ORD-" + System.currentTimeMillis();
        System.out.println("✓ Generated Order ID: " + orderId);

        System.out.println("=== Order Processing Completed ===");

        // Return order ID or reference number (this would come from the database in a
        // real app)
        return orderId;
    }

    /**
     * Validates order data
     * 
     * @param orderDTO Order data to validate
     * @throws IllegalArgumentException if validation fails
     */
    private void validateOrderData(SummaryOrderDTO orderDTO) {
        System.out.println("-> Validating order data...");

        if (orderDTO == null) {
            System.out.println("✗ Order data is null");
            throw new IllegalArgumentException("Order data cannot be null");
        }

        if (orderDTO.getCustomerInfo() == null) {
            System.out.println("✗ Customer information is missing");
            throw new IllegalArgumentException("Customer information is required");
        }

        if (orderDTO.getShippingAddress() == null) {
            System.out.println("✗ Shipping address is missing");
            throw new IllegalArgumentException("Shipping address is required");
        }

        if (orderDTO.getPayment() == null || orderDTO.getPayment().getMethod() == null) {
            System.out.println("✗ Payment method is missing");
            throw new IllegalArgumentException("Payment method is required");
        }

        System.out.println("-> All required fields validated");
    }

    /**
     * Detailed calculation of all order amounts with clear business logic
     * 
     * @param orderDTO Order data to calculate
     */
    public void recalculateOrderAmounts(SummaryOrderDTO orderDTO) {
        System.out.println("\n===== DETAILED ORDER CALCULATION =====");

        // Get order items
        List<SummaryOrderDTO.OrderItem> orderItems = orderDTO.getOrderItems();
        if (orderItems == null || orderItems.isEmpty()) {
            System.out.println("❌ No order items found. Cannot calculate order amounts.");
            return;
        }

        // 1. Calculate Subtotal (sum of all item prices * quantities)
        int subtotal = 0;
        for (SummaryOrderDTO.OrderItem item : orderItems) {
            // Get product price from the item (client-provided) instead of using
            // getProductPrice
            int productVariantId = (int) getOrderItemField(item, "product_variant_id");
            int quantity = (int) getOrderItemField(item, "quantity");
            int itemPrice = (int) getOrderItemField(item, "price");
            int itemSubtotal = itemPrice * quantity;
            subtotal += itemSubtotal;

            System.out.println("➤ Item " + productVariantId +
                    ": Price=" + itemPrice +
                    " × Quantity=" + quantity +
                    " = " + itemSubtotal);
        }
        System.out.println("✓ Subtotal: " + subtotal);

        // 2. Calculate Total Discount
        int totalDiscount = calculateTotalDiscount(orderItems);
        System.out.println("✓ Total Discount: " + totalDiscount);

        // 3. Get Shipping Fee (using the value from the order)
        int shippingFee = 0;
        if (orderDTO.getOrderCalculation() != null) {
            shippingFee = orderDTO.getOrderCalculation().getShippingFee();
        } else if (orderDTO.getShipping() != null) {
            shippingFee = orderDTO.getShipping().getFee();
        }
        System.out.println("✓ Shipping Fee: " + shippingFee);

        // 4. Calculate Total After Discount
        int totalAfterDiscount = subtotal - totalDiscount;
        System.out.println("✓ Total After Discount: " + totalAfterDiscount);

        // 5. Calculate Tax Amount
        int taxAmount = 0;
        if (orderDTO.getTaxInfo() != null && orderDTO.getTaxInfo().isIncludeVat()) {
            double vatRate = orderDTO.getTaxInfo().getVatRate();
            taxAmount = (int) Math.round(totalAfterDiscount * vatRate);
            System.out.println("✓ Tax Amount: " + taxAmount + " (Rate: " + vatRate + ")");
        } else {
            System.out.println("✓ Tax Amount: 0 (VAT not included)");
        }

        // 6. Calculate Final Total
        int finalTotal = totalAfterDiscount + shippingFee + taxAmount;
        System.out.println("✓ Final Total: " + finalTotal);

        // 7. Update the orderDTO with calculated values
        if (orderDTO.getOrderCalculation() == null) {
            // Create new calculation object if it doesn't exist
            orderDTO.setOrderCalculation(new SummaryOrderDTO.OrderCalculation());
        }

        orderDTO.getOrderCalculation().setSubtotal(subtotal);
        orderDTO.getOrderCalculation().setTotalDiscountAmount(totalDiscount);
        orderDTO.getOrderCalculation().setTaxAmount(taxAmount);
        orderDTO.getOrderCalculation().setTotalAfterDiscount(totalAfterDiscount);
        orderDTO.getOrderCalculation().setFinalTotal(finalTotal);

        if (orderDTO.getTaxInfo() != null && orderDTO.getTaxInfo().isIncludeVat()) {
            orderDTO.getTaxInfo().setVatAmount(taxAmount);
        }

        System.out.println("===== END OF DETAILED CALCULATION =====\n");
    }

    /**
     * Helper method to get field values from OrderItem using reflection
     * 
     * @param item      OrderItem instance
     * @param fieldName Name of the field to retrieve
     * @return Field value
     */
    private Object getOrderItemField(SummaryOrderDTO.OrderItem item, String fieldName) {
        try {
            // First try getting the field directly using getter method
            String getterName = "get" + fieldName.substring(0, 1).toUpperCase() + fieldName.substring(1);
            java.lang.reflect.Method method = item.getClass().getMethod(getterName);
            return method.invoke(item);
        } catch (Exception e1) {
            // If getter method not found, try camelCase version
            try {
                String camelCaseGetter = "get" +
                        fieldName.substring(0, 1).toUpperCase() +
                        fieldName.substring(1).replace("_", "");
                java.lang.reflect.Method method = item.getClass().getMethod(camelCaseGetter);
                return method.invoke(item);
            } catch (Exception e2) {
                // If still not found, try direct field access
                try {
                    java.lang.reflect.Field field = item.getClass().getDeclaredField(fieldName);
                    field.setAccessible(true);
                    return field.get(item);
                } catch (Exception e3) {
                    System.out.println("Could not access field: " + fieldName + " in OrderItem");
                    return null;
                }
            }
        }
    }

    /**
     * Calculate total discount amount from all order items
     * 
     * @param orderItems List of order items
     * @return Total discount amount
     */
    private int calculateTotalDiscount(List<SummaryOrderDTO.OrderItem> orderItems) {
        int totalDiscount = 0;

        for (SummaryOrderDTO.OrderItem item : orderItems) {
            // Get applied discounts using reflection
            List<Map<String, Object>> appliedDiscounts = (List<Map<String, Object>>) getOrderItemField(item,
                    "applied_discounts");

            if (appliedDiscounts != null && !appliedDiscounts.isEmpty()) {
                int productVariantId = (int) getOrderItemField(item, "product_variant_id");
                int quantity = (int) getOrderItemField(item, "quantity");
                int itemPrice = (int) getOrderItemField(item, "price");
                int itemSubtotal = itemPrice * quantity;

                for (Map<String, Object> discount : appliedDiscounts) {
                    // Get discount percentage (stored as 10 for 10%)
                    double percentage = parseNumberValue(discount.get("percentage"));
                    double discountRate = percentage / 100.0;

                    // Get max discount amount
                    int maxDiscountAmount = (int) parseNumberValue(discount.get("max_discount_amount"));

                    // Calculate raw discount amount
                    int discountAmount = (int) Math.round(itemSubtotal * discountRate);

                    // Apply maximum discount limit
                    if (discountAmount > maxDiscountAmount) {
                        discountAmount = maxDiscountAmount;
                        System.out.println("➤ Item " + productVariantId +
                                " discount capped at max: " + maxDiscountAmount);
                    }

                    totalDiscount += discountAmount;
                    System.out.println("➤ Item " + productVariantId +
                            " discount: " + discountAmount +
                            " (" + percentage + "% of " + itemSubtotal + ")");
                }
            } else {
                int productVariantId = (int) getOrderItemField(item, "product_variant_id");
                System.out.println("➤ Item " + productVariantId + ": No discounts applied");
            }
        }

        return totalDiscount;
    }

    /**
     * Safely parse a value to a number, handling both String and Number types
     *
     * @param value The value to parse
     * @return The parsed number as a double
     */
    private double parseNumberValue(Object value) {
        if (value == null) {
            return 0;
        }

        if (value instanceof Number) {
            return ((Number) value).doubleValue();
        } else if (value instanceof String) {
            try {
                return Double.parseDouble((String) value);
            } catch (NumberFormatException e) {
                System.out.println("Warning: Could not parse numeric value from: " + value);
                return 0;
            }
        } else {
            System.out.println("Warning: Unknown value type: " + value.getClass().getName());
            return 0;
        }
    }

    /**
     * Calculate and verify final order amounts
     * 
     * @param orderDTO Order data to calculate
     */
    private void calculateFinalAmounts(SummaryOrderDTO orderDTO) {
        System.out.println("-> Calculating final amounts...");

        // In a real application, this would recalculate amounts on the server side
        // to verify client calculations and prevent tampering

        if (orderDTO.getOrderCalculation() != null) {
            System.out.println("   Original subtotal: " + orderDTO.getOrderCalculation().getSubtotal());
            System.out.println("   Original tax amount: " + orderDTO.getOrderCalculation().getTaxAmount());
            System.out.println("   Original final total: " + orderDTO.getOrderCalculation().getFinalTotal());

            // Verify tax amount
            if (orderDTO.getTaxInfo() != null && orderDTO.getTaxInfo().isIncludeVat()) {
                // Calculate VAT on totalAfterDiscount, not subtotal
                double totalAfterDiscount = orderDTO.getOrderCalculation().getTotalAfterDiscount();
                double vatRate = orderDTO.getTaxInfo().getVatRate();
                int calculatedVat = (int) Math.round(totalAfterDiscount * vatRate);

                System.out.println("   Server calculated VAT: " + calculatedVat + " (Client VAT: "
                        + orderDTO.getTaxInfo().getVatAmount() + ")");

                // If there's a significant difference, use server calculated value
                if (Math.abs(calculatedVat - orderDTO.getTaxInfo().getVatAmount()) > 1) {
                    System.out.println("   ⚠ Adjusting VAT amount from " + orderDTO.getTaxInfo().getVatAmount() + " to "
                            + calculatedVat);

                    orderDTO.getTaxInfo().setVatAmount(calculatedVat);
                    // Adjust final total as well
                    orderDTO.getOrderCalculation().setTaxAmount(calculatedVat);

                    int newTotal = orderDTO.getOrderCalculation().getTotalAfterDiscount() +
                            calculatedVat +
                            orderDTO.getOrderCalculation().getShippingFee();

                    System.out.println("   ⚠ Adjusting final total from "
                            + orderDTO.getOrderCalculation().getFinalTotal() + " to " + newTotal);
                    orderDTO.getOrderCalculation().setFinalTotal(newTotal);
                }
            }

            System.out.println("   Final subtotal: " + orderDTO.getOrderCalculation().getSubtotal());
            System.out.println("   Final tax amount: " + orderDTO.getOrderCalculation().getTaxAmount());
            System.out.println("   Final total: " + orderDTO.getOrderCalculation().getFinalTotal());
        } else {
            System.out.println("   ✗ No order calculation data available");
        }
    }
}
