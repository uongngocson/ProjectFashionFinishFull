package local.example.demo.controller.client;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import local.example.demo.model.entity.Address;
import local.example.demo.service.AddressService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/api/addresses")
@RequiredArgsConstructor
@Slf4j
public class AdreessCustomer {

    private final AddressService addressService;

    @GetMapping("/customer/{customerId}")
    public ResponseEntity<List<Address>> getAddressesByCustomerId(@PathVariable Integer customerId) {
        log.info("API request to get addresses for customer ID: {}", customerId);
        List<Address> addresses = addressService.getAddressesForCustomer(customerId);
        return ResponseEntity.ok(addresses);
    }

    @GetMapping("/customer/{customerId}/formatted")
    public ResponseEntity<String> getFormattedAddressesByCustomerId(@PathVariable Integer customerId) {
        log.info("API request to get formatted addresses for customer ID: {}", customerId);
        String formattedAddresses = addressService.getFormattedAddressesForCustomer(customerId);
        return ResponseEntity.ok(formattedAddresses);
    }
}
