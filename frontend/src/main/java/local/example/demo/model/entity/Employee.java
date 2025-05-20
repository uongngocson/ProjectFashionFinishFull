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

    private String address;

    @NotNull(message = "Date of birth cannot be null")
    private LocalDate dateOfBirth;

    private boolean gender;

    @NotBlank(message = "Email cannot be blank")
    private String email;

    @NotBlank(message = "Phone number cannot be blank")
    private String phone;

    private LocalDate hireDate = LocalDate.now();

    @NotNull(message = "Salary cannot be null")
    private BigDecimal salary;

    private boolean status;

    // relationships
    @OneToOne
    @JoinColumn(name = "account_id")
    private Account account;

    @ManyToOne
    @JoinColumn(name = "manager_id")
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
