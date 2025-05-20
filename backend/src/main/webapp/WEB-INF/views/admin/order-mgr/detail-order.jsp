```jsp
<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>Order Details</title>
                <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
                <link rel="icon" href="../../../../resources/assets/dashboard/img/kaiadmin/favicon.ico"
                    type="image/x-icon" />
                <script src="../../../../resources/assets/dashboard/js/plugin/webfont/webfont.min.js"></script>
                <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/bootstrap.min.css" />
                <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/plugins.min.css" />
                <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/kaiadmin.min.css" />
                <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/demo.css" />

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

                                <!-- Error Message -->
                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        ${errorMessage}
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">×</span>
                                        </button>
                                    </div>
                                </c:if>

                                <!-- Order Information -->
                                <c:if test="${not empty order}">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="card">
                                                <div class="card-header">
                                                    <h4 class="card-title">Order #${order.orderId}</h4>
                                                </div>
                                                <div class="card-body">
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <h5>Order Information</h5>
                                                            <p><strong>Order Date:</strong>
                                                                <fmt:parseDate value="${order.orderDate}"
                                                                    pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate"
                                                                    type="both" />
                                                                <fmt:formatDate value="${parsedDate}"
                                                                    pattern="dd/MM/yyyy HH:mm" />
                                                            </p>
                                                            <p><strong>Total Amount:</strong> $${order.totalAmount}</p>
                                                            <p><strong>Order Status:</strong>
                                                                <span
                                                                    class="badge ${order.orderStatus == 'COMPLETED' ? 'bg-success' : 
                                                                order.orderStatus == 'PENDING' ? 'bg-warning' : 
                                                                order.orderStatus == 'CONFIRMED' ? 'bg-primary' : 
                                                                order.orderStatus == 'SHIPPING' ? 'bg-info' : 
                                                                order.orderStatus == 'CANCELLED' ? 'bg-danger' : 
                                                                order.orderStatus == 'RETURNED' ? 'bg-secondary' : 'bg-dark'}">
                                                                    ${order.orderStatus}
                                                                </span>
                                                            </p>
                                                            <p><strong>Payment Status:</strong>
                                                                <c:choose>
                                                                    <c:when test="${order.paymentStatus == 1}">Paid
                                                                    </c:when>
                                                                    <c:when test="${order.paymentStatus == 0}">Unpaid
                                                                    </c:when>
                                                                    <c:otherwise>Unknown</c:otherwise>
                                                                </c:choose>
                                                            </p>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <h5>Customer Information</h5>
                                                            <p><strong>Name:</strong> ${order.firstName}
                                                                ${order.lastName}</p>
                                                            <p><strong>Email:</strong> ${order.email}</p>
                                                            <p><strong>Customer ID:</strong> ${order.customerId}</p>
                                                            <p><strong>Shipping Address:</strong>
                                                                ${order.shippingAddress}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Order Items -->
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="card">
                                                <div class="card-header">
                                                    <h4 class="card-title">Order Items</h4>
                                                </div>
                                                <div class="card-body">
                                                    <div class="table-responsive">
                                                        <table class="table table-hover">
                                                            <thead>
                                                                <tr>
                                                                    <th>Product</th>
                                                                    <th>Image</th>
                                                                    <th>Quantity</th>
                                                                    <th>Price</th>
                                                                    <th>Subtotal</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <c:forEach var="detail" items="${orderDetails}">
                                                                    <tr>
                                                                        <td>
                                                                            <strong>${detail.productName}</strong><br>
                                                                            <small>${detail.description}</small>
                                                                        </td>
                                                                        <td>
                                                                            <c:if test="${not empty detail.imageUrl}">
                                                                                <img src="${detail.imageUrl}"
                                                                                    alt="${detail.productName}"
                                                                                    style="max-width: 50px;" />
                                                                            </c:if>
                                                                        </td>
                                                                        <td>${detail.quantity}</td>
                                                                        <td>$${detail.orderDetailPrice}</td>
                                                                        <td>$${detail.subtotal}</td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Actions -->
                                    <div class="row">
                                        <div class="col-md-12">
                                            <a href="/admin/order-mgr/update/${order.orderId}" class="btn btn-primary">
                                                <i class="fas fa-edit"></i> Edit Order
                                            </a>
                                            <a href="/admin/order-mgr/list" class="btn btn-secondary">
                                                <i class="fas fa-arrow-left"></i> Back to List
                                            </a>
                                        </div>
                                    </div>
                                </c:if>
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
            </body>

            </html>
            ```