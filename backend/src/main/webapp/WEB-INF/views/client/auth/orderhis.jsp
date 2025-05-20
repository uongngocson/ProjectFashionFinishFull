<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử đơn hàng</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sontest.css">
    <link rel="icon" href="${pageContext.request.contextPath}/resources/assets/client/images/icon-adidas-logo.svg" type="image/icon type">
    <style>
        #user-dropdown::before {
            content: "";
            position: absolute;
            top: -8px;
            right: 16px;
            width: 0;
            height: 0;
            border-left: 8px solid transparent;
            border-right: 8px solid transparent;
            border-bottom: 8px solid black;
            filter: drop-shadow(0 -1px 1px rgba(0, 0, 0, 0.05));
        }
    </style>
    <script>
        function confirmCancel(event) {
            if (!confirm("Bạn có muốn hủy đơn hàng này không?")) {
                event.preventDefault();
            }
        }
    </script>
</head>
<body class="bg-white text-black">
    <jsp:include page="../layout/navbar.jsp" />
    <section class="bg-white py-8 antialiased md:py-16">
        <div class="mx-auto max-w-screen-xl px-4 2xl:px-0">
            <div class="mx-auto max-w-5xl">
                <div class="gap-4 sm:flex sm:items-center sm:justify-between">
                    <h2 class="text-xl font-semibold text-black sm:text-2xl">Lịch sử đơn hàng</h2>
                </div>

                <!-- Success or Error Messages -->
                <c:if test="${not empty success}">
                    <div class="text-center text-green-500 mb-6">
                        <p><c:out value="${success}" /></p>
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="text-center text-red-500 mb-6">
                        <p><c:out value="${error}" /></p>
                    </div>
                </c:if>

                <div class="mt-6 flow-root sm:mt-8">
                    <div class="divide-y divide-gray-200">
                        <!-- Table Header -->
                        <div class="flex flex-wrap items-center gap-y-4 py-6 font-semibold text-black">
                            <dl class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1">
                                <dt class="text-base">Mã đơn hàng</dt>
                            </dl>
                            <dl class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1">
                                <dt class="text-base">Ngày đặt</dt>
                            </dl>
                            <dl class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1">
                                <dt class="text-base">Tổng tiền</dt>
                            </dl>
                            <dl class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1">
                                <dt class="text-base">Trạng thái</dt>
                            </dl>
                            <div class="w-full sm:w-1/6 lg:w-64 lg:flex lg:items-center lg:justify-end">
                                <dt class="text-base">Hành động</dt>
                            </div>
                        </div>

                        <!-- Table Content -->
                        <c:choose>
                            <c:when test="${empty orders}">
                                <div class="flex flex-wrap items-center gap-y-4 py-6">
                                    <div class="w-full text-center text-gray-500">
                                        <p>Không có đơn hàng nào để hiển thị.</p>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="order" items="${orders}">
                                    <div class="flex flex-wrap items-center gap-y-4 py-6">
                                        <dl class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1">
                                            <dt class="text-base font-medium text-gray-500 sr-only">Mã đơn hàng:</dt>
                                            <dd class="mt-1.5 text-base font-semibold text-black">
                                                <c:catch var="exception">
                                                    <c:if test="${not empty order.orderId}">
                                                        <a href="${pageContext.request.contextPath}/management/order/details/${order.orderId}?page=${currentPage}" class="text-blue-500 hover:underline">#${order.orderId}</a>
                                                    </c:if>
                                                    <c:if test="${empty order.orderId}">
                                                        N/A
                                                    </c:if>
                                                </c:catch>
                                                <c:if test="${not empty exception}">
                                                    <p class="text-red-500">Lỗi (Mã đơn hàng): ${exception.message}</p>
                                                </c:if>
                                            </dd>
                                        </dl>

                                        <dl class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1">
                                            <dt class="text-base font-medium text-gray-500 sr-only">Ngày đặt:</dt>
                                            <dd class="mt-1.5 text-base font-semibold text-black">
                                                <c:catch var="exception">
                                                    <c:if test="${not empty order.orderDate}">
                                                        <fmt:formatDate value="${order.orderDateAsDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                                                    </c:if>
                                                    <c:if test="${empty order.orderDate}">
                                                        N/A
                                                    </c:if>
                                                </c:catch>
                                                <c:if test="${not empty exception}">
                                                    <p class="text-red-500">Lỗi (Ngày đặt): ${exception.message}</p>
                                                </c:if>
                                            </dd>
                                        </dl>

                                        <dl class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1">
                                            <dt class="text-base font-medium text-gray-500 sr-only">Tổng tiền:</dt>
                                            <dd class="mt-1.5 text-base font-semibold text-black">
                                                <c:catch var="exception">
                                                    <c:if test="${not empty order.totalAmount}">
                                                        <fmt:formatNumber value="${order.totalAmount}" type="number" pattern="#,##0.00"/> VNĐ
                                                    </c:if>
                                                    <c:if test="${empty order.totalAmount}">
                                                        N/A
                                                    </c:if>
                                                </c:catch>
                                                <c:if test="${not empty exception}">
                                                    <p class="text-red-500">Lỗi (Tổng tiền): ${exception.message}</p>
                                                </c:if>
                                            </dd>
                                        </dl>

                                        <dl class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1">
                                            <dt class="text-base font-medium text-gray-500 sr-only">Trạng thái:</dt>
                                            <dd class="me-2 mt-1.5 inline-flex items-center rounded px-2.5 py-0.5 text-xs font-medium">
                                                <c:catch var="exception">
                                                    <c:if test="${not empty order.orderStatus}">
                                                        <c:choose>
                                                            <c:when test="${order.orderStatus == 'PENDING'}">
                                                                <c:set var="statusClass" value="bg-yellow-100 text-yellow-800"/>
                                                                <svg class="me-1 h-3 w-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                                                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"/>
                                                                </svg>
                                                            </c:when>
                                                            <c:when test="${order.orderStatus == 'CONFIRMED'}">
                                                                <c:set var="statusClass" value="bg-blue-100 text-blue-800"/>
                                                                <svg class="me-1 h-3 w-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                                                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h6l2 4m-8-4v8m0-8V6a1 1 0 0 0-1-1H4a1 1 0 0 0-1 1v9h2m8 0H9m4 0h2m4 0h2v-4m0 0h-5m3.5 5.5a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0Zm-10 0a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0Z"/>
                                                                </svg>
                                                            </c:when>
                                                            <c:when test="${order.orderStatus == 'COMPLETED'}">
                                                                <c:set var="statusClass" value="bg-green-100 text-green-800"/>
                                                                <svg class="me-1 h-3 w-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                                                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 11.917 9.724 16.5 19 7.5"/>
                                                                </svg>
                                                            </c:when>
                                                            <c:when test="${order.orderStatus == 'CANCELLED'}">
                                                                <c:set var="statusClass" value="bg-red-100 text-red-800"/>
                                                                <svg class="me-1 h-3 w-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                                                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18 17.94 6M18 18 6.06 6"/>
                                                                </svg>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:set var="statusClass" value="bg-gray-100 text-gray-800"/>
                                                                <svg class="me-1 h-3 w-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                                                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"/>
                                                                </svg>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <span class="${statusClass}">${order.orderStatus}</span>
                                                    </c:if>
                                                    <c:if test="${empty order.orderStatus}">
                                                        N/A
                                                    </c:if>
                                                </c:catch>
                                                <c:if test="${not empty exception}">
                                                    <p class="text-red-500">Lỗi (Trạng thái): ${exception.message}</p>
                                                </c:if>
                                            </dd>
                                        </dl>

                                        <div class="w-full sm:w-1/6 lg:w-64 lg:flex lg:items-center lg:justify-end gap-4">
                                            <c:catch var="exception">
                                                <c:if test="${not empty order.orderStatus}">
                                                    <c:if test="${order.orderStatus == 'PENDING'}">
                                                        <form action="${pageContext.request.contextPath}/management/order/cancel/${order.orderId}?page=${currentPage}" method="post" onsubmit="confirmCancel(event)">
                                                            <sec:csrfInput />
                                                            <button type="submit" class="w-full rounded-lg border border-red-700 px-3 py-2 text-center text-sm font-medium text-red-700 hover:bg-red-700 hover:text-white focus:outline-none focus:ring-4 focus:ring-red-300 lg:w-auto">Hủy đơn hàng</button>
                                                        </form>
                                                    </c:if>
                                                </c:if>
                                                <c:if test="${not empty order.orderId}">
                                                    <a href="${pageContext.request.contextPath}/management/order/details/${order.orderId}?page=${currentPage}" class="w-full inline-flex justify-center rounded-lg border border-gray-200 bg-white px-3 py-2 text-sm font-medium text-gray-900 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:outline-none focus:ring-4 focus:ring-gray-100 lg:w-auto">Xem chi tiết</a>
                                                </c:if>
                                            </c:catch>
                                            <c:if test="${not empty exception}">
                                                <p class="text-red-500">Lỗi (Hành động): ${exception.message}</p>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Pagination Controls -->
                <c:if test="${totalPages > 1}">
                    <nav class="mt-6 flex items-center justify-center sm:mt-8" aria-label="Page navigation example">
                        <ul class="flex h-8 items-center -space-x-px text-sm">
                            <!-- Previous Button -->
                            <li>
                                <c:choose>
                                    <c:when test="${currentPage > 0}">
                                        <a href="${pageContext.request.contextPath}/management/historyorder?page=${currentPage - 1}" class="ms-0 flex h-8 items-center justify-center rounded-s-lg border border-e-0 border-gray-300 bg-white px-3 leading-tight text-gray-500 hover:bg-gray-100 hover:text-gray-700">
                                            <span class="sr-only">Trước</span>
                                            <svg class="h-4 w-4 rtl:rotate-180" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                                                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m15 19-7-7 7-7"/>
                                            </svg>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="ms-0 flex h-8 items-center justify-center rounded-s-lg border border-e-0 border-gray-300 bg-gray-200 px-3 leading-tight text-gray-400 cursor-not-allowed">
                                            <span class="sr-only">Trước</span>
                                            <svg class="h-4 w-4 rtl:rotate-180" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                                                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m15 19-7-7 7-7"/>
                                            </svg>
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </li>

                            <!-- Page Numbers -->
                            <c:set var="startPage" value="${currentPage - 2 < 0 ? 0 : currentPage - 2}"/>
                            <c:set var="endPage" value="${currentPage + 2 > totalPages - 1 ? totalPages - 1 : currentPage + 2}"/>
                            <c:if test="${startPage > 0}">
                                <li>
                                    <a href="${pageContext.request.contextPath}/management/historyorder?page=0" class="flex h-8 items-center justify-center border border-gray-300 bg-white px-3 leading-tight text-gray-500 hover:bg-gray-100 hover:text-gray-700">1</a>
                                </li>
                                <c:if test="${startPage > 1}">
                                    <li>
                                        <span class="flex h-8 items-center justify-center border border-gray-300 bg-white px-3 leading-tight text-gray-500">...</span>
                                    </li>
                                </c:if>
                            </c:if>

                            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                <li>
                                    <c:choose>
                                        <c:when test="${i == currentPage}">
                                            <span class="z-10 flex h-8 items-center justify-center border border-blue-300 bg-blue-50 px-3 leading-tight text-blue-600">${i + 1}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/management/historyorder?page=${i}" class="flex h-8 items-center justify-center border border-gray-300 bg-white px-3 leading-tight text-gray-500 hover:bg-gray-100 hover:text-gray-700">${i + 1}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                            </c:forEach>

                            <c:if test="${endPage < totalPages - 1}">
                                <c:if test="${endPage < totalPages - 2}">
                                    <li>
                                        <span class="flex h-8 items-center justify-center border border-gray-300 bg-white px-3 leading-tight text-gray-500">...</span>
                                    </li>
                                </c:if>
                                <li>
                                    <a href="${pageContext.request.contextPath}/management/historyorder?page=${totalPages - 1}" class="flex h-8 items-center justify-center border border-gray-300 bg-white px-3 leading-tight text-gray-500 hover:bg-gray-100 hover:text-gray-700">${totalPages}</a>
                                </li>
                            </c:if>

                            <!-- Next Button -->
                            <li>
                                <c:choose>
                                    <c:when test="${currentPage < totalPages - 1}">
                                        <a href="${pageContext.request.contextPath}/management/historyorder?page=${currentPage + 1}" class="flex h-8 items-center justify-center rounded-e-lg border border-gray-300 bg-white px-3 leading-tight text-gray-500 hover:bg-gray-100 hover:text-gray-700">
                                            <span class="sr-only">Tiếp</span>
                                            <svg class="h-4 w-4 rtl:rotate-180" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                                                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m9 5 7 7-7 7"/>
                                            </svg>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="flex h-8 items-center justify-center rounded-e-lg border border-gray-300 bg-gray-200 px-3 leading-tight text-gray-400 cursor-not-allowed">
                                            <span class="sr-only">Tiếp</span>
                                            <svg class="h-4 w-4 rtl:rotate-180" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                                                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m9 5 7 7-7 7"/>
                                            </svg>
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </div>
        </div>
    </section>
    <jsp:include page="../layout/footer.jsp" />
    <script src="https://kit.fontawesome.com/your-code.js" crossorigin="anonymous"></script>
</body>
</html>