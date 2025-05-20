<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>Account Management</title>
                <sec:csrfMetaTags />
                <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <link rel="icon" href="<c:url value='/resources/assets/dashboard/img/kaiadmin/favicon.ico'/>"
                    type="image/x-icon" />

                <!-- Fonts and icons -->
                <script src="<c:url value='/resources/assets/dashboard/js/plugin/webfont/webfont.min.js'/>"></script>
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
                            urls: ["<c:url value='/resources/assets/dashboard/css/fonts.min.css'/>"],
                        },
                        active: function () {
                            sessionStorage.fonts = true;
                        },
                    });
                </script>

                <!-- CSS Files -->
                <link rel="stylesheet" href="<c:url value='/resources/assets/dashboard/css/bootstrap.min.css'/>" />
                <link rel="stylesheet" href="<c:url value='/resources/assets/dashboard/css/plugins.min.css'/>" />
                <link rel="stylesheet" href="<c:url value='/resources/assets/dashboard/css/kaiadmin.min.css'/>" />
                <%-- CSS cho DataTables nếu cần tùy chỉnh thêm --%>
                    <link rel="stylesheet"
                        href="<c:url value='/resources/assets/dashboard/js/plugin/datatables/datatables.min.css'/>">

            </head>

            <body>
                <div class="wrapper">
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div class="main-panel">
                        <jsp:include page="../layout/header.jsp" />
                        <div class="container">
                            <div class="page-inner">
                                <div class="page-header">
                                    <h3 class="fw-bold mb-3">Account Management</h3>
                                    <ul class="breadcrumbs mb-3">
                                        <li class="nav-home">
                                            <a href="<c:url value='/admin/dashboard/index'/>">
                                                <i class="icon-home"></i>
                                            </a>
                                        </li>
                                        <li class="separator">
                                            <i class="icon-arrow-right"></i>
                                        </li>
                                        <li class="nav-item">
                                            <a href="<c:url value='/admin/account-mgr/list'/>">Accounts</a>
                                        </li>
                                    </ul>
                                </div>
                                <div
                                    class="d-flex align-items-left align-items-md-center flex-column flex-md-row pt-2 pb-4">
                                    <%-- Nút thêm mới --%>
                                        <div class="ms-md-auto py-2 py-md-0">
                                            <a href="<c:url value='/admin/account-mgr/create'/>"
                                                class="btn btn-primary btn-round">
                                                <i class="fas fa-plus me-1"></i> Add New Account
                                            </a>
                                        </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <h4 class="card-title">Account List</h4>
                                            </div>
                                            <div class="card-body">
                                                <div class="table-responsive">
                                                    <%-- Thêm class "table-striped table-bordered" nếu muốn --%>
                                                        <table id="accountsTable" class="display table table-hover">
                                                            <thead>
                                                                <tr>
                                                                    <th>NO</th>
                                                                    <th>Login Name</th>
                                                                    <th>Role</th>
                                                                    <th style="width: 10%;">Actions</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <c:forEach var="account" items="${accounts}"
                                                                    varStatus="loop">
                                                                    <tr>
                                                                        <td>${loop.index + 1}</td> <%-- Sửa lỗi hiển thị
                                                                            NO --%>
                                                                            <td>${account.loginName}</td>
                                                                            <td>${account.role.roleName}</td>
                                                                            <td>
                                                                                <div class="form-button-action">
                                                                                    <%-- Sử dụng class này cho layout
                                                                                        nút đẹp hơn --%>
                                                                                        <a href="<c:url value='/admin/account-mgr/update/${account.accountId}'/>"
                                                                                            data-bs-toggle="tooltip"
                                                                                            title="Edit Account"
                                                                                            class="btn btn-link btn-primary btn-lg">
                                                                                            <i class="fa fa-edit"></i>
                                                                                        </a>
                                                                                        <button type="button"
                                                                                            data-bs-toggle="tooltip"
                                                                                            title="Delete Account"
                                                                                            class="btn btn-link btn-danger"
                                                                                            onclick="deleteAccount('${account.accountId}')">
                                                                                            <i class="fa fa-times"></i>
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

                <!-- Core JS Files -->
                <script src="<c:url value='/resources/assets/dashboard/js/core/jquery-3.7.1.min.js'/>"></script>
                <script src="<c:url value='/resources/assets/dashboard/js/core/popper.min.js'/>"></script>
                <script src="<c:url value='/resources/assets/dashboard/js/core/bootstrap.min.js'/>"></script>

                <!-- jQuery Scrollbar -->
                <script
                    src="<c:url value='/resources/assets/dashboard/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js'/>"></script>

                <!-- Datatables -->
                <script
                    src="<c:url value='/resources/assets/dashboard/js/plugin/datatables/datatables.min.js'/>"></script>

                <!-- Sweet Alert -->
                <script
                    src="<c:url value='/resources/assets/dashboard/js/plugin/sweetalert/sweetalert.min.js'/>"></script>

                <!-- Kaiadmin JS -->
                <script src="<c:url value='/resources/assets/dashboard/js/kaiadmin.min.js'/>"></script>

                <script>
                    $(document).ready(function () {
                        // Kích hoạt DataTables
                        $('#accountsTable').DataTable();

                        // Kích hoạt Tooltips (nếu sử dụng data-bs-toggle="tooltip")
                        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
                        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                            return new bootstrap.Tooltip(tooltipTriggerEl)
                        })
                    });

                    // Lấy CSRF token từ thẻ meta (nếu có)
                    const csrfToken = document.querySelector('meta[name="_csrf"]')?.content;
                    const csrfHeader = document.querySelector('meta[name="_csrf_header"]')?.content;

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
                                    url: '<c:url value="/admin/account-mgr/delete/"/>' + accountId,
                                    type: 'POST', // Giữ nguyên POST
                                    beforeSend: function (xhr) {
                                        if (csrfHeader && csrfToken) {
                                            xhr.setRequestHeader(csrfHeader, csrfToken);
                                        }
                                    },
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
                                    error: function (xhr, status, error) {
                                        console.error("Error deleting account:", status, error, xhr.responseText);
                                        let errorMsg = "There was an issue deleting the account.";
                                        // Kiểm tra mã trạng thái HTTP
                                        if (xhr.status === 409) { // Conflict - Tài khoản đang sử dụng
                                            errorMsg = xhr.responseText; // Lấy thông báo lỗi từ server
                                        } else if (xhr.status === 404) { // Not Found
                                            errorMsg = xhr.responseText;
                                        } else if (xhr.status === 403) { // Forbidden - CSRF
                                            errorMsg = "Permission denied. Please refresh the page and try again.";
                                        } else if (xhr.responseText) {
                                            errorMsg = xhr.responseText; // Hiển thị lỗi chung từ server nếu có
                                        }
                                        swal("Error!", errorMsg, "error");
                                    }
                                });
                            }
                        });
                    }
                </script>
            </body>

            </html>