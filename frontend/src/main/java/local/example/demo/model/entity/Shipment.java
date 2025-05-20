package local.example.demo.model.entity;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Shipments")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Shipment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer shipmentId;

    // attributes
    @NotBlank(message = "Shipment method cannot be blank")
    private String shipmentMethod;

    @NotBlank(message = "Tracking number cannot be blank")
    private String trackingNumber;

    @NotBlank(message = "Delivery status cannot be blank")
    private String deliveryStatus;

    @NotNull(message = "Shipped date cannot be blank")
    private Date shippedDate;

    @NotNull(message = "Estimated delivery date cannot be blank")
    private Date estimatedDelivery;

    // relationships
    @ManyToOne
    @JoinColumn(name = "order_id")
    private Order order;
}
