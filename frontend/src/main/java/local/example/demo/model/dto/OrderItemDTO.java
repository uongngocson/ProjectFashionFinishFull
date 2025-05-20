package local.example.demo.model.dto;

import java.math.BigDecimal;

import local.example.demo.model.entity.ProductVariant;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class OrderItemDTO {
    private ProductVariant variant;
    private int quantity;
    private Integer product_variant_id;

    public OrderItemDTO(ProductVariant variant, int quantity) {
        this.variant = variant;
        this.quantity = quantity;
    }

    public OrderItemDTO(Integer product_variant_id, int quantity) {
        this.product_variant_id = product_variant_id;
        this.quantity = quantity;
    }

    public ProductVariant getVariant() {
        return variant;
    }

    public int getQuantity() {
        return quantity;
    }

    public BigDecimal getTotalPrice() {
        if (variant == null || variant.getProduct() == null || variant.getProduct().getPrice() == null) {
            return BigDecimal.ZERO;
        }
        return variant.getProduct().getPrice().multiply(BigDecimal.valueOf(quantity));
    }
}
