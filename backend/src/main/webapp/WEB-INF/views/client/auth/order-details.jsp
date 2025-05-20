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
        .debug-info {
            display: none; /* Ẩn thông tin debug */
        }
    </style>
</head>
<body class="bg-white">
    <jsp:include page="../layout/navbar.jsp" />
    <section class="bg-white py-8 antialiased md:py-16">
        <div class="mx-auto max-w-screen-xl px-4 2xl:px-0">
            <div class="mx-auto max-w-5xl">
                <h2 class="text-xl font-bold text-black sm:text-2xl mb-6">
                    Chi tiết đơn hàng #<c:out value="${orderDetails[0].orderId}" />
                </h2>

                <div class="debug-info">
                    <p>Kích thước danh sách chi tiết đơn hàng: <c:out value="${orderDetails.size()}" /></p>
                    <c:if test="${not empty orderDetails}">
                        <p>ID đơn hàng đầu tiên: <c:out value="${orderDetails[0].orderId}" /></p>
                    </c:if>
                </div>

                <c:if test="${not empty errorMessage}">
                    <div class="text-center text-red-500 mb-6">
                        <p><c:out value="${errorMessage}" /></p>
                        <a href="${pageContext.request.contextPath}/management/historyorder?page=${currentPage}" class="text-blue-500 hover:underline">Quay lại lịch sử đơn hàng</a>
                    </div>
                </c:if>

                <c:if test="${not empty orderDetails}">
                    <!-- Thông tin đơn hàng -->
                    <div class="bg-white border border-gray-200 p-6 rounded-lg mb-6">
                        <h3 class="text-lg font-bold text-black mb-4">Thông tin đơn hàng</h3>
                        <dl class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                            <div>
                                <dt class="text-base font-medium text-gray-500">Khách hàng:</dt>
                                <dd class="text-base text-black">
                                    <c:out value="${orderDetails[0].firstName} ${orderDetails[0].lastName}" />
                                </dd>
                            </div>
                            <div>
                                <dt class="text-base font-medium text-gray-500">Email:</dt>
                                <dd class="text-base text-black">
                                    <c:out value="${orderDetails[0].email}" />
                                </dd>
                            </div>
                            <div>
                                <dt class="text-base font-medium text-gray-500">Địa chỉ giao hàng:</dt>
                                <dd class="text-base text-black">
                                    <c:out value="${orderDetails[0].shippingAddress}" default="Không có thông tin địa chỉ" />
                                </dd>
                            </div>
                            <div>
                                <dt class="text-base font-medium text-gray-500">Ngày đặt hàng:</dt>
                                <dd class="text-base text-black">
                                    <fmt:formatDate value="${orderDetails[0].orderDateAsDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                                </dd>
                            </div>
                            <div>
                                <dt class="text-base font-medium text-gray-500">Tổng tiền:</dt>
                                <dd class="text-base text-black">
                                    <fmt:formatNumber value="${orderDetails[0].totalAmount}" type="number" pattern="#,##0.00"/> VNĐ
                                </dd>
                            </div>
                            <div>
                                <dt class="text-base font-medium text-gray-500">Trạng thái đơn hàng:</dt>
                                <dd class="text-base text-black">
                                    <c:choose>
                                        <c:when test="${orderDetails[0].orderStatus == 'PENDING'}">
                                            <span class="bg-yellow-100 text-yellow-800 px-2.5 py-0.5 rounded">
                                                <c:out value="${orderDetails[0].orderStatus}" />
                                            </span>
                                        </c:when>
                                        <c:when test="${orderDetails[0].orderStatus == 'CONFIRMED'}">
                                            <span class="bg-blue-100 text-blue-800 px-2.5 py-0.5 rounded">
                                                <c:out value="${orderDetails[0].orderStatus}" />
                                            </span>
                                        </c:when>
                                        <c:when test="${orderDetails[0].orderStatus == 'COMPLETED'}">
                                            <span class="bg-green-100 text-green-800 px-2.5 py-0.5 rounded">
                                                <c:out value="${orderDetails[0].orderStatus}" />
                                            </span>
                                        </c:when>
                                        <c:when test="${orderDetails[0].orderStatus == 'CANCELLED'}">
                                            <span class="bg-red-100 text-red-800 px-2.5 py-0.5 rounded">
                                                <c:out value="${orderDetails[0].orderStatus}" />
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="bg-gray-100 text-gray-800 px-2.5 py-0.5 rounded">
                                                <c:out value="${orderDetails[0].orderStatus}" />
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </dd>
                            </div>
                            <div>
                                <dt class="text-base font-medium text-gray-500">Trạng thái thanh toán:</dt>
                                <dd class="text-base text-black">
                                    <c:out value="${orderDetails[0].paymentStatus == 1 ? 'Đã thanh toán' : 'Chưa thanh toán'}" />
                                </dd>
                            </div>
                        </dl>
                    </div>
                
                    <!-- Sản phẩm trong đơn hàng -->
                    <div class="mt-6">
                        <h3 class="text-lg font-bold text-black mb-4">Sản phẩm trong đơn hàng</h3>
                        <div class="divide-y divide-gray-200">
                            <!-- Tiêu đề bảng -->
                            <div class="flex flex-wrap items-center gap-y-4 py-4 font-bold text-black">
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
                                    <div class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1 text-black">
                                        <c:out value="${detail.productName}" default="N/A" />
                                    </div>
                                    <div class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1 text-black">
                                        <c:out value="${detail.description}" default="N/A" />
                                    </div>
                                    <div class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1">
                                        <c:choose>
                                            <c:when test="${not empty detail.imageUrl}">
                                                <img src="${pageContext.request.contextPath}/${detail.imageUrl}" alt="Hình ảnh sản phẩm" class="max-w-[100px]"/>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-black">Không có hình ảnh</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1 text-black">
                                        <c:out value="${detail.rating != null ? detail.rating : 'N/A'}" />
                                    </div>
                                    <div class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1 text-black">
                                        <fmt:formatNumber value="${detail.productPrice}" type="number" pattern="#,##0.00"/> VNĐ
                                    </div>
                                    <div class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1 text-black">
                                        <c:out value="${detail.quantity}" default="N/A" />
                                    </div>
                                    <div class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1 text-black">
                                        <fmt:formatNumber value="${detail.orderDetailPrice}" type="number" pattern="#,##0.00"/> VNĐ
                                    </div>
                                    <div class="w-1/2 sm:w-1/6 lg:w-auto lg:flex-1 text-black">
                                        <fmt:formatNumber value="${detail.subtotal}" type="number" pattern="#,##0.00"/> VNĐ
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                
                    <div class="mt-6">
                        <a href="${pageContext.request.contextPath}/management/historyorder?page=${currentPage}" class="text-blue-500 hover:underline">Quay lại lịch sử đơn hàng</a>
                    </div>
                </c:if>
            </div>
        </div>
    </section>
    <jsp:include page="../layout/footer.jsp" />
</body>
</html>