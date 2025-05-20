package local.example.demo.model.entity;

import java.util.Date;
import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Discounts")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Discount {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer discountId;

    // attributes
    @NotBlank(message = "Discount name cannot be blank")
    private String discountName;

    private String description;

    @NotNull(message = "start date cannot blank")
    private Date startDate;

    @NotNull(message = "end date cannot blank")
    private Date endDate;

    // relationships
    @OneToMany(mappedBy = "discount")
    private List<ProductDiscount> productDiscounts;
}