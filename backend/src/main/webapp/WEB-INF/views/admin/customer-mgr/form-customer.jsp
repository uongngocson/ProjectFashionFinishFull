<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>${customer.customerId != null ? 'Update' : 'Create'} Customer</title>
                <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
                <!-- set path -->
                <c:set var="ctx" value="${pageContext.request.contextPath}" />

                <link rel="icon" href="${ctx}/resources/assets/user/img/home/walmart-logo.webp" type="image/x-icon" />

                <!-- Fonts and icons -->
                <script src="${ctx}/resources/assets/dashboard/js/plugin/webfont/webfont.min.js"></script>
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

                <!-- CSS Files -->
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/bootstrap.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/plugins.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/kaiadmin.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/demo.css" />
                <!-- Add Font Awesome for better icons -->
                <link rel="stylesheet"
                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />

                <style>
                    .form-group label {
                        font-weight: 600;
                        color: #4a5568;
                    }

                    .form-control {
                        border-radius: 8px;
                        padding: 10px 15px;
                        border: 1px solid #e2e8f0;
                    }

                    .form-control:focus {
                        border-color: #4299e1;
                        box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.15);
                    }

                    .card {
                        border-radius: 10px;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
                        border: none;
                    }

                    .card-header {
                        background-color: #fff;
                        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
                        padding: 20px 25px;
                    }

                    .card-title {
                        font-weight: 600;
                        color: #2d3748;
                    }

                    .card-body {
                        padding: 25px;
                    }

                    .card-action {
                        padding: 15px 25px;
                        background-color: #f9fafb;
                        border-top: 1px solid rgba(0, 0, 0, 0.05);
                    }

                    .btn {
                        padding: 8px 16px;
                        font-weight: 500;
                        border-radius: 8px;
                    }

                    .btn-success {
                        background-color: #48bb78;
                        border-color: #48bb78;
                    }

                    .btn-primary {
                        background-color: #4299e1;
                        border-color: #4299e1;
                    }

                    .btn-danger {
                        background-color: #f56565;
                        border-color: #f56565;
                    }

                    .text-danger {
                        color: #e53e3e !important;
                    }

                    .custom-radio,
                    .custom-checkbox {
                        margin-right: 15px;
                    }

                    .gender-options {
                        display: flex;
                        gap: 20px;
                    }

                    .gender-option {
                        display: flex;
                        align-items: center;
                        gap: 5px;
                    }

                    .form-section {
                        margin-bottom: 30px;
                    }

                    .form-section-title {
                        font-weight: 600;
                        color: #4a5568;
                        margin-bottom: 15px;
                        padding-bottom: 10px;
                        border-bottom: 1px solid #e2e8f0;
                    }

                    /* Improved gender selection */
                    .gender-options {
                        display: flex;
                        gap: 20px;
                        margin-top: 10px;
                    }

                    .gender-option {
                        display: flex;
                        align-items: center;
                        background-color: #f8f9fa;
                        border-radius: 8px;
                        padding: 10px 15px;
                        cursor: pointer;
                        transition: all 0.3s ease;
                        border: 1px solid #e2e8f0;
                    }

                    .gender-option:hover {
                        background-color: #edf2f7;
                    }

                    .gender-option input[type="radio"] {
                        margin-right: 8px;
                    }

                    .gender-option.selected {
                        background-color: #ebf8ff;
                        border-color: #4299e1;
                    }
                </style>
            </head>

            <body>
                <div class="wrapper">
                    <!-- Sidebar -->
                    <jsp:include page="../layout/sidebar.jsp" />
                    <!-- End Sidebar -->

                    <div class="main-panel">
                        <jsp:include page="../layout/header.jsp" />

                        <div class="container">
                            <div class="page-inner">

                                <!-- Page header-->
                                <div class="page-header">
                                    <h3 class="fw-bold mb-3">${customer.customerId != null ? 'Update' : 'Create'}
                                        Customer
                                    </h3>
                                    <ul class="breadcrumbs mb-3">
                                        <li class="nav-home">
                                            <a href="/admin/dashboard/index"><i class="icon-home"></i></a>
                                        </li>
                                        <li class="separator"><i class="icon-arrow-right"></i></li>
                                        <li class="nav-item"><a href="/admin/customer-mgr/list">Customers</a></li>
                                        <li class="separator"><i class="icon-arrow-right"></i></li>
                                        <li class="nav-item"><a href="#">${customer.customerId != null ? 'Edit' :
                                                'Create'}</a>
                                        </li>
                                    </ul>
                                </div>
                                <!-- End Page header-->

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <div class="card-title">
                                                    <i class="fas fa-user-edit mr-2 text-primary"></i>
                                                    ${customer.customerId != null ? 'Update Customer' : 'Create New
                                                    Customer'}
                                                </div>
                                            </div>
                                            <form:form action="/admin/customer-mgr/save" method="post"
                                                modelAttribute="customer" enctype="multipart/form-data">
                                                <div class="card-body">
                                                    <c:if test="${not empty customer.customerId}">
                                                        <form:hidden path="customerId" />
                                                    </c:if>

                                                    <div class="form-section">
                                                        <div class="row">
                                                            <!-- First Name -->
                                                            <div class="col-md-6 mb-3">
                                                                <div class="form-group">
                                                                    <label for="firstName" class="form-label">
                                                                        <i class="fas fa-user me-2 text-primary"></i>
                                                                        First Name <span class="text-danger">*</span>
                                                                    </label>
                                                                    <form:input path="firstName" type="text"
                                                                        class="form-control" id="firstName"
                                                                        placeholder="Enter first name"
                                                                        required="true" />
                                                                    <form:errors path="firstName"
                                                                        cssClass="invalid-feedback d-block" />
                                                                </div>
                                                            </div>

                                                            <!-- Last Name -->
                                                            <div class="col-md-6 mb-3">
                                                                <div class="form-group">
                                                                    <label for="lastName" class="form-label">
                                                                        <i class="fas fa-user me-2 text-primary"></i>
                                                                        Last Name <span class="text-danger">*</span>
                                                                    </label>
                                                                    <form:input path="lastName" type="text"
                                                                        class="form-control" id="lastName"
                                                                        placeholder="Enter last name" required="true" />
                                                                    <form:errors path="lastName"
                                                                        cssClass="invalid-feedback d-block" />
                                                                </div>
                                                            </div>

                                                            <!-- Email -->
                                                            <div class="col-md-6 mb-3">
                                                                <div class="form-group">
                                                                    <label for="email" class="form-label">
                                                                        <i
                                                                            class="fas fa-envelope me-2 text-primary"></i>
                                                                        Email <span class="text-danger">*</span>
                                                                    </label>
                                                                    <form:input path="email" type="email"
                                                                        class="form-control" id="email"
                                                                        placeholder="Enter email address" />
                                                                    <form:errors path="email"
                                                                        cssClass="invalid-feedback d-block" />
                                                                </div>
                                                            </div>

                                                            <!-- Phone Number -->
                                                            <div class="col-md-6 mb-3">
                                                                <div class="form-group">
                                                                    <label for="phone" class="form-label">
                                                                        <i class="fas fa-phone me-2 text-primary"></i>
                                                                        Phone Number <span class="text-danger">*</span>
                                                                    </label>
                                                                    <form:input path="phone" type="tel"
                                                                        class="form-control" id="phone"
                                                                        placeholder="Enter phone number"
                                                                        required="true" />
                                                                    <form:errors path="phone"
                                                                        cssClass="invalid-feedback d-block" />
                                                                </div>
                                                            </div>

                                                            <!-- Date of Birth -->
                                                            <div class="col-md-6 mb-3">
                                                                <div class="form-group">
                                                                    <label for="dateOfBirth" class="form-label">
                                                                        <i
                                                                            class="fas fa-birthday-cake me-2 text-primary"></i>
                                                                        Date of Birth <span class="text-danger">*</span>
                                                                    </label>
                                                                    <form:input path="dateOfBirth" type="date"
                                                                        class="form-control" id="dateOfBirth"
                                                                        required="true" />
                                                                    <form:errors path="dateOfBirth"
                                                                        cssClass="invalid-feedback d-block" />
                                                                </div>
                                                            </div>

                                                            <script>
                                                                document.addEventListener("DOMContentLoaded", function () {
                                                                    const today = new Date().toISOString().split("T")[0];
                                                                    document.getElementById("dateOfBirth").setAttribute("max", today);
                                                                });
                                                            </script>


                                                            <!-- Gender -->
                                                            <div class="col-md-6 mb-3">
                                                                <div class="form-group">
                                                                    <label class="form-label d-block">
                                                                        <i
                                                                            class="fas fa-venus-mars me-2 text-primary"></i>
                                                                        Gender <span class="text-danger">*</span>
                                                                    </label>
                                                                    <div class="d-flex gap-3">
                                                                        <div class="form-check form-check-inline">
                                                                            <form:radiobutton path="gender" value="true"
                                                                                id="male" class="form-check-input" />
                                                                            <label for="male"
                                                                                class="form-check-label">Male</label>
                                                                        </div>
                                                                        <div class="form-check form-check-inline">
                                                                            <form:radiobutton path="gender"
                                                                                value="false" id="female"
                                                                                class="form-check-input" />
                                                                            <label for="female"
                                                                                class="form-check-label">Female</label>
                                                                        </div>
                                                                    </div>
                                                                    <form:errors path="gender"
                                                                        cssClass="invalid-feedback d-block" />
                                                                </div>
                                                            </div>

                                                            <!-- Status -->
                                                            <div class="col-md-6 mb-3">
                                                                <div class="form-group form-switch">
                                                                    <label for="status" class="form-check-label ms-2">
                                                                        Active
                                                                    </label>
                                                                    <form:checkbox path="status" id="status"
                                                                        class="form-check-input ms-2" role="switch" />
                                                                    <form:errors path="status"
                                                                        cssClass="invalid-feedback d-block" />
                                                                </div>
                                                            </div>

                                                            <!-- Profile Image -->
                                                            <div class="col-md-6 mb-3">
                                                                <div class="form-group">
                                                                    <label for="imageUrl" class="form-label">
                                                                        <i class="fas fa-image me-2 text-primary"></i>
                                                                        Profile Image
                                                                    </label>
                                                                    <input type="file" class="form-control"
                                                                        id="imageUrl" name="imageFile" accept="image/*">
                                                                    <form:hidden path="imageUrl" />
                                                                    <div class="mt-2">
                                                                        <div id="imagePreview" class="img-preview">
                                                                            <c:if test="${not empty customer.imageUrl}">
                                                                                <img src="${customer.imageUrl}"
                                                                                    alt="Profile Image"
                                                                                    class="img-thumbnail mt-2"
                                                                                    style="max-height: 150px;">
                                                                            </c:if>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="card-action">
                                                            <button type="submit" class="btn btn-success">
                                                                <i class="fa fa-save mr-1"></i> ${customer.customerId
                                                                != null ? 'Update' : 'Add'}</button>
                                                            <button type="reset" class="btn btn-primary"><i
                                                                    class="fa fa-redo mr-1"></i> Reset</button>
                                                            <a href="/admin/customer-mgr/list" class="btn btn-danger"><i
                                                                    class="fa fa-times mr-1"></i> Cancel</a>
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
                <script src="${ctx}/resources/assets/dashboard/js/core/jquery-3.7.1.min.js"></script>
                <script src="${ctx}/resources/assets/dashboard/js/core/popper.min.js"></script>
                <script src="${ctx}/resources/assets/dashboard/js/core/bootstrap.min.js"></script>

                <!-- jQuery Scrollbar -->
                <script
                    src="${ctx}/resources/assets/dashboard/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

                <!-- Sweet Alert -->
                <script src="${ctx}/resources/assets/dashboard/js/plugin/sweetalert/sweetalert.min.js"></script>

                <!-- Kaiadmin JS -->
                <script src="${ctx}/resources/assets/dashboard/js/kaiadmin.min.js"></script>

                <!-- Custom JS -->
                <script>
                    $(document).ready(function () {
                        // Format date for HTML5 date input (YYYY-MM-DD)
                        const dateOfBirth = '${customer.dateOfBirth}';
                        if (dateOfBirth) {
                            const formattedDate = new Date(dateOfBirth).toISOString().split('T')[0];
                            $('#dateOfBirth').val(formattedDate);
                        }

                        // Set max date to today
                        const today = new Date().toISOString().split('T')[0];
                        $('#dateOfBirth').attr('max', today);
                        // Prevent future dates from being selected
                        $('#dateOfBirth').on('change', function () {
                            const selectedDate = new Date(this.value);
                            const today = new Date();
                            if (selectedDate > today) {
                                alert('Date of birth cannot be in the future');
                                this.value = '';
                            }
                        });

                        // Update file input label with selected filename
                        $('.custom-file-input').on('change', function () {
                            let fileName = $(this).val().split('\\').pop();
                            $(this).next('.custom-file-label').html(fileName || 'Choose file');

                            // Handle image preview
                            if (this.files && this.files[0]) {
                                const reader = new FileReader();

                                reader.onload = function (e) {
                                    // Clear previous preview
                                    $('#imagePreview').html('');

                                    // Create and append new image preview
                                    const img = $('<img>')
                                        .attr('src', e.target.result)
                                        .addClass('img-fluid rounded')
                                        .css('max-height', '150px');

                                    $('#imagePreview').append(img);
                                }

                                reader.readAsDataURL(this.files[0]);
                            }
                        });

                        // Show existing image on page load if available
                        if ($('#imagePreview img').length === 0 && $('#imageUrl').val()) {
                            $('#imagePreview').html('<img src="' + $('#imageUrl').val() + '" alt="Profile Image" class="img-fluid rounded" style="max-height: 150px;">');
                        }

                    });
                </script>

            </body>

            </html>