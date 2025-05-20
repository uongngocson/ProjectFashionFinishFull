package local.example.demo.model.entity;

import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "ProductVariants")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProductVariant {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer productVariantId;

    // attributes
    @NotBlank(message = "SKU is required")
    private String SKU;

    private String imageUrl;

    @NotNull(message = "Size is required")
    @Min(value = 0, message = "Size must be greater than or equal to 0")
    private Integer quantityStock;

    // relationships
    @OneToMany(mappedBy = "productVariant", fetch = FetchType.LAZY)
    private List<OrderDetail> orderDetails;

    @OneToMany(mappedBy = "productVariant", fetch = FetchType.LAZY)
    private List<CartDetail> cartDetails;

    @ManyToOne
    @JoinColumn(name = "product_id")
    @NotNull(message = "Product is required")
    private Product product;

    @ManyToOne
    @JoinColumn(name = "size_id")
    @NotNull(message = "Size is required")
    private Size size;

    @ManyToOne
    @JoinColumn(name = "color_id")
    @NotNull(message = "Color is required")
    private Color color;

}
