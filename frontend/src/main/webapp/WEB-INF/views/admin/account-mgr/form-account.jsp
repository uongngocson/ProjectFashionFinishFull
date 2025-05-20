<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>${account.accountId != null ? 'Edit' : 'Create'} Account</title>
                <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
                <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/bootstrap.min.css" />
                <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/kaiadmin.min.css" />
            </head>

            <body>
                <div class="wrapper">
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div class="main-panel">
                        <jsp:include page="../layout/header.jsp" />
                        <div class="container">
                            <div class="page-inner">
                                <div class="page-header">
                                    <h3 class="fw-bold mb-3">${account.accountId != null ? 'Edit' : 'Create'} Account
                                    </h3>
                                    <ul class="breadcrumbs mb-3">
                                        <li class="nav-home"><a href="/admin/dashboard/index"><i
                                                    class="icon-home"></i></a></li>
                                        <li class="separator"><i class="icon-arrow-right"></i></li>
                                        <li class="nav-item"><a href="/admin/account-mgr/list">Accounts</a></li>
                                        <li class="separator"><i class="icon-arrow-right"></i></li>
                                        <li class="nav-item"><a href="#">${account.accountId != null ? 'Edit' :
                                                'Create'}</a></li>
                                    </ul>
                                </div>
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
                                                            id="loginName" placeholder="Enter login name"
                                                            required="true" />
                                                        <form:errors path="loginName" cssClass="text-danger" />
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="password">Password <span
                                                                class="text-danger">*</span></label>
                                                        <form:password path="password" class="form-control"
                                                            id="password" placeholder="Enter password"
                                                            required="true" />
                                                        <form:errors path="password" cssClass="text-danger" />
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="role">Role <span
                                                                class="text-danger">*</span></label>
                                                        <form:select path="role" class="form-control" id="role">
                                                            <c:forEach var="role" items="${roles}">
                                                                <form:option value="${role.roleId}">${role.roleName}
                                                                </form:option>
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
            </body>

            </html>