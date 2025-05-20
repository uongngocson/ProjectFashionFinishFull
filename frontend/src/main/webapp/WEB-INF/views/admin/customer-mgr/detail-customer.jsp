<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>Customer Details</title>
                <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
                <c:set var="ctx" value="${pageContext.request.contextPath}" />

                <link rel="icon" href="${ctx}/resources/assets/dashboard/img/kaiadmin/favicon.ico"
                    type="image/x-icon" />
                <script src="${ctx}/resources/assets/dashboard/js/plugin/webfont/webfont.min.js"></script>
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/bootstrap.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/plugins.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/kaiadmin.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/demo.css" />
                <link rel="stylesheet"
                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />

                <style>
                    .profile-img-container {
                        position: relative;
                        width: 150px;
                        height: 150px;
                        margin: 0 auto 20px;
                    }

                    .profile-img {
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                        border-radius: 50%;
                        border: 5px solid #fff;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                    }

                    .profile-badge {
                        position: absolute;
                        bottom: 10px;
                        right: 10px;
                        width: 30px;
                        height: 30px;
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        color: white;
                        font-size: 14px;
                    }

                    .nav-pills-custom .nav-link {
                        color: #718096;
                        border-radius: 0;
                        border-bottom: 2px solid transparent;
                        padding: 12px 20px;
                        font-weight: 500;
                    }

                    .nav-pills-custom .nav-link.active {
                        color: #4F46E5;
                        background: transparent;
                        border-bottom: 2px solid #4F46E5;
                    }

                    .info-card {
                        border: none;
                        border-radius: 10px;
                        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
                        margin-bottom: 25px;
                    }

                    .info-card .card-header {
                        background-color: #fff;
                        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
                        padding: 15px 20px;
                    }

                    .info-card .card-body {
                        padding: 20px;
                    }

                    .info-item {
                        margin-bottom: 20px;
                    }

                    .info-label {
                        color: #718096;
                        font-size: 13px;
                        font-weight: 500;
                        margin-bottom: 5px;
                        text-transform: uppercase;
                    }

                    .info-value {
                        font-weight: 600;
                        font-size: 15px;
                    }

                    .status-badge {
                        padding: 5px 12px;
                        border-radius: 20px;
                        font-weight: 500;
                        font-size: 12px;
                        display: inline-block;
                    }

                    .order-item-img {
                        width: 50px;
                        height: 50px;
                        object-fit: cover;
                        border-radius: 5px;
                    }

                    .chart-container {
                        height: 250px;
                    }

                    @media (max-width: 768px) {
                        .profile-img-container {
                            width: 120px;
                            height: 120px;
                        }
                    }
                </style>

            </head>

            <body>
                <div class="wrapper">
                    <jsp:include page="../layout/sidebar.jsp" />

                    <div class="main-panel">
                        <jsp:include page="../layout/header.jsp" />

                        <div class="container">
                            <div class="page-inner">
                                <div class="page-header">

                                    <h3 class="fw-bold mb-3">Customer Details</h3>
                                    <ul class="breadcrumbs mb-3">
                                        <li class="nav-home">
                                            <a href="/admin/dashboard/index">
                                                <i class="fas fa-home"></i>
                                            </a>
                                        </li>
                                        <li class="separator">
                                            <i class="fas fa-chevron-right"></i>
                                        </li>
                                        <li class="nav-item">
                                            <a href="/admin/customer-mgr/list">Customers</a>
                                        </li>
                                        <li class="separator">
                                            <i class="fas fa-chevron-right"></i>
                                        </li>
                                        <li class="nav-item">
                                            <a href="#">Detail</a>
                                        </li>
                                    </ul>
                                </div>


                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="card info-card">
                                            <div class="card-body text-center">
                                                <div class="profile-img-container">
                                                    <img src="${not empty customer.imageUrl ? customer.imageUrl : ctx.concat('/resources/images-upload/logo-is-empty.jpg')}"
                                                        class="profile-img" alt="${customer.firstName}">
                                                    <div
                                                        class="profile-badge ${customer.status ? 'bg-success' : 'bg-danger'}">
                                                        <i class="fas ${customer.status ? 'fa-check' : 'fa-times'}"></i>
                                                    </div>
                                                </div>

                                                <h4 class="mb-2">${customer.firstName} ${customer.lastName}</h4>
                                                <p class="text-muted mb-3">${customer.email}</p>

                                                <div class="d-flex justify-content-center mb-3">
                                                    <span
                                                        class="status-badge ${customer.status ? 'bg-success' : 'bg-danger'}">
                                                        ${customer.status ? 'Active' : 'Inactive'}
                                                    </span>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- <div class="card info-card">
                                            <div class="card-header">
                                                <h5 class="card-title mb-0">
                                                    <i class="fas fa-chart-pie mr-2 text-primary"></i>
                                                    Customer Stats
                                                </h5>
                                            </div>
                                            <div class="card-body">
                                                <div class="info-item">
                                                    <div class="info-label">Total Orders</div>
                                                    <div class="info-value">${not empty orders ? orders.size() : 0}
                                                    </div>
                                                </div>

                                                <div class="info-item">
                                                    <div class="info-label">Total Spending</div>
                                                    <div class="info-value">
                                                        <fmt:formatNumber value="${totalSpending}" type="currency"
                                                            currencySymbol="$" />
                                                    </div>
                                                </div>

                                                <div class="info-item">
                                                    <div class="info-label">Last Order</div>
                                                    <div class="info-value">
                                                        <c:choose>
                                                            <c:when test="${not empty lastOrderDate}">
                                                                <fmt:formatDate value="${lastOrderDate}"
                                                                    pattern="MMM dd, yyyy" />
                                                            </c:when>
                                                            <c:otherwise>
                                                                N/A
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </div>
                                        </div> -->
                                    </div>

                                    <div class="col-md-8">
                                        <div class="tab-content" id="customerTabsContent">
                                            <div class="tab-pane fade show active" id="profile" role="tabpanel">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="card info-card">
                                                            <div class="card-header">
                                                                <h5 class="card-title mb-0">
                                                                    <i class="fas fa-id-card mr-2 text-primary"></i>
                                                                    Personal Info
                                                                </h5>
                                                            </div>
                                                            <div class="card-body">
                                                                <div class="info-item">
                                                                    <div class="info-label">Customer ID</div>
                                                                    <div class="info-value">#${customer.customerId}
                                                                    </div>
                                                                </div>

                                                                <div class="info-item">
                                                                    <div class="info-label">Full Name</div>
                                                                    <div class="info-value">${customer.firstName}
                                                                        ${customer.lastName}</div>
                                                                </div>

                                                                <div class="info-item">
                                                                    <div class="info-label">Gender</div>
                                                                    <div class="info-value">${customer.gender ? 'Male' :
                                                                        'Female'}</div>
                                                                </div>

                                                                <div class="info-item">
                                                                    <div class="info-label">Date of Birth</div>
                                                                    <div class="info-value">
                                                                        <fmt:formatDate
                                                                            value="${customer.getDateOfBirthAsDate()}"
                                                                            pattern="MMM dd, yyyy" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-6">
                                                        <div class="card info-card">
                                                            <div class="card-header">
                                                                <h5 class="card-title mb-0">
                                                                    <i
                                                                        class="fas fa-address-book mr-2 text-primary"></i>
                                                                    Contact Info
                                                                </h5>
                                                            </div>
                                                            <div class="card-body">
                                                                <div class="info-item">
                                                                    <div class="info-label">Email</div>
                                                                    <div class="info-value">${customer.email}</div>
                                                                </div>

                                                                <div class="info-item">
                                                                    <div class="info-label">Phone</div>
                                                                    <div class="info-value">${customer.phone}</div>
                                                                </div>

                                                                <div class="info-item">
                                                                    <div class="info-label">Registration Date</div>
                                                                    <div class="info-value">
                                                                        <fmt:formatDate
                                                                            value="${customer.getRegistrationDateAsDate()}"
                                                                            pattern="MMM dd, yyyy" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>


                                            </div>

                                            <div class="tab-pane fade" id="orders" role="tabpanel">
                                                <div class="card info-card">
                                                    <div class="card-header">
                                                        <h5 class="card-title mb-0">
                                                            <i class="fas fa-shopping-bag mr-2 text-primary"></i>
                                                            Order History
                                                        </h5>
                                                    </div>
                                                    <div class="card-body">
                                                        <c:choose>
                                                            <c:when test="${not empty orders}">
                                                                <div class="table-responsive">
                                                                    <table class="table table-hover">
                                                                        <thead>
                                                                            <tr>
                                                                                <th>Order ID</th>
                                                                                <th>Date</th>
                                                                                <th>Amount</th>
                                                                                <th>Status</th>
                                                                                <th>Action</th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                            <c:forEach var="order" items="${orders}">
                                                                                <tr>
                                                                                    <td>#${order.orderId}</td>
                                                                                    <td>
                                                                                        <fmt:parseDate
                                                                                            value="${order.orderDate}"
                                                                                            pattern="yyyy-MM-dd'T'HH:mm"
                                                                                            var="parsedDate"
                                                                                            type="both" />
                                                                                        <fmt:formatDate
                                                                                            value="${parsedDate}"
                                                                                            pattern="MMM dd, yyyy" />
                                                                                    </td>
                                                                                    <td>$${order.totalAmount}</td>
                                                                                    <td>
                                                                                        <span
                                                                                            class="status-badge ${order.orderStatus == 'Completed' ? 'bg-success' : 
                                                                                  order.orderStatus == 'Processing' ? 'bg-primary' : 
                                                                                  order.orderStatus == 'Shipped' ? 'bg-info' : 
                                                                                  order.orderStatus == 'Cancelled' ? 'bg-danger' : 'bg-warning'}">
                                                                                            ${order.orderStatus}
                                                                                        </span>
                                                                                    </td>
                                                                                    <td>
                                                                                        <a href="/admin/order-mgr/detail/${order.orderId}"
                                                                                            class="btn btn-sm btn-outline-primary">
                                                                                            <i class="fas fa-eye"></i>
                                                                                            View
                                                                                        </a>
                                                                                    </td>
                                                                                </tr>
                                                                            </c:forEach>
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="text-center py-4">
                                                                    <i
                                                                        class="fas fa-shopping-cart fa-3x text-muted mb-3"></i>
                                                                    <h5>No Orders Found</h5>
                                                                    <p class="text-muted">This customer hasn't placed
                                                                        any orders yet.</p>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="tab-pane fade" id="activity" role="tabpanel">
                                                <div class="card info-card">
                                                    <div class="card-header">
                                                        <h5 class="card-title mb-0">
                                                            <i class="fas fa-chart-bar mr-2 text-primary"></i>
                                                            Purchase Activity
                                                        </h5>
                                                    </div>
                                                    <div class="card-body">
                                                        <div class="chart-container">
                                                            <canvas id="purchaseChart"></canvas>
                                                        </div>
                                                    </div>
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

                <script src="${ctx}/resources/assets/dashboard/js/core/jquery-3.7.1.min.js"></script>
                <script src="${ctx}/resources/assets/dashboard/js/core/popper.min.js"></script>
                <script src="${ctx}/resources/assets/dashboard/js/core/bootstrap.min.js"></script>
                <script src="${ctx}/resources/assets/dashboard/js/plugin/chart.js/chart.min.js"></script>
                <script src="${ctx}/resources/assets/dashboard/js/plugin/sweetalert/sweetalert.min.js"></script>
                <script src="${ctx}/resources/assets/dashboard/js/kai