<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <title>Product Details</title>
            <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
            <!-- set path -->
            <c:set var="ctx" value="${pageContext.request.contextPath}" />
            <link rel="icon" href="../../../../resources/assets/user/img/home/walmart-logo.webp" type="image/x-icon" />
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
                <!-- start sidebar -->
                <jsp:include page="../layout/sidebar.jsp" />
                <!-- end sidebar -->
                <div class="main-panel">
                    <!-- start header -->
                    <jsp:include page="../layout/header.jsp" />
                    <!-- end header -->

                    <!-- start page content -->
                    <div class="container">
                        <div class="page-inner">
                            <div class="page-header">
                                <h3 class="fw-bold mb-3">Details</h3>
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
                                        <a href="/admin/product-mgr/list">Products</a>
                                    </li>
                                    <li class="separator">
                                        <i class="icon-arrow-right"></i>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#">Details</a>
                                    </li>
                                </ul>
                            </div>

                            <!-- Product Details Card -->
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card">
                                        <div class="card-header">
                                            <div class="d-flex align-items-center">
                                                <h4 class="card-title">Product #${product.productId} -
                                                    ${product.productName}</h4>
                                                <div class="ms-auto">
                                                    <a href="/admin/product-mgr/update/${product.productId}"
                                                        class="btn btn-primary btn-sm">
                                                        <i class="fas fa-edit"></i> Edit Product
                                                    </a>
                                                    <button class="btn btn-danger btn-sm"
                                                        onclick="deleteProduct('${product.productId}')">
                                                        <i class="fas fa-trash"></i> Delete Product
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div class="row mb-4">

                                                <div class="col-md-8">
                                                    <div class="product-info">
                                                        <h4 class="fw-bold">${product.productName}</h4>

                                                        <p class="text-muted mb-2">
                                                            <i class="fas fa-tag me-2"></i>Category:
                                                            ${product.category.categoryName}
                                                        </p>
                                                        <p class="text-muted mb-2">
                                                            <i class="fas fa-building me-2"></i>Brand:
                                                            ${product.brand.brandName}
                                                        </p>
                                                        <p class="text-muted mb-2">
                                                            <i class="fas fa-store me-2"></i>Supplier:
                                                            ${product.supplier.supplierName}
                                                        </p>
                                                        <p class="text-muted mb-2">
                                                            <i class="fas fa-dollar-sign me-2"></i>Price:
                                                            $${product.price}
                                                        </p>
                                                        <p class="text-muted mb-2">
                                                            <i class="fas fa-boxes me-2"></i>In Stock:
                                                            ${product.quantitySold}
                                                        </p>

                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-12">
                                                    <div class="product-description-container">
                                                        <button class="btn btn-light btn-sm w-100 mb-3" type="button"
                                                            data-bs-toggle="collapse" data-bs-target="#description"
                                                            aria-expanded="false" aria-controls="fullDescription">
                                                            <i class="fas fa-info-circle me-2"></i>Show Description
                                                            <i class="fas fa-chevron-down ms-2"></i>
                                                        </button>
                                                        <div class="collapse" id="description">
                                                            <div class="card card-body bg-light">
                                                                <div>${product.description != null ?
                                                                    product.description : 'No description
                                                                    available for this product.'}</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- end page content -->

                    <!-- start footer -->
                    <jsp:include page="../layout/footer.jsp" />
                    <!-- end footer -->
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

            <!-- Sweet Alert -->
            <script src="../../../../resources/assets/dashboard/js/plugin/sweetalert/sweetalert.min.js"></script>

            <script>
                // Delete confirmation and API call
                function deleteProduct(productId) {
                    swal({
                        title: "Are you sure you want to delete this product?",
                        text: "This action cannot be undone.",
                        icon: "warning",
                        buttons: ["Cancel", "Delete"],
                        dangerMode: true,
                    }).then((confirmed) => {
                        if (confirmed) {
                            $.post(`/admin/product-mgr/delete/${productId}`)
                                .done(() => {
                                    swal("Deleted!", "The product has been successfully deleted.", "success")
                                        .then(() => window.location.href = "/admin/product-mgr/list");
                                })
                                .fail(() => {
                                    swal("Error!", "Something went wrong. Please try again.", "error");
                                });
                        }
                    });
                }
            </script>
        </body>

        </html>