package local.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import jakarta.servlet.ServletContext;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@Service
public class FileService {

    @Autowired
    private final ServletContext servletContext;

    public FileService(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    /**
     * Lưu file upload và trả về tên file đã lưu với UUID 8 ký tự
     * 
     * @param file         File cần upload
     * @param targetFolder Thư mục đích trong /resources/images
     * @return Tên file đã lưu hoặc empty string nếu thất bại
     * @throws IllegalArgumentException nếu file không hợp lệ
     * @throws IOException              nếu có lỗi I/O khi lưu file
     */
    public String handleSaveUploadFile(MultipartFile file, String targetFolder) {
        // Kiểm tra file hợp lệ
        if (file == null || file.isEmpty()) {
            return "";
        }

        try {
            // Lấy đường dẫn gốc của /resources/images
            String rootPath = servletContext.getRealPath("/resources/images-upload");
            Path targetPath = Paths.get(rootPath, targetFolder);

            // Tạo thư mục nếu chưa tồn tại
            if (!Files.exists(targetPath)) {
                Files.createDirectories(targetPath);
            }

            // Lấy tên file gốc và phần mở rộng
            String originalFileName = file.getOriginalFilename();

            // "myphoto.jpg" → substring(0, 7) → "myphoto"
            String baseName = originalFileName.contains(".")
                    ? originalFileName.substring(0, originalFileName.lastIndexOf("."))
                    : originalFileName;

            // "myphoto.jpg" → substring(7) → ".jpg"
            String fileExtension = originalFileName.contains(".")
                    ? originalFileName.substring(originalFileName.lastIndexOf("."))
                    : "";

            // Tạo tên file duy nhất với UUID 8 ký tự
            String randomUUID = UUID.randomUUID().toString().substring(0, 8); // Lấy 8 ký tự đầu
            String finalName = baseName + "-" + randomUUID + fileExtension; // Ví dụ: "myphoto-550e8400.jpg"

            // Đường dẫn đầy đủ của file
            Path filePath = targetPath.resolve(finalName);

            // Lưu file
            Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

            return finalName;

        } catch (IOException e) {
            e.printStackTrace(); // Nên thay bằng logger trong thực tế
            return "";
        }
    }

    /**
     * Kiểm tra file có hợp lệ không
     * 
     * @param file File cần kiểm tra
     * @return true nếu hợp lệ, false nếu không
     */
    public boolean isValidFile(MultipartFile file) {
        return file != null && !file.isEmpty();
    }
}
