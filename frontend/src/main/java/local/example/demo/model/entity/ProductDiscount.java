package local.example.demo.model.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "ProductDiscounts")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProductDiscount {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer productDiscountId;

    // attribute
    @NotNull(message = "Product cannot be blank")
    private Double discountPercentage;

    // relationship with product
    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    // relationship with discount
    @ManyToOne
    @JoinColumn(name = "discount_id")
    private Discount discount;

}