package local.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.Account;

@Repository
public interface CustomerRepository extends JpaRepository<Customer, Integer> {

    boolean existsByEmail(String email);

    Customer findByAccount(Account account);

    Customer findByEmail(String email);

    Customer findByAccountLoginName(String loginName);
}
