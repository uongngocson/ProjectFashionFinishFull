package local.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import local.example.demo.model.entity.Cart;
import local.example.demo.model.entity.Customer;

@Repository
public interface CartRepository extends JpaRepository<Cart, Integer> {
    Cart findByCustomer(Customer customer);
    
}
