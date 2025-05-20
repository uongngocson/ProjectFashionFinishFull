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
                                        <a href="/employee/dashboard/index">
                                            <i class="icon-home"></i>
                                        </a>
                                    </li>
                                    <li class="separator">
                                        <i class="icon-arrow-right"></i>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/employee/product-mgr/list">Products</a>
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
                                                            <i class="fas fa-boxes me-2"></i>Quantity sold:
                                                            ${product.quantitySold}
                                                        </p>
                                                        <p class="text-muted mb-2">
                                                            <i class="fas fa-boxes me-2"></i>Total quantity:
                                                            ${totalQuantity}
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

                                            <!-- table product productVariant -->
                                            <div class="row">
                                                <div class="col-12">
                                                    <div class="product-variants-container">
                                                        <div
                                                            class="d-flex justify-content-between align-items-center mb-3">
                                                            <button class="btn btn-light btn-sm" type="button"
                                                                data-bs-toggle="collapse" data-bs-target="#variants"
                                                                aria-expanded="false" aria-controls="variants">
                                                                <i class="fas fa-list me-2"></i>Show/Hide Variants
                                                                <i class="fas fa-chevron-down ms-2"></i>
                                                            </button>
                                                            <a href="${ctx}/employee/product-variant-mgr/add/${product.productId}"
                                                                class="btn btn-primary btn-sm">
                                                                <i class="fas fa-plus me-2"></i>Add New Variant
                                                            </a>
                                                        </div>
                                                        <div class="collapse show" id="variants"> <%-- Changed to 'show'
                                                                to be open by default, or keep as 'collapse' --%>
                                                                <div class="card card-body bg-light">
                                                                    <c:if test="${not empty successMessage}">
                                                                        <div class="alert alert-success" role="alert">
                                                                            ${successMessage}
                                                                        </div>
                                                                    </c:if>
                                                                    <c:if test="${not empty errorMessage}">
                                                                        <div class="alert alert-danger" role="alert">
                                                                            ${errorMessage}
                                                                        </div>
                                                                    </c:if>
                                                                    <table class="table table-bordered table-hover">
                                                                        <thead class="thead-light">
                                                                            <tr>
                                                                                <th>ID</th>
                                                                                <th>SKU</th>
                                                                                <th>Color</th>
                                                                                <th>Size</th>
                                                                                <th>Stock</th>
                                                                                <th>Image</th>
                                                                                <th>Actions</th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                            <c:choose>
                                                                                <c:when
                                                                                    test="${not empty product.productVariant and product.productVariant.size() > 0}">
                                                                                    <c:forEach var="variant"
                                                                                        items="${product.productVariant}">
                                                                                        <tr>
                                                                                            <td>${variant.productVariantId}
                                                                                            </td>
                                                                                            <td>${variant.SKU}</td>
                                                                                            <td>${variant.color.colorName}
                                                                                            </td>
                                                                                            <td>${variant.size.sizeName}
                                                                                            </td>
                                                                                            <td>${variant.quantityStock}
                                                                                            </td>
                                                                                            <td>
                                                                                                <c:if
                                                                                                    test="${not empty variant.imageUrl}">
                                                                                                    <img src="${ctx}/${variant.imageUrl}"
                                                                                                        alt="Variant Image"
                                                                                                        style="max-width: 50px; max-height: 50px;">
                                                                                                </c:if>
                                                                                                <c:if
                                                                                                    test="${empty variant.imageUrl}">
                                                                                                    N/A
                                                                                                </c:if>
                                                                                            </td>
                                                                                            <td>
                                                                                                <a href="${ctx}/employee/product-variant-mgr/edit/${variant.productVariantId}"
                                                                                                    class="btn btn-warning btn-sm me-1"
                                                                                                    title="Edit">
                                                                                                    <i
                                                                                                        class="fas fa-edit"></i>
                                                                                                </a>
                                                                                                <a href="#"
                                                                                                    onclick="confirmDeleteVariant('${variant.productVariantId}', '${product.productId}')"
                                                                                                    class="btn btn-danger btn-sm"
                                                                                                    title="Delete">
                                                                                                    <i
                                                                                                        class="fas fa-trash"></i>
                                                                                                </a>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </c:forEach>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <tr>
                                                                                        <td colspan="7"
                                                                                            class="text-center">No
                                                                                            variants found for this
                                                                                            product.</td>
                                                                                    </tr>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-12">
                                                    <div class="product-images-container">
                                                        <div
                                                            class="d-flex justify-content-between align-items-center mb-3">
                                                            <button class="btn btn-light btn-sm" type="button"
                                                                data-bs-toggle="collapse"
                                                                data-bs-target="#imagesSection" <%-- Changed ID to avoid
                                                                conflict --%>
                                                                aria-expanded="false" aria-controls="imagesSection">
                                                                <i class="fas fa-images me-2"></i>Show/Hide Images
                                                                <i class="fas fa-chevron-down ms-2"></i>
                                                            </button>
                                                            <a href="${ctx}/employee/product-image-mgr/add/${product.productId}"
                                                                class="btn btn-primary btn-sm">
                                                                <i class="fas fa-plus me-2"></i>Add New Image
                                                            </a>
                                                        </div>
                                                        <div class="collapse show" id="imagesSection"> <%-- Changed
                                                                to 'show' and new ID --%>
                                                                <div class="card card-body bg-light">
                                                                    <c:if test="${not empty imageSuccessMessage}">
                                                                        <div class="alert alert-success" role="alert">
                                                                            ${imageSuccessMessage}
                                                                        </div>
                                                                    </c:if>
                                                                    <c:if test="${not empty imageErrorMessage}">
                                                                        <div class="alert alert-danger" role="alert">
                                                                            ${imageErrorMessage}
                                                                        </div>
                                                                    </c:if>
                                                                    <div class="row">
                                                                        <c:choose>
                                                                            <c:when
                                                                                test="${not empty product.images and product.images.size() > 0}">
                                                                                <c:forEach var="image"
                                                                                    items="${product.images}">
                                                                                    <div
                                                                                        class="col-md-3 col-sm-4 mb-3 text-center">
                                                                                        <img src="${ctx}/${image.imageUrl}"
                                                                                            class="img-fluid img-thumbnail mb-2"
                                                                                            alt="Product Image"
                                                                                            style="max-height: 150px;">
                                                                                        <p class="mb-1">
                                                                                            <c:if
                                                                                                test="${image.priority}">
                                                                                                <span
                                                                                                    class="badge bg-success">Default</span>
                                                                                            </c:if>
                                                                                        </p>
                                                                                        <a href="#"
                                                                                            onclick="confirmDeleteImage('${image.productImageId}', '${product.productId}')"
                                                                                            class="btn btn-danger btn-sm"
                                                                                            title="Delete Image">
                                                                                            <i class="fas fa-trash"></i>
                                                                                            Delete
                                                                                        </a>
                                                                                        <%-- Optional: Add Set as
                                                                                            Default button if not
                                                                                            already default --%>
                                                                                            <c:if
                                                                                                test="${!image.priority}">
                                                                                                <a href="${ctx}/employee/product-image-mgr/set-default/${image.productImageId}/${product.productId}"
                                                                                                    class="btn btn-info btn-sm ms-1"
                                                                                                    title="Set as Default">
                                                                                                    <i
                                                                                                        class="fas fa-check-circle"></i>
                                                                                                    Set Default
                                                                                                </a>
                                                                                            </c:if>
                                                                                    </div>
                                                                                </c:forEach>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <div class="col-12 text-center">
                                                                                    <p>No images found for this product.
                                                                                    </p>
                                                                                </div>
                                                                            </c:otherwise>
                                                                        </c:choose>
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
                            $.post(`/employee/product-mgr/delete/${productId}`)
                                .done(() => {
                                    swal("Deleted!", "The product has been successfully deleted.", "success")
                                        .then(() => window.location.href = "/employee/product-mgr/list");
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

        <script>
            function confirmDeleteVariant(variantId, productId) {
                swal({
                    title: "Are you sure?",
                    text: "Once deleted, you will not be able to recover this product variant!",
                    icon: "warning",
                    buttons: {
                        cancel: "Cancel",
                        confirm: {
                            text: "Yes, delete it!",
                            value: true,
                            visible: true,
                            className: "btn-danger",
                        }
                    },
                    dangerMode: true,
                }).then((willDelete) => {
                    if (willDelete) {
                        window.location.href = "${ctx}/employee/product-variant-mgr/delete/" + variantId;
                    }
                });
            }

            function confirmDeleteImage(imageId, productId) {
                swal({
                    title: "Are you sure?",
                    text: "Once deleted, you will not be able to recover this product image!",
                    icon: "warning",
                    buttons: {
                        cancel: "Cancel",
                        confirm: {
                            text: "Yes, delete it!",
                            value: true,
                            visible: true,
                            className: "btn-danger",
                        }
                    },
                    dangerMode: true,
                }).then((willDelete) => {
                    if (willDelete) {
                        // Corrected URL construction
                        window.location.href = "${ctx}/employee/product-image-mgr/delete/" + imageId + "/" + productId;
                    }
                });
            }
        </script>