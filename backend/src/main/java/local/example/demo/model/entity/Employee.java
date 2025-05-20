package local.example.demo.model.entity;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Employees")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Employee {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer employeeId;

    // attributes
    @NotBlank(message = "First name cannot be blank")
    private String firstName;

    @NotBlank(message = "Last name cannot be blank")
    private String lastName;

    private String imageUrl;

    @NotBlank(message = "Address cannot be blank")
    private String address;

    @NotNull(message = "Date of birth cannot be blank")
    private LocalDate dateOfBirth;

    private boolean gender = true;

    @NotBlank(message = "Email cannot be blank")
    @Email(message = "Email must be valid")
    private String email;

    @NotBlank(message = "Phone number cannot be blank")
    private String phone;

    @NotNull(message = "Hire date cannot be blank")
    private LocalDate hireDate = LocalDate.now();

    @NotNull(message = "Salary cannot be blank")
    private BigDecimal salary;

    private boolean status = true;

    // relationships
    @OneToOne
    @JoinColumn(name = "account_id")
    @NotNull(message = "Account cannot be blank")
    private Account account;

    @ManyToOne
    @JoinColumn(name = "manager_id")
    @NotNull(message = "Manager cannot be blank")
    private Employee manager;

    public Date getHireDateAsDate() {
        if (this.hireDate == null)
            return null;
        return Date.from(this.hireDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
    }

    public Date getDateOfBirthAsDate() {
        if (this.dateOfBirth == null)
            return null;
        return Date.from(this.dateOfBirth.atStartOfDay(ZoneId.systemDefault()).toInstant());
    }

}
