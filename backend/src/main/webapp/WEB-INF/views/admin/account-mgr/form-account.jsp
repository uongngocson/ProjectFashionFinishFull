<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>${account.accountId != null ? 'Edit' : 'Create'} Account</title>
                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
                <script src="${ctx}/resources/assets/dashboard/js/plugin/webfont/webfont.min.js"></script>
                <script>
                    WebFont.load({
                        google: { families: ["Public Sans:300,400,500,600,700"] },
                        custom: {
                            families: [
                                "Font Awesome 5 Solid",
                                "Font Awesome 5 Regular",
                                "Font Awesome 5 Brands",
                                "simple-line-icons",
                            ],
                            urls: ["${ctx}/resources/assets/dashboard/css/fonts.min.css"],
                        },
                        active: function () {
                            sessionStorage.fonts = true;
                        },
                    });
                </script>

                <!-- CSS Files -->
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/bootstrap.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/plugins.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/kaiadmin.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/demo.css" />
                <!-- Add Font Awesome for better icons -->
                <link rel="stylesheet"
                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
            </head>

            <body>
                <div class="wrapper">
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div class="main-panel">
                        <jsp:include page="../layout/header.jsp" />
                        <div class="container">
                            <div class="page-inner">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <div class="card-title">${account.accountId != null ? 'Update Account' :
                                                    'Create New Account'}</div>
                                            </div>
                                            <form:form action="/admin/account-mgr/save" method="post"
                                                modelAttribute="account">
                                                <div class="card-body">
                                                    <c:if test="${not empty account.accountId}">
                                                        <form:hidden path="accountId" />
                                                    </c:if>

                                                    <div class="form-group">
                                                        <label for="loginName">Login Name <span
                                                                class="text-danger">*</span></label>
                                                        <form:input path="loginName" type="text" class="form-control"
                                                            id="loginName" placeholder="Enter login name" />
                                                        <form:errors path="loginName" cssClass="text-danger" />
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="password">Password <span
                                                                class="text-danger">*</span></label>
                                                        <form:password path="password" class="form-control"
                                                            id="password" placeholder="Enter password" />
                                                        <form:errors path="password" cssClass="text-danger" />
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="role">Role <span
                                                                class="text-danger">*</span></label>
                                                        <form:select path="role" class="form-control" id="role">
                                                            <c:forEach var="roleItem" items="${roles}">
                                                                <c:if test="${roleItem.roleId == account.role.roleId}">
                                                                    <form:option value="${roleItem.roleId}"
                                                                        selected="selected">${roleItem.roleName}
                                                                    </form:option>
                                                                </c:if>
                                                                <c:if test="${roleItem.roleId != account.role.roleId}">
                                                                    <form:option value="${roleItem.roleId}">
                                                                        ${roleItem.roleName}
                                                                    </form:option>
                                                                </c:if>
                                                            </c:forEach>
                                                        </form:select>
                                                        <form:errors path="role" cssClass="text-danger" />
                                                    </div>
                                                </div>
                                                <div class="card-action">
                                                    <button type="submit" class="btn btn-success">${account.accountId !=
                                                        null ? 'Update' : 'Add'}</button>
                                                    <button type="reset" class="btn btn-primary">Reset</button>
                                                    <a href="/admin/account-mgr/list" class="btn btn-danger">Cancel</a>
                                                </div>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>

                <!-- Core JS Files -->
                <script src="${ctx}/resources/assets/dashboard/js/core/jquery-3.7.1.min.js"></script>
                <script src="${ctx}/resources/assets/dashboard/js/core/popper.min.js"></script>
                <script src="${ctx}/resources/assets/dashboard/js/core/bootstrap.min.js"></script>

                <!-- jQuery Scrollbar -->
                <script
                    src="${ctx}/resources/assets/dashboard/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

                <!-- Sweet Alert -->
                <script src="${ctx}/resources/assets/dashboard/js/plugin/sweetalert/sweetalert.min.js"></script>

                <!-- Kaiadmin JS -->
                <script src="${ctx}/resources/assets/dashboard/js/kaiadmin.min.js"></script>
            </body>

            </html>