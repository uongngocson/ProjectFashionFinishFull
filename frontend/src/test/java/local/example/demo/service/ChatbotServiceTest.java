package local.example.demo.service;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@ActiveProfiles("test")
public class ChatbotServiceTest {

    @Autowired
    private ChatbotService chatbotService;

    @Test
    public void testChatbotResponse() {
        // Arrange
        String userMessage = "Hello, I'm testing the chatbot. Please respond with a simple greeting.";

        // Act
        String response = chatbotService.getResponse(userMessage);

        // Assert
        assertNotNull(response, "Response should not be null");
        assertTrue(response.length() > 0, "Response should not be empty");
        System.out.println("Chatbot Response: " + response);
    }
}