package local.example.demo.model.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Data
@Entity
@Table(name = "Suppliers")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Supplier {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer supplierId;

    @NotBlank(message = "Supplier name cannot be blank")
    private String supplierName;

    @NotBlank(message = "Contact person cannot be blank")
    private String contactPerson;

    private String logoUrl;

    @NotBlank(message = "Phone number cannot be blank")
    private String phone;

    @NotBlank(message = "Email cannot be blank")
    @Email(message = "Please provide a valid email address")
    private String email;

    @NotBlank(message = "supplier address cannot be blank")
    private String address;

    @NotNull(message = "supplier status (active/inactive) must be specified")
    private Boolean status = true;

    // relationships
    @OneToMany(mappedBy = "supplier")
    private List<Product> products;
}

