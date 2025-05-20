<xaiArtifact artifact_id="63099b8b-d189-4bf4-a4d5-9ae5339c2b88" artifact_version_id="80d581f7-d521-42c2-be4c-c861cbfed814" title="change_password.jsp" contentType="text/html">
```jsp
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DDTS | Thay Đổi Mật Khẩu</title>
    <c:set var="ctx" value="${pageContext.request.contextPath}" />
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">
    <link href="${ctx}/resources/assets/client/css/profile.css" rel="stylesheet">
    <style>
        .modal input { outline: none; transition: border-color 0.2s; }
        .modal input:focus { border-color: #000; }
        .text-red-500 { font-size: 0.875rem; margin-top: 0.25rem; }
    </style>
</head>

<body class="bg-white">
    <!-- Navbar -->
    <jsp:include page="../layout/navbar.jsp" />

    <div class="container mx-auto px-4 py-12 max-w-6xl">
        <!-- Flash Messages -->
        <c:if test="${not empty passwordSuccess}">
            <div class="bg-green-100 text-green-800 p-4 rounded mb-6">${passwordSuccess}</div>
        </c:if>
        <c:if test="${not empty passwordError}">
            <div class="bg-red-100 text-red-800 p-4 rounded mb-6">${passwordError}</div>
        </c:if>

        <section class="pt-[64px] mb-16">
            <h2 class="text-2xl font-medium mb-6">Thay Đổi Mật Khẩu</h2>

            <div class="bg-white p-8 shadow-sm rounded-lg">
                <form action="${ctx}/management/profile/change-password" method="POST">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <div class="mb-4">
                        <label class="block text-sm text-gray-500 mb-2" for="oldPassword">Mật Khẩu Cũ</label>
                        <input type="password" name="oldPassword" id="oldPassword"
                            class="w-full px-4 py-2 border rounded-full" required />
                    </div>
                    <div class="mb-4">
                        <label class="block text-sm text-gray-500 mb-2" for="newPassword">Mật Khẩu Mới</label>
                        <input type="password" name="newPassword" id="newPassword"
                            class="w-full px-4 py-2 border rounded-full" required />
                    </div>
                    <div class="mb-4">
                        <label class="block text-sm text-gray-500 mb-2" for="confirmPassword">Xác Nhận Mật Khẩu Mới</label>
                        <input type="password" name="confirmPassword" id="confirmPassword"
                            class="w-full px-4 py-2 border rounded-full" required />
                    </div>
                    <div class="flex justify-end space-x-4">
                        <a href="${ctx}/management/profile" class="px-6 py-2 border rounded-full">Hủy</a>
                        <button type="submit" class="btn-black bg-black text-white px-6 py-2 rounded-full">Lưu Mật Khẩu</button>
                    </div>
                </form>
            </div>
        </section>
    </div>
</body>
</html>