<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Edit Order</title>
    <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
    <link rel="icon" href="../../../../resources/assets/dashboard/img/kaiadmin/favicon.ico" type="image/x-icon" />
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
        <jsp:include page="../layout/sidebar.jsp" />
        <div class="main-panel">
            <jsp:include page="../layout/header.jsp" />
            <div class="container">
                <div class="page-inner">
                    <div class="page-header">
                        <h3 class="fw-bold mb-3">Edit Order #${order.orderId != null ? order.orderId : 'Unknown'}</h3>
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
                                <a href="#">Edit Order</a>
                            </li>
                        </ul>
                    </div>
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${errorMessage}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                    </c:if>
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${successMessage}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                    </c:if>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">Edit Order</h4>
                                </div>
                                <div class="card-body">
                                    <c:if test="${order.orderId == null}">
                                        <div class="alert alert-warning">
                                            No order data available. Please check if the order exists.
                                        </div>
                                    </c:if>
                                    <c:if test="${order.orderId != null}">
                                        <form action="/admin/order-mgr/save" method="post">
                                            <sec:csrfInput />
                                            <input type="hidden" name="orderId" value="${order.orderId != null ? order.orderId : ''}" />
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <h5>Order Information</h5>
                                                    <div class="form-group">
                                                        <label>Order ID</label>
                                                        <input type="text" class="form-control" 
                                                               value="${order.orderId != null ? order.orderId : 'Unknown'}" readonly />
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Order Date</label>
                                                        <c:choose>
                                                            <c:when test="${order.orderDate != null}">
                                                                <fmt:parseDate value="${order.orderDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
                                                                <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm" var="formattedDate" />
                                                                <input type="text" class="form-control" value="${formattedDate}" readonly />
                                                            </c:when>
                                                            <c:otherwise>
                                                                <input type="text" class="form-control" value="Unknown" readonly />
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Total Amount</label>
                                                        <input type="text" class="form-control" 
                                                               value="${order.totalAmount != null ? '$'.concat(order.totalAmount) : 'Unknown'}" readonly />
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Shipping Address</label>
                                                        <input type="text" class="form-control" 
                                                               value="${order.shippingAddress != null ? order.shippingAddress.fullAddress : 'Unknown'}" readonly />
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Payment Method</label>
                                                        <input type="text" class="form-control" 
                                                               value="${order.payment != null && order.payment.paymentMethod != null ? order.payment.paymentMethod : 'Unknown'}" readonly />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <h5>Customer Information</h5>
                                                    <div class="form-group">
                                                        <label>Customer Name</label>
                                                        <input type="text" class="form-control" 
                                                               value="${order.customer != null && order.customer.firstName != null && order.customer.lastName != null ? order.customer.firstName.concat(' ').concat(order.customer.lastName) : 'Unknown'}" readonly />
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Email</label>
                                                        <input type="text" class="form-control" 
                                                               value="${order.customer != null && order.customer.email != null ? order.customer.email : 'Unknown'}" readonly />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label for="orderStatus">Order Status</label>
                                                        <select class="form-control" id="orderStatus" name="orderStatus" required>
                                                            <c:forEach var="status" items="${possibleStatuses}">
                                                                <option value="${status}" ${order.orderStatus == status ? 'selected' : ''}>
                                                                    ${status}
                                                                </option>
                                                            </c:forEach>
                                                        </select>
                                                        <c:if test="${empty possibleStatuses}">
                                                            <p class="text-danger">No order statuses available.</p>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label for="paymentStatus">Payment Status</label>
                                                        <select class="form-control" id="paymentStatus" name="paymentStatus" required>
                                                            <c:forEach var="status" items="${paymentStatuses}">
                                                                <option value="${status.value}" ${order.paymentStatus == status.value ? 'selected' : ''}>
                                                                    ${status.label}
                                                                </option>
                                                            </c:forEach>
                                                        </select>
                                                        <c:if test="${empty paymentStatuses}">
                                                            <p class="text-danger">No payment statuses available.</p>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="fas fa-save"></i> Save Changes
                                                </button>
                                                <a href="/admin/order-mgr/list" class="btn btn-secondary">
                                                    <i class="fas fa-arrow-left"></i> Cancel
                                                </a>
                                            </div>
                                        </form>
                                    </c:if>
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
    <script src="../../../../resources/assets/dashboard/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>
    <script src="../../../../resources/assets/dashboard/js/kaiadmin.min.js"></script>
</body>
</html>