package local.example.demo.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ChatbotService {

    @Value("${gemini.api.key}")
    private String apiKey;

    private final String API_URL = "https://generativelanguage.googleapis.com/v1/models/gemini-2.0-flash:generateContent?key=";

    private final RestTemplate restTemplate = new RestTemplate();

    public String getResponse(String userMessage) {
        try {
            // Log message
            System.out.println("ChatbotService processing: " + userMessage);

            if (apiKey == null || apiKey.isEmpty()) {
                System.err.println("API key is missing. Check application.properties.");
                return "Error: API key is missing. Please configure the application properly.";
            }

            // Build request headers
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            // Build request body according to Gemini API format
            Map<String, Object> requestBody = new HashMap<>();

            // Create the content part with user's message
            Map<String, Object> part = new HashMap<>();
            part.put("text", userMessage);

            Map<String, Object> content = new HashMap<>();
            content.put("parts", List.of(part));
            content.put("role", "user");

            // Add to contents array
            requestBody.put("contents", List.of(content));

            // Configure generation parameters
            Map<String, Object> generationConfig = new HashMap<>();
            generationConfig.put("temperature", 0.7);
            generationConfig.put("maxOutputTokens", 800);
            generationConfig.put("topP", 0.95);
            requestBody.put("generationConfig", generationConfig);

            // Create HTTP request
            HttpEntity<Map<String, Object>> request = new HttpEntity<>(requestBody, headers);

            // Log API URL and key fragment for debugging
            String keyFragment = apiKey.substring(0, 5) + "...";
            System.out.println("Calling Gemini API at: " + API_URL + keyFragment);

            // Make API call
            ResponseEntity<Map> response = restTemplate.postForEntity(
                    API_URL + apiKey,
                    request,
                    Map.class);

            // Parse response
            if (response.getBody() != null) {
                Map<String, Object> responseBody = response.getBody();
                System.out.println("API response received: " + responseBody);

                // Check for error in response
                if (responseBody.containsKey("error")) {
                    Map<String, Object> error = (Map<String, Object>) responseBody.get("error");
                    String errorMessage = (String) error.get("message");
                    System.err.println("API Error: " + errorMessage);
                    return "Sorry, there was an error with the AI service: " + errorMessage;
                }

                List<Map<String, Object>> candidates = (List<Map<String, Object>>) responseBody.get("candidates");

                if (candidates != null && !candidates.isEmpty()) {
                    Map<String, Object> candidate = candidates.get(0);
                    Map<String, Object> content1 = (Map<String, Object>) candidate.get("content");
                    List<Map<String, Object>> parts = (List<Map<String, Object>>) content1.get("parts");

                    if (parts != null && !parts.isEmpty()) {
                        String responseText = (String) parts.get(0).get("text");
                        System.out.println("Gemini response: " + responseText);
                        return responseText;
                    }
                }
            }

            return "Sorry, I couldn't process your request. The response format was unexpected.";
        } catch (Exception e) {
            e.printStackTrace();
            return "Sorry, an error occurred while communicating with the AI service: " + e.getMessage();
        }
    }
}
