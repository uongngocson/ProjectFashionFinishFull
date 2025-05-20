<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>Shipper Order Confirmation</title>
                <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
                <!-- set path -->
                <c:set var="ctx" value="${pageContext.request.contextPath}" />

                <link rel="icon" href="${ctx}/resources/assets/dashboard/img/kaiadmin/favicon.ico"
                    type="image/x-icon" />
                <script src="${ctx}/resources/assets/dashboard/js/plugin/webfont/webfont.min.js"></script>
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/bootstrap.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/plugins.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/kaiadmin.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/demo.css" />

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
                                    <h4 class="page-title">Order Confirmation</h4>
                                    <ul class="breadcrumbs">
                                        <li class="nav-home">
                                            <a href="#">
                                                <i class="icon-home"></i>
                                            </a>
                                        </li>
                                        <li class="separator">
                                            <i class="icon-arrow-right"></i>
                                        </li>
                                        <li class="nav-item">
                                            <a href="#">Order Management</a>
                                        </li>
                                        <li class="separator">
                                            <i class="icon-arrow-right"></i>
                                        </li>
                                        <li class="nav-item">
                                            <a href="#">Order Confirmation</a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <c:if test="${not empty successMessage}">
                                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                                ${successMessage}
                                                <button type="button" class="close" data-dismiss="alert"
                                                    aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty errorMessage}">
                                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                                ${errorMessage}
                                                <button type="button" class="close" data-dismiss="alert"
                                                    aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="card">
                                        <div class="card-header">
                                            <div class="d-flex align-items-center">
                                                <h4 class="card-title">Confirmed Orders List</h4>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div class="table-responsive">
                                                <table id="add-row" class="display table table-striped table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>Order ID</th>
                                                            <th>Customer Name</th>
                                                            <th>Order Date</th>
                                                            <th>Total Amount</th>
                                                            <th>Status</th>
                                                            <th style="width: 10%">Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>

                                                        <c:forEach var="order" items="${confirmedOrders}">
                                                            <tr>
                                                                <td>${order.orderId}</td>
                                                                <td>${order.customer.firstName}
                                                                    ${order.customer.lastName}</td>
                                                                <td>
                                                                    <fmt:parseDate value="${order.orderDate}"
                                                                        pattern="yyyy-MM-dd'T'HH:mm:ss.SSS"
                                                                        var="parsedOrderDate" type="both" />
                                                                    <fmt:formatDate value="${parsedOrderDate}"
                                                                        pattern="dd/MM/yyyy HH:mm" />
                                                                </td>
                                                                <td>
                                                                    <fmt:formatNumber value="${order.totalAmount}"
                                                                        type="currency" currencySymbol="VND" />
                                                                </td>
                                                                <td>${order.orderStatus}</td>
                                                                <td>
                                                                    <div class="form-button-action">
                                                                        <%-- Nút Xem chi tiết --%>
                                                                            <a href="${ctx}/shipper/order/detail?orderId=${order.orderId}"
                                                                                data-toggle="tooltip"
                                                                                title="Xem chi tiết"
                                                                                class="btn btn-link btn-info btn-lg">
                                                                                <i class="fa fa-eye"></i>
                                                                            </a>
                                                                            <%-- Nút Xác nhận giao đơn (tạo shipment)
                                                                                --%>
                                                                                <button type="button"
                                                                                    data-toggle="tooltip"
                                                                                    title="Xác nhận giao đơn"
                                                                                    class="btn btn-link btn-primary btn-lg"
                                                                                    onclick="confirmCreateShipment('${order.orderId}')">
                                                                                    <i class="fa fa-check"></i>
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

                <!-- Chart Circle -->
                <script src="${ctx}/resources/assets/dashboard/js/plugin/chart-circle/circles.min.js"></script>

                <!-- Datatables -->
                <script src="${ctx}/resources/assets/dashboard/js/plugin/datatables/datatables.min.js"></script>

                <!-- jQuery Sparkline -->
                <script
                    src="${ctx}/resources/assets/dashboard/js/plugin/jquery.sparkline/jquery.sparkline.min.js"></script>

                <!-- Kaiadmin JS -->
                <script src="${ctx}/resources/assets/dashboard/js/kaiadmin.min.js"></script>

                <!-- Kaiadmin DEMO methods, don't include it in your project! -->
                <script src="${ctx}/resources/assets/dashboard/js/setting-demo.js"></script>
                <script src="${ctx}/resources/assets/dashboard/js/demo.js"></script>

                <script>
                    $(document).ready(function () {
                        $('#add-row').DataTable({
                            "pageLength": 5,
                        });
                    });

                    function confirmCreateShipment(orderId) {
                        if (confirm('Bạn có chắc chắn muốn nhận đơn hàng này?')) {
                            window.location.href = '${ctx}/shipper/shipment/create?orderId=' + orderId;
                        }
                    }
                </script>
            </body>

            </html>