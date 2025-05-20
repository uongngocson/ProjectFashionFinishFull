```jsp
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Order Management</title>
    <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
    <link rel="icon" href="../../../../resources/assets/dashboard/img/kaiadmin/favicon.ico" type="image/x-icon" />
    <script src="../../../../resources/assets/dashboard/js/plugin/webfont/webfont.min.js"></script>
    <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/bootstrap.min.css" />
    <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/plugins.min.css" />
    <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/kaiadmin.min.css" />
    <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/demo.css" />
    <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/plugin/datatables/datatables.min.css" />

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
                                <a href="/admin/dashboard/index">
                                    <i class="icon-home"></i>
                                </a>
                            </li>
                            <li class="separator">
                                <i class="icon-arrow-right"></i>
                            </li>
                            <li class="nav-item">
                                <a href="/admin/order-mgr/list">Orders</a>
                            </li>
                        </ul>
                    </div>

                    <%-- Display Success and Error Messages --%>
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${successMessage}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                    </c:if>
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${errorMessage}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                    </c:if>

                    <!-- Start order tabs -->
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">Orders by Status</h4>
                                </div>
                                <div class="card-body">
                                    <!-- Nav tabs -->
                                    <ul class="nav nav-tabs" id="orderStatusTabs" role="tablist">
                                        <c:forEach var="status" items="${possibleStatuses}" varStatus="loop">
                                            <li class="nav-item">
                                                <a class="nav-link ${loop.first ? 'active' : ''}" id="${status}-tab" data-bs-toggle="tab" href="#${status}" role="tab" aria-controls="${status}" aria-selected="${loop.first}">
                                                    ${status} <span class="badge bg-secondary">${ordersByStatus[status] != null ? ordersByStatus[status].size() : 0}</span>
                                                </a>
                                            </li>
                                        </c:forEach>
                                    </ul>

                                    <!-- Tab content -->
                                    <div class="tab-content" id="orderStatusTabContent">
                                        <c:forEach var="status" items="${possibleStatuses}" varStatus="loop">
                                            <div class="tab-pane fade ${loop.first ? 'show active' : ''}" id="${status}" role="tabpanel" aria-labelledby="${status}-tab">
                                                <div class="table-responsive">
                                                    <table id="table-${fn:replace(status, ' ', '-')}" class="table table-hover">
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
                                                            <c:forEach var="order" items="${ordersByStatus[status]}" varStatus="statusLoop">
                                                                <tr>
                                                                    <td>${statusLoop.index + 1}</td>
                                                                    <td><a href="/admin/order-mgr/detail/${order.orderId}" class="text-primary">#${order.orderId}</a></td>
                                                                    <td>${order.customer.firstName} ${order.customer.lastName}</td>
                                                                    <td>
                                                                        <fmt:parseDate value="${order.orderDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                                                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm" />
                                                                    </td>
                                                                    <td>$${order.totalAmount}</td>
                                                                    <td>
                                                                        <span class="badge ${order.orderStatus == 'COMPLETED' ? 'bg-success' : 
                                                                                    order.orderStatus == 'PENDING' ? 'bg-warning' : 
                                                                                    order.orderStatus == 'CONFIRMED' ? 'bg-primary' : 
                                                                                    order.orderStatus == 'SHIPPING' ? 'bg-info' : 
                                                                                    order.orderStatus == 'CANCELLED' ? 'bg-danger' : 
                                                                                    order.orderStatus == 'RETURNED' ? 'bg-secondary' : 'bg-dark'}">
                                                                            ${order.orderStatus}
                                                                        </span>
                                                                    </td>
                                                                    <td>
                                                                        <div class="btn-group">
                                                                            <a href="/admin/order-mgr/detail/${order.orderId}" class="btn btn-sm btn-info">
                                                                                <i class="fas fa-eye"></i>
                                                                            </a>
                                                                            <a href="/admin/order-mgr/update/${order.orderId}" class="btn btn-sm btn-primary">
                                                                                <i class="fas fa-edit"></i>
                                                                            </a>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </c:forEach>
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
    <script src="../../../../resources/assets/dashboard/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

    <!-- KaiAdmin JS -->
    <script src="../../../../resources/assets/dashboard/js/kaiadmin.min.js"></script>

    <!-- DataTables JS -->
    <script src="../../../../resources/assets/dashboard/js/plugin/datatables/datatables.min.js"></script>

    <script>
        $(document).ready(function () {
            // Initialize DataTables for each status tab
            <c:forEach var="status" items="${possibleStatuses}">
                // Sanitize status to create valid ID
                var tableId = 'table-' + '${status}'.replace(/[^a-zA-Z0-9-_]/g, '-');
                if ($('#' + tableId).length) {
                    $('#' + tableId).DataTable({
                        "pageLength": 10,
                        lengthMenu: [5, 10, 25, 50, 100],
                        columnDefs: [
                            {
                                targets: [6], // Actions column (View and Edit)
                                orderable: false,
                                searchable: false
                            }
                        ],
                        responsive: true,
                        destroy: true
                    });
                }
            </c:forEach>

            // Reinitialize DataTable when a tab is shown
            $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
                $($.fn.dataTable.tables()).DataTable().columns.adjust().responsive.recalc();
            });
        });
    </script>
</body>

</html>
```