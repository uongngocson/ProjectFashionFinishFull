package local.example.demo.service;

import java.time.Instant;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.Random;

import org.springframework.stereotype.Service;

import local.example.demo.model.entity.Employee;
import local.example.demo.model.entity.Order;
import local.example.demo.model.entity.OrderDetail;
import local.example.demo.model.entity.Shipment;
import local.example.demo.repository.OrderDetailRepository;
import local.example.demo.repository.OrderRepository;
import local.example.demo.repository.ShipmentRepository;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ShipperService {

    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final ShipmentRepository shipmentRepository;

    // Lấy danh sách đơn hàng có trạng thái CONFIRMED
    public List<Order> getConfirmedOrders() {
        return orderRepository.findByOrderStatus("CONFIRMED");
    }

    // Lấy chi tiết đơn hàng theo orderId
    public List<OrderDetail> getOrderDetails(String orderId) {
        return orderDetailRepository.findByOrder_OrderId(orderId);
    }

    // Lấy đơn hàng theo ID
    public Optional<Order> getOrderById(String orderId) {
        return orderRepository.findById(orderId);
    }

    // Tạo shipment mới
    public Shipment createShipment(String orderId, Employee shipper) {
        Optional<Order> orderOpt = orderRepository.findById(orderId);
        if (orderOpt.isPresent()) {
            Order order = orderOpt.get();

            // Tạo tracking number ngẫu nhiên (13 ký tự)
            String trackingNumber = generateTrackingNumber();

            Shipment shipment = new Shipment();
            shipment.setOrder(order);
            shipment.setEmployee(shipper);
            shipment.setTrackingNumber(trackingNumber);
            // shipment.setAssignedDate(Date.from(Instant.now()));
            // shipment.setStatus("SHIPPING");

            // deliveredDate sẽ được set null

            // Cập nhật trạng thái đơn hàng
            order.setOrderStatus("SHIPPING");
            orderRepository.save(order);

            return shipmentRepository.save(shipment);
        }
        return null;
    }

    // Lấy danh sách shipment của shipper
    public List<Shipment> getShipmentsByShipper(Employee shipper) {
        return shipmentRepository.findByEmployee(shipper);
    }

    // Lấy shipment theo ID
    public Optional<Shipment> getShipmentById(Integer shipmentId) {
        return shipmentRepository.findById(shipmentId);
    }

    // Cập nhật shipment
    public Shipment updateShipment(Shipment shipment) {
        return shipmentRepository.save(shipment);
    }

    // Xóa shipment
    public void deleteShipment(Integer shipmentId) {
        shipmentRepository.deleteById(shipmentId);
    }

    // Tạo tracking number ngẫu nhiên (13 ký tự)
    private String generateTrackingNumber() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        StringBuilder sb = new StringBuilder();
        Random random = new Random();

        for (int i = 0; i < 13; i++) {
            int index = random.nextInt(chars.length());
            sb.append(chars.charAt(index));
        }

        return sb.toString();
    }

    // Lưu order
    public Order saveOrder(Order order) {
        return orderRepository.save(order);
    }
}
