package local.example.demo.model.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Accounts")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Account {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer accountId;

    // attributes
    @NotBlank(message = "Login name is required")
    private String loginName;

    @NotBlank(message = "Password is required")
    private String password;

    // relationships
    @ManyToOne(fetch = FetchType.EAGER) // EAGER (default) or LAZY (specifi)
    @JoinColumn(name = "role_id")
    private Role role;

    @OneToOne(mappedBy = "account", fetch = FetchType.LAZY)
    private Customer customer;

}
