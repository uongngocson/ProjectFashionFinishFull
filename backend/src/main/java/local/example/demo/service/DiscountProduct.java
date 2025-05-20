
// hàm test
package local.example.demo.service;

import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class DiscountProduct {

    @Autowired
    private DataSource dataSource;

    public List<Map<String, Object>> getDiscountsByProductId(int productId) {
        List<Map<String, Object>> results = new ArrayList<>();

        try (Connection conn = dataSource.getConnection();
                CallableStatement stmt = conn.prepareCall("{CALL dbo.GetDiscountsByProductID(?)}")) {

            stmt.setInt(1, productId);
            boolean hasResults = stmt.execute();

            if (hasResults) {
                try (ResultSet rs = stmt.getResultSet()) {
                    while (rs.next()) {
                        Map<String, Object> row = new HashMap<>();
                        row.put("product_variant_id", rs.getInt("product_variant_id"));
                        row.put("discount_id", rs.getInt("discount_id"));
                        row.put("discount_name", rs.getString("discount_name"));
                        row.put("discount_code", rs.getString("discount_code"));
                        row.put("discount_percentage", rs.getDouble("discount_percentage"));
                        row.put("start_date", rs.getDate("start_date"));
                        row.put("end_date", rs.getDate("end_date"));
                        row.put("totalminmoney", rs.getDouble("totalminmoney"));

                        results.add(row);
                    }
                }
            }
        } catch (SQLException e) {
            log.error("Error executing stored procedure: {}", e.getMessage(), e);
        }

        return results;
    }
}
