<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>Order Management</title>
                <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
                <link rel="icon" href="../../../../resources/assets/dashboard/img/kaiadmin/favicon.ico"
                    type="image/x-icon" />
                <script src="../../../../resources/assets/dashboard/js/plugin/webfont/webfont.min.js"></script>
                <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/bootstrap.min.css" />
                <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/plugins.min.css" />
                <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/kaiadmin.min.css" />
                <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/demo.css" />

                <link rel="stylesheet"
                    href="../../../../resources/assets/dashboard/js/plugin/datatables/datatables.min.js" />

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
                    <!-- Sidebar -->
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div class="main-panel">
                        <jsp:include page="../layout/header.jsp" />
                        <div class="container">
                            <div class="page-inner">
                                <div class="page-header">
                                    <h3 class="fw-bold mb-3">Orders</h3>
                                    <ul class="breadcrumbs mb-3">
                                        <li class="nav-home">
                                            <a href="/employee/dashboard/index">
                                                <i class="icon-home"></i>
                                            </a>
                                        </li>
                                        <li class="separator">
                                            <i class="icon-arrow-right"></i>
                                        </li>
                                        <li class="nav-item">
                                            <a href="/employee/order-mgr/list">Orders</a>
                                        </li>
                                    </ul>
                                </div>

                                <%-- Display Success and Error Messages --%>
                                    <c:if test="${not empty successMessage}">
                                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                                            ${successMessage}
                                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty errorMessage}">
                                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                            ${errorMessage}
                                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                    </c:if>

                                    <!-- start order datatable -->
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="card">
                                                <div class="card-header">
                                                    <div class="d-flex align-items-center">
                                                        <h4 class="card-title">Orders list</h4>
                                                        <!-- <a href="/employee/order-mgr/create"
                                                        class="btn btn-primary btn-round ms-auto">
                                                        <i class="fas fa-plus"></i> Add New Order
                                                    </a> -->
                                                    </div>
                                                </div>
                                                <div class="card-body">
                                                    <div class="table-responsive">
                                                        <table id="add-row" class="table table-hover">
                                                            <thead>
                                                                <tr>
                                                                    <th>No.</th>
                                                                    <th>ID</th>
                                                                    <th>Customer</th>
                                                                    <th>Order Date</th>
                                                                    <th>Total Amount</th>
                                                                    <th>Order Status</th>
                                                                    <th>Actions</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <c:forEach var="order" items="${orders}"
                                                                    varStatus="status">
                                                                    <tr>
                                                                        <td>${status.index+1}</td>
                                                                        <td><a href="/employee/order-mgr/detail/${order.orderId}"
                                                                                class="text-primary">#${order.orderId}</a>
                                                                        </td>
                                                                        <td>${order.customer.firstName}
                                                                            ${order.customer.lastName}</td>
                                                                        <td>
                                                                            <fmt:parseDate value="${order.orderDate}"
                                                                                pattern="yyyy-MM-dd'T'HH:mm"
                                                                                var="parsedDate" type="both" />
                                                                            <fmt:formatDate value="${parsedDate}"
                                                                                pattern="dd/MM/yyyy HH:mm" />
                                                                        </td>

                                                                        <td>$${order.totalAmount}</td>
                                                                        <td>
                                                                            <span
                                                                                class="badge ${order.orderStatus == 'Completed' ? 'bg-success' : 
                                                                        order.orderStatus == 'Processing' ? 'bg-primary' : 
                                                                        order.orderStatus == 'Shipped' ? 'bg-info' : 
                                                                        order.orderStatus == 'Cancelled' ? 'bg-danger' : 'bg-warning'}">
                                                                                ${order.orderStatus}
                                                                            </span>
                                                                        </td>
                                                                        <td>
                                                                            <div class="btn-group">
                                                                                <a href="/employee/order-mgr/detail/${order.orderId}"
                                                                                    class="btn btn-sm btn-info">
                                                                                    <i class="fas fa-eye"></i>
                                                                                </a>
                                                                                <a href="/employee/order-mgr/update/${order.orderId}"
                                                                                    class="btn btn-sm btn-primary">
                                                                                    <i class="fas fa-edit"></i>
                                                                                </a>
                                                                                <%-- Update delete button to use a form
                                                                                    or a more robust JS confirmation
                                                                                    --%>
                                                                                    <button type="button"
                                                                                        class="btn btn-sm btn-danger"
                                                                                        onclick="confirmDeleteOrder('${order.orderId}')">
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

                <!-- Core JS Files -->
                <script src="../../../../resources/assets/dashboard/js/core/jquery-3.7.1.min.js"></script>
                <script src="../../../../resources/assets/dashboard/js/core/popper.min.js"></script>
                <script src="../../../../resources/assets/dashboard/js/core/bootstrap.min.js"></script>

                <!-- Scrollbar Plugin -->
                <script
                    src="../../../../resources/assets/dashboard/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

                <!-- KaiAdmin JS -->
                <script src="../../../../resources/assets/dashboard/js/kaiadmin.min.js"></script>

                <!-- DataTables JS -->
                <script src="../../../../resources/assets/dashboard/js/plugin/datatables/datatables.min.js"></script>

                <!-- Sweet Alert -->
                <script src="../../../../resources/assets/dashboard/js/plugin/sweetalert/sweetalert.min.js"></script>

                <script>
                    $(document).ready(function () {
                        $('#add-row').DataTable({
                            "pageLength": 10,
                            lengthMenu: [5, 10, 25, 50, 100],
                            columnDefs: [
                                {
                                    targets: [6], // Target the Actions column
                                    orderable: false,
                                    searchable: false
                                }
                            ]
                        });
                    });

                    // Delete confirmation and form submission
                    function confirmDeleteOrder(orderId) {
                        swal({
                            title: "Are you sure you want to delete this order (#" + orderId + ")?",
                            text: "This action cannot be undone.",
                            icon: "warning",
                            buttons: {
                                cancel: {
                                    text: "Cancel",
                                    value: null,
                                    visible: true,
                                    className: "btn btn-default",
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
                                // Redirect to the delete URL (which is a GET request handled by Spring MVC)
                                window.location.href = "/employee/order-mgr/delete/" + orderId;
                            }
                        });
                    }
                </script>
            </body>

            </html>