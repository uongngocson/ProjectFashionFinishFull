// package local.example.demo.controller;

// import org.springframework.http.ResponseEntity;
// import org.springframework.web.bind.annotation.GetMapping;
// import org.springframework.web.bind.annotation.RequestMapping;
// import org.springframework.web.bind.annotation.RestController;

// import local.example.demo.service.AddressService;
// import lombok.RequiredArgsConstructor;
// import lombok.extern.slf4j.Slf4j;

// @RestController
// @RequestMapping("/api/test")
// @RequiredArgsConstructor
// @Slf4j
// public class TestController {

// private final AddressService addressService;

// @GetMapping("/address-test")
// public ResponseEntity<String> testAddressRetrieval() {
// Integer customerId = 1003;

// log.info("Testing address retrieval for customerId: {}", customerId);

// String result = addressService.getFormattedAddressesForCustomer(customerId);

// return ResponseEntity.ok(result);
// }
// }