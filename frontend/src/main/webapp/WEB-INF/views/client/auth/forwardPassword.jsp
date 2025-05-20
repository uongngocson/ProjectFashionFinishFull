<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>DDTS | Sign In</title>
                <script src="https://cdn.tailwindcss.com"></script>
                <c:set var="ctx" value="${pageContext.request.contextPath}" />

                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link
                    href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Montserrat:wght@300;400;500&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="${ctx}/resources/assets/client/css/login.css">
            </head>

            <body class="h-screen flex flex-col">
                <!-- Main Content -->
                <div class="flex flex-1 flex-row min-h-screen w-full overflow-hidden">
                    <!-- Left Side - Fashion Image -->
                    <div class="hidden md:block w-1/2 h-full overflow-hidden">
                        <img src="https://images.unsplash.com/photo-1539109136881-3be0616acf4b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1924&q=80"
                            alt="Fashion Model" class="w-full h-full object-cover object-center">
                    </div>

                    <!-- Right Side - Login Form -->
                    <div class="w-full md:w-1/2 flex items-center justify-center p-8 bg-white">
                        <div class="form-container w-full max-w-lg p-10 border border-gray-100 rounded-sm">
                            <div class="text-center mb-10">
                                <h1 class="playfair text-3xl mb-2">Forward Password</h1>
                                
                            </div>

                            <form action="/forwardPassword" method="post">
                                <c:if test="${param.error != null}">
                                    <div class="my-2"
                                        style="color: rgb(128, 0, 0); text-align: center; margin: 10px 0;">
                                        Invalid username 
                                    </div>
                                </c:if>
                                <p class="mb-6">
                                Please re-enter your username and email so we can send you a new password via email.
                                </p>

                                <div class="mb-6">
                                    <label for="username"
                                        class="block text-xs uppercase tracking-wider mb-2">Username</label>
                                    <input type="text" id="username" name="username"
                                        class="w-full px-0 py-2 border-b border-gray-300 focus:border-black focus:outline-none transition-colors duration-300">
                                </div>

                                <div class="mb-1">
                                    <label for="password"
                                        class="block text-xs uppercase tracking-wider mb-2">Email</label>
                                    <input type="text" id="emailForward" name="emailForward"
                                        class="w-full px-0 py-2 border-b border-gray-300 focus:border-black focus:outline-none transition-colors duration-300">
                                </div>

                                <div>
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                </div>

                                <button type="submit"
                                    class="signin-btn w-full py-3 bg-black text-white rounded-sm mb-6 transition-all duration-300">
                                    Get code
                                </button>

                                <div class="text-center mt-6">
                                    <p class="text-xs text-gray-500">Don't have an account? 
                                        <a href="/register" class="text-black hover:underline">Sign Up</a> 
                                        or 
                                        <a href="/login" class="text-black hover:underline">Sign in</a>
                                    </p>
                                    
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Footer -->
                <footer class="py-6 border-t border-gray-100">
                    <div class="max-w-7xl mx-auto px-6">
                        <div class="flex flex-col md:flex-row justify-between items-center text-sm">
                            <div class="mb-4 md:mb-0">
                                <span>© 2023 DDTS. All rights reserved.</span>
                            </div>
                            <div class="flex space-x-6">
                                <a href="#" class="hover:underline">Privacy Policy</a>
                                <a href="#" class="hover:underline">Terms of Service</a>
                                <a href="#" class="hover:underline">Contact</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </body>

            </html>