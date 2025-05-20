package local.example.demo.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartQuantityUpdateRequest {
    private Integer cartDetailId;
    private Integer quantity;
}