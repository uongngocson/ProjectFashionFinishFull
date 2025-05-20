package local.example.demo.model.entity;

import java.math.BigDecimal;
import java.util.List;

import jakarta.persistence.Entity;
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
@Table(name = "Products")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer productId;
    @NotBlank(message = "Product name cannot be blank")
    private String productName;

    private String description;

    @NotNull(message = "Price cannot be null")
    @Min(value = 0, message = "Price must be greater than or equal to 0")
    private BigDecimal price;

    @NotNull(message = "Quantity in stock cannot be null")
    @Min(value = 0, message = "Quantity sold must be greater than or equal to 0")
    private Integer quantitySold;


    @NotBlank(message = "Warranty cannot be blank")
    private String warranty;


    @NotBlank(message = "Return policy cannot be blank")
    private String returnPolicy;

    private String imageUrl;

    private Integer rating;
    

    private Boolean type;

    // relationships
    @ManyToOne
    @JoinColumn(name = "supplier_id")
    @NotNull(message = "Supplier cannot be null")
    private Supplier supplier;

    @ManyToOne
    @JoinColumn(name = "category_id")
    @NotNull(message = "Category cannot be null")
    private Category category;

    @ManyToOne
    @JoinColumn(name = "brand_id")
    @NotNull(message = "Brand cannot be null")
    private Brand brand;

    @OneToMany(mappedBy = "product")
    private List<Review> review;

    @OneToMany(mappedBy = "product")
    private List<ProductVariant> productVariant; // Đặt tên là "variants"

}
