package local.example.demo.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import local.example.demo.model.entity.Cart;
import local.example.demo.model.entity.Customer;
import local.example.demo.repository.CartRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CartService {

    private final CartRepository cartRepository;

    @Transactional(readOnly = true)
    public Cart getCartByCustomer(Customer customer) {
        return cartRepository.findByCustomer(customer);
    }
}