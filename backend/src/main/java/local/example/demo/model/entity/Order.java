package local.example.demo.model.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Orders")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String orderId;

    // attributes
    @NotNull(message = "Order date is required")
    private LocalDateTime orderDate;

    @NotNull(message = "Total amount is required")
    @Min(value = 0, message = "Total amount must be non-negative")
    private BigDecimal totalAmount;

    @NotBlank(message = "Order status is required")
    private String orderStatus;

    // relationship
    @ManyToOne
    @JoinColumn(name = "shipping_address_id")
    @NotNull(message = "Shipping address is required")
    private Address shippingAddress;

    @ManyToOne
    @JoinColumn(name = "payment_id")
    @NotNull(message = "Payment is required")
    private Payment payment;

    @Column(name = "payment_status")
    @NotNull(message = "Payment status is required")
    private Boolean paymentStatus;

    // relationship with Customer
    @ManyToOne
    @JoinColumn(name = "customer_id")
    @NotNull(message = "Customer is required")
    private Customer customer;

    public Date getOrderDateAsDate() {
        if (orderDate == null) {
            return null;
        }
        return Date.from(orderDate.atZone(ZoneId.systemDefault()).toInstant());
    }
}
