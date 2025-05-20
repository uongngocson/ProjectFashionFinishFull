package local.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import local.example.demo.model.entity.Role;

@Repository
public interface RoleRepository extends JpaRepository<Role, Integer> {
    // Define methods for CRUD operations on Role entity
    // For example:
    // List<Role> findAll();
    // Role findById(Integer id);
    // void save(Role role);
    // void deleteById(Integer id);

}
