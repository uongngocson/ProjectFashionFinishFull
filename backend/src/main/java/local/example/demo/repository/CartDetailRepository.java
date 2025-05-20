package local.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import local.example.demo.model.entity.Cart;
import local.example.demo.model.entity.CartDetail;
import local.example.demo.model.entity.ProductVariant;

@Repository
public interface CartDetailRepository extends JpaRepository<CartDetail, Integer> {
    // Tìm sản phẩm đã có trong giỏ hàng chưa
    CartDetail findByCartAndProductVariant(Cart cart, ProductVariant productVariant);

    // Đếm số lượng sản phẩm trong giỏ hàng
    int countByCart(Cart cart);

    // Lấy danh sách chi tiết giỏ hàng theo giỏ hàng
    List<CartDetail> findByCart(Cart cart);

    // Bạn có thể thêm các phương thức truy vấn tùy chỉnh khác ở đây nếu cần
}
