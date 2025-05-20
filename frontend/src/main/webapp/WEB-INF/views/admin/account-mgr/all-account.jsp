<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <title>Account Management</title>
            <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
            <link rel="icon" href="../../../../resources/assets/dashboard/img/kaiadmin/favicon.ico"
                type="image/x-icon" />
            <script src="../../../../resources/assets/dashboard/js/plugin/webfont/webfont.min.js"></script>
            <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/bootstrap.min.css" />
            <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/plugins.min.css" />
            <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/kaiadmin.min.css" />
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
                        urls: ["../../../../resources/assets/dashboard/css/fonts.min.css"],
                    },
                    active: function () {
                        sessionStorage.fonts = true;
                    },
                });
            </script>
        </head>

        <body>
            <div class="wrapper">
                <jsp:include page="../layout/sidebar.jsp" />
                <div class="main-panel">
                    <jsp:include page="../layout/header.jsp" />
                    <div class="container">
                        <div class="page-inner">
                            <div class="page-header">
                                <h3 class="fw-bold mb-3">Accounts</h3>
                                <ul class="breadcrumbs mb-3">
                                    <li class="nav-home">
                                        <a href="/admin/dashboard/index">
                                            <i class="icon-home"></i>
                                        </a>
                                    </li>
                                    <li class="separator">
                                        <i class="icon-arrow-right"></i>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/admin/account-mgr/list">Accounts</a>
                                    </li>
                                </ul>
                            </div>
                            <div
                                class="d-flex align-items-left align-items-md-center flex-column flex-md-row pt-2 pb-4">
                                <div class="ms-md-auto py-2 py-md-0">
                                    <a href="/admin/account-mgr/create" class="btn btn-primary btn-round">
                                        <i class="fas fa-plus"></i> Add New Account
                                    </a>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="table-responsive">
                                                <table id="accountsTable" class="table table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>Account ID</th>
                                                            <th>Login Name</th>
                                                            <th>Role</th>
                                                            <th>Actions</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="account" items="${accounts}">
                                                            <tr>
                                                                <td>${account.accountId}</td>
                                                                <td>${account.loginName}</td>
                                                                <td>${account.role.roleName}</td>
                                                                <td>
                                                                    <div class="btn-group">
                                                                        <a href="/admin/account-mgr/${account.accountId}"
                                                                            class="btn btn-sm btn-info">
                                                                            <i class="fas fa-eye"></i>
                                                                        </a>
                                                                        <a href="/admin/account-mgr/update/${account.accountId}"
                                                                            class="btn btn-sm btn-primary">
                                                                            <i class="fas fa-edit"></i>
                                                                        </a>
                                                                        <button type="button"
                                                                            class="btn btn-sm btn-danger"
                                                                            onclick="deleteAccount('${account.accountId}')">
                                                                            <i class="fas fa-trash"></i>
                                                                        </button>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <jsp:include page="../layout/footer.jsp" />
                </div>
            </div>

            <script src="../../../../resources/assets/dashboard/js/core/jquery-3.7.1.min.js"></script>
            <script src="../../../../resources/assets/dashboard/js/core/popper.min.js"></script>
            <script src="../../../../resources/assets/dashboard/js/core/bootstrap.min.js"></script>
            <script src="../../../../resources/assets/dashboard/js/plugin/sweetalert/sweetalert.min.js"></script>

            <script>
                function deleteAccount(accountId) {
                    swal({
                        title: 'Are you sure?',
                        text: "You won't be able to revert this!",
                        type: 'warning',
                        buttons: {
                            cancel: {
                                visible: true,
                                text: 'Cancel',
                                className: 'btn btn-danger'
                            },
                            confirm: {
                                text: 'Yes, delete it!',
                                className: 'btn btn-success'
                            }
                        }
                    }).then((willDelete) => {
                        if (willDelete) {
                            $.ajax({
                                url: '/admin/account-mgr/delete/' + accountId,
                                type: 'POST',
                                success: function (response) {
                                    swal("Deleted!", "The account has been deleted.", {
                                        icon: "success",
                                        buttons: {
                                            confirm: {
                                                className: 'btn btn-success'
                                            }
                                        }
                                    }).then(function () {
                                        location.reload();
                                    });
                                },
                                error: function (error) {
                                    swal("Error!", "There was an issue deleting the account.", "error");
                                }
                            });
                        }
                    });
                }
            </script>
        </body>

        </html>