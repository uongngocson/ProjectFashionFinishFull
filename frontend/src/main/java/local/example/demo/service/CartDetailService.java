package local.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;
import local.example.demo.model.entity.Cart;
import local.example.demo.model.entity.CartDetail;
import local.example.demo.repository.CartDetailRepository; // ** Quan trọng: Bạn cần có Repository này **
import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class CartDetailService {

    // ** Quan trọng: Inject CartDetailRepository **
    // Đảm bảo bạn đã tạo CartDetailRepository interface kế thừa
    // JpaRepository<CartDetail, Integer>
    private final CartDetailRepository cartDetailRepository;

    @Transactional // Đảm bảo hoạt động xóa được quản lý trong một transaction
    public void removeCartItem(Integer cartDetailId) {
        // Kiểm tra xem item có tồn tại không trước khi xóa
        if (!cartDetailRepository.existsById(cartDetailId)) {
            // Ném lỗi nếu không tìm thấy, Controller sẽ bắt và trả về 404
            throw new IllegalArgumentException("Cart item not found with ID: " + cartDetailId);
        }
        // Thực hiện xóa
        cartDetailRepository.deleteById(cartDetailId);
    }

    @Transactional(readOnly = true)
    public List<CartDetail> getCartDetailsByCart(Cart cart) {
        return cartDetailRepository.findByCart(cart);
    }

    @Transactional
    public CartDetail updateCartItemQuantity(Integer cartDetailId, Integer quantity) {
        // Validate input
        if (quantity <= 0) {
            throw new IllegalArgumentException("Quantity must be greater than zero");
        }

        // Find the cart item
        CartDetail cartDetail = cartDetailRepository.findById(cartDetailId)
                .orElseThrow(() -> new IllegalArgumentException("Cart item not found with ID: " + cartDetailId));

        // Update quantity
        cartDetail.setQuantity(quantity);

        // Save and return updated entity
        return cartDetailRepository.save(cartDetail);
    }

    @Transactional(readOnly = true)
    public CartDetail findById(Integer cartDetailId) {
        return cartDetailRepository.findById(cartDetailId)
                .orElseThrow(() -> new IllegalArgumentException("Cart item not found with ID: " + cartDetailId));
    }

    // Các phương thức khác của service (nếu có)
}