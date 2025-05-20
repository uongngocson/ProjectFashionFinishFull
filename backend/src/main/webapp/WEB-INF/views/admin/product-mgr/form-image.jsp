<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>Add Product Image</title>
                <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <link rel="icon" href="${ctx}/resources/assets/user/img/home/walmart-logo.webp" type="image/x-icon" />
                <script src="${ctx}/resources/assets/dashboard/js/plugin/webfont/webfont.min.js"></script>
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/bootstrap.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/plugins.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/kaiadmin.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/demo.css" />
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
                            urls: ["${ctx}/resources/assets/dashboard/css/fonts.min.css"],
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
                                    <h3 class="fw-bold mb-3">Add Image for Product: ${product.productName}</h3>
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
                                        <li class="separator">
                                            <i class="icon-arrow-right"></i>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${ctx}/admin/product-mgr/detail/${product.productId}">Details</a>
                                        </li>
                                        <li class="separator">
                                            <i class="icon-arrow-right"></i>
                                        </li>
                                        <li class="nav-item">
                                            <a href="#">Add Image</a>
                                        </li>
                                    </ul>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <div class="card-title">Upload New Image</div>
                                            </div>
                                            <form:form method="POST"
                                                action="${ctx}/admin/product-image-mgr/add/${product.productId}"
                                                modelAttribute="productImage" enctype="multipart/form-data">
                                                <div class="card-body">
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

                                                    <div class="form-group">
                                                        <label for="imageFile">Image File</label>
                                                        <input type="file" class="form-control-file" id="imageFile"
                                                            name="imageFile" required
                                                            accept="image/png, image/jpeg, image/gif, image/webp" />
                                                        <small class="form-text text-muted">Accepted formats: PNG, JPG,
                                                            GIF, WEBP.</small>
                                                    </div>

                                                    <div class="form-group">
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="checkbox"
                                                                id="isDefault" name="isDefault" value="true">
                                                            <label class="form-check-label" for="isDefault">
                                                                Set as default image
                                                            </label>
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="card-action">
                                                    <button type="submit" class="btn btn-success">Upload Image</button>
                                                    <a href="${ctx}/admin/product-mgr/detail/${product.productId}"
                                                        class="btn btn-danger">Cancel</a>
                                                </div>
                                            </form:form>
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

                <script src="${ctx}/resources/assets/dashboard/js/core/jquery-3.7.1.min.js"></script>
                <script src="${ctx}/resources/assets/dashboard/js/core/popper.min.js"></script>
                <script src="${ctx}/resources/assets/dashboard/js/core/bootstrap.min.js"></script>
                <script
                    src="${ctx}/resources/assets/dashboard/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>
                <script src="${ctx}/resources/assets/dashboard/js/plugin/chart.js/chart.min.js"></script>
                <script
                    src="${ctx}/resources/assets/dashboard/js/plugin/jquery.sparkline/jquery.sparkline.min.js"></script>
                <script src="${ctx}/resources/assets/dashboard/js/plugin/chart-circle/circles.min.js"></script>
            </body>

            </html>