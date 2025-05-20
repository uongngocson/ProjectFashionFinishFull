package local.example.demo.controller.client;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import local.example.demo.model.ErrorCodes;
import local.example.demo.model.dto.CreateOrderResponse;
import local.example.demo.model.dto.SummaryOrderDTO;
import local.example.demo.service.BookOders;
import local.example.demo.service.SummaryService;

@RestController
@RequestMapping("/api/orders")
public class OrderSubmitApiController {

    @Autowired
    private SummaryService summaryService;

    @Autowired
    private BookOders bookOders;

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

            // Validate required fields first
            validateRequiredFields(orderDTO);

            // Calculate and validate all amounts using SummaryService's calculation method
            System.out.println("\n============ RECALCULATING ORDER AMOUNTS ============");
            summaryService.recalculateOrderAmounts(orderDTO);
            System.out.println("============ CALCULATION COMPLETE ============\n");

            // Process the order through the BookOders service
            System.out.println("\n============ PROCESSING ORDER WITH BookOders SERVICE ============");
            CreateOrderResponse orderResponse = bookOders.processOrder(orderDTO);
            System.out.println("============ PROCESSING COMPLETE ============\n");

            // Prepare response
            Map<String, Object> response = new HashMap<>();

            if (orderResponse == null) {
                throw new RuntimeException("Order processing failed - null response from service");
            }

            if (orderResponse.getErrorCode() == 0) {
                // Success
                response.put("success", true);
                response.put("orderId", orderResponse.getOrderId());
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
            } else {
                // Error from stored procedure - map specific error codes to HTTP status codes
                response.put("success", false);
                response.put("errorCode", orderResponse.getErrorCode());

                // Use the ErrorCodes utility class to get a friendly error message
                String errorMessage = orderResponse.getErrorMessage();
                if (errorMessage == null || errorMessage.trim().isEmpty()) {
                    errorMessage = ErrorCodes.getErrorMessage(orderResponse.getErrorCode());
                }
                response.put("errorMessage", errorMessage);

                // Map error codes to appropriate HTTP status
                HttpStatus httpStatus = mapErrorCodeToHttpStatus(orderResponse.getErrorCode());

                // Log the error for server-side tracking
                System.out.println("Order processing failed with error code: " + orderResponse.getErrorCode());
                System.out.println("Error message: " + errorMessage);

                return ResponseEntity.status(httpStatus).body(response);
            }

        } catch (ValidationException e) {
            // Handle validation errors with 400 Bad Request
            System.out.println("\n----- VALIDATION ERROR -----");
            System.out.println(e.getMessage());

            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("errorCode", ErrorCodes.VALIDATION_ERROR);
            errorResponse.put("errorMessage", e.getMessage());
            errorResponse.put("fieldErrors", e.getFieldErrors());

            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorResponse);

        } catch (Exception e) {
            // Log the error
            System.out.println("\n----- ERROR PROCESSING ORDER -----");
            e.printStackTrace();

            // Create detailed error response
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);

            // Set appropriate error code based on exception type
            int errorCode = ErrorCodes.GENERAL_ERROR;
            HttpStatus status = HttpStatus.INTERNAL_SERVER_ERROR;

            // Check for specific exception types
            if (e instanceof IllegalArgumentException) {
                errorCode = ErrorCodes.VALIDATION_ERROR;
                status = HttpStatus.BAD_REQUEST;
            } else if (e.getMessage() != null && e.getMessage().contains("not found")) {
                // Determine which "not found" error it is
                if (e.getMessage().toLowerCase().contains("customer")) {
                    errorCode = ErrorCodes.CUSTOMER_NOT_FOUND;
                } else if (e.getMessage().toLowerCase().contains("product")) {
                    errorCode = ErrorCodes.PRODUCT_NOT_FOUND;
                } else if (e.getMessage().toLowerCase().contains("order")) {
                    errorCode = ErrorCodes.ORDER_NOT_FOUND;
                } else if (e.getMessage().toLowerCase().contains("address")) {
                    errorCode = ErrorCodes.ADDRESS_NOT_FOUND;
                } else {
                    errorCode = ErrorCodes.ORDER_NOT_FOUND; // Default not found
                }
                status = HttpStatus.NOT_FOUND;
            } else if (e.getMessage() != null &&
                    (e.getMessage().contains("permission") || e.getMessage().contains("access") ||
                            e.getMessage().contains("unauthorized"))) {
                errorCode = ErrorCodes.UNAUTHORIZED_ACCESS;
                status = HttpStatus.FORBIDDEN;
            } else if (e.getMessage() != null && e.getMessage().contains("database")) {
                errorCode = ErrorCodes.DATABASE_ERROR;
            } else if (e.getMessage() != null && e.getMessage().contains("payment")) {
                errorCode = ErrorCodes.PAYMENT_PROCESSING_ERROR;
            }

            errorResponse.put("errorCode", errorCode);
            errorResponse.put("errorMessage", ErrorCodes.getErrorMessage(errorCode));
            errorResponse.put("errorDetail", e.getMessage());
            errorResponse.put("errorType", e.getClass().getSimpleName());

            return ResponseEntity.status(status).body(errorResponse);
        }
    }

    /**
     * Maps error codes from the business logic to appropriate HTTP status codes
     * 
     * @param errorCode The error code from the business logic
     * @return The corresponding HTTP status
     */
    private HttpStatus mapErrorCodeToHttpStatus(int errorCode) {
        if (errorCode >= 1000 && errorCode < 2000) {
            // Validation errors
            return HttpStatus.BAD_REQUEST;
        } else if (errorCode >= 2000 && errorCode < 3000) {
            // Resource not found errors
            return HttpStatus.NOT_FOUND;
        } else if (errorCode >= 3000 && errorCode < 4000) {
            // Authentication/Authorization errors
            return HttpStatus.FORBIDDEN;
        } else if (errorCode == ErrorCodes.PAYMENT_PROCESSING_ERROR) {
            return HttpStatus.PAYMENT_REQUIRED;
        } else if (errorCode >= 4000 && errorCode < 5000) {
            // Business logic errors
            return HttpStatus.UNPROCESSABLE_ENTITY;
        } else {
            // System/Technical errors (5000+)
            return HttpStatus.INTERNAL_SERVER_ERROR;
        }
    }

    /**
     * Validates that all required fields are present in the order DTO
     * 
     * @param orderDTO The order DTO to validate
     * @throws ValidationException If validation fails
     */
    private void validateRequiredFields(SummaryOrderDTO orderDTO) throws ValidationException {
        Map<String, String> fieldErrors = new HashMap<>();

        // Validate customer info
        if (orderDTO.getCustomerId() == null) {
            fieldErrors.put("customerId", ErrorCodes.getErrorMessage(ErrorCodes.MISSING_REQUIRED_FIELD));
        }

        if (orderDTO.getCustomerInfo() == null) {
            fieldErrors.put("customerInfo", ErrorCodes.getErrorMessage(ErrorCodes.MISSING_REQUIRED_FIELD));
        } else {
            if (orderDTO.getCustomerInfo().getFullName() == null
                    || orderDTO.getCustomerInfo().getFullName().trim().isEmpty()) {
                fieldErrors.put("customerInfo.fullName", ErrorCodes.getErrorMessage(ErrorCodes.MISSING_REQUIRED_FIELD));
            }
            if (orderDTO.getCustomerInfo().getEmail() == null
                    || orderDTO.getCustomerInfo().getEmail().trim().isEmpty()) {
                fieldErrors.put("customerInfo.email", ErrorCodes.getErrorMessage(ErrorCodes.MISSING_REQUIRED_FIELD));
            } else if (!isValidEmail(orderDTO.getCustomerInfo().getEmail())) {
                fieldErrors.put("customerInfo.email", ErrorCodes.getErrorMessage(ErrorCodes.INVALID_EMAIL_FORMAT));
            }
            if (orderDTO.getCustomerInfo().getPhone() == null
                    || orderDTO.getCustomerInfo().getPhone().trim().isEmpty()) {
                fieldErrors.put("customerInfo.phone", ErrorCodes.getErrorMessage(ErrorCodes.MISSING_REQUIRED_FIELD));
            } else if (!isValidPhone(orderDTO.getCustomerInfo().getPhone())) {
                fieldErrors.put("customerInfo.phone", ErrorCodes.getErrorMessage(ErrorCodes.INVALID_PHONE_NUMBER));
            }
        }

        // Validate shipping address
        if (orderDTO.getShippingAddress() == null) {
            fieldErrors.put("shippingAddress", ErrorCodes.getErrorMessage(ErrorCodes.MISSING_REQUIRED_FIELD));
        } else {
            if (orderDTO.getShippingAddress().getRecipientName() == null ||
                    orderDTO.getShippingAddress().getRecipientName().trim().isEmpty()) {
                fieldErrors.put("shippingAddress.recipientName",
                        ErrorCodes.getErrorMessage(ErrorCodes.MISSING_REQUIRED_FIELD));
            }
            if (orderDTO.getShippingAddress().getRecipientPhone() == null ||
                    orderDTO.getShippingAddress().getRecipientPhone().trim().isEmpty()) {
                fieldErrors.put("shippingAddress.recipientPhone",
                        ErrorCodes.getErrorMessage(ErrorCodes.MISSING_REQUIRED_FIELD));
            } else if (!isValidPhone(orderDTO.getShippingAddress().getRecipientPhone())) {
                fieldErrors.put("shippingAddress.recipientPhone",
                        ErrorCodes.getErrorMessage(ErrorCodes.INVALID_PHONE_NUMBER));
            }
        }

        // Validate payment method
        if (orderDTO.getPayment() == null || orderDTO.getPayment().getMethod() == null ||
                orderDTO.getPayment().getMethod().trim().isEmpty()) {
            fieldErrors.put("payment.method", ErrorCodes.getErrorMessage(ErrorCodes.MISSING_REQUIRED_FIELD));
        }

        // If there are validation errors, throw exception with detailed field errors
        if (!fieldErrors.isEmpty()) {
            throw new ValidationException("Order validation failed", fieldErrors);
        }
    }

    /**
     * Simple email validation
     */
    private boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return email != null && email.matches(emailRegex);
    }

    /**
     * Simple phone validation - accepts various formats
     */
    private boolean isValidPhone(String phone) {
        String phoneRegex = "^[+]?[(]?[0-9]{3}[)]?[-\\s.]?[0-9]{3}[-\\s.]?[0-9]{4,6}$";
        return phone != null && phone.matches(phoneRegex);
    }

    /**
     * Custom exception for validation errors
     */
    private static class ValidationException extends Exception {
        private final Map<String, String> fieldErrors;

        public ValidationException(String message, Map<String, String> fieldErrors) {
            super(message);
            this.fieldErrors = fieldErrors;
        }

        public Map<String, String> getFieldErrors() {
            return fieldErrors;
        }
    }
}