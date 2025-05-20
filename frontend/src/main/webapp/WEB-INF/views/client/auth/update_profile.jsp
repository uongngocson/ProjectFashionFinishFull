<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>DDTS | Cập Nhật Hồ Sơ</title>
                    <c:set var="ctx" value="${pageContext.request.contextPath}" />
                    <script src="https://cdn.tailwindcss.com"></script>
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                    <link
                        href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;500;600;700&display=swap"
                        rel="stylesheet">
                    <link href="${ctx}/resources/assets/client/css/profile.css" rel="stylesheet">
                    <style>
                        .modal input {
                            outline: none;
                            transition: border-color 0.2s;
                        }

                        .modal input:focus {
                            border-color: #000;
                        }

                        .text-red-500 {
                            font-size: 0.875rem;
                            margin-top: 0.25rem;
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

                        <section class="pt-[64px] mb-16">
                            <h2 class="text-2xl font-medium mb-6">Cập Nhật Hồ Sơ</h2>

                            <!-- Avatar Display -->
                            <div class="avatar-container">
                                <c:choose>
                                    <c:when test="${not empty customer.imageUrl}">
                                        <img src="${ctx}${customer.imageUrl}" alt="Ảnh đại diện" class="avatar">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${ctx}/resources/assets/client/images/default-avatar.jpg"
                                            alt="Ảnh đại diện mặc định" class="avatar">
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="bg-white p-8 shadow-sm rounded-lg">
                                <form:form modelAttribute="customer" action="${ctx}/management/profile/update"
                                    method="POST" enctype="multipart/form-data">
                                    <form:hidden path="customerId" />
                                    <form:hidden path="account.accountId" />
                                    <form:hidden path="registrationDate" />
                                    <form:hidden path="status" />

                                    <div class="mb-4">
                                        <label class="block text-sm text-gray-500 mb-2" for="firstName">Họ</label>
                                        <form:input path="firstName" class="w-full px-4 py-2 border rounded-full"
                                            required="true" />
                                        <form:errors path="firstName" cssClass="text-red-500 text-sm" />
                                    </div>

                                    <div class="mb-4">
                                        <label class="block text-sm text-gray-500 mb-2" for="lastName">Tên</label>
                                        <form:input path="lastName" class="w-full px-4 py-2 border rounded-full"
                                            required="true" />
                                        <form:errors path="lastName" cssClass="text-red-500 text-sm" />
                                    </div>

                                    <div class="mb-4">
                                        <label class="block text-sm text-gray-500 mb-2" for="email">Email</label>
                                        <form:input path="email" type="email"
                                            class="w-full px-4 py-2 border rounded-full" required="true" />
                                        <form:errors path="email" cssClass="text-red-500 text-sm" />
                                    </div>

                                    <div class="mb-4">
                                        <label class="block text-sm text-gray-500 mb-2" for="phone">Số Điện
                                            Thoại</label>
                                        <form:input path="phone" class="w-full px-4 py-2 border rounded-full"
                                            required="true" pattern="\d{10}"
                                            title="Số điện thoại phải có đúng 10 chữ số" />
                                        <form:errors path="phone" cssClass="text-red-500 text-sm" />
                                    </div>

                                    <div class="mb-4">
                                        <label class="block text-sm text-gray-500 mb-2" for="dateOfBirth">Ngày
                                            Sinh</label>
                                        <c:if test="${not empty customer.dateOfBirth}">
                                            <fmt:parseDate value="${customer.dateOfBirth}" pattern="yyyy-MM-dd"
                                                var="parsedDate" />
                                            <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd"
                                                var="formattedDate" />
                                        </c:if>
                                        <form:input path="dateOfBirth" type="date" value="${formattedDate}"
                                            class="w-full px-4 py-2 border rounded-full" required="true" />
                                        <form:errors path="dateOfBirth" cssClass="text-red-500 text-sm" />
                                    </div>

                                    <div class="mb-4">
                                        <label class="block text-sm text-gray-500 mb-2" for="gender">Giới Tính</label>
                                        <form:select path="gender" class="w-full px-4 py-2 border rounded-full">
                                            <form:option value="true">Nam</form:option>
                                            <form:option value="false">Nữ</form:option>
                                        </form:select>
                                        <form:errors path="gender" cssClass="text-red-500 text-sm" />
                                    </div>

                                    <div class="mb-4">
                                        <label class="block text-sm text-gray-500 mb-2" for="image">Ảnh Đại Diện</label>
                                        <input type="file" name="image" class="w-full px-4 py-2 border rounded-full"
                                            accept="image/*" />
                                    </div>

                                    <div class="flex justify-end space-x-4">
                                        <a href="${ctx}/management/profile"
                                            class="px-6 py-2 border rounded-full">Hủy</a>
                                        <button type="submit"
                                            class="btn-black bg-black text-white px-6 py-2 rounded-full">Lưu Thay
                                            Đổi</button>
                                    </div>
                                </form:form>
                            </div>
                        </section>
                    </div>
                </body>

                </html>