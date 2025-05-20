<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Simple Chatbot</title>
                    <!-- For Spring Security CSRF Support -->
                    <meta name="_csrf" content="${_csrf.token}" />
                    <meta name="_csrf_header" content="${_csrf.headerName}" />
                    <!-- Tailwind CSS CDN -->
                    <script src="https://cdn.tailwindcss.com"></script>
                    <!-- Font Awesome -->
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                    <!-- jQuery -->
                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                    <!-- Application Context Path for JavaScript -->
                    <script>
                        var contextPath = '${pageContext.request.contextPath}';
                        var quickViewText = '<spring:message code="category.quickView" />';
                    </script>
                    <!-- Custom CSS -->
                    <style>
                        /* Loading animation */
                        .dot-typing {
                            position: relative;
                            width: 6px;
                            height: 6px;
                            border-radius: 5px;
                            background-color: #6B7280;
                            color: #6B7280;
                            animation: dot-typing 1.5s infinite linear;
                        }

                        .dot-typing::before,
                        .dot-typing::after {
                            content: '';
                            position: absolute;
                            top: 0;
                            left: 15px;
                            width: 6px;
                            height: 6px;
                            border-radius: 5px;
                            background-color: #6B7280;
                            color: #6B7280;
                            animation: dot-typing 1.5s infinite linear;
                            animation-delay: 0.5s;
                        }

                        .dot-typing::after {
                            left: 30px;
                            animation-delay: 1s;
                        }

                        @keyframes dot-typing {
                            0% {
                                transform: scale(1);
                                opacity: 1;
                            }

                            50% {
                                transform: scale(1.3);
                                opacity: 0.6;
                            }

                            100% {
                                transform: scale(1);
                                opacity: 1;
                            }
                        }

                        /* Message bubble styling */
                        .user-bubble {
                            background-color: #2563eb;
                            /* Blue color */
                            color: white;
                            border-radius: 18px 18px 0 18px;
                        }

                        .bot-bubble {
                            background-color: #f3f4f6;
                            /* Light gray */
                            color: #1f2937;
                            border-radius: 18px 18px 18px 0;
                        }

                        /* Error styling */
                        .error-content {
                            background-color: #fef2f2;
                            color: #b91c1c;
                            border-radius: 18px 18px 18px 0;
                            border-left: 3px solid #ef4444;
                        }

                        /* Custom scrollbar */
                        #messages-container::-webkit-scrollbar {
                            width: 8px;
                        }

                        #messages-container::-webkit-scrollbar-track {
                            background: #f1f1f1;
                        }

                        #messages-container::-webkit-scrollbar-thumb {
                            background: #c5c5c5;
                            border-radius: 4px;
                        }

                        #messages-container::-webkit-scrollbar-thumb:hover {
                            background: #a0a0a0;
                        }

                        /* Input styling */
                        #user-input:focus {
                            box-shadow: 0 0 0 2px rgba(37, 99, 235, 0.3);
                            outline: none;
                        }

                        /* Message animation */
                        @keyframes fadeIn {
                            from {
                                opacity: 0;
                                transform: translateY(8px);
                            }

                            to {
                                opacity: 1;
                                transform: translateY(0);
                            }
                        }

                        .message-animation {
                            animation: fadeIn 0.3s ease-out;
                        }

                        /* Product card styles */
                        .product-list-container {
                            display: grid;
                            grid-template-columns: repeat(2, 1fr);
                            gap: 12px;
                            margin-top: 12px;
                            width: 100%;
                        }

                        .product-card {
                            background-color: white;
                            border-radius: 8px;
                            overflow: hidden;
                            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.08);
                            transition: all 0.3s ease;
                            border: 1px solid #e5e7eb;
                            position: relative;
                            height: 100%;
                            display: flex;
                            flex-direction: column;
                        }

                        .product-card:hover {
                            transform: translateY(-3px);
                            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                            border-color: #d1d5db;
                        }

                        .product-image-container {
                            position: relative;
                            padding-top: 100%;
                            overflow: hidden;
                            background-color: #f9fafb;
                        }

                        .product-image {
                            position: absolute;
                            top: 0;
                            left: 0;
                            width: 100%;
                            height: 100%;
                            object-fit: cover;
                            transition: transform 0.5s ease;
                        }

                        .product-card:hover .product-image {
                            transform: scale(1.08);
                        }

                        .product-info {
                            padding: 10px;
                            background-color: white;
                            flex-grow: 1;
                            display: flex;
                            flex-direction: column;
                            justify-content: space-between;
                        }

                        .product-name {
                            font-weight: 500;
                            font-size: 14px;
                            margin-bottom: 6px;
                            color: #1f2937;
                            white-space: nowrap;
                            overflow: hidden;
                            text-overflow: ellipsis;
                            line-height: 1.2;
                        }

                        .product-price {
                            color: #4b5563;
                            font-size: 13px;
                            font-weight: 600;
                        }

                        .quick-view-btn {
                            position: absolute;
                            top: 50%;
                            left: 50%;
                            transform: translate(-50%, -50%);
                            background-color: white;
                            color: black;
                            padding: 8px 16px;
                            border-radius: 4px;
                            font-size: 12px;
                            font-weight: 500;
                            opacity: 0;
                            transition: all 0.3s ease;
                            border: 1px solid black;
                            z-index: 10;
                            white-space: nowrap;
                            letter-spacing: 0.5px;
                            text-transform: uppercase;
                        }

                        .quick-view-btn:hover {
                            background-color: black;
                            color: white;
                            transform: translate(-50%, -50%) scale(1.05);
                        }

                        .product-overlay {
                            position: absolute;
                            inset: 0;
                            background-color: rgba(0, 0, 0, 0.4);
                            opacity: 0;
                            transition: opacity 0.3s ease;
                        }

                        .product-card:hover .product-overlay,
                        .product-card:hover .quick-view-btn {
                            opacity: 1;
                        }

                        /* For larger product list display */
                        .products-container-large {
                            max-width: 100%;
                            border-radius: 12px;
                            overflow: hidden;
                            margin-top: 8px;
                        }

                        /* Responsive adjustments for very small screens */
                        @media (max-width: 380px) {
                            .product-list-container {
                                grid-template-columns: 1fr;
                            }

                            .quick-view-btn {
                                padding: 6px 12px;
                                font-size: 11px;
                            }
                        }
                    </style>
                </head>

                <body class="bg-gray-100 min-h-screen flex items-center justify-center p-4">
                    <div id="chatbox-container"
                        class="bg-white rounded-xl shadow-lg w-full max-w-md overflow-hidden flex flex-col h-[600px]">
                        <!-- Header -->
                        <div id="chatbox-header"
                            class="bg-gradient-to-r from-blue-600 to-blue-700 text-white p-4 flex items-center shadow-md">
                            <div id="chatbox-avatar"
                                class="w-10 h-10 bg-white/20 rounded-full flex items-center justify-center mr-3">
                                <i class="fas fa-robot text-white text-lg"></i>
                            </div>
                            <div id="chatbox-title">
                                <h1 class="font-bold text-lg">DDTS Tư Vấn Thông Minh</h1>
                                <div class="flex items-center text-xs text-blue-100">
                                    <span class="h-2 w-2 bg-green-400 rounded-full mr-2"></span>
                                    <span id="chatbox-status">Online</span>
                                </div>
                            </div>
                        </div>

                        <!-- Messages Container -->
                        <div id="messages-container" class="flex-1 overflow-y-auto p-4 space-y-6 bg-white">
                            <!-- Bot Welcome Message -->
                            <div id="welcome-message" class="flex justify-start">
                                <div class="flex flex-col max-w-[80%]">
                                    <div class="flex items-center mb-1 ml-2">
                                        <div
                                            class="w-6 h-6 bg-blue-600 rounded-full flex items-center justify-center mr-2">
                                            <i class="fas fa-robot text-white text-xs"></i>
                                        </div>
                                        <span class="text-xs font-medium">DDTS Shop</span>
                                        <span class="text-xs ml-2 opacity-75 text-gray-500" id="current-time"></span>
                                    </div>
                                    <div class="bot-bubble p-3 shadow-sm message-animation">
                                        <p>Hello! I'm your DDTS Shop AI assistant. How can I help you today?</p>
                                        <p class="text-xs mt-2 text-gray-500">You can ask me about products, or type
                                            something like "show me some shirts" or "find shoes under $100"</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Input Area -->
                        <div id="chat-input-area" class="border-t border-gray-200 bg-gray-50 p-4">
                            <div class="flex items-center">
                                <input type="text" id="user-input" placeholder="Type your message here..."
                                    class="flex-1 border border-gray-300 rounded-full py-3 px-4 focus:border-blue-500 transition-colors" />
                                <button id="send-button"
                                    class="ml-2 bg-blue-600 text-white p-3 rounded-full hover:bg-blue-700 transition-colors flex items-center justify-center w-12 h-12 shadow-sm">
                                    <i class="fas fa-paper-plane"></i>
                                </button>
                            </div>
                        </div>
                    </div>

                    <script>
                        $(document).ready(function () {
                            console.log("Chat interface initialized");

                            // Set current time for first message
                            const now = new Date();
                            const hours = now.getHours().toString().padStart(2, '0');
                            const minutes = now.getMinutes().toString().padStart(2, '0');
                            $("#current-time").text(hours + ':' + minutes);

                            // Check for pre-filled question in URL
                            const urlParams = new URLSearchParams(window.location.search);
                            const prefilledQuestion = urlParams.get('question');

                            if (prefilledQuestion) {
                                console.log("Found prefilled question:", prefilledQuestion);
                                // Fill the input with the question
                                $("#user-input").val(decodeURIComponent(prefilledQuestion));
                                // Auto-send after a short delay
                                setTimeout(function () {
                                    sendMessage();
                                }, 1000);
                            }

                            // Add user message to chat
                            function addUserMessage(message) {
                                console.log("Adding user message:", message);
                                const now = new Date();
                                const hours = now.getHours().toString().padStart(2, '0');
                                const minutes = now.getMinutes().toString().padStart(2, '0');
                                const timeString = hours + ':' + minutes;
                                const messageId = 'user-msg-' + Date.now(); // Unique ID based on timestamp

                                // Sanitize message to prevent XSS
                                const safeMessage = message
                                    .replace(/&/g, "&amp;")
                                    .replace(/</g, "&lt;")
                                    .replace(/>/g, "&gt;")
                                    .replace(/"/g, "&quot;")
                                    .replace(/'/g, "&#039;");

                                // Create message element
                                const messageDiv = document.createElement('div');
                                messageDiv.className = 'flex justify-end';
                                messageDiv.id = messageId;

                                messageDiv.innerHTML =
                                    '<div class="flex flex-col max-w-[80%] items-end user-message-container">' +
                                    '<div class="flex items-center mb-1 mr-2 user-message-header">' +
                                    '<span class="text-xs ml-2 opacity-75 text-gray-500 user-message-time">' + timeString + '</span>' +
                                    '<span class="text-xs font-medium mx-2">You</span>' +
                                    '<div class="w-6 h-6 bg-blue-600 rounded-full flex items-center justify-center user-avatar">' +
                                    '<i class="fas fa-user text-white text-xs"></i>' +
                                    '</div>' +
                                    '</div>' +
                                    '<div class="user-bubble p-3 shadow-sm message-animation user-message-content">' +
                                    '<p class="user-message-text">' + safeMessage + '</p>' +
                                    '</div>' +
                                    '</div>';

                                $("#messages-container").append(messageDiv);
                                scrollToBottom();

                                // For debugging
                                console.log("Added user message with ID:", messageId);
                                return messageId;
                            }

                            // Add bot message to chat
                            function addBotMessage(message, time) {
                                console.log("Adding bot message:", message);
                                const messageId = 'bot-msg-' + Date.now(); // Unique ID based on timestamp

                                // Sanitize message to prevent XSS
                                const safeMessage = message
                                    .replace(/&/g, "&amp;")
                                    .replace(/</g, "&lt;")
                                    .replace(/>/g, "&gt;")
                                    .replace(/"/g, "&quot;")
                                    .replace(/'/g, "&#039;");
                                console.log("Safe message:", safeMessage);

                                // Append HTML manually instead of using template literals
                                const messageDiv = document.createElement('div');
                                messageDiv.className = 'flex justify-start';
                                messageDiv.id = messageId;

                                messageDiv.innerHTML =
                                    '<div class="flex flex-col max-w-[80%] bot-message-container">' +
                                    '<div class="flex items-center mb-1 ml-2 bot-message-header">' +
                                    '<div class="w-6 h-6 bg-blue-600 rounded-full flex items-center justify-center mr-2 bot-avatar">' +
                                    '<i class="fas fa-robot text-white text-xs"></i>' +
                                    '</div>' +
                                    '<span class="text-xs font-medium">DDTS Bot</span>' +
                                    '<span class="text-xs ml-2 opacity-75 text-gray-500 bot-message-time">' + time + '</span>' +
                                    '</div>' +
                                    '<div class="bot-bubble p-3 shadow-sm message-animation bot-message-content">' +
                                    '<p class="bot-message-text">' + safeMessage + '</p>' +
                                    '</div>' +
                                    '</div>';

                                $("#messages-container").append(messageDiv);
                                scrollToBottom();

                                // For debugging
                                console.log("Added bot message with ID:", messageId);
                                return messageId;
                            }

                            // Add product results to chat
                            function addProductResults(products, time, introText) {
                                console.log("Adding product results:", products);
                                const messageId = 'products-msg-' + Date.now();
                                const now = new Date();
                                const timeString = time || now.getHours().toString().padStart(2, '0') + ':' + now.getMinutes().toString().padStart(2, '0');

                                // Create message element
                                const messageDiv = document.createElement('div');
                                messageDiv.className = 'flex justify-start';
                                messageDiv.id = messageId;

                                // Create intro text if provided
                                let introHtml = '';
                                if (introText) {
                                    introHtml = '<p class="mb-3">' + introText + '</p>';
                                }

                                // Create base message structure
                                let messageHtml =
                                    '<div class="flex flex-col w-full max-w-[90%] bot-message-container">' +
                                    '<div class="flex items-center mb-1 ml-2 bot-message-header">' +
                                    '<div class="w-6 h-6 bg-blue-600 rounded-full flex items-center justify-center mr-2 bot-avatar">' +
                                    '<i class="fas fa-robot text-white text-xs"></i>' +
                                    '</div>' +
                                    '<span class="text-xs font-medium">DDTS Bot</span>' +
                                    '<span class="text-xs ml-2 opacity-75 text-gray-500 bot-message-time">' + timeString + '</span>' +
                                    '</div>' +
                                    '<div class="bot-bubble p-3 shadow-sm message-animation bot-message-content products-container-large">' +
                                    introHtml;

                                // Add product grid
                                messageHtml += '<div class="product-list-container">';

                                // Add each product
                                products.forEach(product => {
                                    // The backend now provides consistent property names
                                    const productId = product.productId || '0';
                                    const productName = product.productName || 'Product';
                                    const price = product.price || '0.00';
                                    const imageUrl = product.imageUrl || 'https://via.placeholder.com/150';

                                    console.log("Rendering product:", { productId, productName, price });

                                    messageHtml +=
                                        '<div class="product-card">' +
                                        '<div class="product-image-container">' +
                                        '<img src="' + imageUrl + '" alt="' + productName + '" class="product-image">' +
                                        '<div class="product-overlay"></div>' +
                                        '<a href="' + contextPath + '/product/detail?id=' + productId + '"' +
                                        ' class="quick-view-btn" title="View ' + productName + '">' +
                                        quickViewText +
                                        '</a>' +
                                        '</div>' +
                                        '<div class="product-info">' +
                                        '<div class="product-name" title="' + productName + '">' + productName + '</div>' +
                                        '<div class="product-price">$' + price + '</div>' +
                                        '</div>' +
                                        '</div>';
                                });

                                messageHtml += '</div>';

                                // If no products were found
                                if (!products || products.length === 0) {
                                    messageHtml += '<p class="text-center py-4">No products found</p>';
                                }

                                // Close the message container
                                messageHtml += '</div></div>';

                                messageDiv.innerHTML = messageHtml;
                                $("#messages-container").append(messageDiv);
                                scrollToBottom();

                                return messageId;
                            }

                            // Add loading indicator
                            function addLoadingIndicator() {
                                console.log("Adding loading indicator");
                                const loadingId = 'loading-indicator'; // Use a fixed ID for the loading indicator

                                // Create loading indicator element
                                const loadingDiv = document.createElement('div');
                                loadingDiv.className = 'flex justify-start';
                                loadingDiv.id = loadingId;

                                loadingDiv.innerHTML =
                                    '<div class="flex flex-col max-w-[80%] bot-loading-container">' +
                                    '<div class="flex items-center mb-1 ml-2 bot-loading-header">' +
                                    '<div class="w-6 h-6 bg-blue-600 rounded-full flex items-center justify-center mr-2 bot-avatar">' +
                                    '<i class="fas fa-robot text-white text-xs"></i>' +
                                    '</div>' +
                                    '<span class="text-xs font-medium">DDTS Bot</span>' +
                                    '</div>' +
                                    '<div class="bot-bubble p-3 shadow-sm message-animation bot-loading-content">' +
                                    '<div class="flex items-center loading-animation-container">' +
                                    '<span class="dot-typing loading-animation"></span>' +
                                    '</div>' +
                                    '</div>' +
                                    '</div>';

                                $("#messages-container").append(loadingDiv);
                                scrollToBottom();

                                console.log("Added loading indicator with ID:", loadingId);
                                return loadingId;
                            }

                            // Error handling for bot messages
                            function addErrorMessage(errorText) {
                                const now = new Date();
                                const hours = now.getHours().toString().padStart(2, '0');
                                const minutes = now.getMinutes().toString().padStart(2, '0');
                                const timeString = hours + ':' + minutes;
                                const errorId = 'error-msg-' + Date.now();

                                const errorDiv = document.createElement('div');
                                errorDiv.className = 'flex justify-start';
                                errorDiv.id = errorId;

                                errorDiv.innerHTML =
                                    '<div class="flex flex-col max-w-[80%] error-container">' +
                                    '<div class="flex items-center mb-1 ml-2 error-header">' +
                                    '<div class="w-6 h-6 bg-red-500 rounded-full flex items-center justify-center mr-2 error-icon">' +
                                    '<i class="fas fa-exclamation-triangle text-white text-xs"></i>' +
                                    '</div>' +
                                    '<span class="text-xs font-medium">Error</span>' +
                                    '<span class="text-xs ml-2 opacity-75 text-gray-500 error-time">' + timeString + '</span>' +
                                    '</div>' +
                                    '<div class="bot-bubble p-3 shadow-sm message-animation bg-red-50 text-red-700 error-content">' +
                                    '<p class="error-text">' + errorText + '</p>' +
                                    '</div>' +
                                    '</div>';

                                $("#messages-container").append(errorDiv);
                                scrollToBottom();

                                console.log("Added error message with ID:", errorId);
                                return errorId;
                            }

                            // Remove loading indicator
                            function removeLoadingIndicator() {
                                console.log("Removing loading indicator");
                                $("#loading-indicator").remove();
                            }

                            // Scroll to bottom of container
                            function scrollToBottom() {
                                const container = document.getElementById("messages-container");
                                container.scrollTop = container.scrollHeight;
                            }

                            // Handle send button click
                            $("#send-button").click(function () {
                                console.log("Send button clicked");
                                sendMessage();
                            });

                            // Handle enter key press
                            $("#user-input").keypress(function (e) {
                                if (e.which == 13) { // Enter key
                                    console.log("Enter key pressed");
                                    sendMessage();
                                    return false;
                                }
                            });

                            // Send message function
                            function sendMessage() {
                                const userInput = $("#user-input").val().trim();

                                if (userInput === '') {
                                    console.log("Empty input, ignoring");
                                    return;
                                }

                                console.log("Sending message:", userInput);

                                // Add user message to chat
                                const userMessageId = addUserMessage(userInput);

                                // Clear input field
                                $("#user-input").val('');

                                // Show loading indicator
                                addLoadingIndicator();

                                try {
                                    // Add CSRF token for Spring Security
                                    const csrfToken = $("meta[name='_csrf']").attr("content");
                                    const csrfHeader = $("meta[name='_csrf_header']").attr("content");

                                    const headers = {};
                                    if (csrfHeader && csrfToken) {
                                        headers[csrfHeader] = csrfToken;
                                    }

                                    // Send message to server
                                    $.ajax({
                                        url: contextPath + "/chatbot/send",
                                        type: "POST",
                                        data: {
                                            message: userInput
                                        },
                                        headers: headers,
                                        success: function (response) {
                                            console.log("Response received:", response);

                                            // Remove loading indicator
                                            removeLoadingIndicator();

                                            // Check if response contains products
                                            if (response && response.products && Array.isArray(response.products)) {
                                                // Handle product search results
                                                const botMessageId = addProductResults(
                                                    response.products,
                                                    response.time || "now",
                                                    response.message || "Here are some products that match your search:"
                                                );
                                            }
                                            // Regular text response
                                            else if (response && response.message) {
                                                const botMessageId = addBotMessage(response.message, response.time || "now");
                                            }
                                            else {
                                                console.error("Invalid response format:", response);
                                                addErrorMessage("Sorry, I received an invalid response format.");
                                            }
                                        },
                                        error: function (xhr, status, error) {
                                            console.error("AJAX Error:", error);
                                            console.error("Status:", status);
                                            console.error("Response:", xhr.responseText);

                                            // Remove loading indicator
                                            removeLoadingIndicator();

                                            // Show error message
                                            addErrorMessage("Sorry, I'm having trouble connecting. Error: " + error);
                                        }
                                    });
                                } catch (e) {
                                    console.error("Exception in AJAX call:", e);

                                    // Remove loading indicator
                                    removeLoadingIndicator();

                                    // Show error message
                                    addErrorMessage("Sorry, an error occurred: " + e.message);
                                }
                            }
                        });
                    </script>
                </body>

                </html>