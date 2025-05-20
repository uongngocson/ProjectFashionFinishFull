<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <title>Supplier Details</title>
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
            <!-- CSS -->
            <style>
                .supplier-logo-container {
                    padding: 15px;
                    background-color: #f8f9fa;
                    border-radius: 5px;
                }

                .supplier-image-container {
                    border-radius: 5px;
                    overflow: hidden;
                    background-color: #f8f9fa;
                    padding: 10px;
                }

                .supplier-info {
                    padding: 10px;
                }

                .supplier-info p {
                    margin-bottom: 8px;
                }

                .supplier-description-container .btn:focus {
                    box-shadow: none;
                }

                .supplier-description-container .btn i.fa-chevron-down {
                    transition: transform 0.3s;
                }

                .supplier-description-container .btn[aria-expanded="true"] i.fa-chevron-down {
                    transform: rotate(180deg);
                }

                /* CSS */
                .supplier-description-container .btn[aria-expanded="true"]::before {
                    content: "Hide Description";
                }

                .supplier-description-container .btn[aria-expanded="true"] .btn-text {
                    display: none;
                }
            </style>
        </head>

        <body>
            <div class="wrapper">
                <!-- start sidebar -->
                <jsp:include page="../layout/sidebar.jsp" />
                <!-- end sidebar -->
                <div class="main-panel">
                    <!-- start navbar -->
                    <jsp:include page="../layout/header.jsp" />
                    <!-- end navbar -->
                    <div class="container">
                        <div class="page-inner">

                            <!-- Page Header -->
                            <div class="page-header">
                                <h3 class="fw-bold mb-3">Supplier Details</h3>
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
                                        <a href="/admin/supplier-mgr/list">Suppliers</a>
                                    </li>
                                    <li class="separator">
                                        <i class="icon-arrow-right"></i>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#">Supplier Details</a>
                                    </li>
                                </ul>
                            </div>

                            <!-- Page Content -->

                            <!-- Supplier Details Card -->
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card">
                                        <!-- start card header -->
                                        <div class="card-header">
                                            <div class="d-flex align-items-center">
                                                <h4 class="card-title">#${supplier.supplierId} -
                                                    ${supplier.supplierName}</h4>
                                                <div class="ms-auto">
                                                    <a href="/admin/supplier-mgr/update/${supplier.supplierId}"
                                                        class="btn btn-primary btn-sm">
                                                        <i class="fas fa-edit"></i> Update Supplier
                                                    </a>
                                                    <button class="btn btn-danger btn-sm"
                                                        onclick="confirmDelete('${supplier.supplierId}')">
                                                        <i class="fas fa-trash"></i> Delete Supplier
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- end card header -->

                                        <!-- start card body -->
                                        <div class="card-body">
                                            <div class="row mb-4">
                                                <div class="col-md-3 text-center">
                                                    <!-- start supplier logo -->
                                                    <div class="supplier-logo-container mb-3">

                                                        <c:choose>
                                                            <c:when test="${not empty supplier.logoUrl}">
                                                                <c:set var="logoUrl"
                                                                    value="${ctx}/${supplier.logoUrl}" />
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:set var="logoUrl"
                                                                    value="${ctx}/resources/images/logo-is-empty.jpg" />
                                                            </c:otherwise>
                                                        </c:choose>

                                                        <img src="${logoUrl}" alt="logo"
                                                            class="img-fluid rounded shadow-sm"
                                                            style="max-height: 150px; max-width: 100%;">
                                                    </div>
                                                    <!-- end supplier logo -->

                                                    <!-- start status -->
                                                    <div class="supplier-status text-center">
                                                        <span
                                                            class="badge badge-${supplier.status ? 'success' : 'danger'} p-2 fs-6 w-100">
                                                            ${supplier.status ? 'Active' : 'Inactive'}
                                                        </span>
                                                    </div>
                                                    <!-- end status -->
                                                </div>

                                                <!-- start information supplier -->
                                                <div class="col-md-5">
                                                    <div class="supplier-info">
                                                        <h4 class="fw-bold">${supplier.supplierName}</h4>
                                                        <p class="text-muted mb-2">
                                                            <i
                                                                class="fas fa-map-marker-alt me-2"></i>${supplier.address}
                                                        </p>
                                                        <p class="text-muted mb-2">
                                                            <i class="fas fa-user me-2"></i>${supplier.contactPerson}
                                                        </p>
                                                        <p class="text-muted mb-2">
                                                            <i class="fas fa-phone me-2"></i>${supplier.phone}
                                                        </p>
                                                        <p class="text-muted mb-2">
                                                            <i class="fas fa-envelope me-2"></i>${supplier.email}
                                                        </p>
                                                    </div>
                                                </div>
                                                <!-- end information supplier -->
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Supplier Products Card -->
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <div class="d-flex align-items-center">
                                                    <h4 class="card-title">Products from this Supplier</h4>
                                                    <a href="/product-mgr/create?supplierId=${supplier.supplierId}"
                                                        class="btn btn-primary btn-round ms-auto">
                                                        <i class="fas fa-plus"></i> Add New Product
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="card-body">
                                                <div class="table-responsive">
                                                    <table id="products-table" class="table table-hover">
                                                        <thead>
                                                            <tr>
                                                                <th>No.</th>
                                                                <th>ID</th>
                                                                <th>Image</th>
                                                                <th>Name</th>
                                                                <th>Category</th>
                                                                <th>Price</th>
                                                                <th>Stock</th>
                                                                <th>Actions</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="product" items="${products}"
                                                                varStatus="status">
                                                                <tr>
                                                                    <td>${status.index+1}</td>
                                                                    <td><a href="/product-mgr/${product.productId}"
                                                                            class="text-primary">#${product.productId}</a>
                                                                    </td>

                                                                    <td>${product.productName}</td>
                                                                    <td>${product.category.categoryName}</td>
                                                                    <td>$${product.price}</td>
                                                                    <td>${product.quantitySold}</td>

                                                                    <td>
                                                                        <div class="btn-group">
                                                                            <a href="/product-mgr/${product.productId}"
                                                                                class="btn btn-sm btn-info">
                                                                                <i class="fas fa-eye"></i>
                                                                            </a>
                                                                            <a href="/product-mgr/update/${product.productId}"
                                                                                class="btn btn-sm btn-primary">
                                                                                <i class="fas fa-edit"></i>
                                                                            </a>
                                                                            <button type="button"
                                                                                class="btn btn-sm btn-danger"
                                                                                onclick="deleteProduct('${product.productId}')">
                                                                                <i class="fas fa-trash"></i>
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

                <!-- DataTables JS -->
                <script src="../../../../resources/assets/dashboard/js/plugin/datatables/datatables.min.js"></script>

                <!-- Sweet Alert -->
                <script src="../../../../resources/assets/dashboard/js/plugin/sweetalert/sweetalert.min.js"></script>

                <script>

                    // function delete supplier
                    function confirmDelete(supplierId) {
                        swal({
                            title: "Are you sure you want to delete this supplier?",
                            text: "This action cannot be undone and will also delete all products associated with this supplier.",
                            icon: "warning",
                            buttons: ["Cancel", "Delete"],
                            dangerMode: true,
                        }).then((confirmed) => {
                            if (confirmed) {
                                $.post(`/admin/supplier-mgr/delete/${supplierId}`)
                                    .done(() => {
                                        swal("Deleted!", "The supplier has been successfully deleted.", "success")
                                            .then(() => window.location.href = "/admin/supplier-mgr/list");
                                    })
                                    .fail(() => {
                                        swal("Error!", "Something went wrong. Please try again.", "error");
                                    });
                            }
                        });
                    }

                    // function delete product
                    function deleteProduct(productId) {
                        swal({
                            title: "Are you sure you want to delete this product?",
                            text: "This action cannot be undone.",
                            icon: "warning",
                            buttons: ["Cancel", "Delete"],
                            dangerMode: true,
                        }).then((confirmed) => {
                            if (confirmed) {
                                $.post(`/product-mgr/delete/${productId}`)
                                    .done(() => {
                                        swal("Deleted!", "The product has been successfully deleted.", "success")
                                            .then(() => location.reload());
                                    })
                                    .fail(() => {
                                        swal("Error!", "Something went wrong. Please try again.", "error");
                                    });
                            }
                        });
                    }


                    $(document).ready(function () {
                        // Initialize DataTable
                        $('#products-table').DataTable({
                            pageLength: 10,
                            lengthMenu: [5, 10, 25, 50, 100],
                            columnDefs: [
                                {
                                    targets: [2, 7],
                                    orderable: false,
                                    searchable: false
                                }
                            ]
                        });
                    });
                </script>
        </body>

        </html>