package local.example.demo.model.entity;

import java.time.Instant;
import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
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

    @NotBlank(message = "Tracking number cannot be blank")
    private String trackingNumber;

    @NotBlank(message = "Delivery status cannot be blank")
    private String status;

    @NotNull(message = "Shipped date cannot be blank")
    private Date assignedDate;

    private Date deliveredDate;

    // relationships
    @ManyToOne
    @JoinColumn(name = "order_id")
    @NotNull(message = "Order cannot be blank")
    private Order order;

    @ManyToOne
    @JoinColumn(name = "shipper_id")
    @NotNull(message = "Shipper cannot be blank")
    private Employee employee;

    // functions - auto generate assigned date and status
    @PrePersist // create
    public void prePersist() {
        if (assignedDate == null) {
            assignedDate = Date.from(Instant.now());
        }
        if (status == null) {
            status = "SHIPPING";
        }
    }

    @PreUpdate // update
    public void preUpdate() {
        deliveredDate = Date.from(Instant.now());
    }
}
