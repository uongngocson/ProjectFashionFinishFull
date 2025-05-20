<%@page contentType="text/html" pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Checkout | Luxury Boutique</title>
                <!-- This page uses customerAddressesv2 from the model for address data
                     - Loads customer addresses on page load from hidden input field
                     - Parses the Addressv2 format
                     - Displays address information in the address selection modal
                     - Updates the main address display when an address is selected
                     - Saves selected address to localStorage for persistence -->
                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <script src="https://cdn.tailwindcss.com"></script>
                <!-- Google Fonts -->
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap" rel="stylesheet">
                <link rel="stylesheet"
                    href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600&family=Montserrat:wght@300;400;500&display=swap">
                <link rel="stylesheet" href="${ctx}/resources/assets/client/css/order.css">
                <!-- jQuery for AJAX requests -->
                <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
                <!-- Axios for API calls -->
                <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

                <!-- CSRF tokens for AJAX requests -->
                <meta name="_csrf" content="${_csrf.token}" />
                <meta name="_csrf_header" content="${_csrf.headerName}" />

                <style>
                    #shipping-fee-result {
                        background-color: #d1fae5;
                        border: 1px solid #10b981;
                        padding: 12px;
                        margin-top: 16px;
                        border-radius: 6px;
                        font-weight: 500;
                    }

                    #shipping-fee-result.visible {
                        display: block !important;
                    }

                    #calculateShippingBtn {
                        margin-top: 16px;
                        font-weight: 500;
                    }

                    /* Discount Code Styles */
                    .discount-trigger {
                        position: relative;
                    }

                    /* Add pseudo-element to bridge the gap between trigger and tooltip */
                    .discount-trigger::after {
                        content: "";
                        position: absolute;
                        height: 20px;
                        width: 100%;
                        bottom: -10px;
                        left: 0;
                        z-index: 40;
                    }

                    .discount-tooltip {
                        position: absolute;
                        top: calc(100% + 10px);
                        left: 0;
                        z-index: 50;
                        width: 500px;
                        transform-origin: top left;
                        background-color: white;
                        border-radius: 0.375rem;
                        box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
                        border: 1px solid rgba(0, 0, 0, 0.1);
                        opacity: 0;
                        visibility: hidden;
                        transition: opacity 0.2s ease, visibility 0.2s ease;
                    }

                    .discount-trigger:hover .discount-tooltip {
                        opacity: 1;
                        visibility: visible;
                    }

                    .discount-pill {
                        background-color: #fee2e2;
                        color: #dc2626;
                        padding: 0.25rem 0.75rem;
                        border-radius: 9999px;
                        font-size: 0.875rem;
                        cursor: pointer;
                        transition: background-color 0.2s ease;
                    }

                    .discount-pill:hover,
                    .discount-pill.active {
                        background-color: #fecaca;
                    }

                    /* Toast notification style */
                    .toast-notification {
                        position: fixed;
                        bottom: 1rem;
                        right: 1rem;
                        padding: 0.5rem 1rem;
                        border-radius: 0.25rem;
                        color: white;
                        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
                        z-index: 50;
                        opacity: 0;
                        transform: translateY(10px);
                        animation: toast-in 0.3s ease forwards, toast-out 0.3s ease 2.7s forwards;
                    }

                    @keyframes toast-in {
                        from {
                            opacity: 0;
                            transform: translateY(10px);
                        }

                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }

                    @keyframes toast-out {
                        from {
                            opacity: 1;
                            transform: translateY(0);
                        }

                        to {
                            opacity: 0;
                            transform: translateY(10px);
                        }
                    }

                    /* Thêm CSS style cho validation */
                    .input-field.border-red-500 {
                        border: 1px solid #f56565;
                    }

                    .error-message {
                        color: #f56565;
                        font-size: 0.75rem;
                        margin-top: 0.25rem;
                    }

                    #test-order-data:disabled {
                        cursor: not-allowed;
                        opacity: 0.7;
                    }
                </style>
            </head>




            <body class="min-h-screen">
                <!-- navbar -->
                <jsp:include page="../layout/navbar.jsp" />

                <!-- Hidden input for addresses data -->
                <input type="hidden" id="formatted-addresses-data" value="<c:out value='${customerAddressesv2}' />" />



                <!-- Header -->
                <header class="text-center mb-12 pt-[64px]">
                    <h1 class="serif text-4xl font-medium mb-2">Checkout</h1>
                    <p class="text-gray-500">Complete your purchase with elegance</p>
                </header>

                <!-- Main Content Grid -->
                <div class="grid checkout-grid gap-12 md:grid-cols-2">
                    <!-- Left Column - Billing & Shipping -->
                    <div class="space-y-8 p-[40px]">
                        <!-- Contact Information -->
                        <section>
                            <h2 class="serif text-xl font-medium mb-6 pb-2 border-b border-gray-200">Contact Information
                            </h2>
                            <div class="space-y-4">
                                <div>
                                    <label for="fullName" class="block text-sm text-gray-600 mb-1">Full Name</label>
                                    <input type="text" id="fullName" class="input-field w-full py-2 px-1 bg-transparent"
                                        placeholder="John Smith" value="${customer.firstName} ${customer.lastName}">
                                </div>
                                <!-- Hidden field for customer ID -->
                                <input type="hidden" id="customerId" value="${customer.customerId}">
                                <div>
                                    <label for="email" class="block text-sm text-gray-600 mb-1">Email Address</label>
                                    <input type="email" id="email" class="input-field w-full py-2 px-1 bg-transparent"
                                        placeholder="john@example.com" value="${customer.email}">
                                </div>
                                <div>
                                    <label for="phone" class="block text-sm text-gray-600 mb-1">Phone Number</label>
                                    <input type="tel" id="phone" class="input-field w-full py-2 px-1 bg-transparent"
                                        placeholder="+1 (123) 456-7890" value="${customer.phone}">
                                </div>
                            </div>
                        </section>


                        <!-- Địa Chỉ Nhận Hàng Section -->
                        <section>
                            <h2 class="serif text-xl font-medium mb-6 pb-2 border-b border-gray-200">Địa Chỉ Nhận Hàng
                            </h2>

                            <!-- Default Address Display -->
                            <div class="w-full p-4 border rounded-md bg-gray-50">
                                <div class="flex items-start justify-between">
                                    <div>
                                        <div class="flex items-center mb-2">
                                            <span class="font-medium text-lg" id="recipient-name">Uông Ngọc Sơn</span>
                                            <span class="ml-3 text-sm text-gray-500" id="recipient-phone">(+84) 368 341
                                                404</span>
                                        </div>
                                        <p class="text-gray-700 mb-1" id="recipient-address">125/10 Đường Lê Đức Thọ
                                            Phương 17, Phường 17, Quận Gò Vấp, TP. Hồ Chí Minh</p>
                                        <span
                                            class="inline-block px-2 py-1 bg-red-100 text-red-800 text-xs font-medium rounded mt-2">Mặc
                                            Định</span>
                                    </div>
                                    <button id="change-address-btn"
                                        class="text-blue-600 hover:text-blue-800 font-medium">Thay Đổi</button>
                                </div>
                            </div>

                            <!-- GHN Shipping Form (initially hidden) -->
                            <div id="shipping-form" class="space-y-4 mt-6" style="display: none;">
                                <!-- Error and Loading Containers -->
                                <div id="error-container"
                                    class="bg-red-100 border border-red-400 text-black px-4 py-3 rounded mb-4"
                                    style="display: none;"></div>

                                <div id="loading-container"
                                    class="bg-blue-100 border border-blue-400 text-black px-4 py-3 rounded mb-4"
                                    style="display: none;">
                                    Loading...
                                </div>

                                <!-- Personal Information Fields -->
                                <div class="mb-4">
                                    <h3 class="font-medium mb-2 text-black">Thông tin cá nhân</h3>
                                    <div class="grid grid-cols-2 gap-4">
                                        <div>
                                            <label for="fullNameEdit" class="block text-sm text-gray-600 mb-1">Họ
                                                Tên</label>
                                            <input type="text" id="fullNameEdit"
                                                class="input-field w-full py-2 px-1 bg-transparent"
                                                placeholder="Nguyễn Văn A">
                                        </div>
                                        <div>
                                            <label for="phoneEdit" class="block text-sm text-gray-600 mb-1">Số điện
                                                thoại</label>
                                            <input type="tel" id="phoneEdit"
                                                class="input-field w-full py-2 px-1 bg-transparent"
                                                placeholder="(+84) 123 456 789">
                                        </div>
                                    </div>
                                </div>

                                <!-- Shop Address Section -->
                                <div class="mb-4">
                                    <h3 class="font-medium mb-2 text-black">Địa chỉ shop:</h3>
                                    <div class="grid grid-cols-2 gap-4">
                                        <div>
                                            <label for="fromProvince"
                                                class="block text-sm text-gray-600 mb-1">Tỉnh/Thành phố</label>
                                            <select id="fromProvince"
                                                class="input-field w-full py-2 px-1 bg-transparent">
                                                <option value="">Đang tải...</option>
                                            </select>
                                        </div>
                                        <div>
                                            <label for="fromDistrict"
                                                class="block text-sm text-gray-600 mb-1">Quận/Huyện</label>
                                            <select id="fromDistrict"
                                                class="input-field w-full py-2 px-1 bg-transparent">
                                                <option value="">Đang tải...</option>
                                            </select>
                                        </div>
                                        <div>
                                            <label for="fromWard"
                                                class="block text-sm text-gray-600 mb-1">Phường/Xã</label>
                                            <select id="fromWard" class="input-field w-full py-2 px-1 bg-transparent">
                                                <option value="">Đang tải...</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <!-- Shipping Address Section -->
                                <div class="mb-4">
                                    <h3 class="font-medium mb-2 text-black">Địa chỉ nhận hàng</h3>
                                    <div class="grid grid-cols-2 gap-4">
                                        <div>
                                            <label for="toProvince" class="block text-sm text-gray-600 mb-1">Tỉnh/Thành
                                                phố</label>
                                            <select id="toProvince" class="input-field w-full py-2 px-1 bg-transparent">
                                                <option value="">Chọn Tỉnh/TP</option>
                                            </select>
                                        </div>
                                        <div>
                                            <label for="toDistrict"
                                                class="block text-sm text-gray-600 mb-1">Quận/Huyện</label>
                                            <select id="toDistrict" class="input-field w-full py-2 px-1 bg-transparent"
                                                disabled>
                                                <option value="">Đang tải...</option>
                                            </select>
                                        </div>
                                        <div>
                                            <label for="toWard"
                                                class="block text-sm text-gray-600 mb-1">Phường/Xã</label>
                                            <select id="toWard" class="input-field w-full py-2 px-1 bg-transparent"
                                                disabled>
                                                <option value="">Đang tải...</option>
                                            </select>
                                        </div>
                                        <div>
                                            <label for="detailAddress" class="block text-sm text-gray-600 mb-1">Địa chỉ
                                                chi tiết</label>
                                            <input type="text" id="detailAddress"
                                                class="input-field w-full py-2 px-1 bg-transparent"
                                                placeholder="Số nhà, tên đường...">
                                        </div>
                                    </div>
                                </div>

                                <!-- Action Buttons -->
                                <div class="flex flex-wrap gap-2">
                                    <button type="button" id="calculateShippingBtn"
                                        class="bg-blue-500 hover:bg-blue-600 text-white font-medium py-2 px-4 rounded">
                                        Tính phí vận chuyển
                                    </button>

                                    <button type="button" id="saveAddressBtn"
                                        class="bg-green-500 hover:bg-green-600 text-white font-medium py-2 px-4 rounded">
                                        Lưu địa chỉ
                                    </button>
                                </div>

                                <!-- Shipping Fee Result (initially hidden) -->
                                <div id="shipping-fee-result" class="mt-4 p-4 bg-green-100 rounded-md"
                                    style="display: none;"></div>
                            </div>

                            <script>
                                document.addEventListener('DOMContentLoaded', function () {
                                    // Storage for currently selected address ID to maintain selection state
                                    let currentlySelectedAddressId = null;

                                    // Function to extract current address ID from localStorage
                                    function setCurrentSelectedAddressId() {
                                        try {
                                            const storedAddress = localStorage.getItem('selectedAddress');
                                            if (storedAddress) {
                                                const addressData = JSON.parse(storedAddress);
                                                currentlySelectedAddressId = addressData.addressId;
                                                console.log('Set current selected address ID to:', currentlySelectedAddressId);
                                            }
                                        } catch (e) {
                                            console.error('Error getting current address ID:', e);
                                        }
                                    }

                                    // Call this function on page load
                                    setCurrentSelectedAddressId();

                                    // Elements for address display and change
                                    const changeAddressBtn = document.getElementById('change-address-btn');
                                    const addressModal = document.getElementById('address-modal');
                                    const shippingForm = document.getElementById('shipping-form');
                                    const recipientName = document.getElementById('recipient-name');
                                    const recipientPhone = document.getElementById('recipient-phone');
                                    const recipientAddress = document.getElementById('recipient-address');

                                    // Elements for closing/confirming address modal
                                    const closeModalBtn = document.getElementById('close-modal');
                                    const cancelAddressBtn = document.getElementById('cancel-address');
                                    const confirmAddressBtn = document.getElementById('confirm-address');

                                    // Elements for calculating shipping
                                    const calculateShippingBtn = document.getElementById('calculateShippingBtn');
                                    const saveAddressBtn = document.getElementById('saveAddressBtn');

                                    // Initialize function to load addresses from formatted-addresses-data
                                    function initializeAddresses() {
                                        const addressesData = document.getElementById('formatted-addresses-data');
                                        if (addressesData && addressesData.value) {
                                            try {
                                                // Try parsing the formatted address data
                                                const addresses = JSON.parse(addressesData.value);

                                                // If we have default address, display it
                                                if (addresses && addresses.length > 0) {
                                                    const defaultAddress = addresses.find(addr => addr.isDefault) || addresses[0];
                                                    if (defaultAddress) {
                                                        if (recipientName) recipientName.textContent = defaultAddress.recipientName || '';
                                                        if (recipientPhone) recipientPhone.textContent = defaultAddress.recipientPhone || '';
                                                        if (recipientAddress) {
                                                            const addressDetail = [
                                                                defaultAddress.detailAddress,
                                                                defaultAddress.wardName,
                                                                defaultAddress.districtName,
                                                                defaultAddress.provinceName
                                                            ].filter(Boolean).join(', ');
                                                            recipientAddress.textContent = addressDetail;
                                                        }

                                                        // Set the current selected address ID
                                                        currentlySelectedAddressId = defaultAddress.addressId;
                                                    }
                                                }
                                            } catch (e) {
                                                console.error('Error parsing addresses data:', e);
                                            }
                                        }
                                    }

                                    // If change address button exists, add event listener
                                    if (changeAddressBtn) {
                                        changeAddressBtn.addEventListener('click', function () {
                                            if (addressModal) {
                                                // Show the modal without changing the main view address
                                                addressModal.classList.remove('hidden');
                                                document.body.style.overflow = 'hidden'; // Prevent scrolling

                                                // Store current address display values to restore if canceled
                                                window.currentAddressState = {
                                                    name: recipientName ? recipientName.textContent : '',
                                                    phone: recipientPhone ? recipientPhone.textContent : '',
                                                    address: recipientAddress ? recipientAddress.textContent : ''
                                                };

                                                console.log('Saved current address state before modal open:', window.currentAddressState);

                                                // Ensure the correct address is visually selected in the modal
                                                setTimeout(() => {
                                                    const addressOptions = document.querySelectorAll('.address-option');
                                                    let foundSelected = false;

                                                    addressOptions.forEach(option => {
                                                        const addressId = option.getAttribute('data-address-id');

                                                        // Clear all selections first
                                                        option.classList.remove('selected', 'border-blue-500', 'border-orange-500');
                                                        option.classList.add('border-gray-200');

                                                        // Update the indicator circle
                                                        const circle = option.querySelector('.w-3.h-3');
                                                        if (circle) {
                                                            circle.classList.remove('bg-blue-500');
                                                            circle.classList.add('bg-transparent');
                                                        }

                                                        // If this is the currently selected address, mark it
                                                        if (addressId === currentlySelectedAddressId) {
                                                            option.classList.add('selected', 'border-blue-500');
                                                            option.classList.remove('border-gray-200');

                                                            // Update the indicator circle
                                                            if (circle) {
                                                                circle.classList.add('bg-blue-500');
                                                                circle.classList.remove('bg-transparent');
                                                            }

                                                            foundSelected = true;
                                                        }
                                                    });

                                                    console.log('Updated address selections in modal, found current address:', foundSelected);
                                                }, 100);
                                            }
                                        });
                                    }

                                    // Close modal function
                                    function closeModal(confirmed = false) {
                                        if (addressModal) {
                                            addressModal.classList.add('hidden');
                                            document.body.style.overflow = 'auto'; // Re-enable scrolling

                                            // If not confirmed (modal was canceled), restore original address display
                                            if (!confirmed && window.currentAddressState) {
                                                if (recipientName) recipientName.textContent = window.currentAddressState.name;
                                                if (recipientPhone) recipientPhone.textContent = window.currentAddressState.phone;
                                                if (recipientAddress) recipientAddress.textContent = window.currentAddressState.address;
                                                console.log('Restored original address state after modal canceled');
                                            }
                                        }
                                    }

                                    // Add close event listeners
                                    if (closeModalBtn) closeModalBtn.addEventListener('click', () => closeModal(false));
                                    if (cancelAddressBtn) cancelAddressBtn.addEventListener('click', () => closeModal(false));

                                    // Add confirm event listener (actual implementation is in handle.jsp)
                                    if (confirmAddressBtn) {
                                        confirmAddressBtn.addEventListener('click', function () {
                                            // Get the selected address ID from the modal
                                            const selectedAddressId = window.selectedAddressId;

                                            // If no address was selected, just close the modal
                                            if (!selectedAddressId) {
                                                console.log('No address selected, closing modal without changes');
                                                closeModal(false);
                                                return;
                                            }

                                            // Store this as the current address ID for future reference
                                            currentlySelectedAddressId = selectedAddressId;

                                            // The actual implementation for confirming address selection
                                            // is in handle.jsp, this just ensures the event is properly connected
                                            console.log('Confirmed address selection, ID:', selectedAddressId);
                                            closeModal(true); // Pass true to indicate confirmation
                                        });
                                    }

                                    // Ensure shipping fee result shows properly when calculated
                                    if (calculateShippingBtn) {
                                        calculateShippingBtn.addEventListener('click', function () {
                                            // The actual implementation for calculating shipping is in handle.jsp
                                            // This ensures the UI updates correctly
                                            const shippingFeeResult = document.getElementById('shipping-fee-result');
                                            if (shippingFeeResult) {
                                                // Ensure the shipping fee calculation is visible
                                                shippingFeeResult.classList.add('visible');
                                            }
                                        });
                                    }

                                    // Initialize addresses on page load
                                    initializeAddresses();
                                });
                            </script>

                            <!-- Address Selection Modal -->
                            <div id="address-modal"
                                class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 hidden">
                                <div class="bg-white rounded-lg w-full max-w-2xl max-h-[80vh] overflow-y-auto">
                                    <div class="p-6 border-b">
                                        <div class="flex justify-between items-center">
                                            <h3 class="text-xl font-medium">Địa Chỉ Của Tôi</h3>
                                            <button id="close-modal" class="text-gray-500 hover:text-gray-700">
                                                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none"
                                                    viewBox="0 0 24 24" stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                                                </svg>
                                            </button>
                                        </div>
                                    </div>

                                    <div class="p-6" id="address-list-container">
                                        <!-- Address options will be populated dynamically here -->
                                    </div>

                                    <div class="p-6 border-t flex justify-end">
                                        <button id="cancel-address"
                                            class="border border-gray-300 rounded-md px-6 py-2 mr-3 hover:bg-gray-50">Huỷ</button>
                                        <button id="confirm-address"
                                            class="bg-orange-500 text-white rounded-md px-6 py-2 hover:bg-orange-600">Xác
                                            nhận</button>
                                    </div>
                                </div>

                                <script>
                                    document.addEventListener('DOMContentLoaded', function () {
                                        // Get the address list container
                                        const addressListContainer = document.getElementById('address-list-container');

                                        // Function to check if container is empty and add placeholder
                                        function initializeAddressListContainer() {
                                            if (addressListContainer && addressListContainer.children.length === 0) {
                                                // Set placeholder if empty
                                                addressListContainer.innerHTML = `
                                                    <div class="text-center py-8 text-gray-500">
                                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-12 w-12 mx-auto mb-4 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                                                        </svg>
                                                        <p class="mb-2 font-medium">Không tìm thấy địa chỉ</p>
                                                        <p class="text-sm">Bạn chưa có địa chỉ nào. Nhấn "Thay Đổi" và thêm địa chỉ mới.</p>
                                                    </div>
                                                `;
                                            }
                                        }

                                        // Setup click delegation for address options
                                        if (addressListContainer) {
                                            addressListContainer.addEventListener('click', function (e) {
                                                const addressElement = e.target.closest('.address-option');

                                                if (addressElement) {
                                                    // Get the address ID
                                                    const addressId = addressElement.getAttribute('data-address-id');

                                                    // Store the selected address ID for later use, but don't update display yet
                                                    window.selectedAddressId = addressId;

                                                    // Deselect all other address options
                                                    document.querySelectorAll('.address-option').forEach(option => {
                                                        option.classList.remove('selected', 'border-blue-500');
                                                        option.classList.add('border-gray-200');

                                                        // Update the indicator circle inside each option
                                                        const circle = option.querySelector('.w-3.h-3');
                                                        if (circle) {
                                                            circle.classList.remove('bg-blue-500');
                                                            circle.classList.add('bg-transparent');
                                                        }
                                                    });

                                                    // Select the clicked address
                                                    addressElement.classList.add('selected', 'border-blue-500');
                                                    addressElement.classList.remove('border-gray-200');

                                                    // Update the indicator circle
                                                    const circle = addressElement.querySelector('.w-3.h-3');
                                                    if (circle) {
                                                        circle.classList.add('bg-blue-500');
                                                        circle.classList.remove('bg-transparent');
                                                    }

                                                    console.log('Selected address ID in modal:', addressId, '(Not yet confirmed)');
                                                }
                                            });
                                        }

                                        // Initialize on page load
                                        initializeAddressListContainer();

                                        // Also re-initialize when modal is opened
                                        document.getElementById('change-address-btn')?.addEventListener('click', function () {
                                            // Short delay to ensure container is ready
                                            setTimeout(initializeAddressListContainer, 100);
                                        });
                                    });
                                </script>
                            </div>



                            <!-- Billing Address bỏ phần này để nguyên không xóa -->
                            <section>
                                <h2 class="serif text-xl font-medium mb-6 pb-2 border-b border-gray-200 hidden">Billing
                                    Address
                                </h2>
                                <div class="flex items-center mb-4">
                                    <input type="checkbox" id="sameAsShipping" class="mr-2 hidden">
                                    <label for="sameAsShipping" class="text-sm text-gray-600 hidden">Same as shipping
                                        address</label>
                                </div>
                                <div id="billingFields" class="space-y-4 hidden">
                                    <div>
                                        <label for="billingAddress" class="block text-sm text-gray-600 mb-1">Street
                                            Address</label>
                                        <input type="text" id="billingAddress"
                                            class="input-field w-full py-2 px-1 bg-transparent"
                                            placeholder="123 Main St">
                                    </div>
                                    <div class="grid grid-cols-2 gap-4">
                                        <div>
                                            <label for="billingCity"
                                                class="block text-sm text-gray-600 mb-1">City</label>
                                            <input type="text" id="billingCity"
                                                class="input-field w-full py-2 px-1 bg-transparent"
                                                placeholder="New York">
                                        </div>
                                        <div>
                                            <label for="billingState"
                                                class="block text-sm text-gray-600 mb-1">State/Province</label>
                                            <input type="text" id="billingState"
                                                class="input-field w-full py-2 px-1 bg-transparent" placeholder="NY">
                                        </div>
                                    </div>
                                    <div class="grid grid-cols-2 gap-4">
                                        <div>
                                            <label for="billingPostalCode"
                                                class="block text-sm text-gray-600 mb-1">Postal
                                                Code</label>
                                            <input type="text" id="billingPostalCode"
                                                class="input-field w-full py-2 px-1 bg-transparent" placeholder="10001">
                                        </div>
                                        <div>
                                            <label for="billingCountry"
                                                class="block text-sm text-gray-600 mb-1">Country</label>
                                            <select id="billingCountry"
                                                class="input-field w-full py-2 px-1 bg-transparent">
                                                <option value="">Select Country</option>
                                                <option value="US">United States</option>
                                                <option value="UK">United Kingdom</option>
                                                <option value="CA">Canada</option>
                                                <option value="AU">Australia</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </section>

                            <!-- Payment Method -->
                            <section>
                                <h2 class="serif text-xl font-medium mb-6 pb-2 border-b border-gray-200">Payment Method
                                </h2>
                                <div class="space-y-4">
                                    <div id="payment-method-1" class="payment-method p-4 border rounded cursor-pointer">
                                        <div class="flex items-center">
                                            <div
                                                class="w-8 h-8 rounded-full border flex items-center justify-center mr-3">
                                                <div class="w-4 h-4 rounded-full bg-transparent"></div>
                                            </div>
                                            <span hidden>1</span>
                                            <div>Thanh toán online</div>

                                        </div>
                                    </div>

                                    <div id="payment-method-2" class="payment-method p-4 border rounded cursor-pointer">
                                        <div class="flex items-center">
                                            <div
                                                class="w-8 h-8 rounded-full border flex items-center justify-center mr-3">
                                                <div class="w-4 h-4 rounded-full bg-transparent"></div>
                                            </div>
                                            <span hidden>2</span>

                                            <div>Thanh toán khi nhận hàng</div>
                                        </div>
                                    </div>
                                </div>
                            </section>


                    </div>

                    <!-- Right Column - Order Summary -->
                    <div>
                        <div class="bg-white p-6 shadow-sm">
                            <h2 class="serif text-xl font-medium mb-6 pb-2 border-b border-gray-200">Order Summary</h2>

                            <!-- Cart Items -->
                            <div class="space-y-4 mb-6">
                                <c:forEach items="${items}" var="item">
                                    <div class="flex items-center py-3 border-b border-gray-100"
                                        data-product-id="${item.variant.product.productId}">
                                        <div class="w-16 h-16 bg-gray-100 mr-4">
                                            <img src="${item.variant.imageUrl}"
                                                alt="${item.variant.product.productName}"
                                                data-variant-id="${item.variant.productVariantId}"
                                                data-product-id="${item.variant.product.productId}"
                                                class="w-full h-full object-cover">
                                        </div>
                                        <div class="flex-1">
                                            <h3 class="text-sm font-medium"
                                                data-product-id="${item.variant.product.productId}">
                                                ${item.variant.product.productName}
                                            </h3>
                                            <p class="text-xs text-gray-500">${item.variant.color.colorName} /
                                                ${item.variant.size.sizeName}</p>
                                        </div>
                                        <div class="text-right">
                                            <p class="text-sm">$${item.variant.product.price}</p>
                                            <p class="text-xs text-gray-500">Qty: ${item.quantity}</p>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- Promo Code -->
                            <div id="promo-code-section" class="promo-section mb-8">
                                <label for="promo-code" class="block text-sm text-gray-600 mb-2">
                                    Mã Giảm Giá
                                </label>
                                <div class="promo-input-container flex mb-4">
                                    <input type="text" id="promo-code" name="promo-code"
                                        class="promo-input flex-1 border border-gray-200 px-5 py-3 text-sm focus:outline-none focus:border-black focus:ring-1 focus:ring-black rounded-l"
                                        placeholder="Nhập mã giảm giá">
                                    <button id="apply-promo-code-btn"
                                        class="promo-apply-btn bg-black text-white px-8 py-3 text-sm font-medium hover:bg-gray-800 transition-colors rounded-r">
                                        Áp Dụng
                                    </button>
                                </div>

                                <!-- Applied Promo Code Display -->
                                <div id="applied-promo-container" class="applied-promo-display hidden mt-3 mb-5">
                                    <div
                                        class="promo-badge flex items-center bg-blue-50 text-sm rounded-lg py-3 px-4 w-full">
                                        <span class="text-blue-600 font-medium" id="applied-promo-text"></span>
                                        <button id="remove-promo-btn"
                                            class="promo-remove-btn ml-4 text-gray-500 hover:text-red-500">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                                                viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M6 18L18 6M6 6l12 12" />
                                            </svg>
                                        </button>
                                    </div>
                                </div>

                                <div id="shop-discount-container" class="relative inline-block discount-trigger w-full">
                                    <div id="shop-discount-trigger"
                                        class="shop-discount-label flex items-center text-sm cursor-pointer text-blue-600 hover:text-blue-800">
                                        <span>Mã Giảm Giá Của Shop</span>
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1" fill="none"
                                            viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M19 9l-7 7-7-7" />
                                        </svg>
                                    </div>
                                    <div id="shop-discount-tooltip"
                                        class="discount-tooltip hidden absolute z-10 bg-white rounded-md shadow-lg border border-gray-200 w-96 left-0 mt-2">
                                        <div class="discount-tooltip-header py-3 px-4 text-sm text-gray-700">
                                            <p class="font-medium">Mã giảm giá của Shop</p>
                                            <p class="text-xs mt-1 text-gray-500">Tiết kiệm hơn khi áp dụng mã giảm
                                                giá của Shop. Liên hệ với Shop nếu gặp trục trặc về mã giảm giá do
                                                Shop tự tạo.</p>
                                        </div>
                                        <div class="py-2 px-3 max-h-[300px] overflow-y-auto" id="discount-list">
                                            <!-- Discount items will be populated dynamically -->
                                            <div class="p-4 text-center text-gray-500">Đang tải mã giảm giá...</div>
                                        </div>
                                    </div>

                                    <!-- Discount Pills -->
                                    <div class="flex flex-wrap gap-2 mt-3" id="discount-pills">
                                        <!-- Discount pills will be populated dynamically -->
                                    </div>
                                </div>
                            </div>

                            <script>
                                document.addEventListener('DOMContentLoaded', function () {
                                    // CSRF Token
                                    const csrfToken = document.querySelector('meta[name="_csrf"]')?.content;
                                    const csrfHeader = document.querySelector('meta[name="_csrf_header"]')?.content;

                                    // Current customer info
                                    const customerId = "${sessionScope.customerId}";
                                    const accountId = "${sessionScope.accountId}";

                                    // Get context path
                                    const contextPath = "${ctx}";

                                    // Array to store applied discount codes - make it globally accessible
                                    window.appliedDiscounts = [];

                                    // Toggle discount tooltip
                                    const discountTrigger = document.querySelector('.discount-trigger');
                                    const discountTooltip = document.querySelector('.discount-tooltip');

                                    if (discountTrigger && discountTooltip) {
                                        const triggerElement = discountTrigger.querySelector('div');

                                        triggerElement.addEventListener('click', function (e) {
                                            e.stopPropagation();

                                            // If tooltip is being shown, fetch discounts
                                            if (discountTooltip.classList.contains('hidden')) {
                                                fetchAvailableDiscounts();
                                            }

                                            // Toggle visibility
                                            discountTooltip.classList.toggle('hidden');
                                        });

                                        // Close tooltip when clicking outside
                                        document.addEventListener('click', function (e) {
                                            if (!discountTrigger.contains(e.target)) {
                                                discountTooltip.classList.add('hidden');
                                            }
                                        });
                                    }

                                    // Apply promo code button
                                    const applyPromoBtn = document.getElementById('apply-promo-code-btn');
                                    const promoInput = document.getElementById('promo-code');
                                    const appliedPromoContainer = document.getElementById('applied-promo-container');
                                    const appliedPromoText = document.getElementById('applied-promo-text');
                                    const removePromoBtn = document.getElementById('remove-promo-btn');

                                    if (applyPromoBtn && promoInput) {
                                        applyPromoBtn.addEventListener('click', function () {
                                            const promoCode = promoInput.value.trim();
                                            if (!promoCode) {
                                                alert('Vui lòng nhập mã giảm giá');
                                                return;
                                            }

                                            // Check if the entered promo code matches any available discount codes
                                            let foundMatchingDiscount = false;
                                            let matchingVariantId = null;
                                            let matchingPill = null;

                                            // Search in discount pills which contain all available discounts
                                            document.querySelectorAll('.discount-pill').forEach(pill => {
                                                const pillCode = pill.getAttribute('data-code');
                                                if (pillCode && pillCode.toLowerCase() === promoCode.toLowerCase()) {
                                                    foundMatchingDiscount = true;
                                                    matchingVariantId = pill.getAttribute('data-product-variant-id') || null;
                                                    matchingPill = pill;
                                                }
                                            });

                                            if (foundMatchingDiscount && matchingPill) {
                                                // Valid code found - apply it
                                                matchingPill.classList.add('active', 'ring-2', 'ring-blue-400');
                                                applyPromoCode(promoCode, matchingVariantId);
                                                showToast('Đã áp dụng mã giảm giá: ' + promoCode);
                                            } else {
                                                // Invalid code - show error message and DO NOT apply
                                                showToast('Mã giảm giá không hợp lệ hoặc không áp dụng được cho đơn hàng này', false);
                                                console.log('Invalid promo code:', promoCode);
                                            }

                                            // Clear the input field
                                            promoInput.value = '';
                                        });
                                    }

                                    if (removePromoBtn) {
                                        // Main remove button - removes all discounts
                                        removePromoBtn.addEventListener('click', function () {
                                            // Remove all discounts at once
                                            window.appliedDiscounts.length = 0; // Clear the array

                                            // Remove highlighting from all pills
                                            document.querySelectorAll('.discount-pill').forEach(pill => {
                                                pill.classList.remove('active', 'ring-2', 'ring-blue-400');
                                            });

                                            // Hide the container
                                            appliedPromoContainer.classList.add('hidden');

                                            // Hide the discount row
                                            document.querySelector('.discount-row')?.classList.add('hidden');

                                            // Reset total back to original value but include shipping fee
                                            const subtotalElement = document.getElementById('cart-subtotal');
                                            const totalElement = document.getElementById('total-with-discount');
                                            if (subtotalElement && totalElement) {
                                                const subtotal = parseFloat(subtotalElement.textContent.replace('$', ''));

                                                // Get shipping fee value from window.ghnState (same as in updateOrderTotalWithMultipleDiscounts)
                                                const shippingFee = (window.ghnState && window.ghnState.shippingFeeValue !== null) ? window.ghnState.shippingFeeValue : 0;
                                                console.log('shippingFee--------------------------', shippingFee);
                                                // Calculate total with shipping fee included
                                                const newTotal = subtotal + shippingFee;
                                                totalElement.textContent = '$' + newTotal.toFixed(2);
                                            }

                                            // Hide any discount display message
                                            const discountDisplay = document.getElementById('discount-display');
                                            if (discountDisplay) discountDisplay.classList.add('hidden');

                                            // Show feedback
                                            showToast('Đã xóa tất cả mã giảm giá');
                                            console.log('Removed all promo codes');
                                        });

                                        // Event delegation for individual remove buttons
                                        appliedPromoContainer.addEventListener('click', function (e) {
                                            // Check if the click was on a remove-code-btn or its child
                                            const removeBtn = e.target.closest('.remove-code-btn');
                                            if (!removeBtn) return;

                                            const codeToRemove = removeBtn.getAttribute('data-code');
                                            const variantId = removeBtn.getAttribute('data-variant-id');

                                            if (!codeToRemove) return;

                                            // Find and remove the discount
                                            const index = window.appliedDiscounts.findIndex(d =>
                                                d.code === codeToRemove &&
                                                ((!d.productVariantId && !variantId) ||
                                                    (d.productVariantId && variantId && String(d.productVariantId) == String(variantId)))
                                            );

                                            if (index !== -1) {
                                                // Get variant ID to unmark the pill
                                                const removedDiscount = window.appliedDiscounts[index];

                                                // Remove highlight from pill
                                                document.querySelectorAll('.discount-pill').forEach(pill => {
                                                    const pillCode = pill.getAttribute('data-code');
                                                    const pillVariantId = pill.getAttribute('data-product-variant-id');

                                                    // Match by code and product variant ID (if applicable)
                                                    const isMatch = pillCode === codeToRemove &&
                                                        ((!removedDiscount.productVariantId && !pillVariantId) ||
                                                            (removedDiscount.productVariantId && pillVariantId &&
                                                                String(pillVariantId) === String(removedDiscount.productVariantId)));

                                                    if (isMatch) {
                                                        pill.classList.remove('active', 'ring-2', 'ring-blue-400');
                                                    }
                                                });

                                                // Now remove from array
                                                window.appliedDiscounts.splice(index, 1);

                                                // Update UI
                                                updateAppliedDiscountsDisplay();

                                                // If no more discounts, hide the container
                                                if (window.appliedDiscounts.length === 0) {
                                                    appliedPromoContainer.classList.add('hidden');

                                                    // Hide the discount row
                                                    document.querySelector('.discount-row')?.classList.add('hidden');

                                                    // Reset total back to original value but include shipping fee
                                                    const subtotalElement = document.getElementById('cart-subtotal');
                                                    const totalElement = document.getElementById('total-with-discount');
                                                    if (subtotalElement && totalElement) {
                                                        const subtotal = parseFloat(subtotalElement.textContent.replace('$', ''));

                                                        // Get shipping fee value from window.ghnState (same as in updateOrderTotalWithMultipleDiscounts)
                                                        const shippingFee = (window.ghnState && window.ghnState.shippingFeeValue !== null) ? window.ghnState.shippingFeeValue : 0;

                                                        // Calculate total with shipping fee included
                                                        const newTotal = subtotal + shippingFee;
                                                        totalElement.textContent = '$' + newTotal.toFixed(2);
                                                    }

                                                    // Hide any discount display message
                                                    const discountDisplay = document.getElementById('discount-display');
                                                    if (discountDisplay) discountDisplay.classList.add('hidden');
                                                } else {
                                                    // Recalculate total with remaining discounts
                                                    updateOrderTotalWithMultipleDiscounts();
                                                }

                                                // Show feedback
                                                showToast('Đã xóa mã giảm giá: ' + codeToRemove);
                                                console.log('Removed promo code:', codeToRemove, 'Remaining discounts:', window.appliedDiscounts);
                                            }
                                        });
                                    }

                                    // Function to get product IDs from order items
                                    function getProductIdsFromOrderItems() {
                                        const productIds = [];
                                        const itemElements = document.querySelectorAll('.flex.items-center.py-3');

                                        console.log('Found ' + itemElements.length + ' product items in order');

                                        itemElements.forEach((element, index) => {
                                            try {
                                                // Try multiple ways to get the product ID
                                                const productId = element.getAttribute('data-product-id') ||
                                                    element.querySelector('img').getAttribute('data-product-id') ||
                                                    element.querySelector('.flex-1 h3').getAttribute('data-product-id');

                                                if (productId) {
                                                    // Clean the product ID (remove non-numeric characters)
                                                    const cleanProductId = productId.toString().replace(/[^0-9]/g, '');

                                                    if (cleanProductId) {
                                                        console.log('Product #' + (index + 1) + ' has product ID:', cleanProductId);

                                                        // Add to the array if it's not already there
                                                        if (!productIds.includes(cleanProductId)) {
                                                            productIds.push(cleanProductId);
                                                        }
                                                    }
                                                } else {
                                                    console.log('Product #' + (index + 1) + ' - could not find product ID in element');

                                                    // Try to get product ID from the nearest heading or any other metadata
                                                    const productName = element.querySelector('.flex-1 h3')?.textContent.trim();
                                                    console.log('Product #' + (index + 1) + ' name:', productName);
                                                }
                                            } catch (error) {
                                                console.error('Error processing product item #' + (index + 1) + ':', error);
                                            }
                                        });

                                        // Fallback: If no product IDs found, try to get from URL
                                        if (productIds.length === 0) {
                                            const urlParams = new URLSearchParams(window.location.search);
                                            const variantId = urlParams.get('variantId');

                                            if (variantId) {
                                                console.log('Using variant ID from URL as fallback:', variantId);
                                                productIds.push(variantId);
                                            } else {
                                                console.log('No product IDs found, using default value: 1');
                                                productIds.push('1');
                                            }
                                        }

                                        console.log('Final product IDs array:', productIds);
                                        return productIds;
                                    }

                                    // Helper function to build API URLs with proper context path
                                    function buildApiUrl(endpoint, params = {}) {
                                        let url = window.location.origin;

                                        if (contextPath && contextPath !== '') {
                                            url += contextPath;
                                        }

                                        if (!endpoint.startsWith('/')) {
                                            endpoint = '/' + endpoint;
                                        }
                                        url += endpoint;

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

                                    // Function to fetch available discounts
                                    function fetchAvailableDiscounts() {
                                        const productVariantIds = getProductIdsFromOrderItems();
                                        const discountList = document.getElementById('discount-list');
                                        const discountPills = document.getElementById('discount-pills');

                                        if (!discountList || !discountPills) return;

                                        // Set loading state
                                        discountList.innerHTML = '<div class="p-4 text-center text-gray-500">Đang tải mã giảm giá...</div>';

                                        // Log all product IDs collected from the order items
                                        console.log('All product variant IDs collected from order items:', productVariantIds);

                                        if (productVariantIds.length === 0) {
                                            discountList.innerHTML = '<div class="p-4 text-center text-gray-500">Không tìm thấy sản phẩm để lấy mã giảm giá.</div>';
                                            return;
                                        }

                                        // Initialize an array to store all discounts
                                        let allDiscounts = [];
                                        let completedRequests = 0;

                                        // Function to handle completion of discount fetching
                                        function handleFetchCompletion() {
                                            console.log(`Combined ${allDiscounts.length} unique discounts from all products`);

                                            // Check if there are any available discounts after filtering
                                            if (allDiscounts.length === 0) {
                                                // If no available discounts, show a specific message
                                                if (discountList) {
                                                    discountList.innerHTML = '<div class="p-4 text-center text-gray-500">Không có mã giảm giá khả dụng.</div>';
                                                }
                                                // Clear discount pills 
                                                if (discountPills) {
                                                    discountPills.innerHTML = '';
                                                }
                                            } else {
                                                // Only update UI if there are available discounts
                                                updateDiscountTooltip(allDiscounts);
                                                updateDiscountPills(allDiscounts);
                                            }
                                        }

                                        // Process each product ID
                                        productVariantIds.forEach(productId => {
                                            console.log('Fetching discounts for product ID:', productId);

                                            // Use the new server-side endpoint instead of the API
                                            const url = '${ctx}/user/product-discounts?productId=' + productId;

                                            // Use AJAX to load the HTML fragment
                                            $.ajax({
                                                url: url,
                                                method: 'GET',
                                                success: function (response) {
                                                    // Parse the hidden JSON data from the response
                                                    const discountsDataElement = $(response).find('#discounts-data');
                                                    let discounts = [];

                                                    if (discountsDataElement.length > 0) {
                                                        try {
                                                            discounts = JSON.parse(discountsDataElement.val() || '[]');
                                                            console.log(`Received ${discounts.length} discounts for product ID ${productId}:`, discounts);
                                                        } catch (e) {
                                                            console.error('Error parsing discounts JSON:', e);
                                                            discounts = [];
                                                        }
                                                    }

                                                    // Add discounts with status "available" to our collection
                                                    discounts.forEach(discount => {
                                                        // Filter to only include discounts with status "available"
                                                        if (discount.status === "available") {
                                                            allDiscounts.push(discount);
                                                        }
                                                    });

                                                    completedRequests++;

                                                    // Once all requests are complete, update the UI
                                                    if (completedRequests === productVariantIds.length) {
                                                        handleFetchCompletion();
                                                    }
                                                },
                                                error: function (xhr, status, error) {
                                                    console.error(`Error fetching discounts for product ID ${productId}:`, error);

                                                    completedRequests++;
                                                    // Even if one request fails, we should still proceed with any results we have
                                                    if (completedRequests === productVariantIds.length) {
                                                        handleFetchCompletion();
                                                    }
                                                }
                                            });
                                        });
                                    }

                                    // Function to update discount tooltip with fetched discounts
                                    function updateDiscountTooltip(discounts) {
                                        const discountList = document.getElementById('discount-list');
                                        if (!discountList) return;

                                        // If no discounts are available, show a simple message
                                        if (!discounts || discounts.length === 0) {
                                            discountList.innerHTML = '<div class="p-4 text-center text-gray-500">Không có mã giảm giá khả dụng.</div>';
                                            return;
                                        }

                                        // Get all product variant IDs from the cart items
                                        const cartItems = [];
                                        document.querySelectorAll('.flex.items-center.py-3').forEach(item => {
                                            const imgElement = item.querySelector('img');
                                            if (imgElement) {
                                                const variantId = parseInt(imgElement.getAttribute('data-variant-id'));
                                                const productName = item.querySelector('h3')?.textContent.trim() || 'Sản phẩm';
                                                const productImage = imgElement.src || '';

                                                if (variantId) {
                                                    cartItems.push({
                                                        variantId: variantId,
                                                        productName: productName,
                                                        productImage: productImage
                                                    });
                                                }
                                            }
                                        });

                                        const cartVariantIds = cartItems.map(item => item.variantId);
                                        console.log('Cart variant IDs for filtering discounts:', cartVariantIds);

                                        // Organize discounts by product
                                        const discountsByProduct = {};
                                        const generalDiscounts = [];

                                        // First, sort discounts into product-specific and general categories
                                        discounts.forEach(discount => {
                                            // Log each discount to help with debugging
                                            console.log('Processing discount:', discount);

                                            if (discount.product_variant_id) {
                                                const variantId = parseInt(discount.product_variant_id);
                                                if (cartVariantIds.includes(variantId)) {
                                                    if (!discountsByProduct[variantId]) {
                                                        discountsByProduct[variantId] = [];
                                                    }
                                                    discountsByProduct[variantId].push(discount);
                                                }
                                            } else {
                                                // If no product_variant_id exists, treat as a general discount
                                                generalDiscounts.push(discount);
                                            }
                                        });

                                        // Check if we actually have any applicable discounts after categorization
                                        const hasGeneralDiscounts = generalDiscounts.length > 0;
                                        const hasProductDiscounts = Object.keys(discountsByProduct).length > 0;

                                        // If no applicable discounts were found, show "no discounts" message and exit
                                        if (!hasGeneralDiscounts && !hasProductDiscounts) {
                                            discountList.innerHTML = '<div class="p-4 text-center text-gray-500">Không có mã giảm giá khả dụng.</div>';
                                            return;
                                        }

                                        // Only build UI if we have actual discounts to display
                                        let tooltipContent = '<div class="py-3 px-4 border-b border-gray-100">' +
                                            '<h4 class="text-sm font-medium">Mã giảm giá có sẵn</h4>' +
                                            '<p class="text-xs text-gray-500 mt-1">Chọn mã giảm giá phù hợp cho sản phẩm của bạn</p>' +
                                            '</div>' +
                                            '<div class="max-h-[350px] overflow-y-auto">';

                                        // First, show general discounts if any
                                        if (hasGeneralDiscounts) {
                                            tooltipContent += '<div class="py-2 px-3 bg-gray-50">' +
                                                '<h5 class="text-sm font-medium text-gray-700">Mã giảm giá cho tất cả sản phẩm</h5>' +
                                                '</div>';

                                            generalDiscounts.forEach(discount => {
                                                const discountCode = discount.discount_code || '';
                                                const discountName = discount.discount_name || 'Giảm giá';
                                                const discountValue = discount.discount_percentage ? discount.discount_percentage + '%' : (discount.discount_amount ? discount.discount_amount + '₫' : 'Giảm giá');
                                                const minOrder = discount.min_order_value ? 'Đơn tối thiểu: ' + discount.min_order_value + '₫' :
                                                    (discount.totalminmoney ? 'Đơn tối thiểu: ' + discount.totalminmoney + '₫' : '');
                                                const maxDiscount = discount.max_discount_amount ? 'Tối đa: ' + discount.max_discount_amount + '₫' : '';
                                                console.log('Discount:', maxDiscount);

                                                tooltipContent += '<div class="flex items-center p-3 border-b border-gray-100 hover:bg-gray-50">' +
                                                    '<div class="w-10 h-10 flex-shrink-0 mr-3">' +
                                                    '<img src="${ctx}/resources/assets/client/images/logo-audio365.png" alt="Shop Logo" class="w-full h-full object-contain">' +
                                                    '</div>' +
                                                    '<div class="flex-grow">' +
                                                    '<p class="text-sm font-medium">' + discountValue + '</p>' +
                                                    '<p class="text-sm font-medium">' + discountCode + '</p>' +
                                                    '<p class="text-xs text-gray-500">' + discountName + '</p>' +
                                                    (minOrder ? '<p class="text-xs text-gray-500">' + minOrder + '</p>' : '') +
                                                    (maxDiscount ? '<p class="text-xs text-gray-500">' + maxDiscount + '</p>' : '') +
                                                    '<p class="text-xs text-gray-500">Áp dụng cho tất cả sản phẩm</p>' +
                                                    '</div>' +
                                                    '<button class="apply-discount-btn bg-black text-white px-3 py-1 text-xs rounded hover:bg-gray-800" ' +
                                                    'data-code="' + discountCode + '">' +
                                                    'Áp dụng</button>' +
                                                    '</div>';
                                            });
                                        }

                                        // Then show discounts for each product
                                        cartItems.forEach(item => {
                                            const productDiscounts = discountsByProduct[item.variantId] || [];

                                            if (productDiscounts.length > 0) {
                                                tooltipContent += '<div class="py-2 px-3 bg-gray-50 border-t">' +
                                                    '<h5 class="text-sm font-medium text-gray-700">Mã giảm giá cho: ' + item.productName + '</h5>' +
                                                    '</div>' +
                                                    '<div class="flex items-center p-2 border-b">' +
                                                    '<div class="w-8 h-8 mr-2">' +
                                                    '<img src="' + item.productImage + '" alt="' + item.productName + '" class="w-full h-full object-cover">' +
                                                    '</div>' +
                                                    '<span class="text-xs text-gray-600">' + item.productName + '</span>' +
                                                    '</div>';

                                                productDiscounts.forEach(discount => {
                                                    const discountCode = discount.discount_code || '';
                                                    const discountName = discount.discount_name || 'Giảm giá';
                                                    const discountValue = discount.discount_percentage ? discount.discount_percentage + '%' : (discount.discount_amount ? discount.discount_amount + '₫' : 'Giảm giá');
                                                    const minOrder = discount.min_order_value ? 'Đơn tối thiểu: ' + discount.min_order_value + '₫' :
                                                        (discount.totalminmoney ? 'Đơn tối thiểu: ' + discount.totalminmoney + '₫' : '');
                                                    const maxDiscount = discount.max_discount_amount ? 'Tối đa: ' + discount.max_discount_amount + '₫' : '';

                                                    tooltipContent += '<div class="flex items-center p-3 border-b border-gray-100 hover:bg-gray-50">' +
                                                        '<div class="w-10 h-10 flex-shrink-0 mr-3">' +
                                                        '<img src="${ctx}/resources/assets/client/images/logo-audio365.png" alt="Shop Logo" class="w-full h-full object-contain">' +
                                                        '</div>' +
                                                        '<div class="flex-grow">' +
                                                        '<p class="text-sm font-medium">' + discountValue + '</p>' +
                                                        '<p class="text-sm font-medium">' + discountCode + '</p>' +
                                                        '<p class="text-xs text-gray-500">' + discountName + '</p>' +
                                                        (minOrder ? '<p class="text-xs text-gray-500">' + minOrder + '</p>' : '') +
                                                        (maxDiscount ? '<p class="text-xs text-gray-500">' + maxDiscount + '</p>' : '') +
                                                        '<p class="text-xs text-gray-500">Chỉ áp dụng cho sản phẩm này</p>' +
                                                        '</div>' +
                                                        '<button class="apply-discount-btn bg-black text-white px-3 py-1 text-xs rounded hover:bg-gray-800" ' +
                                                        'data-code="' + discountCode + '" data-product-variant-id="' + item.variantId + '">' +
                                                        'Áp dụng</button>' +
                                                        '</div>';
                                                });
                                            }
                                        });

                                        tooltipContent += '</div>';
                                        discountList.innerHTML = tooltipContent;

                                        // Add event listeners to the apply buttons
                                        discountList.querySelectorAll('.apply-discount-btn').forEach(button => {
                                            button.addEventListener('click', function () {
                                                const code = this.getAttribute('data-code');
                                                const productVariantId = this.getAttribute('data-product-variant-id');
                                                applyPromoCode(code, productVariantId);
                                            });
                                        });
                                    }

                                    // Function to update discount pills
                                    function updateDiscountPills(discounts) {
                                        const pillsContainer = document.getElementById('discount-pills');
                                        if (!pillsContainer || !discounts || discounts.length === 0) {
                                            return;
                                        }

                                        // Get all product variant IDs from the cart items with product names
                                        const cartItems = [];
                                        document.querySelectorAll('.flex.items-center.py-3').forEach(item => {
                                            const imgElement = item.querySelector('img');
                                            if (imgElement) {
                                                const variantId = parseInt(imgElement.getAttribute('data-variant-id'));
                                                const productName = item.querySelector('h3')?.textContent.trim() || 'Sản phẩm';

                                                if (variantId) {
                                                    cartItems.push({
                                                        variantId: variantId,
                                                        productName: productName
                                                    });
                                                }
                                            }
                                        });

                                        const cartVariantIds = cartItems.map(item => item.variantId);

                                        // Split discounts into general and product-specific
                                        const generalDiscounts = discounts.filter(discount => !discount.product_variant_id);
                                        const productDiscounts = discounts.filter(discount =>
                                            discount.product_variant_id &&
                                            cartVariantIds.includes(parseInt(discount.product_variant_id))
                                        );

                                        let pillsContent = '';

                                        // First show general discounts
                                        if (generalDiscounts.length > 0) {
                                            pillsContent += '<div class="w-full mb-2">' +
                                                '<span class="text-xs text-gray-500 block mb-1">Mã cho tất cả sản phẩm:</span>' +
                                                '<div class="flex flex-wrap gap-1">';

                                            generalDiscounts.forEach(discount => {
                                                const discountCode = discount.discount_code || '';
                                                const discountId = discount.discount_id || '';
                                                const discountValue = discount.discount_percentage ? discount.discount_percentage + '%' : '';
                                                const minOrderValue = discount.min_order_value || discount.totalminmoney || 0;
                                                const maxDiscountAmount = discount.max_discount_amount || 0;


                                                console.log('----ff---------------dv', discountValue);
                                                console.log('-----ff--------------mv', minOrderValue);
                                                console.log('------ff-------------ma', maxDiscountAmount);

                                                pillsContent += '<div class="inline-block">' +
                                                    '<button class="discount-pill bg-blue-50 hover:bg-blue-100 text-blue-600 rounded-full px-3 py-1 text-xs" ' +
                                                    'data-code="' + discountCode + '" data-id="' + discountId + '" ' +
                                                    'data-min-order-value="' + minOrderValue + '" data-max-discount-amount="' + maxDiscountAmount + '" ' +
                                                    'title="Áp dụng cho tất cả sản phẩm">' +
                                                    discountCode + (discountValue ? ' (' + discountValue + ')' : '') +
                                                    '</button>' +
                                                    '</div>';
                                            });

                                            pillsContent += '</div></div>';
                                        }

                                        // Then show product-specific discounts grouped by product
                                        if (productDiscounts.length > 0) {
                                            // Group discounts by product variant ID
                                            const discountsByProduct = {};
                                            productDiscounts.forEach(discount => {
                                                const variantId = parseInt(discount.product_variant_id);
                                                if (!discountsByProduct[variantId]) {
                                                    discountsByProduct[variantId] = [];
                                                }
                                                discountsByProduct[variantId].push(discount);
                                            });

                                            // Create pills for each product's discounts
                                            cartItems.forEach(item => {
                                                const productDiscounts = discountsByProduct[item.variantId] || [];
                                                if (productDiscounts.length > 0) {
                                                    pillsContent += '<div class="w-full mb-2">' +
                                                        '<span class="text-xs text-gray-500 block mb-1">Mã cho ' + item.productName + ':</span>' +
                                                        '<div class="flex flex-wrap gap-1">';

                                                    productDiscounts.forEach(discount => {
                                                        const discountCode = discount.discount_code || '';
                                                        const discountId = discount.discount_id || '';
                                                        const discountValue = discount.discount_percentage ? discount.discount_percentage + '%' : '';
                                                        const minOrderValue = discount.min_order_value || discount.totalminmoney || 0;
                                                        const maxDiscountAmount = discount.max_discount_amount || 0;

                                                        pillsContent += '<div class="inline-block">' +
                                                            '<button class="discount-pill bg-rose-50 hover:bg-rose-100 text-rose-600 rounded-full px-3 py-1 text-xs" ' +
                                                            'data-code="' + discountCode + '" data-id="' + discountId + '" ' +
                                                            'data-product-variant-id="' + item.variantId + '" ' +
                                                            'data-min-order-value="' + minOrderValue + '" data-max-discount-amount="' + maxDiscountAmount + '" ' +
                                                            'title="Áp dụng riêng cho ' + item.productName + '">' +
                                                            discountCode + (discountValue ? ' (' + discountValue + ')' : '') +
                                                            '</button>' +
                                                            '</div>';
                                                    });

                                                    pillsContent += '</div></div>';
                                                }
                                            });
                                        }

                                        pillsContainer.innerHTML = pillsContent;

                                        // Add event listeners to the discount pills
                                        pillsContainer.querySelectorAll('.discount-pill').forEach(pill => {
                                            pill.addEventListener('click', function () {
                                                const code = this.getAttribute('data-code');
                                                const productVariantId = this.getAttribute('data-product-variant-id');

                                                // Check if this discount is already applied
                                                const isApplied = window.appliedDiscounts.some(d =>
                                                    d.code === code &&
                                                    ((!d.productVariantId && !productVariantId) ||
                                                        (d.productVariantId && productVariantId &&
                                                            (String(d.productVariantId) === String(productVariantId))))
                                                );

                                                if (isApplied) {
                                                    // If already applied, remove it (toggle off)
                                                    const index = window.appliedDiscounts.findIndex(d =>
                                                        d.code === code &&
                                                        ((!d.productVariantId && !productVariantId) ||
                                                            (d.productVariantId && productVariantId &&
                                                                (String(d.productVariantId) === String(productVariantId))))
                                                    );

                                                    if (index !== -1) {
                                                        // Remove the discount
                                                        window.appliedDiscounts.splice(index, 1);

                                                        // Remove the highlight
                                                        this.classList.remove('active', 'ring-2', 'ring-blue-400');

                                                        // Update UI
                                                        updateAppliedDiscountsDisplay();
                                                        updateOrderTotalWithMultipleDiscounts();

                                                        // Show toast
                                                        showToast('Đã xóa mã giảm giá: ' + code);
                                                    }
                                                } else {
                                                    // If not applied, add it (toggle on)
                                                    applyPromoCode(code, productVariantId);
                                                }
                                            });
                                        });
                                    }

                                    // Function to apply discount to order
                                    function applyPromoCode(code, productVariantId = null) {
                                        if (!code) return;

                                        // Check if this code is already applied
                                        const existingDiscount = window.appliedDiscounts.find(d =>
                                            d.code === code &&
                                            ((!d.productVariantId && !productVariantId) ||
                                                (d.productVariantId && productVariantId &&
                                                    (String(d.productVariantId) === String(productVariantId))))
                                        );

                                        if (existingDiscount) {
                                            console.log('Discount code already applied:', code);
                                            return;
                                        }

                                        // Check if there's already a discount applied to this product
                                        if (productVariantId) {
                                            const existingProductDiscount = window.appliedDiscounts.findIndex(d =>
                                                d.productVariantId &&
                                                (String(d.productVariantId) === String(productVariantId))
                                            );
                                            if (existingProductDiscount !== -1) {
                                                // Remove the existing discount for this product
                                                const removedDiscount = window.appliedDiscounts.splice(existingProductDiscount, 1)[0];
                                                console.log('Removed existing discount for product:', removedDiscount.code);

                                                // Remove highlight from the old discount pill
                                                document.querySelectorAll('.discount-pill').forEach(pill => {
                                                    const pillCode = pill.getAttribute('data-code');
                                                    const pillVariantId = pill.getAttribute('data-product-variant-id');

                                                    if (pillCode === removedDiscount.code &&
                                                        (String(pillVariantId) === String(removedDiscount.productVariantId))) {
                                                        pill.classList.remove('active', 'ring-2', 'ring-blue-400');
                                                    }
                                                });

                                                // Show toast about replacing discount
                                                showToast('Mã giảm giá ' + removedDiscount.code + ' đã được thay thế bởi ' + code);
                                            }
                                        }

                                        // Find detailed discount information from available discount pills
                                        let discountDetails = null;
                                        const discountPills = document.querySelectorAll('.discount-pill');

                                        // First try to find an exact match for both code and product variant
                                        discountPills.forEach(pill => {
                                            if (pill.getAttribute('data-code')?.toLowerCase() === code.toLowerCase()) {
                                                const pillVariantId = pill.getAttribute('data-product-variant-id');

                                                if ((!productVariantId && !pillVariantId) ||
                                                    (productVariantId && pillVariantId && String(pillVariantId) === String(productVariantId))) {

                                                    const discountText = pill.textContent.trim();
                                                    const discountId = pill.getAttribute('data-id');
                                                    const minOrderValue = pill.getAttribute('data-min-order-value') || pill.getAttribute('data-totalminmoney') || 0;
                                                    const maxDiscountAmount = pill.getAttribute('data-max-discount-amount') || 0;

                                                    // Check if it contains a percentage
                                                    let discountPercentage = 0;
                                                    const percentageMatch = discountText.match(/\((\d+)%\)/);
                                                    if (percentageMatch && percentageMatch[1]) {
                                                        discountPercentage = parseInt(percentageMatch[1]);
                                                    }

                                                    // Get product details if it's product-specific
                                                    let productName = '';
                                                    if (productVariantId) {
                                                        const productItem = document.querySelector(
                                                            `.flex.items-center.py-3 img[data-variant-id="${productVariantId}"]`
                                                        );
                                                        if (productItem) {
                                                            const productElement = productItem.closest('.flex.items-center.py-3');
                                                            productName = productElement.querySelector('h3')?.textContent.trim() || '';
                                                        }
                                                    }

                                                    discountDetails = {
                                                        code: code,
                                                        id: discountId,
                                                        percentage: discountPercentage,
                                                        productVariantId: productVariantId ? productVariantId : null,
                                                        productName: productName,
                                                        min_order_value: minOrderValue,
                                                        max_discount_amount: maxDiscountAmount
                                                    };

                                                    // Highlight this pill as selected
                                                    pill.classList.add('active', 'ring-2', 'ring-blue-400');
                                                }
                                            }
                                        });

                                        // If no exact match was found but we have a product variant ID, try to find a general discount
                                        if (!discountDetails && productVariantId) {
                                            discountPills.forEach(pill => {
                                                if (pill.getAttribute('data-code')?.toLowerCase() === code.toLowerCase() && !pill.getAttribute('data-product-variant-id')) {
                                                    const discountText = pill.textContent.trim();
                                                    const discountId = pill.getAttribute('data-id');
                                                    const minOrderValue = pill.getAttribute('data-min-order-value') || pill.getAttribute('data-totalminmoney') || 0;
                                                    const maxDiscountAmount = pill.getAttribute('data-max-discount-amount') || 0;

                                                    // Check if it contains a percentage
                                                    let discountPercentage = 0;
                                                    const percentageMatch = discountText.match(/\((\d+)%\)/);
                                                    if (percentageMatch && percentageMatch[1]) {
                                                        discountPercentage = parseInt(percentageMatch[1]);
                                                    }

                                                    discountDetails = {
                                                        code: code,
                                                        id: discountId,
                                                        percentage: discountPercentage,
                                                        productVariantId: null, // Use null here since it's a general discount
                                                        productName: '',
                                                        min_order_value: minOrderValue,
                                                        max_discount_amount: maxDiscountAmount
                                                    };

                                                    // Highlight this pill as selected
                                                    pill.classList.add('active', 'ring-2', 'ring-blue-400');
                                                }
                                            });
                                        }

                                        if (!discountDetails) {
                                            // Create a default entry if we don't have pill information
                                            discountDetails = {
                                                code: code,
                                                percentage: 0,
                                                productVariantId: productVariantId ? productVariantId : null,
                                                productName: '',
                                                min_order_value: 0,
                                                max_discount_amount: 0
                                            };
                                        }

                                        // Add to array of applied discounts
                                        window.appliedDiscounts.push(discountDetails);
                                        console.log('Applied discount:', discountDetails);

                                        // Clear input field
                                        if (promoInput) {
                                            promoInput.value = '';
                                        }

                                        // Update the UI
                                        updateAppliedDiscountsDisplay();

                                        // Update order total with all applied discounts
                                        updateOrderTotalWithMultipleDiscounts();

                                        // Hide tooltip
                                        document.querySelector('.discount-tooltip')?.classList.add('hidden');
                                    }

                                    // Function to update applied discounts display
                                    function updateAppliedDiscountsDisplay() {
                                        if (!appliedPromoContainer || !appliedPromoText) return;

                                        if (window.appliedDiscounts.length === 0) {
                                            appliedPromoContainer.classList.add('hidden');
                                            return;
                                        }

                                        // Make sure the container is visible
                                        appliedPromoContainer.classList.remove('hidden');

                                        // Create HTML to display all applied discount codes
                                        let displayHTML = '';

                                        // Create a map to track products that already have a discount shown
                                        // This ensures we only show one discount per product
                                        const productVariantsWithDiscount = new Set();

                                        // Loop through all applied discounts and create a display for each
                                        window.appliedDiscounts.forEach((discount, index) => {
                                            // Skip if this is a product-specific discount and we've already shown one for this product
                                            if (discount.productVariantId && productVariantsWithDiscount.has(String(discount.productVariantId))) {
                                                return;
                                            }

                                            // Track this product variant to avoid showing multiple discounts for it
                                            if (discount.productVariantId) {
                                                productVariantsWithDiscount.add(String(discount.productVariantId));
                                            }

                                            if (index > 0 && !displayHTML.includes('mt-1')) {
                                                displayHTML += '<div class="mt-1"></div>'; // Add spacing between codes
                                            }

                                            displayHTML += '<div class="flex items-center justify-between">' +
                                                '<div class="flex items-center">' +
                                                '<span class="text-blue-600 mr-1 font-medium">' + discount.code + '</span>';

                                            // Add product-specific information if applicable
                                            if (discount.productName) {
                                                displayHTML += ' <span class="text-xs text-gray-600">(Áp dụng cho: ' + discount.productName + ')</span>';
                                            }

                                            // Add percentage info if available
                                            if (discount.percentage > 0) {
                                                displayHTML += ' <span class="text-xs text-green-600 ml-1">(' + discount.percentage + '%)</span>';
                                            }

                                            displayHTML += '</div>' +
                                                '<button type="button" class="remove-code-btn text-gray-500 hover:text-red-500 ml-2" ' +
                                                'data-code="' + discount.code + '" ' +
                                                'data-variant-id="' + (discount.productVariantId || '') + '" ' +
                                                'title="Xóa mã giảm giá">' +
                                                '<svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">' +
                                                '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />' +
                                                '</svg>' +
                                                '</button>' +
                                                '</div>';
                                        });

                                        // Set the HTML content
                                        appliedPromoText.innerHTML = displayHTML;
                                    }

                                    // Function to update order total with multiple discounts
                                    function updateOrderTotalWithMultipleDiscounts() {
                                        try {
                                            // Get the current subtotal
                                            const subtotalElement = document.getElementById('cart-subtotal');
                                            const totalElement = document.getElementById('total-with-discount');
                                            const discountElement = document.getElementById('discount-amount');

                                            if (!subtotalElement || !totalElement || !discountElement) {
                                                console.error('Required elements not found for updating total');
                                                return;
                                            }

                                            // Get the subtotal from the element
                                            const subtotalText = subtotalElement.textContent.trim();
                                            const subtotal = parseFloat(subtotalText.replace('$', ''));

                                            if (isNaN(subtotal)) {
                                                console.error('Invalid subtotal value:', subtotalText);
                                                return;
                                            }

                                            // Initialize total discount
                                            let totalDiscountAmount = 0;

                                            // Process each applied discount
                                            window.appliedDiscounts.forEach(discount => {
                                                let discountAmount = 0;

                                                // Convert string values to numbers if needed
                                                const minOrderValue = parseFloat(discount.min_order_value) || 0;
                                                const maxDiscountAmount = parseFloat(discount.max_discount_amount) || Infinity;

                                                // Check if min order value is met
                                                if (minOrderValue > 0 && subtotal < minOrderValue) {
                                                    console.log(`Discount ${discount.code} not applied - minimum order value ${minOrderValue} not met (current: ${subtotal})`);
                                                    return; // Skip this discount
                                                }

                                                if (discount.productVariantId) {
                                                    // Product-specific discount
                                                    const productItem = document.querySelector(
                                                        '.flex.items-center.py-3 img[data-variant-id="' + discount.productVariantId + '"]'
                                                    );

                                                    if (productItem) {
                                                        const productElement = productItem.closest('.flex.items-center.py-3');
                                                        const priceElement = productElement.querySelector('div.text-right > p.text-sm');
                                                        const quantityElement = productElement.querySelector('div.text-right > p.text-xs');

                                                        if (priceElement && quantityElement) {
                                                            const priceText = priceElement.textContent.trim();
                                                            const price = parseFloat(priceText.replace('$', ''));
                                                            const quantityText = quantityElement.textContent.trim();
                                                            const quantity = parseInt(quantityText.replace('Qty: ', ''));

                                                            if (!isNaN(price) && !isNaN(quantity)) {
                                                                const productTotal = price * quantity;

                                                                if (discount.percentage > 0) {
                                                                    discountAmount = (productTotal * discount.percentage / 100);

                                                                    // Apply max discount cap if specified
                                                                    if (maxDiscountAmount !== Infinity) {
                                                                        discountAmount = Math.min(discountAmount, maxDiscountAmount);
                                                                    }
                                                                }

                                                                console.log('Product-specific discount: ' + discountAmount.toFixed(2) + ' on product with variant ID ' + discount.productVariantId);
                                                            }
                                                        }
                                                    }
                                                } else {
                                                    // General discount - apply to whole cart
                                                    if (discount.percentage > 0) {
                                                        discountAmount = subtotal * (discount.percentage / 100);

                                                        // Apply max discount cap if specified
                                                        if (maxDiscountAmount !== Infinity) {
                                                            discountAmount = Math.min(discountAmount, maxDiscountAmount);
                                                        }
                                                    } else if (discount.amount > 0) {
                                                        discountAmount = discount.amount;

                                                        // Apply max discount cap if necessary
                                                        if (maxDiscountAmount !== Infinity) {
                                                            discountAmount = Math.min(discountAmount, maxDiscountAmount);
                                                        }
                                                    }

                                                    console.log('General discount: ' + discountAmount.toFixed(2) + ' on subtotal ' + subtotal);
                                                }

                                                // Add to total discount amount
                                                totalDiscountAmount += discountAmount;
                                            });

                                            // Cap the total discount to never exceed the subtotal
                                            totalDiscountAmount = Math.min(totalDiscountAmount, subtotal);

                                            // Format the discount amount
                                            discountElement.textContent = "-$" + totalDiscountAmount.toFixed(2);

                                            // Get shipping fee value from window.ghnState
                                            const shippingFee = (window.ghnState && window.ghnState.shippingFeeValue !== null) ? window.ghnState.shippingFeeValue : 0;

                                            // Calculate the new total (including shipping fee)
                                            const newTotal = Math.max(0, subtotal - totalDiscountAmount + shippingFee);
                                            totalElement.textContent = "$" + newTotal.toFixed(2);

                                            console.log("Total including shipping fee:", newTotal, "breakdown:", {
                                                subtotal,
                                                totalDiscountAmount,
                                                shippingFee
                                            });

                                            // Show the discount row
                                            const discountRow = document.querySelector('.discount-row');
                                            if (discountRow) {
                                                discountRow.classList.remove('hidden');
                                            }

                                            // Update discount display with more details
                                            const discountDisplay = document.getElementById('discount-display');
                                            if (discountDisplay) {
                                                let displayHTML = '<div class="font-medium mb-2">Mã giảm giá đã áp dụng (tiết kiệm $' + totalDiscountAmount.toFixed(2) + '):</div>';

                                                // Create a list of all applied discounts
                                                if (window.appliedDiscounts.length > 0) {
                                                    displayHTML += '<div class="flex flex-wrap gap-2 mt-2">';

                                                    // Create a map to track products that already have a discount shown
                                                    // This ensures we only show one discount per product
                                                    const productVariantsWithDiscount = new Set();

                                                    console.log('window.appliedDiscounts', window.appliedDiscounts);

                                                    // First show discounts that apply to specific products
                                                    window.appliedDiscounts.forEach(discount => {
                                                        if (discount.productVariantId) {
                                                            // Skip if we already showed a discount for this product
                                                            if (productVariantsWithDiscount.has(String(discount.productVariantId))) {
                                                                return;
                                                            }

                                                            productVariantsWithDiscount.add(String(discount.productVariantId));

                                                            let bgColor = 'bg-rose-50 text-rose-700';
                                                            let badgeHTML = '<div class="inline-flex items-center rounded-full px-2.5 py-1 text-xs font-medium ' + bgColor + ' group">' +
                                                                '<span>' + discount.code + '</span>';

                                                            // Add percentage info if available
                                                            if (discount.percentage > 0) {
                                                                badgeHTML += ' <span class="ml-1">(' + discount.percentage + '%)</span>';
                                                            }

                                                            // Add product-specific information
                                                            if (discount.productName) {
                                                                badgeHTML += '<span class="ml-1 text-xs opacity-75 truncate max-w-[100px]" title="' + discount.productName + '">' +
                                                                    '• ' + discount.productName.substring(0, 15) + (discount.productName.length > 15 ? '...' : '') +
                                                                    '</span>';
                                                            }

                                                            // Add delete button
                                                            badgeHTML += '<button type="button" class="remove-discount-btn ml-1 text-rose-700 hover:text-rose-900 opacity-0 group-hover:opacity-100 transition-opacity" ' +
                                                                'data-code="' + discount.code + '" ' +
                                                                'data-variant-id="' + (discount.productVariantId || '') + '">' +
                                                                '<svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">' +
                                                                '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />' +
                                                                '</svg>' +
                                                                '</button>';

                                                            badgeHTML += '</div>';
                                                            displayHTML += badgeHTML;
                                                        }
                                                    });

                                                    // Then show general discounts (those not tied to specific products)
                                                    window.appliedDiscounts.forEach(discount => {
                                                        if (!discount.productVariantId) {
                                                            let bgColor = 'bg-blue-50 text-blue-700';
                                                            let badgeHTML = '<div class="inline-flex items-center rounded-full px-2.5 py-1 text-xs font-medium ' + bgColor + ' group">' +
                                                                '<span>' + discount.code + '</span>';

                                                            // Add percentage info if available
                                                            if (discount.percentage > 0) {
                                                                badgeHTML += ' <span class="ml-1">(' + discount.percentage + '%)</span>';
                                                            }

                                                            // Add delete button
                                                            badgeHTML += '<button type="button" class="remove-discount-btn ml-1 text-blue-700 hover:text-blue-900 opacity-0 group-hover:opacity-100 transition-opacity" ' +
                                                                'data-code="' + discount.code + '">' +
                                                                '<svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">' +
                                                                '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />' +
                                                                '</svg>' +
                                                                '</button>';

                                                            badgeHTML += '</div>';
                                                            displayHTML += badgeHTML;
                                                        }
                                                    });

                                                    displayHTML += '</div>';
                                                }

                                                // Set the HTML content
                                                discountDisplay.innerHTML = displayHTML;
                                                discountDisplay.classList.remove('hidden');

                                                // Add event listeners to the remove buttons
                                                discountDisplay.querySelectorAll('.remove-discount-btn').forEach(btn => {
                                                    btn.addEventListener('click', function (e) {
                                                        e.preventDefault();
                                                        e.stopPropagation();

                                                        const code = this.getAttribute('data-code');
                                                        const variantId = this.getAttribute('data-variant-id');

                                                        // Find the discount in the array
                                                        const index = window.appliedDiscounts.findIndex(d =>
                                                            d.code === code &&
                                                            ((!d.productVariantId && !variantId) ||
                                                                (d.productVariantId && variantId &&
                                                                    (String(d.productVariantId) === String(variantId))))
                                                        );

                                                        if (index !== -1) {
                                                            // Remove from array
                                                            const removedDiscount = window.appliedDiscounts.splice(index, 1)[0];

                                                            // Remove highlight from pill
                                                            document.querySelectorAll('.discount-pill').forEach(pill => {
                                                                const pillCode = pill.getAttribute('data-code');
                                                                const pillVariantId = pill.getAttribute('data-product-variant-id');

                                                                // Match using loose comparison to handle type differences
                                                                const isMatch = pillCode === code &&
                                                                    ((!variantId && !pillVariantId) ||
                                                                        (variantId && pillVariantId &&
                                                                            (String(pillVariantId) === String(variantId))));

                                                                if (isMatch) {
                                                                    pill.classList.remove('active', 'ring-2', 'ring-blue-400');
                                                                }
                                                            });

                                                            // Update UI
                                                            updateAppliedDiscountsDisplay();
                                                            updateOrderTotalWithMultipleDiscounts();

                                                            // Show toast
                                                            showToast('Đã xóa mã giảm giá: ' + code);
                                                        }
                                                    });
                                                });
                                            }

                                            console.log('Updated order total with multiple discounts---:', {
                                                subtotal: subtotal,
                                                totalDiscountAmount: totalDiscountAmount,
                                                newTotal: newTotal,
                                                appliedDiscounts: window.appliedDiscounts
                                            });
                                        } catch (error) {
                                            console.error('Error updating order total with multiple discounts:', error);
                                        }
                                    }

                                    // Function to remove discount from order
                                    function removeDiscount() {
                                        console.log('Removing discount');

                                        if (appliedPromoContainer) {
                                            appliedPromoContainer.classList.add('hidden');
                                            appliedPromoContainer.setAttribute('data-discount-code', '');

                                            // Reset discount pill styling
                                            document.querySelectorAll('.discount-pill').forEach(pill => {
                                                pill.classList.remove('bg-blue-100', 'text-blue-700');
                                                pill.classList.add('bg-gray-100');
                                            });

                                            // Reset order total (mock implementation)
                                            updateOrderTotal('');
                                        }
                                    }

                                    // Function to update order total with discount applied
                                    function updateOrderTotal(discountCode, productVariantId = null) {
                                        try {
                                            // Get the current subtotal and product prices
                                            const subtotalElement = document.getElementById('cart-subtotal');
                                            const totalElement = document.getElementById('total-with-discount');
                                            const discountElement = document.getElementById('discount-amount');

                                            if (!subtotalElement || !totalElement || !discountElement) {
                                                console.error('Required elements not found for updating total');
                                                return;
                                            }

                                            // Get the current subtotal from the element
                                            const subtotalText = subtotalElement.textContent.trim();
                                            const subtotal = parseFloat(subtotalText.replace('$', ''));

                                            if (isNaN(subtotal)) {
                                                console.error('Invalid subtotal value:', subtotalText);
                                                return;
                                            }

                                            // Find the discount details if available
                                            let discountPercentage = 0;
                                            let discountAmount = 0;
                                            let maxDiscountAmount = Infinity;

                                            // Find the discount in our list
                                            const allDiscountPills = document.querySelectorAll('.discount-pill');
                                            let discountDetails = null;

                                            allDiscountPills.forEach(pill => {
                                                if (pill.getAttribute('data-code') === discountCode) {
                                                    // Check if product-specific discount matches
                                                    const pillVariantId = pill.getAttribute('data-product-variant-id');
                                                    if ((!productVariantId && !pillVariantId) ||
                                                        (productVariantId && pillVariantId && String(pillVariantId) === String(productVariantId))) {

                                                        const titleText = pill.getAttribute('title') || '';
                                                        const discountIdAttr = pill.getAttribute('data-id');
                                                        const discountText = pill.textContent.trim();

                                                        // Check if it contains a percentage
                                                        const percentageMatch = discountText.match(/\((\d+)%\)/);
                                                        if (percentageMatch && percentageMatch[1]) {
                                                            discountPercentage = parseInt(percentageMatch[1]);
                                                        }

                                                        discountDetails = {
                                                            code: discountCode,
                                                            percentage: discountPercentage,
                                                            isProductSpecific: !!productVariantId
                                                        };
                                                    }
                                                }
                                            });

                                            console.log('Found discount details:', discountDetails);

                                            // If no details found, use default values
                                            if (!discountDetails) {
                                                if (discountCode.includes('%')) {
                                                    const percentMatch = discountCode.match(/(\d+)%/);
                                                    if (percentMatch && percentMatch[1]) {
                                                        discountPercentage = parseInt(percentMatch[1]);
                                                    } else {
                                                        discountPercentage = 10; // Default 10%
                                                    }
                                                } else {
                                                    // Fixed amount discount in VND
                                                    discountAmount = 250000; // Default 250,000 VND
                                                }
                                            }

                                            // Calculate discount amount differently for product-specific vs general discounts
                                            if (productVariantId) {
                                                // This is a product-specific discount - only apply to this product's price
                                                const productItem = document.querySelector(`.flex.items-center.py-3 img[data-variant-id="${productVariantId}"]`);
                                                if (productItem) {
                                                    const productElement = productItem.closest('.flex.items-center.py-3');
                                                    const priceElement = productElement.querySelector('div.text-right > p.text-sm');
                                                    const quantityElement = productElement.querySelector('div.text-right > p.text-xs');

                                                    if (priceElement && quantityElement) {
                                                        const priceText = priceElement.textContent.trim();
                                                        const price = parseFloat(priceText.replace('$', ''));
                                                        const quantityText = quantityElement.textContent.trim();
                                                        const quantity = parseInt(quantityText.replace('Qty: ', ''));

                                                        if (!isNaN(price) && !isNaN(quantity)) {
                                                            const productTotal = price * quantity;

                                                            if (discountPercentage > 0) {
                                                                discountAmount = (productTotal * discountPercentage / 100);
                                                            }

                                                            console.log(`Product-specific discount: ${discountAmount.toFixed(2)} on product with variant ID ${productVariantId}`);
                                                        }
                                                    }
                                                }
                                            } else {
                                                // This is a general discount - apply to whole cart
                                                if (discountPercentage > 0) {
                                                    discountAmount = subtotal * (discountPercentage / 100);
                                                }

                                                // Check for maximum discount cap
                                                if (discountCode.toLowerCase().includes('tối đa')) {
                                                    const maxMatch = discountCode.match(/tối đa ₫(\d+)k/i);
                                                    if (maxMatch && maxMatch[1]) {
                                                        maxDiscountAmount = parseInt(maxMatch[1]) * 1000;
                                                        discountAmount = Math.min(discountAmount, maxDiscountAmount / 25000); // Convert VND to USD
                                                    }
                                                }

                                                console.log(`General discount: ${discountAmount.toFixed(2)} on subtotal ${subtotal}`);
                                            }

                                            // Cap the discount to never exceed the subtotal
                                            discountAmount = Math.min(discountAmount, subtotal);

                                            // Format the discount amount
                                            discountElement.textContent = "-$" + discountAmount.toFixed(2);

                                            // Calculate the new total
                                            const newTotal = Math.max(0, subtotal - discountAmount);
                                            totalElement.textContent = "$" + newTotal.toFixed(2);

                                            // Show the discount row
                                            document.querySelector('.discount-row').classList.remove('hidden');

                                            // Update discount display with more details
                                            const discountDisplay = document.getElementById('discount-display');
                                            if (discountDisplay) {
                                                let displayText = 'Mã đã áp dụng: ' + discountCode;

                                                if (productVariantId) {
                                                    // Find product name
                                                    const productItem = document.querySelector(`.flex.items-center.py-3 img[data-variant-id="${productVariantId}"]`);
                                                    if (productItem) {
                                                        const productElement = productItem.closest('.flex.items-center.py-3');
                                                        const productName = productElement.querySelector('h3')?.textContent.trim();
                                                        if (productName) {
                                                            displayText += ` (Áp dụng cho: ${productName})`;
                                                        }
                                                    }
                                                }

                                                if (discountPercentage > 0) {
                                                    displayText += ` (${discountPercentage}% giảm giá, tiết kiệm $${discountAmount.toFixed(2)})`;
                                                } else if (discountAmount > 0) {
                                                    displayText += ` (tiết kiệm $${discountAmount.toFixed(2)})`;
                                                }

                                                discountDisplay.textContent = displayText;
                                                discountDisplay.classList.remove('hidden');
                                            }

                                            console.log('Updated order total with discount:', {
                                                subtotal: subtotal,
                                                discountCode: discountCode,
                                                discountAmount: discountAmount,
                                                newTotal: newTotal,
                                                productVariantId: productVariantId
                                            });
                                        } catch (error) {
                                            console.error('Error updating order total:', error);
                                        }
                                    }

                                    // Function to update the discount display with more details
                                    function updateDiscountDisplay(code, percentage, amount) {
                                        const displayElement = document.getElementById('discount-display');
                                        if (!displayElement) return;

                                        let displayText = 'Mã đã áp dụng: ' + code;

                                        if (percentage > 0) {
                                            displayText += ' (' + percentage + '% giảm giá';
                                            displayText += ', tiết kiệm $' + (amount / 25000).toFixed(2) + ')';
                                        } else if (amount > 0) {
                                            displayText += ' (tiết kiệm $' + (amount / 25000).toFixed(2) + ')';
                                        }

                                        displayElement.textContent = displayText;
                                        displayElement.classList.remove('hidden');
                                    }

                                    // Function to update discount display in the order summary
                                    function updateDiscountDisplay(discountAmount) {
                                        try {
                                            // Try to find a discount row in the order summary
                                            let discountRow = document.querySelector('.discount-row');

                                            // If discountAmount is 0, remove the row if it exists
                                            if (discountAmount <= 0) {
                                                if (discountRow) {
                                                    discountRow.remove();
                                                }
                                                return;
                                            }

                                            // Find the element before which we should insert the discount row
                                            const totalRow = document.querySelector('.font-medium');
                                            const parentElement = totalRow?.parentElement?.parentElement;

                                            if (!totalRow || !parentElement) return;

                                            // If discount row doesn't exist, create it
                                            if (!discountRow) {
                                                discountRow = document.createElement('div');
                                                discountRow.className = 'flex justify-between discount-row';
                                                discountRow.innerHTML =
                                                    '<span class="text-sm text-green-600">Mã giảm giá</span>' +
                                                    '<span class="text-sm text-green-600 discount-amount">-$' + discountAmount.toFixed(2) + '</span>';

                                                // Insert before the total row
                                                parentElement.insertBefore(discountRow, totalRow.parentElement);
                                            } else {
                                                // Update existing discount row
                                                const discountAmountElem = discountRow.querySelector('.discount-amount');
                                                if (discountAmountElem) {
                                                    discountAmountElem.textContent = '-$' + discountAmount.toFixed(2);
                                                }
                                            }

                                        } catch (error) {
                                            console.error('Error updating discount display:', error);
                                        }
                                    }

                                    // Initialize the discount section
                                    fetchAvailableDiscounts();

                                    // Function to show toast notification
                                    function showToast(message, isSuccess = true) {
                                        const toast = document.getElementById('toast-notification');
                                        const toastMessage = document.getElementById('toast-message');

                                        if (!toast || !toastMessage) return;

                                        // Set message
                                        toastMessage.textContent = message;

                                        // Set color based on success/error
                                        if (isSuccess) {
                                            toast.classList.remove('bg-red-100', 'border-red-500', 'text-red-700');
                                            toast.classList.add('bg-green-100', 'border-green-500', 'text-green-700');
                                        } else {
                                            toast.classList.remove('bg-green-100', 'border-green-500', 'text-green-700');
                                            toast.classList.add('bg-red-100', 'border-red-500', 'text-red-700');
                                        }

                                        // Show the toast
                                        toast.classList.remove('invisible', 'opacity-0');
                                        toast.classList.add('visible', 'opacity-100');

                                        // Hide after 3 seconds
                                        setTimeout(() => {
                                            toast.classList.remove('visible', 'opacity-100');
                                            toast.classList.add('invisible', 'opacity-0');
                                        }, 3000);
                                    }
                                });
                            </script>

                            <!-- Tax Options -->
                            <div class="mb-6 hidden">
                                <label class="block text-sm text-gray-600 mb-2">Tax Options</label>
                                <div class="flex space-x-4">
                                    <button id="noVatBtn" class="tax-option-btn px-4 py-2 border text-sm">No
                                        VAT</button>
                                    <button id="vatBtn"
                                        class="tax-option-btn px-4 py-2 border text-sm bg-black text-white">With VAT
                                        (8%)</button>
                                </div>
                            </div>

                            <!-- Order Totals -->
                            <div class="space-y-3 mb-6">
                                <div class="flex justify-between text-sm">
                                    <span class="text-gray-600">Subtotal</span>
                                    <span id="cart-subtotal">Calculating...</span>
                                </div>

                                <div class="flex justify-between text-sm">
                                    <span class="text-gray-600">Shipping</span>
                                    <span id="shipping-cost-summary">Calculating...</span>
                                </div>



                                <div class="flex justify-between text-sm hidden">
                                    <span class="text-gray-600">Tax</span>
                                    <span id="tax-amount">Calculating......</span>
                                </div>
                                <div class="flex justify-between text-sm hidden">
                                    <span class="text-gray-600">Tax</span>
                                    <span id="tax-amount2">Calculatinggg...</span>
                                </div>







                                <!-- Discount row - initially hidden -->
                                <div class="flex justify-between text-sm discount-row hidden">
                                    <span class="text-gray-600">Discount</span>
                                    <span class="text-green-600" id="discount-amount">-$0.00</span>
                                </div>
                                <div class="flex justify-between text-lg font-medium pt-3 border-t border-gray-200">
                                    <span>Total</span>
                                    <span id="total-with-discount">Calculating...</span>
                                </div>

                                <!-- Applied discount display -->
                                <div id="discount-display" class="text-sm text-green-600 mt-2 hidden"></div>
                            </div>

                            <!-- Test Button for Order Data -->
                            <section class="mt-8">
                                <button id="test-order-data"
                                    class=" w-full py-3 px-6 bg-blue-500 hover:bg-blue-600 text-white font-medium rounded transition duration-200">
                                    Đặt hàng
                                </button>
                            </section>
                            <!-- Secure Checkout -->
                            <div class="mt-4 text-center text-xs text-gray-500">
                                <p>Secure checkout. Your information is protected.</p>
                            </div>
                        </div>

                        <!-- Policies -->
                        <div class="mt-6 text-center text-xs text-gray-500">
                            <p class="mb-2">By placing your order, you agree to our <a href="#" class="underline">Terms
                                    of Service</a> and <a href="#" class="underline">Privacy Policy</a>.</p>
                            <p>Need help? <a href="#" class="underline">Contact us</a></p>
                        </div>
                    </div>
                </div>
                <!-- Footer -->
                <jsp:include page="../layout/footer.jsp" />

                <!-- Toast Notification for Success Messages -->
                <div id="toast-notification"
                    class="fixed top-4 right-4 bg-green-100 border-l-4 border-green-500 text-green-700 p-4 rounded shadow-md transition-opacity duration-300 opacity-0 invisible z-50">
                    <div class="flex items-center">
                        <div class="py-1">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-500 mr-3" fill="none"
                                viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M5 13l4 4L19 7" />
                            </svg>
                        </div>
                        <div id="toast-message">Địa chỉ đã được cập nhật thành công!</div>
                    </div>
                </div>


                <!-- Create a hidden input for current addressv2 data -->
                <input type="hidden" id="current-addressv2-data" value="${customerAddressesv2}">









                <!-- Hidden form for order submission -->
                <form id="orderSubmitForm" action="${pageContext.request.contextPath}/order/submit" method="post"
                    style="display: none;">
                    <!-- Customer ID -->
                    <input type="hidden" id="customerId" name="customerId" />

                    <!-- Customer Info -->
                    <input type="hidden" id="customerInfoFullName" name="customerInfo.fullName" />
                    <input type="hidden" id="customerInfoEmail" name="customerInfo.email" />
                    <input type="hidden" id="customerInfoPhone" name="customerInfo.phone" />

                    <!-- Shipping Address -->
                    <input type="hidden" id="shippingAddressRecipientName" name="shippingAddress.recipientName" />
                    <input type="hidden" id="shippingAddressRecipientPhone" name="shippingAddress.recipientPhone" />
                    <input type="hidden" id="shippingAddressProvinceId" name="shippingAddress.provinceId" />
                    <input type="hidden" id="shippingAddressDistrictId" name="shippingAddress.districtId" />
                    <input type="hidden" id="shippingAddressDistrictName" name="shippingAddress.districtName" />
                    <input type="hidden" id="shippingAddressWardCode" name="shippingAddress.wardCode" />
                    <input type="hidden" id="shippingAddressWardName" name="shippingAddress.wardName" />

                    <!-- Payment -->
                    <input type="hidden" id="paymentMethod" name="payment.method" />

                    <!-- Shipping -->
                    <input type="hidden" id="shippingFee" name="shipping.fee" />
                    <input type="hidden" id="shippingServiceId" name="shipping.serviceId" />
                    <input type="hidden" id="shippingEstimatedDeliveryTime" name="shipping.estimatedDeliveryTime" />

                    <!-- Note -->
                    <input type="hidden" id="orderNote" name="note" />

                    <!-- Tax Info -->
                    <input type="hidden" id="taxInfoIncludeVat" name="taxInfo.includeVat" />
                    <input type="hidden" id="taxInfoVatRate" name="taxInfo.vatRate" />
                    <input type="hidden" id="taxInfoVatAmount" name="taxInfo.vatAmount" />

                    <!-- Order Calculation -->
                    <input type="hidden" id="orderCalculationSubtotal" name="orderCalculation.subtotal" />
                    <input type="hidden" id="orderCalculationTotalDiscountAmount"
                        name="orderCalculation.totalDiscountAmount" />
                    <input type="hidden" id="orderCalculationShippingFee" name="orderCalculation.shippingFee" />
                    <input type="hidden" id="orderCalculationTaxAmount" name="orderCalculation.taxAmount" />
                    <input type="hidden" id="orderCalculationTotalAfterDiscount"
                        name="orderCalculation.totalAfterDiscount" />
                    <input type="hidden" id="orderCalculationFinalTotal" name="orderCalculation.finalTotal" />
                </form>





                <jsp:include page="handle.jsp" />



            </body>

            </html>

            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    // Lấy button test order data
                    const testOrderDataBtn = document.getElementById('test-order-data');

                    // Hàm kiểm tra thông tin form
                    function validateOrderForm() {
                        // Lấy các trường dữ liệu cần kiểm tra
                        const fullName = document.getElementById('fullName');
                        const email = document.getElementById('email');
                        const phone = document.getElementById('phone');

                        // Kiểm tra các trường dữ liệu có trống không
                        const isFullNameValid = fullName && fullName.value.trim() !== '';
                        const isEmailValid = email && email.value.trim() !== '' && /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value.trim());
                        const isPhoneValid = phone && phone.value.trim() !== '' && /^[+]?[(]?[0-9]{3}[)]?[-\s.]?[0-9]{3}[-\s.]?[0-9]{4,6}$/.test(phone.value.trim());

                        // Kết quả kiểm tra
                        const isFormValid = isFullNameValid && isEmailValid && isPhoneValid;

                        // Hiển thị lỗi và cập nhật trạng thái nút "Đặt hàng"
                        if (testOrderDataBtn) {
                            if (isFormValid) {
                                testOrderDataBtn.disabled = false;
                                testOrderDataBtn.classList.remove('bg-gray-400');
                                testOrderDataBtn.classList.add('bg-blue-500', 'hover:bg-blue-600');
                            } else {
                                testOrderDataBtn.disabled = true;
                                testOrderDataBtn.classList.remove('bg-blue-500', 'hover:bg-blue-600');
                                testOrderDataBtn.classList.add('bg-gray-400');
                            }
                        }

                        // Hiển thị lỗi ở các trường dữ liệu
                        displayFieldError(fullName, !isFullNameValid, 'Vui lòng nhập họ tên');
                        displayFieldError(email, !isEmailValid, 'Vui lòng nhập email hợp lệ');
                        displayFieldError(phone, !isPhoneValid, 'Vui lòng nhập số điện thoại hợp lệ');

                        return isFormValid;
                    }

                    // Hàm hiển thị lỗi cho từng trường dữ liệu
                    function displayFieldError(field, hasError, errorMessage) {
                        if (!field) return;

                        // Xóa thông báo lỗi cũ nếu có
                        const existingError = field.parentNode.querySelector('.error-message');
                        if (existingError) {
                            existingError.remove();
                        }

                        // Thêm hoặc xóa lớp viền đỏ
                        if (hasError) {
                            field.classList.add('border-red-500');

                            // Thêm thông báo lỗi
                            const errorDiv = document.createElement('div');
                            errorDiv.className = 'error-message text-red-500 text-xs mt-1';
                            errorDiv.textContent = errorMessage;
                            field.parentNode.appendChild(errorDiv);
                        } else {
                            field.classList.remove('border-red-500');
                        }
                    }

                    // Tạo loading overlay
                    function createLoadingOverlay() {
                        // Kiểm tra xem overlay đã tồn tại chưa
                        if (document.getElementById('loading-overlay')) return;

                        const overlay = document.createElement('div');
                        overlay.id = 'loading-overlay';
                        overlay.className = 'fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50';
                        overlay.innerHTML =
                            '<div class="bg-white p-6 rounded-lg shadow-xl flex flex-col items-center">' +
                            '<div class="loading-spinner mb-4">' +
                            '<svg class="animate-spin h-10 w-10 text-blue-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">' +
                            '<circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>' +
                            '<path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>' +
                            '</svg>' +
                            '</div>' +
                            '<p class="text-gray-700 font-medium">Đang xử lý đơn hàng...</p>' +
                            '<p class="text-gray-500 text-sm mt-2">Vui lòng không tải lại trang</p>' +
                            '</div>';
                        document.body.appendChild(overlay);
                    }

                    // Xóa loading overlay
                    function removeLoadingOverlay() {
                        const overlay = document.getElementById('loading-overlay');
                        if (overlay) {
                            overlay.remove();
                        }
                    }

                    // Tạo modal thông báo
                    function showResponseModal(isSuccess, title, message, orderId = null) {
                        // Xóa modal cũ nếu có
                        const existingModal = document.getElementById('response-modal');
                        if (existingModal) {
                            existingModal.remove();
                        }

                        // Tạo modal mới
                        const modal = document.createElement('div');
                        modal.id = 'response-modal';
                        modal.className = 'fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50';

                        // Icon thành công/lỗi
                        const iconSvg = isSuccess
                            ? '<svg class="h-16 w-16 text-green-500 mb-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg>'
                            : '<svg class="h-16 w-16 text-red-500 mb-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg>';

                        // Nút hành động
                        let actionButton = '';
                        if (isSuccess) {
                            if (orderId) {
                                actionButton = '<a href="' + '${pageContext.request.contextPath}/user/orders/' + orderId + '" class="bg-green-500 hover:bg-green-600 text-white font-bold py-2 px-6 rounded-lg transition duration-200">Xem đơn hàng</a>';
                            } else {
                                actionButton = '<button id="close-response-modal" class="bg-green-500 hover:bg-green-600 text-white font-bold py-2 px-6 rounded-lg transition duration-200">Đóng</button>';
                            }
                        } else {
                            actionButton = '<button id="close-response-modal" class="bg-gray-500 hover:bg-gray-600 text-white font-bold py-2 px-6 rounded-lg transition duration-200">Đóng</button>';
                        }

                        // HTML nội dung modal
                        const colorClass = isSuccess ? 'text-green-600' : 'text-red-600';
                        modal.innerHTML =
                            '<div class="bg-white p-8 rounded-lg shadow-xl max-w-md w-full mx-4">' +
                            '<div class="flex flex-col items-center text-center">' +
                            iconSvg +
                            '<h2 class="text-2xl font-bold mb-2 ' + colorClass + '">' + title + '</h2>' +
                            '<p class="text-gray-600 mb-6">' + message + '</p>' +
                            '<div class="flex space-x-4">' +
                            actionButton +
                            '</div>' +
                            '</div>' +
                            '</div>';

                        document.body.appendChild(modal);

                        // Thêm sự kiện cho nút đóng
                        const closeBtn = document.getElementById('close-response-modal');
                        if (closeBtn) {
                            closeBtn.addEventListener('click', function () {
                                modal.remove();
                            });
                        }
                    }

                    // Thêm sự kiện cho các trường input để kiểm tra khi người dùng nhập
                    const formInputs = document.querySelectorAll('#fullName, #email, #phone');
                    formInputs.forEach(input => {
                        input.addEventListener('input', validateOrderForm);
                        input.addEventListener('change', validateOrderForm);
                    });

                    // Kiểm tra form ngay khi trang được tải
                    validateOrderForm();

                    if (testOrderDataBtn) {
                        testOrderDataBtn.addEventListener('click', function () {
                            console.log('Đang chuẩn bị kiểm tra dữ liệu đơn hàng...');

                            // Kiểm tra lại form trước khi submit
                            if (!validateOrderForm()) {
                                console.warn('Form không hợp lệ, không thể đặt hàng');
                                showResponseModal(false, "Thông tin không hợp lệ", "Vui lòng điền đầy đủ thông tin cá nhân trước khi đặt hàng.");
                                return;
                            }

                            // Hiển thị loading overlay
                            createLoadingOverlay();

                            // Sử dụng hàm từ file handle.jsp để chuẩn bị dữ liệu
                            if (window.orderHandler && typeof window.orderHandler.updateOrderData === 'function') {
                                // Cập nhật dữ liệu đơn hàng
                                window.orderHandler.updateOrderData();

                                // Lấy dữ liệu đã chuẩn bị sẵn
                                const orderData = window.orderHandler.prepareOrderData();

                                // Ghi log ra console để kiểm tra
                                console.group("📋 ORDER DATA TEST");
                                console.log("📝 Raw order state:", JSON.parse(JSON.stringify(window.orderHandler.getOrderState())));
                                console.log("🧾 Formatted for backend:", orderData);
                                console.groupEnd();

                                // Lấy CSRF token
                                const csrfToken = document.querySelector('meta[name="_csrf"]')?.content;
                                const csrfHeader = document.querySelector('meta[name="_csrf_header"]')?.content;

                                // Chuẩn bị headers
                                const headers = {
                                    'Content-Type': 'application/json'
                                };

                                // Thêm CSRF header nếu có
                                if (csrfToken && csrfHeader) {
                                    headers[csrfHeader] = csrfToken;
                                }

                                // Lấy phương thức thanh toán từ orderState
                                const paymentMethod = window.orderHandler.getOrderState().paymentMethod;

                                // Gửi request đến server
                                fetch('${pageContext.request.contextPath}/api/orders/submit', {
                                    method: 'POST',
                                    headers: headers,
                                    body: JSON.stringify(orderData)
                                })
                                    .then(response => {
                                        // Store the response status
                                        const responseStatus = response.status;

                                        // First try to parse the response as JSON regardless of status code
                                        return response.json()
                                            .then(data => {
                                                // Return both the parsed data and status for proper handling
                                                return { data, status: responseStatus, ok: response.ok };
                                            })
                                            .catch(e => {
                                                // If JSON parsing fails, return the response status with empty data
                                                return { data: null, status: responseStatus, ok: response.ok };
                                            });
                                    })
                                    .then(result => {
                                        // Xóa loading overlay
                                        removeLoadingOverlay();

                                        console.log('Response from server:', result);

                                        if (result.ok) {
                                            // Success path - no error
                                            const data = result.data;
                                            console.log('Kết quả từ server:', data);

                                            // Lấy order ID từ response nếu có
                                            const orderId = data.orderId || data.data?.orderId || null;

                                            // Kiểm tra nếu payment method là online payment (1)
                                            if (paymentMethod === "1") {
                                                // Lấy tổng tiền của đơn hàng
                                                const totalAmount = typeof calculateCartTotals === 'function'
                                                    ? calculateCartTotals().total
                                                    : 0;

                                                console.log('Chuyển hướng tới payment gateway với số tiền:', totalAmount);

                                                // Hiển thị modal thành công trước khi chuyển hướng
                                                showResponseModal(true, "Đặt hàng thành công!",
                                                    "Đơn hàng của bạn đã được tạo thành công. Đang chuyển hướng đến trang thanh toán...");

                                                // Đợi 2 giây để hiển thị thông báo trước khi chuyển hướng
                                                setTimeout(() => {
                                                    // Chuyển hướng đến trang thanh toán
                                                    window.location.href = '/api/payment/create_payment?amount=' + Math.round(totalAmount);
                                                }, 2000);
                                            } else {
                                                // Payment method là COD (2)
                                                // Hiển thị thông báo ngắn
                                                showToast("Đặt hàng thành công! Đang chuyển đến trang xác nhận...", true);

                                                // Tạo form ẩn để POST dữ liệu đến trang orderconfirm
                                                const form = document.createElement('form');
                                                form.method = 'POST';
                                                form.action = `${ctx}/user/orderconfirm`;
                                                form.style.display = 'none';

                                                // Thêm CSRF token nếu cần
                                                const csrfToken = document.querySelector('meta[name="_csrf"]')?.content;
                                                const csrfHeader = document.querySelector('meta[name="_csrf_header"]')?.content;

                                                if (csrfToken && csrfHeader) {
                                                    const csrfInput = document.createElement('input');
                                                    csrfInput.type = 'hidden';
                                                    csrfInput.name = '_csrf';
                                                    csrfInput.value = csrfToken;
                                                    form.appendChild(csrfInput);
                                                }

                                                // Thêm dữ liệu đơn hàng vào form
                                                const orderIdInput = document.createElement('input');
                                                orderIdInput.type = 'hidden';
                                                orderIdInput.name = 'orderId';
                                                orderIdInput.value = orderId || '';
                                                form.appendChild(orderIdInput);

                                                // Thêm dữ liệu thời gian đặt hàng
                                                const orderDateInput = document.createElement('input');
                                                orderDateInput.type = 'hidden';
                                                orderDateInput.name = 'orderDate';
                                                orderDateInput.value = new Date().toISOString();
                                                form.appendChild(orderDateInput);

                                                // Thêm dữ liệu khách hàng
                                                const customerNameInput = document.createElement('input');
                                                customerNameInput.type = 'hidden';
                                                customerNameInput.name = 'customerName';
                                                customerNameInput.value = document.getElementById('fullName').value || '';
                                                form.appendChild(customerNameInput);

                                                const customerEmailInput = document.createElement('input');
                                                customerEmailInput.type = 'hidden';
                                                customerEmailInput.name = 'customerEmail';
                                                customerEmailInput.value = document.getElementById('email').value || '';
                                                form.appendChild(customerEmailInput);

                                                // Thêm dữ liệu tổng tiền
                                                if (data.orderCalculation) {
                                                    const cartTotals = typeof calculateCartTotals === 'function' ? calculateCartTotals() : null;

                                                    const subtotalInput = document.createElement('input');
                                                    subtotalInput.type = 'hidden';
                                                    subtotalInput.name = 'subtotal';
                                                    subtotalInput.value = data.orderCalculation.subtotal || '';
                                                    form.appendChild(subtotalInput);

                                                    const discountInput = document.createElement('input');
                                                    discountInput.type = 'hidden';
                                                    discountInput.name = 'discount';
                                                    discountInput.value = data.orderCalculation.totalDiscount || '';
                                                    form.appendChild(discountInput);

                                                    const shippingInput = document.createElement('input');
                                                    shippingInput.type = 'hidden';
                                                    shippingInput.name = 'shipping';
                                                    shippingInput.value = cartTotals.shippingCost || '';
                                                    form.appendChild(shippingInput);

                                                    const totalInput = document.createElement('input');
                                                    totalInput.type = 'hidden';
                                                    totalInput.name = 'total';
                                                    totalInput.value = data.orderCalculation.finalTotal || '';
                                                    form.appendChild(totalInput);
                                                } else {
                                                    // Fallback to cart values if orderCalculation not available
                                                    const cartTotals = typeof calculateCartTotals === 'function' ? calculateCartTotals() : null;
                                                    if (cartTotals) {
                                                        const subtotalInput = document.createElement('input');
                                                        subtotalInput.type = 'hidden';
                                                        subtotalInput.name = 'subtotal';
                                                        subtotalInput.value = cartTotals.subtotal || '';
                                                        form.appendChild(subtotalInput);

                                                        const discountInput = document.createElement('input');
                                                        discountInput.type = 'hidden';
                                                        discountInput.name = 'discount';
                                                        discountInput.value = cartTotals.discount || '';
                                                        form.appendChild(discountInput);

                                                        const shippingInput = document.createElement('input');
                                                        shippingInput.type = 'hidden';
                                                        shippingInput.name = 'shipping';
                                                        // Kiểm tra giá trị shippingCost
                                                        console.log('Shipping Cost Value------------------fdahsfjdfhjjjjjjjjjakjdshfjb  ==-dfsadfsfs:', cartTotals.shippingCost);
                                                        console.log('Complete cartTotals object:', cartTotals);
                                                        shippingInput.value = cartTotals.shippingCost || '';
                                                        form.appendChild(shippingInput);

                                                        const totalInput = document.createElement('input');
                                                        totalInput.type = 'hidden';
                                                        totalInput.name = 'total';
                                                        totalInput.value = cartTotals.total || '';
                                                        form.appendChild(totalInput);
                                                    }
                                                }

                                                // Thêm dữ liệu địa chỉ giao hàng từ form hiện tại
                                                const shippingAddressInput = document.createElement('input');
                                                shippingAddressInput.type = 'hidden';
                                                shippingAddressInput.name = 'shippingAddress';
                                                // Lấy thông tin địa chỉ từ phần hiển thị trên trang
                                                const addressText = document.getElementById('recipient-address')?.textContent || '';
                                                shippingAddressInput.value = addressText;
                                                form.appendChild(shippingAddressInput);

                                                // Thêm đơn hàng dưới dạng JSON string
                                                const orderItemsInput = document.createElement('input');
                                                orderItemsInput.type = 'hidden';
                                                orderItemsInput.name = 'orderItemsJson';

                                                // Lấy danh sách sản phẩm từ các phần tử trong giỏ hàng
                                                const orderItems = [];
                                                document.querySelectorAll('.flex.items-center.py-3').forEach(item => {
                                                    try {
                                                        const name = item.querySelector('h3')?.textContent?.trim() || '';
                                                        const imageUrl = item.querySelector('img')?.src || '';
                                                        const priceText = item.querySelector('div.text-right > p.text-sm')?.textContent || '';
                                                        const price = parseFloat(priceText.replace('$', '')) || 0;
                                                        const quantityText = item.querySelector('div.text-right > p.text-xs')?.textContent || '';
                                                        const quantity = parseInt(quantityText.replace('Qty: ', '')) || 1;

                                                        // Get variant info if available
                                                        const variantText = item.querySelector('p.text-xs.text-gray-500')?.textContent || '';
                                                        const colorMatch = variantText.match(/(.+?)\s*\//) || ['', ''];
                                                        const sizeMatch = variantText.match(/\/\s*(.+)/) || ['', ''];
                                                        const color = colorMatch[1]?.trim() || '';
                                                        const size = sizeMatch[1]?.trim() || '';

                                                        // Create item object
                                                        const orderItem = {
                                                            name: name,
                                                            imageUrl: imageUrl,
                                                            price: price,
                                                            quantity: quantity,
                                                            color: color,
                                                            size: size,
                                                            subtotal: price * quantity
                                                        };

                                                        orderItems.push(orderItem);
                                                    } catch (err) {
                                                        console.error('Error processing order item:', err);
                                                    }
                                                });

                                                orderItemsInput.value = JSON.stringify(orderItems);
                                                form.appendChild(orderItemsInput);

                                                // Thêm form vào document và submit
                                                document.body.appendChild(form);

                                                // Đợi 1 giây để hiển thị thông báo trước khi chuyển trang
                                                setTimeout(() => {
                                                    form.submit();
                                                }, 1000);
                                            }
                                        } else {
                                            // Error path - extract specific error details from the response
                                            let errorTitle = "Đặt hàng thất bại";
                                            let errorMessage = "Đã xảy ra lỗi khi xử lý đơn hàng. Vui lòng thử lại sau.";

                                            // Extract specific error information from the response if available
                                            if (result.data) {
                                                // Extract error message
                                                if (result.data.errorMessage) {
                                                    errorMessage = result.data.errorMessage;
                                                } else if (result.data.message) {
                                                    errorMessage = result.data.message;
                                                } else if (result.data.error) {
                                                    errorMessage = result.data.error;
                                                }

                                                // Process error code and set appropriate title
                                                if (result.data.errorCode) {
                                                    const errorCode = result.data.errorCode;

                                                    // Set error title based on error code ranges
                                                    if (errorCode >= 1000 && errorCode < 2000) {
                                                        // Validation errors (1000-1999)
                                                        errorTitle = "Lỗi thông tin";

                                                        // Handle field-specific validation errors
                                                        if (result.data.fieldErrors) {
                                                            const fieldErrors = result.data.fieldErrors;
                                                            // Add field errors to message if present
                                                            if (Object.keys(fieldErrors).length > 0) {
                                                                errorMessage += "<br><br>Chi tiết lỗi:";
                                                                for (const field in fieldErrors) {
                                                                    errorMessage += "<br>• " + getFieldLabel(field) + ": " + fieldErrors[field];
                                                                }
                                                            }
                                                        }

                                                        // Specific validation error codes
                                                        switch (errorCode) {
                                                            case 1001: // PRODUCT_OUT_OF_STOCK
                                                                errorTitle = "Lỗi kho hàng";
                                                                break;
                                                            case 1002: // PAYMENT_METHOD_NOT_SUPPORTED
                                                                errorTitle = "Lỗi phương thức thanh toán";
                                                                break;
                                                            case 1003: // SHIPPING_ADDRESS_INVALID
                                                                errorTitle = "Lỗi địa chỉ giao hàng";
                                                                break;
                                                            case 1004: // INVALID_DISCOUNT_CODE
                                                                errorTitle = "Lỗi mã giảm giá";
                                                                break;
                                                            case 1005: // INVALID_PHONE_NUMBER
                                                            case 1006: // INVALID_EMAIL_FORMAT
                                                                errorTitle = "Lỗi thông tin liên hệ";
                                                                break;
                                                        }
                                                    }
                                                    else if (errorCode >= 2000 && errorCode < 3000) {
                                                        // Resource not found errors (2000-2999)
                                                        errorTitle = "Không tìm thấy thông tin";
                                                        switch (errorCode) {
                                                            case 2001: // CUSTOMER_NOT_FOUND
                                                                errorTitle = "Không tìm thấy khách hàng";
                                                                break;
                                                            case 2002: // PRODUCT_NOT_FOUND
                                                                errorTitle = "Không tìm thấy sản phẩm";
                                                                break;
                                                            case 2003: // ORDER_NOT_FOUND
                                                                errorTitle = "Không tìm thấy đơn hàng";
                                                                break;
                                                        }
                                                    }
                                                    else if (errorCode >= 3000 && errorCode < 4000) {
                                                        // Authentication/Authorization errors (3000-3999)
                                                        errorTitle = "Lỗi quyền truy cập";
                                                        switch (errorCode) {
                                                            case 3001: // UNAUTHORIZED_ACCESS
                                                            case 3002: // INSUFFICIENT_PERMISSIONS
                                                                errorTitle = "Không có quyền truy cập";
                                                                break;
                                                            case 3003: // AUTHENTICATION_FAILED
                                                            case 3004: // SESSION_EXPIRED
                                                                errorTitle = "Phiên đăng nhập hết hạn";
                                                                // Offer to redirect to login
                                                                errorMessage += "<br><br><button id='redirect-to-login' class='bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded'>Đăng nhập lại</button>";
                                                                break;
                                                        }
                                                    }
                                                    else if (errorCode >= 4000 && errorCode < 5000) {
                                                        // Business logic errors (4000-4999)
                                                        errorTitle = "Lỗi xử lý đơn hàng";
                                                        switch (errorCode) {
                                                            case 4001: // PAYMENT_PROCESSING_ERROR
                                                                errorTitle = "Lỗi thanh toán";
                                                                break;
                                                            case 4002: // ORDER_ALREADY_PROCESSED
                                                                errorTitle = "Đơn hàng đã xử lý";
                                                                break;
                                                            case 4003: // INSUFFICIENT_INVENTORY
                                                            case 4004: // MAX_QUANTITY_EXCEEDED
                                                                errorTitle = "Lỗi số lượng";
                                                                break;
                                                            case 4005: // SHIPPING_CALCULATION_ERROR
                                                                errorTitle = "Lỗi tính phí vận chuyển";
                                                                break;
                                                            case 4006: // DISCOUNT_EXPIRED
                                                            case 4007: // DISCOUNT_USAGE_LIMIT_REACHED
                                                            case 4008: // MINIMUM_ORDER_AMOUNT_NOT_MET
                                                                errorTitle = "Lỗi mã giảm giá";
                                                                break;
                                                        }
                                                    }
                                                    else if (errorCode >= 5000) {
                                                        // System/Technical errors (5000+)
                                                        errorTitle = "Lỗi hệ thống";

                                                        // For system errors, add some general advice
                                                        errorMessage += "<br><br>Vui lòng thử lại sau hoặc liên hệ bộ phận hỗ trợ nếu lỗi vẫn tiếp tục xảy ra.";
                                                    }

                                                    // Add error code to message for reference
                                                    errorMessage += "<br><span class='text-xs text-gray-500'>Mã lỗi: " + errorCode + "</span>";
                                                }
                                            } else if (result.status) {
                                                // Handle HTTP status codes if no specific error data is available
                                                switch (result.status) {
                                                    case 400:
                                                        errorTitle = "Dữ liệu không hợp lệ";
                                                        errorMessage = "Thông tin đơn hàng không hợp lệ. Vui lòng kiểm tra lại.";
                                                        break;
                                                    case 401:
                                                        errorTitle = "Chưa đăng nhập";
                                                        errorMessage = "Vui lòng đăng nhập để tiếp tục đặt hàng.";
                                                        errorMessage += "<br><br><button id='redirect-to-login' class='bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded'>Đăng nhập</button>";
                                                        break;
                                                    case 403:
                                                        errorTitle = "Không có quyền truy cập";
                                                        errorMessage = "Bạn không có quyền thực hiện thao tác này.";
                                                        break;
                                                    case 404:
                                                        errorTitle = "Không tìm thấy";
                                                        errorMessage = "Không tìm thấy dịch vụ đặt hàng. Vui lòng thử lại sau.";
                                                        break;
                                                    case 500:
                                                        errorTitle = "Lỗi máy chủ";
                                                        errorMessage = "Máy chủ đang gặp sự cố. Vui lòng thử lại sau.";
                                                        break;
                                                    default:
                                                        errorTitle = "Lỗi không xác định";
                                                        errorMessage = "Đã xảy ra lỗi không xác định (Mã lỗi HTTP: " + result.status + ")";
                                                }
                                            }

                                            // Hiển thị modal lỗi với thông tin chi tiết
                                            showResponseModal(false, errorTitle, errorMessage);

                                            // Add event listener for redirect to login button if present
                                            setTimeout(() => {
                                                const redirectBtn = document.getElementById('redirect-to-login');
                                                if (redirectBtn) {
                                                    redirectBtn.addEventListener('click', function () {
                                                        window.location.href = '${ctx}/login';
                                                    });
                                                }
                                            }, 100);
                                        }
                                    })
                                    .catch(error => {
                                        // Xóa loading overlay
                                        removeLoadingOverlay();

                                        console.error('Lỗi khi gửi dữ liệu:', error);

                                        // Hiển thị modal lỗi mạng - chỉ khi không có response từ server
                                        showResponseModal(false, "Lỗi kết nối",
                                            "Không thể kết nối đến máy chủ. Vui lòng kiểm tra kết nối internet và thử lại sau.");
                                    });
                            } else {
                                // Xóa loading overlay
                                removeLoadingOverlay();

                                console.error('Không tìm thấy hàm orderHandler.prepareOrderData hoặc updateOrderData');

                                // Hiển thị modal lỗi
                                showResponseModal(false, "Lỗi hệ thống",
                                    "Không thể chuẩn bị dữ liệu đơn hàng. Vui lòng tải lại trang và thử lại.");
                            }
                        });
                    }

                    // Thêm CSS cho loading spinner
                    const styleEl = document.createElement('style');
                    styleEl.textContent =
                        '@keyframes spin {' +
                        '    0% { transform: rotate(0deg); }' +
                        '    100% { transform: rotate(360deg); }' +
                        '}' +
                        '.loading-spinner svg {' +
                        '    animation: spin 1s linear infinite;' +
                        '}';
                    document.head.appendChild(styleEl);
                });

                /**
                 * Helper function to convert field names to user-friendly labels
                 */
                function getFieldLabel(fieldName) {
                    const fieldLabels = {
                        'customerId': 'ID khách hàng',
                        'customerInfo': 'Thông tin khách hàng',
                        'customerInfo.fullName': 'Họ tên',
                        'customerInfo.email': 'Email',
                        'customerInfo.phone': 'Số điện thoại',
                        'shippingAddress': 'Địa chỉ giao hàng',
                        'shippingAddress.recipientName': 'Tên người nhận',
                        'shippingAddress.recipientPhone': 'Số điện thoại người nhận',
                        'payment.method': 'Phương thức thanh toán',
                        // Add more field mappings as needed
                    };

                    return fieldLabels[fieldName] || fieldName;
                }

                // Update the showResponseModal function to support HTML content
                function showResponseModal(isSuccess, title, message, orderId = null) {
                    // Remove existing modals
                    const existingModal = document.getElementById('response-modal');
                    if (existingModal) {
                        existingModal.remove();
                    }

                    // Create modal
                    const modal = document.createElement('div');
                    modal.id = 'response-modal';
                    modal.className = 'fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50';

                    // Icon for success/error
                    const iconSvg = isSuccess
                        ? '<svg class="h-16 w-16 text-green-500 mb-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg>'
                        : '<svg class="h-16 w-16 text-red-500 mb-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg>';

                    // Action buttons
                    let actionButton = '';
                    if (isSuccess) {
                        if (orderId) {
                            actionButton = '<a href="' + '${pageContext.request.contextPath}/user/orders/' + orderId + '" class="bg-green-500 hover:bg-green-600 text-white font-bold py-2 px-6 rounded-lg transition duration-200">Xem đơn hàng</a>';
                        } else {
                            actionButton = '<button id="close-response-modal" class="bg-green-500 hover:bg-green-600 text-white font-bold py-2 px-6 rounded-lg transition duration-200">Đóng</button>';
                        }
                    } else {
                        actionButton = '<button id="close-response-modal" class="bg-gray-500 hover:bg-gray-600 text-white font-bold py-2 px-6 rounded-lg transition duration-200">Đóng</button>';
                    }

                    // Set modal content
                    const colorClass = isSuccess ? 'text-green-600' : 'text-red-600';
                    modal.innerHTML =
                        '<div class="bg-white p-8 rounded-lg shadow-xl max-w-md w-full mx-4">' +
                        '<div class="flex flex-col items-center text-center">' +
                        iconSvg +
                        '<h2 class="text-2xl font-bold mb-2 ' + colorClass + '">' + title + '</h2>' +
                        '<div class="text-gray-600 mb-6">' + message + '</div>' +
                        '<div class="flex space-x-4">' +
                        actionButton +
                        '</div>' +
                        '</div>' +
                        '</div>';

                    document.body.appendChild(modal);

                    // Add event listener
                    const closeBtn = document.getElementById('close-response-modal');
                    if (closeBtn) {
                        closeBtn.addEventListener('click', function () {
                            modal.remove();
                        });
                    }
                }

                // Function to show a toast notification
                function showToast(message, isSuccess = true) {
                    const existingToast = document.getElementById('ajax-toast');
                    if (existingToast) {
                        existingToast.remove();
                    }

                    const toast = document.createElement('div');
                    toast.id = 'ajax-toast';
                    toast.className = `fixed bottom-4 right-4 ${isSuccess ? 'bg-green-500' : 'bg-red-500'} text-white py-2 px-4 rounded-md shadow-lg z-50 transition-opacity duration-500`;
                    toast.innerHTML = message;

                    document.body.appendChild(toast);

                    // Fade in
                    setTimeout(() => {
                        toast.classList.add('opacity-100');
                    }, 10);

                    // Auto remove after 3 seconds
                    setTimeout(() => {
                        toast.classList.add('opacity-0');
                        setTimeout(() => {
                            toast.remove();
                        }, 500);
                    }, 3000);
                }

                // Add localStorage integration for selectedAddress persistence
                document.addEventListener('DOMContentLoaded', function () {
                    // Initialize selectedAddress from localStorage if available
                    const storedAddress = localStorage.getItem('selectedAddress');

                    if (storedAddress) {
                        try {
                            // Parse the stored address
                            const parsedAddress = JSON.parse(storedAddress);

                            // Update UI with the stored address information
                            const recipientName = document.getElementById('recipient-name');
                            const recipientPhone = document.getElementById('recipient-phone');
                            const recipientAddress = document.getElementById('recipient-address');

                            if (recipientName && parsedAddress.recipientName) {
                                recipientName.textContent = parsedAddress.recipientName;
                            }

                            if (recipientPhone && parsedAddress.recipientPhone) {
                                recipientPhone.textContent = parsedAddress.recipientPhone;
                            }

                            if (recipientAddress) {
                                const addressDetail = [
                                    parsedAddress.detailAddress,
                                    parsedAddress.wardName,
                                    parsedAddress.districtName,
                                    parsedAddress.provinceName
                                ].filter(Boolean).join(', ');

                                recipientAddress.textContent = addressDetail;
                            }

                            // Initialize ghnState with geographic data from stored address
                            if (!window.ghnState) {
                                window.ghnState = {};
                            }

                            window.ghnState.toProvinceId = parsedAddress.provinceId;
                            window.ghnState.toDistrictId = parsedAddress.districtId;
                            window.ghnState.toWardCode = parsedAddress.wardCode;

                            console.log('Loaded address from localStorage:', parsedAddress);
                            console.log('Initialized ghnState:', window.ghnState);

                            // If we have shipping fee info already stored, update the UI
                            if (parsedAddress.shippingFee !== undefined) {
                                window.ghnState.shippingFeeValue = parsedAddress.shippingFee;
                                updateShippingFeeDisplay(parsedAddress.shippingFee);
                                updateOrderTotalWithShipping(parsedAddress.shippingFee);
                                console.log('Restored shipping fee:', parsedAddress.shippingFee);
                            }
                        } catch (error) {
                            console.error('Error parsing stored address:', error);
                        }
                    } else {
                        // If no stored address, initialize from default address
                        initializeFromDefaultAddress();
                    }
                });

                // Function to initialize from default address (from customerAddressesv2)
                function initializeFromDefaultAddress() {
                    const addressesData = document.getElementById('formatted-addresses-data');
                    if (addressesData && addressesData.value) {
                        try {
                            const addresses = JSON.parse(addressesData.value);
                            if (addresses && addresses.length > 0) {
                                // Find default address or use first one
                                const defaultAddress = addresses.find(addr => addr.isDefault) || addresses[0];

                                if (defaultAddress) {
                                    // Create selectedAddress object
                                    const selectedAddress = {
                                        addressId: defaultAddress.addressId,
                                        recipientName: defaultAddress.recipientName,
                                        recipientPhone: defaultAddress.recipientPhone,
                                        provinceId: defaultAddress.provinceId,
                                        provinceName: defaultAddress.provinceName,
                                        districtId: defaultAddress.districtId,
                                        districtName: defaultAddress.districtName,
                                        wardCode: defaultAddress.wardCode,
                                        wardName: defaultAddress.wardName,
                                        detailAddress: defaultAddress.detailAddress,
                                        isDefault: defaultAddress.isDefault
                                    };

                                    // Save to localStorage
                                    localStorage.setItem('selectedAddress', JSON.stringify(selectedAddress));

                                    // Initialize ghnState
                                    if (!window.ghnState) {
                                        window.ghnState = {};
                                    }

                                    window.ghnState.toProvinceId = defaultAddress.provinceId;
                                    window.ghnState.toDistrictId = defaultAddress.districtId;
                                    window.ghnState.toWardCode = defaultAddress.wardCode;

                                    console.log('Initialized from default address:', selectedAddress);
                                    console.log('Initialized ghnState:', window.ghnState);
                                }
                            }
                        } catch (e) {
                            console.error('Error parsing addresses data:', e);
                        }
                    }
                }

                // Function to update shipping fee display
                function updateShippingFeeDisplay(fee) {
                    // Convert from VND to USD if needed (approximate conversion)
                    // GHN shipping fees are in VND, but our display is in USD
                    const feeInUSD = typeof fee === 'number' ? fee / 25000 : 0; // Rough conversion rate

                    const shippingCostElement = document.getElementById('shipping-cost-summary');
                    if (shippingCostElement) {
                        shippingCostElement.textContent = '$' + feeInUSD.toFixed(2);
                        console.log('Updated shipping cost display to: $' + feeInUSD.toFixed(2));
                    }

                    // Also update the shipping fee result section if visible
                    const shippingFeeResult = document.getElementById('shipping-fee-result');
                    if (shippingFeeResult) {
                        shippingFeeResult.style.display = 'block';

                        // If the shipping fee result has a specific format with spans
                        const feeAmountSpan = shippingFeeResult.querySelector('#shipping-fee-amount');
                        if (feeAmountSpan) {
                            // If using the structured format from handle.jsp
                            feeAmountSpan.textContent = fee.toLocaleString(); // Format in VND
                        } else {
                            // Simple text format
                            shippingFeeResult.textContent = 'Phí vận chuyển: $' + feeInUSD.toFixed(2);
                        }
                    }

                    // Update the order total with this shipping fee
                    updateOrderTotalWithShipping(feeInUSD);
                }

                // Function to update order total with shipping
                function updateOrderTotalWithShipping(shippingFeeUSD) {
                    const subtotalElement = document.getElementById('cart-subtotal');
                    const totalElement = document.getElementById('total-with-discount');
                    const discountElement = document.getElementById('discount-amount');

                    if (subtotalElement && totalElement) {
                        // Parse the subtotal from the display (already in USD)
                        const subtotal = parseFloat(subtotalElement.textContent.replace('$', '')) || 0;

                        // Check if there are any discounts applied
                        let discount = 0;
                        if (discountElement && !discountElement.closest('.hidden')) {
                            const discountText = discountElement.textContent.replace('-$', '');
                            discount = parseFloat(discountText) || 0;
                        }

                        // Store shipping fee in USD in window.ghnState for other calculations
                        if (window.ghnState) {
                            window.ghnState.shippingFeeUSD = shippingFeeUSD;
                        }

                        // Calculate new total with shipping and discount
                        const newTotal = subtotal - discount + (shippingFeeUSD || 0);
                        totalElement.textContent = '$' + newTotal.toFixed(2);

                        console.log('Updated order total with shipping:', {
                            subtotal: subtotal,
                            discount: discount,
                            shippingFee: shippingFeeUSD,
                            newTotal: newTotal.toFixed(2)
                        });
                    }
                }

                document.addEventListener('DOMContentLoaded', function () {
                    // Function to update shipping fee in selectedAddress localStorage
                    function updateStoredAddressWithShippingFee(shippingFee) {
                        try {
                            const storedAddress = localStorage.getItem('selectedAddress');
                            if (storedAddress) {
                                const addressObj = JSON.parse(storedAddress);
                                addressObj.shippingFee = shippingFee;
                                localStorage.setItem('selectedAddress', JSON.stringify(addressObj));
                                console.log('Updated selectedAddress in localStorage with shipping fee:', shippingFee);
                            }
                        } catch (e) {
                            console.error('Error updating shipping fee in localStorage:', e);
                        }
                    }

                    // Override calculateShippingFee when it's available
                    function setupShippingFeeInterceptor() {
                        // Wait for the original calculateShippingFee function to be available
                        if (typeof window.calculateShippingFee === 'function') {
                            console.log('Intercepting calculateShippingFee to add localStorage shipping fee updates');

                            // Store the original function
                            const originalCalculateShippingFee = window.calculateShippingFee;

                            // Replace with our enhanced version
                            window.calculateShippingFee = async function () {
                                // Call the original function and get its result
                                const result = await originalCalculateShippingFee.apply(this, arguments);

                                // After calculation, update localStorage if shippingFeeValue was set
                                if (window.ghnState && window.ghnState.shippingFeeValue !== null) {
                                    updateStoredAddressWithShippingFee(window.ghnState.shippingFeeValue);
                                }

                                return result;
                            };

                            console.log('Successfully intercepted calculateShippingFee');
                        } else {
                            // Try again in 100ms if the function isn't available yet
                            setTimeout(setupShippingFeeInterceptor, 100);
                        }
                    }

                    // Start trying to set up the interceptor
                    setupShippingFeeInterceptor();
                });
            </script>