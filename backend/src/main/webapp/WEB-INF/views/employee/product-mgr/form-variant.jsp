<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <!DOCTYPE html>
            <html>

            <head>
                <title>${empty productVariant.productVariantId ? 'Add' : 'Edit'} Product Variant for
                    ${product.productName}</title>
                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <link rel="icon" href="${ctx}/resources/assets/user/img/home/walmart-logo.webp" type="image/x-icon" />
                <script src="${ctx}/resources/assets/dashboard/js/plugin/webfont/webfont.min.js"></script>
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/bootstrap.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/kaiadmin.min.css" />
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
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div class="main-panel">
                        <jsp:include page="../layout/header.jsp" />
                        <div class="container">
                            <div class="page-inner">
                                <div class="page-header">
                                    <h3 class="fw-bold mb-3">${empty productVariant.productVariantId ? 'Add New' :
                                        'Edit'} Variant for ${product.productName}</h3>
                                    <ul class="breadcrumbs mb-3">
                                        <li class="nav-home">
                                            <a href="${ctx}/employee/dashboard/index">
                                                <i class="icon-home"></i>
                                            </a>
                                        </li>
                                        <li class="separator">
                                            <i class="icon-arrow-right"></i>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${ctx}/employee/product-mgr/list">Products</a>
                                        </li>
                                        <li class="separator">
                                            <i class="icon-arrow-right"></i>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${ctx}/employee/product-mgr/detail/${product.productId}">Product
                                                Details</a>
                                        </li>
                                        <li class="separator">
                                            <i class="icon-arrow-right"></i>
                                        </li>
                                        <li class="nav-item">
                                            <a href="#">${empty productVariant.productVariantId ? 'Add' : 'Edit'}
                                                Variant</a>
                                        </li>
                                    </ul>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <div class="card-title">Variant Details</div>
                                            </div>
                                            <form:form modelAttribute="productVariant" action="${ctx}${formAction}"
                                                method="post" enctype="multipart/form-data">
                                                <div class="card-body">
                                                    <form:hidden path="productVariantId" />
                                                    <form:hidden path="product.productId" />

                                                    <div class="form-group">
                                                        <label for="SKU">SKU</label>
                                                        <form:input path="SKU" cssClass="form-control" id="SKU"
                                                            placeholder="Enter SKU" />
                                                        <form:errors path="SKU" cssClass="text-danger" />
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="color">Color</label>
                                                        <form:select path="color.colorId" cssClass="form-control"
                                                            id="color">
                                                            <form:option value="" label="--- Select Color ---" />
                                                            <form:options items="${colors}" itemValue="colorId"
                                                                itemLabel="colorName" />
                                                        </form:select>
                                                        <form:errors path="color" cssClass="text-danger" />
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="size">Size</label>
                                                        <form:select path="size.sizeId" cssClass="form-control"
                                                            id="size">
                                                            <form:option value="" label="--- Select Size ---" />
                                                            <form:options items="${sizes}" itemValue="sizeId"
                                                                itemLabel="sizeName" />
                                                        </form:select>
                                                        <form:errors path="size" cssClass="text-danger" />
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="quantityStock">Quantity in Stock</label>
                                                        <form:input type="number" path="quantityStock"
                                                            cssClass="form-control" id="quantityStock"
                                                            placeholder="Enter quantity" />
                                                        <form:errors path="quantityStock" cssClass="text-danger" />
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="imageUrl">Image URL (Optional)</label>
                                                        <input type="file" name="imageFile" class="form-control-file"
                                                            id="imageFile"
                                                            accept="image/png, image/jpeg, image/gif, image/webp" />
                                                        <form:errors path="imageUrl" cssClass="text-danger" />

                                                        <%-- Hiển thị thẻ img chỉ khi có imageUrl tồn tại --%>
                                                            <c:if test="${not empty productVariant.imageUrl}">
                                                                <img id="imagePreview"
                                                                    src="${ctx}/${productVariant.imageUrl}"
                                                                    alt="Variant Image Preview"
                                                                    style="max-width: 100px; margin-top: 10px;" />
                                                            </c:if>
                                                            <%-- Thêm một thẻ img rỗng và ẩn ban đầu cho trường hợp Add
                                                                hoặc khi chưa có ảnh --%>
                                                                <c:if test="${empty productVariant.imageUrl}">
                                                                    <img id="imagePreview" alt="Variant Image Preview"
                                                                        style="max-width: 100px; margin-top: 10px; display: none;" />
                                                                </c:if>


                                                                <c:if test="${not empty imageUploadError}">
                                                                    <div class="text-danger">${imageUploadError}</div>
                                                                </c:if>
                                                    </div>
                                                </div>
                                                <div class="card-action">
                                                    <button type="submit" class="btn btn-success">${empty
                                                        productVariant.productVariantId ? 'Add Variant' : 'Update
                                                        Variant'}</button>
                                                    <a href="${ctx}/employee/product-mgr/detail/${product.productId}"
                                                        class="btn btn-danger">Cancel</a>
                                                </div>
                                            </form:form>
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
                <script src="${ctx}/resources/assets/dashboard/js/kaiadmin.min.js"></script>

                <script>
                    // JavaScript để hiển thị ảnh preview khi chọn file
                    document.getElementById('imageFile').addEventListener('change', function (event) {
                        const [file] = event.target.files;
                        const imagePreview = document.getElementById('imagePreview');

                        if (file) {
                            const reader = new FileReader();
                            reader.onload = function (e) {
                                imagePreview.src = e.target.result;
                                imagePreview.style.display = 'block'; // Hiển thị thẻ img
                            }
                            reader.readAsDataURL(file);
                        } else {
                            // Nếu không có file nào được chọn, ẩn ảnh preview
                            imagePreview.src = '';
                            imagePreview.style.display = 'none';
                        }
                    });

                    // Khi trang tải xong (đối với trường hợp edit), kiểm tra nếu có ảnh hiện tại thì hiển thị
                    document.addEventListener('DOMContentLoaded', function () {
                        const imagePreview = document.getElementById('imagePreview');
                        // Nếu src của ảnh preview không rỗng (đã được set từ productVariant.imageUrl)
                        if (imagePreview.src && imagePreview.src !== window.location.href + '/') { // Kiểm tra src không phải là URL hiện tại + '/'
                            imagePreview.style.display = 'block';
                        } else {
                            imagePreview.style.display = 'none';
                        }
                    });
                </script>
            </body>

            </html>