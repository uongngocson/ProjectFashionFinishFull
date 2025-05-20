package local.example.demo.model.dto;

import java.math.BigDecimal;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * DTO for order items used in the order confirmation page
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderConfirmItemDTO {
    private String name;
    private String imageUrl;
    private BigDecimal price;
    private int quantity;
    private String color;
    private String size;
    private String style;
    private BigDecimal subtotal;
}