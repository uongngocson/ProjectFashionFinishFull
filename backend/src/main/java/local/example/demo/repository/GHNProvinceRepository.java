package local.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import local.example.demo.model.entity.GHNProvince;

@Repository
public interface GHNProvinceRepository extends JpaRepository<GHNProvince, Integer> {
    // Các phương thức truy vấn cho tỉnh/thành phố
}