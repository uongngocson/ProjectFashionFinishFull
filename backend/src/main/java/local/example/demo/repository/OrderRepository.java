package local.example.demo.repository;

import local.example.demo.model.entity.Order;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderRepository extends JpaRepository<Order, String> {

    @Query("SELECT o FROM Order o WHERE o.customer.customerId = :customerId")
    List<Order> findByCustomerId(@Param("customerId") Integer customerId);

    @Query("SELECT o FROM Order o WHERE o.customer.customerId = :customerId")
    Page<Order> findByCustomerIdPaged(@Param("customerId") Integer customerId, Pageable pageable);

    @Query("SELECT o FROM Order o WHERE o.orderId = :orderId AND o.customer.customerId = :customerId")
    Order findByOrderIdAndCustomerId(@Param("orderId") String orderId, @Param("customerId") Integer customerId);

    @Query(value = """
            SELECT
                o.order_id,
                o.order_date,
                o.total_amount,
                o.order_status,
                o.payment_status,
                c.customer_id,
                c.first_name,
                c.last_name,
                c.email,
                od.order_detail_id,
                od.product_variant_id,
                p.product_id,
                p.product_name,
                p.description,
                p.image_url,
                p.rating,
                p.price AS product_price,
                od.quantity,
                od.price AS order_detail_price,
                (od.quantity * od.price) AS subtotal
            FROM
                Orders o
                INNER JOIN Customers c ON o.customer_id = c.customer_id
                INNER JOIN order_details od ON o.order_id = od.order_id
                LEFT JOIN Products p ON od.product_variant_id = p.product_id
            WHERE
                o.order_id = :orderId
            """, nativeQuery = true)
    List<Object[]> findOrderDetailsByOrderId(@Param("orderId") String orderId);

    // List<Order> findByCustomerId(Integer customerId);

    // 1. Tổng doanh thu
    @Query(value = "EXEC sp_GetTotalRevenue", nativeQuery = true)
    Object getTotalRevenue();

    // 2. Doanh thu theo ngày
    @Query(value = "EXEC sp_GetRevenueByDay :date", nativeQuery = true)
    Object[] getRevenueByDay(@Param("date") Date date);

    // 3. Doanh thu từng ngày (full list)
    @Query(value = "EXEC sp_GetRevenueByDays", nativeQuery = true)
    List<Object[]> getRevenueByDays();

    // 4. Doanh thu theo tháng trong năm
    @Query(value = "EXEC sp_GetRevenueByMonth :year", nativeQuery = true)
    List<Object[]> getRevenueByMonth(@Param("year") int year);

    // 5. Doanh thu theo tuần trong tháng
    @Query(value = "EXEC sp_GetRevenueByWeekInMonth :year, :month", nativeQuery = true)
    List<Object[]> getRevenueByWeekInMonth(@Param("year") int year, @Param("month") int month);

    // 6. Doanh thu từ ngày đến ngày
    @Query(value = "EXEC sp_GetRevenueByDateRange :startDate, :endDate", nativeQuery = true)
    List<Object[]> getRevenueByDateRange(@Param("startDate") Date startDate, @Param("endDate") Date endDate);

    // New method: Product-wise revenue for a given month
    @Query(value = """
            SELECT
                p.product_id,
                p.product_name,
                SUM(od.quantity * od.price) as total_revenue,
                SUM(od.quantity) as total_quantity
            FROM Orders o
            INNER JOIN order_details od ON o.order_id = od.order_id
            LEFT JOIN Products p ON od.product_variant_id = p.product_id
            WHERE YEAR(o.order_date) = :year AND MONTH(o.order_date) = :month
            GROUP BY p.product_id, p.product_name
            """, nativeQuery = true)
    List<Object[]> getProductRevenueByMonth(@Param("year") int year, @Param("month") int month);

    boolean existsByCustomer_CustomerId(Integer customerId);

    // Sửa tên phương thức ở đây
    // Tên cũ: boolean existsBySippingAddressId(Integer shippingAddressId);
    // Tên mới, giả sử Address có trường addressId:
    boolean existsByShippingAddress_AddressId(Integer shippingAddressId);

    List<Order> findByOrderStatus(String orderStatus);

}
