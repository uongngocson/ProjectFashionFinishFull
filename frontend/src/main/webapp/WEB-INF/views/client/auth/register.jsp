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
        }

        .cormorant {
            font-family: 'Cormorant Garamond', serif;
        }

        .input-field:focus {
            border-color: #000;
        }
    </style>
</head>

<body class="min-h-screen bg-gray-50">
    <div class="flex flex-col min-h-screen">
        <!-- Main Content -->
        <div class="flex flex-1">
            <!-- Left Side - Fashion Image (hidden on mobile) -->
            <div class="hidden md:block md:w-1/2 bg-black">
                <img src="https://images.unsplash.com/photo-1483985988355-763728e1935b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1924&q=80"
                    alt="Fashion Atelier" class="w-full h-full object-cover object-center opacity-90">
            </div>

            <!-- Right Side - Sign Up Form -->
            <div class="w-full md:w-1/2 flex items-center justify-center bg-white overflow-y-auto">
                <div class="w-full max-w-md p-4 md:p-8">
                    <div class="text-center mb-6">
                        <h1 class="cormorant text-3xl mb-2 tracking-tight">Create an Account</h1>
                        <p class="text-xs text-gray-500 tracking-wider">JOIN OUR EXCLUSIVE FASHION COMMUNITY</p>
                    </div>

                    <form:form action="${pageContext.request.contextPath}/register"
                        class="space-y-4" method="post" modelAttribute="registerDTO">

                        <!-- first name -->
                        <div>
                            <label for="firstName"
                                class="block text-xs uppercase tracking-wider mb-2">Họ</label>
                            <form:input placeholder="Họ"
                                class="w-full px-0 py-2 border-b border-gray-300 focus:outline-none focus:border-black"
                                path="firstName" />
                            <form:errors path="firstName" cssClass="text-red-600 text-sm mt-1" />
                            <c:if test="${not empty errors.firstName}">
                                <div class="text-red-600 bg-red-100 p-2 rounded mt-2 text-sm">${errors.firstName}</div>
                            </c:if>
                        </div>

                        <!-- last name -->
                        <div>
                            <label for="lastName"
                                class="block text-xs uppercase tracking-wider mb-2">Tên</label>
                            <form:input placeholder="Tên"
                                class="w-full px-0 py-2 border-b border-gray-300 focus:outline-none focus:border-black"
                                path="lastName" />
                            <form:errors path="lastName" cssClass="text-red-600 text-sm mt-1" />
                            <c:if test="${not empty errors.lastName}">
                                <div class="text-red-600 bg-red-100 p-2 rounded mt-2 text-sm">${errors.lastName}</div>
                            </c:if>
                        </div>

                        <!-- email -->
                        <div>
                            <label for="email" class="block text-xs uppercase tracking-wider mb-2">Email</label>
                            <form:input placeholder="Email"
                                class="w-full px-0 py-2 border-b border-gray-300 focus:outline-none focus:border-black"
                                path="email" />
                            <form:errors path="email" cssClass="text-red-600 text-sm mt-1" />
                            <c:if test="${not empty errors.email}">
                                <div class="text-red-600 bg-red-100 p-2 rounded mt-2 text-sm">${errors.email}</div>
                            </c:if>
                        </div>

                        <!-- phone number -->
                        <div>
                            <label for="phoneNumber" class="block text-xs uppercase tracking-wider mb-2">Số điện
                                thoại</label>
                            <form:input placeholder="Số điện thoại"
                                class="w-full px-0 py-2 border-b border-gray-300 focus:outline-none focus:border-black"
                                path="phoneNumber" />
                            <form:errors path="phoneNumber" cssClass="text-red-600 text-sm mt-1" />
                            <c:if test="${not empty errors.phoneNumber}">
                                <div class="text-red-600 bg-red-100 p-2 rounded mt-2 text-sm">${errors.phoneNumber}</div>
                            </c:if>
                        </div>

                        <!-- login name -->
                        <div>
                            <label for="loginName" class="block text-xs uppercase tracking-wider mb-2">Tên đăng
                                nhập</label>
                            <form:input placeholder="Tên đăng nhập"
                                class="w-full px-0 py-2 border-b border-gray-300 focus:outline-none focus:border-black"
                                path="loginName" />
                            <form:errors path="loginName" cssClass="text-red-600 text-sm mt-1" />
                            <c:if test="${not empty errors.loginName}">
                                <div class="text-red-600 bg-red-100 p-2 rounded mt-2 text-sm">${errors.loginName}</div>
                            </c:if>
                        </div>

                        <!-- password -->
                        <div>
                            <label for="password" class="block text-xs uppercase tracking-wider mb-2">Mật
                                khẩu</label>
                            <form:input placeholder="Mật khẩu"
                                class="w-full px-0 py-2 border-b border-gray-300 focus:outline-none focus:border-black"
                                path="password" type="password" />
                            <form:errors path="password" cssClass="text-red-600 text-sm mt-1" />
                        </div>

                        <!-- confirm password -->
                        <div>
                            <label for="confirmPassword"
                                class="block text-xs uppercase tracking-wider mb-2">Nhập lại mật khẩu</label>
                            <form:input placeholder="Nhập lại mật khẩu"
                                class="w-full px-0 py-2 border-b border-gray-300 focus:outline-none focus:border-black"
                                path="confirmPassword" type="password" />
                            <form:errors path="confirmPassword" cssClass="text-red-600 text-sm mt-1" />
                            <c:if test="${not empty errors.confirmPassword}">
                                <div class="text-red-600 bg-red-100 p-2 rounded mt-2 text-sm">${errors.confirmPassword}</div>
                            </c:if>
                        </div>

                        <!-- btn register -->
                        <div class="pt-4">
                            <button type="submit"
                                class="w-full py-3 bg-black text-white rounded-sm hover:bg-gray-800 transition-colors">
                                Đăng kí
                            </button>
                        </div>

                        <!-- btn login -->
                        <div class="flex items-center justify-center text-sm pt-2">
                            <div class="text-gray-600">Bạn đã có tài khoản?</div>
                            <a class="ml-2 text-black hover:underline" href="/login">Đăng nhập</a>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer class="py-4 border-t border-gray-100 bg-white">
            <div class="container mx-auto px-6">
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
    </div>
</body>

</html>