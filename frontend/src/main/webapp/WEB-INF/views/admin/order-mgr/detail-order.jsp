<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>Order Details</title>
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
                <!-- Add Font Awesome for better icons -->
                <link rel="stylesheet"
                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />

                <!-- Custom styles for this page -->
                <style>
                    .order-status-badge {
                        padding: 8px 12px;
                        border-radius: 30px;
                        font-weight: 600;
                        font-size: 12px;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                    }

                    .timeline {
                        position: relative;
                        padding: 20px 0;
                    }

                    .timeline-item {
                        position: relative;
                        margin-bottom: 30px;
                    }

                    .timeline-badge {
                        width: 40px;
                        height: 40px;
                        border-radius: 50%;
                        text-align: center;
                        position: absolute;
                        left: 0;
                        top: 0;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        color: white;
                        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                    }

                    .timeline-badge i {
                        font-size: 16px;
                    }

                    .timeline-panel {
                        margin-left: 60px;
                        padding: 20px;
                        background: #fff;
                        border-radius: 8px;
                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                    }

                    .timeline-title {
                        font-weight: 600;
                        margin-bottom: 5px;
                    }

                    .product-item {
                        display: flex;
                        align-items: center;
                    }

                    .product-image {
                        width: 60px;
                        height: 60px;
                        border-radius: 8px;
                        object-fit: cover;
                        margin-right: 15px;
                        border: 1px solid #eee;
                    }

                    .product-details {
                        flex: 1;
                    }

                    .product-name {
                        font-weight: 600;
                        margin-bottom: 5px;
                        color: #1a73e8;
                    }

                    .info-card {
                        border-radius: 10px;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
                        border: none;
                        margin-bottom: 25px;
                    }

                    .info-card .card-header {
                        background-color: #fff;
                        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
                        padding: 20px 25px;
                    }

                    .info-card .card-body {
                        padding: 25px;
                    }

                    .info-label {
                        color: #718096;
                        font-size: 13px;
                        font-weight: 500;
                        margin-bottom: 8px;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                    }

                    .info-value {
                        font-weight: 600;
                        font-size: 16px;
                        margin-bottom: 20px;
                    }

                    .table-order-items th {
                        font-weight: 600;
                        color: #4a5568;
                        border-top: none;
                        background-color: #f9fafb;
                    }

                    .table-order-items td {
                        vertical-align: middle;
                    }

                    .table-footer {
                        background-color: #f9fafb;
                        font-weight: 600;
                    }

                    .action-buttons .btn {
                        padding: 8px 16px;
                        font-weight: 500;
                        margin-left: 10px;
                    }
                </style>

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
                                    <h3 class="fw-bold mb-3">Order Details</h3>
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
                                        <li class="separator">
                                            <i class="icon-arrow-right"></i>
                                        </li>
                                        <li class="nav-item">
                                            <a href="#">Order #${order.orderId}</a>
                                        </li>
                                    </ul>
                                </div>

                                <!-- Order Information Card -->
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card info-card">
                                            <div class="card-header">
                                                <div class="d-flex align-items-center">
                                                    <h4 class="card-title mb-0">
                                                        <i class="fas fa-info-circle mr-2 text-primary"></i>
                                                        Order Information
                                                    </h4>
                                                    <div class="ml-auto action-buttons">
                                                        <a href="/admin/order-mgr/update/${order.orderId}"
                                                            class="btn btn-primary btn-round">
                                                            <i class="fa fa-edit mr-1"></i> Edit
                                                        </a>
                                                        <button class="btn btn-danger btn-round"
                                                            onclick="deleteOrder('${order.orderId}')">
                                                            <i class="fa fa-trash mr-1"></i> Delete
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="card-body">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="mb-4">
                                                            <div class="info-label">Order ID</div>
                                                            <div class="info-value">#${order.orderId}</div>
                                                        </div>
                                                        <div class="mb-4">
                                                            <div class="info-label">Order Date</div>
                                                            <div class="info-value">
                                                                <i class="far fa-calendar-alt mr-2 text-muted"></i>
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
                                                                    ${order.customer.phoneNumber}</div>
                                                            </div>
                                                        </div>
                                                        <div class="mb-4">
                                                            <div class="info-label">Shipping Address</div>
                                                            <div class="info-value">
                                                                <i class="fas fa-map-marker-alt mr-2 text-muted"></i>
                                                                ${order.shippingAddress.street}
                                                            </div>
                                                            <div class="mt-2">
                                                                <div>${order.shippingAddress.ward},
                                                                    ${order.shippingAddress.district}
                                                                    ${order.shippingAddress.province}</div>
                                                                <div>${order.shippingAddress.city}</div>
                                                            </div>
                                                        </div>
                                                        <div class="mb-4">
                                                            <div class="info-label">Payment Information</div>
                                                            <div class="info-value">
                                                                <i class="fas fa-credit-card mr-2 text-muted"></i>
                                                                ${order.payment.namePaymentMethod}
                                                            </div>
                                                            <div class="mt-2">
                                                                <strong>Status:</strong>
                                                                <span
                                                                    class="order-status-badge ${order.paymentStatus == 'Paid' ? 'bg-success' : 
                                                        order.paymentStatus == 'Pending' ? 'bg-warning' : 
                                                        order.paymentStatus == 'Failed' ? 'bg-danger' : 'bg-secondary'}">
                                                                    <i
                                                                        class="fas ${order.paymentStatus == 'Paid' ? 'fa-check-circle' : 
                                                            order.paymentStatus == 'Pending' ? 'fa-clock' : 
                                                            order.paymentStatus == 'Failed' ? 'fa-times-circle' : 'fa-question-circle'} mr-1"></i>
                                                                    ${order.paymentStatus}
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Order Details Table -->
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card info-card">
                                            <div class="card-header">
                                                <div class="card-title mb-0">
                                                    <i class="fas fa-shopping-cart mr-2 text-primary"></i>
                                                    Order Items
                                                </div>
                                            </div>
                                            <div class="card-body">
                                                <div class="table-responsive">
                                                    <table class="table table-hover table-order-items">
                                                        <thead>
                                                            <tr>
                                                                <th width="5%">#</th>
                                                                <th width="45%">Product</th>
                                                                <th width="15%">Quantity</th>
                                                                <th width="15%">Price</th>
                                                                <th width="20%" class="text-right">Total</th>
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
                                                                                    ${orderDetail.product.productName}
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <span
                                                                            class="badge badge-pill bg-light text-dark">
                                                                            ${orderDetail.quantity}
                                                                        </span>
                                                                    </td>
                                                                    <td>$${orderDetail.price}</td>
                                                                    <td class="text-right font-weight-bold">
                                                                        $${orderDetail.price * orderDetail.quantity}
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                        <tfoot>
                                                            <tr class="table-footer">
                                                                <td colspan="4" class="text-right h5">Total</td>
                                                                <td class="text-right h5 text-primary">
                                                                    $${order.totalAmount}</td>
                                                            </tr>
                                                        </tfoot>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Order Timeline -->
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card info-card">
                                            <div class="card-header">
                                                <div class="card-title mb-0">
                                                    <i class="fas fa-history mr-2 text-primary"></i>
                                                    Order Timeline
                                                </div>
                                            </div>
                                            <div class="card-body">
                                                <div class="timeline">
                                                    <div class="timeline-item">
                                                        <div class="timeline-badge bg-success">
                                                            <i class="fas fa-shopping-cart"></i>
                                                        </div>
                                                        <div class="timeline-panel">
                                                            <div class="timeline-heading">
                                                                <h4 class="timeline-title">Order Placed</h4>
                                                                <p>
                                                                    <small class="text-muted">
                                                                        <i class="far fa-clock mr-1"></i>
                                                                        <fmt:parseDate value="${order.orderDate}"
                                                                            pattern="yyyy-MM-dd'T'HH:mm"
                                                                            var="parsedDate" type="both" />
                                                                        <fmt:formatDate value="${parsedDate}"
                                                                            pattern="dd/MM/yyyy HH:mm" />
                                                                    </small>
                                                                </p>
                                                            </div>
                                                            <div class="timeline-body">
                                                                <p>Order #${order.orderId} was placed by
                                                                    ${order.customer.firstName}
                                                                    ${order.customer.lastName}</p>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <c:if
                                                        test="${order.orderStatus == 'Processing' || order.orderStatus == 'Shipped' || order.orderStatus == 'Delivered' || order.orderStatus == 'Completed'}">
                                                        <div class="timeline-item">
                                                            <div class="timeline-badge bg-primary">
                                                                <i class="fas fa-cog"></i>
                                                            </div>
                                                            <div class="timeline-panel">
                                                                <div class="timeline-heading">
                                                                    <h4 class="timeline-title">Order Processing</h4>
                                                                    <p><small class="text-muted"><i
                                                                                class="far fa-clock mr-1"></i> After
                                                                            order placement</small></p>
                                                                </div>
                                                                <div class="timeline-body">
                                                                    <p>Order is being processed and prepared for
                                                                        shipping</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:if>


                                                    <c:if test="${order.orderStatus == 'Cancelled'}">
                                                        <div class="timeline-item">
                                                            <div class="timeline-badge bg-danger">
                                                                <i class="fas fa-times"></i>
                                                            </div>
                                                            <div class="timeline-panel">
                                                                <div class="timeline-heading">
                                                                    <h4 class="timeline-title">Order Cancelled</h4>
                                                                    <p><small class="text-muted"><i
                                                                                class="far fa-clock mr-1"></i> After
                                                                            order placement</small></p>
                                                                </div>
                                                                <div class="timeline-body">
                                                                    <p>Order has been cancelled</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:if>
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

                    <!-- Sweet Alert -->
                    <script src="${ctx}/resources/assets/dashboard/js/plugin/sweetalert/sweetalert.min.js"></script>

                    <!-- Kaiadmin JS -->
                    <script src="${ctx}/resources/assets/dashboard/js/kaiadmin.min.js"></script>

                    <script>
                        // Delete confirmation
                        function deleteOrder(orderId) {
                            swal({
                                title: "Are you sure?",
                                text: "Once deleted, you will not be able to recover this order!",
                                icon: "warning",
                                buttons: true,
                                dangerMode: true,
                            })
                                .then((willDelete) => {
                                    if (willDelete) {
                                        window.location.href = "/admin/order-mgr/delete/" + orderId;
                                    }
                                });
                        }
                    </script>
                </div>
            </body>

            </html>