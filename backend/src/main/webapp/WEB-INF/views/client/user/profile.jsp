<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>DDTS | Your Profile</title>
                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <script src="https://cdn.tailwindcss.com"></script>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link
                    href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;500;600;700&display=swap"
                    rel="stylesheet">
                <link href="${ctx}/resources/assets/client/css/profile.css" rel="stylesheet">

            </head>

            <body class="bg-white">
                <!-- navbar -->
                <jsp:include page="../layout/navbar.jsp" />
                <div class="container mx-auto px-4 py-12 max-w-6xl">

                    <!-- Profile Section -->
                    <section class="pt-[64px] mb-16">
                        <div class="flex justify-between items-center mb-6">
                            <h2 class="text-2xl font-medium">Your Profile</h2>
                            <button class="btn-black bg-black text-white px-6 py-2 rounded-full text-sm">
                                Edit Info
                            </button>
                        </div>

                        <div class="bg-white p-8 shadow-sm">
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                                <div>
                                    <h3 class="text-lg font-medium mb-4">Personal Information</h3>
                                    <div class="space-y-4">
                                        <div>
                                            <p class="text-gray-500 text-sm">Full Name</p>
                                            <p class="font-medium">Eleanor Montgomery</p>
                                        </div>
                                        <div>
                                            <p class="text-gray-500 text-sm">Email</p>
                                            <p class="font-medium">eleanor@montgomery.com</p>
                                        </div>
                                        <div>
                                            <p class="text-gray-500 text-sm">Phone</p>
                                            <p class="font-medium">+1 (555) 123-4567</p>
                                        </div>
                                    </div>
                                </div>

                                <div>
                                    <h3 class="text-lg font-medium mb-4">Shipping Address</h3>
                                    <div class="space-y-4">
                                        <div>
                                            <p class="text-gray-500 text-sm">Primary Address</p>
                                            <p class="font-medium">450 Park Avenue, Apt 12B</p>
                                            <p class="font-medium">New York, NY 10022</p>
                                        </div>
                                        <div>
                                            <p class="text-gray-500 text-sm">Shipping Preferences</p>
                                            <p class="font-medium">Signature Required</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- Orders Section -->
                    <section>
                        <h2 class="text-2xl font-medium mb-6">Your Orders</h2>

                        <!-- Order Tabs -->
                        <div class="mb-8">
                            <div class="flex space-x-8 border-b border-gray-200">
                                <button class="tab-active pb-3 px-1 text-sm">Pending Confirmation</button>
                                <button class="pb-3 px-1 text-sm text-gray-500">Confirmed Orders</button>
                                <button class="pb-3 px-1 text-sm text-gray-500">Delivered Orders</button>
                            </div>
                        </div>

                        <!-- Order List -->
                        <div class="space-y-6">
                            <!-- Order 1 -->
                            <div class="order-card bg-white p-6 rounded-sm">
                                <div class="flex flex-col md:flex-row md:items-center">
                                    <div class="md:w-1/4 mb-4 md:mb-0">
                                        <img src="https://images.unsplash.com/photo-1591047139829-d91aecb6caea?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=400&q=80"
                                            alt="Cashmere Coat" class="w-full h-48 object-cover">
                                    </div>

                                    <div class="md:w-3/4 md:pl-8">
                                        <div class="flex flex-col md:flex-row md:items-center md:justify-between mb-4">
                                            <div>
                                                <h3 class="font-medium text-lg">DDTS Cashmere Overcoat</h3>
                                                <p class="text-gray-500 text-sm">Order #DDTS-2023-8765</p>
                                            </div>
                                            <div class="mt-2 md:mt-0">
                                                <span
                                                    class="bg-gray-100 text-gray-800 text-xs px-3 py-1 rounded-full">Pending
                                                    Confirmation</span>
                                            </div>
                                        </div>

                                        <div class="divider my-4"></div>

                                        <div class="flex flex-col md:flex-row md:items-center md:justify-between">
                                            <div class="mb-4 md:mb-0">
                                                <p class="text-gray-500 text-sm">Order Date</p>
                                                <p class="font-medium">October 12, 2023</p>
                                            </div>

                                            <div class="mb-4 md:mb-0">
                                                <p class="text-gray-500 text-sm">Total</p>
                                                <p class="font-medium">$2,450.00</p>
                                            </div>

                                            <div>
                                                <button
                                                    class="btn-black bg-black text-white px-6 py-2 rounded-full text-sm">
                                                    View Details
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Order 2 -->
                            <div class="order-card bg-white p-6 rounded-sm">
                                <div class="flex flex-col md:flex-row md:items-center">
                                    <div class="md:w-1/4 mb-4 md:mb-0">
                                        <img src="https://images.unsplash.com/photo-1551232864-3f0890e580d9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=400&q=80"
                                            alt="Silk Dress" class="w-full h-48 object-cover">
                                    </div>

                                    <div class="md:w-3/4 md:pl-8">
                                        <div class="flex flex-col md:flex-row md:items-center md:justify-between mb-4">
                                            <div>
                                                <h3 class="font-medium text-lg">DDTS Silk Evening Dress</h3>
                                                <p class="text-gray-500 text-sm">Order #DDTS-2023-7654</p>
                                            </div>
                                            <div class="mt-2 md:mt-0">
                                                <span
                                                    class="bg-gray-100 text-gray-800 text-xs px-3 py-1 rounded-full">Pending
                                                    Confirmation</span>
                                            </div>
                                        </div>

                                        <div class="divider my-4"></div>

                                        <div class="flex flex-col md:flex-row md:items-center md:justify-between">
                                            <div class="mb-4 md:mb-0">
                                                <p class="text-gray-500 text-sm">Order Date</p>
                                                <p class="font-medium">October 8, 2023</p>
                                            </div>

                                            <div class="mb-4 md:mb-0">
                                                <p class="text-gray-500 text-sm">Total</p>
                                                <p class="font-medium">$1,850.00</p>
                                            </div>

                                            <div>
                                                <button
                                                    class="btn-black bg-black text-white px-6 py-2 rounded-full text-sm">
                                                    View Details
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- footer -->
                    <jsp:include page="../layout/footer.jsp" />

                </div>

                <script>
                    // Tab switching functionality
                    const tabs = document.querySelectorAll('[class*="pb-3 px-1"]');

                    tabs.forEach(tab => {
                        tab.addEventListener('click', () => {
                            // Remove active class from all tabs
                            tabs.forEach(t => {
                                t.classList.remove('tab-active');
                                t.classList.add('text-gray-500');
                            });

                            // Add active class to clicked tab
                            tab.classList.add('tab-active');
                            tab.classList.remove('text-gray-500');

                            // Here you would typically load different order data based on the selected tab
                            // For this example, we're just changing the UI state
                        });
                    });
                </script>
            </body>

            </html>