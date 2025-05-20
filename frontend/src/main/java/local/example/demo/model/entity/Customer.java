package local.example.demo.model.entity;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Customers")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Customer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer customerId;

    // attributes
    private String firstName;

    private String lastName;

    private String phone;

    @NotBlank(message = "Email is required")
    @Email(message = "Invalid email format")
    private String email;

    // @Past(message = "Date of birth must be in the past")
    // @NotNull(message = "Date of birth is required")
    // @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate dateOfBirth;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate registrationDate = LocalDate.now();

    private boolean gender;

    private String imageUrl;

    private boolean status = true;

    // relationships
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "account_id")
    private Account account;

    @OneToOne(mappedBy = "customer", fetch = FetchType.LAZY)
    private Cart cart;

    @OneToMany(mappedBy = "customer")
    private List<Address> addresses;

    // methods
    public Date getDateOfBirthAsDate() {
        if (this.dateOfBirth == null)
            return null;
        return Date.from(this.dateOfBirth.atStartOfDay(ZoneId.systemDefault()).toInstant());
    }

    public Date getRegistrationDateAsDate() {
        if (this.registrationDate == null)
            return null;
        return Date.from(this.registrationDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
    }

    

}
