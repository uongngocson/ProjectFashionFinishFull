<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>DDTS | Create Account</title>
                <script src="https://cdn.tailwindcss.com"></script>
                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link
                    href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=Montserrat:wght@300;400;500&display=swap"
                    rel="stylesheet">
                <style>
                    body {
                        font-family: 'Montserrat', sans-serif;
                        color: #333;
                        overflow: hidden;
                    }

                    .cormorant {
                        font-family: 'Cormorant Garamond', serif;
                    }

                    .form-container {
                        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.03);
                    }

                    .input-field {
                        transition: all 0.3s ease;
                    }

                    .input-field:focus {
                        border-color: #000;
                    }

                    .signup-btn:hover {
                        transform: translateY(-1px);
                        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
                    }

                    .signin-link {
                        position: relative;
                    }

                    .signin-link:after {
                        content: '';
                        position: absolute;
                        width: 0;
                        height: 1px;
                        bottom: 0;
                        left: 0;
                        background-color: #000;
                        transition: width 0.3s ease;
                    }

                    .signin-link:hover:after {
                        width: 100%;
                    }

                    .google-btn:hover {
                        box-shadow: 0 1px 2px 0 rgba(60, 64, 67, 0.1), 0 1px 3px 1px rgba(60, 64, 67, 0.15);
                    }
                </style>
            </head>

            <body class="h-screen flex flex-col bg-white">
                <!-- Main Content -->
                <div class="flex flex-1">
                    <!-- Left Side - Fashion Image -->
                    <div class="hidden md:block w-1/2 h-full overflow-hidden bg-black">
                        <img src="https://images.unsplash.com/photo-1483985988355-763728e1935b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1924&q=80"
                            alt="Fashion Atelier" class="w-full h-full object-cover object-center opacity-90">
                    </div>

                    <!-- Right Side - Sign Up Form -->
                    <div class="w-full md:w-1/2 flex items-center justify-center p-8 bg-white">
                        <div class="form-container w-full max-w-md p-12 border border-black rounded-sm">
                            <div class="text-center mb-10">
                                <h1 class="cormorant text-3xl mb-2 tracking-tight">Create an Account</h1>
                                <p class="text-xs text-gray-500 tracking-wider">JOIN OUR EXCLUSIVE FASHION COMMUNITY</p>
                            </div>

                            <form action="${pageContext.request.contextPath}/register-auth" method="post"
                                class="form-two--item2--list1-con">
                                <div class="form-two-icon1">
                                    <div>Xác nhận đăng ký</div>
                                </div>

                                <!-- Verification code -->
                                <div class="mb-6">
                                    <label for="verificationCode" class="block text-xs uppercase tracking-wider mb-2">Mã
                                        xác nhận</label>
                                    <input placeholder="Nhập mã xác nhận" id="verificationCode" name="verificationCode"
                                        class="input-field w-full px-0 py-2 border-b border-gray-300 focus:outline-none" />
                                </div>

                                <!-- CSRF Token -->
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                <!-- Error messages -->
                                <c:if test="${not empty verificationError}">
                                    <div class="text-danger" style="color: red; margin: 10px 0;">
                                        ${verificationError}
                                    </div>
                                </c:if>
                                <c:if test="${not empty message}">
                                    <div class="text-success" style="color: green; margin: 10px 0;">
                                        ${message}
                                    </div>
                                </c:if>

                                <!-- Buttons -->
                                <div class="mb-8">
                                    <button type="submit"
                                        class="signup-btn w-full py-3 bg-black text-white rounded-sm mb-6 transition-all duration-300">
                                        Xác nhận
                                    </button>
                                </div>

                                <!-- Resend verification link -->
                                <div class="form-two-icon7">
                                    <a href="${pageContext.request.contextPath}/resend-verification"
                                        class="form-two-icon4-icon1">
                                        Gửi lại mã xác nhận
                                    </a>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>

                <!-- Footer -->
                <footer class="py-6 border-t border-gray-100">
                    <div class="max-w-7xl mx-auto px-6">
                        <div class="flex flex-col md:flex-row justify-between items-center text-xs tracking-wider">
                            <div class="mb-4 md:mb-0">
                                <span>© 2023 DDTS. ALL RIGHTS RESERVED.</span>
                            </div>
                            <div class="flex space-x-6">
                                <a href="#" class="hover:underline">PRIVACY</a>
                                <a href="#" class="hover:underline">TERMS</a>
                                <a href="#" class="hover:underline">CONTACT</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </body>

            </html>