<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <c:set var="ctx" value="${pageContext.request.contextPath}" />

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <title>Product Management</title>
            <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
            <link rel="icon" href="${ctx}/resources/assets/dashboard/img/kaiadmin/favicon.ico" type="image/x-icon" />
            <script src="${ctx}/resources/assets/dashboard/js/plugin/webfont/webfont.min.js"></script>
            <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/bootstrap.min.css" />
            <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/plugins.min.css" />
            <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/kaiadmin.min.css" />
            <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/demo.css" />

            <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/js/plugin/datatables/datatables.min.js" />
            <!-- Add Font Awesome for better icons -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />

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
                                <h3 class="fw-bold mb-3">Products</h3>
                                <ul class="breadcrumbs mb-3">
                                    <li class="nav-home">
                                        <a href="${ctx}/admin/dashboard/index">
                                            <i class="icon-home"></i>
                                        </a>
                                    </li>
                                    <li class="separator">
                                        <i class="icon-arrow-right"></i>
                                    </li>
                                    <li class="nav-item">
                                        <a href="${ctx}/admin/product-mgr/list">Products</a>
                                    </li>
                                </ul>
                            </div>

                            <%-- Display Success and Error Messages --%>
                                <c:if test="${not empty successMessage}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        ${successMessage}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"
                                            aria-label="Close"></button>
                                    </div>
                                </c:if>
                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        ${errorMessage}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"
                                            aria-label="Close"></button>
                                    </div>
                                </c:if>

                                <!-- start product datatable -->
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <div class="d-flex align-items-center">
                                                    <h4 class="card-title">Products list</h4>
                                                    <a href="${ctx}/admin/product-mgr/create"
                                                        class="btn btn-primary btn-round ms-auto">
                                                        <i class="fas fa-plus"></i> Add New Product
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="card-body">
                                                <div class="table-responsive">
                                                    <table id="add-row" class="table table-hover">
                                                        <thead>
                                                            <tr>
                                                                <th>No.</th>
                                                                <th>ID</th>
                                                                <th>Name</th>
                                                                <th>Image</th>
                                                                <th>Category</th>
                                                                <th>Brand</th>
                                                                <th>Price</th>
                                                                <th>Quantity Sold</th>
                                                                <th>Actions</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="product" items="${products}"
                                                                varStatus="status">
                                                                <tr>
                                                                    <td>${status.index+1}</td>
                                                                    <td><a href="${ctx}/admin/product-mgr/detail/${product.productId}"
                                                                            class="text-primary">#${product.productId}</a>
                                                                    </td>
                                                                    <td>${product.productName}</td>
                                                                    <td>
                                                                        <c:set var="defaultImageUrl" value="" />
                                                                        <c:forEach var="image"
                                                                            items="${product.images}">
                                                                            <c:if test="${image.priority}">
                                                                                <c:set var="defaultImageUrl"
                                                                                    value="${image.imageUrl}" />
                                                                            </c:if>
                                                                        </c:forEach>
                                                                        <%-- Nếu không tìm thấy ảnh default, dùng ảnh
                                                                            đầu tiên nếu có --%>
                                                                            <c:if
                                                                                test="${empty defaultImageUrl && not empty product.images}">
                                                                                <c:set var="defaultImageUrl"
                                                                                    value="${product.images[0].imageUrl}" />
                                                                            </c:if>
                                                                            <img src="${ctx}/${defaultImageUrl}"
                                                                                alt="${product.productName}"
                                                                                style="max-width: 100px; max-height: 100px;">
                                                                    </td>
                                                                    <td>${product.category.categoryName}</td>
                                                                    <td>${product.brand.brandName}</td>
                                                                    <td>$${product.price}</td>
                                                                    <td>${product.quantitySold}</td>
                                                                    <td>
                                                                        <div class="btn-group">
                                                                            <a href="${ctx}/admin/product-mgr/detail/${product.productId}"
                                                                                class="btn btn-sm btn-info">
                                                                                <i class="fas fa-eye"></i>
                                                                            </a>
                                                                            <a href="${ctx}/admin/product-mgr/update/${product.productId}"
                                                                                class="btn btn-sm btn-primary">
                                                                                <i class="fas fa-edit"></i>
                                                                            </a>
                                                                            <%-- Form for delete action --%>
                                                                                <form
                                                                                    id="deleteForm-${product.productId}"
                                                                                    action="${ctx}/admin/product-mgr/delete/${product.productId}"
                                                                                    method="POST"
                                                                                    style="display:inline;">
                                                                                    <%-- Add CSRF token --%>
                                                                                        <input type="hidden"
                                                                                            name="${_csrf.parameterName}"
                                                                                            value="${_csrf.token}" />
                                                                                        <button type="button"
                                                                                            class="btn btn-sm btn-danger"
                                                                                            onclick="confirmDeleteProduct('${product.productId}', '${product.productName}')">
                                                                                            <i class="fas fa-trash"></i>
                                                                                        </button>
                                                                                </form>
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
            <script src="${ctx}/resources/assets/dashboard/js/core/jquery-3.7.1.min.js"></script>
            <script src="${ctx}/resources/assets/dashboard/js/core/popper.min.js"></script>
            <script src="${ctx}/resources/assets/dashboard/js/core/bootstrap.min.js"></script>

            <!-- Scrollbar Plugin -->
            <script src="${ctx}/resources/assets/dashboard/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

            <!-- KaiAdmin JS -->
            <script src="${ctx}/resources/assets/dashboard/js/kaiadmin.min.js"></script>

            <!-- DataTables JS -->
            <script src="${ctx}/resources/assets/dashboard/js/plugin/datatables/datatables.min.js"></script>

            <!-- Sweet Alert -->
            <script src="${ctx}/resources/assets/dashboard/js/plugin/sweetalert/sweetalert.min.js"></script>

            <script>
                $(document).ready(function () {
                    $('#add-row').DataTable({
                        "pageLength": 10,
                        lengthMenu: [5, 10, 25, 50, 100],
                        columnDefs: [
                            {
                                targets: [7],
                                orderable: false,
                                searchable: false
                            }
                        ]
                    });
                });

                // Delete confirmation and form submission
                function confirmDeleteProduct(productId, productName) {
                    swal({
                        title: "Are you sure?",
                        text: "You are about to delete product: " + productName + ". This action cannot be undone!",
                        icon: "warning",
                        buttons: {
                            cancel: {
                                visible: true,
                                text: "Cancel",
                                className: "btn btn-secondary",
                            },
                            confirm: {
                                text: "Delete",
                                className: "btn btn-danger",
                            },
                        },
                        dangerMode: true,
                    }).then((willDelete) => {
                        if (willDelete) {
                            // Submit the form if confirmed
                            document.getElementById('deleteForm-' + productId).submit();
                        }
                    });
                }

                // Remove the old deleteProduct function that uses AJAX POST if it exists
                // function deleteProduct(productId) { ... AJAX call ... }
            </script>
        </body>

        </html>