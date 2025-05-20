package local.example.demo.service;

import local.example.demo.model.dto.CreateOrderResponse;
import local.example.demo.model.dto.SummaryOrderDTO;
import local.example.demo.model.dto.OrderItemDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class BookOders {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    /**
     * Process an order using the SummaryOrderDTO and call the stored procedure
     * usp_CreateOrderTestV1
     * 
     * @param orderDTO The summary order data from client
     * @return CreateOrderResponse containing the result of the operation
     */
    @Transactional
    public CreateOrderResponse processOrder(SummaryOrderDTO orderDTO) {
        CreateOrderResponse response = new CreateOrderResponse();

        try {
            System.out.println("=== Starting Order Processing in BookOders Service ===");

            // Extract customerId - convert from String to Integer
            Integer customerId = Integer.parseInt(orderDTO.getCustomerId());

            // Extract paymentId - convert from String to Integer
            Integer paymentId = Integer.parseInt(orderDTO.getPayment().getMethod());

            // Get total amount from the order calculation
            BigDecimal totalAmount = new BigDecimal(orderDTO.getOrderCalculation().getFinalTotal());

            // Convert SummaryOrderDTO.OrderItem to OrderItemDTO
            List<OrderItemDTO> orderItems = orderDTO.getOrderItems().stream()
                    .map(item -> {
                        OrderItemDTO dto = new OrderItemDTO();
                        dto.setProduct_variant_id(item.getProduct_variant_id());
                        dto.setQuantity(item.getQuantity());
                        return dto;
                    })
                    .collect(Collectors.toList());

            System.out.println("✓ Extracted order items: " + orderItems.size() + " items");

            // Extract address information
            Integer addressId = Integer.parseInt(orderDTO.getShippingAddress().getId());
            String recipientName = orderDTO.getShippingAddress().getRecipientName();
            String recipientPhone = orderDTO.getShippingAddress().getRecipientPhone();
            String street = orderDTO.getShippingAddress().getFullAddress();
            Integer provinceId = Integer.parseInt(orderDTO.getShippingAddress().getProvinceId());
            Integer districtId = Integer.parseInt(orderDTO.getShippingAddress().getDistrictId());
            Integer wardId = Integer.parseInt(orderDTO.getShippingAddress().getWardCode());
            String country = "Việt Nam"; // Default country

            System.out.println("✓ Extracted shipping address details");

            // Extract product variant IDs with discounts
            List<Integer> itemsWithDiscounts = orderDTO.getOrderItems().stream()
                    .filter(item -> item.getApplied_discounts() != null && !item.getApplied_discounts().isEmpty())
                    .map(item -> item.getProduct_variant_id())
                    .collect(Collectors.toList());

            System.out.println("✓ Extracted " + itemsWithDiscounts.size() + " items with discounts");

            // Convert itemsWithDiscounts to comma-separated string
            String productVariantIds = null;
            if (!itemsWithDiscounts.isEmpty()) {
                productVariantIds = itemsWithDiscounts.stream()
                        .map(String::valueOf)
                        .collect(Collectors.joining(","));
                System.out.println("✓ Product variant IDs with discounts: " + productVariantIds);
            }

            // Prepare SQL to execute stored procedure
            StringBuilder sql = new StringBuilder();

            // TVP preparation
            sql.append("DECLARE @OrderItems AS dbo.OrderDetailType; ");

            // Insert items into TVP
            for (OrderItemDTO item : orderItems) {
                sql.append("INSERT INTO @OrderItems (product_variant_id, quantity) VALUES (")
                        .append(item.getProduct_variant_id()).append(", ")
                        .append(item.getQuantity()).append("); ");
            }

            // Declare output variables
            sql.append("DECLARE @OutputOrderID CHAR(10); ");
            sql.append("DECLARE @OutputErrorCode INT; ");
            sql.append("DECLARE @OutputErrorMessage NVARCHAR(500); ");

            // Execute stored procedure
            sql.append("EXEC [dbo].[usp_CreateOrderFull] ");
            sql.append("@customer_id = ").append(customerId).append(", ");
            sql.append("@payment_id = ").append(paymentId).append(", ");
            sql.append("@TotalAmount = ").append(totalAmount).append(", ");
            sql.append("@OrderItems = @OrderItems, ");

            // Add address parameters
            sql.append("@AddressId = ").append(addressId).append(", ");
            sql.append("@RecipientName = N'").append(recipientName).append("', ");
            sql.append("@RecipientPhone = '").append(recipientPhone).append("', ");
            sql.append("@Street = N'").append(street).append("', ");
            sql.append("@ProvinceId = ").append(provinceId).append(", ");
            sql.append("@DistrictId = ").append(districtId).append(", ");
            sql.append("@WardId = ").append(wardId).append(", ");
            sql.append("@Country = N'").append(country).append("', ");

            // Add product variant IDs with discounts if available
            if (productVariantIds != null) {
                sql.append("@ProductVariantIds = '").append(productVariantIds).append("', ");
            }

            // Add output parameters
            sql.append("@new_order_id = @OutputOrderID OUTPUT, ");
            sql.append("@ErrorCode = @OutputErrorCode OUTPUT, ");
            sql.append("@ErrorMessage = @OutputErrorMessage OUTPUT; ");

            // Get results
            sql.append(
                    "SELECT @OutputOrderID AS NewOrderID, @OutputErrorCode AS ErrorCode, @OutputErrorMessage AS ErrorMessage;");

            System.out.println("✓ SQL statement prepared");

            // Execute SQL
            jdbcTemplate.query(
                    sql.toString(),
                    (rs) -> {
                        if (rs.next()) {
                            response.setOrderId(rs.getString("NewOrderID"));
                            response.setErrorCode(rs.getInt("ErrorCode"));
                            response.setErrorMessage(rs.getString("ErrorMessage"));
                        }
                        return null;
                    });

            // Log results
            System.out.println("✓ Stored procedure executed");
            System.out.println("✓ Order ID: " + response.getOrderId());
            System.out.println("✓ Error Code: " + response.getErrorCode());
            System.out.println("✓ Error Message: " + response.getErrorMessage());

            System.out.println("=== Order Processing Completed ===");

        } catch (Exception e) {
            e.printStackTrace();
            response.setErrorCode(-1);
            response.setErrorMessage("Error processing order: " + e.getMessage());
            System.out.println("✗ Error occurred: " + e.getMessage());
        }

        return response;
    }
}
