<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>DDTS | Luxury fashion</title>
                    <script src="https://cdn.tailwindcss.com"></script>
                    <c:set var="ctx" value="${pageContext.request.contextPath}" />

                    <!-- Google Fonts -->
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap"
                        rel="stylesheet">

                    <!-- SwiperJS CSS -->
                    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />

                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                    <link rel="stylesheet" href="${ctx}/resources/assets/client/css/home.css">
                    <style>
                        body {
                            font-family: 'Inter', sans-serif;
                            font-weight: 500;
                        }

                        /* Optional: Add specific weights if needed */
                        .font-light {
                            font-weight: 300;
                        }

                        .font-normal {
                            font-weight: 400;
                        }

                        .font-medium {
                            font-weight: 500;
                        }

                        .font-semibold {
                            font-weight: 600;
                        }

                        .font-bold {
                            font-weight: 700;
                        }

                        /* Swiper custom pagination */
                        .swiper-pagination-bullet {
                            width: 10px;
                            height: 10px;
                            background-color: rgba(255, 255, 255, 0.5);
                            opacity: 1;
                            transition: background-color 0.3s ease, width 0.3s ease;
                        }

                        .swiper-pagination-bullet-active {
                            background-color: white;
                            width: 25px;
                            /* Make active bullet wider */
                            border-radius: 5px;
                        }

                        /* Loading indicator */
                        .loading {
                            position: relative;
                        }

                        .loading::after {
                            content: "";
                            position: absolute;
                            top: 0;
                            left: 0;
                            right: 0;
                            bottom: 0;
                            background: rgba(255, 255, 255, 0.7);
                            z-index: 100;
                            display: flex;
                            justify-content: center;
                            align-items: center;
                        }

                        .loading::before {
                            content: "";
                            position: absolute;
                            top: 50%;
                            left: 50%;
                            width: 40px;
                            height: 40px;
                            margin-top: -20px;
                            margin-left: -20px;
                            border-radius: 50%;
                            border: 3px solid #f3f3f3;
                            border-top: 3px solid #000;
                            animation: spin 1s linear infinite;
                            z-index: 101;
                        }

                        @keyframes spin {
                            0% {
                                transform: rotate(0deg);
                            }

                            100% {
                                transform: rotate(360deg);
                            }
                        }
                    </style>
                </head>

                <body class="bg-white text-black font-sans">


                    <!-- navbar -->
                    <jsp:include page="layout/navbar.jsp" />

                    <!-- Hero Slider -->
                    <section class="relative h-screen mt-5  hero-slider-container">
                        <!-- Slider main container -->
                        <div class="swiper heroSwiper h-full">
                            <!-- Additional required wrapper -->
                            <div class="swiper-wrapper">
                                <!-- Slides -->
                                <div class="swiper-slide">
                                    <img src="https://file.hstatic.net/1000402464/file/hero_1-100.jpg"
                                        alt="Luxury Fashion Model 1"
                                        class="absolute inset-0 w-full h-full object-cover">
                                    <div class="absolute inset-0 hero-overlay z-10"></div> <!-- Optional overlay -->
                                </div>
                                <div class="swiper-slide">
                                    <img src="https://images.unsplash.com/photo-1483985988355-763728e1935b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80"
                                        alt="Luxury Fashion Model 2"
                                        class="absolute inset-0 w-full h-full object-cover">
                                    <div class="absolute inset-0 hero-overlay z-10"></div> <!-- Optional overlay -->
                                </div>
                                <div class="swiper-slide">
                                    <img src="https://images.unsplash.com/photo-1556905055-8f358a7a47b2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80"
                                        alt="Luxury Fashion Model 3"
                                        class="absolute inset-0 w-full h-full object-cover">
                                    <div class="absolute inset-0 hero-overlay z-10"></div> <!-- Optional overlay -->
                                </div>
                                <div class="swiper-slide">
                                    <img src="https://images.unsplash.com/photo-1523381210434-271e8be1f52b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80"
                                        alt="Luxury Fashion Model 4"
                                        class="absolute inset-0 w-full h-full object-cover">
                                    <div class="absolute inset-0 hero-overlay z-10"></div> <!-- Optional overlay -->
                                </div>
                            </div>
                            <!-- If we need pagination -->
                            <div class="swiper-pagination absolute bottom-8 inset-x-0 z-20 text-center"></div>
                        </div>
                    </section>

                    <jsp:include page="layout/section1.jsp" />

                    <!-- Featured Collections -->
                    <section class="py-20 px-6 max-w-7xl mx-auto">
                        <div class="text-center mb-16">
                            <h2 class="text-3xl font-light mb-4">
                                <spring:message code="home.collections" />
                            </h2>
                            <div class="w-20 h-px bg-black mx-auto"></div>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                            <div class="relative h-96 collection-hover">
                                <img src="${ctx}/resources/assets/client/images/image1.avif" alt="Women's Collection"
                                    class="w-full h-full object-cover">
                                <div
                                    class="absolute inset-0 collection-overlay opacity-0 flex items-center justify-center">
                                    <div class="text-center text-white p-6">
                                        <h3 class="text-2xl mb-2">
                                            <spring:message code="home.women" />
                                        </h3>
                                        <a href="/product/item-female"
                                            class="border border-white px-6 py-2 inline-block uppercase text-xs tracking-wider hover:bg-white hover:text-black transition duration-300">
                                            <spring:message code="home.viewDetails" />
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <div class="relative h-96 collection-hover">
                                <img src="${ctx}/resources/assets/client/images/image2.avif" alt="Men's Collection"
                                    class="w-full h-full object-cover">
                                <div
                                    class="absolute inset-0 collection-overlay opacity-0 flex items-center justify-center">
                                    <div class="text-center text-white p-6">
                                        <h3 class="text-2xl mb-2">
                                            <spring:message code="home.men" />
                                        </h3>
                                        <a href="/product/item-male"
                                            class="border border-white px-6 py-2 inline-block uppercase text-xs tracking-wider hover:bg-white hover:text-black transition duration-300">
                                            <spring:message code="home.viewDetails" />
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <div class="relative h-96 collection-hover">
                                <img src="${ctx}/resources/assets/client/images/image3.avif"
                                    alt="Accessories Collection" class="w-full h-full object-cover">
                                <div
                                    class="absolute inset-0 collection-overlay opacity-0 flex items-center justify-center">
                                    <div class="text-center text-white p-6">
                                        <h3 class="text-2xl mb-2">
                                            <spring:message code="home.accessories" />
                                        </h3>
                                        <a href="/product/item-male"
                                            class="border border-white px-6 py-2 inline-block uppercase text-xs tracking-wider hover:bg-white hover:text-black transition duration-300">
                                            <spring:message code="home.viewDetails" />
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- Featured Products -->
                    <section class="py-20 bg-gray-50">
                        <div class="max-w-7xl mx-auto px-6">
                            <div class="text-center mb-16">
                                <h2 class="text-3xl font-light mb-4">
                                    <spring:message code="home.featuredProducts" />
                                </h2>
                                <div class="w-20 h-px bg-black mx-auto"></div>
                                <p class="mt-4 text-sm text-gray-600">
                                    <spring:message code="home.totalProducts" text="Total products" />:
                                    ${featuredTotalRecords}
                                </p>
                            </div>

                            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
                                <c:choose>
                                    <c:when test="${empty featuredProducts}">
                                        <div class="col-span-4 text-center py-10">
                                            <p>
                                                <spring:message code="home.noProducts" text="No products available" />
                                            </p>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${featuredProducts}" var="product" begin="0" end="7">
                                            <div
                                                class="group border-2 border-transparent hover:border-black transition-colors duration-300 p-2">
                                                <div class="relative overflow-hidden h-96">
                                                    <img src="${product.image_url != null ? product.image_url : 'https://assets.adidas.com/images/w_766,h_766,f_auto,q_auto,fl_lossy,c_fill,g_auto/e3956afad4ca48a3a33f6ee339a93a31_9366/manchester-united-ubp-tee.jpg'}"
                                                        alt="${product.product_name}"
                                                        class="product-primary-image w-full h-full object-cover transition-opacity duration-300 ease-in-out group-hover:opacity-0">
                                                    <img src="${product.image_url != null ? product.image_url : 'https://assets.adidas.com/images/w_766,h_766,f_auto,q_auto,fl_lossy,c_fill,g_auto/170eb3f87f1e44c5ac8599ddb9b19969_9366/manchester-united-ubp-tee.jpg'}"
                                                        alt="${product.product_name} Hover"
                                                        class="product-hover-image absolute inset-0 w-full h-full object-cover opacity-0 group-hover:opacity-100 transition-opacity duration-300 ease-in-out">

                                                    <!-- Quick View Button -->
                                                    <div
                                                        class="absolute inset-0 flex items-center justify-center opacity-0 group-hover:opacity-100 transition duration-300">
                                                        <c:url var="detailUrl" value="/product/detail">
                                                            <c:param name="id" value="${product.product_id}" />
                                                        </c:url>
                                                        <a href="${detailUrl}"
                                                            class="bg-white px-6 py-2 text-sm tracking-wider border border-black hover:bg-black hover:text-white transition duration-300">
                                                            <spring:message code="category.quickView" />
                                                        </a>
                                                    </div>
                                                </div>
                                                <div class="mt-4 text-center">
                                                    <h3 class="text-lg font-light">${product.product_name}</h3>
                                                    <p class="text-sm text-gray-600">$${product.price}</p>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="text-center mt-12">
                                <a href="/product/category"
                                    class="border border-black px-8 py-3 inline-block uppercase text-sm tracking-wider hover:bg-black hover:text-white transition duration-300">
                                    <spring:message code="home.viewAllProducts" />
                                </a>
                            </div>
                        </div>
                    </section>

                    <!-- Tạp chí -->
                    <section class="py-20 max-w-7xl mx-auto px-6">
                        <!-- Display search results when isSearchResult flag is true -->
                        <c:if test="${isSearchResult == true}">
                            <div class="text-center mb-16">
                                <h2 class="text-3xl font-light mb-4">
                                    <spring:message code="home.searchResults" text="Search Results" />
                                    <c:if test="${not empty searchKeyword}">
                                        for: "${searchKeyword}"
                                    </c:if>
                                </h2>
                                <div class="w-20 h-px bg-black mx-auto"></div>
                                <p class="mt-4">
                                    <spring:message code="home.found" text="Found" /> ${searchTotalRecords}
                                    <spring:message code="home.results" text="results" />
                                </p>
                            </div>

                            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
                                <c:choose>
                                    <c:when test="${empty searchProducts}">
                                        <div class="col-span-4 text-center py-10">
                                            <p>
                                                <spring:message code="home.noResults" text="No results found" />
                                            </p>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${searchProducts}" var="product">
                                            <div
                                                class="group border-2 border-transparent hover:border-black transition-colors duration-300 p-2">
                                                <div class="relative overflow-hidden h-96">
                                                    <img src="${product.image_url != null ? product.image_url : 'https://assets.adidas.com/images/w_766,h_766,f_auto,q_auto,fl_lossy,c_fill,g_auto/e3956afad4ca48a3a33f6ee339a93a31_9366/manchester-united-ubp-tee.jpg'}"
                                                        alt="${product.product_name}"
                                                        class="product-primary-image w-full h-full object-cover transition-opacity duration-300 ease-in-out group-hover:opacity-0">
                                                    <img src="${product.image_url != null ? product.image_url : 'https://assets.adidas.com/images/w_766,h_766,f_auto,q_auto,fl_lossy,c_fill,g_auto/170eb3f87f1e44c5ac8599ddb9b19969_9366/manchester-united-ubp-tee.jpg'}"
                                                        alt="${product.product_name} Hover"
                                                        class="product-hover-image absolute inset-0 w-full h-full object-cover opacity-0 group-hover:opacity-100 transition-opacity duration-300 ease-in-out">

                                                    <!-- Quick View Button -->
                                                    <div
                                                        class="absolute inset-0 flex items-center justify-center opacity-0 group-hover:opacity-100 transition duration-300">
                                                        <c:url var="detailUrl" value="/product/detail">
                                                            <c:param name="id" value="${product.product_id}" />
                                                        </c:url>
                                                        <a href="${detailUrl}"
                                                            class="bg-white px-6 py-2 text-sm tracking-wider border border-black hover:bg-black hover:text-white transition duration-300">
                                                            <spring:message code="category.quickView" />
                                                        </a>
                                                    </div>
                                                </div>
                                                <div class="mt-4 text-center">
                                                    <h3 class="text-lg font-light">${product.product_name}</h3>
                                                    <p class="text-sm text-gray-600">$${product.price}</p>
                                                    <p class="text-xs text-gray-500">
                                                        <spring:message code="home.rank" text="Rank" />:
                                                        ${product.search_rank}
                                                    </p>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- Pagination for search results -->
                            <c:if test="${searchTotalRecords > searchPageSize}">
                                <div class="flex justify-center mt-10">
                                    <div class="flex items-center space-x-1">
                                        <c:forEach begin="1"
                                            end="${(searchTotalRecords + searchPageSize - 1) / searchPageSize}" var="i">
                                            <a href="${pageContext.request.contextPath}/products/search?keyword=${searchKeyword}&page=${i}&size=${searchPageSize}"
                                                class="${i == searchCurrentPage ? 'bg-black text-white' : 'bg-white text-black'} px-4 py-2 border hover:bg-gray-200 transition">
                                                ${i}
                                            </a>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:if>
                        </c:if>

                        <!-- Original magazine section only shows if not viewing search results -->
                        <c:if test="${isSearchResult != true}">
                            <div class="text-center mb-16">
                                <h2 class="text-3xl font-light mb-4">
                                    <spring:message code="home.magazine" />
                                </h2>
                                <div class="w-20 h-px bg-black mx-auto"></div>
                            </div>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-12">
                                <div class="flex flex-col md:flex-row gap-6">
                                    <div class="md:w-1/2">
                                        <img src="https://images.unsplash.com/photo-1479064555552-3ef4979f8908?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80"
                                            alt="Biên tập thời trang" class="w-full h-64 object-cover">
                                    </div>
                                    <div class="md:w-1/2">
                                        <span class="text-xs tracking-wider">
                                            <spring:message code="home.editorial" />
                                        </span>
                                        <h3 class="text-xl font-light mt-2 mb-3">
                                            <spring:message code="home.minimalistFashion" />
                                        </h3>
                                        <p class="text-sm text-gray-600 mb-4">
                                            <spring:message code="home.minimalistFashionDesc" />
                                        </p>
                                        <a href="#"
                                            class="text-sm uppercase tracking-wider border-b border-black pb-1 hover:text-gray-600 hover:border-gray-600 transition duration-300">
                                            <spring:message code="home.readMore" />
                                        </a>
                                    </div>
                                </div>

                                <div class="flex flex-col md:flex-row gap-6">
                                    <div class="md:w-1/2">
                                        <img src="https://images.unsplash.com/photo-1561526116-e2460f4d40a8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80"
                                            alt="Thời trang bền vững" class="w-full h-64 object-cover">
                                    </div>
                                    <div class="md:w-1/2">
                                        <span class="text-xs tracking-wider">
                                            <spring:message code="home.sustainability" />
                                        </span>
                                        <h3 class="text-xl font-light mt-2 mb-3">
                                            <spring:message code="home.ethicalFashion" />
                                        </h3>
                                        <p class="text-sm text-gray-600 mb-4">
                                            <spring:message code="home.ethicalFashionDesc" />
                                        </p>
                                        <a href="#"
                                            class="text-sm uppercase tracking-wider border-b border-black pb-1 hover:text-gray-600 hover:border-gray-600 transition duration-300">
                                            <spring:message code="home.readMore" />
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </section>


                    <jsp:include page="layout/notidiscount.jsp" />



                    <jsp:include page="layout/toast.jsp" />


                    <!-- Footer -->
                    <jsp:include page="layout/footer.jsp" />


                    <div class="fixed z-[9999] bottom-0 right-0 m-4">
                        <!-- Chat toggle button -->
                        <button id="chatToggleBtn"
                            class="w-14 h-14 rounded-full bg-black text-white shadow-lg flex items-center justify-center hover:bg-gray-800 transition-all duration-300 focus:outline-none">
                            <i class="fas fa-comments text-xl"></i>
                        </button>

                        <!-- Chat container (hidden by default) -->
                        <div id="chatContainer"
                            class="hidden mt-4 transition-all duration-300 transform origin-bottom-right">
                            <jsp:include page="layout/chatbox.jsp" />
                        </div>
                    </div>





                    <!-- SwiperJS JS -->
                    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
                    <!-- Custom Slider JS -->
                    <script src="${ctx}/resources/assets/client/js/hero-slider.js"></script>

                    <!-- Login Success Toast Script -->
                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            // Check for login or logout success parameter
                            const urlParams = new URLSearchParams(window.location.search);

                            // Handle login success
                            if (urlParams.get('login') === 'success') {
                                showToast('toast-success', 'Login successful!');
                            }

                            // Handle logout success
                            if (urlParams.get('logout') === 'success') {
                                showToast('toast-success', 'Logout successful!');
                            }

                            // Function to show a toast with the given message
                            function showToast(toastId, message) {
                                const toast = document.getElementById(toastId);
                                if (toast) {
                                    // Update toast message
                                    const toastMessage = toast.querySelector('.text-sm.font-normal');
                                    if (toastMessage) {
                                        toastMessage.textContent = message;
                                    }

                                    // Show the toast
                                    toast.classList.remove('hidden');

                                    // Set timeout to hide toast after 3 seconds
                                    setTimeout(function () {
                                        toast.classList.add('hidden');
                                    }, 3000);

                                    // Clean URL by removing the parameter
                                    const url = new URL(window.location);
                                    url.searchParams.delete('login');
                                    url.searchParams.delete('logout');
                                    window.history.replaceState({}, '', url);
                                }
                            }
                        });
                    </script>
                    <script src="https://kit.fontawesome.com/73713bf219.js" crossorigin="anonymous"></script>

                    <!-- Chat toggle script -->
                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            const chatToggleBtn = document.getElementById('chatToggleBtn');
                            const chatContainer = document.getElementById('chatContainer');

                            chatToggleBtn.addEventListener('click', function () {
                                chatContainer.classList.toggle('hidden');

                                // Change button icon based on chat visibility
                                const icon = this.querySelector('i');
                                if (chatContainer.classList.contains('hidden')) {
                                    icon.classList.remove('fa-times');
                                    icon.classList.add('fa-comments');
                                } else {
                                    icon.classList.remove('fa-comments');
                                    icon.classList.add('fa-times');
                                }
                            });
                        });
                    </script>
                </body>

                </html>