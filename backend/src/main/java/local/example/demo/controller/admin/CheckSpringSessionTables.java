package local.example.demo.controller.admin;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class CheckSpringSessionTables {
    public static void main(String[] args) {
        String url = "jdbc:sqlserver://172.30.2.157:1433;databaseName=ClothesShop;encrypt=true;trustServerCertificate=true";
        String username = "sa";
        String password = "123";

        try (Connection conn = DriverManager.getConnection(url, username, password)) {
            System.out.println("Kết nối cơ sở dữ liệu thành công!");

            // Kiểm tra sự tồn tại và cấu trúc bảng
            checkTableStructure(conn, "SPRING_SESSION");
            checkTableStructure(conn, "SPRING_SESSION_ATTRIBUTES");

            // Kiểm tra dữ liệu mẫu trong bảng
            checkTableData(conn, "SPRING_SESSION");
            checkTableData(conn, "SPRING_SESSION_ATTRIBUTES");

        } catch (Exception e) {
            System.err.println("Lỗi khi kiểm tra bảng: ");
            e.printStackTrace();
        }
    }

    private static void checkTableStructure(Connection conn, String tableName) throws Exception {
        System.out.println("\nKiểm tra cấu trúc bảng: " + tableName);
        DatabaseMetaData metaData = conn.getMetaData();
        ResultSet rs = metaData.getColumns(null, null, tableName, null);

        boolean tableExists = false;
        System.out.println("Các cột trong bảng " + tableName + ":");
        while (rs.next()) {
            tableExists = true;
            String columnName = rs.getString("COLUMN_NAME");
            String columnType = rs.getString("TYPE_NAME");
            int columnSize = rs.getInt("COLUMN_SIZE");
            System.out.println("Cột: " + columnName + ", Kiểu: " + columnType + ", Kích thước: " + columnSize);
        }

        if (!tableExists) {
            System.out.println("Bảng " + tableName + " không tồn tại trong cơ sở dữ liệu!");
        } else {
            System.out.println("Bảng " + tableName + " tồn tại.");
        }
        rs.close();
    }

    private static void checkTableData(Connection conn, String tableName) throws Exception {
        System.out.println("\nKiểm tra dữ liệu trong bảng: " + tableName);
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT TOP 5 * FROM " + tableName);

        int rowCount = 0;
        while (rs.next()) {
            rowCount++;
            System.out.println("Dòng " + rowCount + ":");
            for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                String columnName = rs.getMetaData().getColumnName(i);
                Object value = rs.getObject(i);
                System.out.println("  " + columnName + ": " + value);
            }
        }

        if (rowCount == 0) {
            System.out.println("Bảng " + tableName + " không có dữ liệu.");
        } else {
            System.out.println("Bảng " + tableName + " có " + rowCount + " dòng dữ liệu (hiển thị tối đa 5 dòng).");
        }
        rs.close();
        stmt.close();
    }
}