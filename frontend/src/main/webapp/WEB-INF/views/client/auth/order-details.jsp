<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
                <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                    <!DOCTYPE html>
                    <html lang="en">

                    <head>
                        <meta charset="UTF-8">
                        <meta http-equiv="X-UA-Compatible" content="IE=edge">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Chi tiết đơn hàng</title>
                        <script src="https://cdn.tailwindcss.com"></script>
                        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
                        <link rel="preconnect" href="https://fonts.googleapis.com">
                        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                        <link
                            href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap"
                            rel="stylesheet">
                        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sontest.css">
                        <link rel="icon"
                            href="${pageContext.request.contextPath}/resources/assets/client/images/icon-adidas-logo.svg"
                            type="image/icon type">
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
                    </head>

                    <body>
                        <jsp:include page="../layout/navbar.jsp" />
                        <!-- Thay đổi màu nền từ bg-white thành bg-blue-100 -->
                        <section class="bg-gray-700 md:py-16 bg-white">
                            <div class="mx-auto max-w-screen-xl px-4 2xl:px-0">
                                <div class="mx-auto max-w-5xl">
                                    <h2 class="text-xl font-semibold text-gray-900 dark:text-white sm:text-2xl mb-6">
                                        Chi tiết đơn hàng #
                                        <c:out value="${orderDetails[0].orderId}" />
                                    </h2>

                                    <div class="debug-info">
                                        <p style="color: white;">Kích thước danh sách chi tiết đơn hàng:
                                            <c:out value="${orderDetails.size()}" />
                                        </p>
                                        <c:if test="${not empty orderDetails}">
                                            <p>ID đơn hàng đầu tiên:
                                                <c:out value="${orderDetails[0].orderId}" />
                                            </p>
                                        </c:if>
                                    </div>

                                    <c:if test="${not empty errorMessage}">
                                        <div class="text-center text-red-500 mb-6">
                                            <p>
                                                <c:out value="${errorMessage}" />
                                            </p>
                                            <a href="${pageContext.request.contextPath}/management/historyorder"
                                                class="text-blue-500 hover:underline">Quay lại lịch sử đơn hàng</a>
                                        </div>
                                    </c:if>

                                    <c:if test="${not empty orderDetails}">
                                        <!-- Thông tin đơn hàng -->
                                        <div class="dark:bg-gray-800 p-6 rounded-lg mb-6">
                                            <h3 class="text-lg font-semibold text-white dark:text-gray-100 mb-4">Thông
                                                tin đơn hàng</h3>
                                            <dl class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                                                <div>
                                                    <dt class="text-base font-medium text-gray-300 dark:text-gray-200">
                                                        Khách hàng:</dt>
                                                    <dd class="text-base text-white dark:text-gray-100">
                                                        <c:out
                                                            value="${orderDetails[0].firstName} ${orderDetails[0].lastName}" />
                                                    </dd>
                                                </div>
                                                <div>
                                                    <dt class="text-base font-medium text-gray-300 dark:text-gray-200">
                                                        Email:</dt>
                                                    <dd class="text-base text-white dark:text-gray-100">
                                                        <c:out value="${orderDetails[0].email}" />
                                                    </dd>
                                                </div>
                                                <div>
                                                    <dt class="text-base font-medium text-gray-300 dark:text-gray-200">
                                                        Địa chỉ giao hàng:</dt>
                                                    <dd class="text-base text-white dark:text-gray-100">
                                                        <c:out value="${orderDetails[0].shippingAddress}"
                                                            default="Không có thông tin địa chỉ" />
                                                    </dd>
                                                </div>
                                                <div>
                                                    <dt class="text-base font-medium text-gray-300 dark:text-gray-200">
                                                        Ngày đặt hàng:</dt>
                                                    <dd class="text-base text-white dark:text-gray-100">
                                                        <fmt:formatDate value="${orderDetails[0].orderDateAsDate}"
                                                            pattern="dd/MM/yyyy HH:mm:ss" />
                                                    </dd>
                                                </div>
                                                <div>
                                                    <dt class="text-base font-medium text-gray-300 dark:text-gray-200">
                                                        Tổng tiền:</dt>
                                                    <dd class="text-base text-white dark:text-gray-100">
                                                        <fmt:formatNumber value="${orderDetails[0].totalAmount}"
                                                            type="number" pattern="#,##0.00" /> VNĐ
                                                    </dd>
                                                </div>
                                                <div>
                                                    <dt class="text-base font-medium text-gray-300 dark:text-gray-200">
                                                        Trạng thái đơn hàng:</dt>
                                                    <dd class="text-base text-white dark:text-gray-100">
                                                        <c:choose>
                                                            <c:when test="${orderDetails[0].orderStatus == 'Pending'}">
                                                                <span
                                                                    class="bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-200 px-2.5 py-0.5 rounded">
                                                                    <c:out value="${orderDetails[0].orderStatus}" />
                                                                </span>
                                                            </c:when>
                                                            <c:when
                                                                test="${orderDetails[0].orderStatus == 'Đang xử lý'}">
                                                                <span
                                                                    class="bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200 px-2.5 py-0.5 rounded">
                                                                    <c:out value="${orderDetails[0].orderStatus}" />
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${orderDetails[0].orderStatus == 'Đã giao'}">
                                                                <span
                                                                    class="bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-200 px-2.5 py-0.5 rounded">
                                                                    <c:out value="${orderDetails[0].orderStatus}" />
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${orderDetails[0].orderStatus == 'Đã hủy'}">
                                                                <span
                                                                    class="bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-200 px-2.5 py-0.5 rounded">
                                                                    <c:out value="${orderDetails[0].orderStatus}" />
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span
                                                                    class="bg-gray-100 text-gray-800 dark:bg-gray-900 dark:text-gray-200 px-2.5 py-0.5 rounded">
                                                                    <c:out value="${orderDetails[0].orderStatus}" />
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </dd>
                                                </div>
                                                <div>
                                                    <dt class="text-base font-medium text-gray-300 dark:text-gray-200">
                                                        Trạng thái thanh toán:</dt>
                                                    <dd class="text-base text-white dark:text-gray-100">
                                                        <c:out
                                                            value="${orderDetails[0].paymentStatus == 1 ? 'Đã thanh toán' : 'Chưa thanh toán'}" />
                                                    </dd>
                                                </div>
                                            </dl>
                                        </div>

                                        <!-- Sản phẩm trong đơn hàng -->
                                        <div class="mt-6">
                                            <h3 class="text-lg font-semibold text-white dark:text-gray-100 mb-4">Sản
                                                phẩm trong đơn hàng</h3>
                                            <div class="divide-y divide-gray-200 dark:divide-gray-700">
                                                <!-- Tiêu đề bảng -->
                                                <div
                                                    class="flex flex-wrap items-center gap-y-4 py-4 font-semibold text-white dark:text-gray-100">
                                                    <div class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1">Sản phẩm</div>
                                                    <div class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1">Mô tả</div>
                                                    <div class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1">Hình ảnh</div>
                                                    <div class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1">Đánh giá</div>
                                                    <div class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1">Giá sản phẩm</div>
                                                    <div class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1">Số lượng</div>
                                                    <div class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1">Giá chi tiết</div>
                                                    <div class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1">Tổng phụ</div>
                                                </div>

                                                <!-- Dữ liệu bảng -->
                                                <c:forEach var="detail" items="${orderDetails}">
                                                    <div class="flex flex-wrap items-center gap-y-4 py-4">
                                                        <div
                                                            class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1 text-white dark:text-gray-100">
                                                            <c:out value="${detail.productName}" default="N/A" />
                                                        </div>
                                                        <div
                                                            class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1 text-white dark:text-gray-100">
                                                            <c:out value="${detail.description}" default="N/A" />
                                                        </div>
                                                        <div class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1">
                                                            <c:choose>
                                                                <c:when test="${not empty detail.imageUrl}">
                                                                    <img src="${pageContext.request.contextPath}/${detail.imageUrl}"
                                                                        alt="Hình ảnh sản phẩm" class="max-w-[100px]" />
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-white dark:text-gray-100">Không có
                                                                        hình ảnh</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <div
                                                            class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1 text-white dark:text-gray-100">
                                                            <c:out
                                                                value="${detail.rating != null ? detail.rating : 'N/A'}" />
                                                        </div>
                                                        <div
                                                            class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1 text-white dark:text-gray-100">
                                                            <fmt:formatNumber value="${detail.productPrice}"
                                                                type="number" pattern="#,##0.00" /> VNĐ
                                                        </div>
                                                        <div
                                                            class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1 text-white dark:text-gray-100">
                                                            <c:out value="${detail.quantity}" default="N/A" />
                                                        </div>
                                                        <div
                                                            class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1 text-white dark:text-gray-100">
                                                            <fmt:formatNumber value="${detail.orderDetailPrice}"
                                                                type="number" pattern="#,##0.00" /> VNĐ
                                                        </div>
                                                        <div
                                                            class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1 text-white dark:text-gray-100">
                                                            <fmt:formatNumber value="${detail.subtotal}" type="number"
                                                                pattern="#,##0.00" /> VNĐ
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>

                                        <div class="mt-6">
                                            <a href="${pageContext.request.contextPath}/management/historyorder"
                                                class="text-blue-500 hover:underline">Quay lại lịch sử đơn hàng</a>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </section>
                        <jsp:include page="../layout/footer.jsp" />
                    </body>

                    </html>