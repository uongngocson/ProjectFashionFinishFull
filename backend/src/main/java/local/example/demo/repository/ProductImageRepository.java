package local.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import local.example.demo.model.entity.ProductImage;
import java.util.List;

@Repository
public interface ProductImageRepository extends JpaRepository<ProductImage, Integer> {

    // Tìm tất cả ảnh của một sản phẩm
    List<ProductImage> findByProduct_ProductId(Integer productId);

    // Sắp xếp ảnh default lên đầu
    @Query("SELECT pi FROM ProductImage pi WHERE pi.product.productId = :productId ORDER BY pi.priority DESC, pi.productImageId ASC")
    List<ProductImage> findByProduct_ProductIdOrderByPriorityDesc(Integer productId);

    // Đặt tất cả ảnh của một sản phẩm thành non-default (priority=false),
    // ngoại trừ một ảnh cụ thể (nếu productImageIdToExclude được cung cấp)
    @Modifying
    @Transactional
    @Query("UPDATE ProductImage pi SET pi.priority = false WHERE pi.product.productId = :productId AND (:productImageIdToExclude IS NULL OR pi.productImageId != :productImageIdToExclude)")
    void clearDefaultImageFlagByProductIdAndExclude(@Param("productId") Integer productId,
            @Param("productImageIdToExclude") Integer productImageIdToExclude);

}
