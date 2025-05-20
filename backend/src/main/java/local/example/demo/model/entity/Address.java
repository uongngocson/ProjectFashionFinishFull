package local.example.demo.model.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Address")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Address {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "address_id")
    private Integer addressId;

    @ManyToOne
    @JoinColumn(name = "customer_id")
    private Customer customer;

    @Column(name = "street")
    private String street;

    @Column(name = "country")
    private String country;

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