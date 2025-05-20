// package local.example.demo.controller;

// import java.util.List;

// import org.springframework.http.ResponseEntity;
// import org.springframework.web.bind.annotation.GetMapping;
// import org.springframework.web.bind.annotation.RequestMapping;
// import org.springframework.web.bind.annotation.RestController;

// import local.example.demo.model.entity.Addressv2;
// import local.example.demo.service.AddressService;
// import lombok.RequiredArgsConstructor;
// import lombok.extern.slf4j.Slf4j;

// @RestController
// @RequestMapping("/api/addressv2")
// @RequiredArgsConstructor
// @Slf4j
// public class TestAddressController {

// private final AddressService addressService;

// @GetMapping("/test-query")
// public ResponseEntity<String> testAddressQuery() {
// // ID khách hàng cần truy vấn
// Integer customerId = 1017;

// log.info("Đang truy vấn địa chỉ cho khách hàng ID: {}", customerId);

// // Truy vấn địa chỉ từ bảng mới
// List<Addressv2> addresses =
// addressService.getAddressesv2ForCustomer(customerId);

// // In thông tin chi tiết ra console
// log.info("===== KẾT QUẢ TRUY VẤN ĐỊA CHỈ CHO KHÁCH HÀNG ID {} =====",
// customerId);
// log.info("Tìm thấy {} địa chỉ", addresses.size());

// StringBuilder resultBuilder = new StringBuilder();
// resultBuilder.append("Tìm thấy ").append(addresses.size()).append(" địa
// chỉ:\n");

// for (Addressv2 address : addresses) {
// String addressInfo = String.format(
// "Địa chỉ ID: %d\n" +
// "Đường: %s\n" +
// "Phường/Xã: %s (ID: %d)\n" +
// "Quận/Huyện: %s (ID: %d)\n" +
// "Tỉnh/Thành: %s (ID: %d)\n" +
// "Quốc gia: %s\n" +
// "Địa chỉ đầy đủ: %s\n" +
// "--------------------------\n",
// address.getAddressId(),
// address.getStreet(),
// address.getWard() != null ? address.getWard().getWardName() : "N/A",
// address.getWardId(),
// address.getDistrict() != null ? address.getDistrict().getDistrictName() :
// "N/A",
// address.getDistrictId(),
// address.getProvince() != null ? address.getProvince().getProvinceName() :
// "N/A",
// address.getProvinceId(),
// address.getCountry(),
// address.getFullAddress());

// log.info(addressInfo);
// resultBuilder.append(addressInfo);
// }

// log.info("===== KẾT THÚC TRUY VẤN =====");

// if (addresses.isEmpty()) {
// return ResponseEntity.ok("Không tìm thấy địa chỉ nào cho khách hàng ID: " +
// customerId);
// } else {
// return ResponseEntity.ok(resultBuilder.toString());
// }
// }
// }