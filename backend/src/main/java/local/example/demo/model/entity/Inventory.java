package local.example.demo.model.entity;

import java.math.BigDecimal;
import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Inventories")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Inventory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer inventoryId;

    @ManyToOne
    @JoinColumn(name = "supplier_id")
    @NotNull(message = "Supplier required")
    private Supplier supplier;
    // relationships
    @ManyToOne
    @JoinColumn(name = "product_id")
    @NotNull(message = "Product required")
    private Product product;

    @NotNull(message = "Price cannot be null")
    private Date importDate;

    // attribute
    @NotNull(message = "Quantity stock cannot be null")
    @Min(value = 0, message = "Quantity stock must be greater than or equal to 0")
    private Integer quantityStock;

    @NotNull(message = "Price cannot be null")
    @Min(value = 0, message = "Price must be greater than or equal to 0")
    private BigDecimal purchasePrice;
}
