<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>Shipper Order Detail</title>
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
                <link rel="stylesheet"
                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">


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
                    .info-label {
                        font-weight: bold;
                        color: #555;
                    }

                    .info-value {
                        margin-left: 10px;
                    }

                    .order-status-badge {
                        padding: .25em .5em;
                        border-radius: .25rem;
                        color: #fff;
                        font-weight: bold;
                    }

                    .bg-success {
                        background-color: #28a745 !important;
                    }

                    .bg-primary {
                        background-color: #007bff !important;
                    }

                    .bg-info {
                        background-color: #17a2b8 !important;
                    }

                    .bg-danger {
                        background-color: #dc3545 !important;
                    }

                    .bg-warning {
                        background-color: #ffc107 !important;
                    }

                    .product-item {
                        display: flex;
                        align-items: center;
                    }

                    .product-details {
                        margin-left: 10px;
                    }

                    .product-name {
                        font-weight: bold;
                    }
                </style>
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
                                    <h4 class="page-title">Order Detail</h4>
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
                                            <a href="${ctx}/shipper/order/list">Order Confirmation</a>
                                        </li>
                                        <li class="separator">
                                            <i class="icon-arrow-right"></i>
                                        </li>
                                        <li class="nav-item">
                                            <a href="#">Order Detail</a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <div class="d-flex align-items-center">
                                                    <h4 class="card-title">Order Details for Order ID: ${order.orderId}
                                                    </h4>
                                                    <div class="ml-auto">
                                                        <a href="${ctx}/shipper/order/list"
                                                            class="btn btn-secondary btn-round ml-auto">
                                                            <i class="fa fa-arrow-left"></i> Back to List
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="card-body">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="mb-4">
                                                            <div class="info-label">Order ID</div>
                                                            <div class="info-value">${order.orderId}</div>
                                                        </div>
                                                        <div class="mb-4">
                                                            <div class="info-label">Order Date</div>
                                                            <div class="info-value">
                                                                <fmt:parseDate value="${order.orderDate}"
                                                                    pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate"
                                                                    type="both" />
                                                                <fmt:formatDate value="${parsedDate}"
                                                                    pattern="dd/MM/yyyy HH:mm" />
                                                            </div>
                                                        </div>
                                                        <div class="mb-4">
                                                            <div class="info-label">Order Status</div>
                                                            <div class="info-value">
                                                                <span
                                                                    class="order-status-badge ${order.orderStatus == 'Completed' ? 'bg-success' :
                                                        order.orderStatus == 'Processing' ? 'bg-primary' :
                                                        order.orderStatus == 'Shipped' ? 'bg-info' :
                                                        order.orderStatus == 'Cancelled' ? 'bg-danger' : 'bg-warning'}">
                                                                    <i
                                                                        class="fas ${order.orderStatus == 'Completed' ? 'fa-check-circle' :
                                                            order.orderStatus == 'Processing' ? 'fa-cog' :
                                                            order.orderStatus == 'Shipped' ? 'fa-shipping-fast' :
                                                            order.orderStatus == 'Cancelled' ? 'fa-times-circle' : 'fa-clock'} mr-1"></i>
                                                                    ${order.orderStatus}
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="mb-4">
                                                            <div class="info-label">Customer</div>
                                                            <div class="info-value">
                                                                <i class="fas fa-user mr-2 text-muted"></i>
                                                                ${order.customer.firstName} ${order.customer.lastName}
                                                            </div>
                                                            <div class="mt-2">
                                                                <div><i class="fas fa-envelope mr-2 text-muted"></i>
                                                                    ${order.customer.email}</div>
                                                                <div><i class="fas fa-phone mr-2 text-muted"></i>
                                                                    ${order.customer.phone}</div>
                                                            </div>
                                                        </div>
                                                        <div class="mb-4">
                                                            <div class="info-label">Shipping Address</div>
                                                            <div class="info-value">
                                                                <i class="fas fa-map-marker-alt mr-2 text-muted"></i>
                                                                ${order.shippingAddress.street}
                                                            </div>
                                                            <div class="mt-2">
                                                                <div>${order.shippingAddress.ward.wardName},
                                                                    ${order.shippingAddress.district.districtName},
                                                                    ${order.shippingAddress.province.provinceName}</div>
                                                            </div>
                                                        </div>
                                                        <div class="mb-4">
                                                            <div class="info-label">Payment Information</div>
                                                            <div class="info-value">
                                                                <i class="fas fa-credit-card mr-2 text-muted"></i>
                                                                ${order.payment.paymentMethod}
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
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
                                <!-- Order Details Table -->
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <h4 class="card-title">Order Items</h4>
                                            </div>
                                            <div class="card-body">
                                                <div class="table-responsive">
                                                    <table class="table table-bordered">
                                                        <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>Product</th>
                                                                <th>Quantity</th>
                                                                <th>Price</th>
                                                                <th>Subtotal</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="orderDetail" items="${orderDetails}"
                                                                varStatus="status">
                                                                <tr>
                                                                    <td>${status.index + 1}</td>
                                                                    <td>
                                                                        <div class="product-item">
                                                                            <div class="product-details">
                                                                                <div class="product-name">
                                                                                    ${orderDetail.productVariant.product.productName}
                                                                                </div>
                                                                                <div>Variant:
                                                                                    ${orderDetail.productVariant.SKU}
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td>${orderDetail.quantity}</td>
                                                                    <td>
                                                                        <fmt:formatNumber value="${orderDetail.price}"
                                                                            type="currency" currencySymbol="VND" />
                                                                    </td>
                                                                    <td>
                                                                        <fmt:formatNumber
                                                                            value="${orderDetail.quantity * orderDetail.price}"
                                                                            type="currency" currencySymbol="VND" />
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                        <tfoot>
                                                            <tr>
                                                                <td colspan="4" class="text-right"><strong>Total
                                                                        Amount:</strong></td>
                                                                <td>
                                                                    <fmt:formatNumber value="${order.totalAmount}"
                                                                        type="currency" currencySymbol="VND" />
                                                                </td>
                                                            </tr>
                                                        </tfoot>
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

            </body>

            </html>