package local.example.demo.service;

import local.example.demo.model.dto.CreateOrderResponse;
import local.example.demo.model.dto.OrderDetailDTO;
import local.example.demo.model.dto.OrderItemDTO;
import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.Order;
import local.example.demo.model.entity.OrderDetail;
import local.example.demo.repository.OrderDetailRepository;
import local.example.demo.repository.OrderRepository;
import lombok.RequiredArgsConstructor;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Types;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.stream.Collectors;
import javax.sql.DataSource;

@RequiredArgsConstructor
@Service
public class OrderService {

    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final JdbcTemplate jdbcTemplate;
    private final DataSource dataSource;

    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    public Order getOrderById(String orderId) {
        return orderRepository.findById(orderId).orElse(null);
    }

    @Transactional
    public void saveOrder(Order order) {
        if (order.getOrderId() == null || order.getOrderId().isEmpty()) {
            // Trường hợp tạo mới
            order.setOrderId(generateRandomOrderId());
            orderRepository.save(order);
        } else {
            // Trường hợp cập nhật: lấy từ DB trước
            Order existingOrder = orderRepository.findById(order.getOrderId())
                    .orElseThrow(() -> new RuntimeException("Order not found: " + order.getOrderId()));
            orderRepository.save(existingOrder);
        }
    }

    public void deleteOrder(String orderId) {
        orderRepository.deleteById(orderId);
    }

    public List<OrderDetail> getOrderDetailByOrderId(String orderId) {
        return orderDetailRepository.findByOrderId(orderId);
    }

    /**
     * Calls the stored procedure to create a new order
     * 
     * @param customerId The ID of the customer
     * @param paymentId  The ID of the payment method
     * @param orderItems List of order items with product variant IDs and
     *                   quantities
     * @return CreateOrderResponse containing the result of the operation
     */
    @Transactional
    public CreateOrderResponse createOrderWithStoredProcedure(
            Integer customerId,
            Integer paymentId,
            List<OrderItemDTO> orderItems) {

        CreateOrderResponse response = new CreateOrderResponse();

        try {
            System.out.println("Creating order with params: customerId=" + customerId +
                    ", paymentId=" + paymentId);
            System.out.println("Order items:");
            for (OrderItemDTO item : orderItems) {
                System.out.println("- product_variant_id: " + item.getProduct_variant_id() +
                        ", quantity: " + item.getQuantity());
            }

            // Kiểm tra xem có orderItems nào không
            if (orderItems == null || orderItems.isEmpty()) {
                response.setErrorCode(-1);
                response.setErrorMessage("No order items provided");
                return response;
            }

            // Lọc các orderItems không hợp lệ
            List<OrderItemDTO> validItems = orderItems.stream()
                    .filter(item -> item.getProduct_variant_id() != null && item.getProduct_variant_id() > 0
                            && item.getQuantity() > 0)
                    .toList();

            if (validItems.isEmpty()) {
                response.setErrorCode(-1);
                response.setErrorMessage("No valid order items found after filtering");
                return response;
            }

            // Thay vì gọi stored procedure với TVP, chúng ta sẽ tạo một câu SQL
            // tương tự như script gốc mà bạn đã cung cấp
            StringBuilder sql = new StringBuilder();

            // Phần khai báo các biến
            sql.append("DECLARE @CustomerID INT = ").append(customerId).append("; ");
            sql.append("DECLARE @PaymentMethodID INT = ").append(paymentId).append("; ");

            // Khai báo biến kiểu bảng và thêm dữ liệu chi tiết sản phẩm
            sql.append("DECLARE @OrderItems AS dbo.OrderDetailType; ");

            // Thêm các mục vào biến kiểu bảng
            for (OrderItemDTO item : validItems) {
                sql.append("INSERT INTO @OrderItems (product_variant_id, quantity) VALUES (")
                        .append(item.getProduct_variant_id()).append(", ")
                        .append(item.getQuantity()).append("); ");
            }

            // Khai báo biến output
            sql.append("DECLARE @OrderID CHAR(10); ");
            sql.append("DECLARE @ErrCode INT; ");
            sql.append("DECLARE @ErrMsg NVARCHAR(500); ");

            // Gọi Stored Procedure
            sql.append("EXEC dbo.usp_CreateOrder ")
                    .append("@customer_id = @CustomerID, ")
                    .append("@payment_id = @PaymentMethodID, ")
                    .append("@OrderItems = @OrderItems, ")
                    .append("@new_order_id = @OrderID OUTPUT, ")
                    .append("@ErrorCode = @ErrCode OUTPUT, ")
                    .append("@ErrorMessage = @ErrMsg OUTPUT; ");

            // Lấy kết quả
            sql.append("SELECT @OrderID AS NewOrderID, @ErrCode AS ErrorCode, @ErrMsg AS ErrorMessage;");

            System.out.println("Executing SQL: " + sql.toString());

            // Thực thi câu lệnh SQL
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

            // Ghi log kết quả
            System.out.println("Stored procedure result:");
            System.out.println("Order ID: " + response.getOrderId());
            System.out.println("Error Code: " + response.getErrorCode());
            System.out.println("Error Message: " + response.getErrorMessage());

        } catch (Exception e) {
            e.printStackTrace();
            response.setErrorCode(-1);
            response.setErrorMessage("Error calling stored procedure: " + e.getMessage());
        }

        return response;
    }

    /**
     * Generates a random 10-character order ID
     * 
     * @return A unique order ID string
     */
    private String generateRandomOrderId() {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        StringBuilder orderId = new StringBuilder();
        Random random = new Random();

        // Generate a 10-character random string
        for (int i = 0; i < 10; i++) {
            orderId.append(characters.charAt(random.nextInt(characters.length())));
        }

        // Check if the generated ID already exists
        if (orderRepository.existsById(orderId.toString())) {
            // If it exists, generate a new one recursively
            return generateRandomOrderId();
        }

        return orderId.toString();
    }

    public List<Order> findOrdersByCustomer(Customer customer) {
        List<Order> orders = orderRepository.findByCustomerId(customer.getCustomerId());
        System.out.println("Customer ID: " + customer.getCustomerId());
        System.out.println("Orders found: " + (orders != null ? orders.size() : 0));
        if (orders != null) {
            for (Order order : orders) {
                System.out.println("Order ID: " + order.getOrderId() + ", Status: " + order.getOrderStatus());
            }
        }
        return orders;
    }

    @Transactional
    public void cancelOrder(String orderId, Customer customer) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new IllegalArgumentException("Đơn hàng không tồn tại"));
        if (!order.getCustomer().getCustomerId().equals(customer.getCustomerId())) {
            throw new IllegalArgumentException("Bạn không có quyền hủy đơn hàng này");
        }
        if (!order.getOrderStatus().equals("Pending")) {
            throw new IllegalArgumentException("Chỉ có thể hủy đơn hàng ở trạng thái Pending");
        }
        order.setOrderStatus("Cancel"); // Cập nhật trạng thái thành "Cancel"
        orderRepository.save(order);
    }

    public List<OrderDetailDTO> getOrderDetails(String orderId) {
        String sql = """
                    SELECT
                        o.order_id,
                        o.order_date,
                        o.total_amount,
                        o.order_status,
                        o.payment_status,
                        c.customer_id,
                        c.first_name,
                        c.last_name,
                        c.email,
                        od.order_detail_id,
                        od.product_variant_id,
                        p.product_id,
                        p.product_name,
                        p.description,
                        p.image_url,
                        p.rating,
                        p.price AS product_price,
                        od.quantity,
                        od.price AS order_detail_price,
                        (od.quantity * od.price) AS subtotal,
                        -- Lấy thông tin địa chỉ giao hàng từ bảng Addresses, sử dụng các cột có sẵn
                        CONCAT(a.street, ', ', a.ward, ', ', a.district, ', ', a.city, ', ', a.province, ', ', a.country) AS shipping_address
                    FROM
                        Orders o
                        INNER JOIN Customers c ON o.customer_id = c.customer_id
                        INNER JOIN order_details od ON o.order_id = od.order_id
                        LEFT JOIN Products p ON od.product_variant_id = p.product_id
                        LEFT JOIN Addresses a ON o.shipping_address_id = a.address_id
                    WHERE
                        o.order_id = ?
                """;

        System.out.println("Executing getOrderDetails for orderId: " + orderId);
        System.out.println("SQL Query: " + sql);

        List<OrderDetailDTO> orderDetails = jdbcTemplate.query(sql, new Object[] { orderId }, (rs, rowNum) -> {
            OrderDetailDTO dto = new OrderDetailDTO(
                    rs.getString("order_id"),
                    rs.getObject("order_date", LocalDateTime.class),
                    rs.getBigDecimal("total_amount"),
                    rs.getString("order_status"),
                    rs.getInt("payment_status"),
                    rs.getInt("customer_id"),
                    rs.getString("first_name"),
                    rs.getString("last_name"),
                    rs.getString("email"),
                    rs.getLong("order_detail_id"),
                    rs.getLong("product_variant_id"),
                    rs.getLong("product_id"),
                    rs.getString("product_name"),
                    rs.getString("description"),
                    rs.getString("image_url"),
                    rs.getInt("rating") != 0 ? rs.getInt("rating") : null,
                    rs.getBigDecimal("product_price"),
                    rs.getInt("quantity"),
                    rs.getBigDecimal("order_detail_price"),
                    rs.getBigDecimal("subtotal"),
                    rs.getString("shipping_address"));
            System.out.println("Fetched OrderDetailDTO: " + dto.getOrderId() + ", Product: " + dto.getProductName());
            return dto;
        });

        System.out.println("Number of order details fetched: " + (orderDetails != null ? orderDetails.size() : 0));
        return orderDetails;
    }

    /**
     * Creates an order using the usp_CreateOrderTestV1 stored procedure with TVP
     * and address parameters
     * 
     * @param customerId         The ID of the customer
     * @param paymentId          The ID of the payment method
     * @param totalAmount        The total order amount
     * @param orderItems         List of order items with product variant IDs and
     *                           quantities
     * @param addressId          ID of the address to use or update
     * @param recipientName      Name of the recipient
     * @param recipientPhone     Phone number of the recipient
     * @param street             Street address
     * @param provinceId         Province ID
     * @param districtId         District ID
     * @param wardId             Ward ID
     * @param country            Country
     * @param itemsWithDiscounts List of product variant IDs with discounts applied
     * @return CreateOrderResponse containing the result of the operation
     */
    @Transactional
    public CreateOrderResponse createOrderTestV1(
            Integer customerId,
            Integer paymentId,
            java.math.BigDecimal totalAmount,
            List<OrderItemDTO> orderItems,
            Integer addressId,
            String recipientName,
            String recipientPhone,
            String street,
            Integer provinceId,
            Integer districtId,
            Integer wardId,
            String country,
            List<Integer> itemsWithDiscounts) {

        CreateOrderResponse response = new CreateOrderResponse();

        try {
            System.out.println("Creating order with params: customerId=" + customerId +
                    ", paymentId=" + paymentId +
                    ", totalAmount=" + totalAmount);

            System.out.println("Order items:");
            for (OrderItemDTO item : orderItems) {
                System.out.println("- product_variant_id: " + item.getProduct_variant_id() +
                        ", quantity: " + item.getQuantity());
            }

            // Kiểm tra xem có orderItems nào không
            if (orderItems == null || orderItems.isEmpty()) {
                response.setErrorCode(-1);
                response.setErrorMessage("No order items provided");
                return response;
            }

            // Lọc các orderItems không hợp lệ
            List<OrderItemDTO> validItems = orderItems.stream()
                    .filter(item -> item.getProduct_variant_id() != null && item.getProduct_variant_id() > 0
                            && item.getQuantity() > 0)
                    .toList();

            if (validItems.isEmpty()) {
                response.setErrorCode(-1);
                response.setErrorMessage("No valid order items found after filtering");
                return response;
            }

            // Convert itemsWithDiscounts to comma-separated string format
            String productVariantIds = null;
            if (itemsWithDiscounts != null && !itemsWithDiscounts.isEmpty()) {
                productVariantIds = itemsWithDiscounts.stream()
                        .map(String::valueOf)
                        .collect(Collectors.joining(","));
                System.out.println("Product variant IDs with discounts: " + productVariantIds);
            }

            // Prepare SQL to execute stored procedure
            StringBuilder sql = new StringBuilder();

            // TVP preparation
            sql.append("DECLARE @OrderItems AS dbo.OrderDetailType; ");

            // Insert items into TVP
            for (OrderItemDTO item : validItems) {
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
            if (addressId != null) {
                sql.append("@AddressId = ").append(addressId).append(", ");
            }

            if (recipientName != null) {
                sql.append("@RecipientName = N'").append(recipientName).append("', ");
            }

            if (recipientPhone != null) {
                sql.append("@RecipientPhone = '").append(recipientPhone).append("', ");
            }

            if (street != null) {
                sql.append("@Street = N'").append(street).append("', ");
            }

            if (provinceId != null) {
                sql.append("@ProvinceId = ").append(provinceId).append(", ");
            }

            if (districtId != null) {
                sql.append("@DistrictId = ").append(districtId).append(", ");
            }

            if (wardId != null) {
                sql.append("@WardId = ").append(wardId).append(", ");
            }

            if (country != null) {
                sql.append("@Country = N'").append(country).append("', ");
            }

            // Add product variant IDs with discounts
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

            System.out.println("Executing SQL: " + sql.toString());

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
            System.out.println("Stored procedure result:");
            System.out.println("Order ID: " + response.getOrderId());
            System.out.println("Error Code: " + response.getErrorCode());
            System.out.println("Error Message: " + response.getErrorMessage());

        } catch (Exception e) {
            e.printStackTrace();
            response.setErrorCode(-1);
            response.setErrorMessage("Error calling stored procedure: " + e.getMessage());
        }

        return response;
    }

    /**
     * Creates an order using the usp_CreateOrderTestV1 stored procedure
     * This overloaded method uses a SummaryOrderDTO to extract the necessary data
     * 
     * @param orderDTO The summary order DTO containing all order information
     * @return CreateOrderResponse containing the result of the operation
     */
    @Transactional
    public CreateOrderResponse createOrderTestV1(local.example.demo.model.dto.SummaryOrderDTO orderDTO) {
        try {
            // Extract customerId - needs to be converted from String to Integer
            Integer customerId = Integer.parseInt(orderDTO.getCustomerId());

            // Extract paymentId - payment method is a String in the DTO
            Integer paymentId = Integer.parseInt(orderDTO.getPayment().getMethod());

            // Extract totalAmount - convert from int to BigDecimal
            java.math.BigDecimal totalAmount = new java.math.BigDecimal(orderDTO.getOrderCalculation().getFinalTotal());

            // Extract order items
            List<OrderItemDTO> orderItems = orderDTO.getOrderItems().stream()
                    .map(item -> {
                        OrderItemDTO dto = new OrderItemDTO();
                        dto.setProduct_variant_id(item.getProduct_variant_id());
                        dto.setQuantity(item.getQuantity());
                        return dto;
                    })
                    .collect(Collectors.toList());

            // Extract address information - convert String IDs to Integer
            Integer addressId = Integer.parseInt(orderDTO.getShippingAddress().getId());
            String recipientName = orderDTO.getShippingAddress().getRecipientName();
            String recipientPhone = orderDTO.getShippingAddress().getRecipientPhone();
            String street = orderDTO.getShippingAddress().getFullAddress(); // Using fullAddress as street
            Integer provinceId = Integer.parseInt(orderDTO.getShippingAddress().getProvinceId());
            Integer districtId = Integer.parseInt(orderDTO.getShippingAddress().getDistrictId());
            Integer wardId = Integer.parseInt(orderDTO.getShippingAddress().getWardCode()); // Using wardCode as wardId
            String country = "Việt Nam"; // Default country

            // Extract product variant IDs with discounts
            List<Integer> itemsWithDiscounts = orderDTO.getOrderItems().stream()
                    .filter(item -> item.getApplied_discounts() != null && !item.getApplied_discounts().isEmpty())
                    .map(item -> item.getProduct_variant_id())
                    .collect(Collectors.toList());

            // Call the main method with all extracted parameters
            return createOrderTestV1(
                    customerId,
                    paymentId,
                    totalAmount,
                    orderItems,
                    addressId,
                    recipientName,
                    recipientPhone,
                    street,
                    provinceId,
                    districtId,
                    wardId,
                    country,
                    itemsWithDiscounts);
        } catch (Exception e) {
            e.printStackTrace();
            CreateOrderResponse response = new CreateOrderResponse();
            response.setErrorCode(-1);
            response.setErrorMessage("Error processing order data: " + e.getMessage());
            return response;
        }
    }
}
