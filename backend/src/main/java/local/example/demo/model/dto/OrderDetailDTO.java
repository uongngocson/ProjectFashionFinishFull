package local.example.demo.model.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

public class OrderDetailDTO {
    private String orderId;
    private LocalDateTime orderDate;
    private BigDecimal totalAmount;
    private String orderStatus;
    private Integer paymentStatus;
    private Integer customerId;
    private String firstName;
    private String lastName;
    private String email;
    private Long orderDetailId;
    private Long productVariantId;
    private Long productId;
    private String productName;
    private String description;
    private String imageUrl;
    private Integer rating;
    private BigDecimal productPrice;
    private Integer quantity;
    private BigDecimal orderDetailPrice;
    private BigDecimal subtotal;
    // Thêm trường mới cho địa chỉ giao hàng
    private String shippingAddress;

    // Constructor
    public OrderDetailDTO(String orderId, LocalDateTime orderDate, BigDecimal totalAmount,
            String orderStatus, Integer paymentStatus, Integer customerId,
            String firstName, String lastName, String email, Long orderDetailId,
            Long productVariantId, Long productId, String productName,
            String description, String imageUrl, Integer rating,
            BigDecimal productPrice, Integer quantity, BigDecimal orderDetailPrice,
            BigDecimal subtotal, String shippingAddress) {
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.orderStatus = orderStatus;
        this.paymentStatus = paymentStatus;
        this.customerId = customerId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.orderDetailId = orderDetailId;
        this.productVariantId = productVariantId;
        this.productId = productId;
        this.productName = productName;
        this.description = description;
        this.imageUrl = imageUrl;
        this.rating = rating;
        this.productPrice = productPrice;
        this.quantity = quantity;
        this.orderDetailPrice = orderDetailPrice;
        this.subtotal = subtotal;
        this.shippingAddress = shippingAddress;
    }

    // Getters and setters
    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public Integer getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(Integer paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Long getOrderDetailId() {
        return orderDetailId;
    }

    public void setOrderDetailId(Long orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    public Long getProductVariantId() {
        return productVariantId;
    }

    public void setProductVariantId(Long productVariantId) {
        this.productVariantId = productVariantId;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Integer getRating() {
        return rating;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }

    public BigDecimal getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(BigDecimal productPrice) {
        this.productPrice = productPrice;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getOrderDetailPrice() {
        return orderDetailPrice;
    }

    public void setOrderDetailPrice(BigDecimal orderDetailPrice) {
        this.orderDetailPrice = orderDetailPrice;
    }

    public BigDecimal getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
    }

    // Getter và Setter cho địa chỉ giao hàng
    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    // Phương thức getter để chuyển đổi LocalDateTime thành Date
    public Date getOrderDateAsDate() {
        if (orderDate == null) {
            return null;
        }
        return Date.from(orderDate.atZone(ZoneId.systemDefault()).toInstant());
    }
}