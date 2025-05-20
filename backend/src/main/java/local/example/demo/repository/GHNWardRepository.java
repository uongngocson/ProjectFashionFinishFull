package local.example.demo.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import local.example.demo.model.entity.GHNWard;

@Repository
public interface GHNWardRepository extends JpaRepository<GHNWard, Integer> {
    List<GHNWard> findByDistrictId(Integer districtId);
}