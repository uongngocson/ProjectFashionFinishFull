package local.example.demo.service;

import java.util.List;
import java.time.LocalDateTime;
import java.util.Optional;

import org.springframework.stereotype.Service;

import local.example.demo.model.entity.Cart;
import local.example.demo.model.entity.CartDetail;
import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.ProductVariant;
import local.example.demo.repository.CartDetailRepository;
import local.example.demo.repository.CartRepository;
import local.example.demo.repository.CustomerRepository;
import local.example.demo.repository.ProductVariantRepository;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ProductVariantService {
    private final ProductVariantRepository productVariantRepository;
    private final CustomerRepository customerRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;

    public List<ProductVariant> findVariantsByProductId(Integer productId) {
        return productVariantRepository.findByProduct_ProductId(productId);
    }

    public ProductVariant findById(Integer id) {
        return productVariantRepository.findById(id).orElse(null);
    }

    public void save(ProductVariant variant) {
        productVariantRepository.save(variant);
    }

    public void deleteById(Integer id) {
        productVariantRepository.deleteById(id);
    }

    public List<ProductVariant> findAll() {
        return productVariantRepository.findAll();
    }

    // handle add to cart
    public void handleAddToCart(String email, Integer productVariantId, Integer quantity) {
        Customer customer = customerRepository.findByEmail(email);
        Cart cart = cartRepository.findByCustomer(customer);
        if (cart == null) {
            cart = new Cart();
            cart.setCustomer(customer);
            cartRepository.save(cart);
        }

        Optional<ProductVariant> productVariant = productVariantRepository.findById(productVariantId);
        if (productVariant.isPresent()) {
            ProductVariant productVariantHere = productVariant.get();
            CartDetail cartDetail = this.cartDetailRepository.findByCartAndProductVariant(cart, productVariant.get());
            if (cartDetail == null) {
                cartDetail = new CartDetail();
                cartDetail.setCart(cart);
                cartDetail.setProductVariant(productVariantHere);
                cartDetail.setPrice(productVariantHere.getProduct().getPrice());
                cartDetail.setQuantity(quantity);
                cartDetail.setAddedDate(LocalDateTime.now());
                cartDetailRepository.save(cartDetail);
            } else {
                // Update existing cart item quantity
                cartDetail.setQuantity(cartDetail.getQuantity() + quantity);
                cartDetailRepository.save(cartDetail);
            }
        }
    }
}
