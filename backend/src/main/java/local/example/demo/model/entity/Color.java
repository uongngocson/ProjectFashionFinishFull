package local.example.demo.model.entity;

import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Colors")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor

public class Color {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer colorId;

    // attributes
    @NotBlank(message = "Color name cannot be blank")
    private String colorName;

    // relationship with ProductVariant
    @OneToMany(mappedBy = "color")
    private List<ProductVariant> productVariants;

    @NotBlank(message = "Color hex cannot be blank")
    private String colorHex;


}
