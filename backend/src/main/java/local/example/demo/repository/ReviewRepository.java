package local.example.demo.repository;

import local.example.demo.model.entity.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Integer> {
    List<Review> findByCustomer_CustomerId(Integer customerId);
    boolean existsByCustomer_CustomerId(Integer customerId);
}