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
                        overflow-x: hidden;
                        max-height: 100vh;
                        display: flex;
                        flex-direction: column;
                    }

                    .cormorant {
                        font-family: 'Cormorant Garamond', serif;
                    }

                    .form-container {
                        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.03);
                        max-height: calc(100vh - 120px);
                        overflow-y: auto;
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

                    .main-content {
                        flex: 1;
                        overflow: hidden;
                        min-height: 0;
                    }

                    .form-scroll-container {
                        overflow-y: auto;
                        max-height: 100%;
                        padding: 1rem;
                    }

                    /* Small fix for the title */
                    h1.cormorant {
                        font-weight: 600;
                    }

                    /* Responsive padding adjustments */
                    @media (max-height: 800px) {
                        .form-container {
                            padding: 1rem;
                        }
                    }
                </style>
            </head>

            <body class="h-screen">
                <!-- Main Content -->
                <div class="main-content flex flex-1">
                    <!-- Left Side - Fashion Image -->
                    <div class="hidden md:block w-1/2 h-full overflow-hidden bg-black">
                        <img src="https://images.unsplash.com/photo-1483985988355-763728e1935b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1924&q=80"
                            alt="Fashion Atelier" class="w-full h-full object-cover object-center opacity-90">
                    </div>

                    <!-- Right Side - Sign Up Form -->
                    <div class="w-full md:w-1/2 flex items-center justify-center bg-white form-scroll-container">
                        <div class="form-container w-full max-w-md p-8 border border-black rounded-sm">
                            <div class="text-center mb-6">
                                <h1 class="cormorant text-3xl mb-2 tracking-tight">Create an Account</h1>
                                <p class="text-xs text-gray-500 tracking-wider">JOIN OUR EXCLUSIVE FASHION COMMUNITY</p>
                            </div>

                            <form:form action="${pageContext.request.contextPath}/register"
                                class="form-two--item2--list1-con" method="post" modelAttribute="registerDTO">

                                <div class="form-two-icon1">
                                    <div>Đăng ký</div>
                                    <div class="form-two-icon1-item3"><i class="fa-solid fa-qrcode"></i></div>
                                </div>

                                <!-- first name -->
                                <div class="mb-4">
                                    <label for="firstName"
                                        class="block text-xs uppercase tracking-wider mb-2">Họ</label>
                                    <form:input placeholder="Họ"
                                        class="input-field w-full px-0 py-2 border-b border-gray-300 focus:outline-none"
                                        path="firstName" />
                                    <form:errors path="firstName" cssClass="text-danger" />
                                    <c:if test="${not empty errors.firstName}">
                                        <div class="text-danger">${errors.firstName}</div>
                                    </c:if>
                                </div>

                                <!-- last name -->
                                <div class="mb-4">
                                    <label for="lastName"
                                        class="block text-xs uppercase tracking-wider mb-2">Tên</label>
                                    <form:input placeholder="Tên"
                                        class="input-field w-full px-0 py-2 border-b border-gray-300 focus:outline-none"
                                        path="lastName" />
                                    <form:errors path="lastName" cssClass="text-danger" />
                                    <c:if test="${not empty errors.lastName}">
                                        <div class="text-danger">${errors.lastName}</div>
                                    </c:if>
                                </div>

                                <!-- email -->
                                <div class="mb-4">
                                    <label for="email" class="block text-xs uppercase tracking-wider mb-2">Email</label>
                                    <form:input placeholder="Email"
                                        class="input-field w-full px-0 py-2 border-b border-gray-300 focus:outline-none"
                                        path="email" />
                                    <form:errors path="email" cssClass="text-danger" />
                                    <c:if test="${not empty errors.email}">
                                        <div class="text-danger">${errors.email}</div>
                                    </c:if>
                                </div>

                                <!-- phone number -->
                                <div class="mb-4">
                                    <label for="phoneNumber" class="block text-xs uppercase tracking-wider mb-2">Số điện
                                        thoại</label>
                                    <form:input placeholder="Số điện thoại"
                                        class="input-field w-full px-0 py-2 border-b border-gray-300 focus:outline-none"
                                        path="phoneNumber" />
                                    <form:errors path="phoneNumber" cssClass="text-danger" />
                                    <c:if test="${not empty errors.phoneNumber}">
                                        <div class="text-danger">${errors.phoneNumber}</div>
                                    </c:if>
                                </div>

                                <!-- login name -->
                                <div class="mb-4">
                                    <label for="loginName" class="block text-xs uppercase tracking-wider mb-2">Tên đăng
                                        nhập</label>
                                    <form:input placeholder="Tên đăng nhập"
                                        class="input-field w-full px-0 py-2 border-b border-gray-300 focus:outline-none"
                                        path="loginName" />
                                    <form:errors path="loginName" cssClass="text-danger" />
                                    <c:if test="${not empty errors.loginName}">
                                        <div class="text-danger">${errors.loginName}</div>
                                    </c:if>
                                </div>

                                <!-- password -->
                                <div class="mb-4">
                                    <label for="password" class="block text-xs uppercase tracking-wider mb-2">Mật
                                        khẩu</label>
                                    <form:input placeholder="Mật khẩu"
                                        class="input-field w-full px-0 py-2 border-b border-gray-300 focus:outline-none"
                                        path="password" type="password" />
                                    <form:errors path="password" cssClass="text-danger" />
                                </div>

                                <!-- confirm password -->
                                <div class="mb-6">
                                    <label for="confirmPassword"
                                        class="block text-xs uppercase tracking-wider mb-2">Nhập lại mật khẩu</label>
                                    <form:input placeholder="Nhập lại mật khẩu"
                                        class="input-field w-full px-0 py-2 border-b border-gray-300 focus:outline-none"
                                        path="confirmPassword" type="password" />
                                    <form:errors path="confirmPassword" cssClass="text-danger" />
                                    <c:if test="${not empty errors.confirmPassword}">
                                        <div class="text-danger">${errors.confirmPassword}</div>
                                    </c:if>
                                </div>

                                <!-- btn register -->
                                <div class="mb-4">
                                    <button type="submit"
                                        class="signup-btn w-full py-3 bg-black text-white rounded-sm mb-4 transition-all duration-300">
                                        Đăng kí
                                    </button>
                                </div>

                                <!-- btn login -->
                                <div class="form-two-icon7">
                                    <div class="form-two-icon7-item1">Bạn đã có tài khoản?</div>
                                    <a class="form-two-icon7-item2" href="/client/auth/login">Đăng nhập</a>
                                </div>
                            </form:form>

                        </div>
                    </div>
                </div>

                <!-- Footer -->
                <footer class="py-4 border-t border-gray-100">
                    <div class="max-w-7xl mx-auto px-6">
                        <div class="flex flex-col md:flex-row justify-between items-center text-xs tracking-wider">
                            <div class="mb-2 md:mb-0">
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