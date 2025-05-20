<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>Customer Management</title>
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
                    .customer-avatar {
                        width: 40px;
                        height: 40px;
                        border-radius: 50%;
                        object-fit: cover;
                    }

                    .status-badge {
                        padding: 5px 10px;
                        border-radius: 30px;
                        font-size: 12px;
                        font-weight: 600;
                    }

                    .table-responsive {
                        overflow-x: auto;
                    }

                    .action-buttons .btn {
                        /* This class was defined but not used, keeping for potential future use or removal if definitely not needed */
                        padding: 5px 10px;
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

                    .card-body {
                        padding: 25px;
                    }

                    .table th {
                        font-weight: 600;
                        color: #4a5568;
                        border-top: none;
                        background-color: #f9fafb;
                    }

                    .table td {
                        vertical-align: middle;
                    }

                    .customer-info {
                        display: flex;
                        align-items: center;
                    }

                    .customer-details {
                        margin-left: 15px;
                    }

                    .customer-name {
                        font-weight: 600;
                        margin-bottom: 3px;
                    }

                    .customer-email {
                        font-size: 12px;
                        color: #718096;
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
                                    <h3 class="fw-bold mb-3">Customer Management</h3>
                                    <ul class="breadcrumbs mb-3">
                                        <li class="nav-home">
                                            <a href="<c:url value='/admin/dashboard/index' />">
                                                <i class="icon-home"></i>
                                            </a>
                                        </li>
                                        <li class="separator">
                                            <i class="icon-arrow-right"></i>
                                        </li>
                                        <li class="nav-item">
                                            <a href="<c:url value='/admin/customer-mgr/list' />">Customers</a>
                                        </li>
                                    </ul>
                                </div>

                                <%-- Hủy chức năng thêm khách hàng của trang ADMIN --%>
                                    <!-- <div
                        class="d-flex align-items-left align-items-md-center flex-column flex-md-row pt-2 pb-4">
                        <div class="ms-md-auto py-2 py-md-0">
                            <a href="<c:url value='/admin/customer-mgr/create' />" class="btn btn-primary btn-round">
                                <i class="fas fa-plus"></i> Add New Customer
                            </a>
                        </div>
                    </div> -->

                                    <%-- Display Success and Error Messages --%>
                                        <c:if test="${not empty successMessage}">
                                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                                ${successMessage}
                                                <button type="button" class="close" data-dismiss="alert"
                                                    aria-label="Close">
                                                    <span aria-hidden="true">×</span>
                                                </button>
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty errorMessage}">
                                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                                ${errorMessage}
                                                <button type="button" class="close" data-dismiss="alert"
                                                    aria-label="Close">
                                                    <span aria-hidden="true">×</span>
                                                </button>
                                            </div>
                                        </c:if>

                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <div class="card-title">
                                                            <i class="fas fa-users mr-2 text-primary"></i>
                                                            Customer List
                                                        </div>
                                                    </div>
                                                    <div class="card-body">
                                                        <div class="table-responsive">
                                                            <table id="customerTable" class="table table-hover">
                                                                <thead>
                                                                    <tr>
                                                                        <th width="5%">No.</th>
                                                                        <th width="25%">Customer</th>
                                                                        <th width="15%">Phone</th>
                                                                        <th width="15%">Date of Birth</th>
                                                                        <th width="15%">Register Date</th>
                                                                        <th width="10%">Status</th>
                                                                        <th width="15%" class="text-center">Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:forEach var="customer" items="${customers}"
                                                                        varStatus="status">
                                                                        <tr>
                                                                            <td>${status.index + 1}</td>
                                                                            <td>
                                                                                <div class="customer-info">
                                                                                    <img src="${not empty customer.imageUrl 
                                                                            ? customer.imageUrl 
                                                                            : (ctx.concat(customer.gender ? '/resources/images-upload/customer/avatar-default-male.jpg' 
                                                                                                         : '/resources/images-upload/customer/avatar-default-female.jpg'))}"
                                                                                        class="customer-avatar"
                                                                                        alt="Avatar">
                                                                                    <div class="customer-details">
                                                                                        <div class="customer-name">
                                                                                            ${customer.firstName}
                                                                                            ${customer.lastName}
                                                                                        </div>
                                                                                        <div class="customer-email">
                                                                                            ${customer.email}
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </td>
                                                                            <td>${customer.phone}</td>
                                                                            <td>
                                                                                <fmt:formatDate
                                                                                    value="${customer.getDateOfBirthAsDate()}"
                                                                                    pattern="dd/MM/yyyy" />
                                                                            </td>
                                                                            <td>
                                                                                <fmt:formatDate
                                                                                    value="${customer.getRegistrationDateAsDate()}"
                                                                                    pattern="dd/MM/yyyy" />
                                                                            </td>
                                                                            <td>
                                                                                <span
                                                                                    class="status-badge ${customer.status ? 'bg-success text-white' : 'bg-danger text-white'}">
                                                                                    ${customer.status ? 'Active' :
                                                                                    'Inactive'}
                                                                                </span>
                                                                            </td>
                                                                            <td class="text-center">
                                                                                <div class="btn-group">
                                                                                    <a href="<c:url value='/admin/customer-mgr/detail/${customer.customerId}' />"
                                                                                        class="btn btn-sm btn-info"
                                                                                        title="View Details">
                                                                                        <i class="fas fa-eye"></i>
                                                                                    </a>
                                                                                    <a href="<c:url value='/admin/customer-mgr/update/${customer.customerId}' />"
                                                                                        class="btn btn-sm btn-primary"
                                                                                        title="Edit Customer">
                                                                                        <i class="fas fa-edit"></i>
                                                                                    </a>
                                                                                    <button type="button"
                                                                                        class="btn btn-sm btn-danger"
                                                                                        onclick="confirmDelete('${customer.customerId}', '${customer.firstName} ${customer.lastName}')"
                                                                                        title="Delete Customer">
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

                <!-- Datatables -->
                <script src="${ctx}/resources/assets/dashboard/js/plugin/datatables/datatables.min.js"></script>

                <!-- Sweet Alert -->
                <script src="${ctx}/resources/assets/dashboard/js/plugin/sweetalert/sweetalert.min.js"></script>

                <!-- Kaiadmin JS -->
                <script src="${ctx}/resources/assets/dashboard/js/kaiadmin.min.js"></script>

                <script>
                    $(document).ready(function () {
                        $('#customerTable').DataTable({
                            "pageLength": 10,
                            "responsive": true,
                            "order": [[0, "asc"]], // Default sort by first column (No.)
                            columnDefs: [
                                {
                                    targets: [6], // Actions column
                                    orderable: false,
                                    searchable: false
                                },
                                {
                                    targets: [5], // Status column (can be made searchable/orderable if needed)
                                    orderable: true, // Allow sorting by status
                                    searchable: true // Allow searching by status text e.g. "Active"
                                }
                            ]
                        });
                    });

                    function confirmDelete(customerId, customerName) {
                        swal({
                            title: "Are you sure?",
                            text: "Do you really want to delete customer '" + customerName + "'? This action cannot be undone.",
                            icon: "warning",
                            buttons: {
                                cancel: {
                                    text: "Cancel",
                                    value: null,
                                    visible: true,
                                    className: "btn btn-secondary",
                                    closeModal: true,
                                },
                                confirm: {
                                    text: "Delete",
                                    value: true,
                                    visible: true,
                                    className: "btn btn-danger",
                                    closeModal: true
                                }
                            },
                            dangerMode: true,
                        }).then((willDelete) => {
                            if (willDelete) {
                                // Construct the URL using the context path variable 'ctx'
                                window.location.href = "${ctx}/admin/customer-mgr/delete/" + customerId;
                            }
                        });
                    }
                </script>
            </body>

            </html>