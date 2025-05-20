package local.example.demo.model.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "GHN_Wards")
public class GHNWard {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ward_id")
    private Integer wardId;

    @Column(name = "ward_name")
    private String wardName;

    @Column(name = "district_id")
    private Integer districtId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "district_id", insertable = false, updatable = false)
    private GHNDistrict district;
}