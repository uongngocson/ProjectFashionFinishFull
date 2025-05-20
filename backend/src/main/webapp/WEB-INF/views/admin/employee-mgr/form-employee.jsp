<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>${employee.employeeId != null ? 'Edit' : 'Create'} Employee</title>
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
                        color: #2d3748;
                        margin-bottom: 8px;
                    }

                    .form-control {
                        border-radius: 8px;
                        padding: 10px 15px;
                        border: 1px solid #e2e8f0;
                        transition: all 0.3s;
                    }

                    .form-control:focus {
                        border-color: #4e73df;
                        box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
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

                    .btn-primary {
                        background-color: #4e73df;
                        border-color: #4e73df;
                    }

                    .btn-success {
                        background-color: #1cc88a;
                        border-color: #1cc88a;
                    }

                    .btn-danger {
                        background-color: #e74a3b;
                        border-color: #e74a3b;
                    }

                    .text-danger {
                        color: #e74a3b !important;
                    }

                    .gender-options {
                        display: flex;
                        gap: 20px;
                        margin-top: 10px;
                    }

                    .gender-option {
                        display: flex;
                        align-items: center;
                        gap: 8px;
                    }

                    .custom-file-label {
                        border-radius: 8px;
                        padding: 10px 15px;
                        border: 1px solid #e2e8f0;
                    }

                    .img-preview {
                        margin-top: 15px;
                    }

                    .custom-control-input:checked~.custom-control-label::before {
                        background-color: #4e73df;
                        border-color: #4e73df;
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
                                    <h3 class="fw-bold mb-3">${employee.employeeId != null ? 'Edit' : 'Create'} Employee
                                    </h3>
                                    <ul class="breadcrumbs mb-3">
                                        <li class="nav-home">
                                            <a href="/admin/dashboard/index"><i class="icon-home"></i></a>
                                        </li>
                                        <li class="separator"><i class="icon-arrow-right"></i></li>
                                        <li class="nav-item"><a href="/admin/employee-mgr/list">Employees</a></li>
                                        <li class="separator"><i class="icon-arrow-right"></i></li>
                                        <li class="nav-item"><a href="#">${employee.employeeId != null ? 'Edit' :
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
                                                    ${employee.employeeId != null ? 'Update Employee' : 'Create New
                                                    Employee'}
                                                </div>
                                            </div>
                                            <form:form action="/admin/employee-mgr/save" method="post"
                                                modelAttribute="employee" enctype="multipart/form-data">
                                                <div class="card-body">
                                                    <form:hidden path="employeeId" />

                                                    <div class="row">
                                                        <!-- First Name -->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="firstName">
                                                                    <i class="fas fa-user mr-1 text-primary"></i>
                                                                    First Name <span class="text-danger">*</span>
                                                                </label>
                                                                <form:input path="firstName" type="text"
                                                                    class="form-control" id="firstName"
                                                                    placeholder="Enter first name" />
                                                                <form:errors path="firstName" cssClass="text-danger" />
                                                            </div>
                                                        </div>

                                                        <!-- Last Name -->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="lastName">
                                                                    <i class="fas fa-user mr-1 text-primary"></i>
                                                                    Last Name <span class="text-danger">*</span>
                                                                </label>
                                                                <form:input path="lastName" type="text"
                                                                    class="form-control" id="lastName"
                                                                    placeholder="Enter last name" />
                                                                <form:errors path="lastName" cssClass="text-danger" />
                                                            </div>
                                                        </div>

                                                        <!-- Email -->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="email">
                                                                    <i class="fas fa-envelope mr-1 text-primary"></i>
                                                                    Email <span class="text-danger">*</span>
                                                                </label>
                                                                <form:input path="email" type="email"
                                                                    class="form-control" id="email"
                                                                    placeholder="Enter email address" />
                                                                <form:errors path="email" cssClass="text-danger" />
                                                            </div>
                                                        </div>

                                                        <!-- Phone -->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="phone">
                                                                    <i class="fas fa-phone mr-1 text-primary"></i>
                                                                    Phone Number <span class="text-danger">*</span>
                                                                </label>
                                                                <form:input path="phone" type="tel" class="form-control"
                                                                    id="phone" placeholder="Enter phone number" />
                                                                <form:errors path="phone" cssClass="text-danger" />
                                                            </div>
                                                        </div>

                                                        <!-- Address -->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="address">
                                                                    <i
                                                                        class="fas fa-map-marker-alt mr-1 text-primary"></i>
                                                                    Address
                                                                </label>
                                                                <form:input path="address" type="text"
                                                                    class="form-control" id="address"
                                                                    placeholder="Enter address" />
                                                                <form:errors path="address" cssClass="text-danger" />
                                                            </div>
                                                        </div>

                                                        <!-- Date of Birth -->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="dateOfBirth">
                                                                    <i
                                                                        class="fas fa-birthday-cake mr-1 text-primary"></i>
                                                                    Date of Birth <span class="text-danger">*</span>
                                                                </label>
                                                                <form:input path="dateOfBirth" type="date"
                                                                    class="form-control" id="dateOfBirth" />
                                                                <form:errors path="dateOfBirth"
                                                                    cssClass="text-danger" />
                                                            </div>
                                                        </div>
                                                        <script>
                                                            document.addEventListener("DOMContentLoaded", function () {
                                                                const today = new Date().toISOString().split("T")[0];
                                                                document.getElementById("dateOfBirth").setAttribute("max", today);
                                                            });
                                                        </script>

                                                        <!-- Hire Date -->
                                                        <!-- <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="hireDate">
                                                                    <i
                                                                        class="fas fa-calendar-alt mr-1 text-primary"></i>
                                                                    Hire Date
                                                                </label>
                                                                <form:input path="hireDate" type="date"
                                                                    class="form-control" id="hireDate" />
                                                                <form:errors path="hireDate" cssClass="text-danger" />
                                                            </div>
                                                        </div> -->

                                                        <!-- Salary -->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="salary">
                                                                    <i class="fas fa-dollar-sign mr-1 text-primary"></i>
                                                                    Salary <span class="text-danger">*</span>
                                                                </label>
                                                                <form:input path="salary" type="number" step="0.01"
                                                                    class="form-control" id="salary"
                                                                    placeholder="Enter salary" />
                                                                <form:errors path="salary" cssClass="text-danger" />
                                                            </div>
                                                        </div>

                                                        <!-- Manager Selection -->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="manager">
                                                                    <i class="fas fa-user-tie mr-1 text-primary"></i>
                                                                    Manager
                                                                </label>
                                                                <form:select path="manager" class="form-control"
                                                                    id="manager">
                                                                    <form:option value=""
                                                                        label="-- Select Manager --" />
                                                                    <c:forEach items="${managers}" var="managerItem">
                                                                        <form:option value="${managerItem.employeeId}"
                                                                            label="${managerItem.firstName} ${managerItem.lastName}"
                                                                            selected="${employee.manager != null && employee.manager.employeeId == managerItem.employeeId ? 'selected' : ''}" />
                                                                    </c:forEach>
                                                                </form:select>
                                                                <form:errors path="manager" cssClass="text-danger" />
                                                            </div>
                                                        </div>

                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="account">
                                                                    <i class="fas fa-user-tie mr-1 text-primary"></i>
                                                                    account
                                                                </label>
                                                                <form:select path="account" class="form-control"
                                                                    id="account">
                                                                    <form:option value=""
                                                                        label="-- Select account --" />
                                                                    <c:forEach items="${accounts}" var="account">
                                                                        <form:option value="${account.accountId}"
                                                                            label="${account.getLoginName()}"
                                                                            selected="${employee.account != null && employee.account.accountId == account.accountId ? 'selected' : ''}" />
                                                                    </c:forEach>
                                                                </form:select>
                                                                <form:errors path="account" cssClass="text-danger" />
                                                            </div>
                                                        </div>

                                                        <!-- Gender -->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label>
                                                                    <i class="fas fa-venus-mars mr-1 text-primary"></i>
                                                                    Gender <span class="text-danger">*</span>
                                                                </label>
                                                                <div class="gender-options">
                                                                    <div class="gender-option">
                                                                        <form:radiobutton path="gender" value="true"
                                                                            id="male" />
                                                                        <label for="male">Male</label>
                                                                    </div>
                                                                    <div class="gender-option">
                                                                        <form:radiobutton path="gender" value="false"
                                                                            id="female" />
                                                                        <label for="female">Female</label>
                                                                    </div>
                                                                </div>
                                                                <form:errors path="gender" cssClass="text-danger" />
                                                            </div>
                                                        </div>

                                                        <!-- Status -->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <div class="custom-control custom-switch">
                                                                    <form:checkbox path="status" id="status"
                                                                        cssClass="custom-control-input" />
                                                                    <label class="custom-control-label" for="status">
                                                                        Active
                                                                    </label>
                                                                </div>
                                                                <form:errors path="status" cssClass="text-danger" />
                                                            </div>
                                                        </div>

                                                        <!-- imageUrl -->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="imageUrl">
                                                                    <i class="fas fa-image mr-1 text-primary"></i>
                                                                    Image path
                                                                </label>
                                                                <div class="custom-file">
                                                                    <input type="file" class="custom-file-input"
                                                                        id="imageUrl" name="imageFile" accept="image/*">
                                                                    <form:hidden path="imageUrl" />
                                                                </div>
                                                                <div class="mt-3">
                                                                    <div id="imagePreview" class="img-preview">
                                                                        <c:if test="${not empty employee.imageUrl}">
                                                                            <img src="${employee.imageUrl}"
                                                                                alt="Profile Image"
                                                                                class="img-fluid rounded"
                                                                                style="max-height: 150px;">
                                                                        </c:if>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="card-action">
                                                    <button type="submit" class="btn btn-success">
                                                        <i class="fa fa-save mr-1"></i> ${employee.employeeId != null ?
                                                        'Update' : 'Add'}</button>
                                                    <button type="reset" class="btn btn-primary"><i
                                                            class="fa fa-redo mr-1" id="btn-reset"></i> Reset</button>
                                                    <a href="/admin/employee-mgr/list" class="btn btn-danger"><i
                                                            class="fa fa-times mr-1"></i> Cancel</a>
                                                </div>
                                            </form:form>
                                        </div>
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

                <script>
                    // Hide reset button if update
                    $(document).ready(function () {
                        var employeeId = '<c:out value="${employee.employeeId}" />';
                        if (employeeId !== '') {
                            $('#btn-reset').parent().hide();
                        }

                        // Format date fields for display
                        function formatDateForInput(dateString) {
                            if (!dateString) return '';

                            // Handle different date formats
                            let date;
                            if (dateString.includes('T')) {
                                // ISO format
                                date = new Date(dateString);
                            } else if (dateString.includes('-')) {
                                // YYYY-MM-DD format
                                date = new Date(dateString);
                            } else {
                                // Try to parse as is
                                date = new Date(dateString);
                            }

                            if (isNaN(date.getTime())) return '';

                            // Format as YYYY-MM-DD for input[type=date]
                            return date.toISOString().split('T')[0];
                        }

                        // Set date of birth if exists
                        var dateOfBirth = '<c:out value="${employee.dateOfBirth}" />';
                        if (dateOfBirth) {
                            $('#dateOfBirth').val(formatDateForInput(dateOfBirth));
                        }

                        // Set hire date if exists, otherwise set to today for new employees
                        var hireDate = '<c:out value="${employee.hireDate}" />';
                        if (hireDate) {
                            $('#hireDate').val(formatDateForInput(hireDate));
                        } else if (!employeeId) {
                            // For new employee, set hire date to today
                            var today = new Date();
                            var formattedToday = today.toISOString().split('T')[0];
                            $('#hireDate').val(formattedToday);
                        }
                    });
                </script>

                <!-- Custom JS -->
                <script>
                    $(document).ready(function () {
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