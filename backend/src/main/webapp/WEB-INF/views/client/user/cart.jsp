<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>MONOCHROME | Your Shopping Bag</title>
                    <c:set var="ctx" value="${pageContext.request.contextPath}" />
                    <script src="https://cdn.tailwindcss.com"></script>
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                    <link
                        href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Inter:wght@300;400;500&display=swap"
                        rel="stylesheet">

                    <link rel="stylesheet" href="${ctx}/css/cart.css">

                    <!-- Google Fonts -->
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap"
                        rel="stylesheet">

                    <!-- CSRF Token -->
                    <meta name="_csrf" content="${_csrf.token}" />
                    <meta name="_csrf_header" content="${_csrf.headerName}" />

                    <style>
                        .heading-font {
                            font-family: 'Playfair Display', serif;
                        }

                        .body-font {
                            font-family: 'Inter', sans-serif;
                        }

                        .color-dot {
                            width: 16px;
                            height: 16px;
                            border-radius: 50%;
                            display: inline-block;
                        }

                        .quantity-selector {
                            border-radius: 4px;
                            overflow: hidden;
                        }

                        .summary-card {
                            border-radius: 4px;
                        }

                        .btn-checkout {
                            border-radius: 4px;
                            transition: all 0.2s ease;
                        }

                        .btn-checkout:hover {
                            transform: translateY(-1px);
                        }

                        /* Make all text bolder */
                        body {
                            font-weight: 500;
                        }

                        h1,
                        h2,
                        h3,
                        .heading-font {
                            font-weight: 600;
                        }

                        .font-medium,
                        span,
                        label,
                        p,
                        button,
                        input,
                        select {
                            font-weight: 500;
                        }

                        .btn-checkout {
                            font-weight: 600;
                        }
                    </style>

                </head>

                <body class="bg-white body-font text-gray-800 min-h-screen flex flex-col">
                    <!-- navbar -->
                    <jsp:include page="../layout/navbar.jsp" />

                    <!-- Hero Section -->
                    <div class="border-b border-gray-100 py-12 pt-[80px] bg-gray-50">
                        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                            <h1
                                class="heading-font text-3xl md:text-4xl lg:text-5xl text-center font-light tracking-tight text-gray-900">
                                <spring:message code="cart.title" />
                            </h1>
                            <p class="text-center text-gray-500 mt-3 text-sm" id="cart-item-count">
                                ${cartDetails.size()}
                                <spring:message code="cart.items" />
                            </p>

                            <!-- Alert messages -->
                            <c:if test="${not empty successMessage}">
                                <div
                                    class="mt-4 bg-green-100 border border-green-200 text-green-700 px-4 py-3 rounded relative">
                                    ${successMessage}
                                </div>
                            </c:if>
                            <c:if test="${not empty errorMessage}">
                                <div
                                    class="mt-4 bg-red-100 border border-red-200 text-red-700 px-4 py-3 rounded relative">
                                    ${errorMessage}
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <!-- Main Cart Content -->
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 flex-grow">
                        <div class="flex flex-col lg:flex-row gap-8 lg:gap-12">
                            <!-- Left Column - Cart Items -->
                            <div class="lg:w-2/3 space-y-6">
                                <!-- Cart Header -->
                                <div class="hidden md:grid grid-cols-12 gap-4 pb-4 border-b border-gray-200">
                                    <div class="col-span-1 text-xs uppercase tracking-wider text-gray-500 font-medium">
                                        <input type="checkbox"
                                            class="rounded border-gray-300 text-black focus:ring-black"
                                            name="selectAll">
                                    </div>
                                    <div class="col-span-4 text-xs uppercase tracking-wider text-gray-500 font-medium">
                                        <spring:message code="cart.product" />
                                    </div>
                                    <div class="col-span-2 text-xs uppercase tracking-wider text-gray-500 font-medium">
                                        <spring:message code="cart.color" />
                                    </div>
                                    <div class="col-span-1 text-xs uppercase tracking-wider text-gray-500 font-medium">
                                        <spring:message code="cart.size" />
                                    </div>
                                    <div class="col-span-2 text-xs uppercase tracking-wider text-gray-500 font-medium">
                                        <spring:message code="cart.quantity" />
                                    </div>
                                    <div
                                        class="col-span-1 text-xs uppercase tracking-wider text-gray-500 text-right font-medium">
                                        <spring:message code="cart.price" />
                                    </div>
                                </div>

                                <!-- Cart Items -->
                                <div class="space-y-6">
                                    <c:forEach items="${cartDetails}" var="item" varStatus="status">
                                        <div class="cart-item grid grid-cols-12 gap-4 items-center py-6 border-b border-gray-200 hover:bg-gray-50 transition-colors duration-200"
                                            data-price="${item.productVariant.product.price}"
                                            data-cart-detail-id="${item.cartDetailId}"
                                            data-product-id="${item.productVariant.product.productId}"
                                            data-product-id-safe="${item.productVariant.product.productId == null ? '1' : item.productVariant.product.productId}"
                                            data-product-name="${item.productVariant.product.productName}"
                                            data-product-variant-id="${item.productVariant.productVariantId}"
                                            data-color-name="${item.productVariant.color.colorName}"
                                            data-size-name="${item.productVariant.size.sizeName}"
                                            data-quantity="${item.quantity}">
                                            <div class="col-span-1 md:block">
                                                <input type="checkbox"
                                                    class="item-checkbox rounded border-gray-300 text-black focus:ring-black"
                                                    name="product">
                                            </div>
                                            <div class="col-span-11 md:col-span-4 flex items-center">
                                                <div
                                                    class="w-20 h-20 md:w-24 md:h-24 bg-gray-50 mr-4 flex-shrink-0 border border-gray-100">
                                                    <img src="${ctx}/${item.productVariant.imageUrl}"
                                                        alt="${item.productVariant.product.productName}"
                                                        class="w-full h-full object-cover">
                                                </div>
                                                <div>
                                                    <h3 class="heading-font font-medium text-gray-900">
                                                        ${item.productVariant.product.productName}
                                                    </h3>
                                                    <p class="text-gray-500 text-sm mt-1">
                                                        ${item.productVariant.product.brand.brandName}</p>

                                                    <!-- Item Discount Section -->
                                                    <div class="mt-2">
                                                        <div class="relative inline-block item-discount-trigger">
                                                            <div
                                                                class="flex items-center text-xs cursor-pointer text-blue-600 hover:text-blue-800">
                                                                <span>Mã Giảm Giá</span>
                                                                <svg xmlns="http://www.w3.org/2000/svg"
                                                                    class="h-4 w-4 ml-1" fill="none" viewBox="0 0 24 24"
                                                                    stroke="currentColor">
                                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                                        stroke-width="2" d="M19 9l-7 7-7-7" />
                                                                </svg>
                                                            </div>

                                                            <div
                                                                class="item-discount-tooltip hidden absolute z-10 bg-white rounded-md shadow-lg border border-gray-200 w-72 left-0 mt-2">
                                                                <div class="py-2 px-3 text-sm text-gray-700">
                                                                    <p class="font-medium">Mã giảm giá cho sản phẩm</p>
                                                                    <p class="text-xs mt-1 text-gray-500">Áp dụng mã
                                                                        giảm giá để tiết kiệm khi mua sản phẩm này</p>
                                                                </div>
                                                                <div class="py-2 px-3 max-h-[200px] overflow-y-auto">
                                                                    <!-- Discount Code 1 -->
                                                                    <div class="flex items-center p-2 border-b">
                                                                        <div class="flex-shrink-0 mr-3">
                                                                            <img src="${ctx}/resources/assets/client/images/logo-audio365.png"
                                                                                alt="Shop Logo"
                                                                                class="w-8 h-8 object-contain">
                                                                        </div>
                                                                        <div class="flex-grow">
                                                                            <p class="font-medium text-xs">Giảm ₫8k</p>
                                                                            <p class="text-xs text-gray-500">Đơn Tối
                                                                                Thiểu ₫170k</p>
                                                                            <p class="text-xs text-gray-500 mt-1">Còn 9
                                                                                giờ</p>
                                                                        </div>
                                                                        <div class="ml-2">
                                                                            <button
                                                                                class="apply-item-discount-btn bg-orange-500 hover:bg-orange-600 text-white px-2 py-1 rounded text-xs"
                                                                                data-discount="8000"
                                                                                data-code="Giảm ₫8k"
                                                                                data-cart-detail-id="${item.cartDetailId}">
                                                                                Áp dụng
                                                                            </button>
                                                                        </div>
                                                                    </div>

                                                                    <!-- Discount Code 2 -->
                                                                    <div class="flex items-center p-2 border-b">
                                                                        <div class="flex-shrink-0 mr-3">
                                                                            <img src="${ctx}/resources/assets/client/images/logo-audio365.png"
                                                                                alt="Shop Logo"
                                                                                class="w-8 h-8 object-contain">
                                                                        </div>
                                                                        <div class="flex-grow">
                                                                            <p class="font-medium text-xs">Giảm ₫10k</p>
                                                                            <p class="text-xs text-gray-500">Đơn Tối
                                                                                Thiểu ₫220k</p>
                                                                            <p class="text-xs text-gray-500 mt-1">Còn 9
                                                                                giờ</p>
                                                                        </div>
                                                                        <div class="ml-2">
                                                                            <button
                                                                                class="apply-item-discount-btn bg-orange-500 hover:bg-orange-600 text-white px-2 py-1 rounded text-xs"
                                                                                data-discount="10000"
                                                                                data-code="Giảm ₫10k"
                                                                                data-cart-detail-id="${item.cartDetailId}">
                                                                                Áp dụng
                                                                            </button>
                                                                        </div>
                                                                    </div>

                                                                    <!-- Discount Code 3 -->
                                                                    <div class="flex items-center p-2 border-b">
                                                                        <div class="flex-shrink-0 mr-3">
                                                                            <img src="${ctx}/resources/assets/client/images/logo-audio365.png"
                                                                                alt="Shop Logo"
                                                                                class="w-8 h-8 object-contain">
                                                                        </div>
                                                                        <div class="flex-grow">
                                                                            <p class="font-medium text-xs">Giảm ₫30k</p>
                                                                            <p class="text-xs text-gray-500">Đơn Tối
                                                                                Thiểu ₫500k</p>
                                                                            <p class="text-xs text-gray-500 mt-1">Còn 9
                                                                                giờ</p>
                                                                        </div>
                                                                        <div class="ml-2">
                                                                            <button
                                                                                class="apply-item-discount-btn bg-orange-500 hover:bg-orange-600 text-white px-2 py-1 rounded text-xs"
                                                                                data-discount="30000"
                                                                                data-code="Giảm ₫30k"
                                                                                data-cart-detail-id="${item.cartDetailId}">
                                                                                Áp dụng
                                                                            </button>
                                                                        </div>
                                                                    </div>

                                                                    <!-- Discount Code 4 -->
                                                                    <div class="flex items-center p-2">
                                                                        <div class="flex-shrink-0 mr-3">
                                                                            <img src="${ctx}/resources/assets/client/images/logo-audio365.png"
                                                                                alt="Shop Logo"
                                                                                class="w-8 h-8 object-contain">
                                                                        </div>
                                                                        <div class="flex-grow">
                                                                            <p class="font-medium text-xs">Giảm 10%</p>
                                                                            <p class="text-xs text-gray-500">Tối đa ₫50k
                                                                            </p>
                                                                            <p class="text-xs text-gray-500 mt-1">Còn 9
                                                                                giờ</p>
                                                                        </div>
                                                                        <div class="ml-2">
                                                                            <button
                                                                                class="apply-item-discount-btn bg-orange-500 hover:bg-orange-600 text-white px-2 py-1 rounded text-xs"
                                                                                data-discount="10%" data-code="Giảm 10%"
                                                                                data-cart-detail-id="${item.cartDetailId}">
                                                                                Áp dụng
                                                                            </button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <!-- Applied Discount Display -->
                                                            <div
                                                                class="mt-1 applied-discount-container-${item.cartDetailId} hidden">
                                                                <div
                                                                    class="flex items-center bg-blue-50 text-xs rounded-full py-1 px-3 w-fit">
                                                                    <span
                                                                        class="text-blue-600 font-medium applied-discount-text-${item.cartDetailId}"></span>
                                                                    <button
                                                                        class="ml-2 text-gray-500 hover:text-red-500 remove-discount-btn"
                                                                        data-cart-detail-id="${item.cartDetailId}">
                                                                        <svg xmlns="http://www.w3.org/2000/svg"
                                                                            class="h-3 w-3" fill="none"
                                                                            viewBox="0 0 24 24" stroke="currentColor">
                                                                            <path stroke-linecap="round"
                                                                                stroke-linejoin="round" stroke-width="2"
                                                                                d="M6 18L18 6M6 6l12 12" />
                                                                        </svg>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-span-6 md:col-span-2 flex items-center">
                                                <div class="color-dot bg-gray-200 border border-gray-200 mr-2">
                                                </div>
                                                <span class="text-sm">${item.productVariant.color.colorName}</span>
                                            </div>
                                            <div class="col-span-6 md:col-span-1">
                                                <span
                                                    class="text-sm font-medium">${item.productVariant.size.sizeName}</span>
                                            </div>
                                            <div class="col-span-6 md:col-span-2">
                                                <div
                                                    class="quantity-selector flex items-center border border-gray-200 w-24 shadow-sm">
                                                    <button
                                                        class="px-2 py-1 text-gray-500 hover:bg-gray-100 transition-colors"
                                                        onclick="updateQuantity(this, -1)">-</button>
                                                    <span class="flex-1 text-center quantity-value py-1"
                                                        data-cart-detail-id="${item.cartDetailId}"
                                                        data-cart-detail-price="${item.price}"
                                                        data-cart-detail-index="${status.index}"
                                                        data-cart-detail-stock="${item.productVariant.quantityStock}">
                                                        ${item.quantity}
                                                    </span>
                                                    <button
                                                        class="px-2 py-1 text-gray-500 hover:bg-gray-100 transition-colors"
                                                        onclick="updateQuantity(this, 1)">+</button>
                                                </div>
                                            </div>
                                            <div class="col-span-6 md:col-span-1 text-right">
                                                <span
                                                    class="font-medium">$${item.quantity*item.productVariant.product.price}</span>
                                                <a href="${ctx}/cart/remove/${item.cartDetailId}"
                                                    class="remove-btn block mt-2 text-gray-400 hover:text-red-500 text-sm transition-colors"
                                                    onclick="return confirm(msgRemoveConfirm)">
                                                    <i class="far fa-trash-alt mr-1"></i>
                                                </a>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>

                                <!-- Continue Shopping -->
                                <div class="mt-8">
                                    <a href="#"
                                        class="text-sm flex items-center text-gray-600 hover:text-black transition-colors">
                                        <i class="fas fa-arrow-left mr-2"></i> Continue Shopping
                                    </a>
                                </div>
                            </div>

                            <!-- Right Column - Order Summary -->
                            <div class="lg:w-1/3 mt-8 lg:mt-0">
                                <div class="summary-card border border-gray-200 bg-white p-6 shadow-sm sticky top-24">
                                    <h2 class="heading-font text-xl font-light mb-6 border-b border-gray-100 pb-4">
                                        <spring:message code="cart.orderSummary" />
                                    </h2>
                                    <div class="space-y-4">
                                        <div class="flex justify-between">
                                            <span class="text-sm text-gray-500">
                                                <spring:message code="cart.subtotal" />
                                            </span>
                                            <span class="text-sm font-medium" id="cart-subtotal"
                                                data-cart-total-price="${totalPrice}">
                                                $${totalPrice}
                                            </span>
                                        </div>
                                        <div class="flex justify-between">
                                            <span class="text-sm text-gray-500">
                                                <spring:message code="cart.shipping" />
                                            </span>
                                            <span class="text-sm text-green-600 font-medium">
                                                calculate...
                                            </span>
                                        </div>
                                        <div class="border-t border-gray-200 my-4 pt-4"></div>
                                        <div class="flex justify-between">
                                            <span class="font-medium">
                                                <spring:message code="cart.total" />
                                            </span>
                                            <span class="font-medium text-lg" id="cart-total"
                                                data-cart-total-price="${totalPrice}">
                                                $${totalPrice}
                                            </span>
                                        </div>
                                    </div>

                                    <!-- Promo Code -->
                                    <div class="mt-6">
                                        <label for="promo-code" class="block text-sm text-gray-500 mb-2">
                                            Promo Code
                                        </label>
                                        <div class="flex">
                                            <input type="text" id="promo-code"
                                                class="flex-1 border border-gray-200 px-4 py-2 text-sm focus:outline-none focus:border-black focus:ring-1 focus:ring-black rounded-l"
                                                placeholder="Enter code">
                                            <button
                                                class="bg-black text-white px-6 py-2 text-sm font-medium hover:bg-gray-800 transition-colors rounded-r">
                                                Apply
                                            </button>
                                        </div>
                                    </div>

                                    <!-- Checkout Button -->
                                    <button id="checkout-btn"
                                        class="btn-checkout w-full bg-black text-white py-3 px-4 mt-6 font-medium hover:bg-gray-800 transition-colors shadow-sm inline-block text-center">
                                        PROCEED TO CHECKOUT
                                    </button>

                                    <!-- Legacy API-based checkout button -->
                                    <a href="${ctx}/user/order"
                                        class="w-full bg-gray-500 text-white py-3 px-4 mt-3 font-medium hover:bg-gray-600 transition-colors shadow-sm inline-block text-center">
                                        PROCEED TO CHECKOUT (API)
                                    </a>
                                </div>

                                <!-- Customer Service -->
                                <div class="mt-6 p-6 bg-gray-50 border border-gray-200 rounded shadow-sm">
                                    <h3 class="heading-font font-medium text-sm mb-3">NEED HELP?</h3>
                                    <p class="text-sm text-gray-600 mb-3">
                                        Our customer service is available to assist you with any questions about your
                                        order.
                                    </p>
                                    <a href="#"
                                        class="text-sm underline flex items-center text-gray-600 hover:text-black transition-colors">
                                        <i class="fas fa-comment mr-2"></i> Contact Us
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Footer -->
                    <jsp:include page="../layout/footer.jsp" />

                    <script>
                        // Define product discounts variable from server-side model
                        var productDiscountsJson = '<c:out value="${productDiscounts}" escapeXml="false" />';

                        // New: get all product discounts from server-side model
                        var allProductDiscountsJson = '<c:out value="${allProductDiscounts}" escapeXml="false" />';
                        var allProductDiscounts = {};

                        // Dữ liệu mẫu cho nội dung demo - sẽ được sử dụng nếu không có dữ liệu từ server
                        var sampleDiscountsData = [
                            {
                                "end_date": "Nov 30, 2025",
                                "totalminmoney": 50000,
                                "discount_code": "SHOPZ62MCQJP",
                                "discount_name": "Chào thành viên mới",
                                "discount_percentage": 10,
                                "product_variant_id": 1,
                                "customer_id": 1017,
                                "discount_id": 3,
                                "start_date": "Jan 1, 2025",
                                "status": "available"
                            },
                            {
                                "end_date": "Apr 27, 2025",
                                "totalminmoney": 100000,
                                "discount_code": "SHOPK91T8AHE",
                                "discount_name": "Flash Sale cuối tuần 26/4",
                                "discount_percentage": 20,
                                "product_variant_id": 1,
                                "customer_id": 1017,
                                "discount_id": 5,
                                "start_date": "Apr 26, 2025",
                                "status": "available"
                            },
                            {
                                "end_date": "Feb 28, 2026",
                                "totalminmoney": 50000,
                                "discount_code": "SHOPNWB34T2C",
                                "discount_name": "Xả hàng cuối mùa Đông",
                                "discount_percentage": 20,
                                "product_variant_id": 2,
                                "customer_id": 1017,
                                "discount_id": 4,
                                "start_date": "Feb 15, 2026",
                                "status": "expired"
                            },
                            {
                                "end_date": "Apr 27, 2025",
                                "totalminmoney": 100000,
                                "discount_code": "SHOPK91T8AHE",
                                "discount_name": "Flash Sale cuối tuần 26/4",
                                "discount_percentage": 20,
                                "product_variant_id": 2,
                                "customer_id": 1017,
                                "discount_id": 5,
                                "start_date": "Apr 26, 2025",
                                "status": "expired"
                            },
                            {
                                "end_date": "Nov 30, 2025",
                                "totalminmoney": 50000,
                                "discount_code": "SHOPZ62MCQJP",
                                "discount_name": "Chào thành viên mới",
                                "discount_percentage": 10,
                                "product_variant_id": 3,
                                "customer_id": 1017,
                                "discount_id": 3,
                                "start_date": "Jan 1, 2025",
                                "status": "available"
                            },
                            {
                                "end_date": "Feb 28, 2026",
                                "totalminmoney": 50000,
                                "discount_code": "SHOPNWB34T2C",
                                "discount_name": "Xả hàng cuối mùa Đông",
                                "discount_percentage": 20,
                                "product_variant_id": 3,
                                "customer_id": 1017,
                                "discount_id": 4,
                                "start_date": "Feb 15, 2026",
                                "status": "available"
                            },
                            {
                                "end_date": "Apr 27, 2025",
                                "totalminmoney": 100000,
                                "discount_code": "SHOPK91T8AHE",
                                "discount_name": "Flash Sale cuối tuần 26/4",
                                "discount_percentage": 20,
                                "product_variant_id": 3,
                                "customer_id": 1017,
                                "discount_id": 5,
                                "start_date": "Apr 26, 2025",
                                "status": "available"
                            },
                            {
                                "end_date": "Nov 30, 2025",
                                "totalminmoney": 50000,
                                "discount_code": "SHOPZ62MCQJP",
                                "discount_name": "Chào thành viên mới",
                                "discount_percentage": 10,
                                "product_variant_id": 22,
                                "discount_id": 3,
                                "start_date": "Jan 1, 2025",
                                "status": "available"
                            }
                        ];

                        // Parse the JSON data if available
                        try {
                            if (allProductDiscountsJson && allProductDiscountsJson !== '{}') {
                                // Fix common JSON escaping issues
                                if (allProductDiscountsJson.startsWith('&quot;') || allProductDiscountsJson.startsWith('"')) {
                                    console.log("Detected escaped JSON for allProductDiscounts, attempting to fix...");
                                    // Remove leading/trailing quotes if present
                                    if (allProductDiscountsJson.startsWith('&quot;') && allProductDiscountsJson.endsWith('&quot;')) {
                                        allProductDiscountsJson = allProductDiscountsJson.substring(6, allProductDiscountsJson.length - 6);
                                    } else if (allProductDiscountsJson.startsWith('"') && allProductDiscountsJson.endsWith('"')) {
                                        allProductDiscountsJson = allProductDiscountsJson.substring(1, allProductDiscountsJson.length - 1);
                                    }

                                    // Replace &quot; with " inside the string
                                    allProductDiscountsJson = allProductDiscountsJson.replace(/&quot;/g, '"');

                                    // Unescape other common HTML entities
                                    allProductDiscountsJson = allProductDiscountsJson
                                        .replace(/&lt;/g, '<')
                                        .replace(/&gt;/g, '>')
                                        .replace(/&amp;/g, '&');
                                }

                                // Parse the JSON
                                allProductDiscounts = JSON.parse(allProductDiscountsJson);
                                console.log("Successfully parsed allProductDiscounts from server model");
                            } else {
                                console.log("No pre-loaded discount data found from server model, using sample data");
                                // Use sample data if no server data
                                allProductDiscounts = { "all": sampleDiscountsData };
                            }
                        } catch (e) {
                            console.error("Error parsing allProductDiscounts JSON:", e);
                            console.error("Raw JSON:", allProductDiscountsJson);
                            console.log("Using sample data instead due to parsing error");
                            // Use sample data on error
                            allProductDiscounts = { "all": sampleDiscountsData };
                        }

                        // Store the correct context path for API calls
                        const contextPathValue = '<c:out value="${pageContext.request.contextPath}" />';

                        // Helper function to build API URLs with proper context path and params
                        function buildApiUrl(endpoint, params = {}) {
                            // Start with the origin
                            let url = window.location.origin;

                            // Add context path if it exists and is valid
                            if (contextPathValue && contextPathValue !== '') {
                                url += contextPathValue;
                            }

                            // Add the endpoint (should start with /)
                            if (!endpoint.startsWith('/')) {
                                endpoint = '/' + endpoint;
                            }
                            url += endpoint;

                            // Add query parameters
                            const queryParams = new URLSearchParams();
                            for (const key in params) {
                                if (params[key] !== undefined && params[key] !== null && params[key] !== '') {
                                    queryParams.append(key, params[key]);
                                }
                            }

                            const queryString = queryParams.toString();
                            if (queryString) {
                                url += '?' + queryString;
                            }

                            return url;
                        }

                        // Fix common JSON escaping issues
                        if (productDiscountsJson.startsWith('&quot;') || productDiscountsJson.startsWith('"')) {
                            console.log("Detected escaped JSON, attempting to fix...");
                            // Remove leading/trailing quotes if present
                            if (productDiscountsJson.startsWith('&quot;') && productDiscountsJson.endsWith('&quot;')) {
                                productDiscountsJson = productDiscountsJson.substring(6, productDiscountsJson.length - 6);
                            } else if (productDiscountsJson.startsWith('"') && productDiscountsJson.endsWith('"')) {
                                productDiscountsJson = productDiscountsJson.substring(1, productDiscountsJson.length - 1);
                            }

                            // Replace &quot; with " inside the string
                            productDiscountsJson = productDiscountsJson.replace(/&quot;/g, '"');

                            // Unescape other common HTML entities
                            productDiscountsJson = productDiscountsJson
                                .replace(/&lt;/g, '<')
                                .replace(/&gt;/g, '>')
                                .replace(/&amp;/g, '&');

                            console.log("Fixed JSON:", productDiscountsJson.substring(0, 100) + "...");
                        }

                        // cẩn thận động vào các class trong js , vì class selector có thể bị trùng với các class khác , 
                        // Resolve Spring messages for JavaScript usage
                        const msgRemoveConfirm = '<spring:message code="cart.remove.confirm" text="Are you sure you want to remove this item?" javaScriptEscape="true"/>';
                        const msgItems = '<spring:message code="cart.items" text="items" javaScriptEscape="true"/>';
                        const msgErrorRemove = '<spring:message code="cart.error.remove" text="Failed to remove item" javaScriptEscape="true"/>';
                        const msgErrorIdentify = '<spring:message code="cart.error.identify" text="Error: Could not identify the item to remove." javaScriptEscape="true"/>';
                        const msgStockLimitReached = '<spring:message code="cart.stock.limit" text="Cannot exceed available stock quantity." javaScriptEscape="true"/>';

                        // Get customer info from session
                        const accountId = "${sessionScope.accountId}";
                        const customerId = "${sessionScope.customerId}";

                        // Log product discount information for customer and product IDs
                        console.log("--- Product Discount Information ---");
                        console.log("Current Customer ID:", customerId || "Not logged in");


                        // Helper function to check if a string is valid JSON
                        function isValidJson(str) {
                            try {
                                JSON.parse(str);
                                return true;
                            } catch (e) {
                                return false;
                            }
                        }

                        // Function to log cart items from data attributes
                        function logCartItemsFromAttributes() {
                            try {
                                console.log("--- Cart Items Information ---");
                                // Log account_id instead of customerId (or both)
                                console.log("Current Account ID:", accountId || "Not available");
                                console.log("Current Customer ID:", customerId || "Not logged in");

                                // Get all cart items from the DOM and read their data attributes
                                const cartItems = document.querySelectorAll('.cart-item');
                                console.log(`Total Items: ${cartItems.length}`);

                                let productIdHasProblems = false;

                                cartItems.forEach((item, index) => {

                                    try {
                                        // Extract all data attributes
                                        const rawProductId = item.dataset.productId;
                                        const cleanProductId = rawProductId ? rawProductId.replace(/[^0-9]/g, '') : null;

                                        // Check if product ID has unexpected characters
                                        if (rawProductId && rawProductId !== cleanProductId) {
                                            console.warn(`Item #${index + 1} has a problematic productId:`, rawProductId);
                                            productIdHasProblems = true;
                                        }

                                        const itemData = {
                                            accountId: accountId || "N/A", // Include account ID for each item
                                            cartDetailId: item.dataset.cartDetailId || "N/A",
                                            productId: rawProductId || "N/A",
                                            cleanProductId: cleanProductId || "N/A",
                                            productName: item.dataset.productName || "N/A",
                                            productVariantId: item.dataset.productVariantId || "N/A",  // This is the key one
                                            colorName: item.dataset.colorName || "N/A",
                                            sizeName: item.dataset.sizeName || "N/A",
                                            price: item.dataset.price || "N/A",
                                            quantity: item.dataset.quantity || "N/A"
                                        };

                                        console.log(`Item #${index + 1}:`, itemData);
                                    } catch (itemError) {
                                        console.error(`Error processing item #${index + 1}:`, itemError);
                                    }
                                });

                                if (productIdHasProblems) {
                                    console.warn("IMPORTANT: Some product IDs have unexpected characters. This may cause API request failures.");
                                }
                            } catch (error) {
                                console.error("Error logging cart items:", error);
                            }
                        }

                        // Function to update cart totals
                        function updateCartTotals() {
                            let subtotal = 0;
                            document.querySelectorAll('.cart-item').forEach(item => {
                                const checkbox = item.querySelector('.item-checkbox');
                                // Only count checked items
                                if (checkbox && checkbox.checked) {
                                    const quantityElement = item.querySelector('.quantity-value');
                                    const unitPrice = parseFloat(item.dataset.price);
                                    const quantity = parseInt(quantityElement.textContent);
                                    if (!isNaN(unitPrice) && !isNaN(quantity)) {
                                        subtotal += unitPrice * quantity;
                                    }
                                }
                            });

                            const subtotalElement = document.getElementById('cart-subtotal');
                            const totalElement = document.getElementById('cart-total');

                            if (subtotalElement) {
                                subtotalElement.textContent = '$' + subtotal.toFixed(2);
                            }
                            if (totalElement) {
                                totalElement.textContent = '$' + subtotal.toFixed(2);
                            }
                        }

                        // Function to fetch discounts for a specific product
                        function fetchProductDiscounts(productId, cartDetailId, productVariantId, callback) {
                            console.log('Fetching discounts for ProductID:', productId, 'VariantID:', productVariantId, 'CartDetailID:', cartDetailId);

                            // Skip querying the DOM since we already have the variant ID
                            if (!productVariantId) {
                                console.warn('Product Variant ID is null or undefined, using empty array');
                                if (callback && typeof callback === 'function') {
                                    callback([]);
                                }
                                return;
                            }

                            // First check if we have pre-loaded data
                            if (allProductDiscounts && Object.keys(allProductDiscounts).length > 0) {
                                console.log('Filtering discounts by productVariantId:', productVariantId);

                                // Filter discounts by product_variant_id and status
                                const filteredDiscounts = [];

                                // Loop through all discounts to find matches
                                for (const key in allProductDiscounts) {
                                    if (Array.isArray(allProductDiscounts[key])) {
                                        allProductDiscounts[key].forEach(discount => {
                                            // Check if this discount is for the current product variant
                                            const discountVariantId = discount.product_variant_id;

                                            if (discountVariantId == productVariantId) {
                                                filteredDiscounts.push(discount);
                                            }
                                        });
                                    }
                                }

                                console.log('Found ' + filteredDiscounts.length + ' matching discounts for variant ' + productVariantId);

                                if (filteredDiscounts.length > 0) {
                                    if (callback && typeof callback === 'function') {
                                        callback(filteredDiscounts);
                                    }
                                    return;
                                } else {
                                    console.log('No matching discounts found, using API call');
                                }
                            }

                            console.log('No pre-loaded discounts found for productVariantId ' + productVariantId + ', falling back to API call');

                            const csrfToken = document.querySelector('meta[name="_csrf"]')?.content;
                            const csrfHeader = document.querySelector('meta[name="_csrf_header"]')?.content;

                            // Use our custom URL builder with proper parameter handling - now get discounts by variant ID
                            const url = buildApiUrl('/user/api/variant-discounts', { productVariantId: productVariantId });
                            console.log('Fetching discounts from URL: ' + url);

                            // Add debug info to the console
                            console.log('Debug info:');
                            console.log('- productId:', productId);
                            console.log('- productVariantId:', productVariantId);
                            console.log('- cartDetailId:', cartDetailId);
                            console.log('- contextPathValue:', contextPathValue);
                            console.log('- Full URL:', url);

                            fetch(url, {
                                method: 'GET',
                                headers: {
                                    'Content-Type': 'application/json',
                                    [csrfHeader]: csrfToken
                                }
                            })
                                .then(response => {
                                    if (!response.ok) {
                                        console.error('Server returned ' + response.status + ': ' + response.statusText);
                                        throw new Error('Server returned ' + response.status + ': ' + response.statusText);
                                    }
                                    return response.json();
                                })
                                .then(data => {
                                    console.log('Successfully fetched discounts for productVariantId ' + productVariantId + ':', data);

                                    // Debug the data structure
                                    debugDiscountData(data);

                                    // Check if data is empty or not an array
                                    if (!data || (Array.isArray(data) && data.length === 0) ||
                                        (data.content && Array.isArray(data.content) && data.content.length === 0)) {
                                        console.log('API returned empty data, using empty array');
                                        if (callback && typeof callback === 'function') {
                                            callback([]);
                                        }
                                        return;
                                    }

                                    // Cache the result for future use
                                    if (!allProductDiscounts) {
                                        allProductDiscounts = {};
                                    }
                                    // Store by product variant ID
                                    if (!allProductDiscounts[productVariantId]) {
                                        allProductDiscounts[productVariantId] = [];
                                    }
                                    allProductDiscounts[productVariantId] = data;

                                    if (callback && typeof callback === 'function') {
                                        callback(data);
                                    }
                                })
                                .catch(error => {
                                    console.error('Error fetching discounts for product variant ' + productVariantId + ':', error);
                                    if (callback && typeof callback === 'function') {
                                        // Use empty array to indicate no discounts available
                                        callback([]);
                                    }
                                });
                        }

                        // Debug helper for discount data
                        function debugDiscountData(data) {
                            console.log("=== DEBUG DISCOUNT DATA ===");
                            console.log("Type of data:", typeof data);

                            if (data === null) {
                                console.log("Data is null");
                                return;
                            }

                            if (typeof data === 'string') {
                                console.log("Data is string, length:", data.length);
                                try {
                                    const parsed = JSON.parse(data);
                                    console.log("Successfully parsed string to:", parsed);
                                    data = parsed;
                                } catch (e) {
                                    console.log("Could not parse string as JSON:", e);
                                }
                            }

                            if (Array.isArray(data)) {
                                console.log("Data is array with", data.length, "items");
                                if (data.length > 0) {
                                    console.log("First item:", data[0]);
                                    console.log("Keys in first item:", Object.keys(data[0]));
                                }
                            } else if (typeof data === 'object') {
                                console.log("Data is object with keys:", Object.keys(data));

                                // Check if this is a wrapper object with content inside
                                if (data.content && Array.isArray(data.content)) {
                                    console.log("Found data.content array with", data.content.length, "items");
                                    if (data.content.length > 0) {
                                        console.log("First content item:", data.content[0]);
                                    }
                                }
                            }

                            console.log("=== END DEBUG ===");
                        }

                        // Function to save checkbox state to localStorage
                        function saveCheckboxState() {
                            const checkedItems = {};
                            document.querySelectorAll('.cart-item').forEach(item => {
                                const checkbox = item.querySelector('.item-checkbox');
                                const cartDetailId = item.dataset.cartDetailId;
                                if (checkbox && cartDetailId) {
                                    checkedItems[cartDetailId] = checkbox.checked;
                                }
                            });
                            localStorage.setItem('cartCheckedItems', JSON.stringify(checkedItems));
                        }

                        // Function to restore checkbox state from localStorage
                        function restoreCheckboxState() {
                            try {
                                const checkedItems = JSON.parse(localStorage.getItem('cartCheckedItems')) || {};
                                document.querySelectorAll('.cart-item').forEach(item => {
                                    const checkbox = item.querySelector('.item-checkbox');
                                    const cartDetailId = item.dataset.cartDetailId;
                                    if (checkbox && cartDetailId && checkedItems.hasOwnProperty(cartDetailId)) {
                                        checkbox.checked = checkedItems[cartDetailId];
                                    }
                                });

                                // Update select all checkbox state based on restored state
                                const selectAllCheckbox = document.querySelector('input[name="selectAll"]');
                                const itemCheckboxes = document.querySelectorAll('.item-checkbox');
                                if (selectAllCheckbox && itemCheckboxes.length > 0) {
                                    const allChecked = Array.from(itemCheckboxes).every(checkbox => checkbox.checked);
                                    selectAllCheckbox.checked = allChecked;
                                }

                                // Update totals based on restored state
                                updateCartTotals();
                            } catch (error) {
                                console.error('Error restoring checkbox state:', error);
                            }
                        }

                        // Helper function to update item count in the header (NEW FUNCTION)
                        function updateItemCountHeader() {
                            // Use the specific ID instead of complex selector
                            const itemCountParagraph = document.getElementById('cart-item-count');
                            if (itemCountParagraph) {
                                const remainingItems = document.querySelectorAll('.cart-item').length;
                                // Assuming the text format is like "X items" - adapt if using i18n heavily
                                const textParts = itemCountParagraph.textContent.trim().split(' ');
                                itemCountParagraph.textContent = remainingItems + ' ' + msgItems; // Use JS variable for "items" text
                            }
                        }

                        // Function to update quantity
                        function updateQuantity(button, change) {
                            const quantityContainer = button.closest('.quantity-selector');
                            const quantityElement = quantityContainer.querySelector('.quantity-value');
                            const cartItemElement = button.closest('.cart-item');
                            const cartDetailId = quantityElement.dataset.cartDetailId;
                            const stockQuantity = parseInt(quantityElement.dataset.cartDetailStock);

                            let currentQuantity = parseInt(quantityElement.textContent);
                            let newQuantity = currentQuantity + change;

                            // Ensure quantity doesn't go below 1
                            if (newQuantity < 1) newQuantity = 1;

                            // Ensure quantity doesn't exceed stock limit
                            if (stockQuantity && newQuantity > stockQuantity) {
                                alert(msgStockLimitReached);
                                newQuantity = stockQuantity;
                            }

                            // If quantity didn't change, exit early
                            if (newQuantity === currentQuantity) return;

                            // Update quantity display
                            quantityElement.textContent = newQuantity;

                            // Update item price display if element exists
                            const priceElement = cartItemElement.querySelector('.font-medium');
                            const itemPrice = parseFloat(cartItemElement.dataset.price);

                            if (priceElement && !isNaN(itemPrice)) {
                                priceElement.textContent = '$' + (newQuantity * itemPrice).toFixed(2);
                            }

                            // Send AJAX request to update the quantity in the database
                            const csrfToken = document.querySelector('meta[name="_csrf"]')?.content;
                            const csrfHeader = document.querySelector('meta[name="_csrf_header"]')?.content;

                            fetch('${ctx}/cart/update-quantity', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/json',
                                    [csrfHeader]: csrfToken
                                },
                                body: JSON.stringify({
                                    cartDetailId: cartDetailId,
                                    quantity: newQuantity
                                })
                            })
                                .then(response => {
                                    if (!response.ok) {
                                        throw new Error('Failed to update quantity');
                                    }
                                    return response.json();
                                })
                                .then(data => {
                                    console.log('Quantity updated successfully', data);
                                })
                                .catch(error => {
                                    console.error('Error updating quantity:', error);
                                    // Revert the quantity display if there was an error
                                    quantityElement.textContent = currentQuantity;
                                    if (priceElement && !isNaN(itemPrice)) {
                                        priceElement.textContent = '$' + (currentQuantity * itemPrice).toFixed(2);
                                    }
                                    // You might want to show an error message to the user
                                    alert('Failed to update quantity. Please try again.');
                                });

                            // Update cart totals
                            updateCartTotals();
                            // Save state after quantity change
                            saveCheckboxState();
                        }

                        // Document ready function
                        document.addEventListener('DOMContentLoaded', function () {
                            // Log cart items data
                            logCartItemsFromAttributes();

                            // Initialize dummy discounts for testing if no data is available
                            initializeDummyDiscounts();

                            // Get all checkboxes
                            const selectAllCheckbox = document.querySelector('input[name="selectAll"]');
                            const itemCheckboxes = document.querySelectorAll('.item-checkbox');

                            // Add event listener to "select all" checkbox
                            if (selectAllCheckbox) {
                                selectAllCheckbox.addEventListener('change', function () {
                                    const isChecked = this.checked;
                                    // Update all item checkboxes
                                    itemCheckboxes.forEach(function (checkbox) {
                                        checkbox.checked = isChecked;
                                    });
                                    // Update totals after selecting/deselecting all
                                    updateCartTotals();
                                    // Save checkbox state
                                    saveCheckboxState();
                                });
                            }

                            // Add event listeners to individual checkboxes
                            itemCheckboxes.forEach(function (checkbox) {
                                checkbox.addEventListener('change', function () {
                                    // Check if all checkboxes are checked
                                    if (selectAllCheckbox) {
                                        const allChecked = Array.from(itemCheckboxes).every(function (cb) {
                                            return cb.checked;
                                        });
                                        // Update the "select all" checkbox
                                        selectAllCheckbox.checked = allChecked;
                                    }
                                    // Update totals when individual checkbox changes
                                    updateCartTotals();
                                    // Save checkbox state
                                    saveCheckboxState();
                                });
                            });

                            // Restore saved checkbox state
                            restoreCheckboxState();

                            // Add event listener for checkout button
                            const checkoutBtn = document.getElementById('checkout-btn');
                            if (checkoutBtn) {
                                checkoutBtn.addEventListener('click', function () {
                                    processCheckout();
                                });
                            }
                        });

                        // Function to process checkout with selected items
                        function processCheckout() {
                            const selectedItems = [];

                            // Get all selected items
                            document.querySelectorAll('.cart-item').forEach(item => {
                                const checkbox = item.querySelector('.item-checkbox');
                                if (checkbox && checkbox.checked) {
                                    const cartDetailId = item.dataset.cartDetailId;
                                    if (cartDetailId) {
                                        selectedItems.push(cartDetailId);
                                    }
                                }
                            });

                            // Check if any items are selected
                            if (selectedItems.length === 0) {
                                alert('Please select at least one item to checkout');
                                return;
                            }

                            console.log('Selected items for checkout:', selectedItems);

                            // Create a form to submit selected items
                            const form = document.createElement('form');
                            form.method = 'POST';
                            form.action = '${ctx}/user/order-view';

                            // Add CSRF token
                            const csrfToken = document.querySelector('meta[name="_csrf"]')?.content;
                            const csrfHeader = document.querySelector('meta[name="_csrf_header"]')?.content;

                            if (csrfToken) {
                                const csrfInput = document.createElement('input');
                                csrfInput.type = 'hidden';
                                csrfInput.name = '_csrf';
                                csrfInput.value = csrfToken;
                                form.appendChild(csrfInput);
                            }

                            // Add selected item IDs
                            selectedItems.forEach(id => {
                                const input = document.createElement('input');
                                input.type = 'hidden';
                                input.name = 'selectedItems';
                                input.value = id;
                                form.appendChild(input);
                            });

                            console.log('Form created with', selectedItems.length, 'selected items');
                            console.log('Submitting to new controller: ${ctx}/user/order-view');

                            // Append form to body and submit
                            document.body.appendChild(form);
                            form.submit();
                        }

                        // Function to update event listeners for discount remove buttons
                        function setupDiscountRemoveButtons() {
                            // Add click event handlers for discount remove buttons
                            document.querySelectorAll('.remove-discount-btn').forEach(button => {
                                button.addEventListener('click', function () {
                                    const cartDetailId = this.getAttribute('data-cart-detail-id');
                                    removeDiscount(cartDetailId);
                                });
                            });
                        }

                        document.addEventListener('DOMContentLoaded', function () {
                            // Toggle discount tooltips
                            const discountTriggers = document.querySelectorAll('.item-discount-trigger');

                            discountTriggers.forEach(trigger => {
                                const triggerElement = trigger.querySelector('div');
                                const tooltip = trigger.querySelector('.item-discount-tooltip');
                                const cartItem = trigger.closest('.cart-item');

                                // Store the cart item ID and product variant ID for later use
                                let cartDetailId = '';
                                let productVariantId = '';

                                if (cartItem) {
                                    cartDetailId = cartItem.getAttribute('data-cart-detail-id') || '';
                                    productVariantId = cartItem.getAttribute('data-product-variant-id') || '';

                                    // Add these as attributes to the trigger for easy access
                                    trigger.setAttribute('data-cart-detail-id', cartDetailId);
                                    trigger.setAttribute('data-product-variant-id', productVariantId);

                                    console.log('Cart item found - CartDetailID:', cartDetailId, 'VariantID:', productVariantId);
                                }

                                triggerElement.addEventListener('click', function (e) {
                                    e.stopPropagation();

                                    // Get the product ID from closest cart item
                                    const cartItem = trigger.closest('.cart-item');
                                    if (!cartItem) {
                                        console.warn('Could not find parent cart item');
                                        return;
                                    }

                                    const productId = cartItem.getAttribute('data-product-id');
                                    const cartDetailId = cartItem.getAttribute('data-cart-detail-id');
                                    const productVariantId = cartItem.getAttribute('data-product-variant-id');

                                    console.log('Clicked discount trigger for ProductID:', productId, 'VariantID:', productVariantId, 'CartDetailID:', cartDetailId);

                                    // Only fetch discounts if the tooltip is being shown
                                    if (tooltip.classList.contains('hidden')) {
                                        // Show loading indicator in tooltip
                                        tooltip.innerHTML = '<div class="p-4 text-center text-gray-500">Đang tải mã giảm giá...</div>';
                                        tooltip.classList.toggle('hidden'); // Show the tooltip immediately with loading state

                                        // Pass the specific cart item element for accurate variant identification
                                        fetchProductDiscounts(productId, cartDetailId, productVariantId, function (discounts) {
                                            updateDiscountTooltip(tooltip, discounts, cartDetailId);
                                        });
                                    } else {
                                        // Just toggle the tooltip if already visible
                                        tooltip.classList.toggle('hidden');
                                    }
                                });

                                // Close tooltip when clicking outside
                                document.addEventListener('click', function (e) {
                                    if (!trigger.contains(e.target)) {
                                        tooltip.classList.add('hidden');
                                    }
                                });
                            });

                            // Setup remove discount buttons
                            setupDiscountRemoveButtons();
                        });

                        // Function to update discount tooltip with fetched discounts
                        function updateDiscountTooltip(tooltipElement, discounts, cartDetailId) {
                            let tooltipContent =
                                '<div class="py-2 px-3 text-sm text-gray-700">' +
                                '<p class="font-medium">Mã giảm giá cho sản phẩm</p>' +
                                '<p class="text-xs mt-1 text-gray-500">Áp dụng mã giảm giá để tiết kiệm khi mua sản phẩm này</p>' +
                                '</div>' +
                                '<div class="py-2 px-3 max-h-[200px] overflow-y-auto">';

                            // Handle potential wrapper object structure
                            if (discounts && discounts.content && Array.isArray(discounts.content)) {
                                console.log("Using content array from wrapper object");
                                discounts = discounts.content;
                            }

                            // Check if we have discounts 
                            if (!discounts || discounts.length === 0) {
                                tooltipContent += '<div class="p-4 text-center text-gray-500">Sản phẩm này hiện chưa có mã giảm giá.</div>';
                            } else {
                                // Filter for available discounts only
                                const availableDiscounts = discounts.filter(discount =>
                                    discount.status === 'available' || !discount.status);

                                if (availableDiscounts.length === 0) {
                                    tooltipContent += '<div class="p-4 text-center text-gray-500">Sản phẩm này hiện chưa có mã giảm giá.</div>';
                                    console.log("No available discounts found after filtering");
                                } else {
                                    console.log("Processing " + availableDiscounts.length + " available discounts");
                                    // Add each discount to the tooltip
                                    availableDiscounts.forEach(discount => {
                                        // Get values with fallbacks for both API and model data structures
                                        const discountName = discount.discount_name || discount.discountName || 'Discount';
                                        const discountCode = discount.discount_code || discount.discountCode || '';
                                        const discountPercentage = discount.discount_percentage || discount.discountPercentage || 10;
                                        const discountType = discount.discount_type || discount.discountType || 'PERCENT';
                                        const minAmount = discount.totalminmoney || 0;
                                        const startDate = discount.start_date || discount.startDate || '';
                                        const endDate = discount.end_date || discount.endDate || '';
                                        const status = discount.status || 'available';

                                        console.log("Processing discount:", {
                                            name: discountName,
                                            code: discountCode,
                                            percentage: discountPercentage,
                                            type: discountType,
                                            minAmount: minAmount,
                                            status: status
                                        });

                                        // Format display value based on discount type
                                        const displayValue = discountType.toUpperCase() === 'PERCENT' ?
                                            'Giảm ' + discountPercentage + '%' : 'Giảm ₫' + discountPercentage + 'k';

                                        // Format min amount if applicable
                                        const minAmountText = minAmount > 0 ?
                                            'Đơn Tối Thiểu ₫' + (minAmount / 1000) + 'k' : '';

                                        // Format date info
                                        let dateInfo = '';
                                        if (startDate && endDate) {
                                            // Just show "Còn X ngày" for simplicity
                                            dateInfo = 'Còn thời hạn';
                                        }

                                        tooltipContent +=
                                            '<div class="flex items-center p-2 border-b">' +
                                            '<div class="flex-shrink-0 mr-3">' +
                                            '<img src="' + contextPathValue + '/resources/assets/client/images/logo-audio365.png" ' +
                                            'alt="Shop Logo" class="w-8 h-8 object-contain" ' +
                                            'onerror="this.onerror=null; this.src=\'data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0IiBmaWxsPSJub25lIiBzdHJva2U9ImN1cnJlbnRDb2xvciIgc3Ryb2tlLXdpZHRoPSIyIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIGNsYXNzPSJmZWF0aGVyIGZlYXRoZXItc2hvcHBpbmctYmFnIj48cGF0aCBkPSJNNiAyTDMgNnYxNGEyIDIgMCAwIDAgMiAyaDE0YTIgMiAwIDAgMCAyLTJWNmwtMy00eiI+PC9wYXRoPjxsaW5lIHgxPSIzIiB5MT0iNiIgeDI9IjIxIiB5Mj0iNiI+PC9saW5lPjxwYXRoIGQ9Ik0xNiAxMGE0IDQgMCAwIDEtOCAwIj48L3BhdGg+PC9zdmc+\'>"' +
                                            '</div>' +
                                            '<div class="flex-grow">' +
                                            '<p class="font-medium text-xs">' + displayValue + '</p>' +
                                            '<p class="text-xs text-gray-500">' + minAmountText + '</p>' +
                                            '<p class="text-xs text-gray-500 mt-1">' + dateInfo + '</p>' +
                                            '</div>' +
                                            '<div class="ml-2">' +
                                            '<button class="apply-item-discount-btn bg-orange-500 hover:bg-orange-600 text-white px-2 py-1 rounded text-xs" ' +
                                            'data-discount="' + discountPercentage + '" ' +
                                            'data-discount-type="' + discountType + '" ' +
                                            'data-code="' + discountCode + '" ' +
                                            'data-min-amount="' + minAmount + '" ' +
                                            'data-cart-detail-id="' + cartDetailId + '">' +
                                            'Áp dụng' +
                                            '</button>' +
                                            '</div>' +
                                            '</div>';
                                    });
                                }
                            }

                            tooltipContent += '</div>';
                            tooltipElement.innerHTML = tooltipContent;

                            // Re-attach event listeners to newly created buttons
                            tooltipElement.querySelectorAll('.apply-item-discount-btn').forEach(button => {
                                button.addEventListener('click', function () {
                                    const discountValue = this.getAttribute('data-discount');
                                    const discountType = this.getAttribute('data-discount-type');
                                    const discountCode = this.getAttribute('data-code');
                                    const cartDetailId = this.getAttribute('data-cart-detail-id');

                                    let displayValue;
                                    if (discountType.toUpperCase() === 'PERCENT') {
                                        displayValue = discountValue + '%';
                                    } else {
                                        displayValue = '₫' + discountValue + 'k';
                                    }

                                    applyDiscount(cartDetailId, discountCode, displayValue);

                                    // Hide tooltip after applying discount
                                    tooltipElement.classList.add('hidden');
                                });
                            });
                        }

                        // Apply discount to cart item
                        function applyDiscount(cartDetailId, discountCode, discountValue) {
                            // Show applied discount
                            const container = document.querySelector('.applied-discount-container-' + cartDetailId);
                            const discountText = document.querySelector('.applied-discount-text-' + cartDetailId);

                            if (container && discountText) {
                                container.classList.remove('hidden');
                                discountText.textContent = discountCode + ' - ' + discountValue;

                                // Store discount info in data attributes for later use
                                container.setAttribute('data-discount-value', discountValue);
                                container.setAttribute('data-discount-code', discountCode);

                                // Update totals
                                recalculateTotals();

                                console.log('Applied discount: ' + discountCode + ' (' + discountValue + ') to cart item ' + cartDetailId);
                            } else {
                                console.error('Container or text element not found for cart detail ID: ' + cartDetailId);
                            }
                        }

                        // Remove discount from cart item
                        function removeDiscount(cartDetailId) {
                            const container = document.querySelector('.applied-discount-container-' + cartDetailId);

                            if (container) {
                                container.classList.add('hidden');

                                // Clear discount data
                                container.setAttribute('data-discount-value', '');
                                container.setAttribute('data-discount-code', '');

                                // Update totals
                                recalculateTotals();

                                console.log('Removed discount from cart item ' + cartDetailId);
                            } else {
                                console.error('Container not found for cart detail ID: ' + cartDetailId);
                            }
                        }

                        // Recalculate cart totals with discounts
                        function recalculateTotals() {
                            // This function would be implemented to calculate totals including discounts
                            // It depends on your existing cart calculation logic
                            console.log('Recalculating totals with discounts');

                            // Example implementation (modify based on your existing cart logic):
                            /*
                            let subtotal = 0;
                            const cartItems = document.querySelectorAll('.cart-item');

                            cartItems.forEach(item => {
                                const checkbox = item.querySelector('.item-checkbox');
                                if (checkbox && checkbox.checked) {
                                    const price = parseFloat(item.getAttribute('data-price'));
                                const quantityElement = item.querySelector('.quantity-value');
                                const quantity = parseInt(quantityElement.textContent.trim());
                                const cartDetailId = item.getAttribute('data-cart-detail-id');

                                let itemTotal = price * quantity;

                                // Apply discount if available
                                const discountContainer = document.querySelector(`.applied-discount-container-${cartDetailId}`);
                                    if (discountContainer && !discountContainer.classList.contains('hidden')) {
                                        const discountValue = discountContainer.getAttribute('data-discount-value');
                                        
                                        if (discountValue.includes('%')) {
                                            // Percentage discount
                                            const percentage = parseFloat(discountValue);
                                            const discountAmount = itemTotal * (percentage / 100);
                                            itemTotal -= discountAmount;
                                        } else {
                                            // Fixed amount discount
                                            const discountAmount = parseFloat(discountValue);
                                            itemTotal = Math.max(0, itemTotal - discountAmount);
                                        }
                                    }
                                    
                                    subtotal += itemTotal;
                                }
                            });
                            
                            // Update subtotal display
                            document.getElementById('cart-subtotal').textContent = '$' + subtotal.toFixed(2);
                            */
                        }

                        // Function to initialize dummy discounts if none are available
                        function initializeDummyDiscounts() {
                            console.log("Checking if dummy discount initialization is needed...");

                            // Check if we have any discount data
                            if (!allProductDiscounts || Object.keys(allProductDiscounts).length === 0) {
                                console.log("No pre-loaded discounts found, initializing dummy data");

                                // Mẫu data minh họa dựa trên cấu trúc thực tế
                                allProductDiscounts = {
                                    "all": sampleDiscountsData
                                };

                                // Copy discounts to product variant specific arrays for easier access
                                const variantIds = [];

                                // Collect all product variant IDs from cart items
                                document.querySelectorAll('.cart-item').forEach(item => {
                                    const variantId = item.dataset.productVariantId;
                                    if (variantId && !variantIds.includes(variantId)) {
                                        variantIds.push(variantId);
                                    }
                                });

                                console.log("Found product variant IDs in cart:", variantIds);

                                // Create specific arrays for each product variant
                                variantIds.forEach(variantId => {
                                    // Filter discounts for this variant
                                    allProductDiscounts[variantId] = allProductDiscounts.all.filter(
                                        discount => discount.product_variant_id == variantId
                                    );
                                });

                                console.log("Initialized dummy discount data for " + variantIds.length + " product variants");
                            } else {
                                console.log("Pre-loaded discounts found, no need for dummy data");
                            }
                        }
                    </script>
                </body>

                </html>