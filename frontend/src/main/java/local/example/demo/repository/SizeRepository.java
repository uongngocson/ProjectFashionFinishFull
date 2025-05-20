package local.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import local.example.demo.model.entity.Size;

@Repository
public interface SizeRepository extends JpaRepository<Size, Integer>{
    
}
