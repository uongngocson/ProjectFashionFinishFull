package local.example.demo.service;

import local.example.demo.exception.OrderInUseException;
import local.example.demo.model.dto.CreateOrderResponse;
import local.example.demo.model.dto.OrderDetailDTO;
import local.example.demo.model.dto.OrderItemDTO;
import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.Order;
import local.example.demo.model.entity.OrderDetail;
import local.example.demo.repository.OrderDetailRepository;
import local.example.demo.repository.OrderRepository;
import local.example.demo.repository.ReturnRepository;
import local.example.demo.repository.ShipmentRepository;
import lombok.RequiredArgsConstructor;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;

import java.sql.Timestamp;
import java.sql.Types;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Random;

@RequiredArgsConstructor
@Service
public class OrderService {

    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final JdbcTemplate jdbcTemplate;
    private final ReturnRepository returnRepository;
    private final ShipmentRepository shipmentRepository;

    @PersistenceContext
    private EntityManager entityManager;

    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    public Page<Order> getPaginatedOrders(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return orderRepository.findAll(pageable);
    }

    public Order getOrderById(String orderId) {
        System.out.println("Fetching order with ID: " + orderId);
        return orderRepository.findById(orderId).orElse(null);
    }

    @Transactional
    public void saveOrder(Order order) {
        if (order.getOrderId() == null || order.getOrderId().isEmpty()) {
            order.setOrderId(generateRandomOrderId());
            orderRepository.save(order);
        } else {
            Order existingOrder = orderRepository.findById(order.getOrderId())
                    .orElseThrow(() -> new RuntimeException("Order not found: " + order.getOrderId()));
            existingOrder.setOrderDate(order.getOrderDate());
            existingOrder.setTotalAmount(order.getTotalAmount());
            existingOrder.setOrderStatus(order.getOrderStatus());
            existingOrder.setShippingAddress(order.getShippingAddress());
            existingOrder.setPayment(order.getPayment());
            existingOrder.setCustomer(order.getCustomer());
            orderRepository.save(existingOrder);
        }
    }

    @Transactional
    public void updateOrderStatusAndPayment(String orderId, String orderStatus, Boolean paymentStatus) {
        System.out.println("Updating order ID: " + orderId + ", orderStatus: " + orderStatus + ", paymentStatus: "
                + paymentStatus);
        Order existingOrder = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found: " + orderId));
        List<String> validStatuses = List.of("PENDING", "CONFIRMED", "SHIPPING", "COMPLETED", "CANCELLED", "RETURNED");
        if (!validStatuses.contains(orderStatus)) {
            throw new IllegalArgumentException("Invalid order status: " + orderStatus);
        }
        if (paymentStatus == null) {
            throw new IllegalArgumentException("Payment status cannot be null");
        }
        existingOrder.setOrderStatus(orderStatus);
        existingOrder.setPaymentStatus(paymentStatus);
        orderRepository.save(existingOrder);
        System.out.println("Order updated successfully: ID=" + orderId);
    }

    public void deleteOrder(String orderId) {
        if (returnRepository.existsByOrder_OrderId(orderId)) {
            throw new OrderInUseException("Cannot delete order with associated returns");
        }
        if (shipmentRepository.existsByOrder_OrderId(orderId)) {
            throw new OrderInUseException("Cannot delete order with associated shipments");
        }
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

    public Page<Order> findPaginatedOrdersByCustomer(Customer customer, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return orderRepository.findByCustomerIdPaged(customer.getCustomerId(), pageable);
    }

    @Transactional
    public void cancelOrder(String orderId, Customer customer) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new IllegalArgumentException("Đơn hàng không tồn tại"));
        if (!order.getCustomer().getCustomerId().equals(customer.getCustomerId())) {
            throw new IllegalArgumentException("Bạn không có quyền hủy đơn hàng này");
        }
        if (!order.getOrderStatus().equals("PENDING")) {
            throw new IllegalArgumentException("Chỉ có thể hủy đơn hàng ở trạng thái Pending");
        }
        order.setOrderStatus("CANCELLED"); // Cập nhật trạng thái thành "Cancel"
        orderRepository.save(order);
    }

    @SuppressWarnings("unchecked")
    public List<OrderDetailDTO> getOrderDetails(String orderId) {
        System.out.println("Thực thi sp_GetOrderDetails cho orderId: " + orderId);

        StoredProcedureQuery query = entityManager
                .createStoredProcedureQuery("sp_GetOrderDetails");
        query.registerStoredProcedureParameter("OrderId", String.class, ParameterMode.IN);
        query.setParameter("OrderId", orderId);

        List<Object[]> results = query.getResultList();
        List<OrderDetailDTO> orderDetails = results.stream().map(result -> {
            LocalDateTime orderDate = result[1] != null ? ((Timestamp) result[1]).toLocalDateTime() : null;
            Integer paymentStatus = result[4] != null ? ((Boolean) result[4] ? 1 : 0) : null;
            return new OrderDetailDTO(
                    (String) result[0], // order_id
                    orderDate, // order_date
                    (java.math.BigDecimal) result[2], // total_amount
                    (String) result[3], // order_status
                    paymentStatus, // payment_status
                    (Integer) result[5], // customer_id
                    (String) result[6], // first_name
                    (String) result[7], // last_name
                    (String) result[8], // email
                    result[9] != null ? ((Number) result[9]).longValue() : null, // order_detail_id
                    result[10] != null ? ((Number) result[10]).longValue() : null, // product_variant_id
                    result[11] != null ? ((Number) result[11]).longValue() : null, // product_id
                    (String) result[12], // product_name
                    (String) result[13], // description
                    (String) result[14], // image_url
                    result[15] != null && ((Number) result[15]).intValue() != 0
                            ? ((Number) result[15]).intValue()
                            : null, // rating
                    (java.math.BigDecimal) result[16], // product_price
                    (Integer) result[17], // quantity
                    (java.math.BigDecimal) result[18], // order_detail_price
                    (java.math.BigDecimal) result[19], // subtotal
                    (String) result[20] // shipping_address
            );
        }).toList();

        System.out.println("Số chi tiết đơn hàng lấy được: " + orderDetails.size());
        return orderDetails;
    }
}
