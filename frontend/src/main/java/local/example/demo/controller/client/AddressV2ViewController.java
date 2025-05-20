package local.example.demo.controller.client;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import local.example.demo.model.entity.Addressv2;
import local.example.demo.service.AddressService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/address-v2")
@RequiredArgsConstructor
@Slf4j
public class AddressV2ViewController {

    private final AddressService addressService;

    @GetMapping("/view")
    public String viewAddresses(Model model) {
        // ID khách hàng cần truy vấn
        Integer customerId = 1017;

        log.info("Đang truy vấn địa chỉ cho khách hàng ID: {}", customerId);

        // Truy vấn địa chỉ từ bảng mới
        List<Addressv2> addresses = addressService.getAddressesv2ForCustomer(customerId);

        // In thông tin chi tiết ra console
        log.info("===== KẾT QUẢ TRUY VẤN ĐỊA CHỈ CHO KHÁCH HÀNG ID {} =====", customerId);
        log.info("Tìm thấy {} địa chỉ", addresses.size());

        // Truyền danh sách địa chỉ trực tiếp đến view
        model.addAttribute("addressesV2", addresses);

        // Format địa chỉ để hiển thị trong view
        String formattedAddresses = formatAddressesForView(addresses);
        model.addAttribute("formattedAddressesV2", formattedAddresses);

        log.info("===== KẾT THÚC TRUY VẤN =====");

        // Trả về tên của view template
        return "customer/addresses-v2";
    }

    private String formatAddressesForView(List<Addressv2> addresses) {
        StringBuilder formattedAddresses = new StringBuilder();

        for (Addressv2 address : addresses) {
            formattedAddresses.append(String.format(
                    "Địa chỉ ID: %d, Đường: %s, Phường/Xã: %s, Quận/Huyện: %s, Tỉnh/Thành: %s, Quốc gia: %s<br>",
                    address.getAddressId(),
                    address.getStreet(),
                    address.getWard() != null ? address.getWard().getWardName() : "N/A",
                    address.getDistrict() != null ? address.getDistrict().getDistrictName() : "N/A",
                    address.getProvince() != null ? address.getProvince().getProvinceName() : "N/A",
                    address.getCountry()));
        }

        return formattedAddresses.toString();
    }
}