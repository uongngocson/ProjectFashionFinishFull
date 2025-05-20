<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>DDTS | Product Detail</title>
                    <script src="https://cdn.tailwindcss.com"></script>
                    <c:set var="ctx" value="${pageContext.request.contextPath}" />
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                    <link rel="stylesheet" href="${ctx}/resources/assets/client/css/productDetail.css">
                    <script id="variantsData" type="application/json">
                    ${variantsJson}
                </script>

                </head>

                <body class="bg-white">
                    <!-- navbar -->
                    <jsp:include page="../layout/navbar.jsp" />

                    <!-- Product Container -->

                    <div class="bg-gray-100">
                        <div class="container mx-auto px-4 py-8">
                            <div class="bg-white py-8 antialiased dark:bg-gray-900 md:py-16 flex flex-wrap -mx-4">
                                <!-- Product Images -->
                                <div class="w-full md:w-1/2 px-4 mb-8">
                                    <div class="image-container">
                                        <img src="https://images.unsplash.com/photo-1505740420928-5e560c06d30e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NzEyNjZ8MHwxfHNlYXJjaHwxfHxoZWFkcGhvbmV8ZW58MHwwfHx8MTcyMTMwMzY5MHww&ixlib=rb-4.0.3&q=80&w=1080"
                                            alt="${product.productName}" class="w-full h-auto rounded-lg shadow-md mb-4"
                                            id="mainImage">
                                    </div>
                                    <div class="flex gap-4 py-4 justify-center overflow-x-auto">
                                        <img src="https://images.unsplash.com/photo-1505751171710-1f6d0ace5a85?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NzEyNjZ8MHwxfHNlYXJjaHwxMnx8aGVhZHBob25lfGVufDB8MHx8fDE3MjEzMDM2OTB8MA&ixlib=rb-4.0.3&q=80&w=1080"
                                            alt="Thumbnail 1"
                                            class="size-16 sm:size-20 object-cover rounded-md cursor-pointer opacity-60 hover:opacity-100 transition duration-300"
                                            onclick="changeImage(this.src)">
                                        <img src="https://images.unsplash.com/photo-1484704849700-f032a568e944?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NzEyNjZ8MHwxfHNlYXJjaHw0fHxoZWFkcGhvbmV8ZW58MHwwfHx8MTcyMTMwMzY5MHww&ixlib=rb-4.0.3&q=80&w=1080"
                                            alt="Thumbnail 2"
                                            class="size-16 sm:size-20 object-cover rounded-md cursor-pointer opacity-60 hover:opacity-100 transition duration-300"
                                            onclick="changeImage(this.src)">
                                        <img src="https://images.unsplash.com/photo-1496957961599-e35b69ef5d7c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NzEyNjZ8MHwxfHNlYXJjaHw4fHxoZWFkcGhvbmV8ZW58MHwwfHx8MTcyMTMwMzY5MHww&ixlib=rb-4.0.3&q=80&w=1080"
                                            alt="Thumbnail 3"
                                            class="size-16 sm:size-20 object-cover rounded-md cursor-pointer opacity-60 hover:opacity-100 transition duration-300"
                                            onclick="changeImage(this.src)">
                                        <img src="https://images.unsplash.com/photo-1528148343865-51218c4a13e6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NzEyNjZ8MHwxfHNlYXJjaHwzfHxoZWFkcGhvbmV8ZW58MHwwfHx8MTcyMTMwMzY5MHww&ixlib=rb-4.0.3&q=80&w=1080"
                                            alt="Thumbnail 4"
                                            class="size-16 sm:size-20 object-cover rounded-md cursor-pointer opacity-60 hover:opacity-100 transition duration-300"
                                            onclick="changeImage(this.src)">
                                    </div>
                                </div>

                                <!-- Product Details -->
                                <div class="w-full md:w-1/2 px-4">
                                    <h2 class="text-3xl font-bold mb-2">${product.productName}</h2>
                                    <p class="text-gray-600 mb-4">SKU: WH1000XM4</p>
                                    <p class="text-gray-600 mb-4">TÌNH TRẠNG: <span id="stockStatus"
                                            class="text-green-600">Còn hàng</span> <span id="stockQuantity"
                                            class="text-blue-600 font-medium"></span></p>

                                    <div class="mb-4">
                                        <span class="text-2xl font-bold mr-2">${product.price}</span>
                                        <span class="text-gray-500 line-through">$399.99</span>
                                    </div>
                                    <div class="flex items-center mb-4">
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"
                                            class="size-6 text-yellow-500">
                                            <path fill-rule="evenodd"
                                                d="M10.788 3.21c.448-1.077 1.976-1.077 2.424 0l2.082 5.006 5.404.434c1.164.093 1.636 1.545.749 2.305l-4.117 3.527 1.257 5.273c.271 1.136-.964 2.033-1.96 1.425L12 18.354 7.373 21.18c-.996.608-2.231-.29-1.96-1.425l1.257-5.273-4.117-3.527c-.887-.76-.415-2.212.749-2.305l5.404-.434 2.082-5.005Z"
                                                clip-rule="evenodd" />
                                        </svg>
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"
                                            class="size-6 text-yellow-500">
                                            <path fill-rule="evenodd"
                                                d="M10.788 3.21c.448-1.077 1.976-1.077 2.424 0l2.082 5.006 5.404.434c1.164.093 1.636 1.545.749 2.305l-4.117 3.527 1.257 5.273c.271 1.136-.964 2.033-1.96 1.425L12 18.354 7.373 21.18c-.996.608-2.231-.29-1.96-1.425l1.257-5.273-4.117-3.527c-.887-.76-.415-2.212.749-2.305l5.404-.434 2.082-5.005Z"
                                                clip-rule="evenodd" />
                                        </svg>
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"
                                            class="size-6 text-yellow-500">
                                            <path fill-rule="evenodd"
                                                d="M10.788 3.21c.448-1.077 1.976-1.077 2.424 0l2.082 5.006 5.404.434c1.164.093 1.636 1.545.749 2.305l-4.117 3.527 1.257 5.273c.271 1.136-.964 2.033-1.96 1.425L12 18.354 7.373 21.18c-.996.608-2.231-.29-1.96-1.425l1.257-5.273-4.117-3.527c-.887-.76-.415-2.212.749-2.305l5.404-.434 2.082-5.005Z"
                                                clip-rule="evenodd" />
                                        </svg>
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"
                                            class="size-6 text-yellow-500">
                                            <path fill-rule="evenodd"
                                                d="M10.788 3.21c.448-1.077 1.976-1.077 2.424 0l2.082 5.006 5.404.434c1.164.093 1.636 1.545.749 2.305l-4.117 3.527 1.257 5.273c.271 1.136-.964 2.033-1.96 1.425L12 18.354 7.373 21.18c-.996.608-2.231-.29-1.96-1.425l1.257-5.273-4.117-3.527c-.887-.76-.415-2.212.749-2.305l5.404-.434 2.082-5.005Z"
                                                clip-rule="evenodd" />
                                        </svg>
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"
                                            class="size-6 text-yellow-500">
                                            <path fill-rule="evenodd"
                                                d="M10.788 3.21c.448-1.077 1.976-1.077 2.424 0l2.082 5.006 5.404.434c1.164.093 1.636 1.545.749 2.305l-4.117 3.527 1.257 5.273c.271 1.136-.964 2.033-1.96 1.425L12 18.354 7.373 21.18c-.996.608-2.231-.29-1.96-1.425l1.257-5.273-4.117-3.527c-.887-.76-.415-2.212.749-2.305l5.404-.434 2.082-5.005Z"
                                                clip-rule="evenodd" />
                                        </svg>
                                        <span class="ml-2 text-gray-600">4.7 | ${product.quantitySold} sold</span>
                                    </div>
                                    <p class="text-gray-700 mb-6">${product.description}</p>

                                    <div class="mb-6">
                                        <h3 class="text-lg font-semibold mb-2">COLOR: <span id="selectedColor2"
                                                style="display:none;"></span></h3>
                                        <div class="flex space-x-2">
                                            <c:forEach var="color" items="${colors}">
                                                <div class="color-option2 w-8 h-8 rounded-full cursor-pointer"
                                                    data-bg-color="${color.colorHex}" data-color-id="${color.colorId}"
                                                    onclick="selectColor2(this, '${color.colorName}')"></div>
                                            </c:forEach>
                                        </div>
                                    </div>

                                    <!-- Size Selection -->
                                    <div class="mb-6">
                                        <h3 class="text-lg font-semibold mb-2">SIZE: <span id="selectedSize2"
                                                style="display:none;"></span></h3>
                                        <div class="grid grid-cols-5 gap-2">
                                            <c:forEach var="size" items="${sizes}">
                                                <div class="size-option2 text-center py-2 border border-gray-200 cursor-pointer text-sm"
                                                    data-size-id="${size.sizeId}"
                                                    onclick="selectSize2(this, '${size.sizeName}')">
                                                    ${size.sizeName}
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>

                                    <!-- Quantity -->
                                    <div class="mb-6">
                                        <h3 class="text-lg font-semibold mb-2">QUANTITY:</h3>
                                        <div
                                            class="quantity-selector flex items-center border border-gray-200 w-24 shadow-sm">
                                            <button type="button"
                                                class="px-2 py-1 text-gray-500 hover:bg-gray-100 transition-colors"
                                                onclick="adjustQuantity2(-1)">-</button>
                                            <span id="quantityDisplay2"
                                                class="flex-1 text-center quantity-value py-1">1</span>
                                            <button type="button"
                                                class="px-2 py-1 text-gray-500 hover:bg-gray-100 transition-colors"
                                                onclick="adjustQuantity2(1)">+</button>
                                        </div>
                                    </div>

                                    <div class="flex space-x-4 mb-6">
                                        <!-- Nút ADD TO CART -->
                                        <form action="/product-variant/add-to-cart" method="post" id="addToCartForm2"
                                            class="flex-1">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <input type="hidden" name="variantId" id="cartVariantId2" value="" />
                                            <input type="hidden" name="quantity" id="cartQuantityInput2" value="1" />
                                            <button type="submit"
                                                class="w-full bg-black text-white py-3 font-medium hover:bg-gray-800 rounded-md">
                                                <i class="fas fa-shopping-cart mr-2"></i> ADD TO CART
                                            </button>
                                        </form>

                                        <!-- Nút BUY NOW -->
                                        <form action="${ctx}/user/order" method="get" id="buyNowForm2" class="flex-1">
                                            <input type="hidden" name="variantId" id="selectedVariantId2" />
                                            <input type="hidden" name="quantity" id="quantityInput2" value="1" />
                                            <button type="submit" id="buyNowButton2" disabled
                                                class="w-full bg-red-600 text-white py-3 font-medium hover:bg-red-700 disabled:bg-gray-400 disabled:cursor-not-allowed rounded-md">
                                                <i class="fas fa-credit-card mr-2"></i> BUY NOW
                                            </button>
                                        </form>
                                    </div>

                                    <div class="flex items-center gap-4 mb-8">
                                        <button class="flex items-center text-sm text-gray-700 hover:text-black">
                                            <i class="far fa-heart mr-2"></i> Add to Wishlist
                                        </button>
                                        <div class="flex items-center gap-3">
                                            <span class="text-sm text-gray-700">Share:</span>
                                            <a href="#" class="text-gray-500 hover:text-black"><i
                                                    class="fab fa-facebook-f"></i></a>
                                            <a href="#" class="text-gray-500 hover:text-black"><i
                                                    class="fab fa-twitter"></i></a>
                                            <a href="#" class="text-gray-500 hover:text-black"><i
                                                    class="fab fa-pinterest-p"></i></a>
                                        </div>
                                    </div>

                                    <div>
                                        <h3 class="text-lg font-semibold mb-2">Key Features:</h3>
                                        <ul class="list-disc list-inside text-gray-700">
                                            <li>Industry-leading noise cancellation</li>
                                            <li>30-hour battery life</li>
                                            <li>Touch sensor controls</li>
                                            <li>Speak-to-chat technology</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <jsp:include page="../layout/review.jsp" />


                        <script>
                            function changeImage(src) {
                                document.getElementById('mainImage').src = src;
                            }

                            // Apply background colors to color options
                            document.addEventListener('DOMContentLoaded', function () {
                                document.querySelectorAll('.color-option2').forEach(function (el) {
                                    const bgColor = el.getAttribute('data-bg-color');
                                    if (bgColor) {
                                        el.style.backgroundColor = bgColor;
                                        el.style.border = '1px solid black';
                                    }
                                });
                            });

                            function selectColor2(el, name) {
                                document.querySelectorAll('.color-option2').forEach(e => e.classList.remove('selected'));
                                el.classList.add('selected');
                                const label = document.getElementById('selectedColor2');
                                if (label) label.innerText = name;
                                updateSelectedVariant2();
                            }

                            function selectSize2(el, name) {
                                document.querySelectorAll('.size-option2').forEach(e => e.classList.remove('selected'));
                                el.classList.add('selected');
                                const label = document.getElementById('selectedSize2');
                                if (label) label.innerText = name;
                                updateSelectedVariant2();
                            }

                            function adjustQuantity2(change) {
                                const display = document.getElementById('quantityDisplay2');
                                let val = parseInt(display.innerText);

                                // Lấy số lượng tồn kho của variant đã chọn
                                const selectedVariant = getSelectedVariant();
                                const maxStock = selectedVariant ? selectedVariant.quantityStock : 0;

                                // Giới hạn số lượng không vượt quá tồn kho
                                val = Math.max(1, Math.min(maxStock, val + change));
                                display.innerText = val;

                                // Update quantity for both forms
                                document.getElementById('quantityInput2').value = val;
                                document.getElementById('cartQuantityInput2').value = val;

                                console.log("Quantity updated to:", val);
                            }

                            // Hàm lấy variant đã chọn hiện tại
                            function getSelectedVariant() {
                                const selectedColorId = document.querySelector('.color-option2.selected')?.dataset.colorId;
                                const selectedSizeId = document.querySelector('.size-option2.selected')?.dataset.sizeId;

                                if (!selectedColorId || !selectedSizeId || !variants || variants.length === 0) {
                                    return null;
                                }

                                return variants.find(v =>
                                    v.color.colorId == selectedColorId && v.size.sizeId == selectedSizeId
                                );
                            }

                            let variants = [];
                            try {
                                const rawJson = document.getElementById("variantsData").textContent.trim();
                                variants = JSON.parse(rawJson);
                                console.log("Variants loaded:", variants);

                                // Kiểm tra tình trạng hàng hóa khi trang được tải
                                checkInitialStockStatus();
                            } catch (e) {
                                console.error("Lỗi khi parse variantsJson:", e);
                            }

                            // Kiểm tra tình trạng hàng hóa khi trang được tải
                            function checkInitialStockStatus() {
                                const stockStatus = document.getElementById('stockStatus');
                                const stockQuantity = document.getElementById('stockQuantity');

                                // Kiểm tra xem có ít nhất một variant còn hàng không
                                const hasStock = variants.some(variant => variant.quantityStock > 0);
                                const totalStock = variants.reduce((sum, variant) => sum + (variant.quantityStock || 0), 0);

                                if (variants.length === 0) {
                                    stockStatus.textContent = "Không có sẵn";
                                    stockStatus.className = "text-gray-600";
                                    stockQuantity.textContent = "";
                                } else if (hasStock) {
                                    stockStatus.textContent = "Có sẵn";
                                    stockStatus.className = "text-green-600";
                                    stockQuantity.textContent = "(Tổng " + totalStock + " sản phẩm)";
                                    stockQuantity.className = "text-blue-600 font-medium ml-2";
                                } else {
                                    stockStatus.textContent = "Hết hàng";
                                    stockStatus.className = "text-red-600";
                                    stockQuantity.textContent = "(0 sản phẩm)";
                                    stockQuantity.className = "text-gray-600 ml-2";
                                }
                            }

                            function updateSelectedVariant2() {
                                if (!variants || variants.length === 0) {
                                    console.warn("Không có variants để xử lý.");
                                    return;
                                }

                                const selectedColorId = document.querySelector('.color-option2.selected')?.dataset.colorId;
                                const selectedSizeId = document.querySelector('.size-option2.selected')?.dataset.sizeId;
                                const buyNowButton = document.getElementById('buyNowButton2');
                                const addToCartButton = document.getElementById('addToCartForm2').querySelector('button[type="submit"]');
                                const stockStatus = document.getElementById('stockStatus');
                                const stockQuantity = document.getElementById('stockQuantity');
                                const quantityDisplay = document.getElementById('quantityDisplay2');

                                // Disable BUY NOW button by default
                                buyNowButton.disabled = true;

                                if (selectedColorId && selectedSizeId) {
                                    const found = variants.find(v =>
                                        v.color.colorId == selectedColorId && v.size.sizeId == selectedSizeId
                                    );
                                    if (found) {
                                        document.getElementById('selectedVariantId2').value = found.productVariantId;
                                        document.getElementById('cartVariantId2').value = found.productVariantId;
                                        console.log("Selected variant ID:", found.productVariantId);
                                        console.log("Quantity Stock:", found.quantityStock);

                                        // Kiểm tra số lượng tồn kho
                                        if (found.quantityStock && found.quantityStock > 0) {
                                            stockStatus.textContent = "Còn hàng";
                                            stockStatus.className = "text-green-600";
                                            // Hiển thị số lượng tồn kho
                                            stockQuantity.textContent = "(" + found.quantityStock + " sản phẩm)";
                                            stockQuantity.className = "text-blue-600 font-medium ml-2";

                                            // Reset quantity display to 1 or max available
                                            const currentQty = parseInt(quantityDisplay.textContent);
                                            if (currentQty > found.quantityStock) {
                                                quantityDisplay.textContent = "1";
                                                document.getElementById('quantityInput2').value = 1;
                                                document.getElementById('cartQuantityInput2').value = 1;
                                            }

                                            // Enable BUY NOW button if variant is found and in stock
                                            buyNowButton.disabled = false;
                                            addToCartButton.disabled = false;
                                            addToCartButton.classList.remove('bg-gray-400', 'cursor-not-allowed');
                                            addToCartButton.classList.add('bg-black', 'hover:bg-gray-800');
                                        } else {
                                            stockStatus.textContent = "Hết hàng";
                                            stockStatus.className = "text-red-600";
                                            stockQuantity.textContent = "(0 sản phẩm)";
                                            stockQuantity.className = "text-gray-600 ml-2";

                                            // Reset quantity display
                                            quantityDisplay.textContent = "1";
                                            document.getElementById('quantityInput2').value = 1;
                                            document.getElementById('cartQuantityInput2').value = 1;

                                            // Disable both buttons if out of stock
                                            buyNowButton.disabled = true;
                                            addToCartButton.disabled = true;
                                            addToCartButton.classList.add('bg-gray-400', 'cursor-not-allowed');
                                            addToCartButton.classList.remove('bg-black', 'hover:bg-gray-800');
                                        }
                                    } else {
                                        stockStatus.textContent = "Không có sẵn";
                                        stockStatus.className = "text-gray-600";
                                        stockQuantity.textContent = "";
                                        buyNowButton.disabled = true;
                                        addToCartButton.disabled = true;
                                        addToCartButton.classList.add('bg-gray-400', 'cursor-not-allowed');
                                        addToCartButton.classList.remove('bg-black', 'hover:bg-gray-800');
                                        alert("Tổ hợp size & màu này không có sẵn!");
                                    }
                                } else {
                                    stockStatus.textContent = "Vui lòng chọn màu sắc và kích thước";
                                    stockStatus.className = "text-gray-600";
                                    stockQuantity.textContent = "";
                                    buyNowButton.disabled = true;
                                    addToCartButton.disabled = true;
                                    addToCartButton.classList.add('bg-gray-400', 'cursor-not-allowed');
                                    addToCartButton.classList.remove('bg-black', 'hover:bg-gray-800');
                                }

                                console.log("Hidden input value set to:", document.getElementById('selectedVariantId2').value);
                            }

                            // Add event listeners when the document is fully loaded
                            document.addEventListener('DOMContentLoaded', function () {
                                // Buy Now form submission for second section
                                document.getElementById('buyNowForm2').addEventListener('submit', function (e) {
                                    // Ensure values are up to date
                                    updateSelectedVariant2();

                                    const variantInput = document.getElementById('selectedVariantId2');
                                    const quantityInput = document.getElementById('quantityInput2');
                                    const quantityValue = parseInt(document.getElementById('quantityDisplay2').textContent);

                                    // Update quantity one more time to be sure
                                    quantityInput.value = quantityValue;

                                    console.log("Buy Now - Variant ID:", variantInput.value);
                                    console.log("Buy Now - Quantity:", quantityInput.value);

                                    if (!variantInput.value) {
                                        e.preventDefault();
                                        alert('Vui lòng chọn đầy đủ màu sắc và kích thước!');
                                        return false;
                                    }

                                    // Extra validation to ensure quantity is valid
                                    if (isNaN(parseInt(quantityInput.value)) || parseInt(quantityInput.value) < 1) {
                                        e.preventDefault();
                                        alert('Số lượng không hợp lệ');
                                        return false;
                                    }

                                    return true;
                                });

                                // Add to Cart form submission for second section
                                document.getElementById('addToCartForm2').addEventListener('submit', function (e) {
                                    updateSelectedVariant2(); // Update variant ID when form is submitted

                                    const variantInput = document.getElementById('cartVariantId2');
                                    console.log("Cart variant to submit:", variantInput.value);

                                    if (!variantInput.value) {
                                        e.preventDefault();
                                        alert('Vui lòng chọn đầy đủ màu sắc và kích thước!');
                                    }
                                });
                            });
                        </script>
                    </div>

                    <style>
                        /* Styles for color selection in the second product section */
                        .color-option2.selected {
                            border: 2px solid #000 !important;
                            box-shadow: 0 0 0 1px #fff, 0 0 0 3px #000;
                            transform: scale(1.1);
                        }

                        /* Styles for size selection in the second product section */
                        .size-option2.selected {
                            background-color: #000;
                            color: #fff;
                            border-color: #000;
                        }

                        /* Original styles for the first product section */
                        .color-option.selected {
                            border: 2px solid #000 !important;
                            box-shadow: 0 0 0 1px #fff, 0 0 0 3px #000;
                            transform: scale(1.1);
                        }

                        .size-option.selected {
                            background-color: #000;
                            color: #fff;
                            border-color: #000;
                        }

                        /* Image zoom effect styles */
                        .image-container {
                            position: relative;
                            overflow: hidden;
                            border-radius: 0.5rem;
                            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
                        }

                        #mainImage {
                            transition: transform 0.5s ease;
                            transform-origin: center center;
                            will-change: transform;
                        }

                        .image-container:hover #mainImage {
                            transform: scale(1.2);
                        }

                        .image-container::after {
                            content: '';
                            position: absolute;
                            top: 0;
                            left: 0;
                            right: 0;
                            bottom: 0;
                            background: rgba(0, 0, 0, 0.03);
                            opacity: 0;
                            transition: opacity 0.3s ease;
                        }

                        .image-container:hover::after {
                            opacity: 1;
                        }
                    </style>

                    <!-- footer -->
                    <jsp:include page="../layout/footer.jsp" />

                    <div class="container mx-auto px-4 py-8 bg-white">
                        <h2 class="text-2xl font-bold mb-4">Danh sách hình ảnh sản phẩm</h2>
                        <div class="overflow-x-auto">
                            <table class="min-w-full bg-white border border-gray-300">
                                <thead>
                                    <tr>
                                        <th
                                            class="px-6 py-3 bg-gray-100 text-left text-xs font-medium text-gray-700 uppercase tracking-wider border-b">
                                            ID</th>
                                        <th
                                            class="px-6 py-3 bg-gray-100 text-left text-xs font-medium text-gray-700 uppercase tracking-wider border-b">
                                            Hình ảnh</th>
                                        <th
                                            class="px-6 py-3 bg-gray-100 text-left text-xs font-medium text-gray-700 uppercase tracking-wider border-b">
                                            URL</th>
                                        <th
                                            class="px-6 py-3 bg-gray-100 text-left text-xs font-medium text-gray-700 uppercase tracking-wider border-b">
                                            Ưu tiên</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="image" items="${productImages}">
                                        <tr class="border-b hover:bg-gray-50">
                                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                                ${image.productImageId}</td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                <img src="${image.imageUrl}" alt="Product Image"
                                                    class="h-16 w-16 object-cover rounded">
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                ${image.imageUrl}</td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                <c:choose>
                                                    <c:when test="${image.priority}">
                                                        <span
                                                            class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">Có</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span
                                                            class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-gray-100 text-gray-800">Không</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>

                                    <c:if test="${empty productImages}">
                                        <tr class="border-b">
                                            <td colspan="4"
                                                class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 text-center">
                                                Không có hình ảnh nào</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <script>
                        function selectColor(el, name) {
                            document.querySelectorAll('.color-option').forEach(e => e.classList.remove('selected'));
                            el.classList.add('selected');
                            const label = document.getElementById('selectedColor');
                            if (label) label.innerText = name;
                            updateSelectedVariant();
                        }

                        function selectSize(el, name) {
                            document.querySelectorAll('.size-option').forEach(e => e.classList.remove('selected'));
                            el.classList.add('selected');
                            const label = document.getElementById('selectedSize');
                            if (label) label.innerText = name;
                            updateSelectedVariant();
                        }

                        function adjustQuantity(change) {
                            const display = document.getElementById('quantityDisplay');
                            let val = parseInt(display.innerText);
                            val = Math.max(1, val + change);
                            display.innerText = val;

                            // Update quantity for both forms
                            document.getElementById('quantityInput').value = val;
                            document.getElementById('cartQuantityInput').value = val;

                            console.log("Quantity updated to:", val);
                        }

                        function updateSelectedVariant() {
                            if (!variants || variants.length === 0) {
                                console.warn("Không có variants để xử lý.");
                                return;
                            }

                            const selectedColorId = document.querySelector('.color-option.selected')?.dataset.colorId;
                            const selectedSizeId = document.querySelector('.size-option.selected')?.dataset.sizeId;
                            const buyNowButton = document.getElementById('buyNowButton');

                            // Disable BUY NOW button by default
                            buyNowButton.disabled = true;

                            if (selectedColorId && selectedSizeId) {
                                const found = variants.find(v =>
                                    v.color.colorId == selectedColorId && v.size.sizeId == selectedSizeId
                                );
                                if (found) {
                                    document.getElementById('selectedVariantId').value = found.productVariantId;
                                    document.getElementById('cartVariantId').value = found.productVariantId;
                                    console.log("Selected variant ID:", found.productVariantId);

                                    // Enable BUY NOW button if variant is found
                                    buyNowButton.disabled = false;
                                } else {
                                    alert("Tổ hợp size & màu này không có sẵn!");
                                }
                            }

                            console.log("Hidden input value set to:", document.getElementById('selectedVariantId').value);
                        }

                        // Add event listeners when the document is fully loaded
                        document.addEventListener('DOMContentLoaded', function () {
                            // Xử lý khi trang vừa được tải
                            try {
                                const rawJson = document.getElementById("variantsData").textContent.trim();
                                variants = JSON.parse(rawJson);
                                console.log("Variants loaded:", variants);

                                // Kiểm tra tình trạng hàng hóa khi trang được tải
                                checkInitialStockStatus();
                            } catch (e) {
                                console.error("Lỗi khi parse variantsJson:", e);
                            }

                            // Buy Now form submission
                            document.getElementById('buyNowForm').addEventListener('submit', function (e) {
                                // Ensure values are up to date
                                updateSelectedVariant();

                                const variantInput = document.getElementById('selectedVariantId');
                                const quantityInput = document.getElementById('quantityInput');
                                const quantityValue = parseInt(document.getElementById('quantityDisplay').textContent);

                                // Update quantity one more time to be sure
                                quantityInput.value = quantityValue;

                                console.log("Buy Now - Variant ID:", variantInput.value);
                                console.log("Buy Now - Quantity:", quantityInput.value);

                                if (!variantInput.value) {
                                    e.preventDefault();
                                    alert('Vui lòng chọn đầy đủ màu sắc và kích thước!');
                                    return false;
                                }

                                // Extra validation to ensure quantity is valid
                                if (isNaN(parseInt(quantityInput.value)) || parseInt(quantityInput.value) < 1) {
                                    e.preventDefault();
                                    alert('Số lượng không hợp lệ');
                                    return false;
                                }

                                return true;
                            });

                            // Add to Cart form submission
                            document.getElementById('addToCartForm').addEventListener('submit', function (e) {
                                updateSelectedVariant(); // Update variant ID when form is submitted

                                const variantInput = document.getElementById('cartVariantId');
                                console.log("Cart variant to submit:", variantInput.value);

                                if (!variantInput.value) {
                                    e.preventDefault();
                                    alert('Vui lòng chọn đầy đủ màu sắc và kích thước!');
                                }
                            });
                        });
                    </script>
                </body>

                </html>