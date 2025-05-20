package local.example.demo.repository;

import local.example.demo.model.entity.Order;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderRepository extends JpaRepository<Order, String> {

    @Query("SELECT o FROM Order o WHERE o.customer.id = :customerId")
    List<Order> findByCustomerId(@Param("customerId") Integer customerId);


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
}
