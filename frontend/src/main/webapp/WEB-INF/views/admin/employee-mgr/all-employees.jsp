<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>Employee Management</title>
                <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
                <!-- set path -->
                <c:set var="ctx" value="${pageContext.request.contextPath}" />

                <link rel="icon" href="${ctx}/resources/assets/user/img/home/walmart-logo.webp" type="image/x-icon" />

                <script src="${ctx}/resources/assets/dashboard/js/plugin/webfont/webfont.min.js"></script>
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/bootstrap.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/plugins.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/kaiadmin.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/demo.css" />
                <!-- Add Font Awesome for better icons -->
                <link rel="stylesheet"
                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />

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

                <style>
                    .employee-avatar {
                        width: 45px;
                        height: 45px;
                        border-radius: 50%;
                        object-fit: cover;
                        margin-right: 15px;
                        border: 2px solid #4e73df;
                    }

                    .employee-info {
                        display: flex;
                        align-items: center;
                    }

                    .employee-details {
                        display: flex;
                        flex-direction: column;
                    }

                    .employee-name {
                        font-weight: 600;
                        color: #2d3748;
                        font-size: 14px;
                    }

                    .employee-position {
                        font-size: 12px;
                        color: #718096;
                    }

                    .badge-success {
                        background-color: #1cc88a;
                    }

                    .badge-danger {
                        background-color: #e74a3b;
                    }

                    .badge {
                        font-size: 12px;
                        padding: 6px 12px;
                        border-radius: 30px;
                        font-weight: 500;
                        margin: 0 2px;
                    }

                    .card {
                        border-radius: 10px;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
                        border: none;
                    }

                    .card-header {
                        background-color: #fff;
                        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
                        padding: 20px 25px;
                    }

                    .card-title {
                        font-weight: 600;
                        color: #2d3748;
                    }

                    .btn-primary {
                        background-color: #4e73df;
                        border-color: #4e73df;
                    }

                    .btn-success {
                        background-color: #1cc88a;
                        border-color: #1cc88a;
                    }

                    .btn-danger {
                        background-color: #e74a3b;
                        border-color: #e74a3b;
                    }

                    .btn-info {
                        background-color: #36b9cc;
                        border-color: #36b9cc;
                    }

                    .btn-round {
                        border-radius: 30px;
                        padding: 8px 16px;
                    }

                    .table th {
                        font-weight: 600;
                        color: #4e73df;
                    }

                    .table-hover tbody tr:hover {
                        background-color: #f8f9fc;
                    }

                    .department-badge {
                        background-color: #4e73df;
                        color: white;
                        padding: 5px 10px;
                        border-radius: 15px;
                        font-size: 12px;
                    }
                </style>

            </head>

            <body>
                <div class="wrapper">
                    <!-- Sidebar -->
                    <jsp:include page="../layout/sidebar.jsp" />
                    <!-- End Sidebar -->

                    <div class="main-panel">
                        <jsp:include page="../layout/header.jsp" />

                        <div class="container">
                            <div class="page-inner">
                                <div class="page-header">
                                    <h3 class="fw-bold mb-3">Employee Management</h3>
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
                                            <a href="#">Employees</a>
                                        </li>
                                    </ul>
                                </div>
                                <div
                                    class="d-flex align-items-left align-items-md-center flex-column flex-md-row pt-2 pb-4">
                                    <div class="ms-md-auto py-2 py-md-0">
                                        <a href="/admin/employee-mgr/create" class="btn btn-primary btn-round">
                                            <i class="fas fa-plus"></i> Add New Employee
                                        </a>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <div class="card-title">
                                                    <i class="fas fa-users mr-2 text-primary"></i>
                                                    Employee List
                                                </div>
                                            </div>
                                            <div class="card-body">
                                                <div class="table-responsive">
                                                    <table id="employee-table" class="table table-hover">
                                                        <thead>
                                                            <tr>
                                                                <th>ID</th>
                                                                <th>Employee</th>
                                                                <th>Hire Date</th>
                                                                <th>Salary</th>
                                                                <th>Status</th>
                                                                <th>Actions</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="employee" items="${employees}">
                                                                <tr>
                                                                    <td>#${employee.employeeId}</td>
                                                                    <td>
                                                                        <div class="employee-info">
                                                                            <img src="${not empty employee.imageUrl ? employee.imageUrl : ctx.concat('/resources/assets/dashboard/img/profile.jpg')}"
                                                                                class="employee-avatar"
                                                                                alt="${employee.firstName}">
                                                                            <div class="employee-details">
                                                                                <div class="employee-name">
                                                                                    ${employee.firstName}
                                                                                    ${employee.lastName}</div>
                                                                                <div class="employee-position">
                                                                                    ${employee.email}</div>
                                                                            </div>
                                                                        </div>
                                                                    </td>


                                                                    <td>
                                                                        <fmt:formatDate
                                                                            value="${employee.getHireDateAsDate()}"
                                                                            pattern="MMM dd, yyyy" />
                                                                    </td>
                                                                    <td>$${employee.salary}</td>
                                                                    <td>
                                                                        <span
                                                                            class="badge badge-${employee.status ? 'success' : 'danger'}">
                                                                            ${employee.status ? 'Active' : 'Inactive'}
                                                                        </span>
                                                                    </td>
                                                                    <td>
                                                                        <div class="btn-group">
                                                                            <a href="/admin/employee-mgr/detail/${employee.employeeId}"
                                                                                class="btn btn-sm btn-info">
                                                                                <i class="fas fa-eye"></i>
                                                                            </a>
                                                                            <a href="/admin/employee-mgr/update/${employee.employeeId}"
                                                                                class="btn btn-sm btn-primary">
                                                                                <i class="fas fa-edit"></i>
                                                                            </a>
                                                                            <button type="button"
                                                                                class="btn btn-sm btn-danger"
                                                                                onclick="confirmDelete('${employee.employeeId}')">
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

                        <!-- Footer -->
                        <jsp:include page="../layout/footer.jsp" />
                        <!-- End Footer -->
                    </div>
                </div>

                <!-- Core JS Files -->
                <script src="${ctx}/resources/assets/dashboard/js/core/jquery-3.7.1.min.js"></script>
                <script src="${ctx}/resources/assets/dashboard/js/core/popper.min.js"></script>
                <script src="${ctx}/resources/assets/dashboard/js/core/bootstrap.min.js"></script>

                <!-- jQuery Scrollbar -->
                <script
                    src="${ctx}/resources/assets/dashboard/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

                <!-- DataTables -->
                <script src="${ctx}/resources/assets/dashboard/js/plugin/datatables/datatables.min.js"></script>

                <!-- Sweet Alert -->
                <script src="${ctx}/resources/assets/dashboard/js/plugin/sweetalert/sweetalert.min.js"></script>

                <!-- Kaiadmin JS -->
                <script src="${ctx}/resources/assets/dashboard/js/kaiadmin.min.js"></script>

                <script>
                    $(document).ready(function () {
                        $('#employee-table').DataTable({
                            "pageLength": 10,
                            "lengthMenu": [5, 10, 15, 20, 50, 100],
                            "order": [[0, "desc"]],
                            "columnDefs": [
                                { "orderable": false, "targets": [4] },
                                { "orderable": false, "targets": [5] } // Corrected target index for Actions column
                            ]
                        });
                    });

                    function confirmDelete(employeeId) {
                        swal({
                            title: 'Are you sure?',
                            text: "You won't be able to revert this!",
                            icon: 'warning',
                            buttons: {
                                cancel: {
                                    visible: true,
                                    text: 'Cancel',
                                    className: 'btn btn-secondary'
                                },
                                confirm: {
                                    text: 'Yes, delete it!',
                                    className: 'btn btn-danger'
                                }
                            }
                        }).then((willDelete) => {
                            if (willDelete) {
                                $.ajax({
                                    url: '/admin/employee-mgr/delete/' + employeeId,
                                    type: 'POST',
                                    success: function (result) {
                                        swal({
                                            title: 'Deleted!',
                                            text: 'Employee has been deleted.',
                                            icon: 'success'
                                        }).then(() => {
                                            location.reload();
                                        });
                                    },
                                    error: function (error) {
                                        swal('Error!', 'Something went wrong.', 'error');
                                    }
                                });
                            }
                        });
                    }
                </script>
            </body>

            </html>