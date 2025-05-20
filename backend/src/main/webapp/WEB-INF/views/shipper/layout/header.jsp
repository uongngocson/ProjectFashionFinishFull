<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <div class="main-header">
                <div class="main-header-logo"><!-- Logo Header -->

                    <!-- End Logo Header -->
                </div>
                <!-- Navbar Header -->
                <nav class="navbar navbar-header navbar-header-transparent navbar-expand-lg border-bottom">
                    <div class="container-fluid">
                        <ul class="navbar-nav topbar-nav ms-md-auto align-items-center">
                            <li class="nav-item topbar-user dropdown hidden-caret">
                                <a class="dropdown-toggle profile-pic" data-bs-toggle="dropdown" href="#"
                                    aria-expanded="false">
                                    <div class="avatar-sm">
                                        <%-- Sử dụng c:url để tạo đường dẫn chính xác --%>
                                            <c:choose>
                                                <c:when test="${empty sessionScope.employeeAvatar}">
                                                    <img src="<c:url value='/resources/images-upload/avatar-default.jpg'/>"
                                                        alt="" class="avatar-img rounded-circle" />
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="<c:url value='${sessionScope.employeeAvatar}'/>" alt=""
                                                        class="avatar-img rounded-circle" />
                                                </c:otherwise>
                                            </c:choose>
                                    </div>
                                    <span class="profile-username">
                                        <span class="op-7">Hi,</span>
                                        <span class="fw-bold">${sessionScope.employeeFullName}
                                        </span>
                                    </span>
                                </a>
                                <ul class="dropdown-menu dropdown-user animated fadeIn">
                                    <div class="dropdown-user-scroll scrollbar-outer">
                                        <li>
                                            <div class="user-box">
                                                <div class="avatar-lg">
                                                    <%-- Áp dụng tương tự cho ảnh lớn nếu cần --%>
                                                        <c:choose>
                                                            <c:when test="${empty sessionScope.employeeAvatar}">
                                                                <img src="<c:url value='/resources/images-upload/avatar-default.jpg'/>"
                                                                    alt="image profile" class="avatar-img rounded" />
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img src="<c:url value='${sessionScope.employeeAvatar}'/>"
                                                                    alt="image profile" class="avatar-img rounded" />
                                                            </c:otherwise>
                                                        </c:choose>
                                                </div>
                                                <div class="u-text">
                                                    <p class="text-muted">${sessionScope.employeeEmail}</p>
                                                    <a href="#" class="btn btn-xs btn-secondary btn-sm">View
                                                        Profile</a>
                                                </div>
                                            </div>
                                        </li>
                                        <li>
                                            <form method="post" action="/logout">
                                                <input type="hidden" name="${_csrf.parameterName}"
                                                    value="${_csrf.token}" />
                                                <button class="dropdown-item">Logout</button>
                                            </form>
                                        </li>
                                    </div>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </nav>
                <!-- End Navbar -->
            </div>