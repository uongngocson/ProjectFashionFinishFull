<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>${product.productId != null ? 'Update' : 'Create'} Product</title>
                <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
                <!-- set path -->
                <c:set var="ctx" value="${pageContext.request.contextPath}" />

                <link rel="icon" href="../../../../resources/assets/user/img/home/walmart-logo.webp"
                    type="image/x-icon" />
                <script src="../../../../resources/assets/dashboard/js/plugin/webfont/webfont.min.js"></script>
                <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/bootstrap.min.css" />
                <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/plugins.min.css" />
                <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/kaiadmin.min.css" />
                <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/demo.css" />
                <!-- CKEditor -->
                <script src="https://cdn.ckeditor.com/ckeditor5/40.0.0/classic/ckeditor.js"></script>
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
                                <!-- start page header -->
                                <div class="page-header">
                                    <h3 class="fw-bold mb-3">${product.productId != null ? 'Update' : 'Create'} Product
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
                                            <a href="/admin/product-mgr/list">Products</a>
                                        </li>
                                        <li class="separator">
                                            <i class="icon-arrow-right"></i>
                                        </li>
                                        <li class="nav-item">
                                            <a href="#">${product.productId != null ? 'Update' : 'Create'}</a>
                                        </li>
                                    </ul>
                                </div>
                                <!-- end page header -->

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <div class="card-title">${product.productId != null ? 'Update Product #'
                                                    : 'Create New Product'} ${product.productId != null ?
                                                    product.productId : ''}</div>
                                            </div>
                                            <form:form action="/admin/product-mgr/save" method="post"
                                                modelAttribute="product" enctype="multipart/form-data">
                                                <!-- product id -->
                                                <form:hidden path="productId" />

                                                <div class="card-body">
                                                    <!-- product name -->
                                                    <div class="row mb-4">
                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="fw-bold">Product Name <span
                                                                        class="text-danger">*</span></label>
                                                                <form:input path="productName" type="text"
                                                                    class="form-control form-control-lg"
                                                                    id="productName" placeholder="Enter product name" />
                                                                <form:errors path="productName"
                                                                    cssClass="text-danger" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row mb-4">
                                                        <!-- product category -->
                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="fw-bold">Category <span
                                                                        class="text-danger">*</span></label>
                                                                <form:select path="category.categoryId"
                                                                    class="form-control form-control-lg"
                                                                    id="categoryId">
                                                                    <form:option value=""
                                                                        label="-- Select Category --" />
                                                                    <c:forEach var="category" items="${categories}">
                                                                        <form:option value="${category.categoryId}"
                                                                            label="${category.categoryName}" />
                                                                    </c:forEach>
                                                                </form:select>
                                                                <form:errors path="category.categoryId"
                                                                    cssClass="text-danger" />
                                                            </div>
                                                        </div>
                                                        <!-- product brand -->
                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="fw-bold">Brand <span
                                                                        class="text-danger">*</span></label>
                                                                <form:select path="brand.brandId"
                                                                    class="form-control form-control-lg" id="brandId">
                                                                    <form:option value="" label="-- Select Brand --" />
                                                                    <c:forEach var="brand" items="${brands}">
                                                                        <form:option value="${brand.brandId}"
                                                                            label="${brand.brandName}" />
                                                                    </c:forEach>
                                                                </form:select>
                                                                <form:errors path="brand.brandId"
                                                                    cssClass="text-danger" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row mb-4">
                                                        <!-- product supplier -->
                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="fw-bold">Supplier <span
                                                                        class="text-danger">*</span></label>
                                                                <form:select path="supplier.supplierId"
                                                                    class="form-control form-control-lg"
                                                                    id="supplierId">
                                                                    <form:option value=""
                                                                        label="-- Select Supplier --" />
                                                                    <c:forEach var="supplier" items="${suppliers}">
                                                                        <form:option value="${supplier.supplierId}"
                                                                            label="${supplier.supplierName}" />
                                                                    </c:forEach>
                                                                </form:select>
                                                                <form:errors path="supplier.supplierId"
                                                                    cssClass="text-danger" />
                                                            </div>
                                                        </div>
                                                        <!-- product price -->
                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="fw-bold">Price <span
                                                                        class="text-danger">*</span></label>
                                                                <form:input path="price" type="number" step="0.01"
                                                                    min="0" class="form-control form-control-lg"
                                                                    id="price" placeholder="Enter price" />
                                                                <form:errors path="price" cssClass="text-danger" />
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row mb-4">
                                                        <!-- product quantity in stock -->
                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="fw-bold">Quantity in Sold <span
                                                                        class="text-danger">*</span></label>
                                                                <form:input path="quantitySold" type="number" min="0"
                                                                    class="form-control form-control-lg"
                                                                    id="quantitySold"
                                                                    placeholder="Enter quantity in stock" />
                                                                <form:errors path="quantitySold"
                                                                    cssClass="text-danger" />
                                                            </div>
                                                        </div>
                                                    </div>


                                                </div>


                                        </div>


                                        <div class="row mb-4">
                                            <div class="col-md-4">
                                                <div class="mb-3">
                                                    <label class="fw-bold">Warranty <span
                                                            class="text-danger">*</span></label>
                                                    <form:input path="warranty" type="text"
                                                        class="form-control form-control-lg" id="warranty"
                                                        placeholder="Enter warranty" />
                                                    <form:errors path="warranty" cssClass="text-danger" />
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="mb-3">
                                                    <label class="fw-bold">Return policy <span
                                                            class="text-danger">*</span></label>
                                                    <form:input path="returnPolicy" type="text"
                                                        class="form-control form-control-lg" id="returnPolicy"
                                                        placeholder="Enter return policy" />
                                                    <form:errors path="returnPolicy" cssClass="text-danger" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="mb-4">
                                            <label class="fw-bold">Description <span
                                                    class="text-danger">*</span></label>
                                            <form:textarea path="description" class="form-control form-control-lg"
                                                id="description" rows="5" placeholder="Enter full description" />
                                            <form:errors path="description" cssClass="text-danger" />
                                        </div>

                                        <div class="card-action">
                                            <button type="submit" class="btn btn-success">${product.productId !=
                                                null ? 'Update' : 'Add'}</button>
                                            <button type="reset" class="btn btn-primary" id="btn-reset">Reset</button>
                                            <a href="/admin/product-mgr/list" class="btn btn-danger">Cancel</a>
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
                <script src="../../../../resources/assets/dashboard/js/plugin/sweetalert/sweetalert.min.js"></script>

                <!-- Kaiadmin JS -->
                <script src="../../../../resources/assets/dashboard/js/kaiadmin.min.js"></script>

                <script>
                    // Ép EL vào biến JavaScript và đảm bảo bao quanh bằng dấu nháy nếu là chuỗi
                    var productId = '<c:out value="${product.productId}" />';
                    if (productId !== '') {
                        document.getElementById('btn-reset').style.display = 'none';
                    }
                </script>

                <script>
                    // Initialize CKEditor for textarea with id fullDescription
                    ClassicEditor
                        .create(document.querySelector('#description'), {
                        })
                        .catch(error => {
                            console.error(error);
                        });

                    // Image preview functionality
                    $(document).ready(function () {
                        // Function to handle file input change and show preview
                        function handleFileInputChange(input) {
                            const previewElement = $($(input).data('preview'));

                            if (input.files && input.files[0]) {
                                const reader = new FileReader();

                                reader.onload = function (e) {
                                    // Clear previous preview
                                    previewElement.html('');

                                    // Create image element
                                    const img = $('<img>')
                                        .attr('src', e.target.result)
                                        .addClass('img-fluid rounded')
                                        .css('max-height', '150px');

                                    // Add to preview container
                                    previewElement.append(img);
                                }

                                reader.readAsDataURL(input.files[0]);
                            }
                        }

                        // Attach event listeners to file inputs
                        // $('#imageFile').change(function () {
                        //     handleFileInputChange(this);
                        // });
                    });
                </script>

            </body>

            </html>