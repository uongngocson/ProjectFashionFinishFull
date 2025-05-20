package local.example.demo.service;

import org.springframework.data.jpa.domain.Specification;

import local.example.demo.model.entity.Product;

public class ProductSpecification {
    public static Specification<Product> nameBrandLike(String nameBrand) {
        return (root, query, criteriaBuilder) -> {
            return criteriaBuilder.like(root.get("nameBrand"), "%" + nameBrand + "%");
        };
        
    }
    
}
