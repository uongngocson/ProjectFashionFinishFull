<%@page contentType="text/html" pageEncoding="UTF-8" %>

    <!-- Sidebar -->
    <div class="sidebar" data-background-color="dark">
        <div class="sidebar-logo">
            <!-- Logo Header -->
            <div class="logo-header" data-background-color="dark">
                <a href="/employee/dashboard/index" class="logo">
                    <img src="../../../../resources/assets/dashboard/img/kaiadmin/favicon.ico" alt="navbar brand"
                        class="navbar-brand" height="20" />
                </a>

                <div class="nav-toggle">
                    <button class="btn btn-toggle toggle-sidebar">
                        <i class="gg-menu-right"></i>
                    </button>
                    <button class="btn btn-toggle sidenav-toggler">
                        <i class="gg-menu-left"></i>
                    </button>
                </div>
                <button class="topbar-toggler more">
                    <i class="gg-more-vertical-alt"></i>
                </button>
            </div>
            <!-- End Logo Header -->
        </div>
        <div class="sidebar-wrapper scrollbar scrollbar-inner">
            <div class="sidebar-content">
                <ul class="nav nav-secondary">
                    <!-- Dashboard -->
                    <!-- <li class="nav-item">
                        <a href="/employee/dashboard/index">
                            <i class="fas fa-home"></i>
                            <p>Dashboard</p>
                        </a>
                    </li> -->

                    <!-- Charts -->
                    <!-- <li class="nav-item">
                        <a data-bs-toggle="collapse" href="#charts">
                            <i class="fas fa-chart-bar"></i>
                            <p>Charts</p>
                            <span class="caret"></span>
                        </a>
                        <div class="collapse" id="charts">
                            <ul class="nav nav-collapse">
                                <li>
                                    <a href="#">
                                        <span class="sub-item">Revenue Over Time</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <span class="sub-item">Order Status Breakdown</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <span class="sub-item">Top Selling Products</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </li> -->

                    <!-- Customer Management -->
                    <!-- <li class="nav-item">
                        <a data-bs-toggle="collapse" href="#customers">
                            <i class="fas fa-users"></i>
                            <p>Customer Management</p>
                            <span class="caret"></span>
                        </a>
                        <div class="collapse" id="customers">
                            <ul class="nav nav-collapse">
                                <li>
                                    <a href="/employee/customer-mgr/list">
                                        <span class="sub-item">Customer List</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </li> -->

                    <!-- Employee Management -->
                    <!-- <li class="nav-item">
                        <a data-bs-toggle="collapse" href="#employees">
                            <i class="fas fa-users"></i>
                            <p>Employee Management</p>
                            <span class="caret"></span>
                        </a>
                        <div class="collapse" id="employees">
                            <ul class="nav nav-collapse">
                                <li>
                                    <a href="/employee/employee-mgr/list">
                                        <span class="sub-item">Employee List</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </li> -->

                    <!-- Supplier Management -->
                    <!-- <li class="nav-item">
                        <a data-bs-toggle="collapse" href="#suppliers">
                            <i class="fas fa-globe"></i>
                            <p>Supplier Management</p>
                            <span class="caret"></span>
                        </a>
                        <div class="collapse" id="suppliers">
                            <ul class="nav nav-collapse">
                                <li>
                                    <a href="/employee/supplier-mgr/list">
                                        <span class="sub-item">Supplier List</span>
                                    </a>
                                </li>

                            </ul>
                        </div>
                    </li> -->

                    <!-- Product Management -->
                    <li class="nav-item">
                        <a data-bs-toggle="collapse" href="#products">
                            <i class="fas fa-th"></i>
                            <p>Product Management</p>
                            <span class="caret"></span>
                        </a>
                        <div class="collapse" id="products">
                            <ul class="nav nav-collapse">
                                <li>
                                    <a href="/employee/product-mgr/list">
                                        <span class="sub-item">Product List</span>
                                    </a>
                                </li>
                                <!-- <li>
                                    <a href="#">
                                        <span class="sub-item">Brand List</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="/#">
                                        <span class="sub-item">Size List</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="/#">
                                        <span class="sub-item">Color List</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <span class="sub-item">Category List</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <span class="sub-item">Inventory</span>
                                    </a>
                                </li> -->
                            </ul>
                        </div>
                    </li>

                    <!-- Order Management -->
                    <li class="nav-item">
                        <a data-bs-toggle="collapse" href="#orders">
                            <i class="fas fa-shopping-cart"></i>
                            <p>Order Management</p>
                            <span class="caret"></span>
                        </a>
                        <div class="collapse" id="orders">
                            <ul class="nav nav-collapse">
                                <li>
                                    <a href="/employee/order-mgr/list">
                                        <span class="sub-item">Order List</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <span class="sub-item">Shipping Status</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <span class="sub-item">Shipper List</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <!-- Account Management -->
                    <!-- <li class="nav-item">
                        <a data-bs-toggle="collapse" href="#accounts">
                            <i class="fas fa-user-cog"></i>
                            <p>Account Management</p>
                            <span class="caret"></span>
                        </a>
                        <div class="collapse" id="accounts">
                            <ul class="nav nav-collapse">
                                <li>
                                    <a href="/employee/account-mgr/list">
                                        <span class="sub-item">Account List</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </li> -->
                </ul>
            </div>
        </div>
    </div>
    <!-- End Sidebar -->