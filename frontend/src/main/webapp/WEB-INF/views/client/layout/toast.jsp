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
                    <script src="https://cdn.tailwindcss.com"></script>

                </head>

                <body>

                    <div class="fixed z-50 right-0 bottom-0">
                        <div id="toast-success"
                            class="flex items-center w-full max-w-xs p-4 mb-4 text-gray-500 bg-white rounded-lg shadow-sm dark:text-gray-400 dark:bg-gray-800 hidden"
                            role="alert">
                            <div
                                class="inline-flex items-center justify-center shrink-0 w-8 h-8 text-green-500 bg-green-100 rounded-lg dark:bg-green-800 dark:text-green-200">
                                <svg class="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
                                    fill="currentColor" viewBox="0 0 20 20">
                                    <path
                                        d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5Zm3.707 8.207-4 4a1 1 0 0 1-1.414 0l-2-2a1 1 0 0 1 1.414-1.414L9 10.586l3.293-3.293a1 1 0 0 1 1.414 1.414Z" />
                                </svg>
                                <span class="sr-only">Check icon</span>
                            </div>
                            <div class="ms-3 text-sm font-normal">Item moved successfully.</div>
                            <button type="button"
                                class="ms-auto -mx-1.5 -my-1.5 bg-white text-gray-400 hover:text-gray-900 rounded-lg focus:ring-2 focus:ring-gray-300 p-1.5 hover:bg-gray-100 inline-flex items-center justify-center h-8 w-8 dark:text-gray-500 dark:hover:text-white dark:bg-gray-800 dark:hover:bg-gray-700"
                                data-dismiss-target="#toast-success" aria-label="Close">
                                <span class="sr-only">Close</span>
                                <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none"
                                    viewBox="0 0 14 14">
                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                        stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6" />
                                </svg>
                            </button>
                        </div>
                        <div id="toast-danger"
                            class="flex items-center w-full max-w-xs p-4 mb-4 text-gray-500 bg-white rounded-lg shadow-sm dark:text-gray-400 dark:bg-gray-800 hidden"
                            role="alert">
                            <div
                                class="inline-flex items-center justify-center shrink-0 w-8 h-8 text-red-500 bg-red-100 rounded-lg dark:bg-red-800 dark:text-red-200">
                                <svg class="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
                                    fill="currentColor" viewBox="0 0 20 20">
                                    <path
                                        d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5Zm3.707 11.793a1 1 0 1 1-1.414 1.414L10 11.414l-2.293 2.293a1 1 0 0 1-1.414-1.414L8.586 10 6.293 7.707a1 1 0 0 1 1.414-1.414L10 8.586l2.293-2.293a1 1 0 0 1 1.414 1.414L11.414 10l2.293 2.293Z" />
                                </svg>
                                <span class="sr-only">Error icon</span>
                            </div>
                            <div class="ms-3 text-sm font-normal">Item has been deleted.</div>
                            <button type="button"
                                class="ms-auto -mx-1.5 -my-1.5 bg-white text-gray-400 hover:text-gray-900 rounded-lg focus:ring-2 focus:ring-gray-300 p-1.5 hover:bg-gray-100 inline-flex items-center justify-center h-8 w-8 dark:text-gray-500 dark:hover:text-white dark:bg-gray-800 dark:hover:bg-gray-700"
                                data-dismiss-target="#toast-danger" aria-label="Close">
                                <span class="sr-only">Close</span>
                                <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none"
                                    viewBox="0 0 14 14">
                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                        stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6" />
                                </svg>
                            </button>
                        </div>
                        <div id="toast-warning"
                            class="flex items-center w-full max-w-xs p-4 text-gray-500 bg-white rounded-lg shadow-sm dark:text-gray-400 dark:bg-gray-800 hidden"
                            role="alert">
                            <div
                                class="inline-flex items-center justify-center shrink-0 w-8 h-8 text-orange-500 bg-orange-100 rounded-lg dark:bg-orange-700 dark:text-orange-200">
                                <svg class="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
                                    fill="currentColor" viewBox="0 0 20 20">
                                    <path
                                        d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5ZM10 15a1 1 0 1 1 0-2 1 1 0 0 1 0 2Zm1-4a1 1 0 0 1-2 0V6a1 1 0 0 1 2 0v5Z" />
                                </svg>
                                <span class="sr-only">Warning icon</span>
                            </div>
                            <div class="ms-3 text-sm font-normal">Improve password difficulty.</div>
                            <button type="button"
                                class="ms-auto -mx-1.5 -my-1.5 bg-white text-gray-400 hover:text-gray-900 rounded-lg focus:ring-2 focus:ring-gray-300 p-1.5 hover:bg-gray-100 inline-flex items-center justify-center h-8 w-8 dark:text-gray-500 dark:hover:text-white dark:bg-gray-800 dark:hover:bg-gray-700"
                                data-dismiss-target="#toast-warning" aria-label="Close">
                                <span class="sr-only">Close</span>
                                <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none"
                                    viewBox="0 0 14 14">
                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                        stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6" />
                                </svg>
                            </button>
                        </div>


                    </div>




                    <script src="https://kit.fontawesome.com/73713bf219.js" crossorigin="anonymous"></script>
                    <script src="${pageContext.request.contextPath}/resources/assets/client/js/mainson.js"></script>
                </body>

                </html>
                <!-- Font Awesome -->
                <script src="https://kit.fontawesome.com/your-code.js" crossorigin="anonymous"></script>