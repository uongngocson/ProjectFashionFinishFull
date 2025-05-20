package local.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import local.example.demo.model.entity.Address;
import local.example.demo.model.entity.Customer;

@Repository
public interface AddressRepository extends JpaRepository<Address, Integer> {
    List<Address> findByCustomer(Customer customer);

    List<Address> findByCustomerCustomerId(Integer customerId);

    void deleteByCustomer_CustomerId(Integer customerId);

    // List<Address> findByCustomerId(Integer customerId);

    @Query("SELECT a FROM Address a JOIN FETCH a.ward JOIN FETCH a.district JOIN FETCH a.province WHERE a.customer.customerId = ?1")
    List<Address> findByCustomerIdWithDetails(Integer customerId);

    // delete by customerId
    @Query("DELETE FROM Address a WHERE a.customer.customerId = ?1")
    void deleteByCustomerId(Integer customerId);
}
