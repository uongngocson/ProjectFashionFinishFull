package local.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import local.example.demo.model.entity.AccountDiscountCode;

@Repository
public interface AccountDiscountCodeRepository extends JpaRepository<AccountDiscountCode, Integer> {

    void deleteByCustomer_CustomerId(Integer customerId);
    
}
