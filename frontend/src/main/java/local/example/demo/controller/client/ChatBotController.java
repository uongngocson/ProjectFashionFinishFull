package local.example.demo.controller.client;

import local.example.demo.service.ChatbotService;
import local.example.demo.service.ProductLoadRandom;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
public class ChatBotController {

    @Autowired
    private ChatbotService chatbotService;

    @Autowired
    private ProductLoadRandom productLoadRandom;

    // Category-specific keywords for better filtering
    private final Map<String, List<String>> categoryKeywords = new HashMap<String, List<String>>() {
        {
            put("pants", List.of("quần", "quần jeans", "quần dài", "quần short", "quần đùi", "pants", "trousers",
                    "jeans", "shorts"));
            put("shirts", List.of("áo", "áo sơ mi", "áo thun", "áo khoác", "áo len", "shirt", "t-shirt", "hoodie",
                    "jacket", "sweater"));
            put("shoes", List.of("giày", "giày dép", "dép", "shoes", "sneakers", "footwear", "sandals"));
            put("accessories", List.of("phụ kiện", "mũ", "túi", "ví", "thắt lưng", "kính", "accessories", "hat", "cap",
                    "bag", "wallet", "belt", "glasses"));
        }
    };

    @GetMapping("/chatbot")
    public String chatboxPage() {
        return "client/layout/chatbox";
    }

    @GetMapping("/chatbot/demo")
    public String chatbotDemo() {
        return "client/chatbot-demo";
    }

    @GetMapping("/chatbot/test")
    public String chatbotTest() {
        return "client/chatbot-test";
    }

    @PostMapping("/chatbot/send")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> sendMessage(@RequestParam("message") String message) {
        try {
            // Log để debug
            System.out.println("Nhận được request với message: " + message);

            // Format thời gian hiện tại để hiển thị
            String currentTime = new SimpleDateFormat("HH:mm").format(new Date());

            // Check if the message is a product search query
            if (isProductQuery(message)) {
                // Extract search term from the message
                String searchTerm = extractSearchTerm(message);
                System.out.println("Extracted search term: " + searchTerm);

                // Determine the product category if possible
                String category = determineProductCategory(message);
                System.out.println("Determined category: " + (category != null ? category : "none"));

                // Get product results
                Map<String, Object> productResults = productLoadRandom.searchProductsByName(searchTerm, 1, 8, 20);
                List<Map<String, Object>> rawProducts = productLoadRandom.getProductResults(productResults);
                int totalRecords = productLoadRandom.getTotalRecords(productResults);

                System.out.println("Found " + (rawProducts != null ? rawProducts.size() : 0) + " products out of "
                        + totalRecords + " total");

                // Process and filter products based on category
                List<Map<String, Object>> processedProducts = processAndFilterProductData(rawProducts, category);
                int filteredCount = processedProducts.size();

                // Create response with products
                Map<String, Object> response = new HashMap<>();

                // Add user-friendly message
                if (processedProducts != null && !processedProducts.isEmpty()) {
                    // If we filtered by category, indicate that in the response
                    if (category != null) {
                        response.put("message",
                                "Here are some " + getCategoryDisplayName(category) + " products that match \""
                                        + searchTerm + "\". I found " + filteredCount + " products for you:");
                    } else {
                        response.put("message", "Here are some products that match \"" + searchTerm + "\". I found "
                                + totalRecords + " products in total:");
                    }
                } else {
                    if (category != null) {
                        response.put("message",
                                "I couldn't find any " + getCategoryDisplayName(category) + " products matching \""
                                        + searchTerm + "\". Try a different search term or browse our categories.");
                    } else {
                        response.put("message", "I couldn't find any products matching \"" + searchTerm
                                + "\". Try a different search term or browse our categories.");
                    }
                }

                response.put("products", processedProducts);
                response.put("time", currentTime);
                response.put("totalRecords", filteredCount);

                return ResponseEntity.ok(response);
            }

            // For non-product queries, use regular chatbot response
            String botResponse = chatbotService.getResponse(message);

            // Tạo response object
            Map<String, Object> response = new HashMap<>();
            response.put("message", botResponse);
            response.put("time", currentTime);

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            // Log lỗi
            e.printStackTrace();

            // Trả về thông báo lỗi
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("message", "Xảy ra lỗi: " + e.getMessage());
            errorResponse.put("time", new SimpleDateFormat("HH:mm").format(new Date()));

            return ResponseEntity.ok(errorResponse);
        }
    }

    /**
     * Get a user-friendly display name for a category
     */
    private String getCategoryDisplayName(String category) {
        switch (category) {
            case "pants":
                return "pants";
            case "shirts":
                return "shirts";
            case "shoes":
                return "shoes";
            case "accessories":
                return "accessories";
            default:
                return "products";
        }
    }

    /**
     * Determine the product category based on the user's query
     */
    private String determineProductCategory(String message) {
        String lowercaseMessage = message.toLowerCase();

        // Check each category's keywords
        for (Map.Entry<String, List<String>> entry : categoryKeywords.entrySet()) {
            for (String keyword : entry.getValue()) {
                if (lowercaseMessage.contains(keyword)) {
                    return entry.getKey();
                }
            }
        }

        return null; // No specific category determined
    }

    /**
     * Process raw product data and filter by category if specified
     */
    private List<Map<String, Object>> processAndFilterProductData(List<Map<String, Object>> rawProducts,
            String category) {
        if (rawProducts == null || rawProducts.isEmpty()) {
            return new ArrayList<>();
        }

        List<Map<String, Object>> processedProducts = new ArrayList<>();

        for (Map<String, Object> product : rawProducts) {
            // Create a new map for each product with consistent keys
            Map<String, Object> processedProduct = new HashMap<>();

            // Look for product ID in various possible formats
            Integer productId = null;
            if (product.containsKey("ProductID")) {
                productId = (Integer) product.get("ProductID");
            } else if (product.containsKey("productId")) {
                productId = (Integer) product.get("productId");
            } else if (product.containsKey("product_id")) {
                productId = (Integer) product.get("product_id");
            }

            // Only include products with valid IDs
            if (productId != null) {
                processedProduct.put("productId", productId);

                // Process product name
                String productName = "Product";
                if (product.containsKey("ProductName")) {
                    productName = (String) product.get("ProductName");
                } else if (product.containsKey("productName")) {
                    productName = (String) product.get("productName");
                } else if (product.containsKey("product_name")) {
                    productName = (String) product.get("product_name");
                }
                processedProduct.put("productName", productName);

                // Process price
                Object price = "0.00";
                if (product.containsKey("Price")) {
                    price = product.get("Price");
                } else if (product.containsKey("price")) {
                    price = product.get("price");
                }
                processedProduct.put("price", price);

                // Process image URL
                String imageUrl = "https://via.placeholder.com/150";
                if (product.containsKey("ImageURL")) {
                    imageUrl = (String) product.get("ImageURL");
                } else if (product.containsKey("imageUrl")) {
                    imageUrl = (String) product.get("imageUrl");
                } else if (product.containsKey("image_url")) {
                    imageUrl = (String) product.get("image_url");
                }
                processedProduct.put("imageUrl", imageUrl);

                // Category filtering: only add the product if it matches the requested category
                // or if no category filter
                if (category == null || doesProductMatchCategory(productName, category)) {
                    processedProducts.add(processedProduct);
                    System.out.println("Added product: " + productName + " to results");
                } else {
                    System.out
                            .println("Filtered out product: " + productName + " - doesn't match category: " + category);
                }
            } else {
                System.out.println("Skipping product without ID: " + product);
            }
        }

        return processedProducts;
    }

    /**
     * Check if a product name matches the specified category
     */
    private boolean doesProductMatchCategory(String productName, String category) {
        if (productName == null || category == null) {
            return false;
        }

        String lowercaseName = productName.toLowerCase();

        // Check if the product name contains any keywords for this category
        List<String> keywords = categoryKeywords.get(category);
        if (keywords != null) {
            for (String keyword : keywords) {
                if (lowercaseName.contains(keyword)) {
                    return true;
                }
            }
        }

        // Additional logic for common product naming patterns
        switch (category) {
            case "pants":
                return lowercaseName.contains("quần") ||
                        lowercaseName.contains("pant") ||
                        lowercaseName.contains("jean") ||
                        lowercaseName.contains("trouser") ||
                        lowercaseName.contains("short");
            case "shirts":
                return lowercaseName.contains("áo") ||
                        lowercaseName.contains("shirt") ||
                        lowercaseName.contains("hoodie") ||
                        lowercaseName.contains("sweater") ||
                        lowercaseName.contains("jacket");
            case "shoes":
                return lowercaseName.contains("giày") ||
                        lowercaseName.contains("dép") ||
                        lowercaseName.contains("shoe") ||
                        lowercaseName.contains("sneaker") ||
                        lowercaseName.contains("sandal");
            case "accessories":
                return lowercaseName.contains("phụ kiện") ||
                        lowercaseName.contains("mũ") ||
                        lowercaseName.contains("túi") ||
                        lowercaseName.contains("ví") ||
                        lowercaseName.contains("thắt lưng") ||
                        lowercaseName.contains("kính") ||
                        lowercaseName.contains("accessory") ||
                        lowercaseName.contains("accessorie") ||
                        lowercaseName.contains("hat") ||
                        lowercaseName.contains("cap") ||
                        lowercaseName.contains("bag") ||
                        lowercaseName.contains("wallet") ||
                        lowercaseName.contains("belt") ||
                        lowercaseName.contains("glass");
            default:
                return false;
        }
    }

    /**
     * Determines if a message is likely a product search query
     */
    private boolean isProductQuery(String message) {
        // Convert message to lowercase for case-insensitive matching
        String lowercaseMessage = message.toLowerCase();

        // Check for product search intent keywords
        String[] productKeywords = {
                "product", "products", "show me", "find", "search", "looking for",
                "where can i find", "do you have", "show", "i want", "i need",
                "i'm looking for", "recommend", "suggest", "áo", "quần", "giày", "phụ kiện",
                "túi", "mũ", "shirt", "shoes", "pants", "jacket", "hoodie", "dress",
                "what products", "display", "list", "available"
        };

        for (String keyword : productKeywords) {
            if (lowercaseMessage.contains(keyword)) {
                return true;
            }
        }

        return false;
    }

    /**
     * Extracts the search term from the message
     */
    private String extractSearchTerm(String message) {
        // Remove common prefixes that indicate product search intent
        String[] prefixes = {
                "show me ", "find ", "search for ", "looking for ", "where can i find ",
                "do you have ", "show ", "i want ", "i need ", "i'm looking for ",
                "recommend ", "suggest ", "what products ", "display ", "list "
        };

        String cleanedMessage = message;
        for (String prefix : prefixes) {
            if (message.toLowerCase().startsWith(prefix)) {
                cleanedMessage = message.substring(prefix.length());
                break;
            }
        }

        // Remove common question endings
        String[] suffixes = {
                "?", "please", "thank you", "thanks"
        };

        for (String suffix : suffixes) {
            if (cleanedMessage.toLowerCase().endsWith(suffix)) {
                cleanedMessage = cleanedMessage.substring(0,
                        cleanedMessage.length() - suffix.length()).trim();
            }
        }

        // If the cleaned message is too short, use the original message
        if (cleanedMessage.length() < 2) {
            // Extract core terms using a simple regex pattern
            Pattern pattern = Pattern.compile("\\b\\w+\\b");
            Matcher matcher = pattern.matcher(message);
            StringBuilder terms = new StringBuilder();

            while (matcher.find()) {
                String term = matcher.group();
                if (term.length() > 2 && !isStopWord(term)) {
                    if (terms.length() > 0) {
                        terms.append(" ");
                    }
                    terms.append(term);
                }
            }

            return terms.toString();
        }

        return cleanedMessage;
    }

    /**
     * Check if a word is a common stop word
     */
    private boolean isStopWord(String word) {
        String[] stopWords = {
                "the", "a", "an", "and", "or", "but", "is", "are", "was", "were",
                "for", "of", "in", "on", "at", "to", "me", "you", "he", "she", "it",
                "we", "they", "this", "that", "these", "those", "my", "your", "his",
                "her", "its", "our", "their", "do", "does", "did", "have", "has", "had",
                "by", "with", "from", "about"
        };

        String lowercaseWord = word.toLowerCase();
        for (String stopWord : stopWords) {
            if (lowercaseWord.equals(stopWord)) {
                return true;
            }
        }

        return false;
    }
}
