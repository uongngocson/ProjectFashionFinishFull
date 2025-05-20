<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Gemini Chatbot Demo</title>
                    <script src="https://cdn.tailwindcss.com"></script>
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
                </head>

                <body class="bg-gray-50 min-h-screen">
                    <header class="bg-white shadow">
                        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6">
                            <h1 class="text-3xl font-bold text-gray-900">Gemini AI Chatbot Demo</h1>
                            <p class="mt-2 text-sm text-gray-600">Experience the power of Google's Gemini 2.0 Flash
                                model</p>
                        </div>
                    </header>

                    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-12">
                            <div class="space-y-6">
                                <div class="bg-white shadow rounded-lg p-6">
                                    <h2 class="text-xl font-semibold text-gray-900 mb-4">About This Demo</h2>
                                    <p class="text-gray-600">
                                        This chatbot is powered by Google's Gemini 2.0 Flash model, one of the most
                                        advanced AI language models available today.
                                        It can answer questions, provide information, help with tasks, and engage in
                                        natural conversations.
                                    </p>
                                </div>

                                <div class="bg-white shadow rounded-lg p-6">
                                    <h2 class="text-xl font-semibold text-gray-900 mb-4">Features</h2>
                                    <ul class="space-y-2 text-gray-600">
                                        <li class="flex items-start">
                                            <i class="fas fa-check-circle text-green-500 mt-1 mr-2"></i>
                                            <span>Fast, accurate responses to your questions</span>
                                        </li>
                                        <li class="flex items-start">
                                            <i class="fas fa-check-circle text-green-500 mt-1 mr-2"></i>
                                            <span>Natural, conversational interactions</span>
                                        </li>
                                        <li class="flex items-start">
                                            <i class="fas fa-check-circle text-green-500 mt-1 mr-2"></i>
                                            <span>Seamless integration with your existing website</span>
                                        </li>
                                        <li class="flex items-start">
                                            <i class="fas fa-check-circle text-green-500 mt-1 mr-2"></i>
                                            <span>Customizable appearance to match your brand</span>
                                        </li>
                                    </ul>
                                </div>

                                <div class="bg-white shadow rounded-lg p-6">
                                    <h2 class="text-xl font-semibold text-gray-900 mb-4">Try It Out</h2>
                                    <p class="text-gray-600 mb-4">
                                        Click the button below to open the chatbot interface in a new window.
                                    </p>
                                    <a href="${pageContext.request.contextPath}/chatbot"
                                        class="inline-flex items-center px-4 py-2 border border-transparent text-base font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                        Open Chatbot
                                        <i class="fas fa-external-link-alt ml-2"></i>
                                    </a>
                                </div>
                            </div>

                            <div class="bg-white shadow rounded-lg p-6 h-full flex flex-col">
                                <h2 class="text-xl font-semibold text-gray-900 mb-6">Sample Questions to Ask</h2>
                                <div class="grid grid-cols-1 gap-4 flex-grow">
                                    <div
                                        class="border border-gray-200 rounded-lg p-4 hover:bg-gray-50 cursor-pointer transition">
                                        <p class="font-medium text-gray-900">What can you help me with?</p>
                                        <p class="text-sm text-gray-500 mt-1">Learn about the capabilities of the
                                            chatbot</p>
                                    </div>
                                    <div
                                        class="border border-gray-200 rounded-lg p-4 hover:bg-gray-50 cursor-pointer transition">
                                        <p class="font-medium text-gray-900">Tell me about the latest fashion trends</p>
                                        <p class="text-sm text-gray-500 mt-1">Get information about current fashion</p>
                                    </div>
                                    <div
                                        class="border border-gray-200 rounded-lg p-4 hover:bg-gray-50 cursor-pointer transition">
                                        <p class="font-medium text-gray-900">How do I find the right size clothing?</p>
                                        <p class="text-sm text-gray-500 mt-1">Get sizing advice</p>
                                    </div>
                                    <div
                                        class="border border-gray-200 rounded-lg p-4 hover:bg-gray-50 cursor-pointer transition">
                                        <p class="font-medium text-gray-900">What's your return policy?</p>
                                        <p class="text-sm text-gray-500 mt-1">Learn about our store policies</p>
                                    </div>
                                    <div
                                        class="border border-gray-200 rounded-lg p-4 hover:bg-gray-50 cursor-pointer transition">
                                        <p class="font-medium text-gray-900">Can you recommend an outfit for a summer
                                            wedding?</p>
                                        <p class="text-sm text-gray-500 mt-1">Get personalized fashion advice</p>
                                    </div>
                                </div>

                                <div class="mt-6 pt-6 border-t border-gray-200">
                                    <p class="text-sm text-gray-500">
                                        Click on any question above to open the chatbot with that question pre-filled,
                                        or use the button
                                        on the left to start a new conversation.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </main>

                    <!-- Include the chatbot button -->
                    <jsp:include page="layout/chatbot-button.jsp" />

                    <script>
                        // Handle clicking on sample questions
                        document.querySelectorAll('.cursor-pointer').forEach(question => {
                            question.addEventListener('click', () => {
                                const questionText = question.querySelector('.font-medium').textContent;
                                const chatbotUrl = new URL('${pageContext.request.contextPath}/chatbot', window.location.origin);
                                chatbotUrl.searchParams.append('question', encodeURIComponent(questionText));
                                window.open(chatbotUrl.toString(), '_blank', 'width=400,height=600');
                            });
                        });
                    </script>
                </body>

                </html>