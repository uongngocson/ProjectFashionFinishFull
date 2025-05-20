<%@page contentType="text/html" pageEncoding="UTF-8" %>

    <!-- Sidebar -->
    <div class="sidebar" data-background-color="dark">
        <div class="sidebar-logo">
            <!-- Logo Header -->
            <div class="logo-header" data-background-color="dark">
                <a href="/shipper/order/list" class="logo">
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
                    <!-- ORDER -->
                    <li class="nav-item">
                        <a data-bs-toggle="collapse" href="#orders">
                            <i class="fas fa-shopping-cart"></i>
                            <p>Orders</p>
                            <span class="caret"></span>
                        </a>
                        <div class="collapse" id="orders">
                            <ul class="nav nav-collapse">
                                <li>
                                    <a href="/shipper/order/list">
                                        <span class="sub-item">order List</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </li>

                    <!-- Shipments -->
                    <li class="nav-item">
                        <a data-bs-toggle="collapse" href="#shipments">
                            <i class="fas fa-th"></i>
                            <p>Shipments</p>
                            <span class="caret"></span>
                        </a>
                        <div class="collapse" id="shipments">
                            <ul class="nav nav-collapse">
                                <li>
                                    <a href="/shipper/shipment/list">
                                        <span class="sub-item">shipment List</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </li>

                </ul>
            </div>
        </div>
    </div>
    <!-- End Sidebar -->