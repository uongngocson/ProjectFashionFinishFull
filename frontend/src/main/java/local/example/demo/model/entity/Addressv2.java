package local.example.demo.model.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "Address")
public class Addressv2 {

    @Id
    @Column(name = "address_id")
    private Integer addressId;

    @Column(name = "customer_id")
    private Integer customerId;

    @Column(name = "street")
    private String street;

    @Column(name = "ward_id")
    private Integer wardId;

    @Column(name = "district_id")
    private Integer districtId;

    @Column(name = "province_id")
    private Integer provinceId;

    @Column(name = "country")
    private String country;

    // @Column(name = "recipientName", length = 100)
    // private String recipientName;

    // @Column(name = "recipientPhone", length = 15)
    // private String recipientPhone;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "ward_id", insertable = false, updatable = false)
    private GHNWard ward;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "district_id", insertable = false, updatable = false)
    private GHNDistrict district;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "province_id", insertable = false, updatable = false)
    private GHNProvince province;

    // Helper method để lấy địa chỉ đầy đủ
    public String getFullAddress() {
        StringBuilder sb = new StringBuilder();

        if (street != null && !street.isEmpty()) {
            sb.append(street);
        }

        if (ward != null && ward.getWardName() != null) {
            if (sb.length() > 0)
                sb.append(", ");
            sb.append(ward.getWardName());
        }

        if (district != null && district.getDistrictName() != null) {
            if (sb.length() > 0)
                sb.append(", ");
            sb.append(district.getDistrictName());
        }

        if (province != null && province.getProvinceName() != null) {
            if (sb.length() > 0)
                sb.append(", ");
            sb.append(province.getProvinceName());
        }

        if (country != null && !country.isEmpty()) {
            if (sb.length() > 0)
                sb.append(", ");
            sb.append(country);
        }

        return sb.toString();
    }
}