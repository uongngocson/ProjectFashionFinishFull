package local.example.demo.service;

import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ProductDiscount {

    @Autowired
    private DataSource dataSource;

    public List<Map<String, Object>> getVariantsWithAccountsByProductId(int productId, Integer customerId) {
        List<Map<String, Object>> results = new ArrayList<>();

        try (Connection conn = dataSource.getConnection();
                CallableStatement stmt = conn.prepareCall("{CALL dbo.GetVariantsWithAccounts(?, ?)}")) {

            log.debug("Executing GetVariantsWithAccounts with productId: {}, customerId: {}", productId, customerId);
            stmt.setInt(1, productId);
            if (customerId != null) {
                stmt.setInt(2, customerId);
            } else {
                stmt.setNull(2, java.sql.Types.INTEGER);
            }
            boolean hasResults = stmt.execute();
            log.debug("Stored procedure execution completed, hasResults: {}", hasResults);

            if (hasResults) {
                try (ResultSet rs = stmt.getResultSet()) {
                    int rowCount = 0;
                    while (rs.next()) {
                        rowCount++;
                        Map<String, Object> row = new HashMap<>();
                        row.put("product_variant_id", rs.getInt("product_variant_id"));
                        row.put("discount_id", rs.getInt("discount_id"));
                        row.put("discount_name", rs.getString("discount_name"));
                        row.put("discount_code", rs.getString("discount_code"));
                        row.put("discount_percentage", rs.getDouble("discount_percentage"));
                        row.put("start_date", rs.getDate("start_date"));
                        row.put("end_date", rs.getDate("end_date"));
                        row.put("totalminmoney", rs.getDouble("totalminmoney"));

                        // Additional fields from the GetVariantsWithAccounts procedure
                        row.put("customer_id", rs.getObject("customer_id")); // Changed from account_id to customer_id
                        row.put("used_at", rs.getTimestamp("used_at"));
                        row.put("status", rs.getString("status"));
                        row.put("max_discount_amount", rs.getDouble("max_discount_amount"));

                        results.add(row);
                    }
                    log.debug("Retrieved {} rows from stored procedure", rowCount);
                }
            } else {
                log.warn("Stored procedure did not return a result set");
                // Try to check for more result sets
                boolean moreResults = stmt.getMoreResults();
                log.debug("Checking for more results: {}", moreResults);
                if (moreResults) {
                    try (ResultSet rs = stmt.getResultSet()) {
                        int rowCount = 0;
                        while (rs.next()) {
                            rowCount++;
                            Map<String, Object> row = new HashMap<>();
                            row.put("product_variant_id", rs.getInt("product_variant_id"));
                            row.put("discount_id", rs.getInt("discount_id"));
                            row.put("discount_name", rs.getString("discount_name"));
                            row.put("discount_code", rs.getString("discount_code"));
                            row.put("discount_percentage", rs.getDouble("discount_percentage"));
                            row.put("start_date", rs.getDate("start_date"));
                            row.put("end_date", rs.getDate("end_date"));
                            row.put("totalminmoney", rs.getDouble("totalminmoney"));

                            // Additional fields from the GetVariantsWithAccounts procedure
                            row.put("customer_id", rs.getObject("customer_id")); // Changed from account_id to
                                                                                 // customer_id
                            row.put("used_at", rs.getTimestamp("used_at"));
                            row.put("status", rs.getString("status"));
                            row.put("max_discount_amount", rs.getDouble("max_discount_amount"));

                            results.add(row);
                        }
                        log.debug("Retrieved {} rows from additional result set", rowCount);
                    }
                }
            }
        } catch (SQLException e) {
            log.error("Error executing stored procedure: {}", e.getMessage(), e);
        }

        log.info("Final result size from GetVariantsWithAccounts: {}", results.size());
        return results;
    }

    // Overloaded method to maintain backward compatibility
    public List<Map<String, Object>> getVariantsWithAccountsByProductId(int productId) {
        return getVariantsWithAccountsByProductId(productId, null);
    }
}
