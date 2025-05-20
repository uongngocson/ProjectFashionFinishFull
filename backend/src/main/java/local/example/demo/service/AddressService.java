package local.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import local.example.demo.model.entity.Address;
import local.example.demo.repository.AddressRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Service
@Slf4j
public class AddressService {

    private final CustomerService customerService;
    private final AddressRepository addressRepository;

    /**
     * Retrieves addresses for a customer and formats them as a string
     * 
     * @param customerId The ID of the customer
     * @return Formatted string with address details
     */
    public String getFormattedAddressesForCustomer(Integer customerId) {
        log.info("Retrieving addresses for customerId: {}", customerId);

        // Lấy địa chỉ từ bảng mới với thông tin chi tiết
        List<Address> addresses = addressRepository.findByCustomerIdWithDetails(customerId);

        StringBuilder result = new StringBuilder();
        result.append("Retrieved ").append(addresses.size()).append(" addresses for customerId ").append(customerId)
                .append(":\n");

        for (Address address : addresses) {
            result.append("\nAddress ID: ").append(address.getAddressId())
                    .append("\nStreet: ").append(address.getStreet())
                    .append("\nWard: ").append(address.getWard() != null ? address.getWard().getWardName() : "N/A")
                    .append("\nDistrict: ")
                    .append(address.getDistrict() != null ? address.getDistrict().getDistrictName() : "N/A")
                    .append("\nProvince: ")
                    .append(address.getProvince() != null ? address.getProvince().getProvinceName() : "N/A")
                    .append("\nCountry: ").append(address.getCountry())
                    .append("\n-----------------------");

            log.info("Address found: ID={}, Street={}, Ward={}, District={}, Province={}, Country={}",
                    address.getAddressId(),
                    address.getStreet(),
                    address.getWard() != null ? address.getWard().getWardName() : "N/A",
                    address.getDistrict() != null ? address.getDistrict().getDistrictName() : "N/A",
                    address.getProvince() != null ? address.getProvince().getProvinceName() : "N/A",
                    address.getCountry());
        }

        if (addresses.isEmpty()) {
            log.info("No addresses found for customerId: {}", customerId);
        }

        return result.toString();
    }

    /**
     * Retrieves the list of addresses for a customer
     * 
     * @param customerId The ID of the customer
     * @return List of addresses for the customer
     */
    public List<Address> getAddressesForCustomer(Integer customerId) {
        log.info("Retrieving addresses for customerId: {}", customerId);

        // Gọi phương thức cũ để giữ nguyên logic hiện tại
        return customerService.findAddressesByCustomerId(customerId);
    }

    /**
     * Retrieves the list of new addresses (addressv2) for a customer
     * 
     * @param customerId The ID of the customer
     * @return List of new addresses for the customer
     */
    public List<Address> getAddressesv2ForCustomer(Integer customerId) {
        log.info("Retrieving addressesv2 for customerId: {}", customerId);
        return addressRepository.findByCustomerIdWithDetails(customerId);
    }
}
