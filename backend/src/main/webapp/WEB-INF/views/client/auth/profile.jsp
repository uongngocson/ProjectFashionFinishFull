<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DDTS | Hồ Sơ Của Bạn</title>
    <c:set var="ctx" value="${pageContext.request.contextPath}" />
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="${ctx}/resources/assets/client/css/profile.css" rel="stylesheet">
    <style>
        /* Áp dụng font Cormorant Garamond với font dự phòng */
        body, h1, h2, h3, p, div, a, span {
            font-family: 'Cormorant Garamond', serif !important;
        }
        /* Nếu font không tải được, sử dụng font dự phòng */
        body {
            font-family: 'Cormorant Garamond', 'Times New Roman', serif !important;
        }
        .avatar-container { 
            display: flex; 
            justify-content: center; 
            margin-bottom: 2rem; 
        }
        .avatar { 
            width: 128px; 
            height: 128px; 
            border-radius: 50%; 
            object-fit: cover; 
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); 
            border: 2px solid #e5e7eb; 
        }
    </style>
</head>

<body class="bg-white">
    <!-- Navbar -->
    <jsp:include page="../layout/navbar.jsp" />

    <div class="container mx-auto px-4 py-12 max-w-6xl">
        <!-- Flash Messages -->
        <c:if test="${not empty success}">
            <div class="bg-green-100 text-green-800 p-4 rounded mb-6">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="bg-red-100 text-red-800 p-4 rounded mb-6">${error}</div>
        </c:if>
        <c:if test="${not empty passwordSuccess}">
            <div class="bg-green-100 text-green-800 p-4 rounded mb-6">${passwordSuccess}</div>
        </c:if>
        <c:if test="${not empty passwordError}">
            <div class="bg-red-100 text-red-800 p-4 rounded mb-6">${passwordError}</div>
        </c:if>

        <!-- Profile Section -->
        <c:choose>
            <c:when test="${not empty customer}">
                <section class="pt-[64px] mb-16">
                    <div class="flex justify-between items-center mb-6">
                        <h2 class="text-2xl font-medium">Hồ Sơ Của Bạn</h2>
                        <div class="flex space-x-4">
                            <a href="${ctx}/management/profile/update" class="btn-black bg-black text-white px-6 py-2 rounded-full text-sm">
                                Chỉnh Sửa Thông Tin
                            </a>
                            <a href="${ctx}/management/profile/change-password" class="btn-black bg-black text-white px-6 py-2 rounded-full text-sm">
                                Thay Đổi Mật Khẩu
                            </a>
                        </div>
                    </div>

                    <!-- Avatar Display -->
                    <div class="avatar-container">
                        <c:choose>
                            <c:when test="${not empty customer.imageUrl}">
                                <img src="${ctx}${customer.imageUrl}" alt="Ảnh đại diện" class="avatar"
                                    onerror="this.src='${ctx}/resources/assets/client/images/default-avatar.jpg'">
                            </c:when>
                            <c:otherwise>
                                <img src="${ctx}/resources/assets/client/images/default-avatar.jpg" alt="Ảnh đại diện mặc định"
                                    class="avatar">
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Validation Error Message -->
                    <c:if test="${empty customer.dateOfBirth}">
                        <div class="bg-red-100 text-red-800 p-4 rounded mb-6">
                            Lỗi: Ngày sinh không được để trống. Vui lòng cập nhật thông tin hồ sơ.
                        </div>
                    </c:if>

                    <div class="bg-white p-8 shadow-sm rounded-lg">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                            <!-- Personal Info -->
                            <div>
                                <h3 class="text-lg font-medium mb-4">Thông Tin Cá Nhân</h3>
                                <div class="space-y-4">
                                    <div>
                                        <p class="text-gray-500 text-sm">Họ và Tên</p>
                                        <p class="font-medium">
                                            <c:out value="${not empty customer.firstName ? customer.firstName : 'N/A'}" />
                                            <c:out value="${not empty customer.lastName ? customer.lastName : 'N/A'}" />
                                        </p>
                                    </div>
                                    <div>
                                        <p class="text-gray-500 text-sm">Email</p>
                                        <p class="font-medium">
                                            <c:out value="${not empty customer.email ? customer.email : 'N/A'}" />
                                        </p>
                                    </div>
                                    <div>
                                        <p class="text-gray-500 text-sm">Số Điện Thoại</p>
                                        <p class="font-medium">
                                            <c:out value="${not empty customer.phone ? customer.phone : 'N/A'}" />
                                        </p>
                                    </div>
                                    <div>
                                        <p class="text-gray-500 text-sm">Ngày Sinh</p>
                                        <p class="font-medium">
                                            <c:choose>
                                                <c:when test="${not empty customer.dateOfBirth}">
                                                    <fmt:parseDate value="${customer.dateOfBirth}" pattern="yyyy-MM-dd" var="parsedDate" />
                                                    <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy" />
                                                </c:when>
                                                <c:otherwise>N/A</c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>
                                    <div>
                                        <p class="text-gray-500 text-sm">Giới Tính</p>
                                        <p class="font-medium">
                                            <c:choose>
                                                <c:when test="${customer.gender}">Nam</c:when>
                                                <c:otherwise>Nữ</c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <!-- Addresses -->
                            <div>
                                <h3 class="text-lg font-medium mb-4">Địa Chỉ Giao Hàng</h3>
                                <div class="space-y-4">
                                    <c:choose>
                                        <c:when test="${not empty customer.addresses}">
                                            <c:forEach var="address" items="${customer.addresses}">
                                                <div>
                                                    <p class="font-medium">
                                                        <c:out value="${not empty address.street ? address.street : 'N/A'}" />
                                                    </p>
                                                    <p class="font-medium">
                                                        <c:if test="${not empty address.ward && not empty address.ward.wardName}">
                                                            <c:out value="${address.ward.wardName}" />
                                                        </c:if>
                                                        <c:if test="${not empty address.district && not empty address.district.districtName}">
                                                            , <c:out value="${address.district.districtName}" />
                                                        </c:if>
                                                        <c:if test="${not empty address.province && not empty address.province.provinceName}">
                                                            , <c:out value="${address.province.provinceName}" />
                                                        </c:if>
                                                        <c:if test="${not empty address.country}">
                                                            , <c:out value="${address.country}" />
                                                        </c:if>
                                                        <c:if test="${empty address.ward && empty address.district && empty address.province && empty address.country}">
                                                            N/A
                                                        </c:if>
                                                    </p>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="text-gray-500">Không có địa chỉ nào.</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </c:when>
            <c:otherwise>
                <div class="bg-red-100 text-red-800 p-4 rounded mb-6">
                    Không thể tải thông tin hồ sơ. Vui lòng đăng nhập.
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>