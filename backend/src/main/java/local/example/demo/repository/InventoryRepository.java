package local.example.demo.repository;

import java.sql.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import local.example.demo.model.entity.Inventory;

@Repository
public interface InventoryRepository extends JpaRepository<Inventory, Integer>{

    @Query(value = "EXEC sp_GetTotalImportValue", nativeQuery = true)
    Object getTotalImportValue();

    @Query(value = "EXEC sp_GetImportValueByDateRange :startDate, :endDate", nativeQuery = true)
    List<Object[]> getImportValueByDateRange(@Param("startDate") Date startDate, @Param("endDate") Date endDate);

    @Query(value = "EXEC sp_GetImportValueByWeekInMonth :year, :month", nativeQuery = true)
    List<Object[]> getImportValueByWeekInMonth(@Param("year") int year, @Param("month") int month);

    @Query(value = "EXEC sp_GetImportValueByMonth :year", nativeQuery = true)
    List<Object[]> getImportValueByMonth(@Param("year") int year);

    boolean existsByProduct_ProductId(Integer productId);

    List<Inventory> findByProduct_ProductId(Integer productId);

}
