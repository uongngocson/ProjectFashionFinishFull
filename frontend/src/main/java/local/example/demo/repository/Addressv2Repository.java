package local.example.demo.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import local.example.demo.model.entity.Addressv2;

@Repository
public interface Addressv2Repository extends JpaRepository<Addressv2, Integer> {

    List<Addressv2> findByCustomerId(Integer customerId);

    @Query("SELECT a FROM Addressv2 a JOIN FETCH a.ward JOIN FETCH a.district JOIN FETCH a.province WHERE a.customerId = ?1")
    List<Addressv2> findByCustomerIdWithDetails(Integer customerId);
}