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
                    <!-- Tailwind CSS CDN -->
                    <script src="https://cdn.tailwindcss.com"></script>
                    <!-- Lucide Icons (untuk ikon Bot, User, Send) -->
                    <script src="https://unpkg.com/lucide/dist/umd/lucide.min.js"></script>
                    <script>
                        document.addEventListener('DOMContentLoaded', () => {
                            lucide.createIcons();
                        });
                    </script>
                </head>

                <body class="min-h-screen bg-gray-100 flex items-center justify-center z-50 p-4">
                    <div class="bg-white rounded-lg shadow-lg w-full max-w-sm overflow-hidden flex flex-col h-[500px]">
                        <!-- Header -->
                        <div class="bg-blue-600 text-white p-4 flex items-center">
                            <i data-lucide="bot" class="mr-2 w-6 h-6"></i>
                            <div>
                                <h1 class="font-bold text-lg">Simple Chatbot</h1>
                                <p class="text-xs text-blue-100">Online</p>
                            </div>
                        </div>

                        <!-- Messages Container -->
                        <div class="flex-1 overflow-y-auto p-4 space-y-4">
                            <!-- Pesan Bot Pertama (Statis) -->
                            <div class="flex justify-start">
                                <div class="max-w-[80%] rounded-lg p-3 bg-gray-200 text-gray-800 rounded-bl-none">
                                    <div class="flex items-center mb-1">
                                        <i data-lucide="bot" class="mr-1 w-4 h-4"></i>
                                        <span class="text-xs font-medium">Chatbot</span>
                                        <span class="text-xs ml-2 opacity-75">10:00</span>
                                    </div>
                                    <p>Hello! I'm your friendly chatbot. How can I help you today?</p>
                                </div>
                            </div>

                            <!-- Contoh Pesan User (Statis) -->
                            <div class="flex justify-end">
                                <div class="max-w-[80%] rounded-lg p-3 bg-blue-600 text-white rounded-br-none">
                                    <div class="flex items-center mb-1">
                                        <i data-lucide="user" class="mr-1 w-4 h-4"></i>
                                        <span class="text-xs font-medium">You</span>
                                        <span class="text-xs ml-2 opacity-75">10:01</span>
                                    </div>
                                    <p>Hi! Can you tell me more about this?</p>
                                </div>
                            </div>

                            <!-- Contoh Pesan Bot Kedua (Statis) -->
                            <div class="flex justify-start">
                                <div class="max-w-[80%] rounded-lg p-3 bg-gray-200 text-gray-800 rounded-bl-none">
                                    <div class="flex items-center mb-1">
                                        <i data-lucide="bot" class="mr-1 w-4 h-4"></i>
                                        <span class="text-xs font-medium">Chatbot</span>
                                        <span class="text-xs ml-2 opacity-75">10:02</span>
                                    </div>
                                    <p>I'm here to help! What would you like to know?</p>
                                </div>
                            </div>
                        </div>

                        <!-- Input Area -->
                        <div class="border-t border-gray-200 p-4 flex items-center">
                            <input type="text" placeholder="Type your message here..."
                                class="flex-1 border border-gray-300 rounded-l-lg py-2 px-4 focus:outline-none focus:ring-2 focus:ring-blue-500" />
                            <button
                                class="bg-blue-600 text-white p-2 rounded-r-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <i data-lucide="send" class="w-5 h-5"></i>
                            </button>
                        </div>
                    </div>
                </body>

                </html>