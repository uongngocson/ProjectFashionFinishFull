<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>Employee Details</title>
                <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
                <!-- set path -->
                <c:set var="ctx" value="${pageContext.request.contextPath}" />

                <link rel="icon" href="${ctx}/resources/assets/user/img/home/walmart-logo.webp" type="image/x-icon" />

                <script src="${ctx}/resources/assets/dashboard/js/plugin/webfont/webfont.min.js"></script>
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/bootstrap.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/plugins.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/kaiadmin.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/demo.css" />
                <!-- Add Font Awesome for better icons -->
                <link rel="stylesheet"
                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />

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

                <style>
                    .profile-header {
                        background-color: #4e73df;
                        color: white;
                        padding: 30px;
                        border-radius: 10px;
                        margin-bottom: 30px;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                    }

                    .profile-img {
                        width: 150px;
                        height: 150px;
                        border-radius: 50%;
                        border: 5px solid white;
                        object-fit: cover;
                        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                    }

                    .profile-name {
                        font-size: 28px;
                        font-weight: 700;
                        margin-top: 15px;
                        margin-bottom: 5px;
                    }

                    .profile-position {
                        font-size: 18px;
                        opacity: 0.9;
                        margin-bottom: 15px;
                    }

                    .profile-department {
                        display: inline-block;
                        background-color: rgba(255, 255, 255, 0.2);
                        padding: 5px 15px;
                        border-radius: 20px;
                        font-size: 14px;
                        margin-bottom: 10px;
                    }

                    .profile-status {
                        display: inline-block;
                        background-color: #1cc88a;
                        color: white;
                        padding: 5px 15px;
                        border-radius: 20px;
                        font-size: 14px;
                        margin-left: 10px;
                    }

                    .profile-status.inactive {
                        background-color: #e74a3b;
                    }

                    .info-card {
                        background-color: white;
                        border-radius: 10px;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
                        padding: 25px;
                        margin-bottom: 30px;
                        border-top: 4px solid #4e73df;
                    }

                    .info-title {
                        font-size: 18px;
                        font-weight: 600;
                        color: #2d3748;
                        margin-bottom: 20px;
                        padding-bottom: 15px;
                        border-bottom: 1px solid #e2e8f0;
                    }

                    .info-item {
                        margin-bottom: 20px;
                    }

                    .info-label {
                        font-weight: 600;
                        color: #4e73df;
                        margin-bottom: 5px;
                        font-size: 14px;
                    }

                    .info-value {
                        color: #2d3748;
                        font-size: 16px;
                    }

                    .info-icon {
                        color: #4e73df;
                        margin-right: 10px;
                        width: 20px;
                        text-align: center;
                    }

                    .action-buttons {
                        margin-top: 20px;
                    }

                    .btn-primary {
                        background-color: #4e73df;
                        border-color: #4e73df;
                    }

                    .btn-danger {
                        background-color: #e74a3b;
                        border-color: #e74a3b;
                    }

                    .btn-round {
                        border-radius: 30px;
                        padding: 8px 16px;
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
                                <div class="page-header">
                                    <h3 class="fw-bold mb-3">Employee Details</h3>
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
                                            <a href="/admin/employee-mgr/list">Employees</a>
                                        </li>
                                        <li class="separator">
                                            <i class="icon-arrow-right"></i>
                                        </li>
                                        <li class="nav-item">
                                            <a href="#">Details</a>
                                        </li>
                                    </ul>
                                </div>

                                <!-- Profile Header (simplified) -->
                                <div class="profile-header">
                                    <div class="row align-items-center">
                                        <div class="col-md-2 text-center">
                                            <img src="${not empty employee.imageUrl ? employee.imageUrl : ctx.concat('/resources/images-upload/logo-is-empty.jpg')}"
                                                alt="${employee.firstName}" class="profile-img">
                                        </div>
                                        <div class="col-md-10">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <h1 class="profile-name">${employee.firstName} ${employee.lastName}
                                                    </h1>
                                                    <div class="profile-position">Employee ID: #${employee.employeeId}
                                                    </div>
                                                </div>
                                                <div class="profile-status ${employee.status ? '' : 'inactive'}">
                                                    ${employee.status ? 'Active' : 'Inactive'}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Main Content Area -->
                                <div class="row">
                                    <!-- Left Column - Personal Info -->
                                    <div class="col-lg-4">
                                        <div class="card">
                                            <div class="card-header bg-primary text-white">
                                                <h4 class="mb-0"><i class="fas fa-user mr-2"></i>Personal Information
                                                </h4>
                                            </div>
                                            <div class="card-body">
                                                <ul class="list-group list-group-flush">
                                                    <li
                                                        class="list-group-item d-flex justify-content-between align-items-center">
                                                        <span><i class="fas fa-venus-mars mr-2"></i>Gender</span>
                                                        <span>${employee.gender ? 'Male' : 'Female'}</span>
                                                    </li>
                                                    <li
                                                        class="list-group-item d-flex justify-content-between align-items-center">
                                                        <span><i class="fas fa-birthday-cake mr-2"></i>Date of
                                                            Birth</span>
                                                        <span>
                                                            <fmt:formatDate value="${employee.getDateOfBirthAsDate()}"
                                                                pattern="dd/MM/yyyy" />
                                                        </span>
                                                    </li>
                                                    <li class="list-group-item">
                                                        <div><i class="fas fa-map-marker-alt mr-2"></i>Address</div>
                                                        <div class="text-muted mt-1">${not empty employee.address ?
                                                            employee.address : 'Not provided'}</div>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>

                                        <!-- Contact Card -->
                                        <div class="card mt-4">
                                            <div class="card-header bg-info text-white">
                                                <h4 class="mb-0"><i class="fas fa-address-book mr-2"></i>Contact</h4>
                                            </div>
                                            <div class="card-body">
                                                <ul class="list-group list-group-flush">
                                                    <li class="list-group-item">
                                                        <div><i class="fas fa-envelope mr-2"></i>Email</div>
                                                        <div class="text-muted mt-1">${employee.email}</div>
                                                    </li>
                                                    <li
                                                        class="list-group-item d-flex justify-content-between align-items-center">
                                                        <span><i class="fas fa-phone mr-2"></i>Phone</span>
                                                        <span>${employee.phone}</span>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Right Column - Employment Details -->
                                    <div class="col-lg-8">
                                        <div class="card">
                                            <div class="card-header bg-success text-white">
                                                <h4 class="mb-0"><i class="fas fa-briefcase mr-2"></i>Employment Details
                                                </h4>
                                            </div>
                                            <div class="card-body">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="mb-3">
                                                            <h6><i class="fas fa-calendar-day mr-2"></i>Hire Date</h6>
                                                            <p class="text-muted">
                                                                <fmt:formatDate value="${employee.getHireDateAsDate()}"
                                                                    pattern="dd/MM/yyyy" />
                                                            </p>
                                                        </div>
                                                        <div class="mb-3">
                                                            <h6><i class="fas fa-user-tie mr-2"></i>Manager</h6>
                                                            <p class="text-muted">${not empty employee.manager ?
                                                                employee.manager.firstName.concat('
                                                                ').concat(employee.manager.lastName) : 'No manager'}</p>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="mb-3">
                                                            <h6><i class="fas fa-dollar-sign mr-2"></i>Salary</h6>
                                                            <p class="text-muted">
                                                                <fmt:formatNumber value="${employee.salary}"
                                                                    type="currency" currencySymbol="$" />
                                                            </p>
                                                        </div>
                                                        <div class="mb-3">
                                                            <h6><i class="fas fa-user-shield mr-2"></i>Account</h6>
                                                            <p class="text-muted">${not empty employee.account ?
                                                                employee.account.username : 'No account linked'}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Action Buttons -->
                                        <div class="card mt-4">
                                            <div class="card-body text-center">
                                                <a href="/admin/employee-mgr/update/${employee.employeeId}"
                                                    class="btn btn-primary btn-lg mr-3">
                                                    <i class="fas fa-edit mr-2"></i>Update Employee
                                                </a>
                                                <button onclick="deleteEmployee('${employee.employeeId}')"
                                                    class="btn btn-danger btn-lg">
                                                    <i class="fas fa-trash-alt mr-2"></i>Delete Employee
                                                </button>
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
                    function deleteEmployee(employeeId) {
                        swal({
                            title: 'Are you sure?',
                            text: "You won't be able to revert this!",
                            icon: 'warning',
                            buttons: {
                                cancel: {
                                    visible: true,
                                    text: 'Cancel',
                                    className: 'btn btn-secondary'
                                },
                                confirm: {
                                    text: 'Yes, delete it!',
                                    className: 'btn btn-danger'
                                }
                            }
                        }).then((willDelete) => {
                            if (willDelete) {
                                $.ajax({
                                    url: '/admin/employee-mgr/delete/' + employeeId,
                                    type: 'POST',
                                    success: function (result) {
                                        swal({
                                            title: 'Deleted!',
                                            text: 'Employee has been deleted.',
                                            icon: 'success'
                                        }).then(() => {
                                            window.location.href = '/admin/employee-mgr/list';
                                        });
                                    },
                                    error: function (error) {
                                        swal('Error!', 'Something went wrong.', 'error');
                                    }
                                });
                            }
                        });
                    }
                </script>
            </body>

            </html>