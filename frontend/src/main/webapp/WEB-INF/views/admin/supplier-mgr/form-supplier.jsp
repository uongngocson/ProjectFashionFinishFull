<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>Create Product</title>
                <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
                <link rel="icon" href="../../../../resources/assets/dashboard/img/kaiadmin/favicon.ico"
                    type="image/x-icon" />

                <!-- set path -->
                <c:set var="ctx" value="${pageContext.request.contextPath}" />

                <!-- Fonts and icons -->
                <script src="../../../../resources/assets/dashboard/js/plugin/webfont/webfont.min.js"></script>

                <!-- ckeditor -->
                <!-- <script src="../../../../resources/ckeditor/ckeditor.js"></script> -->
                <script src="https://cdn.ckeditor.com/ckeditor5/36.0.1/classic/ckeditor.js"></script>

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

                <!-- CSS Files -->
                <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/bootstrap.min.css" />
                <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/plugins.min.css" />
                <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/kaiadmin.min.css" />
                <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/demo.css" />
            </head>

            <body>
                <div class="wrapper">
                    <!-- Sidebar -->
                    <jsp:include page="../layout/sidebar.jsp" />
                    <!-- End Sidebar -->

                    <div class="main-panel">
                        <!-- start header -->
                        <jsp:include page="../layout/header.jsp" />
                        <!-- end header -->

                        <!-- Content -->
                        <div class="container">
                            <div class="page-inner">

                                <div class="page-header">
                                    <h3 class="fw-bold mb-3">${supplier.supplierId != null ? 'Update' : 'Create'}
                                        Supplier</h3>
                                    <ul class="breadcrumbs mb-3">
                                        <li class="nav-home">
                                            <a href="/admin/dashboard/index"><i class="icon-home"></i></a>
                                        </li>
                                        <li class="separator"><i class="icon-arrow-right"></i></li>
                                        <li class="nav-item"><a href="/admin/supplier-mgr/list">Suppliers</a></li>
                                        <li class="separator"><i class="icon-arrow-right"></i></li>
                                        <li class="nav-item"><a href="#">${supplier.supplierId != null ? 'Update' :
                                                'Create'}</a>
                                        </li>
                                    </ul>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <form:form action="/admin/supplier-mgr/save" method="post"
                                                modelAttribute="supplier" enctype="multipart/form-data">
                                                <div class="card-body">
                                                    <!-- id -->
                                                    <c:if test="${not empty supplier.supplierId}">
                                                        <form:hidden path="supplierId" />
                                                    </c:if>

                                                    <div class="row mb-4">
                                                        <!-- supplier name -->
                                                        <div class="col-md-6">
                                                            <div class="mb-3 ">
                                                                <label class="fw-bold">Supplier Name <span
                                                                        class="text-danger">*</span></label>
                                                                <form:input path="supplierName" type="text"
                                                                    class="form-control form-control-lg"
                                                                    id="supplierName"
                                                                    placeholder="Enter supplier name" />
                                                                <form:errors path="supplierName"
                                                                    cssClass="text-danger" />
                                                            </div>
                                                        </div>

                                                        <!-- contact person -->
                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="fw-bold">Contact Person <span
                                                                        class="text-danger">*</span></label>
                                                                <form:input path="contactPerson" type="text"
                                                                    class="form-control form-control-lg"
                                                                    id="contactPerson"
                                                                    placeholder="Enter contact person" />
                                                                <form:errors path="contactPerson"
                                                                    cssClass="text-danger" />
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row mb-4">
                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="fw-bold">Phone Number <span
                                                                        class="text-danger">*</label>
                                                                <form:input path="phone" type="tel"
                                                                    class="form-control form-control-lg" id="phone"
                                                                    placeholder="Enter phone number" />
                                                                <form:errors path="phone" cssClass="text-danger" />
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="fw-bold">Email <span
                                                                        class="text-danger">*</label>
                                                                <form:input path="email" type="email"
                                                                    class="form-control form-control-lg" id="email"
                                                                    placeholder="Enter email" />
                                                                <form:errors path="email" cssClass="text-danger" />
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="mb-4">
                                                        <label class="fw-bold">Supplier Address <span
                                                                class="text-danger">*</span></label>
                                                        <form:input path="address" type="text"
                                                            class="form-control form-control-lg" id="address"
                                                            placeholder="Enter supplier address" />
                                                        <form:errors path="address" cssClass="text-danger" />
                                                    </div>



                                                    <div class="row mb-4">
                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="fw-bold">Supplier Logo</label>
                                                                <div class="file-upload-wrapper">
                                                                    <input type="file" id="logoFile" name="logoFile"
                                                                        class="file-upload-input"
                                                                        data-preview="#logoPreview" accept="image/*">
                                                                    <form:hidden path="logoUrl" />
                                                                </div>
                                                                <div class="mt-2">
                                                                    <div id="logoPreview" class="img-preview">
                                                                        <c:if test="${not empty supplier.logoUrl}">
                                                                            <img src="${ctx}/${supplier.logoUrl}"
                                                                                alt="supplier Logo"
                                                                                class="img-fluid rounded"
                                                                                style="max-height: 150px;">
                                                                        </c:if>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>


                                                    <div class="col-md-4">
                                                        <div class="form-check form-switch mt-4">
                                                            <form:checkbox path="status" class="form-check-input"
                                                                id="isActiveSwitch" role="switch" />
                                                            <label class="form-check-label fw-bold"
                                                                for="isActiveSwitch">
                                                                Active Supplier
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                        </div>
                                        <div class="card-action">
                                            <button type="submit" class="btn btn-success">${supplier.supplierId != null
                                                ? 'Update' : 'Add'}</button>
                                            <button type="reset" class="btn btn-primary">Reset</button>
                                            <a href="/admin/supplier-mgr/list" class="btn btn-danger">Cancel</a>
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
                        $('#logoFile').change(function () {
                            handleFileInputChange(this);
                        });

                        $('#coverFile').change(function () {
                            handleFileInputChange(this);
                        });

                    });
                </script>

            </body>

            </html>