package local.example.demo.service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Service;

import local.example.demo.repository.OrderRepository;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class RevenueService {
    private final OrderRepository orderRepository;

    public List<Object[]> getMonthlyRevenue(int year) {
        return orderRepository.getRevenueByMonth(year);
    }

    public List<Object[]> getWeeklyRevenue(int year, int month) {
        return orderRepository.getRevenueByWeekInMonth(year, month);
    }

    public List<Object[]> getRevenueBetween(Date start, Date end) {
        return orderRepository.getRevenueByDateRange(start, end);
    }

    public Object getTotalRevenue() {
        return orderRepository.getTotalRevenue();
    }

    public Object[] getRevenueByDay(LocalDate date) {
        return orderRepository.getRevenueByDay(Date.valueOf(date));
    }

    public List<Object[]> getRevenueByDays() {
        return orderRepository.getRevenueByDays();
    }

    // New method: Fetch product-wise revenue for a month
    public List<Object[]> getProductRevenueByMonth(int year, int month) {
        return orderRepository.getProductRevenueByMonth(year, month);
    }

}
