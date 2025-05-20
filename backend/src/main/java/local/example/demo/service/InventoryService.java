package local.example.demo.service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import local.example.demo.repository.InventoryRepository;

@Service
public class InventoryService {

    @Autowired
    private InventoryRepository inventoryRepository;

    // Tổng giá trị nhập toàn bộ
    public Object getTotalImportValue() {
        return inventoryRepository.getTotalImportValue();
    }

    // Thống kê theo ngày trong khoảng
    public List<Object[]> getImportValueByDateRange(LocalDate start, LocalDate end) {
        return inventoryRepository.getImportValueByDateRange(Date.valueOf(start), Date.valueOf(end));
    }

    // Thống kê theo tháng trong năm
    public List<Object[]> getImportValueByMonth(int year) {
        return inventoryRepository.getImportValueByMonth(year);
    }

    // Thống kê theo tuần trong tháng
    public List<Object[]> getImportValueByWeekInMonth(int year, int month) {
        return inventoryRepository.getImportValueByWeekInMonth(year, month);
    }
}
