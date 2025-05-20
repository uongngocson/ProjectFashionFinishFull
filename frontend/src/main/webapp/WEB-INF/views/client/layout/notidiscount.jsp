<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

                <!-- Navigation -->
                <!-- <nav class="fixed w-full z-50 bg-white bg-opacity-90 border-b border-gray-100">
                    <div class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
                        <div class="text-2xl font-semibold tracking-widest">DDTS</div>

                        <div class="hidden md:flex space-x-8">
                            <a href="/"
                                class="nav-link uppercase text-sm tracking-wider hover:after:w-full after:block after:w-0 after:h-px after:bg-black after:transition-all after:duration-300">
                                <spring:message code="navbar.home" />
                            </a>
                            <a href="/product/category"
                                class="nav-link uppercase text-sm tracking-wider hover:after:w-full after:block after:w-0 after:h-px after:bg-black after:transition-all after:duration-300">
                                <spring:message code="navbar.categories" />
                            </a>
                            <a href="/product/item-male"
                                class="nav-link uppercase text-sm tracking-wider hover:after:w-full after:block after:w-0 after:h-px after:bg-black after:transition-all after:duration-300">
                                <spring:message code="navbar.men" />
                            </a>
                            <a href="/product/item-female"
                                class="nav-link uppercase text-sm tracking-wider hover:after:w-full after:block after:w-0 after:h-px after:bg-black after:transition-all after:duration-300">
                                <spring:message code="navbar.women" />
                            </a>
                            <a href="/about"
                                class="nav-link uppercase text-sm tracking-wider hover:after:w-full after:block after:w-0 after:h-px after:bg-black after:transition-all after:duration-300">
                                <spring:message code="navbar.about" />
                            </a>
                        </div>

                        <div class="flex items-center space-x-6">
                            <div class="flex space-x-2">
                                <a href="?lang=en"
                                    class="text-sm ${pageContext.response.locale == 'en' ? 'font-bold text-blue-600' : 'text-gray-600'}">EN</a>
                                <span class="text-gray-400">|</span>
                                <a href="?lang=vi"
                                    class="text-sm ${pageContext.response.locale == 'vi' ? 'font-bold text-blue-600' : 'text-gray-600'}">VI</a>
                            </div>
                            <c:if test="${not empty pageContext.request.userPrincipal}">
                                <a href="/user/cart" class="relative me-4 my-auto">
                                    <i class="fa fa-shopping-bag fa-lg"></i>
                                    <span
                                        class="absolute -top-1 -right-2 bg-blue-200 rounded-full flex items-center justify-center text-dark px-1 h-5 w-5 text-xs"
                                        id="sumCart">
                                        ${sessionScope.sum}
                                    </span>
                                </a>
                                <div class="relative my-auto group">
                                    <button type="button" class="focus:outline-none">
                                        <i class="fas fa-user fa-lg"></i>
                                    </button>
                                    <div
                                        class="absolute right-0 mt-2 w-72 bg-white rounded-md shadow-lg z-50 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-300 transform group-hover:translate-y-0 translate-y-1">
                                        <div class="p-4">
                                            <div class="flex flex-col items-center">
                                                <img class="w-24 h-24 rounded-full object-cover mb-3"
                                                    src="${sessionScope.avatar}" />
                                                <div class="text-center font-medium mb-3">
                                                    <c:out value="${sessionScope.fullName}" />
                                                </div>
                                            </div>
                                            <hr class="my-2 border-gray-200">
                                            <a href="#" class="block px-4 py-2 text-gray-800 hover:bg-gray-100">
                                                <spring:message code="navbar.account" />
                                            </a>
                                            <a href="/order-history"
                                                class="block px-4 py-2 text-gray-800 hover:bg-gray-100">
                                                <spring:message code="navbar.orderHistory" />
                                            </a>
                                            <hr class="my-2 border-gray-200">
                                            <form method="post" action="/logout">
                                                <input type="hidden" name="${_csrf.parameterName}"
                                                    value="${_csrf.token}" />
                                                <button type="submit"
                                                    class="w-full text-left block px-4 py-2 text-gray-800 hover:bg-gray-100">
                                                    <spring:message code="navbar.logout" />
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <c:if test="${empty pageContext.request.userPrincipal}">
                                <a href="/login" class="text-sm hover:text-blue-600">
                                    <spring:message code="navbar.login" />
                                </a>
                            </c:if>
                        </div>
                    </div>
                </nav> -->
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta http-equiv="X-UA-Compatible" content="IE=edge">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Document</title>
                    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap"
                        rel="stylesheet">
                    <link rel="stylesheet"
                        href="${pageContext.request.contextPath}/resources/assets/client/css/style.css">
                    <link rel="stylesheet"
                        href="${pageContext.request.contextPath}/resources/assets/client/css/sontest.css">

                    <link rel="icon"
                        href="${pageContext.request.contextPath}/resources/assets/client/images/icon-adidas-logo.svg"
                        type="image/icon type">
                </head>


                <body>
















                    <footer>
                        <section class="adiclub">
                            <div class="wrapper">
                                <h1>JOIN OUR ADICLUB & GET 15% OFF</h1>
                                <a href="" class="sign-up"> SIGN UP FOR FREE <i class="uil uil-arrow-right"></i></a>
                            </div>
                        </section>

                    </footer>

                    <script src="https://kit.fontawesome.com/73713bf219.js" crossorigin="anonymous"></script>
                    <script src="${pageContext.request.contextPath}/resources/assets/client/js/mainson.js"></script>
                </body>

                </html>
                <!-- Font Awesome -->
                <script src="https://kit.fontawesome.com/your-code.js" crossorigin="anonymous"></script>