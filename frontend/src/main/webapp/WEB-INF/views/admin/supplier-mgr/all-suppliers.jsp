<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <title>Supplier Management</title>
            <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
            <link rel="icon" href="../../../../resources/assets/user/img/home/walmart-logo.webp" type="image/x-icon" />
            <script src="../../../../resources/assets/dashboard/js/plugin/webfont/webfont.min.js"></script>
            <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/bootstrap.min.css" />
            <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/plugins.min.css" />
            <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/kaiadmin.min.css" />
            <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/demo.css" />

            <link rel="stylesheet"
                href="../../../../resources/assets/dashboard/js/plugin/datatables/datatables.min.js" />


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
                <!-- Sidebar -->
                <jsp:include page="../layout/sidebar.jsp" />
                <div class="main-panel">
                    <jsp:include page="../layout/header.jsp" />
                    <div class="container">
                        <div class="page-inner">
                            <div class="page-header">
                                <h3 class="fw-bold mb-3">Suppliers</h3>
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
                                </ul>
                            </div>
                            <!-- start supplier datatable -->
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card">
                                        <div class="card-header">
                                            <div class="d-flex align-items-center">
                                                <h4 class="card-title">Suppliers list</h4>
                                                <a href="/admin/supplier-mgr/create"
                                                    class="btn btn-primary btn-round ms-auto">
                                                    <i class="fas fa-plus"></i> Add New Supplier
                                                </a>

                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div class="table-responsive">
                                                <div class="table-responsive">
                                                    <table id="add-row" class="table table-hover">
                                                        <thead>
                                                            <tr>
                                                                <th>No.</th>
                                                                <th>ID</th>
                                                                <th>Name</th>
                                                                <th>Contact</th>
                                                                <th>Phone</th>
                                                                <th>Email</th>
                                                                <th>Address</th>
                                                                <th>Active</th>
                                                                <th>Actions</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="supplier" items="${suppliers}"
                                                                varStatus="status">
                                                                <tr>
                                                                    <td>${status.index+1}</td>
                                                                    <td>
                                                                        <a href="/supplier/${supplier.supplierId}"
                                                                            class="text-primary">#${supplier.supplierId}</a>
                                                                    </td>
                                                                    <td>${supplier.supplierName}</td>
                                                                    <td>${supplier.contactPerson}</td>
                                                                    <td>${supplier.phone}</td>
                                                                    <td>${supplier.email}</td>
                                                                    <td>${supplier.address}</td>
                                                                    <td>
                                                                        <span
                                                                            class="badge badge-${supplier.status ? 'success' : 'danger'}">
                                                                            ${supplier.status ? 'Active' : 'Inactive'}
                                                                        </span>
                                                                    </td>
                                                                    <td>
                                                                        <div class="btn-group">
                                                                            <a href="/admin/supplier-mgr/detail/${supplier.supplierId}"
                                                                                class="btn btn-sm btn-info">
                                                                                <i class="fas fa-eye"></i>
                                                                            </a>
                                                                            <a href="/admin/supplier-mgr/update/${supplier.supplierId}"
                                                                                class="btn btn-sm btn-primary">
                                                                                <i class="fas fa-edit"></i>
                                                                            </a>
                                                                            <button type="button"
                                                                                class="btn btn-sm btn-danger"
                                                                                onclick="confirmDelete('${supplier.supplierId}')">
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
                            <!-- end supplier datatable -->
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
                function confirmDelete(supplierId) {
                    swal({
                        title: "Are you sure you want to delete this supplier?",
                        text: "This action cannot be undone.",
                        icon: "warning",
                        buttons: ["Cancel", "Delete"],
                        dangerMode: true,
                    }).then((confirmed) => {
                        if (confirmed) {
                            $.post(`/admin/supplier-mgr/delete/${supplierId}`)
                                .done(() => {
                                    swal("Deleted!", "The supplier has been successfully deleted.", "success")
                                        .then(() => location.reload());
                                })
                                .fail(() => {
                                    swal("Error!", "Something went wrong. Please try again.", "error");
                                });
                        }
                    });
                }
            </script>


            <script>
                $(document).ready(function () {
                    // Add Row
                    $("#add-row").DataTable({
                        pageLength: 10,
                        lengthMenu: [5, 10, 25, 50, 100],
                        columnDefs: [
                            {
                                targets: [7],
                                orderable: false,
                                searchable: false
                            },
                            {
                                targets: [8],
                                orderable: false,
                                searchable: false
                            }
                        ]
                    });
                });
            </script>
        </body>

        </html>