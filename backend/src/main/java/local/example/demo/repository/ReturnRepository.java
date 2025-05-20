package local.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import local.example.demo.model.entity.Return;

@Repository
public interface ReturnRepository extends JpaRepository<Return, Integer>{
    boolean existsByOrder_OrderId(String orderId);
}
