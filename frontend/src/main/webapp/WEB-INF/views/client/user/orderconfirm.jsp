<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                    <!DOCTYPE html>
                    <html lang="en">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Order Confirmation | Luxury Boutique</title>
                        <c:set var="ctx" value="${pageContext.request.contextPath}" />
                        <script src="https://cdn.tailwindcss.com"></script>
                        <link rel="stylesheet"
                            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                        <link
                            href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;500;600;700&display=swap"
                            rel="stylesheet">
                        <link href="${ctx}/resources/assets/client/css/profile.css" rel="stylesheet">
                    </head>

                    <body class="bg-white">
                        <!-- navbar -->
                        <jsp:include page="../layout/navbar.jsp" />
                        <div class="container mx-auto px-4 py-12 max-w-6xl">

                            <div class="py-14 px-4 md:px-6 2xl:px-20 2xl:container 2xl:mx-auto">
                                <!-- Display error message if present -->
                                <c:if test="${not empty error}">
                                    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6"
                                        role="alert">
                                        <p class="font-bold">Error</p>
                                        <p>${error}</p>
                                    </div>
                                </c:if>

                                <div class="flex justify-start item-start space-y-2 flex-col">
                                    <h1 class="text-3xl lg:text-4xl font-semibold leading-7 lg:leading-9 text-gray-800">
                                        ĐẶT HÀNG THÀNH CÔNG #
                                        <c:out value="${orderId}" default="ORD-UNKNOWN" />
                                    </h1>
                                    <p class="text-base font-medium leading-6 text-gray-600">
                                        <c:out value="${orderDate}" default="Today" />
                                    </p>
                                </div>

                                <div
                                    class="mt-10 flex flex-col xl:flex-row jusitfy-center items-stretch w-full xl:space-x-8 space-y-4 md:space-y-6 xl:space-y-0">
                                    <div
                                        class="flex flex-col justify-start items-start w-full space-y-4 md:space-y-6 xl:space-y-8">
                                        <div
                                            class="flex flex-col justify-start items-start bg-gray-50 px-4 py-4 md:py-6 md:p-6 xl:p-8 w-full">
                                            <p
                                                class="text-lg md:text-xl font-semibold leading-6 xl:leading-5 text-gray-800">
                                                Customer's Cart
                                            </p>

                                            <!-- Loop through order items -->
                                            <c:forEach items="${orderItems}" var="item" varStatus="status">
                                                <c:if test="${status.index < fn:length(orderItems) - 1}">
                                                    <div
                                                        class="mt-4 md:mt-6 flex flex-col md:flex-row justify-start items-start md:items-center md:space-x-6 xl:space-x-8 w-full ${status.index > 0 ? 'mt-6 md:mt-0' : ''}">
                                                        <div class="pb-4 md:pb-8 w-full md:w-40">
                                                            <c:choose>
                                                                <c:when test="${not empty item.imageUrl}">
                                                                    <img class="w-full hidden md:block"
                                                                        src="${item.imageUrl}" alt="${item.name}" />
                                                                    <img class="w-full md:hidden" src="${item.imageUrl}"
                                                                        alt="${item.name}" />
                                                                </c:when>

                                                            </c:choose>
                                                        </div>
                                                        <div
                                                            class="border-b border-gray-200 md:flex-row flex-col flex justify-between items-start w-full pb-8 space-y-4 md:space-y-0">
                                                            <div
                                                                class="w-full flex flex-col justify-start items-start space-y-8">
                                                                <h3
                                                                    class="text-xl xl:text-2xl font-semibold leading-6 text-gray-800">
                                                                    <c:out value="${item.name}" />
                                                                </h3>
                                                                <div
                                                                    class="flex justify-start items-start flex-col space-y-2">
                                                                    <c:if test="${not empty item.style}">
                                                                        <p class="text-sm leading-none text-gray-800">
                                                                            <span class="text-gray-300">Style: </span>
                                                                            <c:out value="${item.style}" />
                                                                        </p>
                                                                    </c:if>
                                                                    <c:if test="${not empty item.size}">
                                                                        <p class="text-sm leading-none text-gray-800">
                                                                            <span class="text-gray-300">Size: </span>
                                                                            <c:out value="${item.size}" />
                                                                        </p>
                                                                    </c:if>
                                                                    <c:if test="${not empty item.color}">
                                                                        <p class="text-sm leading-none text-gray-800">
                                                                            <span class="text-gray-300">Color: </span>
                                                                            <c:out value="${item.color}" />
                                                                        </p>
                                                                    </c:if>
                                                                </div>
                                                            </div>
                                                            <div
                                                                class="flex justify-between space-x-8 items-start w-full">
                                                                <p class="text-base xl:text-lg leading-6">
                                                                    Price x
                                                                    <fmt:formatNumber value="${item.price}"
                                                                        pattern="#,##0.00" />
                                                                </p>
                                                                <p class="text-base xl:text-lg leading-6 text-gray-800">
                                                                    <c:out value="${item.quantity}" />
                                                                </p>
                                                                <p
                                                                    class="text-base xl:text-lg font-semibold leading-6 text-gray-800">
                                                                    Total x
                                                                    <fmt:formatNumber value="${item.subtotal}"
                                                                        pattern="#,##0.00" />
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>

                                            <!-- If no items are available -->
                                            <c:if test="${empty orderItems}">
                                                <div class="mt-4 w-full p-6 text-center bg-gray-100 rounded-md">
                                                    <p class="text-gray-500">No order items available</p>
                                                </div>
                                            </c:if>
                                        </div>

                                        <div
                                            class="flex justify-center flex-col md:flex-row flex-col items-stretch w-full space-y-4 md:space-y-0 md:space-x-6 xl:space-x-8">
                                            <div
                                                class="flex flex-col px-4 py-6 md:p-6 xl:p-8 w-full bg-gray-50 space-y-6">
                                                <h3 class="text-xl font-semibold leading-5 text-gray-800">
                                                    Summary
                                                </h3>
                                                <div
                                                    class="flex justify-center items-center w-full space-y-4 flex-col border-gray-200 border-b pb-4">
                                                    <div class="flex justify-between w-full">
                                                        <p class="text-base leading-4 text-gray-800">Subtotal</p>
                                                        <p class="text-base leading-4 text-gray-600">
                                                            $
                                                            <fmt:formatNumber value="${subtotal}" pattern="#,##0.00" />
                                                        </p>
                                                    </div>
                                                    <div class="flex justify-between items-center w-full">
                                                        <p class="text-base leading-4 text-gray-800">
                                                            Discount
                                                            <c:if
                                                                test="${not empty discountPercentage and discountPercentage > 0}">
                                                                <span
                                                                    class="bg-gray-200 p-1 text-xs font-medium leading-3 text-gray-800">
                                                                    <c:choose>
                                                                        <c:when test="${discountPercentage > 0}">
                                                                            ${discountPercentage}%
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            STUDENT
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </span>
                                                            </c:if>
                                                        </p>
                                                        <p class="text-base leading-4 text-gray-600">
                                                            -$
                                                            <fmt:formatNumber value="${discount}" pattern="#,##0.00" />
                                                            <c:if
                                                                test="${not empty discountPercentage and discountPercentage > 0}">
                                                                (${discountPercentage}%)
                                                            </c:if>
                                                        </p>
                                                    </div>
                                                    <div class="flex justify-between items-center w-full">
                                                        <p class="text-base leading-4 text-gray-800">Shipping</p>
                                                        <p class="text-base leading-4 text-gray-600">
                                                            $
                                                            <fmt:formatNumber value="${shipping}" pattern="#,##0.00" />
                                                        </p>
                                                    </div>
                                                </div>
                                                <div class="flex justify-between items-center w-full">
                                                    <p class="text-base font-semibold leading-4 text-gray-800">Total</p>
                                                    <p class="text-base font-semibold leading-4 text-gray-600">
                                                        $
                                                        <fmt:formatNumber value="${total}" pattern="#,##0.00" />
                                                    </p>
                                                </div>
                                            </div>

                                            <div
                                                class="flex flex-col justify-center px-4 py-6 md:p-6 xl:p-8 w-full bg-gray-50 space-y-6">
                                                <h3 class="text-xl font-semibold leading-5 text-gray-800">Shipping</h3>
                                                <div class="flex justify-between items-start w-full">
                                                    <div class="flex justify-center items-center space-x-4">
                                                        <div class="w-8 h-8">
                                                            <img class="w-full h-full" alt="logo"
                                                                src="https://i.ibb.co/L8KSdNQ/image-3.png" />
                                                        </div>
                                                        <div class="flex flex-col justify-start items-center">
                                                            <p class="text-lg leading-6 font-semibold text-gray-800">
                                                                DPD Delivery<br /><span class="font-normal">Delivery
                                                                    with 24
                                                                    Hours</span>
                                                            </p>
                                                        </div>
                                                    </div>
                                                    <p class="text-lg font-semibold leading-6 text-gray-800">
                                                        $
                                                        <fmt:formatNumber value="${shipping}" pattern="#,##0.00" />
                                                    </p>
                                                </div>
                                                <div class="w-full flex justify-center items-center">
                                                    <button
                                                        class="hover:bg-black focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-800 py-5 w-96 md:w-full bg-gray-800 text-base font-medium leading-4 text-white">
                                                        View Carrier Details
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div
                                        class="bg-gray-50 w-full xl:w-96 flex justify-between items-center md:items-start px-4 py-6 md:p-6 xl:p-8 flex-col">
                                        <h3 class="text-xl font-semibold leading-5 text-gray-800">Customer</h3>
                                        <div
                                            class="flex flex-col md:flex-row xl:flex-col justify-start items-stretch h-full w-full md:space-x-6 lg:space-x-8 xl:space-x-0">
                                            <div class="flex flex-col justify-start items-start flex-shrink-0">
                                                <div
                                                    class="flex justify-center w-full md:justify-start items-center space-x-4 py-8 border-b border-gray-200">
                                                    <img src="${ctx}/resources/assets/client/images/user-avatar.jpg"
                                                        alt="avatar" class="w-16 h-16 rounded-full object-cover" />
                                                    <div class="flex justify-start items-start flex-col space-y-2">
                                                        <p
                                                            class="text-base font-semibold leading-4 text-left text-gray-800">
                                                            <c:out value="${customerName}" default="Customer" />
                                                        </p>
                                                        <p class="text-sm leading-5 text-gray-600">
                                                            Valued Customer
                                                        </p>
                                                    </div>
                                                </div>

                                                <div
                                                    class="flex justify-center text-gray-800 md:justify-start items-center space-x-4 py-4 border-b border-gray-200 w-full">
                                                    <img class="dark:hidden"
                                                        src="https://tuk-cdn.s3.amazonaws.com/can-uploader/order-summary-3-svg1.svg"
                                                        alt="email">
                                                    <p class="cursor-pointer text-sm leading-5">
                                                        <c:out value="${customerEmail}"
                                                            default="customer@example.com" />
                                                    </p>
                                                </div>
                                            </div>

                                            <div
                                                class="flex justify-between xl:h-full items-stretch w-full flex-col mt-6 md:mt-0">
                                                <div
                                                    class="flex justify-center md:justify-start xl:flex-col flex-col md:space-x-6 lg:space-x-8 xl:space-x-0 space-y-4 xl:space-y-12 md:space-y-0 md:flex-row items-center md:items-start">
                                                    <div
                                                        class="flex justify-center md:justify-start items-center md:items-start flex-col space-y-4 xl:mt-8">
                                                        <p
                                                            class="text-base font-semibold leading-4 text-center md:text-left text-gray-800">
                                                            Shipping Address
                                                        </p>
                                                        <p
                                                            class="w-48 lg:w-full xl:w-48 text-center md:text-left text-sm leading-5 text-gray-600">
                                                            <c:out value="${shippingAddress}"
                                                                default="No shipping address provided" />
                                                        </p>
                                                    </div>

                                                    <!-- <div
                                                        class="flex justify-center md:justify-start items-center md:items-start flex-col space-y-4">
                                                        <p
                                                            class="text-base font-semibold leading-4 text-center md:text-left text-gray-800">
                                                            Billing Address
                                                        </p>
                                                        <p
                                                            class="w-48 lg:w-full xl:w-48 text-center md:text-left text-sm leading-5 text-gray-600">
                                                            <c:out value="${shippingAddress}"
                                                                default="Same as shipping address" />
                                                        </p>
                                                    </div> -->
                                                </div>

                                                <div
                                                    class="flex w-full justify-center items-center md:justify-start md:items-start">
                                                    <a href="${ctx}/management/order/details/${orderId}"
                                                        class="mt-6 md:mt-0 py-5 hover:bg-gray-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-800 border border-gray-800 font-medium w-96 2xl:w-full text-base font-medium leading-4 text-center text-gray-800">
                                                        View My Orders
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <!-- footer -->
                        <jsp:include page="../layout/footer.jsp" />

                        <script>
                            // If you need any client-side JavaScript for the confirmation page
                            document.addEventListener('DOMContentLoaded', function () {
                                console.log('Order confirmation page loaded successfully');
                            });
                        </script>
                    </body>

                    </html>