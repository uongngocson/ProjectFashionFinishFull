package local.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import local.example.demo.model.entity.Brand;
import local.example.demo.repository.BrandRepository;

@Service
public class BrandService {
    private final BrandRepository brandRepository;

    public BrandService(BrandRepository brandRepository) {
        this.brandRepository = brandRepository;
    }

    public List<Brand> findAllBrands() {
        return brandRepository.findAll();
    }

}
