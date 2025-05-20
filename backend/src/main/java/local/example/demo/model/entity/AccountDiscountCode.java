package local.example.demo.model.entity;

import java.time.LocalDateTime;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "Account_Discount_Codes")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AccountDiscountCode {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="account_discount_id")
    private Integer id;
    
    private LocalDateTime usedAt;

    private String status;
    
    @ManyToOne
    @JoinColumn(name = "product_variant_id")
    private ProductVariant productVariant;

    @ManyToOne
    @JoinColumn(name = "customer_id")
    private Customer customer;
    
}
