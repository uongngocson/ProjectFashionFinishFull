package local.example.demo.service;


import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;

import jakarta.servlet.ServletContext;
import local.example.demo.model.dto.facebook.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Service;

import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.apache.commons.io.FilenameUtils;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.URL;
import java.util.*;

@Service
public class FacebookService {
    private String pageId ;
    private String accessToken ;
    private final ServletContext servletContext;

    public FacebookService(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    public List<Post> getPosts() {
        List<Post> posts = new ArrayList<>();

        try {
            String url = "https://graph.facebook.com/" + pageId + "/posts"
                    + "?fields=id,message,created_time,attachments,permalink_url"
                    + "&access_token=" + accessToken;

            RestTemplate restTemplate = new RestTemplate();
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            
            // Thêm dòng này để xử lý tên trường snake_case
            mapper.setPropertyNamingStrategy(PropertyNamingStrategies.SNAKE_CASE);

            String jsonResponse = restTemplate.getForObject(url, String.class);
            System.out.println("=== Raw Facebook JSON ===");
            System.out.println(jsonResponse);

            FacebookReponse response = mapper.readValue(jsonResponse, FacebookReponse.class);

            if (response != null && response.getData() != null) {
                posts = response.getData();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return posts;
    }

    public String postTextToFacebook(String message) {
        try {
            String url = "https://graph.facebook.com/" + pageId + "/feed";

            Map<String, String> params = new HashMap<>();
            params.put("message", message);
            params.put("access_token", accessToken);

            RestTemplate restTemplate = new RestTemplate();
            return restTemplate.postForObject(url, params, String.class);
        } catch (Exception e) {
            return "Error posting text: " + e.getMessage();
        }
    }

    public String postPhotoToFacebook(String message, MultipartFile file) {
        try {
            String uploadDir = servletContext.getRealPath("/resources/images-upload/facebook/");
            File directory = new File(uploadDir);
            if (!directory.exists()) {
                directory.mkdirs();
            }

            String fileName = UUID.randomUUID() + "." + FilenameUtils.getExtension(file.getOriginalFilename());
            File dest = new File(uploadDir, fileName);
            file.transferTo(dest);

            String uploadUrl = "https://graph.facebook.com/" + pageId + "/photos";
            Map<String, Object> body = new LinkedHashMap<>();
            body.put("message", message);
            body.put("access_token", accessToken);
            body.put("source", new FileSystemResource(dest));

            RestTemplate restTemplate = new RestTemplate();
            return restTemplate.postForObject(uploadUrl, body, String.class);
        } catch (Exception e) {
            return "Error posting image: " + e.getMessage();
        }
    }
}
