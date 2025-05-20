<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <title>${order.orderId != null ? 'Update' : 'Create'} Order</title>
                    <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
                    <!-- set path -->
                    <c:set var="ctx" value="${pageContext.request.contextPath}" />

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
                                        <h3 class="fw-bold mb-3">${order.orderId != null ? 'Update' : 'Create'} Order
                                        </h3>
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
                                                <a href="#">${order.orderId != null ? 'Update' : 'Create'} Order</a>
                                            </li>
                                        </ul>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="card">
                                                <div class="card-header">
                                                    <div class="card-title">Order Information</div>
                                                </div>
                                                <div class="card-body">
                                                    <form:form action="/admin/order-mgr/save" method="post"
                                                        modelAttribute="order">
                                                        <c:if test="${isNewOrder}">
                                                            <form:hidden path="orderId" />
                                                            <div class="form-group">
                                                                <label>Order ID will be automatically generated</label>
                                                            </div>
                                                        </c:if>
                                                        <c:if test="${!isNewOrder}">
                                                            <div class="form-group">
                                                                <label for="orderId">Order ID</label>
                                                                <form:input path="orderId" class="form-control"
                                                                    readonly="true" />
                                                            </div>
                                                        </c:if>

                                                        <div class="row mb-4">
                                                            <div class="col-md-6">
                                                                <div class="mb-3">
                                                                    <label class="fw-bold">Customer <span
                                                                            class="text-danger">*</span></label>
                                                                    <form:select path="customer"
                                                                        class="form-control form-control-lg">
                                                                        <form:option value=""
                                                                            label="-- Select Customer --" />
                                                                        <c:forEach items="${customers}" var="customer">
                                                                            <form:option value="${customer.customerId}"
                                                                                label="${customer.firstName} ${customer.lastName}" />
                                                                        </c:forEach>
                                                                    </form:select>

                                                                    <form:errors path="customer"
                                                                        cssClass="text-danger" />
                                                                </div>
                                                            </div>

                                                            <div class="col-md-6">
                                                                <div class="mb-3">
                                                                    <label class="fw-bold">Order Date <span
                                                                            class="text-danger">*</span></label>
                                                                    <form:input path="orderDate" type="datetime-local"
                                                                        class="form-control form-control-lg"
                                                                        required="true" />
                                                                    <form:errors path="orderDate"
                                                                        cssClass="text-danger" />
                                                                </div>
                                                            </div>
                                                        </div>



                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="fw-bold">Shipping Address <span
                                                                        class="text-danger">*</span></label>
                                                                <form:select path="shippingAddress"
                                                                    class="form-control form-control-lg">
                                                                    <form:option value=""
                                                                        label="-- Select Shipping Address --" />
                                                                    <c:forEach items="${addresses}" var="address">
                                                                        <form:option value="${address.addressId}"
                                                                            label="${address.street}, ${address.ward}, ${address.district}, ${address.province}, ${address.city}" />
                                                                    </c:forEach>
                                                                </form:select>
                                                                <form:errors path="shippingAddress"
                                                                    cssClass="text-danger" />
                                                            </div>
                                                        </div>

                                                </div>

                                                <div class="row mb-4">
                                                    <div class="col-md-4">
                                                        <div class="mb-3">
                                                            <label class="fw-bold">Total Amount <span
                                                                    class="text-danger">*</span></label>
                                                            <form:input path="totalAmount" type="number" step="0.01"
                                                                min="0" class="form-control form-control-lg"
                                                                required="true" />
                                                            <form:errors path="totalAmount" cssClass="text-danger" />
                                                        </div>
                                                    </div>




                                                </div>

                                                <div class="row mb-4">
                                                    <div class="col-md-6">
                                                        <div class="mb-3">
                                                            <label class="fw-bold">Order Status</label>
                                                            <form:select path="orderStatus"
                                                                class="form-control form-control-lg">
                                                                <form:option value="Pending" label="Pending" />
                                                                <form:option value="Processing" label="Processing" />
                                                                <form:option value="Shipped" label="Shipped" />
                                                                <form:option value="Delivered" label="Delivered" />
                                                                <form:option value="Cancelled" label="Cancelled" />
                                                            </form:select>
                                                            <form:errors path="orderStatus" cssClass="text-danger" />
                                                        </div>
                                                    </div>

                                                    <div class="col-md-6">
                                                        <div class="mb-3">
                                                            <label class="fw-bold">Payment <span
                                                                    class="text-danger">*</span></label>
                                                            <form:select path="payment"
                                                                class="form-control form-control-lg" required="true">
                                                                <form:option value=""
                                                                    label="-- Select Payment Method --" />
                                                                <form:options items="${payments}" itemValue="paymentId"
                                                                    itemLabel="namePaymentMethod" />
                                                            </form:select>
                                                            <form:errors path="payment" cssClass="text-danger" />
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row mb-4">
                                                    <div class="col-md-6">
                                                        <div class="mb-3">
                                                            <label class="fw-bold">Payment Status</label>
                                                            <form:select path="paymentStatus"
                                                                class="form-control form-control-lg">
                                                                <form:option value="Pending" label="Pending" />
                                                                <form:option value="Paid" label="Paid" />
                                                                <form:option value="Failed" label="Failed" />
                                                                <form:option value="Refunded" label="Refunded" />
                                                            </form:select>
                                                            <form:errors path="paymentStatus" cssClass="text-danger" />
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="card-action">
                                                    <button type="submit" class="btn btn-success">${order.orderId !=
                                                        null ?
                                                        'Update' : 'Add'}</button>
                                                    <button type="reset" class="btn btn-primary"
                                                        id="btn-reset">Reset</button>
                                                    <a href="/admin/order-mgr/list" class="btn btn-danger">Cancel</a>
                                                </div>
                                                </form:form>
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
                    <script src="../../../../resources/assets/dashboard/js/core/jquery-3.7.1.min.js"></script>
                    <script src="../../../../resources/assets/dashboard/js/core/popper.min.js"></script>
                    <script src="../../../../resources/assets/dashboard/js/core/bootstrap.min.js"></script>

                    <!-- jQuery Scrollbar -->
                    <script
                        src="../../../../resources/assets/dashboard/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

                    <!-- Sweet Alert -->
                    <script
                        src="../../../../resources/assets/dashboard/js/plugin/sweetalert/sweetalert.min.js"></script>

                    <!-- Kaiadmin JS -->
                    <script src="../../../../resources/assets/dashboard/js/kaiadmin.min.js"></script>

                    <script>
                        // Hide reset button if editing an existing order
                        var orderId = '<c:out value="${order.orderId}" />';
                        if (orderId !== '') {
                            document.getElementById('btn-reset').style.display = 'none';
                        }

                        // Format date fields for display
                        $(document).ready(function () {
                            // Format orderDate (datetime-local)
                            var orderDate = '<c:out value="${order.orderDate}" />';
                            if (orderDate) {
                                // Convert to format required by datetime-local input
                                var date = new Date(orderDate);
                                if (!isNaN(date.getTime())) {
                                    var formattedDate = date.toISOString().slice(0, 16);
                                    $('#orderDate').val(formattedDate);
                                }
                            }


                        });
                    </script>
                    </div>
                </body>

                </html>