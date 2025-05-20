package local.example.demo.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CartQuantityUpdateResponse {
    private Integer cartDetailId;
    private Integer quantity;
    private Double totalPrice;
    private Boolean success;
    private String message;
}