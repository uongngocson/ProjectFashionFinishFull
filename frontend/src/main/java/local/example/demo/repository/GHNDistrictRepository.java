package local.example.demo.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import local.example.demo.model.entity.GHNDistrict;

@Repository
public interface GHNDistrictRepository extends JpaRepository<GHNDistrict, Integer> {
    List<GHNDistrict> findByProvinceId(Integer provinceId);
}