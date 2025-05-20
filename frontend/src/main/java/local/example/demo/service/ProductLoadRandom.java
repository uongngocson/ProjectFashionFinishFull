package local.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Service;

import javax.sql.DataSource;
import java.sql.Types;
import java.util.List;
import java.util.Map;

@Service
public class ProductLoadRandom {

    @Autowired
    private DataSource dataSource;

    public Map<String, Object> searchProductsByName(String keyword, int pageNumber, int pageSize,
            int minRequiredResults) {
        try {
            JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

            // Configure the stored procedure call
            SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTemplate)
                    .withProcedureName("usp_SearchProductsByName_Advanced_V3")
                    .withSchemaName("dbo")
                    .declareParameters(
                            new SqlParameter("Keyword", Types.NVARCHAR),
                            new SqlParameter("PageNumber", Types.INTEGER),
                            new SqlParameter("PageSize", Types.INTEGER),
                            new SqlParameter("MinRequiredResults", Types.INTEGER),
                            new SqlOutParameter("TotalRecords", Types.INTEGER));

            // Set the input parameters
            MapSqlParameterSource inParams = new MapSqlParameterSource()
                    .addValue("Keyword", keyword)
                    .addValue("PageNumber", pageNumber)
                    .addValue("PageSize", pageSize)
                    .addValue("MinRequiredResults", minRequiredResults);

            // Execute the stored procedure and return the results
            return jdbcCall.execute(inParams);
        } catch (Exception e) {
            System.out.println("Error executing stored procedure: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public int getTotalRecords(Map<String, Object> results) {
        if (results != null && results.containsKey("TotalRecords")) {
            return (Integer) results.get("TotalRecords");
        }
        return 0;
    }

    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getProductResults(Map<String, Object> results) {
        if (results != null && results.containsKey("#result-set-1")) {
            return (List<Map<String, Object>>) results.get("#result-set-1");
        }
        return null;
    }
}
