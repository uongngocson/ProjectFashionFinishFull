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
                </style>
            </head>




            <body class="min-h-screen">
                <!-- navbar -->

                <!-- Hidden input for addresses data -->

                <!-- Helper script for error handling to avoid JSP EL conflicts -->
                <script>
                    function handleError(prefix, error) {
                        if (error && error.response && error.response.data && error.response.data.message) {
                            return prefix + ': ' + error.response.data.message;
                        } else if (error && error.message) {
                            return prefix + ': ' + error.message;
                        } else {
                            return prefix + ': Unknown error';
                        }
                    }
                </script>








                <!-- Console log address values -->
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        // From address selects
                        const fromProvinceSelect = document.getElementById('fromProvince');
                        const fromDistrictSelect = document.getElementById('fromDistrict');
                        const fromWardSelect = document.getElementById('fromWard');

                        // To address selects
                        const toProvinceSelect = document.getElementById('toProvince');
                        const toDistrictSelect = document.getElementById('toDistrict');
                        const toWardSelect = document.getElementById('toWard');

                        // Log from address values
                        if (fromProvinceSelect) {
                            fromProvinceSelect.addEventListener('change', function () {
                                console.log('From Province:', {
                                    provinceId: this.value,
                                    provinceName: this.options[this.selectedIndex]?.text || 'None'
                                });
                            });
                        }

                        if (fromDistrictSelect) {
                            fromDistrictSelect.addEventListener('change', function () {
                                console.log('From District:', {
                                    districtId: this.value,
                                    districtName: this.options[this.selectedIndex]?.text || 'None'
                                });
                            });
                        }

                        if (fromWardSelect) {
                            fromWardSelect.addEventListener('change', function () {
                                console.log('From Ward:', {
                                    wardCode: this.value,
                                    wardName: this.options[this.selectedIndex]?.text || 'None'
                                });
                            });
                        }

                        // Log to address values
                        if (toProvinceSelect) {
                            toProvinceSelect.addEventListener('change', function () {
                                console.log('To Province:', {
                                    provinceId: this.value,
                                    provinceName: this.options[this.selectedIndex]?.text || 'None'
                                });
                            });
                        }

                        if (toDistrictSelect) {
                            toDistrictSelect.addEventListener('change', function () {
                                console.log('To District:', {
                                    districtId: this.value,
                                    districtName: this.options[this.selectedIndex]?.text || 'None'
                                });
                            });
                        }

                        if (toWardSelect) {
                            toWardSelect.addEventListener('change', function () {
                                console.log('To Ward:', {
                                    wardCode: this.value,
                                    wardName: this.options[this.selectedIndex]?.text || 'None'
                                });
                            });
                        }

                        // Log when clicking calculate button
                        const calculateBtn = document.getElementById('calculateShippingBtn');
                        if (calculateBtn) {
                            calculateBtn.addEventListener('click', function () {
                                console.log('--- SHIPPING CALCULATION DATA ---');
                                console.log('From Address:', {
                                    provinceId: fromProvinceSelect?.value,
                                    districtId: fromDistrictSelect?.value,
                                    wardCode: fromWardSelect?.value
                                });
                                console.log('To Address:', {
                                    provinceId: toProvinceSelect?.value,
                                    districtId: toDistrictSelect?.value,
                                    wardCode: toWardSelect?.value,
                                    detail: document.getElementById('detailAddress')?.value
                                });
                            });
                        }

                        // Log when saving address
                        const saveBtn = document.getElementById('saveAddressBtn');
                        if (saveBtn) {
                            saveBtn.addEventListener('click', function () {
                                console.log('--- SAVING ADDRESS DATA ---');
                                console.log('Personal Info:', {
                                    name: document.getElementById('fullNameEdit')?.value,
                                    phone: document.getElementById('phoneEdit')?.value
                                });
                                console.log('Address Details:', {
                                    provinceId: toProvinceSelect?.value,
                                    districtId: toDistrictSelect?.value,
                                    wardCode: toWardSelect?.value,
                                    detail: document.getElementById('detailAddress')?.value
                                });
                            });
                        }
                    });
                </script>

                <!-- Địa Chỉ Storage Script -->
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        // Khởi tạo mảng địa chỉ từ model hoặc từ localStorage nếu chưa có
                        let modelAddresses;
                        try {
                            modelAddresses = JSON.parse('${addressDataJson}' || '[]');
                        } catch (e) {
                            console.error('Error parsing address data from model:', e);
                            modelAddresses = [];
                        }

                        let savedAddresses = modelAddresses.length > 0 ?
                            modelAddresses :
                            JSON.parse(localStorage.getItem('userAddresses') || '[]');

                        // Log để kiểm tra dữ liệu địa chỉ
                        console.log('Addresses loaded------------------------------:', savedAddresses);

                        // Lấy thông tin mặc định từ model
                        let defaultAddress;
                        try {
                            defaultAddress = JSON.parse('${defaultAddressJson}' || '{}');
                        } catch (e) {
                            console.error('Error parsing default address from model:', e);
                            defaultAddress = {};
                        }

                        const defaultFullName = defaultAddress.name || document.getElementById('recipient-name')?.textContent || '';
                        const defaultPhone = defaultAddress.phone || document.getElementById('recipient-phone')?.textContent || '';
                        const defaultFullAddress = defaultAddress.fullAddress || document.getElementById('recipient-address')?.textContent || '';

                        // Hàm xử lý dữ liệu địa chỉ để đảm bảo có đủ các giá trị cần thiết
                        function processAddressData(addressData) {
                            // Nếu không có trường name (hoặc trống), sử dụng defaultFullName
                            if (!addressData.name || addressData.name.trim() === '') {
                                console.log(`[Address Processing] Name is missing, using default name: ${defaultFullName}`);
                                addressData.name = defaultFullName.trim();
                            }

                            // Nếu không có trường phone (hoặc trống), sử dụng defaultPhone
                            if (!addressData.phone || addressData.phone.trim() === '') {
                                console.log(`[Address Processing] Phone is missing, using default phone: ${defaultPhone}`);
                                addressData.phone = defaultPhone.trim();
                            }

                            return addressData;
                        }

                        // Xử lý tất cả địa chỉ đã lưu để đảm bảo có đủ thông tin
                        for (let i = 0; i < savedAddresses.length; i++) {
                            savedAddresses[i] = processAddressData(savedAddresses[i]);
                        }

                        // Lưu lại danh sách địa chỉ đã được xử lý
                        localStorage.setItem('userAddresses', JSON.stringify(savedAddresses));

                        // Nếu chưa có địa chỉ nào, thêm địa chỉ mặc định từ model
                        if (savedAddresses.length === 0 && defaultAddress.name) {
                            savedAddresses.push({
                                id: generateUniqueId(),
                                name: defaultFullName.trim(),
                                phone: defaultPhone.trim(),
                                fullAddress: defaultFullAddress.trim(),
                                provinceId: defaultAddress.provinceId || '',
                                provinceName: defaultAddress.provinceName || '',
                                districtId: defaultAddress.districtId || '',
                                districtName: defaultAddress.districtName || '',
                                wardCode: defaultAddress.wardCode || '',
                                wardName: defaultAddress.wardName || '',
                                detailAddress: defaultFullAddress.trim(),
                                isDefault: true
                            });

                            // Lưu vào localStorage
                            localStorage.setItem('userAddresses', JSON.stringify(savedAddresses));
                        }

                        // Hiển thị địa chỉ mặc định từ model khi trang vừa tải
                        if (defaultAddress.name && defaultAddress.phone && defaultAddress.fullAddress) {
                            const recipientName = document.getElementById('recipient-name');
                            const recipientPhone = document.getElementById('recipient-phone');
                            const recipientAddress = document.getElementById('recipient-address');

                            if (recipientName) recipientName.textContent = defaultAddress.name;
                            if (recipientPhone) recipientPhone.textContent = defaultAddress.phone;
                            if (recipientAddress) recipientAddress.textContent = defaultAddress.fullAddress;
                        } else {
                            // Không có địa chỉ từ model, thử tìm địa chỉ mặc định từ localStorage
                            const defaultAddressFromStorage = savedAddresses.find(addr => addr.isDefault);
                            if (defaultAddressFromStorage) {
                                updateDisplayedAddress(defaultAddressFromStorage);
                            }
                        }

                        // Tạo ID duy nhất cho mỗi địa chỉ
                        // Tạo ID duy nhất với tối đa 9 chữ số
                        function generateUniqueId() {
                            // Tạo số ngẫu nhiên từ 100000000 đến 999999999 (9 chữ số)
                            return Math.floor(100000000 + Math.random() * 900000000).toString();
                        }


                        // Lưu địa chỉ mới
                        const saveAddressBtn = document.getElementById('saveAddressBtn');
                        if (saveAddressBtn) {
                            saveAddressBtn.addEventListener('click', function () {
                                const fromProvinceSelect = document.getElementById('fromProvince');
                                const fromDistrictSelect = document.getElementById('fromDistrict');
                                const fromWardSelect = document.getElementById('fromWard');
                                const toProvinceSelect = document.getElementById('toProvince');
                                const toDistrictSelect = document.getElementById('toDistrict');
                                const toWardSelect = document.getElementById('toWard');
                                const fullNameEdit = document.getElementById('fullNameEdit');
                                const phoneEdit = document.getElementById('phoneEdit');
                                const detailAddress = document.getElementById('detailAddress');

                                // Kiểm tra dữ liệu hợp lệ
                                if (!toProvinceSelect?.value || !toDistrictSelect?.value || !toWardSelect?.value ||
                                    (!fullNameEdit?.value && !defaultFullName) ||
                                    (!phoneEdit?.value && !defaultPhone) ||
                                    !detailAddress?.value) {
                                    alert('Vui lòng điền đầy đủ thông tin địa chỉ');
                                    return;
                                }

                                // Tạo đối tượng địa chỉ mới
                                let newAddress = {
                                    id: generateUniqueId(),
                                    name: fullNameEdit?.value?.trim() || '',
                                    phone: phoneEdit?.value?.trim() || '',
                                    provinceId: toProvinceSelect.value,
                                    provinceName: toProvinceSelect.options[toProvinceSelect.selectedIndex] ? toProvinceSelect.options[toProvinceSelect.selectedIndex].text : '',
                                    districtId: toDistrictSelect.value,
                                    districtName: toDistrictSelect.options[toDistrictSelect.selectedIndex] ? toDistrictSelect.options[toDistrictSelect.selectedIndex].text : '',
                                    wardCode: toWardSelect.value,
                                    wardName: toWardSelect.options[toWardSelect.selectedIndex] ? toWardSelect.options[toWardSelect.selectedIndex].text : '',
                                    detailAddress: detailAddress.value.trim(),
                                    fullAddress: detailAddress.value.trim() +
                                        ', ' + (toWardSelect.options[toWardSelect.selectedIndex] ? toWardSelect.options[toWardSelect.selectedIndex].text : '') +
                                        ', ' + (toDistrictSelect.options[toDistrictSelect.selectedIndex] ? toDistrictSelect.options[toDistrictSelect.selectedIndex].text : '') +
                                        ', ' + (toProvinceSelect.options[toProvinceSelect.selectedIndex] ? toProvinceSelect.options[toProvinceSelect.selectedIndex].text : ''),
                                    isDefault: savedAddresses.length === 0 // Đặt mặc định nếu là địa chỉ đầu tiên
                                };

                                // Xử lý để đảm bảo có đủ thông tin người nhận
                                newAddress = processAddressData(newAddress);

                                // Đảm bảo form được cập nhật với các giá trị đã được xử lý
                                if (fullNameEdit && newAddress.name !== fullNameEdit.value.trim()) {
                                    fullNameEdit.value = newAddress.name;
                                }

                                if (phoneEdit && newAddress.phone !== phoneEdit.value.trim()) {
                                    phoneEdit.value = newAddress.phone;
                                }

                                // Thêm vào mảng địa chỉ
                                savedAddresses.push(newAddress);

                                // Lưu vào localStorage
                                localStorage.setItem('userAddresses', JSON.stringify(savedAddresses));

                                // Cập nhật giao diện hiển thị địa chỉ
                                updateDisplayedAddress(newAddress);

                                // Ẩn form nhập địa chỉ
                                document.getElementById('shipping-form').style.display = 'none';

                                alert('Đã lưu địa chỉ thành công!');

                                // Cập nhật modal địa chỉ
                                updateAddressModal();
                            });
                        }

                        // Cập nhật địa chỉ hiển thị trên trang
                        function updateDisplayedAddress(address) {
                            // Đảm bảo địa chỉ được xử lý để có đủ thông tin
                            const processedAddress = processAddressData(address);

                            // Hiển thị địa chỉ đã được xử lý
                            const recipientName = document.getElementById('recipient-name');
                            const recipientPhone = document.getElementById('recipient-phone');
                            const recipientAddress = document.getElementById('recipient-address');

                            if (recipientName) recipientName.textContent = processedAddress.name;
                            if (recipientPhone) recipientPhone.textContent = processedAddress.phone;
                            if (recipientAddress) recipientAddress.textContent = processedAddress.fullAddress;

                            console.log('[Address Display] Original address:', address);
                            console.log('[Address Display] Processed and displayed address:', processedAddress);

                            // THÊM MỚI: Đồng bộ địa chỉ đã chọn với GHN API để tính phí vận chuyển ngay lập tức
                            syncAddressWithGHNApi(processedAddress);
                        }

                        // THÊM MỚI: Hàm đồng bộ địa chỉ với GHN API
                        function syncAddressWithGHNApi(address) {
                            console.log('[GHN Sync] Starting to sync address with GHN API:', address);

                            // Đảm bảo window.ghnState đã được khởi tạo
                            if (typeof window.ghnState === 'undefined') {
                                console.log('[GHN Sync] Waiting for GHN state to initialize...');
                                // Nếu chưa khởi tạo, đặt một timeout để đợi
                                setTimeout(() => syncAddressWithGHNApi(address), 500);
                                return;
                            }

                            // Đảm bảo rằng chúng ta có các giá trị cần thiết
                            if (!address.provinceId || !address.districtId || !address.wardCode) {
                                console.log('[GHN Sync] Missing required address data for GHN API sync. Skipping.');
                                return;
                            }

                            // Cập nhật ghnState với thông tin địa chỉ
                            window.ghnState.selectedToProvince = parseInt(address.provinceId);
                            window.ghnState.selectedToDistrict = parseInt(address.districtId);
                            window.ghnState.selectedToWard = address.wardCode;

                            console.log('[GHN Sync] Updated ghnState with address data:', {
                                province: window.ghnState.selectedToProvince,
                                district: window.ghnState.selectedToDistrict,
                                ward: window.ghnState.selectedToWard
                            });

                            // Cập nhật các select element nếu đã được render
                            const toProvinceSelect = document.getElementById('toProvince');
                            const toDistrictSelect = document.getElementById('toDistrict');
                            const toWardSelect = document.getElementById('toWard');

                            // Đảm bảo các select đã được render và có options
                            const updateSelectsAndCalculate = () => {
                                console.log('[GHN Sync] Checking if selects are ready to update...');

                                // Nếu các select chưa sẵn sàng, thử lại sau
                                if (!toProvinceSelect || !toProvinceSelect.options.length ||
                                    !toDistrictSelect || !toDistrictSelect.options.length ||
                                    !toWardSelect || !toWardSelect.options.length) {
                                    console.log('[GHN Sync] Selects not ready yet. Trying again in 500ms...');
                                    setTimeout(updateSelectsAndCalculate, 500);
                                    return;
                                }

                                try {
                                    // Cập nhật các select với giá trị từ địa chỉ
                                    for (let i = 0; i < toProvinceSelect.options.length; i++) {
                                        if (toProvinceSelect.options[i].value == address.provinceId) {
                                            toProvinceSelect.selectedIndex = i;
                                            console.log('[GHN Sync] Set province select to:', address.provinceId);
                                            break;
                                        }
                                    }

                                    // Trigger sự kiện change để load districts
                                    const provinceChangeEvent = new Event('change', { bubbles: true });
                                    toProvinceSelect.dispatchEvent(provinceChangeEvent);

                                    // Đặt timeout để đợi districts load
                                    setTimeout(() => {
                                        for (let i = 0; i < toDistrictSelect.options.length; i++) {
                                            if (toDistrictSelect.options[i].value == address.districtId) {
                                                toDistrictSelect.selectedIndex = i;
                                                console.log('[GHN Sync] Set district select to:', address.districtId);
                                                break;
                                            }
                                        }

                                        // Trigger sự kiện change để load wards
                                        const districtChangeEvent = new Event('change', { bubbles: true });
                                        toDistrictSelect.dispatchEvent(districtChangeEvent);

                                        // Đặt timeout để đợi wards load
                                        setTimeout(() => {
                                            for (let i = 0; i < toWardSelect.options.length; i++) {
                                                if (toWardSelect.options[i].value == address.wardCode) {
                                                    toWardSelect.selectedIndex = i;
                                                    console.log('[GHN Sync] Set ward select to:', address.wardCode);
                                                    break;
                                                }
                                            }

                                            // Cập nhật chi tiết địa chỉ nếu có
                                            const detailAddressInput = document.getElementById('detailAddress');
                                            if (detailAddressInput && address.detailAddress) {
                                                detailAddressInput.value = address.detailAddress;
                                            }

                                            // Tự động tính phí vận chuyển
                                            console.log('[GHN Sync] All address data set, calculating shipping fee...');
                                            if (typeof calculateShippingFee === 'function') {
                                                // Gọi hàm tính phí vận chuyển
                                                calculateShippingFee().then(() => {
                                                    console.log('[GHN Sync] Shipping fee calculation completed');

                                                    // Hiển thị kết quả nếu chưa hiển thị
                                                    const shippingFeeResult = document.getElementById('shipping-fee-result');
                                                    if (shippingFeeResult) {
                                                        shippingFeeResult.style.display = 'block';
                                                    }
                                                }).catch(err => {
                                                    console.error('[GHN Sync] Error calculating shipping fee:', err);
                                                });
                                            } else {
                                                console.log('[GHN Sync] calculateShippingFee function not available yet');
                                            }
                                        }, 500);
                                    }, 500);
                                } catch (err) {
                                    console.error('[GHN Sync] Error updating selects:', err);
                                }
                            };

                            // Bắt đầu quá trình cập nhật sau khi GHN API đã được khởi tạo
                            if (window.ghnState.provinces && window.ghnState.provinces.length > 0) {
                                console.log('[GHN Sync] GHN state initialized, continuing with select updates');
                                updateSelectsAndCalculate();
                            } else {
                                console.log('[GHN Sync] GHN provinces not loaded yet, waiting...');
                                // Kiểm tra mỗi 500ms xem GHN API đã khởi tạo chưa
                                const checkGhnInitialized = setInterval(() => {
                                    if (window.ghnState.provinces && window.ghnState.provinces.length > 0) {
                                        clearInterval(checkGhnInitialized);
                                        console.log('[GHN Sync] GHN provinces loaded, continuing with select updates');
                                        updateSelectsAndCalculate();
                                    }
                                }, 500);

                                // Dừng kiểm tra sau 10 giây nếu GHN API không khởi tạo
                                setTimeout(() => {
                                    clearInterval(checkGhnInitialized);
                                    console.log('[GHN Sync] Timed out waiting for GHN API initialization');
                                }, 10000);
                            }
                        }

                        // Cập nhật danh sách địa chỉ trong modal
                        function updateAddressModal() {
                            const addressModalContent = document.querySelector('#address-modal .p-6:not(.border-t):not(.border-b)');
                            if (!addressModalContent) return;

                            // Xóa nội dung cũ
                            addressModalContent.innerHTML = '';
                            console.log('savedAddresses', savedAddresses); // check lại mảng địa chỉ ddang luuw tin local 

                            // Kiểm tra nếu không có địa chỉ
                            if (savedAddresses.length === 0) {
                                addressModalContent.innerHTML = '<div class="text-center py-4 text-gray-500">Bạn chưa có địa chỉ nào. Vui lòng thêm địa chỉ mới.</div>';
                            } else {
                                // Thêm các địa chỉ vào modal
                                savedAddresses.forEach((address, index) => {
                                    // Xử lý địa chỉ trước khi hiển thị để đảm bảo đủ thông tin
                                    const processedAddress = processAddressData(address);

                                    const addressElement = document.createElement('div');
                                    addressElement.className = 'border rounded-md p-4 mb-4 relative ' + (processedAddress.isDefault ? 'border-orange-500 bg-orange-50' : 'border-gray-200');
                                    addressElement.setAttribute('data-address-id', processedAddress.id);

                                    const addressHtml =
                                        '<div class="flex justify-between">' +
                                        '<div>' +
                                        '<div class="flex items-center mb-2">' +
                                        '<span class="font-medium">' + processedAddress.name + '</span>' +
                                        '<span class="ml-3 text-sm text-gray-500">' + processedAddress.phone + '</span>' +
                                        (processedAddress.isDefault ? '<span class="ml-3 px-2 py-1 bg-red-100 text-red-800 text-xs font-medium rounded">Mặc Định</span>' : '') +
                                        '</div>' +
                                        '<p class="text-gray-700">' + processedAddress.fullAddress + '</p>' +
                                        '</div>' +
                                        '<div class="flex flex-col">' +
                                        '<button class="text-blue-600 hover:text-blue-800 font-medium mb-2 edit-address-btn" data-index="' + index + '">Sửa</button>' +
                                        (!processedAddress.isDefault ? '<button class="text-red-600 hover:text-red-800 font-medium delete-address-btn" data-index="' + index + '">Xóa</button>' : '') +
                                        (!processedAddress.isDefault ? '<button class="text-orange-600 hover:text-orange-800 font-medium mt-2 set-default-btn" data-index="' + index + '">Đặt mặc định</button>' : '') +
                                        '</div>' +
                                        '</div>';

                                    addressElement.innerHTML = addressHtml;
                                    addressModalContent.appendChild(addressElement);
                                });
                            }

                            // Thêm button để thêm địa chỉ mới
                            const addNewBtn = document.createElement('button');
                            addNewBtn.className = 'w-full border border-dashed border-gray-300 rounded-md p-4 text-center hover:bg-gray-50';
                            addNewBtn.innerHTML = '<span class="text-blue-600 font-medium">+ Thêm địa chỉ mới</span>';
                            addNewBtn.addEventListener('click', function () {
                                document.getElementById('address-modal').style.display = 'none';

                                // Đảm bảo form shipping được hiển thị đúng và scroll đến vị trí của nó
                                const shippingForm = document.getElementById('shipping-form');
                                shippingForm.style.display = 'block';

                                // Cuộn đến vị trí của form
                                shippingForm.scrollIntoView({ behavior: 'smooth', block: 'start' });

                                // Reset form
                                document.getElementById('fullNameEdit').value = '';
                                document.getElementById('phoneEdit').value = '';
                                document.getElementById('detailAddress').value = '';

                                // Reset selects nếu cần
                                if (document.getElementById('toProvince')) {
                                    document.getElementById('toProvince').selectedIndex = 0;
                                }

                                // Đảm bảo body có thể scroll
                                document.body.style.overflow = 'auto';
                            });

                            addressModalContent.appendChild(addNewBtn);

                            // Thêm sự kiện cho các button
                            attachAddressButtonEvents();
                        }

                        // Gắn sự kiện cho các button trong modal địa chỉ
                        function attachAddressButtonEvents() {
                            // Sự kiện nút Sửa
                            document.querySelectorAll('.edit-address-btn').forEach(button => {
                                button.addEventListener('click', function () {
                                    const index = parseInt(this.getAttribute('data-index'));
                                    const address = savedAddresses[index];

                                    // Hiển thị form
                                    document.getElementById('address-modal').style.display = 'none';
                                    document.getElementById('shipping-form').style.display = 'block';

                                    // Đảm bảo body có thể scroll lại sau khi đóng modal
                                    document.body.style.overflow = 'auto';

                                    // Cuộn đến vị trí của form shipping để người dùng có thể nhìn thấy
                                    setTimeout(function () {
                                        const shippingForm = document.getElementById('shipping-form');
                                        if (shippingForm) {
                                            shippingForm.scrollIntoView({ behavior: 'smooth', block: 'start' });
                                        }
                                    }, 100);

                                    // Đảm bảo địa chỉ được xử lý đúng trước khi điền vào form
                                    const processedAddress = processAddressData(address);

                                    // Điền dữ liệu vào form
                                    const fullNameEditField = document.getElementById('fullNameEdit');
                                    const phoneEditField = document.getElementById('phoneEdit');

                                    if (fullNameEditField) fullNameEditField.value = processedAddress.name;
                                    if (phoneEditField) phoneEditField.value = processedAddress.phone;

                                    // Chi tiết địa chỉ
                                    const detailAddressField = document.getElementById('detailAddress');
                                    if (detailAddressField) detailAddressField.value = processedAddress.detailAddress || '';

                                    // Debug information
                                    console.log('[Address Edit] Processing address:', address);
                                    console.log('[Address Edit] Processed address:', processedAddress);

                                    // Xóa địa chỉ cũ
                                    savedAddresses.splice(index, 1);
                                    localStorage.setItem('userAddresses', JSON.stringify(savedAddresses));
                                });
                            });

                            // Sự kiện nút Xóa
                            document.querySelectorAll('.delete-address-btn').forEach(button => {
                                button.addEventListener('click', function () {
                                    if (confirm('Bạn có chắc muốn xóa địa chỉ này?')) {
                                        const index = parseInt(this.getAttribute('data-index'));

                                        // Xóa địa chỉ khỏi mảng
                                        savedAddresses.splice(index, 1);

                                        // Lưu mảng mới vào localStorage
                                        localStorage.setItem('userAddresses', JSON.stringify(savedAddresses));

                                        // Nếu vừa xóa hết địa chỉ, hiển thị thông báo thêm địa chỉ mới
                                        if (savedAddresses.length === 0) {
                                            const addressModalContent = document.querySelector('#address-modal .p-6:not(.border-t):not(.border-b)');
                                            if (addressModalContent) {
                                                addressModalContent.innerHTML = '<div class="text-center py-4 text-gray-500">Bạn chưa có địa chỉ nào. Vui lòng thêm địa chỉ mới.</div>';

                                                // Thêm lại nút thêm địa chỉ mới
                                                const addNewBtn = document.createElement('button');
                                                addNewBtn.className = 'w-full border border-dashed border-gray-300 rounded-md p-4 text-center hover:bg-gray-50 mt-4';
                                                addNewBtn.innerHTML = '<span class="text-blue-600 font-medium">+ Thêm địa chỉ mới</span>';
                                                addressModalContent.appendChild(addNewBtn);
                                            }
                                        } else {
                                            // Cập nhật modal nếu còn địa chỉ
                                            updateAddressModal();
                                        }

                                        // Thông báo thành công
                                        alert('Đã xóa địa chỉ thành công!');
                                    }
                                });
                            });

                            // Sự kiện nút Đặt mặc định
                            document.querySelectorAll('.set-default-btn').forEach(button => {
                                button.addEventListener('click', function () {
                                    const index = parseInt(this.getAttribute('data-index'));

                                    // Bỏ mặc định tất cả địa chỉ
                                    savedAddresses.forEach(addr => addr.isDefault = false);

                                    // Đặt địa chỉ được chọn làm mặc định
                                    savedAddresses[index].isDefault = true;
                                    localStorage.setItem('userAddresses', JSON.stringify(savedAddresses));

                                    // Cập nhật giao diện hiển thị địa chỉ
                                    updateDisplayedAddress(savedAddresses[index]);

                                    // THÊM MỚI: Lưu địa chỉ mặc định vào selectedAddress để đảm bảo được sử dụng
                                    localStorage.setItem('selectedAddress', JSON.stringify(savedAddresses[index]));
                                    console.log('Saved default address to selectedAddress:', savedAddresses[index]);

                                    // THÊM MỚI: Đồng bộ trực tiếp với GHN API sau khi đặt địa chỉ mặc định
                                    if (typeof window.ghnState !== 'undefined' && savedAddresses[index].provinceId &&
                                        savedAddresses[index].districtId && savedAddresses[index].wardCode) {
                                        // Cập nhật trực tiếp ghnState
                                        window.ghnState.selectedToProvince = parseInt(savedAddresses[index].provinceId);
                                        window.ghnState.selectedToDistrict = parseInt(savedAddresses[index].districtId);
                                        window.ghnState.selectedToWard = savedAddresses[index].wardCode;

                                        console.log('Updated GHN state with default address data:', {
                                            province: window.ghnState.selectedToProvince,
                                            district: window.ghnState.selectedToDistrict,
                                            ward: window.ghnState.selectedToWard
                                        });

                                        // Tính phí vận chuyển nếu được hiển thị
                                        if (typeof calculateShippingFee === 'function') {
                                            // Đặt timeout để đảm bảo các giá trị đã được cập nhật
                                            setTimeout(() => {
                                                calculateShippingFee().then(() => {
                                                    console.log('Shipping fee calculation completed after setting default address');

                                                    // Hiển thị kết quả
                                                    const shippingFeeResult = document.getElementById('shipping-fee-result');
                                                    if (shippingFeeResult) {
                                                        shippingFeeResult.style.display = 'block';
                                                    }
                                                }).catch(err => {
                                                    console.error('Error calculating shipping fee after setting default address:', err);
                                                });
                                            }, 500);
                                        }
                                    }

                                    // Cập nhật modal
                                    updateAddressModal();

                                    // Thông báo thành công
                                    alert('Đã đặt địa chỉ mặc định thành công!');
                                });
                            });
                        }

                        // Sự kiện hiển thị modal địa chỉ
                        const changeAddressBtn = document.getElementById('change-address-btn');
                        if (changeAddressBtn) {
                            changeAddressBtn.addEventListener('click', function () {
                                updateAddressModal();
                                document.getElementById('address-modal').style.display = 'flex';
                                // Khi hiển thị modal, ngăn body scroll để tránh xung đột
                                document.body.style.overflow = 'hidden';
                            });
                        }

                        // Sự kiện đóng modal
                        const closeModalBtn = document.getElementById('close-modal');
                        const cancelAddressBtn = document.getElementById('cancel-address');

                        if (closeModalBtn) {
                            closeModalBtn.addEventListener('click', function () {
                                document.getElementById('address-modal').style.display = 'none';
                                // Đảm bảo body có thể scroll lại sau khi đóng modal
                                document.body.style.overflow = 'auto'; // Re-enable scrolling
                            });
                        }

                        if (cancelAddressBtn) {
                            cancelAddressBtn.addEventListener('click', function () {
                                document.getElementById('address-modal').style.display = 'none';
                                // Đảm bảo body có thể scroll lại sau khi đóng modal
                                document.body.style.overflow = 'auto';
                            });
                        }

                        // Sự kiện xác nhận địa chỉ từ modal
                        const confirmAddressBtn = document.getElementById('confirm-address');
                        if (confirmAddressBtn) {
                            confirmAddressBtn.addEventListener('click', function () {
                                // Tìm địa chỉ được chọn (có class border-orange-500)
                                const selectedAddressElement = document.querySelector('#address-modal .border-orange-500');
                                if (selectedAddressElement) {
                                    const addressId = selectedAddressElement.getAttribute('data-address-id');
                                    const selectedAddress = savedAddresses.find(addr => addr.id === addressId);

                                    if (selectedAddress) {
                                        // Set the selected address as default in the array
                                        savedAddresses.forEach(address => {
                                            address.isDefault = (address.id === addressId);
                                        });

                                        // Save updated addresses to localStorage
                                        localStorage.setItem('userAddresses', JSON.stringify(savedAddresses));

                                        // Update the displayed address
                                        updateDisplayedAddress(selectedAddress);

                                        // Save the selected address separately to ensure it's used
                                        localStorage.setItem('selectedAddress', JSON.stringify(selectedAddress));

                                        console.log('Updated default addressoahfkjdahufadshfa:', selectedAddress);

                                        // THÊM MỚI: Đồng bộ trực tiếp với GHN API sau khi chọn địa chỉ
                                        // Lưu ý: updateDisplayedAddress đã gọi syncAddressWithGHNApi phía trên
                                        // Tuy nhiên, thêm phần này để đảm bảo đồng bộ rõ ràng và dự phòng
                                        console.log('Explicitly syncing selected address with GHN API...');
                                        if (typeof window.ghnState !== 'undefined') {
                                            // Cập nhật trực tiếp ghnState
                                            window.ghnState.selectedToProvince = parseInt(selectedAddress.provinceId);
                                            window.ghnState.selectedToDistrict = parseInt(selectedAddress.districtId);
                                            window.ghnState.selectedToWard = selectedAddress.wardCode;

                                            // Nếu shipping-form đang hiển thị, cập nhật các dropdown
                                            const shippingForm = document.getElementById('shipping-form');
                                            if (shippingForm && shippingForm.style.display !== 'none') {
                                                // Đợi một chút để đảm bảo các dropdown đã được cập nhật
                                                setTimeout(() => {
                                                    // Gọi tính phí vận chuyển
                                                    if (typeof calculateShippingFee === 'function') {
                                                        calculateShippingFee().then(() => {
                                                            console.log('Shipping fee calculation completed after address selection');

                                                            // Hiển thị kết quả
                                                            const shippingFeeResult = document.getElementById('shipping-fee-result');
                                                            if (shippingFeeResult) {
                                                                shippingFeeResult.style.display = 'block';
                                                            }
                                                        }).catch(err => {
                                                            console.error('Error calculating shipping fee after address selection:', err);
                                                        });
                                                    }
                                                }, 500);
                                            }
                                        }
                                    }
                                }

                                document.getElementById('address-modal').style.display = 'none';
                                // Đảm bảo body có thể scroll lại sau khi đóng modal
                                document.body.style.overflow = 'auto';
                            });
                        }

                        // Khởi tạo: hiển thị địa chỉ mặc định từ model hoặc từ localStorage
                        if ('${defaultAddress.name}' && '${defaultAddress.phone}' && '${defaultAddress.fullAddress}') {
                            const recipientName = document.getElementById('recipient-name');
                            const recipientPhone = document.getElementById('recipient-phone');
                            const recipientAddress = document.getElementById('recipient-address');

                            if (recipientName) recipientName.textContent = '${defaultAddress.name}';
                            if (recipientPhone) recipientPhone.textContent = '${defaultAddress.phone}';
                            if (recipientAddress) recipientAddress.textContent = '${defaultAddress.fullAddress}';
                        } else {
                            // Không có địa chỉ từ model, thử tìm địa chỉ mặc định từ localStorage
                            const defaultAddress = savedAddresses.find(addr => addr.isDefault);
                            if (defaultAddress) {
                                updateDisplayedAddress(defaultAddress);
                            }
                        }
                    });
                </script>



                <script src="${ctx}/resources/assets/client/js/order.js">
                </script>
                <!-- Add JavaScript for modal and shipping form interaction -->
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        const changeAddressBtn = document.getElementById('change-address-btn');
                        const addressModal = document.getElementById('address-modal');
                        const closeModalBtn = document.getElementById('close-modal');
                        const cancelAddressBtn = document.getElementById('cancel-address');
                        const confirmAddressBtn = document.getElementById('confirm-address');
                        const addressOptions = document.querySelectorAll('.address-option');
                        const editAddressBtns = document.querySelectorAll('.edit-address-btn');
                        const shippingForm = document.getElementById('shipping-form');

                        // Initialize addresses from localStorage if available
                        initializeAddressesFromLocalStorage();

                        // Ensure the recipient address is properly displayed on page load
                        const recipientAddress = document.getElementById('recipient-address');
                        // If the address is empty or just "...", set it to the default address
                        if (!recipientAddress.textContent || recipientAddress.textContent === "..." || recipientAddress.textContent.trim() === "") {
                            const defaultAddress = document.querySelector('.address-option.selected');
                            if (defaultAddress) {
                                const addressLine1 = defaultAddress.querySelectorAll('p.text-gray-700')[0].textContent;
                                const addressLine2 = defaultAddress.querySelectorAll('p.text-gray-700')[1].textContent;
                                recipientAddress.textContent = addressLine1 + '. ' + addressLine2;
                            }
                        }

                        // Get customer ID and fetch addresses on page load
                        const customerId = document.getElementById('customerId');
                        if (customerId && customerId.value) {
                            console.log('Found customer ID on page load:', customerId.value);
                            // This call is redundant since loadCustomerAddressesFromModel is called in main initialization
                            // loadCustomerAddressesFromModel(); // Removed to prevent duplication
                        } else {
                            console.log('Customer ID not found or empty');

                            // If no customer ID, try to restore from localStorage anyway
                            try {
                                const savedAddress = localStorage.getItem('selectedAddress');
                                if (savedAddress) {
                                    const addressData = JSON.parse(savedAddress);
                                    console.log('Restored address from localStorage:', addressData);

                                    // Update recipient display with saved address
                                    if (document.getElementById('recipient-name')) {
                                        document.getElementById('recipient-name').textContent = addressData.name || '';
                                    }
                                    if (document.getElementById('recipient-phone')) {
                                        document.getElementById('recipient-phone').textContent = addressData.phone || '';
                                    }
                                    if (document.getElementById('recipient-address')) {
                                        let fullAddress = addressData.addressLine1 || '';
                                        if (addressData.addressLine2) {
                                            fullAddress += ', ' + addressData.addressLine2;
                                        }
                                        document.getElementById('recipient-address').textContent = fullAddress;
                                    }
                                }
                            } catch (e) {
                                console.error('Error restoring address from localStorage:', e);
                            }
                        }

                        // Open modal
                        changeAddressBtn.addEventListener('click', function () {
                            // Reset the addressesLoaded flag to allow reloading addresses
                            resetAddressLoadingState();

                            // Load the latest addresses every time the modal is opened
                            loadCustomerAddressesFromModel();

                            // Show the modal
                            addressModal.classList.remove('hidden');
                            document.body.style.overflow = 'hidden'; // Prevent scrolling
                        });

                        // Close modal functions
                        const closeModal = function () {
                            addressModal.classList.add('hidden');
                            document.body.style.overflow = 'auto'; // Re-enable scrolling
                        };

                        closeModalBtn.addEventListener('click', closeModal);
                        cancelAddressBtn.addEventListener('click', closeModal);
                        confirmAddressBtn.addEventListener('click', function () {
                            // Get selected address
                            const selectedAddress = document.querySelector('.address-option.selected');
                            if (selectedAddress) {
                                // Get displayed data from the selected address in the modal
                                const name = selectedAddress.querySelector('.font-medium').textContent.trim();
                                const phone = selectedAddress.querySelector('.text-sm.text-gray-500').textContent.trim();
                                const addressLine1 = selectedAddress.querySelectorAll('p.text-gray-700')[0].textContent.trim();
                                const addressLine2 = selectedAddress.querySelectorAll('p.text-gray-700')[1].textContent.trim();
                                const addressId = selectedAddress.dataset.addressId;

                                console.log('Selected address with ID:', addressId);
                                console.log('Name:', name);
                                console.log('Phone:', phone);
                                console.log('Address Line 1:', addressLine1);
                                console.log('Address Line 2:', addressLine2);

                                // Update the main displayed address on the page
                                const recipientNameElement = document.getElementById('recipient-name');
                                const recipientPhoneElement = document.getElementById('recipient-phone');
                                const recipientAddressElement = document.getElementById('recipient-address');

                                if (recipientNameElement) recipientNameElement.textContent = name;
                                if (recipientPhoneElement) recipientPhoneElement.textContent = phone;

                                // Combine address lines for the main display, handling null or empty values
                                if (recipientAddressElement) {
                                    let fullAddress = addressLine1 || '';
                                    if (addressLine2 && addressLine2 !== 'No additional address details') {
                                        if (fullAddress) fullAddress += ', ';
                                        fullAddress += addressLine2;
                                    }
                                    recipientAddressElement.textContent = fullAddress || 'No address details';
                                    console.log('Updated main display with address:', fullAddress);
                                }

                                // Save address data to local storage for persistence
                                try {
                                    const addressData = {
                                        id: addressId,
                                        name: name,
                                        phone: phone,
                                        addressLine1: addressLine1,
                                        addressLine2: addressLine2,
                                        isDefault: selectedAddress.querySelector('.px-2.py-1.bg-red-100.text-red-800') !== null
                                    };

                                    localStorage.setItem('selectedAddress', JSON.stringify(addressData));
                                    console.log('Saved address data to localStorage:', addressData);
                                } catch (e) {
                                    console.error('Error saving address to localStorage:', e);
                                }

                                // Show success toast
                                showToast('Đã chọn địa chỉ thành công!');
                            } else {
                                console.warn('No address selected');
                                showToast('Vui lòng chọn một địa chỉ', false);
                            }
                            closeModal();
                        });

                        // Close modal when clicking outside
                        addressModal.addEventListener('click', function (e) {
                            if (e.target === addressModal) {
                                closeModal();
                            }
                        });

                        // Select address option
                        addressOptions.forEach(option => {
                            option.addEventListener('click', function (e) {
                                // Don't trigger selection if clicked on a button
                                if (e.target.tagName === 'BUTTON') {
                                    return;
                                }

                                // Remove selected class from all options
                                addressOptions.forEach(opt => {
                                    opt.classList.remove('selected');
                                    const radio = opt.querySelector('.w-5.h-5');
                                    radio.classList.remove('border-blue-500');
                                    radio.classList.add('border-gray-300');
                                    const innerCircle = radio.querySelector('.w-3.h-3');
                                    innerCircle.classList.remove('bg-blue-500');
                                    innerCircle.classList.add('bg-transparent');
                                });

                                // Add selected class to clicked option
                                this.classList.add('selected');
                                const radio = this.querySelector('.w-5.h-5');
                                radio.classList.remove('border-gray-300');
                                radio.classList.add('border-blue-500');
                                const innerCircle = radio.querySelector('.w-3.h-3');
                                innerCircle.classList.remove('bg-transparent');
                                innerCircle.classList.add('bg-blue-500');
                            });
                        });

                        // Edit address button click
                        editAddressBtns.forEach(btn => {
                            btn.addEventListener('click', function (e) {
                                e.preventDefault();
                                e.stopPropagation();

                                // Get address ID from data attribute
                                const addressOption = this.closest('.address-option');
                                const addressId = addressOption.dataset.addressId;
                                console.log('Editing address ID:', addressId);

                                // Get the name and phone from this address
                                const name = addressOption.querySelector('.font-medium').textContent;
                                const phone = addressOption.querySelector('.text-sm.text-gray-500').textContent;
                                const addressLine1 = addressOption.querySelectorAll('p.text-gray-700')[0].textContent;
                                const addressParts = addressOption.querySelectorAll('p.text-gray-700')[1].textContent.split(', ');

                                // Pre-fill form with address data
                                document.getElementById('fullNameEdit').value = name;
                                document.getElementById('phoneEdit').value = phone;
                                document.getElementById('detailAddress').value = addressLine1;

                                // Save the address option reference for later update
                                window.currentEditingAddressOption = addressOption;

                                // Close the modal
                                closeModal();

                                // Show the shipping form
                                shippingForm.style.display = 'block';

                                // Scroll to shipping form
                                shippingForm.scrollIntoView({ behavior: 'smooth' });
                            });
                        });

                        // Save address button
                        document.getElementById('saveAddressBtn').addEventListener('click', function () {
                            // Get form data for location
                            const province = document.getElementById('toProvince').options[document.getElementById('toProvince').selectedIndex]?.text || 'Default Province';
                            const district = document.getElementById('toDistrict').options[document.getElementById('toDistrict').selectedIndex]?.text || 'Default District';
                            const ward = document.getElementById('toWard').options[document.getElementById('toWard').selectedIndex]?.text || 'Default Ward';
                            const detailAddress = document.getElementById('detailAddress').value || 'Default Address';

                            // Log form values for debugging
                            console.log('Form Values:', {
                                province: province,
                                district: district,
                                ward: ward,
                                detailAddress: detailAddress
                            });

                            // Get form data for personal info
                            const fullName = document.getElementById('fullNameEdit').value || '';
                            const phone = document.getElementById('phoneEdit').value || '';

                            if (!province || !district || !ward || !detailAddress) {
                                alert('Vui lòng điền đầy đủ thông tin địa chỉ');
                                return;
                            }

                            if (!fullName || !phone) {
                                alert('Vui lòng điền đầy đủ họ tên và số điện thoại');
                                return;
                            }
                            // Format the full address with fallback values if any are missing
                            const safeDetailAddress = detailAddress || 'Default Address';
                            const safeWard = ward || 'Default Ward';
                            const safeDistrict = district || 'Default District';
                            const safeProvince = province || 'Default Province';

                            const addressParts = [detailAddress, ward, district, province]
                                .filter(part => part && !part.includes('Default'))
                                .slice(0, 3); // Lấy tối đa 3 phần có giá trị

                            const fullAddress = addressParts.join('');
                            console.log("Full address with up to 3 valid parts:", fullAddress);

                            // Update the main display
                            const recipientNameElement = document.getElementById('recipient-name');
                            const recipientPhoneElement = document.getElementById('recipient-phone');
                            const recipientAddressElement = document.getElementById('recipient-address');

                            // Update all fields in main display
                            recipientNameElement.textContent = fullName;
                            recipientPhoneElement.textContent = phone;
                            recipientAddressElement.textContent = fullAddress;
                            recipientAddressElement.style.display = 'block'; // Make sure it's visible

                            // Show "Mặc Định" badge in main display (since this is the active address)
                            const mainDefaultBadge = document.querySelector('.w-full.p-4 .inline-block.px-2.py-1.bg-red-100.text-red-800');
                            if (mainDefaultBadge) {
                                mainDefaultBadge.style.display = 'inline-block';
                            }

                            // Update the active address in the modal
                            let addressToUpdate = window.currentEditingAddressOption || document.querySelector('.address-option.selected');

                            if (addressToUpdate) {
                                // Update name and phone
                                const nameElement = addressToUpdate.querySelector('.font-medium');
                                const phoneElement = addressToUpdate.querySelector('.text-sm.text-gray-500');
                                if (nameElement) nameElement.textContent = fullName;
                                if (phoneElement) phoneElement.textContent = phone;

                                // Update address lines in the modal
                                const addressLines = addressToUpdate.querySelectorAll('p.text-gray-700');
                                if (addressLines.length >= 2) {
                                    addressLines[0].textContent = detailAddress;
                                    addressLines[1].textContent = (ward || '') + (ward && district ? ', ' : '') + (district || '') + ((district && province) ? ', ' : '') + (province || '');
                                }

                                // Save the address ID for tracking
                                const addressId = addressToUpdate.dataset.addressId;

                                // Save to localStorage
                                saveAddressToLocalStorage(addressId, {
                                    name: fullName,
                                    phone: phone,
                                    detailAddress: detailAddress,
                                    ward: ward,
                                    district: district,
                                    province: province,
                                    isDefault: true
                                });

                                // Create the full address string - ensure all variables have values
                                const addressDetail = detailAddress || 'Default Address';
                                const wardText = ward || 'Default Ward';
                                const districtText = district || 'Default District';
                                const provinceText = province || 'Default Province';

                                // Create the full address with guaranteed values
                                const addressParts = [addressDetail, wardText, districtText, provinceText]
                                    .filter(part => part && !part.includes('Default'))
                                    .slice(0, 3); // Lấy tối đa 3 phần có giá trị
                                const fullAddressStr = addressParts.join(',');

                            } else {
                                // If no address was selected, create a new one in the modal
                                console.log('Creating new address entry in modal');

                                // Create a new address option
                                const newAddressId = Date.now().toString(); // Generate unique ID
                                const addressContainer = document.querySelector('.p-6');

                                const newAddressHTML = `
                                    <div class="border rounded-md p-4 mb-4 hover:border-blue-500 cursor-pointer address-option selected" data-address-id="\${newAddressId}">
                                        <div class="flex items-start mb-2">
                                            <div class="flex-shrink-0 mt-1">
                                                <div class="w-5 h-5 border border-blue-500 rounded-full flex items-center justify-center">
                                                    <div class="w-3 h-3 bg-blue-500 rounded-full"></div>
                                                </div>
                                            </div>
                                            <div class="ml-3 flex-grow">
                                                <div class="flex items-center justify-between w-full mb-1">
                                                    <div class="flex items-center">
                                                        <span class="font-medium">\${fullName}</span>
                                                        <span class="ml-3 text-sm text-gray-500">\${phone}</span>
                                                    </div>
                                                    <span class="px-2 py-1 bg-red-100 text-red-800 text-xs font-medium rounded">Mặc định</span>
                                                </div>
                                                <p class="text-gray-700 mb-1">\${detailAddress}</p>
                                                <p class="text-gray-700">\${addressData.ward != null ? addressData.ward : ''}\${addressData.ward != null && addressData.district != null ? ', ' : ''}\${addressData.district != null ? addressData.district : ''}\${addressData.district != null && addressData.province != null ? ', ' : ''}\${addressData.province != null ? addressData.province : ''}</p>
                                                <div class="flex items-center mt-2">
                                                    <button class="text-gray-500 text-sm border px-4 py-1 rounded mr-2">Mặc định</button>
                                                    <button class="edit-address-btn text-blue-600 text-sm border border-blue-600 px-4 py-1 rounded">Thay đổi</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                `;

                                // Deselect all existing options
                                document.querySelectorAll('.address-option').forEach(opt => {
                                    opt.classList.remove('selected');
                                    const radio = opt.querySelector('.w-5.h-5');
                                    radio.classList.remove('border-blue-500');
                                    radio.classList.add('border-gray-300');
                                    const innerCircle = radio.querySelector('.w-3.h-3');
                                    innerCircle.classList.remove('bg-blue-500');
                                    innerCircle.classList.add('bg-transparent');
                                });

                                // Add the new address to the top of the list
                                if (addressContainer) {
                                    const firstChild = addressContainer.firstChild;
                                    const div = document.createElement('div');
                                    div.innerHTML = newAddressHTML;
                                    const newAddressNode = div.firstChild;
                                    addressContainer.insertBefore(newAddressNode, firstChild);

                                    // Save to localStorage
                                    saveAddressToLocalStorage(newAddressId, {
                                        name: fullName,
                                        phone: phone,
                                        detailAddress: detailAddress,
                                        ward: ward,
                                        district: district,
                                        province: province,
                                        isDefault: true
                                    });

                                    // Create the full address string - ensure all variables have values
                                    const addressDetail = detailAddress || 'Default Address';
                                    const wardText = ward || 'Default Ward';
                                    const districtText = district || 'Default District';
                                    const provinceText = province || 'Default Province';

                                    // Create the full address with guaranteed values
                                    const addressParts = [addressDetail, wardText, districtText, provinceText]
                                        .filter(part => part && !part.includes('Default'))
                                        .slice(0, 3); // Lấy tối đa 3 phần có giá trị
                                    const fullAddressStr = addressParts.join(',');
                                    console.log("fullAddress", fullAddressStr);
                                    console.log(`Address ${newAddressId} created with: ${fullAddressStr}`);

                                    // Add event listener to the new edit button
                                    const newEditBtn = newAddressNode.querySelector('.edit-address-btn');
                                    if (newEditBtn) {
                                        newEditBtn.addEventListener('click', function (e) {
                                            e.preventDefault();
                                            e.stopPropagation();

                                            // Get the name and phone from this address
                                            const addressOption = this.closest('.address-option');
                                            const name = addressOption.querySelector('.font-medium').textContent;
                                            const phone = addressOption.querySelector('.text-sm.text-gray-500').textContent;
                                            const addressLine1 = addressOption.querySelectorAll('p.text-gray-700')[0].textContent;

                                            // Pre-fill form with address data
                                            document.getElementById('fullNameEdit').value = name;
                                            document.getElementById('phoneEdit').value = phone;
                                            document.getElementById('detailAddress').value = addressLine1;

                                            // Save the address option reference for later update
                                            window.currentEditingAddressOption = addressOption;

                                            // Close the modal
                                            closeModal();

                                            // Show the shipping form
                                            shippingForm.style.display = 'block';

                                            // Scroll to shipping form
                                            shippingForm.scrollIntoView({ behavior: 'smooth' });
                                        });
                                    }

                                    // Add click event for selection
                                    newAddressNode.addEventListener('click', function (e) {
                                        if (e.target.tagName === 'BUTTON') {
                                            return;
                                        }

                                        // Remove selected class from all options
                                        document.querySelectorAll('.address-option').forEach(opt => {
                                            opt.classList.remove('selected');
                                            const radio = opt.querySelector('.w-5.h-5');
                                            radio.classList.remove('border-gray-300');
                                            radio.classList.add('border-blue-500');
                                            const innerCircle = radio.querySelector('.w-3.h-3');
                                            innerCircle.classList.remove('bg-transparent');
                                            innerCircle.classList.add('bg-blue-500');
                                        });

                                        // Add selected class to this option
                                        this.classList.add('selected');
                                        const radio = this.querySelector('.w-5.h-5');
                                        radio.classList.remove('border-gray-300');
                                        radio.classList.add('border-blue-500');
                                        const innerCircle = radio.querySelector('.w-3.h-3');
                                        innerCircle.classList.remove('bg-transparent');
                                        innerCircle.classList.add('bg-blue-500');
                                    });
                                }
                            }

                            // Clear the current editing reference
                            window.currentEditingAddressOption = null;

                            // Hide the form after saving
                            shippingForm.style.display = 'none';

                            // Show success message with toast
                            showToast('Đã lưu địa chỉ thành công!');
                        });
                    });

                    // Function to load customer addresses from model data
                    let addressesLoaded = false; // Add tracking variable

                    // Function to reset address loading state
                    function resetAddressLoadingState() {
                        console.log("Resetting address loading state");
                        addressesLoaded = false;
                    }

                    function loadCustomerAddressesFromModel() {
                        // Check if addresses have already been loaded
                        if (addressesLoaded) {
                            console.log("Addresses already loaded, skipping duplicate load");
                            return;
                        }

                        console.log("Loading addresses from model data");

                        // Get the address container in the modal
                        const addressContainer = document.querySelector('#address-modal .p-6');

                        // Always clear existing address options first to prevent duplication
                        if (addressContainer) {
                            addressContainer.innerHTML = '';
                            console.log("Cleared address container to prevent duplication");
                        }

                        // Attempt to get addresses from localStorage first (preferred if available)
                        let addresses = [];
                        try {
                            const savedAddresses = JSON.parse(localStorage.getItem('userAddresses')) || [];
                            if (savedAddresses && savedAddresses.length > 0) {
                                console.log(`Found ${savedAddresses.length} addresses in localStorage, using these instead of model data`);

                                // Transform localStorage addresses to the format expected by our display code
                                addresses = savedAddresses.map(saved => {
                                    return {
                                        addressId: saved.id || saved.addressId || Date.now().toString(36),
                                        street: saved.detailAddress || saved.street || '',
                                        ward: saved.wardName || saved.ward || '',
                                        wardId: saved.wardCode || saved.wardId || '',
                                        district: saved.districtName || saved.district || '',
                                        districtId: saved.districtId || '',
                                        province: saved.provinceName || saved.province || '',
                                        provinceId: saved.provinceId || '',
                                        recipientName: saved.name || '',
                                        recipientPhone: saved.phone || '',
                                        isDefault: saved.isDefault || false
                                    };
                                });
                            }
                        } catch (error) {
                            console.error("Error reading addresses from localStorage:", error);
                        }

                        // If no addresses found in localStorage, fall back to model data
                        if (!addresses || addresses.length === 0) {
                            console.log("No addresses found in localStorage, falling back to model data");

                            // Get formatted addresses from the hidden input field 
                            const addressesDataText = document.getElementById('formatted-addresses-data').value;
                            console.log("Raw address data from model:", addressesDataText);

                            // Parse the addresses - our parser now handles both old and new formats
                            addresses = parseFormattedAddresses(addressesDataText);
                            console.log("Parsed addresses from model:", addresses);
                        }

                        // Check if addresses array exists and is not empty
                        if (addresses && addresses.length > 0) {
                            console.log("Found " + addresses.length + " addresses to display");

                            // Loop through addresses and create HTML for each
                            addresses.forEach((address, index) => {
                                // Log each address for debugging
                                console.log("Address " + (index + 1) + ":");
                                console.log("  ID: " + (address.addressId || 'N/A'));
                                console.log("  Street: " + (address.street || 'N/A'));
                                console.log("  Ward: " + (address.ward || 'N/A'));
                                console.log("  District: " + (address.district || 'N/A'));
                                console.log("  Province: " + (address.province || 'N/A'));
                                console.log("  City: " + (address.city || 'N/A'));

                                // Only add to DOM if we have valid data
                                if (address && address.addressId) {
                                    // Create full address string
                                    const addressDetails = [
                                        address.street || '',
                                        address.ward || '',
                                        address.district || '',
                                        address.province || '',
                                        address.city || ''
                                    ].filter(part => part && part.trim() !== '');

                                    // Split address into two parts (line 1 and line 2) for display
                                    let addressLine1 = addressDetails.length > 0 ? addressDetails[0] : 'No address details';
                                    let addressLine2 = addressDetails.slice(1).join(', ');

                                    if (!addressLine2) {
                                        addressLine2 = 'No additional address details';
                                    }

                                    // Get customer name and phone from address object or main form
                                    const customerName = address.recipientName || document.getElementById('fullName').value || 'Customer';
                                    const customerPhone = address.recipientPhone || document.getElementById('phone').value || 'No phone';

                                    // Create the HTML elements for this address
                                    if (addressContainer) {
                                        // Create container for the address
                                        const isSelected = index === 0; // First one is selected by default
                                        const addressDiv = document.createElement('div');
                                        addressDiv.className = 'border rounded-md p-4 mb-4 hover:border-blue-500 cursor-pointer address-option ' +
                                            (isSelected ? 'selected' : '');
                                        addressDiv.setAttribute('data-address-id', address.addressId);

                                        // Create inner content
                                        const innerDiv = document.createElement('div');
                                        innerDiv.className = 'flex items-start mb-2';

                                        // Create radio button appearance
                                        const radioDiv = document.createElement('div');
                                        radioDiv.className = 'flex-shrink-0 mt-1';

                                        const borderDiv = document.createElement('div');
                                        borderDiv.className = 'w-5 h-5 border ' +
                                            (isSelected ? 'border-blue-500' : 'border-gray-300') +
                                            ' rounded-full flex items-center justify-center';

                                        const innerCircle = document.createElement('div');
                                        innerCircle.className = 'w-3 h-3 ' +
                                            (isSelected ? 'bg-blue-500' : 'bg-transparent') +
                                            ' rounded-full';

                                        // Create address content
                                        const contentDiv = document.createElement('div');
                                        contentDiv.className = 'ml-3 flex-grow';

                                        // Header row with name, phone, and default tag
                                        const headerDiv = document.createElement('div');
                                        headerDiv.className = 'flex items-center justify-between w-full mb-1';

                                        const customerInfoDiv = document.createElement('div');
                                        customerInfoDiv.className = 'flex items-center';

                                        // Name
                                        const nameSpan = document.createElement('span');
                                        nameSpan.className = 'font-medium';
                                        nameSpan.textContent = customerName;

                                        // Phone
                                        const phoneSpan = document.createElement('span');
                                        phoneSpan.className = 'ml-3 text-sm text-gray-500';
                                        phoneSpan.textContent = customerPhone;

                                        // Default badge (only for first address)
                                        let defaultBadge = null;
                                        if (index === 0) {
                                            defaultBadge = document.createElement('span');
                                            defaultBadge.className = 'px-2 py-1 bg-red-100 text-red-800 text-xs font-medium rounded';
                                            defaultBadge.textContent = 'Mặc định';
                                        }

                                        // Address lines
                                        const addressLine1P = document.createElement('p');
                                        addressLine1P.className = 'text-gray-700 mb-1';
                                        addressLine1P.textContent = addressLine1;

                                        const addressLine2P = document.createElement('p');
                                        addressLine2P.className = 'text-gray-700';
                                        addressLine2P.textContent = addressLine2;

                                        // Action buttons
                                        const buttonsDiv = document.createElement('div');
                                        buttonsDiv.className = 'flex items-center mt-2';

                                        const defaultBtn = document.createElement('button');
                                        defaultBtn.className = 'text-gray-500 text-sm border px-4 py-1 rounded mr-2';
                                        defaultBtn.textContent = 'Mặc định';

                                        const editBtn = document.createElement('button');
                                        editBtn.className = 'edit-address-btn text-blue-600 text-sm border border-blue-600 px-4 py-1 rounded';
                                        editBtn.textContent = 'Thay đổi';

                                        // Build the DOM structure
                                        borderDiv.appendChild(innerCircle);
                                        radioDiv.appendChild(borderDiv);

                                        customerInfoDiv.appendChild(nameSpan);
                                        customerInfoDiv.appendChild(phoneSpan);

                                        headerDiv.appendChild(customerInfoDiv);
                                        if (defaultBadge) {
                                            headerDiv.appendChild(defaultBadge);
                                        }

                                        buttonsDiv.appendChild(defaultBtn);
                                        buttonsDiv.appendChild(editBtn);

                                        contentDiv.appendChild(headerDiv);
                                        contentDiv.appendChild(addressLine1P);
                                        contentDiv.appendChild(addressLine2P);
                                        contentDiv.appendChild(buttonsDiv);

                                        innerDiv.appendChild(radioDiv);
                                        innerDiv.appendChild(contentDiv);

                                        addressDiv.appendChild(innerDiv);

                                        // Add the completed address to the container
                                        addressContainer.appendChild(addressDiv);
                                    }
                                }
                            });

                            // Update the main display with the first address
                            if (addresses.length > 0 && addresses[0]) {
                                updateMainDisplayWithFirstAddress(addresses[0]);
                            }

                            // Re-attach event listeners to the new address options
                            attachAddressOptionListeners();

                            // Mark as loaded to prevent duplicate loading
                            addressesLoaded = true;
                        } else {
                            console.log("No addresses found in model data");
                        }
                    }

                    // Function to fetch customer addresses from API (keeping for backward compatibility)
                    function fetchCustomerAddresses(customerId) {
                        console.log("Deprecated: fetchCustomerAddresses is no longer used. Using model data instead.");

                        // Call the new function that uses model data, respecting the addressesLoaded flag
                        // This ensures we don't duplicate addresses if they've already been loaded
                        if (!addressesLoaded) {
                            loadCustomerAddressesFromModel();
                        } else {
                            console.log("Addresses already loaded, skipping fetchCustomerAddresses call");
                        }
                    }

                    // Function to parse formatted addresses string into an array of address objects
                    function parseFormattedAddresses(formattedText) {
                        const addresses = [];

                        try {
                            // Check if we're dealing with the new Addressv2 format
                            if (formattedText && formattedText.includes('Addressv2')) {
                                console.log("Detected Addressv2 format, parsing accordingly");

                                // Function to extract values from the Addressv2 string
                                function extractValue(str, pattern, defaultValue = '') {
                                    const regex = new RegExp(pattern + '=([^,\\)]+)');
                                    const match = str.match(regex);
                                    return match ? match[1].trim() : defaultValue;
                                }

                                // Split the input into individual addresses if it's a collection
                                const addressItems = formattedText.includes('[') ?
                                    formattedText.substring(1, formattedText.length - 1).split(', Addressv2') :
                                    [formattedText];

                                // Process each address
                                for (let i = 0; i < addressItems.length; i++) {
                                    const addrStr = addressItems[i];
                                    // Make sure it's an Addressv2 item
                                    if (!addrStr.includes('Addressv2') && i > 0) {
                                        addressItems[i] = 'Addressv2' + addrStr;
                                    }
                                }

                                for (const addrStr of addressItems) {
                                    if (!addrStr.trim()) continue;

                                    // Extract fields from Addressv2
                                    const addressId = extractValue(addrStr, 'addressId');
                                    const customerId = extractValue(addrStr, 'customerId');
                                    const street = extractValue(addrStr, 'street');

                                    // Extract nested ward data
                                    const wardId = extractValue(addrStr, 'wardId');
                                    const wardName = extractValue(addrStr, 'wardName');

                                    // Extract nested district data
                                    const districtId = extractValue(addrStr, 'districtId');
                                    const districtName = extractValue(addrStr, 'districtName');

                                    // Extract nested province data
                                    const provinceId = extractValue(addrStr, 'provinceId');
                                    const provinceName = extractValue(addrStr, 'provinceName');

                                    // Create address object in the required format
                                    const address = {
                                        addressId: addressId,
                                        street: street,
                                        ward: wardName,
                                        wardId: wardId,
                                        district: districtName,
                                        districtId: districtId,
                                        province: provinceName,
                                        provinceId: provinceId,
                                        // Get customer information from the form
                                        recipientName: document.getElementById('fullName')?.value || '',
                                        recipientPhone: document.getElementById('phone')?.value || ''
                                    };

                                    // Add to addresses array if we have a valid ID
                                    if (address.addressId) {
                                        addresses.push(address);
                                    }
                                }

                                console.log(`Successfully parsed ${addresses.length} addresses from Addressv2 format`);
                            } else {
                                // Original parsing logic for old format (keeping for backward compatibility)
                                console.log("Using legacy parser for old address format");

                                // Bỏ dòng đầu tiên (Retrieved X addresses for customerId Y)
                                const addressesText = formattedText.split('\n').slice(1).join('\n');

                                // Tách thành từng địa chỉ riêng biệt
                                const addressBlocks = addressesText.split('-----------------------');

                                // Xử lý từng khối địa chỉ
                                for (const block of addressBlocks) {
                                    if (!block.trim()) continue;

                                    // Tạo đối tượng địa chỉ
                                    const address = {};

                                    // Phân tích từng dòng
                                    const lines = block.trim().split('\n');
                                    for (const line of lines) {
                                        if (!line.trim()) continue;

                                        // Tách key và value
                                        const [key, value] = line.split(':').map(part => part.trim());

                                        // Xác định trường dữ liệu dựa trên key
                                        if (key === 'Address ID') address.addressId = parseInt(value);
                                        else if (key === 'Street') address.street = value;
                                        else if (key === 'Ward') address.ward = value;
                                        else if (key === 'District') address.district = value;
                                        else if (key === 'Province') address.province = value;
                                        else if (key === 'City') address.city = value;
                                    }

                                    // Chỉ thêm địa chỉ hợp lệ vào danh sách
                                    if (address.addressId) {
                                        addresses.push(address);
                                    }
                                }

                                console.log(`Successfully parsed ${addresses.length} addresses from legacy format`);
                            }
                        } catch (error) {
                            console.error('Error parsing addresses:', error);
                        }

                        return addresses;
                    }

                    // Function to update main display with first address
                    function updateMainDisplayWithFirstAddress(address) {
                        if (!address) return;

                        console.log("Updating main display with address:", address);

                        // Get the display elements
                        const recipientName = document.getElementById('recipient-name');
                        const recipientPhone = document.getElementById('recipient-phone');
                        const recipientAddress = document.getElementById('recipient-address');

                        // Get customer name and phone from address object or form
                        const customerName = address.recipientName || document.getElementById('fullName').value || 'Customer';
                        const customerPhone = address.recipientPhone || document.getElementById('phone').value || 'No phone';

                        // Update the display if elements exist
                        if (recipientName) recipientName.textContent = customerName;
                        if (recipientPhone) recipientPhone.textContent = customerPhone;

                        if (recipientAddress) {
                            // Create full address string - make sure to handle null values
                            const addressDetails = [
                                address.street || '',
                                address.ward || '',
                                address.district || '',
                                address.province || '',
                                address.city || ''
                            ].filter(part => part && part.trim() !== '');

                            // Join parts with comma separator
                            const fullAddress = addressDetails.join(', ');
                            recipientAddress.textContent = fullAddress || 'No address details available';

                            // Store the address ID for reference
                            if (address.addressId) {
                                recipientAddress.dataset.addressId = address.addressId;
                            }

                            console.log("Updated main display with address:", fullAddress);
                        }
                    }

                    // Function to attach event listeners to address options
                    function attachAddressOptionListeners() {
                        // Select address option
                        const addressOptions = document.querySelectorAll('.address-option');
                        addressOptions.forEach(option => {
                            option.addEventListener('click', function (e) {
                                // Don't trigger selection if clicked on a button
                                if (e.target.tagName === 'BUTTON') {
                                    return;
                                }

                                // Remove selected class from all options
                                addressOptions.forEach(opt => {
                                    opt.classList.remove('selected');
                                    const radio = opt.querySelector('.w-5.h-5');
                                    radio.classList.remove('border-blue-500');
                                    radio.classList.add('border-gray-300');
                                    const innerCircle = radio.querySelector('.w-3.h-3');
                                    innerCircle.classList.remove('bg-blue-500');
                                    innerCircle.classList.add('bg-transparent');
                                });

                                // Add selected class to clicked option
                                this.classList.add('selected');
                                const radio = this.querySelector('.w-5.h-5');
                                radio.classList.remove('border-gray-300');
                                radio.classList.add('border-blue-500');
                                const innerCircle = radio.querySelector('.w-3.h-3');
                                innerCircle.classList.remove('bg-transparent');
                                innerCircle.classList.add('bg-blue-500');
                            });
                        });

                        // Edit address button click
                        const editAddressBtns = document.querySelectorAll('.edit-address-btn');
                        editAddressBtns.forEach(btn => {
                            btn.addEventListener('click', function (e) {
                                e.preventDefault();
                                e.stopPropagation();

                                // Get address ID from data attribute
                                const addressOption = this.closest('.address-option');
                                const addressId = addressOption.dataset.addressId;
                                console.log('Editing address ID:', addressId);

                                // Get the name and phone from this address
                                const name = addressOption.querySelector('.font-medium').textContent;
                                const phone = addressOption.querySelector('.text-sm.text-gray-500').textContent;
                                const addressLine1 = addressOption.querySelectorAll('p.text-gray-700')[0].textContent;

                                // Pre-fill form with address data
                                document.getElementById('fullNameEdit').value = name;
                                document.getElementById('phoneEdit').value = phone;
                                document.getElementById('detailAddress').value = addressLine1;

                                // Save the address option reference for later update
                                window.currentEditingAddressOption = addressOption;

                                // Get the address modal and shipping form
                                const addressModal = document.getElementById('address-modal');
                                const shippingForm = document.getElementById('shipping-form');

                                // Close the modal
                                if (addressModal) {
                                    addressModal.classList.add('hidden');
                                    document.body.style.overflow = 'auto';
                                }

                                // Show the shipping form
                                if (shippingForm) {
                                    shippingForm.style.display = 'block';

                                    // Scroll to shipping form
                                    shippingForm.scrollIntoView({ behavior: 'smooth' });
                                }
                            });
                        });
                    }

                    // Toggle billing address fields
                    document.getElementById('sameAsShipping').addEventListener('change', function () {
                        const billingFields = document.getElementById('billingFields');
                        if (this.checked) {
                            billingFields.classList.add('hidden');
                        } else {
                            billingFields.classList.remove('hidden');
                        }
                        validateForm(); // Revalidate form when this changes
                    });


                    // GHN Shipping integration
                    document.addEventListener('DOMContentLoaded', () => {
                        // GHN API constants
                        const GHN_API_BASE = 'https://online-gateway.ghn.vn/shiip/public-api/v2';
                        const GHN_TOKEN = 'a00c1fc5-2454-11f0-8c8d-faf19a0e6e5b';
                        const SHOP_ID = '5754757';

                        // App state - attaching to window for access from calculateCartTotals
                        window.ghnState = {
                            loading: false,
                            error: null,
                            provinces: [],
                            districts: [],
                            wards: [],
                            services: [],
                            selectedFromProvince: null,
                            selectedFromDistrict: null,
                            selectedFromWard: null,
                            selectedToProvince: null,
                            selectedToDistrict: null,
                            selectedToWard: null,
                            selectedService: null,
                            packageDetails: {
                                weight: 500, // Default weight 500g
                                length: 20,
                                width: 15,
                                height: 15,
                                insurance_value: 500000, // Default insurance value
                            },
                            shippingFeeValue: null // Initialize shipping fee value
                        };

                        // DOM Elements
                        const errorContainer = document.getElementById('error-container');
                        const loadingContainer = document.getElementById('loading-container');
                        const shippingFeeResult = document.getElementById('shipping-fee-result');

                        // Log elements for debugging
                        console.log("Initial shipping-fee-result element:", shippingFeeResult);

                        // Initialize DOM elements after DOM content is loaded
                        document.addEventListener('DOMContentLoaded', function () {
                            // Log all important elements on DOM ready
                            console.log("DOM fully loaded in shipping section");
                            console.log("Error container exists:", document.getElementById('error-container') ? true : false);
                            console.log("Loading container exists:", document.getElementById('loading-container') ? true : false);
                            console.log("Shipping fee result exists:", document.getElementById('shipping-fee-result') ? true : false);
                        });

                        // Helper to set loading state
                        function setLoading(isLoading) {
                            window.ghnState.loading = isLoading;
                            loadingContainer.style.display = isLoading ? 'block' : 'none';
                        }

                        // Helper to set error
                        function setError(message) {
                            window.ghnState.error = message;
                            errorContainer.textContent = message ? message : '';
                            errorContainer.style.display = message ? 'block' : 'none';
                        }

                        // Helper to update select options
                        function updateSelectOptions(selectId, options, valueProp, textProp) {
                            const select = document.getElementById(selectId);
                            select.innerHTML = `<option value="">Chọn</option>`;
                            options.forEach(option => {
                                const opt = document.createElement('option');
                                opt.value = option[valueProp];
                                opt.textContent = option[textProp];
                                select.appendChild(opt);
                            });
                        }

                        // Fetch provinces
                        async function fetchProvinces() {
                            setLoading(true);
                            setError(null);
                            try {
                                console.log("Fetching provinces...");
                                const response = await axios.get('https://online-gateway.ghn.vn/shiip/public-api/master-data/province', {
                                    headers: {
                                        Token: GHN_TOKEN
                                    }
                                });

                                if (response.data.code === 200) {
                                    window.ghnState.provinces = response.data.data;

                                    // Find Ho Chi Minh City in the response data
                                    const hcmCity = window.ghnState.provinces.find(p =>
                                        p.ProvinceName.includes("Hồ Chí Minh") ||
                                        p.ProvinceName.includes("HCM") ||
                                        p.ProvinceName.includes("Thành phố Hồ Chí Minh"));

                                    if (hcmCity) {
                                        // Update fromProvince dropdown
                                        const select = document.getElementById('fromProvince');
                                        select.innerHTML = '';
                                        const opt = document.createElement('option');
                                        opt.value = hcmCity.ProvinceID;
                                        opt.textContent = "Tp Hồ Chí Minh";
                                        opt.selected = true;
                                        select.appendChild(opt);

                                        // Save the selected province
                                        window.ghnState.selectedFromProvince = hcmCity.ProvinceID;

                                        // Fetch districts for HCM
                                        fetchDistricts(hcmCity.ProvinceID, true);
                                    }

                                    // Update toProvince as normal
                                    updateSelectOptions('toProvince', window.ghnState.provinces, 'ProvinceID', 'ProvinceName');
                                } else {
                                    setError('Error fetching provinces: ' + response.data.message);
                                }
                            } catch (err) {
                                console.error("Error fetching provinces:", err);
                                setError(handleError('Error fetching provinces', err));
                            } finally {
                                setLoading(false);
                            }
                        }

                        // Fetch districts
                        async function fetchDistricts(provinceId, isFrom = true) {
                            setLoading(true);
                            setError(null);
                            try {
                                console.log(`Fetching districts for province ID: ${provinceId}`);
                                const response = await axios.get('https://online-gateway.ghn.vn/shiip/public-api/master-data/district', {
                                    params: { province_id: provinceId },
                                    headers: {
                                        Token: GHN_TOKEN
                                    }
                                });

                                if (response.data.code === 200) {
                                    // Store the districts in a variable based on from/to
                                    const districtsData = response.data.data;

                                    if (isFrom) {
                                        // Find Go Vap district
                                        const goVapDistrict = districtsData.find(d =>
                                            d.DistrictName.includes("Gò Vấp") ||
                                            d.DistrictName.includes("Go Vap"));

                                        if (goVapDistrict) {
                                            // Update fromDistrict dropdown
                                            const select = document.getElementById('fromDistrict');
                                            select.innerHTML = '';
                                            const opt = document.createElement('option');
                                            opt.value = goVapDistrict.DistrictID;
                                            opt.textContent = "Quận Gò Vấp";
                                            opt.selected = true;
                                            select.appendChild(opt);

                                            // Save the selected district
                                            window.ghnState.selectedFromDistrict = goVapDistrict.DistrictID;

                                            // Fetch wards for Go Vap
                                            fetchWards(goVapDistrict.DistrictID, true);
                                        } else {
                                            // Fallback if not found
                                            const select = document.getElementById('fromDistrict');
                                            select.innerHTML = '<option value="">Chọn Quận/Huyện</option>';
                                            districtsData.forEach(district => {
                                                const opt = document.createElement('option');
                                                opt.value = district.DistrictID;
                                                opt.textContent = district.DistrictName;
                                                select.appendChild(opt);
                                            });
                                        }
                                    } else {
                                        // Update the toDistrict dropdown
                                        const select = document.getElementById('toDistrict');
                                        select.innerHTML = '<option value="">Chọn Quận/Huyện</option>';
                                        districtsData.forEach(district => {
                                            const opt = document.createElement('option');
                                            opt.value = district.DistrictID;
                                            opt.textContent = district.DistrictName;
                                            select.appendChild(opt);
                                        });
                                        select.disabled = false;
                                    }
                                } else {
                                    setError(`Error fetching districts: ${response.data.message}`);
                                }
                            } catch (err) {
                                console.error("Error fetching districts:", err);
                                setError(handleError('Error fetching districts', err));
                            } finally {
                                setLoading(false);
                            }
                        }

                        // Fetch wards
                        async function fetchWards(districtId, isFrom = true) {
                            setLoading(true);
                            setError(null);
                            try {
                                console.log(`Fetching wards for district ID: ${districtId}`);

                                const response = await axios.get('https://online-gateway.ghn.vn/shiip/public-api/master-data/ward', {
                                    params: { district_id: districtId },
                                    headers: {
                                        Token: GHN_TOKEN
                                    }
                                });

                                if (response.data.code === 200) {
                                    // Store the wards in a variable based on from/to
                                    const wardsData = response.data.data;

                                    if (isFrom) {
                                        // Find ward 17
                                        const ward17 = wardsData.find(w =>
                                            w.WardName.includes("17") ||
                                            w.WardName.includes("Mười Bảy") ||
                                            w.WardName.includes("Phường 17"));

                                        if (ward17) {
                                            // Update fromWard dropdown
                                            const select = document.getElementById('fromWard');
                                            select.innerHTML = '';
                                            const opt = document.createElement('option');
                                            opt.value = ward17.WardCode;
                                            opt.textContent = "Phường 17";
                                            opt.selected = true;
                                            select.appendChild(opt);

                                            // Save the selected ward
                                            window.ghnState.selectedFromWard = ward17.WardCode;
                                        } else {
                                            // Fallback if not found
                                            const select = document.getElementById('fromWard');
                                            select.innerHTML = '<option value="">Chọn Phường/Xã</option>';
                                            wardsData.forEach(ward => {
                                                const opt = document.createElement('option');
                                                opt.value = ward.WardCode;
                                                opt.textContent = ward.WardName;
                                                select.appendChild(opt);
                                            });
                                        }
                                    } else {
                                        // Update the toWard dropdown
                                        const select = document.getElementById('toWard');
                                        select.innerHTML = '<option value="">Chọn Phường/Xã</option>';
                                        wardsData.forEach(ward => {
                                            const opt = document.createElement('option');
                                            opt.value = ward.WardCode;
                                            opt.textContent = ward.WardName;
                                            select.appendChild(opt);
                                        });
                                        select.disabled = false;
                                    }
                                } else {
                                    setError(`Error fetching wards: ${response.data.message}`);
                                }
                            } catch (err) {
                                console.error("Error fetching wards:", err);
                                setError(`Error fetching wards: ${err.message}`);
                            } finally {
                                setLoading(false);
                            }
                        }

                        // Fetch services
                        async function fetchServices(fromDistrictId, toDistrictId) {
                            setLoading(true);
                            setError(null);
                            try {
                                console.log(`Fetching services from district ID: ${fromDistrictId} to district ID: ${toDistrictId}`);
                                const response = await axios.get('https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/available-services', {
                                    params: {
                                        shop_id: SHOP_ID,
                                        from_district: fromDistrictId,
                                        to_district: toDistrictId
                                    },
                                    headers: {
                                        Token: GHN_TOKEN
                                    }
                                });

                                console.log("Available services response:", response.data);

                                if (response.data.code === 200) {
                                    window.ghnState.services = response.data.data || [];
                                    console.log(`Found ${window.ghnState.services.length} available services`);

                                    // Look for a lightweight shipping option first
                                    let selectedService = null;

                                    // First try to find a service with "value" or similar in the name
                                    selectedService = window.ghnState.services.find(s => {
                                        const serviceName = s.service_name || '';
                                        const matches = serviceName.toLowerCase().includes('value') ||
                                            serviceName.toLowerCase().includes('tiết kiệm') ||
                                            serviceName.toLowerCase().includes('chuẩn');
                                        if (matches) {
                                            console.log(`Found matching service: ${serviceName}`);
                                        }
                                        return matches;
                                    });

                                    // If no value service found, use the first available service
                                    if (!selectedService && window.ghnState.services.length > 0) {
                                        selectedService = window.ghnState.services[0];
                                        console.log(`No matching service found, using first available: ${selectedService.service_name}`);
                                    }

                                    if (selectedService) {
                                        console.log(`Selected service: ${selectedService.service_name} (ID: ${selectedService.service_id})`);
                                        window.ghnState.selectedService = selectedService.service_id;

                                        // Set default package details
                                        window.ghnState.packageDetails = {
                                            weight: 500,  // 500g - lightweight package
                                            length: 20,
                                            width: 15,
                                            height: 15,
                                            insurance_value: 500000
                                        };

                                        // Calculate fee after selecting a service
                                        console.log("Service selected, calculating shipping fee...");
                                        setTimeout(() => {
                                            calculateShippingFee();
                                        }, 200);
                                    } else {
                                        console.error("No services available from API response");
                                        setError("Không tìm thấy dịch vụ vận chuyển phù hợp");
                                    }
                                } else {
                                    console.error(`API error: ${response.data.message}`);
                                    setError(`Error fetching services: ${response.data.message}`);
                                }
                            } catch (err) {
                                console.error("Error fetching services:", err);
                                setError(`Error fetching services: ${err.message}`);
                            } finally {
                                setLoading(false);
                            }
                        }

                        // Calculate shipping fee
                        async function calculateShippingFee() {
                            if (!window.ghnState.selectedFromDistrict) {
                                setError("Vui lòng chọn đầy đủ thông tin địa chỉ gửi hàng");
                                return;
                            }
                            if (!window.ghnState.selectedToDistrict) {
                                setError("Vui lòng chọn đầy đủ thông tin quận/huyện nhận hàng");
                                return;
                            }
                            if (!window.ghnState.selectedToWard) {
                                setError("Vui lòng chọn đầy đủ thông tin phường/xã nhận hàng");
                                return;
                            }
                            if (!window.ghnState.selectedService) {
                                setError("Không tìm thấy dịch vụ vận chuyển phù hợp");
                                return;
                            }

                            setLoading(true);
                            setError(null);

                            // Use the default package details
                            const payload = {
                                from_district_id: parseInt(window.ghnState.selectedFromDistrict),
                                service_id: parseInt(window.ghnState.selectedService),
                                to_district_id: parseInt(window.ghnState.selectedToDistrict),
                                to_ward_code: window.ghnState.selectedToWard,
                                height: parseInt(window.ghnState.packageDetails.height),
                                length: parseInt(window.ghnState.packageDetails.length),
                                weight: parseInt(window.ghnState.packageDetails.weight),
                                width: parseInt(window.ghnState.packageDetails.width),
                                insurance_value: parseInt(window.ghnState.packageDetails.insurance_value),
                                coupon: null
                            };

                            try {
                                console.log("Calculating shipping fee with payload:", JSON.stringify(payload, null, 2));
                                const response = await axios.post('https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee', payload, {
                                    headers: {
                                        Token: GHN_TOKEN,
                                        ShopId: SHOP_ID,
                                        'Content-Type': 'application/json'
                                    }
                                });

                                console.log("Shipping fee API response:", response.data);

                                if (response.data.code === 200) {
                                    // Store the shipping fee value directly from the response
                                    const shippingFeeValue = response.data.data.total;

                                    // *** STORE THE FEE IN STATE ***
                                    window.ghnState.shippingFeeValue = shippingFeeValue;

                                    // *** RECALCULATE ORDER SUMMARY ***
                                    calculateCartTotals();

                                    // Find the service name
                                    let serviceName = "Standard";
                                    if (window.ghnState.services && window.ghnState.services.length > 0) {
                                        const serviceObj = window.ghnState.services.find(s => s.service_id === window.ghnState.selectedService);
                                        if (serviceObj && serviceObj.service_name) {
                                            serviceName = serviceObj.service_name;
                                        }
                                    }

                                    // Format the shipping fee for display
                                    const formattedFee = shippingFeeValue ? shippingFeeValue.toLocaleString() : '0';

                                    console.log("Raw shipping fee from API:", shippingFeeValue);
                                    console.log("Shipping fee formatted:", formattedFee);
                                    console.log("Selected service:", serviceName);

                                    // Get the shipping fee result element - should exist from HTML
                                    let shippingFeeResultElement = document.getElementById('shipping-fee-result');

                                    if (!shippingFeeResultElement) {
                                        // This case is unlikely if the HTML is correct, but handle it defensively.
                                        console.error("FATAL: shipping-fee-result element not found in the DOM! Cannot display fee.");
                                        setError("Lỗi hiển thị phí vận chuyển: Không tìm thấy phần tử hiển thị.");
                                        return; // Stop if the fundamental element is missing
                                    }

                                    // Check if the element has the required inner structure (spans with IDs)
                                    let feeAmountSpan = shippingFeeResultElement.querySelector('#shipping-fee-amount');
                                    let serviceNameSpan = shippingFeeResultElement.querySelector('#shipping-service-name');

                                    // If the structure isn't correct, set it now
                                    if (!feeAmountSpan || !serviceNameSpan) {
                                        console.log("shipping-fee-result exists but lacks spans. Setting innerHTML structure.");
                                        shippingFeeResultElement.innerHTML = `
                                            <p class="font-semibold text-black">Phí vận chuyển: <span id="shipping-fee-amount" class="text-black"></span> VND</p>
                                            <p class="text-sm text-gray-600">Dịch vụ: <span id="shipping-service-name"></span></p>
                                            <p class="text-sm text-gray-600">Gói hàng: 500g, 20×15×15 cm</p>
                                        `;
                                        // Re-query for the spans after setting innerHTML
                                        feeAmountSpan = shippingFeeResultElement.querySelector('#shipping-fee-amount');
                                        serviceNameSpan = shippingFeeResultElement.querySelector('#shipping-service-name');
                                    }

                                    // Now, update the content of the specific spans (they should exist)
                                    if (feeAmountSpan && serviceNameSpan) {
                                        console.log(`Updating fee span with: ${formattedFee}`);
                                        console.log(`Updating service span with: ${serviceName}`);
                                        feeAmountSpan.textContent = formattedFee;
                                        serviceNameSpan.textContent = serviceName;

                                        // Ensure the result is visible
                                        shippingFeeResultElement.style.display = 'block';
                                        shippingFeeResultElement.classList.add('visible');

                                        console.log("Shipping fee result spans updated successfully.");
                                        console.log("Current innerHTML:", shippingFeeResultElement.innerHTML);
                                    } else {
                                        // This should ideally not be reached now
                                        console.error("Failed to find spans even after setting innerHTML. Cannot update fee display properly.");
                                        setError("Lỗi cập nhật hiển thị phí vận chuyển.");
                                        // As a last resort, make sure the container is visible even if content update failed partially
                                        shippingFeeResultElement.style.display = 'block';
                                        shippingFeeResultElement.classList.add('visible');
                                    }

                                    // Create a floating notification
                                    const notification = document.createElement('div');
                                    notification.style.position = 'fixed';
                                    notification.style.top = '20px';
                                    notification.style.right = '20px';
                                    notification.style.padding = '15px';
                                    notification.style.background = '#d1fae5';
                                    notification.style.border = '1px solid #10b981';
                                    notification.style.borderRadius = '8px';
                                    notification.style.boxShadow = '0 4px 6px rgba(0, 0, 0, 0.1)';
                                    notification.style.zIndex = '9999';
                                    notification.innerHTML =
                                        '<p style="margin: 0; font-weight: bold;">Phí vận chuyển: ' + formattedFee + ' VND</p>' +
                                        '<p style="margin: 5px 0 0 0; font-size: 14px;">Dịch vụ: ' + serviceName + '</p>';

                                    document.body.appendChild(notification);

                                    // Remove notification after 5 seconds
                                    setTimeout(() => {
                                        notification.remove();
                                    }, 5000);
                                } else {
                                    setError('Lỗi tính phí vận chuyển: ' + (err.response && err.response.data && err.response.data.message ? err.response.data.message : err.message));
                                    // Clear the fee if calculation fails
                                    window.ghnState.shippingFeeValue = null;
                                    calculateCartTotals(); // Update summary to show calculating/error state
                                }
                            } catch (err) {
                                console.error("Error calculating shipping fee:", err);
                                setError(`Lỗi tính phí vận chuyển: ${err.response && err.response.data && err.response.data.message ? err.response.data.message : err.message}`);
                                // Clear the fee on error
                                window.ghnState.shippingFeeValue = null;
                                calculateCartTotals(); // Update summary to show calculating/error state
                            } finally {
                                setLoading(false);
                            }
                        }

                        // Function to try calculating fee automatically
                        async function tryCalculateFeeAutomatically() {
                            console.log("Trying to calculate fee automatically...");

                            // Check if all required fields are available
                            if (!window.ghnState.selectedFromDistrict) {
                                console.log("Missing from district, can't calculate fee yet");
                                return;
                            }
                            if (!window.ghnState.selectedToDistrict) {
                                console.log("Missing to district, can't calculate fee yet");
                                return;
                            }
                            if (!window.ghnState.selectedToWard) {
                                console.log("Missing to ward, can't calculate fee yet");
                                return;
                            }

                            // If we have a destination district and ward but no service yet,
                            // fetch services which will then trigger calculation
                            if (!window.ghnState.selectedService) {
                                console.log("No service selected yet, fetching services first");
                                if (window.ghnState.selectedFromDistrict && window.ghnState.selectedToDistrict) {
                                    console.log(`Fetching services from ${window.ghnState.selectedFromDistrict} to ${window.ghnState.selectedToDistrict}`);
                                    fetchServices(window.ghnState.selectedFromDistrict, window.ghnState.selectedToDistrict);
                                    return;
                                }
                                return;
                            }

                            // Since all required data is available, calculate fee
                            console.log("All data available, calculating shipping fee");
                            await calculateShippingFee();
                        }

                        // Event Listeners for form inputs
                        document.getElementById('toProvince')?.addEventListener('change', function (e) {
                            window.ghnState.selectedToProvince = e.target.value;
                            if (window.ghnState.selectedToProvince) {
                                fetchDistricts(window.ghnState.selectedToProvince, false);
                            }
                        });

                        document.getElementById('toDistrict')?.addEventListener('change', function (e) {
                            window.ghnState.selectedToDistrict = e.target.value;
                            if (window.ghnState.selectedToDistrict) {
                                fetchWards(window.ghnState.selectedToDistrict, false);
                                if (window.ghnState.selectedFromDistrict) {
                                    fetchServices(window.ghnState.selectedFromDistrict, window.ghnState.selectedToDistrict);
                                }
                            }
                        });

                        document.getElementById('toWard')?.addEventListener('change', function (e) {
                            window.ghnState.selectedToWard = e.target.value;
                            // Try to calculate fee automatically
                            tryCalculateFeeAutomatically();
                        });

                        // Add event listener for the manual calculation button
                        document.getElementById('calculateShippingBtn')?.addEventListener('click', function () {
                            console.log("Calculate shipping button clicked");
                            calculateShippingFee();
                        });

                        // Dynamically calculate shipping based on selected address
                        document.getElementById('confirm-address')?.addEventListener('click', function () {
                            // Find the currently selected address from modal
                            const selectedAddressElement = document.querySelector('#address-modal .border-orange-500');
                            if (!selectedAddressElement) {
                                console.log("No address selected for shipping calculation");
                                return;
                            }

                            const addressId = selectedAddressElement.getAttribute('data-address-id');
                            if (!addressId) {
                                console.log("Selected address has no ID");
                                return;
                            }

                            // Get the address data from localStorage
                            const savedAddresses = JSON.parse(localStorage.getItem('userAddresses')) || [];
                            const selectedAddress = savedAddresses.find(addr => addr.id === addressId);

                            if (!selectedAddress) {
                                console.log("Cannot find address data for ID:", addressId);
                                return;
                            }

                            console.log("Selected address for shipping calculation:", selectedAddress);

                            // Update GHN state with selected address data
                            window.ghnState.selectedToProvince = selectedAddress.provinceId;
                            window.ghnState.selectedToDistrict = selectedAddress.districtId;
                            window.ghnState.selectedToWard = selectedAddress.wardCode;

                            // Ensure the destination values are correctly set as integers
                            if (window.ghnState.selectedToProvince) {
                                window.ghnState.selectedToProvince = parseInt(window.ghnState.selectedToProvince);
                            }

                            if (window.ghnState.selectedToDistrict) {
                                window.ghnState.selectedToDistrict = parseInt(window.ghnState.selectedToDistrict);
                            }

                            console.log("Updated GHN state with selected address:", {
                                provinceId: window.ghnState.selectedToProvince,
                                districtId: window.ghnState.selectedToDistrict,
                                wardCode: window.ghnState.selectedToWard
                            });

                            // Try to fetch services and calculate shipping automatically
                            if (window.ghnState.selectedFromDistrict && window.ghnState.selectedToDistrict) {
                                console.log("Fetching shipping services for selected address...");
                                fetchServices(window.ghnState.selectedFromDistrict, window.ghnState.selectedToDistrict);
                            } else {
                                console.log("Cannot calculate shipping: missing from district or to district");
                            }
                        });

                        // Also calculate shipping when page loads based on default address
                        document.addEventListener('DOMContentLoaded', function () {
                            // Wait a short time to ensure all address data is loaded
                            setTimeout(function () {
                                // Get the currently displayed address
                                const currentAddressElement = document.getElementById('recipient-address');
                                if (!currentAddressElement) {
                                    console.log("No recipient address element found");
                                    return;
                                }

                                // Find the address in localStorage that matches the displayed address
                                const savedAddresses = JSON.parse(localStorage.getItem('userAddresses')) || [];
                                const currentAddress = savedAddresses.find(addr => addr.isDefault === true);

                                if (!currentAddress) {
                                    console.log("No default address found in localStorage");
                                    return;
                                }

                                console.log("Default address for shipping calculation:", currentAddress);

                                // Update GHN state with current address data
                                window.ghnState.selectedToProvince = parseInt(currentAddress.provinceId);
                                window.ghnState.selectedToDistrict = parseInt(currentAddress.districtId);
                                window.ghnState.selectedToWard = currentAddress.wardCode;

                                console.log("Set initial GHN state with default address:", {
                                    provinceId: window.ghnState.selectedToProvince,
                                    districtId: window.ghnState.selectedToDistrict,
                                    wardCode: window.ghnState.selectedToWard
                                });

                                // Try to calculate shipping fee if from address is set
                                if (window.ghnState.selectedFromDistrict) {
                                    console.log("Trying to calculate initial shipping fee...");
                                    fetchServices(window.ghnState.selectedFromDistrict, window.ghnState.selectedToDistrict);
                                } else {
                                    console.log("Cannot calculate initial shipping: shop address not set");
                                }
                            }, 1000); // Wait 1 second for everything to initialize
                        }, { once: true });

                        // Modify validation function to include new shipping fields
                        const originalValidateForm = validateForm;
                        validateForm = function () {
                            // Call the original validation function first
                            const originalResult = originalValidateForm();

                            // Additional validation for GHN shipping fields
                            const isToProvinceValid = validateSelect(document.getElementById('toProvince'), 'Vui lòng chọn tỉnh/thành phố');
                            const isToDistrictValid = validateSelect(document.getElementById('toDistrict'), 'Vui lòng chọn quận/huyện');
                            const isToWardValid = validateSelect(document.getElementById('toWard'), 'Vui lòng chọn phường/xã');
                            const isDetailAddressValid = validateInput(document.getElementById('detailAddress'), 'Vui lòng nhập địa chỉ chi tiết');

                            // Combine with original validation result
                            return originalResult && isToProvinceValid && isToDistrictValid && isToWardValid && isDetailAddressValid;
                        };

                        // Initialize GHN shipping
                        fetchProvinces();

                        // THÊM MỚI: Đồng bộ địa chỉ mặc định với GHN API sau khi khởi tạo
                        setTimeout(() => {
                            console.log('[GHN Init] Synchronizing default address with GHN API...');

                            // Lấy địa chỉ mặc định từ localStorage
                            try {
                                // Kiểm tra địa chỉ đã lưu trước trong selectedAddress
                                const savedAddress = localStorage.getItem('selectedAddress');
                                if (savedAddress) {
                                    const addressData = JSON.parse(savedAddress);
                                    console.log('[GHN Init] Found selected address in localStorage:', addressData);

                                    if (addressData.provinceId && addressData.districtId && addressData.wardCode) {
                                        // Cập nhật ghnState
                                        window.ghnState.selectedToProvince = parseInt(addressData.provinceId);
                                        window.ghnState.selectedToDistrict = parseInt(addressData.districtId);
                                        window.ghnState.selectedToWard = addressData.wardCode;

                                        console.log('[GHN Init] Updated GHN state with selected address data');

                                        // Gọi tính phí vận chuyển khi GHN API đã sẵn sàng
                                        setTimeout(() => {
                                            if (typeof calculateShippingFee === 'function') {
                                                console.log('[GHN Init] Auto-calculating shipping fee...');
                                                calculateShippingFee().then(() => {
                                                    console.log('[GHN Init] Shipping fee calculation completed');

                                                    // Hiển thị kết quả
                                                    const shippingFeeResult = document.getElementById('shipping-fee-result');
                                                    if (shippingFeeResult) {
                                                        shippingFeeResult.style.display = 'block';
                                                    }
                                                }).catch(err => {
                                                    console.error('[GHN Init] Error calculating shipping fee:', err);
                                                });
                                            } else {
                                                console.warn('[GHN Init] calculateShippingFee function not available');
                                            }
                                        }, 1500); // Đợi GHN API khởi tạo hoàn tất
                                    }
                                } else {
                                    // Nếu không có selectedAddress, thử tìm địa chỉ mặc định từ userAddresses
                                    const userAddresses = JSON.parse(localStorage.getItem('userAddresses') || '[]');
                                    const defaultAddress = userAddresses.find(addr => addr.isDefault);

                                    if (defaultAddress && defaultAddress.provinceId && defaultAddress.districtId && defaultAddress.wardCode) {
                                        console.log('[GHN Init] Using default address from userAddresses:', defaultAddress);

                                        // Cập nhật ghnState
                                        window.ghnState.selectedToProvince = parseInt(defaultAddress.provinceId);
                                        window.ghnState.selectedToDistrict = parseInt(defaultAddress.districtId);
                                        window.ghnState.selectedToWard = defaultAddress.wardCode;

                                        // Lưu địa chỉ được chọn để sử dụng sau này
                                        localStorage.setItem('selectedAddress', JSON.stringify(defaultAddress));

                                        console.log('[GHN Init] Updated GHN state with default address data');

                                        // Gọi tính phí vận chuyển khi GHN API đã sẵn sàng
                                        setTimeout(() => {
                                            if (typeof calculateShippingFee === 'function') {
                                                console.log('[GHN Init] Auto-calculating shipping fee...');
                                                calculateShippingFee().then(() => {
                                                    console.log('[GHN Init] Shipping fee calculation completed');

                                                    // Hiển thị kết quả
                                                    const shippingFeeResult = document.getElementById('shipping-fee-result');
                                                    if (shippingFeeResult) {
                                                        shippingFeeResult.style.display = 'block';
                                                    }
                                                }).catch(err => {
                                                    console.error('[GHN Init] Error calculating shipping fee:', err);
                                                });
                                            } else {
                                                console.warn('[GHN Init] calculateShippingFee function not available');
                                            }
                                        }, 1500); // Đợi GHN API khởi tạo hoàn tất
                                    }
                                }
                            } catch (error) {
                                console.error('[GHN Init] Error synchronizing default address:', error);
                            }
                        }, 1000); // Đợi fetchProvinces hoàn tất

                        // Disable the sender address fields
                        setTimeout(() => {
                            document.getElementById('fromProvince').disabled = true;
                            document.getElementById('fromDistrict').disabled = true;
                            document.getElementById('fromWard').disabled = true;
                        }, 1500);
                    });

                    // Functionality for "Mặc định" buttons
                    const defaultButtons = document.querySelectorAll('.address-option .text-gray-500.text-sm.border.mr-2');
                    defaultButtons.forEach(btn => {
                        btn.addEventListener('click', function (e) {
                            e.preventDefault();
                            e.stopPropagation();

                            const addressOption = this.closest('.address-option');

                            // Remove default badge from all addresses
                            document.querySelectorAll('.address-option .px-2.py-1.bg-red-100.text-red-800').forEach(badge => {
                                badge.remove();
                            });

                            // Add default badge to this address header
                            const headerDiv = addressOption.querySelector('.flex.items-center.justify-between.w-full.mb-1');
                            if (headerDiv) {
                                const defaultBadge = document.createElement('span');
                                defaultBadge.className = 'px-2 py-1 bg-red-100 text-red-800 text-xs font-medium rounded';
                                defaultBadge.textContent = 'Mặc định';
                                headerDiv.appendChild(defaultBadge);
                            }

                            // If this address is also selected, update main display
                            if (addressOption.classList.contains('selected')) {
                                const mainDefaultBadge = document.querySelector('.w-full.p-4 .inline-block.px-2.py-1.bg-red-100.text-red-800');
                                if (mainDefaultBadge) {
                                    mainDefaultBadge.style.display = 'inline-block';
                                }
                            }
                        });
                    });

                    // Function to initialize address list from localStorage
                    function initializeAddressesFromLocalStorage() {
                        try {
                            const savedAddresses = loadAddressesFromLocalStorage();
                            if (Object.keys(savedAddresses).length === 0) {
                                console.log('No saved addresses found in localStorage');
                                return;
                            }

                            console.log('Initializing address list from localStorage');

                            // Get the address container
                            const addressContainer = document.querySelector('.p-6');
                            if (!addressContainer) {
                                console.error('Address container not found');
                                return;
                            }

                            // Clear existing addresses if modal has starter data
                            const existingAddressCount = document.querySelectorAll('.address-option').length;
                            if (existingAddressCount > 0) {
                                // Clear all existing addresses only if there are saved addresses
                                if (Object.keys(savedAddresses).length > 0) {
                                    const addressOptionsParent = document.querySelector('.p-6');
                                    if (addressOptionsParent) {
                                        // Remove all existing address options
                                        const existingOptions = addressOptionsParent.querySelectorAll('.address-option');
                                        existingOptions.forEach(option => option.remove());
                                    }
                                }
                            }

                            // Track default address for main display update
                            let defaultAddress = null;

                            // Create and add each address
                            Object.keys(savedAddresses).forEach(addressId => {
                                const addressData = savedAddresses[addressId];

                                // Remember default address
                                if (addressData.isDefault) {
                                    defaultAddress = addressData;
                                }

                                // Check if this address already exists in the DOM
                                const existingAddress = document.querySelector(`.address-option[data-address-id="${addressId}"]`);
                                if (existingAddress) {
                                    console.log(`Address ${addressId} already exists in DOM, updating`);
                                    // Update existing address with current data
                                    const nameElement = existingAddress.querySelector('.font-medium');
                                    const phoneElement = existingAddress.querySelector('.text-sm.text-gray-500');
                                    const addressLines = existingAddress.querySelectorAll('p.text-gray-700');

                                    if (nameElement) nameElement.textContent = addressData.name;
                                    if (phoneElement) phoneElement.textContent = addressData.phone;
                                    if (addressLines.length >= 2) {
                                        addressLines[0].textContent = addressData.detailAddress;
                                        addressLines[1].textContent = (addressData.ward || '') + (addressData.ward && addressData.district ? ', ' : '') + (addressData.district || '') + ((addressData.district && addressData.province) ? ', ' : '') + (addressData.province || '');
                                    }

                                    // Update default badge if needed
                                    const headerDiv = existingAddress.querySelector('.flex.items-center.justify-between.w-full.mb-1');
                                    const defaultBadge = headerDiv.querySelector('.px-2.py-1.bg-red-100.text-red-800');

                                    if (addressData.isDefault && !defaultBadge) {
                                        // Add default badge
                                        const newBadge = document.createElement('span');
                                        newBadge.className = 'px-2 py-1 bg-red-100 text-red-800 text-xs font-medium rounded';
                                        newBadge.textContent = 'Mặc định';
                                        headerDiv.appendChild(newBadge);
                                    } else if (!addressData.isDefault && defaultBadge) {
                                        // Remove default badge
                                        defaultBadge.remove();
                                    }

                                    // Update selected state if needed
                                    if (addressData.isDefault) {
                                        // Select this address
                                        document.querySelectorAll('.address-option').forEach(opt => {
                                            opt.classList.remove('selected');
                                            const radio = opt.querySelector('.w-5.h-5');
                                            if (radio) {
                                                radio.classList.remove('border-blue-500');
                                                radio.classList.add('border-gray-300');
                                                const innerCircle = radio.querySelector('.w-3.h-3');
                                                if (innerCircle) {
                                                    innerCircle.classList.remove('bg-blue-500');
                                                    innerCircle.classList.add('bg-transparent');
                                                }
                                            }
                                        });

                                        // Mark this one as selected
                                        existingAddress.classList.add('selected');
                                        const radio = existingAddress.querySelector('.w-5.h-5');
                                        if (radio) {
                                            radio.classList.remove('border-gray-300');
                                            radio.classList.add('border-blue-500');
                                            const innerCircle = radio.querySelector('.w-3.h-3');
                                            if (innerCircle) {
                                                innerCircle.classList.remove('bg-transparent');
                                                innerCircle.classList.add('bg-blue-500');
                                            }
                                        }
                                    }

                                    return;
                                }

                                // Create the address HTML
                                const newAddressHTML = `
                                    <div class="border rounded-md p-4 mb-4 hover:border-blue-500 cursor-pointer address-option \${addressData.isDefault ? 'selected' : ''}" data-address-id="\${addressId}">
                                        <div class="flex items-start mb-2">
                                            <div class="flex-shrink-0 mt-1">
                                                <div class="w-5 h-5 border \${addressData.isDefault ? 'border-blue-500' : 'border-gray-300'} rounded-full flex items-center justify-center">
                                                    <div class="w-3 h-3 \${addressData.isDefault ? 'bg-blue-500' : 'bg-transparent'} rounded-full"></div>
                                                </div>
                                            </div>
                                            <div class="ml-3 flex-grow">
                                                <div class="flex items-center justify-between w-full mb-1">
                                                    <div class="flex items-center">
                                                        <span class="font-medium">\${addressData.name}</span>
                                                        <span class="ml-3 text-sm text-gray-500">\${addressData.phone}</span>
                                                    </div>
                                                    \${addressData.isDefault ? '<span class="px-2 py-1 bg-red-100 text-red-800 text-xs font-medium rounded">Mặc định</span>' : ''}
                                                </div>
                                                <p class="text-gray-700 mb-1">\${addressData.detailAddress}</p>
                                                <p class="text-gray-700">\${addressData.ward != null ? addressData.ward : ''}\${addressData.ward != null && addressData.district != null ? ', ' : ''}\${addressData.district != null ? addressData.district : ''}\${addressData.district != null && addressData.province != null ? ', ' : ''}\${addressData.province != null ? addressData.province : ''}</p>
                                                <div class="flex items-center mt-2">
                                                    <button class="text-gray-500 text-sm border px-4 py-1 rounded mr-2">Mặc định</button>
                                                    <button class="edit-address-btn text-blue-600 text-sm border border-blue-600 px-4 py-1 rounded">Thay đổi</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                `;

                                // Add to the DOM
                                const div = document.createElement('div');
                                div.innerHTML = newAddressHTML;
                                const newAddressNode = div.firstChild;
                                addressContainer.prepend(newAddressNode);

                                // Add event listeners
                                addAddressEventListeners(newAddressNode);
                            });

                            // Update main display with default address if any
                            if (defaultAddress) {
                                updateMainDisplayWithAddress(defaultAddress);
                            }

                            console.log('Finished initializing address list');
                        } catch (error) {
                            console.error('Error initializing address list:', error);
                        }
                    }

                    // Function to update main display with address
                    function updateMainDisplayWithAddress(addressData) {
                        if (!addressData) {
                            console.warn('Cannot update display: No address data provided');
                            return;
                        }

                        console.log('Updating main display with address:', addressData);

                        // Get the display elements
                        const recipientName = document.getElementById('recipient-name');
                        const recipientPhone = document.getElementById('recipient-phone');
                        const recipientAddress = document.getElementById('recipient-address');

                        // Update the display if elements exist
                        if (recipientName) {
                            recipientName.textContent = addressData.name || '';
                        }

                        if (recipientPhone) {
                            recipientPhone.textContent = addressData.phone || '';
                        }

                        if (recipientAddress) {
                            let fullAddress = '';

                            // Handle different address data formats
                            if (addressData.street) {
                                // API format
                                const parts = [
                                    addressData.street,
                                    addressData.ward,
                                    addressData.district,
                                    addressData.province,
                                    addressData.city
                                ].filter(part => part && part.trim() !== '');

                                fullAddress = parts.join(', ');
                            } else if (addressData.addressLine1) {
                                // Modal format
                                fullAddress = addressData.addressLine1;
                                if (addressData.addressLine2 && addressData.addressLine2 !== 'No additional address details') {
                                    fullAddress += ', ' + addressData.addressLine2;
                                }
                            } else if (addressData.detailAddress) {
                                // Legacy format
                                const parts = [
                                    addressData.detailAddress,
                                    addressData.ward,
                                    addressData.district,
                                    addressData.province
                                ].filter(part => part && part.trim() !== '');

                                fullAddress = parts.join(', ');
                            }

                            recipientAddress.textContent = fullAddress || 'No address details available';
                        }

                        // Log the updated display
                        console.log('Updated main display with address');
                    }

                    // Helper function to add event listeners to address option
                    function addAddressEventListeners(addressNode) {
                        // Add event listener to the edit button
                        const editBtn = addressNode.querySelector('.edit-address-btn');
                        if (editBtn) {
                            editBtn.addEventListener('click', function (e) {
                                e.preventDefault();
                                e.stopPropagation();

                                // Get the name and phone from this address
                                const addressOption = this.closest('.address-option');
                                const name = addressOption.querySelector('.font-medium').textContent;
                                const phone = addressOption.querySelector('.text-sm.text-gray-500').textContent;
                                const addressLine1 = addressOption.querySelectorAll('p.text-gray-700')[0].textContent;

                                // Pre-fill form with address data
                                document.getElementById('fullNameEdit').value = name;
                                document.getElementById('phoneEdit').value = phone;
                                document.getElementById('detailAddress').value = addressLine1;

                                // Save the address option reference for later update
                                window.currentEditingAddressOption = addressOption;

                                // Close the modal
                                const closeModal = function () {
                                    document.getElementById('address-modal').classList.add('hidden');
                                    document.body.style.overflow = 'auto'; // Re-enable scrolling
                                };
                                closeModal();

                                // Show the shipping form
                                document.getElementById('shipping-form').style.display = 'block';

                                // Scroll to shipping form
                                document.getElementById('shipping-form').scrollIntoView({ behavior: 'smooth' });
                            });
                        }

                        // Add click event for selection
                        addressNode.addEventListener('click', function (e) {
                            if (e.target.tagName === 'BUTTON') {
                                return;
                            }

                            // Remove selected class from all options
                            document.querySelectorAll('.address-option').forEach(opt => {
                                opt.classList.remove('selected');
                                const radio = opt.querySelector('.w-5.h-5');
                                if (radio) {
                                    radio.classList.remove('border-blue-500');
                                    radio.classList.add('border-gray-300');
                                    const innerCircle = radio.querySelector('.w-3.h-3');
                                    if (innerCircle) {
                                        innerCircle.classList.remove('bg-blue-500');
                                        innerCircle.classList.add('bg-transparent');
                                    }
                                }
                            });

                            // Add selected class to this option
                            this.classList.add('selected');
                            const radio = this.querySelector('.w-5.h-5');
                            if (radio) {
                                radio.classList.remove('border-gray-300');
                                radio.classList.add('border-blue-500');
                                const innerCircle = radio.querySelector('.w-3.h-3');
                                if (innerCircle) {
                                    innerCircle.classList.remove('bg-transparent');
                                    innerCircle.classList.add('bg-blue-500');
                                }
                            }
                        });

                        // Add event listener to the default button
                        const defaultBtn = addressNode.querySelector('.text-gray-500.text-sm.border.mr-2');
                        if (defaultBtn) {
                            defaultBtn.addEventListener('click', function (e) {
                                e.preventDefault();
                                e.stopPropagation();

                                const addressOption = this.closest('.address-option');
                                const addressId = addressOption.dataset.addressId;

                                // Get the address data from localStorage
                                const savedAddresses = loadAddressesFromLocalStorage();
                                if (savedAddresses[addressId]) {
                                    // Update this address to be default
                                    savedAddresses[addressId].isDefault = true;

                                    // Save back to localStorage (this will unset default on others)
                                    saveAddressToLocalStorage(addressId, savedAddresses[addressId]);

                                    // Update UI to show this is the default address
                                    // First remove default badge from all addresses
                                    document.querySelectorAll('.address-option .px-2.py-1.bg-red-100.text-red-800').forEach(badge => {
                                        badge.remove();
                                    });

                                    // Add default badge to this address header
                                    const headerDiv = addressOption.querySelector('.flex.items-center.justify-between.w-full.mb-1');
                                    if (headerDiv) {
                                        const defaultBadge = document.createElement('span');
                                        defaultBadge.className = 'px-2 py-1 bg-red-100 text-red-800 text-xs font-medium rounded';
                                        defaultBadge.textContent = 'Mặc định';
                                        headerDiv.appendChild(defaultBadge);
                                    }

                                    // If this is the selected address, update the main display
                                    if (addressOption.classList.contains('selected')) {
                                        updateMainDisplayWithAddress(savedAddresses[addressId]);
                                    }

                                    // Show success toast
                                    showToast('Đã đặt địa chỉ này làm mặc định');
                                }
                            });
                        }
                    }

                    // Function to show toast notifications
                    function showToast(message, isSuccess = true, bgColor = null) {
                        // Create toast element if it doesn't exist
                        let toast = document.querySelector('.toast-notification');
                        if (toast) {
                            // If a toast already exists, remove it
                            toast.remove();
                        }

                        // Create new toast
                        toast = document.createElement('div');
                        toast.className = 'toast-notification ' + (isSuccess ? 'bg-green-500' : 'bg-red-500');
                        toast.textContent = message;

                        // Add to document
                        document.body.appendChild(toast);

                        // Remove after animation completes (3s)
                        setTimeout(() => {
                            if (document.body.contains(toast)) {
                                document.body.removeChild(toast);
                            }
                        }, 3000);
                    }

                    // Function to save address to localStorage
                    function saveAddressToLocalStorage(addressId, addressData) {
                        try {
                            // Get existing addresses or initialize empty object
                            let savedAddresses = JSON.parse(localStorage.getItem('savedAddresses')) || {};

                            // If this address is set as default, unset default on others
                            if (addressData.isDefault) {
                                Object.keys(savedAddresses).forEach(key => {
                                    if (savedAddresses[key]) {
                                        savedAddresses[key].isDefault = false;
                                    }
                                });
                            }

                            // Save this address
                            savedAddresses[addressId] = addressData;

                            // Save back to localStorage
                            localStorage.setItem('savedAddresses', JSON.stringify(savedAddresses));
                            console.log('Address saved to localStorage:', addressId);
                            console.log('Address data:', JSON.stringify(addressData));
                        } catch (error) {
                            console.error('Error saving address to localStorage:', error);
                        }
                    }

                    // Function to load addresses from localStorage
                    function loadAddressesFromLocalStorage() {
                        try {
                            const savedAddresses = JSON.parse(localStorage.getItem('savedAddresses')) || {};
                            console.log('Loaded addresses from localStorage:', Object.keys(savedAddresses).length);
                            return savedAddresses;
                        } catch (error) {
                            console.error('Error loading addresses from localStorage:', error);
                            return {};
                        }
                    }

                    // Initialize saved addresses when loading page
                    document.addEventListener('DOMContentLoaded', function () {
                        // Load saved addresses and update UI if needed
                        try {
                            const savedAddresses = loadAddressesFromLocalStorage();

                            // If we have saved addresses, find the default one
                            let defaultAddress = null;
                            Object.keys(savedAddresses).forEach(addressId => {
                                if (savedAddresses[addressId].isDefault) {
                                    defaultAddress = savedAddresses[addressId];
                                    defaultAddress.id = addressId;
                                }
                            });

                            // If we have a default address, update the main display
                            if (defaultAddress) {
                                console.log('Found default address:', defaultAddress);

                                // Update main display with default address
                                const recipientNameElement = document.getElementById('recipient-name');
                                const recipientPhoneElement = document.getElementById('recipient-phone');
                                const recipientAddressElement = document.getElementById('recipient-address');

                                // Ensure all elements exist before updating
                                if (recipientNameElement && recipientPhoneElement && recipientAddressElement) {
                                    recipientNameElement.textContent = defaultAddress.name;
                                    recipientPhoneElement.textContent = defaultAddress.phone;

                                    const fullAddress = defaultAddress.detailAddress +
                                        (defaultAddress.ward ? ', ' + defaultAddress.ward : '') +
                                        (defaultAddress.district ? ', ' + defaultAddress.district : '') +
                                        (defaultAddress.province ? ', ' + defaultAddress.province : '');
                                    recipientAddressElement.textContent = fullAddress;
                                    recipientAddressElement.style.display = 'block';
                                }
                            }
                        } catch (error) {
                            console.error('Error initializing saved addresses:', error);
                        }
                    });

                    // Function to collect order items and calculate order values
                    function calculateOrderValues() {
                        // Collect order items
                        const orderItems = [];
                        document.querySelectorAll('.space-y-4.mb-6 > div.flex').forEach(item => {
                            // Get product name to help with debugging
                            const productName = item.querySelector('h3')?.textContent.trim();

                            // Get image element and extract product_variant_id
                            const imgElement = item.querySelector('img');
                            const productVariantId = imgElement ? parseInt(imgElement.getAttribute('data-variant-id') || 0) : 0;

                            // Get quantity from the text
                            const quantityText = item.querySelector('div.text-right > p.text-xs')?.textContent.trim();
                            const quantity = parseInt(quantityText?.replace('Qty: ', '') || '1') || 1;

                            // Get price from the text
                            const priceText = item.querySelector('div.text-right > p.text-sm')?.textContent.trim();
                            const price = parseFloat(priceText?.replace('$', '') || '0') || 0;

                            // Only add items with valid product_variant_id
                            if (productVariantId > 0) {
                                // Create base order item
                                const orderItem = {
                                    product_variant_id: productVariantId,
                                    quantity: quantity,
                                    price: price,
                                    applied_discounts: [] // Initialize empty array for discounts
                                };

                                // Check for applicable discounts
                                if (window.appliedDiscounts && window.appliedDiscounts.length > 0) {
                                    // Find all discounts that apply to this product variant
                                    const matchingDiscounts = window.appliedDiscounts.filter(
                                        discount => discount.productVariantId &&
                                            (discount.productVariantId == productVariantId ||
                                                String(discount.productVariantId) === String(productVariantId))
                                    );

                                    // Add matching discounts to this order item
                                    if (matchingDiscounts.length > 0) {
                                        // Ensure we only take the first discount (most recently applied)
                                        // to enforce one discount per product constraint
                                        const singleDiscount = matchingDiscounts[0];
                                        orderItem.applied_discounts = [{
                                            code: singleDiscount.code,
                                            id: singleDiscount.id,
                                            percentage: singleDiscount.percentage,
                                            product_variant_id: singleDiscount.productVariantId,
                                            product_name: singleDiscount.productName || productName,
                                            min_order_value: singleDiscount.min_order_value,
                                            max_discount_amount: singleDiscount.max_discount_amount
                                        }];
                                        console.log(`Applied discount: ${singleDiscount.code} to product: ${productName}`);
                                    }
                                }

                                orderItems.push(orderItem);
                                console.log(`Added product: ${productName}, variant ID: ${productVariantId}, quantity: ${quantity}, price: ${price}`);
                            }
                        });

                        // Calculate order values
                        const subtotal = orderState.orderTotal || 0;
                        const discountAmount = orderState.discount || 0;
                        const shippingFee = orderState.shipping.fee || 0;
                        const taxAmount = 0;
                        const totalAfterDiscount = subtotal - discountAmount;
                        const finalTotal = totalAfterDiscount + shippingFee + taxAmount;

                        return {
                            orderItems: orderItems,
                            orderCalculation: {
                                subtotal: subtotal,
                                totalDiscountAmount: discountAmount,
                                shippingFee: shippingFee,
                                taxAmount: taxAmount,
                                totalAfterDiscount: totalAfterDiscount,
                                finalTotal: finalTotal,
                                appliedDiscounts: window.appliedDiscounts || []
                            }
                        };
                    }

                    // Use the function to get values
                    const orderData = calculateOrderValues();

                    orderCalculation: orderData.orderCalculation
                </script>




                <!-- Add this script tag at the end of the file, before the closing body tag -->
                <script src="${pageContext.request.contextPath}/assets/js/address-handler.js"></script>



                <script>
                    // Function to save address to localStorage
                    function saveAddressToLocalStorage(addressId, addressData) {
                        try {
                            // Get existing addresses or initialize empty object
                            let savedAddresses = JSON.parse(localStorage.getItem('savedAddresses')) || {};

                            // If this address is set as default, unset default on others
                            if (addressData.isDefault) {
                                Object.keys(savedAddresses).forEach(key => {
                                    if (savedAddresses[key]) {
                                        savedAddresses[key].isDefault = false;
                                    }
                                });
                            }

                            // Save this address
                            savedAddresses[addressId] = addressData;

                            // Save back to localStorage
                            localStorage.setItem('savedAddresses', JSON.stringify(savedAddresses));
                            console.log('Address saved to localStorage:', addressId);
                            console.log('Address data:', JSON.stringify(addressData));
                        } catch (error) {
                            console.error('Error saving address to localStorage:', error);
                        }
                    }

                    // Function to load addresses from localStorage
                    function loadAddressesFromLocalStorage() {
                        try {
                            const savedAddresses = JSON.parse(localStorage.getItem('savedAddresses')) || {};
                            console.log('Loaded addresses from localStorage:', Object.keys(savedAddresses).length);
                            return savedAddresses;
                        } catch (error) {
                            console.error('Error loading addresses from localStorage:', error);
                            return {};
                        }
                    }

                    // Initialize saved addresses when loading page
                    document.addEventListener('DOMContentLoaded', function () {
                        // Load saved addresses and update UI if needed
                        try {
                            const savedAddresses = loadAddressesFromLocalStorage();

                            // If we have saved addresses, find the default one
                            let defaultAddress = null;
                            Object.keys(savedAddresses).forEach(addressId => {
                                if (savedAddresses[addressId].isDefault) {
                                    defaultAddress = savedAddresses[addressId];
                                    defaultAddress.id = addressId;
                                }
                            });

                            // If we have a default address, update the main display
                            if (defaultAddress) {
                                console.log('Found default address:', defaultAddress);

                                // Update main display with default address
                                const recipientNameElement = document.getElementById('recipient-name');
                                const recipientPhoneElement = document.getElementById('recipient-phone');
                                const recipientAddressElement = document.getElementById('recipient-address');

                                // Ensure all elements exist before updating
                                if (recipientNameElement && recipientPhoneElement && recipientAddressElement) {
                                    recipientNameElement.textContent = defaultAddress.name;
                                    recipientPhoneElement.textContent = defaultAddress.phone;

                                    const fullAddress = defaultAddress.detailAddress +
                                        (defaultAddress.ward ? ', ' + defaultAddress.ward : '') +
                                        (defaultAddress.district ? ', ' + defaultAddress.district : '') +
                                        (defaultAddress.province ? ', ' + defaultAddress.province : '');
                                    recipientAddressElement.textContent = fullAddress;
                                    recipientAddressElement.style.display = 'block';
                                }
                            }
                        } catch (error) {
                            console.error('Error initializing saved addresses:', error);
                        }
                    });
                </script>

                <!-- Script to log customerAddressesv2 data to console -->
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        console.log('--- customerAddressesv2 Data ---');

                        // Get data from hidden input
                        const addressesDataElement = document.getElementById('customerAddressesData');

                        if (addressesDataElement) {
                            console.log('Model attribute customerAddressesv2 found');

                            try {
                                // Log raw value
                                console.log('Raw data:', addressesDataElement.value);

                                // Attempt to parse any JSON format if possible
                                try {
                                    const jsonData = JSON.parse(addressesDataElement.value);
                                    console.log('Parsed JSON data:', jsonData);
                                } catch (jsonError) {
                                    console.log('Data is not in JSON format');
                                }
                            } catch (error) {
                                console.error('Error processing address data:', error);
                            }
                        } else {
                            console.log('Model attribute customerAddressesv2: null');
                        }
                    });
                </script>



                <!-- Script to log customerAddressesv2 data -->
                <script>
                    // Console log the customerAddressesv2 data
                    document.addEventListener('DOMContentLoaded', function () {
                        console.log('--- Logging Customer Addresses Data ---');

                        // Try to detect customer addresses from any source on the page
                        console.log('Addresses from JSP modellllllllll:', '${customerAddressesv2}');

                        // Try to find address data in localStorage
                        if (window.localStorage) {
                            console.log('Checking localStorage for addresses...');

                            try {
                                // Check different possible keys
                                const possibleKeys = ['userAddresses', 'savedAddresses', 'addresses', 'customerAddresses'];

                                possibleKeys.forEach(key => {
                                    const storageData = localStorage.getItem(key);
                                    if (storageData) {
                                        console.log(`Found data in localStorage["${key}"]:`, storageData);
                                        try {
                                            const parsedData = JSON.parse(storageData);
                                            console.log(`Parsed localStorage["${key}"] as JSON:`, parsedData);
                                        } catch (e) {
                                            console.log(`Could not parse localStorage["${key}"] as JSON:`, e);
                                        }
                                    }
                                });
                            } catch (e) {
                                console.error('Error accessing localStorage:', e);
                            }
                        }

                        // Try indirect approaches to find the data in the DOM
                        console.log('Searching for address data in the DOM...');

                        // Method 1: Find by attribute
                        const addressElements = document.querySelectorAll('[data-address-id]');
                        if (addressElements.length > 0) {
                            console.log('Found', addressElements.length, 'address elements with [data-address-id]');
                            addressElements.forEach((el, i) => {
                                console.log('Address #' + (i + 1) + ':', {
                                    element: el,
                                    id: el.dataset.addressId,
                                    text: el.textContent
                                });
                            });
                        } else {
                            console.log('No address elements found with [data-address-id]');
                        }

                        // Method 2: Find by recipient info
                        const recipientName = document.getElementById('recipient-name');
                        const recipientPhone = document.getElementById('recipient-phone');
                        const recipientAddress = document.getElementById('recipient-address');

                        if (recipientName || recipientPhone || recipientAddress) {
                            console.log('Found recipient information in the DOM:');
                            console.log('Recipient:', {
                                name: recipientName ? recipientName.textContent : 'Not found',
                                phone: recipientPhone ? recipientPhone.textContent : 'Not found',
                                address: recipientAddress ? recipientAddress.textContent : 'Not found'
                            });
                        } else {
                            console.log('No recipient information found in the DOM');
                        }

                        // Method 3: Check if any hidden inputs contain address data
                        const hiddenInputs = document.querySelectorAll('input[type="hidden"]');
                        console.log(`Found ${hiddenInputs.length} hidden inputs - checking for address data:`);

                        hiddenInputs.forEach((input, i) => {
                            const inputId = input.id || 'unknown-id';
                            const inputName = input.name || 'unknown-name';
                            const inputValue = input.value || '';

                            if (inputValue && (
                                inputId.toLowerCase().includes('address') ||
                                inputName.toLowerCase().includes('address') ||
                                inputValue.toLowerCase().includes('address') ||
                                inputValue.toLowerCase().includes('recipient')
                            )) {
                                console.log(`Hidden input #${i + 1} [${inputId}/${inputName}] may contain address data:`, inputValue);
                            }
                        });
                    });
                </script>

                <!-- Script for processing Addressv2 data -->
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        console.log('--- Addressv2 Parser ---');

                        // Hàm phân tích dữ liệu Addressv2
                        function parseAddressv2(addressv2String) {
                            try {
                                console.log('Parsing Addressv2 string:', addressv2String);

                                // Array to store multiple addresses
                                const addresses = [];

                                // Check if we have multiple addresses (indicated by [...] format)
                                const isMultipleAddresses = addressv2String.startsWith('[') && addressv2String.endsWith(']');

                                if (isMultipleAddresses) {
                                    // Extract each Addressv2 instance
                                    // Remove outer brackets and split by "Addressv2(" or "), Addressv2("
                                    const addressesStrings = addressv2String.substring(1, addressv2String.length - 1)
                                        .split(/\)\s*,\s*Addressv2\(/);

                                    // Process first item which might have "Addressv2(" prefix
                                    let firstItem = addressesStrings[0];
                                    if (firstItem.startsWith("Addressv2(")) {
                                        firstItem = firstItem.substring("Addressv2(".length);
                                        addressesStrings[0] = firstItem;
                                    }

                                    // Process last item which might have ")" suffix
                                    let lastItem = addressesStrings[addressesStrings.length - 1];
                                    if (lastItem.endsWith(")")) {
                                        lastItem = lastItem.substring(0, lastItem.length - 1);
                                        addressesStrings[addressesStrings.length - 1] = lastItem;
                                    }

                                    console.log(`Found ${addressesStrings.length} addresses to process`);

                                    // Process each address individually
                                    addressesStrings.forEach((addrStr, index) => {
                                        try {
                                            // Function to extract values for individual address
                                            function extractValue(pattern, defaultValue = '') {
                                                const regex = new RegExp(pattern + '=([^,\\)]+)');
                                                const match = addrStr.match(regex);
                                                return match ? match[1].trim() : defaultValue;
                                            }

                                            // Extract nested values
                                            const wardName = extractWardName(addrStr);
                                            const districtName = extractDistrictName(addrStr);
                                            const provinceName = extractProvinceName(addrStr);

                                            // Lấy thông tin cá nhân từ form
                                            const defaultName = document.getElementById('fullName')?.value ||
                                                document.getElementById('recipient-name')?.textContent || '';
                                            const defaultPhone = document.getElementById('phone')?.value ||
                                                document.getElementById('recipient-phone')?.textContent || '';

                                            // Create address object
                                            const address = {
                                                id: extractValue('addressId', '0'), // Extract addressId,
                                                name: defaultName.trim(),
                                                phone: defaultPhone.trim(),
                                                provinceId: extractValue('provinceId', '0'),
                                                provinceName: provinceName,
                                                districtId: extractValue('districtId', '0'),
                                                districtName: districtName,
                                                wardCode: extractValue('wardId', '0'),
                                                wardName: wardName,
                                                detailAddress: extractValue('street', ''),
                                                fullAddress: extractValue('street', '') +
                                                    (wardName ? ', ' + wardName : '') +
                                                    (districtName ? ', ' + districtName : '') +
                                                    (provinceName ? ', ' + provinceName : ''),
                                                isDefault: index === 0, // Set first address as default
                                            };

                                            addresses.push(address);
                                            console.log(`Processed address #${index + 1}:`, address);
                                        } catch (err) {
                                            console.error(`Error processing address #${index + 1}:`, err);
                                        }
                                    });
                                } else {
                                    // Process single address
                                    function extractValue(pattern, defaultValue = '') {
                                        const regex = new RegExp(pattern + '=([^,\\)]+)');
                                        const match = addressv2String.match(regex);
                                        return match ? match[1].trim() : defaultValue;
                                    }

                                    // Extract nested values
                                    const wardName = extractWardName(addressv2String);
                                    const districtName = extractDistrictName(addressv2String);
                                    const provinceName = extractProvinceName(addressv2String);

                                    // Lấy thông tin cá nhân từ form
                                    const defaultName = document.getElementById('fullName')?.value ||
                                        document.getElementById('recipient-name')?.textContent || '';
                                    const defaultPhone = document.getElementById('phone')?.value ||
                                        document.getElementById('recipient-phone')?.textContent || '';

                                    // Tạo đối tượng địa chỉ mới theo cấu trúc userAddresses
                                    const newAddress = {
                                        id: extractValue('addressId', '0'), // Extract addressId,
                                        name: defaultName.trim(),
                                        phone: defaultPhone.trim(),
                                        provinceId: extractValue('provinceId', '0'),
                                        provinceName: provinceName,
                                        districtId: extractValue('districtId', '0'),
                                        districtName: districtName,
                                        wardCode: extractValue('wardId', '0'),
                                        wardName: wardName,
                                        detailAddress: extractValue('street', ''),
                                        fullAddress: extractValue('street', '') +
                                            (wardName ? ', ' + wardName : '') +
                                            (districtName ? ', ' + districtName : '') +
                                            (provinceName ? ', ' + provinceName : ''),
                                        isDefault: true
                                    };

                                    addresses.push(newAddress);
                                    console.log('Parsed single address:', newAddress);
                                }

                                // Helper functions to extract nested values
                                function extractWardName(str) {
                                    const wardMatch = str.match(/ward=GHNWard\([^)]*wardName=([^,)]+)/);
                                    return wardMatch ? wardMatch[1].trim() : '';
                                }

                                function extractDistrictName(str) {
                                    const districtMatch = str.match(/district=GHNDistrict\([^)]*districtName=([^,)]+)/);
                                    return districtMatch ? districtMatch[1].trim() : '';
                                }

                                function extractProvinceName(str) {
                                    const provinceMatch = str.match(/province=GHNProvince\([^)]*provinceName=([^,)]+)/);
                                    return provinceMatch ? provinceMatch[1].trim() : '';
                                }

                                // Save all addresses to localStorage
                                saveAddressesToLocalStorage(addresses);

                                return addresses;
                            } catch (error) {
                                console.error('Error parsing Addressv2:', error);
                                return [];
                            }
                        }

                        // Save all addresses to localStorage
                        function saveAddressesToLocalStorage(addresses) {
                            try {
                                if (!addresses || addresses.length === 0) {
                                    console.log('No addresses to save');
                                    return;
                                }

                                // Get existing addresses
                                let savedAddresses = JSON.parse(localStorage.getItem('userAddresses')) || [];

                                // Filter out duplicates
                                const newAddresses = addresses.filter(newAddr => {
                                    return !savedAddresses.some(existingAddr =>
                                        existingAddr.detailAddress === newAddr.detailAddress &&
                                        existingAddr.wardCode === newAddr.wardCode &&
                                        existingAddr.districtId === newAddr.districtId &&
                                        existingAddr.provinceId === newAddr.provinceId
                                    );
                                });

                                if (newAddresses.length === 0) {
                                    console.log('All addresses already exist in localStorage');
                                    return;
                                }

                                // If we're adding the first address, set it as default
                                if (savedAddresses.length === 0 && newAddresses.length > 0) {
                                    newAddresses[0].isDefault = true;
                                } else if (newAddresses.some(addr => addr.isDefault)) {
                                    // If any new address is default, remove default from existing addresses
                                    savedAddresses.forEach(addr => {
                                        addr.isDefault = false;
                                    });
                                }

                                // Combine addresses
                                savedAddresses = [...savedAddresses, ...newAddresses];

                                // Save to localStorage
                                localStorage.setItem('userAddresses', JSON.stringify(savedAddresses));
                                console.log(`Saved ${newAddresses.length} new addresses to localStorage, total: ${savedAddresses.length}`);

                                // Update display if we have a default address
                                const defaultAddress = savedAddresses.find(addr => addr.isDefault);
                                if (defaultAddress) {
                                    updateAddressDisplay(defaultAddress);
                                }
                            } catch (error) {
                                console.error('Error saving addresses to localStorage:', error);
                            }
                        }

                        // Lưu địa chỉ vào localStorage (legacy function for backward compatibility)
                        function saveAddressToLocalStorage(address) {
                            try {
                                saveAddressesToLocalStorage([address]);
                            } catch (error) {
                                console.error('Error in legacy saveAddressToLocalStorage:', error);
                            }
                        }

                        // Cập nhật hiển thị địa chỉ
                        function updateAddressDisplay(address) {
                            const recipientName = document.getElementById('recipient-name');
                            const recipientPhone = document.getElementById('recipient-phone');
                            const recipientAddress = document.getElementById('recipient-address');

                            if (recipientName) recipientName.textContent = address.name;
                            if (recipientPhone) recipientPhone.textContent = address.phone;
                            if (recipientAddress) recipientAddress.textContent = address.fullAddress;

                            console.log('Updated address display with:', address);
                        }

                        // Tìm và xử lý dữ liệu Addressv2 từ input ẩn
                        function processAddressv2FromHiddenInputs() {
                            const hiddenInputs = document.querySelectorAll('input[type="hidden"]');
                            console.log('Processing', hiddenInputs.length, 'hidden inputs for Addressv2 data');

                            // Kiểm tra xem đã xử lý dữ liệu này chưa
                            if (localStorage.getItem('addressesProcessed') === 'true') {
                                console.log('Addresses already processed, skipping to prevent duplicates');
                                return;
                            }

                            let addressFound = false;
                            hiddenInputs.forEach((input, index) => {
                                const value = input.value || '';

                                if (value.includes('Addressv2') && value.includes('customerId')) {
                                    console.log(`Found Addressv2 data in hidden input #${index + 1}:`, input.id || 'unnamed');
                                    addressFound = true;

                                    // Phân tích dữ liệu Addressv2 - now returns array of addresses
                                    const addressDataArray = parseAddressv2(value);

                                    if (addressDataArray && addressDataArray.length > 0) {
                                        console.log(`Successfully processed ${addressDataArray.length} addresses from Addressv2 data`);
                                    }
                                }
                            });

                            // Đánh dấu là đã xử lý để tránh xử lý lại
                            if (addressFound) {
                                localStorage.setItem('addressesProcessed', 'true');
                                console.log('Marked addresses as processed to prevent duplicates');
                            }
                        }

                        // Thực thi xử lý địa chỉ - chỉ khi cần thiết
                        // Kiểm tra nếu chưa có địa chỉ nào trong localStorage thì mới xử lý
                        const existingAddresses = JSON.parse(localStorage.getItem('userAddresses')) || [];
                        if (existingAddresses.length === 0) {
                            console.log('No addresses in localStorage, processing hidden inputs...');
                            processAddressv2FromHiddenInputs();
                        } else {
                            console.log('Found existing addresses in localStorage, skipping processing');
                        }
                    });
                </script>

                <!-- Main initialization code -->
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        console.log("Document ready, initializing checkout page");

                        // Initialize shop to customer shipping
                        initializeShippingModule();

                        // Get customer ID
                        const customerId = document.getElementById('customerId').value;

                        // Function to clear stored address data (for troubleshooting)
                        window.clearStoredAddressData = function () {
                            console.log("Clearing stored address data from localStorage");
                            localStorage.removeItem('userAddresses');
                            localStorage.removeItem('addressesProcessed');
                            localStorage.removeItem('selectedAddress');

                            // Reset loading state
                            resetAddressLoadingState();

                            // Reload the page to start fresh
                            alert("Đã xóa dữ liệu địa chỉ lưu trữ. Trang sẽ được tải lại.");
                            window.location.reload();
                        };

                        // Add clear address data button to debug section if it exists
                        const debugSection = document.querySelector('.debug-section') || document.body;
                        const clearAddressButton = document.createElement('button');
                        clearAddressButton.textContent = 'Xóa dữ liệu địa chỉ';
                        clearAddressButton.className = 'px-4 py-2 bg-red-500 text-white rounded hover:bg-red-600 fixed bottom-4 right-4 z-50';
                        clearAddressButton.style.display = 'none'; // Hide by default
                        clearAddressButton.onclick = window.clearStoredAddressData;
                        debugSection.appendChild(clearAddressButton);

                        // Show button on Ctrl+Shift+A
                        document.addEventListener('keydown', function (e) {
                            if (e.ctrlKey && e.shiftKey && e.key === 'A') {
                                clearAddressButton.style.display = clearAddressButton.style.display === 'none' ? 'block' : 'none';
                            }
                        });

                        // Load customer addresses using the addressesv2 data
                        // This is now the single point where addresses are loaded on page load
                        loadCustomerAddressesFromModel();

                        // Attach event listeners
                        attachMainEventListeners();
                    });
                </script>

                <!-- Process and use Addressv2 data directly for shipping calculations -->
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        console.log('--- Addressv2 Data for Shipping ---');

                        // Function to process Addressv2 data for shipping
                        function useAddressv2DataForShipping(addressv2String) {
                            try {
                                console.log('Processing Addressv2 data for shipping calculation:', addressv2String);

                                // Check if we have multiple addresses
                                const isMultipleAddresses = addressv2String.startsWith('[') && addressv2String.endsWith(']');
                                let addressToUse = '';

                                if (isMultipleAddresses) {
                                    // Extract default address (first one for now, could be enhanced to find one marked as default)
                                    const addressesStrings = addressv2String.substring(1, addressv2String.length - 1)
                                        .split(/\)\s*,\s*Addressv2\(/);

                                    // Process first item which might have "Addressv2(" prefix
                                    let firstItem = addressesStrings[0];
                                    if (firstItem.startsWith("Addressv2(")) {
                                        firstItem = firstItem.substring("Addressv2(".length);
                                    }

                                    // Remove trailing ")" if present
                                    if (firstItem.endsWith(")")) {
                                        firstItem = firstItem.substring(0, firstItem.length - 1);
                                    }

                                    addressToUse = firstItem;
                                    console.log('Using first address from multiple addresses for shipping calculation');
                                } else {
                                    // Single address case
                                    addressToUse = addressv2String;
                                    if (addressToUse.startsWith("Addressv2(")) {
                                        addressToUse = addressToUse.substring("Addressv2(".length);
                                    }
                                    if (addressToUse.endsWith(")")) {
                                        addressToUse = addressToUse.substring(0, addressToUse.length - 1);
                                    }
                                }

                                // Extract key shipping values
                                function extractValue(pattern, defaultValue = '') {
                                    const regex = new RegExp(pattern + '=([^,\\)]+)');
                                    const match = addressToUse.match(regex);
                                    return match ? match[1].trim() : defaultValue;
                                }

                                // Get required values
                                const wardId = extractValue('wardId', '0');
                                const districtId = extractValue('districtId', '0');
                                const provinceId = extractValue('provinceId', '0');

                                // Set GHN state for shipping calculation
                                window.ghnState.selectedToProvince = parseInt(provinceId);
                                window.ghnState.selectedToDistrict = parseInt(districtId);
                                window.ghnState.selectedToWard = wardId;

                                console.log('Set GHN state from Addressv2 data:', {
                                    provinceId: window.ghnState.selectedToProvince,
                                    districtId: window.ghnState.selectedToDistrict,
                                    wardCode: window.ghnState.selectedToWard
                                });

                                // If we have the required data, calculate shipping fee
                                if (window.ghnState.selectedFromDistrict &&
                                    window.ghnState.selectedToDistrict &&
                                    window.ghnState.selectedToWard) {

                                    console.log('Attempting to calculate shipping with Addressv2 data...');
                                    // Try to fetch services and calculate
                                    fetchServices(window.ghnState.selectedFromDistrict, window.ghnState.selectedToDistrict);
                                    return true;
                                } else {
                                    console.log('Missing required data for shipping calculation:', {
                                        fromDistrict: window.ghnState.selectedFromDistrict,
                                        toDistrict: window.ghnState.selectedToDistrict,
                                        toWard: window.ghnState.selectedToWard
                                    });
                                    return false;
                                }
                            } catch (error) {
                                console.error('Error processing Addressv2 data for shipping:', error);
                                return false;
                            }
                        }

                        // Find and process Addressv2 data on page load
                        document.addEventListener('DOMContentLoaded', function () {
                            // Find Addressv2 data in hidden inputs
                            const hiddenInputs = document.querySelectorAll('input[type="hidden"]');
                            let addressv2Found = false;

                            hiddenInputs.forEach(input => {
                                const value = input.value || '';
                                if (value.includes('Addressv2') && value.includes('customerId') && !addressv2Found) {
                                    console.log('Found Addressv2 data in hidden input:', input.id || 'unnamed');
                                    addressv2Found = useAddressv2DataForShipping(value);
                                }
                            });

                            // If we didn't find or successfully process Addressv2 data, fall back to localStorage
                            if (!addressv2Found) {
                                console.log('No Addressv2 data found or processing failed, falling back to localStorage');
                                setTimeout(() => {
                                    const savedAddresses = JSON.parse(localStorage.getItem('userAddresses')) || [];
                                    const defaultAddress = savedAddresses.find(addr => addr.isDefault);

                                    if (defaultAddress) {
                                        console.log('Using default address from localStorage:', defaultAddress);
                                        window.ghnState.selectedToProvince = parseInt(defaultAddress.provinceId);
                                        window.ghnState.selectedToDistrict = parseInt(defaultAddress.districtId);
                                        window.ghnState.selectedToWard = defaultAddress.wardCode;

                                        if (window.ghnState.selectedFromDistrict) {
                                            fetchServices(window.ghnState.selectedFromDistrict, window.ghnState.selectedToDistrict);
                                        }
                                    }
                                }, 1500);
                            }
                        }, { once: true });
                    });
                </script>


                <!-- Additional script for address selection and shipping calculation -->
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        console.log('--- Address Selection for Shipping ---');

                        // Get elements
                        const addressModal = document.getElementById('address-modal');
                        const confirmAddressBtn = document.getElementById('confirm-address');

                        // Event listener for address selection in modal
                        addressModal.addEventListener('click', function (e) {
                            // Check if user clicked on an address element or set-default button
                            const addressElement = e.target.closest('[data-address-id]');

                            if (addressElement) {
                                // Remove highlight from all addresses
                                document.querySelectorAll('#address-modal [data-address-id]').forEach(el => {
                                    el.classList.remove('border-orange-500', 'bg-orange-50');
                                    el.classList.add('border-gray-200');
                                });

                                // Highlight clicked address
                                addressElement.classList.remove('border-gray-200');
                                addressElement.classList.add('border-orange-500', 'bg-orange-50');

                                console.log('Selected address ID:', addressElement.getAttribute('data-address-id'));
                            }
                        });

                        // Enhanced function to update shipping when address is confirmed
                        if (confirmAddressBtn) {
                            confirmAddressBtn.addEventListener('click', function () {
                                const selectedAddressElement = document.querySelector('#address-modal .border-orange-500');
                                if (!selectedAddressElement) {
                                    console.log('No address selected in modal');
                                    return;
                                }

                                const addressId = selectedAddressElement.getAttribute('data-address-id');
                                console.log('Confirmed address selection, ID:', addressId);

                                // Get address details
                                const savedAddresses = JSON.parse(localStorage.getItem('userAddresses')) || [];
                                const selectedAddress = savedAddresses.find(addr => addr.id === addressId);

                                if (selectedAddress) {
                                    console.log('Selected address for shipping calculation:', selectedAddress);

                                    // Update shipping calculation state
                                    if (window.ghnState) {
                                        // Convert ID values to integers
                                        window.ghnState.selectedToProvince = parseInt(selectedAddress.provinceId);
                                        window.ghnState.selectedToDistrict = parseInt(selectedAddress.districtId);
                                        window.ghnState.selectedToWard = selectedAddress.wardCode;

                                        console.log('Updated GHN shipping state:', {
                                            toProvince: window.ghnState.selectedToProvince,
                                            toDistrict: window.ghnState.selectedToDistrict,
                                            toWard: window.ghnState.selectedToWard
                                        });

                                        // Calculate shipping if shop address is available
                                        if (window.ghnState.selectedFromDistrict) {
                                            console.log('Calculating shipping for new address...');
                                            fetchServices(window.ghnState.selectedFromDistrict, window.ghnState.selectedToDistrict);
                                        }
                                    } else {
                                        console.warn('GHN state is not initialized');
                                    }
                                }
                            });
                        }

                        // Find and store Addressv2 data from model
                        const hiddenInputs = document.querySelectorAll('input[type="hidden"]');
                        hiddenInputs.forEach(input => {
                            const value = input.value || '';
                            if (value.includes('Addressv2') && value.includes('customerId')) {
                                // Store the data in a dedicated hidden input for easier access
                                document.getElementById('current-addressv2-data').value = value;
                                console.log('Stored Addressv2 data in hidden input for later use');
                            }
                        });
                    });
                </script>




                <script>
                    // Order data handler function
                    document.addEventListener('DOMContentLoaded', function () {
                        // State to track selected values
                        const orderState = {
                            customer: {
                                customerId: '',
                                fullName: '',
                                email: '',
                                phone: ''
                            },
                            shippingAddress: {
                                id: '',
                                name: '',
                                phone: '',
                                provinceId: '',
                                provinceName: '',
                                districtId: '',
                                districtName: '',
                                wardCode: '',
                                wardName: '',
                                detailAddress: '',
                                fullAddress: ''
                            },
                            paymentMethod: '',
                            shipping: {
                                fee: 0,
                                serviceId: '',
                                serviceName: '',
                                estimatedDeliveryTime: ''
                            },
                            orderNote: '123'
                        };

                        // Cache DOM elements for better performance
                        const elements = {
                            // Customer information elements
                            customerId: document.getElementById('customerId'),
                            fullName: document.getElementById('fullName'),
                            email: document.getElementById('email'),
                            phone: document.getElementById('phone'),

                            // Address elements
                            recipientName: document.getElementById('recipient-name'),
                            recipientPhone: document.getElementById('recipient-phone'),
                            recipientAddress: document.getElementById('recipient-address'),

                            // Payment method elements
                            paymentMethods: document.querySelectorAll('.payment-method'),

                            // Submit button - Will need to be added to HTML if not present
                            submitOrderBtn: document.getElementById('submit-order-btn'),

                            // Test button
                            testOrderDataBtn: document.getElementById('test-order-data')
                        };

                        // Initialize data from existing elements
                        function initializeOrderData() {
                            // Customer information
                            if (elements.customerId) orderState.customer.customerId = elements.customerId.value;
                            if (elements.fullName) orderState.customer.fullName = elements.fullName.value;
                            if (elements.email) orderState.customer.email = elements.email.value;
                            if (elements.phone) orderState.customer.phone = elements.phone.value;

                            // Get shipping address from displayed address or localStorage
                            const selectedAddress = JSON.parse(localStorage.getItem('selectedAddress') || '{}');
                            if (selectedAddress && Object.keys(selectedAddress).length > 0) {
                                orderState.shippingAddress = selectedAddress;
                            } else {
                                // Fallback to displayed address
                                if (elements.recipientName && elements.recipientPhone && elements.recipientAddress) {
                                    orderState.shippingAddress.name = elements.recipientName.textContent.trim();
                                    orderState.shippingAddress.phone = elements.recipientPhone.textContent.trim();
                                    orderState.shippingAddress.fullAddress = elements.recipientAddress.textContent.trim();
                                }
                            }

                            // Shipping fee from GHN if available
                            if (window.ghnState && window.ghnState.selectedService) {
                                orderState.shipping.serviceId = window.ghnState.selectedService.service_id;
                                orderState.shipping.serviceName = window.ghnState.selectedService.short_name;
                                // Prioritize shippingFeeValue over totalShippingFee
                                orderState.shipping.fee = window.ghnState.shippingFeeValue || window.ghnState.totalShippingFee || 0;
                                console.log("🚚 Initial shipping fee value:", orderState.shipping.fee,
                                    "from ghnState.shippingFeeValue:", window.ghnState.shippingFeeValue);
                                orderState.shipping.estimatedDeliveryTime = window.ghnState.expectedDeliveryTime || '';
                            }

                            // Log initial state
                            console.log('Order initial state:', JSON.parse(JSON.stringify(orderState)));
                        }

                        // Validate order data before submission
                        function validateOrderData() {
                            const errors = [];

                            // Validate customer information
                            if (!orderState.customer.fullName) errors.push('Customer name is required');
                            if (!orderState.customer.email) errors.push('Customer email is required');
                            if (!orderState.customer.phone) errors.push('Customer phone is required');

                            // Validate shipping address
                            if (!orderState.shippingAddress.name) errors.push('Recipient name is required');
                            if (!orderState.shippingAddress.phone) errors.push('Recipient phone is required');
                            if (!orderState.shippingAddress.fullAddress) errors.push('Shipping address is required');

                            // For GHN integration, validate specific address components
                            if (window.ghnState) {
                                if (!orderState.shippingAddress.provinceId) errors.push('Province selection is required');
                                if (!orderState.shippingAddress.districtId) errors.push('District selection is required');
                                if (!orderState.shippingAddress.wardCode) errors.push('Ward selection is required');
                            }

                            // Validate payment method
                            if (!orderState.paymentMethod) errors.push('Payment method is required');

                            return {
                                isValid: errors.length === 0,
                                errors: errors
                            };
                        }

                        // Update order data from form inputs
                        function updateOrderData() {
                            // Update customer information
                            if (elements.customerId) orderState.customer.customerId = elements.customerId.value;
                            if (elements.fullName) orderState.customer.fullName = elements.fullName.value;
                            if (elements.email) orderState.customer.email = elements.email.value;
                            if (elements.phone) orderState.customer.phone = elements.phone.value;

                            // Get latest shipping address from localStorage
                            const selectedAddress = JSON.parse(localStorage.getItem('selectedAddress') || '{}');
                            if (selectedAddress && Object.keys(selectedAddress).length > 0) {
                                orderState.shippingAddress = selectedAddress;

                                // Log selected address for debugging
                                console.log("📍 Selected Address from localStorage:", selectedAddress);
                            }

                            // Try to get data from GHN state if available (in case selected address doesn't have all required fields)
                            if (window.ghnState) {
                                // Ensure shippingAddress has complete GHN data
                                if (window.ghnState.selectedToProvince) {
                                    orderState.shippingAddress.provinceId = window.ghnState.selectedToProvince.toString();
                                }

                                if (window.ghnState.selectedToDistrict) {
                                    orderState.shippingAddress.districtId = window.ghnState.selectedToDistrict.toString();
                                }

                                if (window.ghnState.selectedToWard) {
                                    orderState.shippingAddress.wardCode = window.ghnState.selectedToWard.toString();
                                }

                                // Get district and ward names from GHN data if available
                                if (window.ghnState.toDistrictName) {
                                    orderState.shippingAddress.districtName = window.ghnState.toDistrictName;
                                }

                                if (window.ghnState.toWardName) {
                                    orderState.shippingAddress.wardName = window.ghnState.toWardName;
                                }

                                if (window.ghnState.toProvinceName) {
                                    orderState.shippingAddress.provinceName = window.ghnState.toProvinceName;
                                }
                            }

                            // Get shipping fee data from GHN if available
                            if (window.ghnState) {
                                // Update with the latest shipping calculation
                                if (window.ghnState.selectedService) {
                                    orderState.shipping.serviceId = window.ghnState.selectedService.service_id;
                                    orderState.shipping.serviceName = window.ghnState.selectedService.short_name;
                                    // Prioritize shippingFeeValue over totalShippingFee
                                    orderState.shipping.fee = window.ghnState.shippingFeeValue || window.ghnState.totalShippingFee || 0;
                                    console.log("🚚 Using shipping fee value:", orderState.shipping.fee,
                                        "from ghnState.shippingFeeValue:", window.ghnState.shippingFeeValue);
                                    orderState.shipping.estimatedDeliveryTime = window.ghnState.expectedDeliveryTime || '';
                                }
                            }

                            // Log updated state
                            console.log('Updated order dataaaaaaaaaaaaaaaaaaaaaaaaaa:', JSON.parse(JSON.stringify(orderState)));
                        }

                        // Prepare order data for backend submission
                        // Function to collect order items and calculate order values
                        function calculateOrderValues() {
                            // Collect order items
                            const orderItems = [];
                            document.querySelectorAll('.space-y-4.mb-6 > div.flex').forEach(item => {
                                // Get product name to help with debugging
                                const productName = item.querySelector('h3')?.textContent.trim();

                                // Get image element and extract product_variant_id
                                const imgElement = item.querySelector('img');
                                const productVariantId = imgElement ? parseInt(imgElement.getAttribute('data-variant-id') || 0) : 0;

                                // Get quantity from the text
                                const quantityText = item.querySelector('div.text-right > p.text-xs')?.textContent.trim();
                                const quantity = parseInt(quantityText?.replace('Qty: ', '') || '1') || 1;

                                // Get price from the text
                                const priceText = item.querySelector('div.text-right > p.text-sm')?.textContent.trim();
                                const price = parseFloat(priceText?.replace('$', '') || '0') || 0;

                                // Only add items with valid product_variant_id
                                if (productVariantId > 0) {
                                    // Create base order item
                                    const orderItem = {
                                        product_variant_id: productVariantId,
                                        quantity: quantity,
                                        price: price,
                                        applied_discounts: [] // Initialize empty array for discounts
                                    };

                                    // Check for applicable discounts
                                    if (window.appliedDiscounts && window.appliedDiscounts.length > 0) {
                                        // Find all discounts that apply to this product variant
                                        const matchingDiscounts = window.appliedDiscounts.filter(
                                            discount => discount.productVariantId &&
                                                (discount.productVariantId == productVariantId ||
                                                    String(discount.productVariantId) === String(productVariantId))
                                        );

                                        // Add matching discounts to this order item
                                        if (matchingDiscounts.length > 0) {
                                            // Ensure we only take the first discount (most recently applied)
                                            // to enforce one discount per product constraint
                                            const singleDiscount = matchingDiscounts[0];
                                            orderItem.applied_discounts = [{
                                                code: singleDiscount.code,
                                                id: singleDiscount.id,
                                                percentage: singleDiscount.percentage,
                                                product_variant_id: singleDiscount.productVariantId,
                                                product_name: singleDiscount.productName || productName,
                                                min_order_value: singleDiscount.min_order_value,
                                                max_discount_amount: singleDiscount.max_discount_amount
                                            }];
                                            console.log(`Applied discount: ${singleDiscount.code} to product: ${productName}`);
                                        }
                                    }

                                    orderItems.push(orderItem);
                                    console.log(`Added product: ${productName}, variant ID: ${productVariantId}, quantity: ${quantity}, price: ${price}`);
                                }
                            });

                            // Calculate order values
                            const subtotal = orderState.orderTotal || 0;
                            const discountAmount = orderState.discount || 0;
                            const shippingFee = orderState.shipping.fee || 0;
                            const taxAmount = 0;
                            const totalAfterDiscount = subtotal - discountAmount;
                            const finalTotal = totalAfterDiscount + shippingFee + taxAmount;

                            // For backwards compatibility, still include the overall appliedDiscounts array
                            // but the individual discounts are now also attached to their specific order items
                            return {
                                orderItems: orderItems,
                                orderCalculation: {
                                    subtotal: subtotal,
                                    totalDiscountAmount: discountAmount,
                                    shippingFee: shippingFee,
                                    taxAmount: taxAmount,
                                    totalAfterDiscount: totalAfterDiscount,
                                    finalTotal: finalTotal,
                                    //appliedDiscounts: window.appliedDiscounts || []
                                }
                            };
                        }

                        function prepareOrderDataForSubmission() {
                            // Debug GHN shipping fee values
                            if (window.ghnState) {
                                console.log("🧮 GHN State Values before preparing data:");
                                console.log("   shippingFeeValue:", window.ghnState.shippingFeeValue);
                                console.log("   totalShippingFee:", window.ghnState.totalShippingFee);
                                console.log("   orderState.shipping.fee:", orderState.shipping.fee);
                            }

                            // Ensure shipping fee is up to date before creating orderData
                            if (window.ghnState && window.ghnState.shippingFeeValue) {
                                orderState.shipping.fee = window.ghnState.shippingFeeValue;
                            }

                            // Make sure we have applied discounts data
                            console.log("👍 Applied discounts before preparing data:", window.appliedDiscounts);
                            if (!window.appliedDiscounts) {
                                window.appliedDiscounts = [];
                            }

                            // Calculate order values and get order items
                            const calculatedValues = calculateOrderValues();

                            // Use actual data from orderState and calculated values
                            const orderData = {
                                customerId: orderState.customer.customerId,
                                customerInfo: {
                                    fullName: orderState.customer.fullName,
                                    email: orderState.customer.email,
                                    phone: orderState.customer.phone
                                },
                                shippingAddress: {
                                    id: orderState.shippingAddress.id || "",
                                    recipientName: orderState.shippingAddress.name || orderState.customer.fullName || "",
                                    recipientPhone: orderState.shippingAddress.phone || orderState.customer.phone || "",
                                    provinceId: orderState.shippingAddress.provinceId || "",
                                    districtId: orderState.shippingAddress.districtId || "",
                                    districtName: orderState.shippingAddress.districtName || "",
                                    wardCode: orderState.shippingAddress.wardCode || "",
                                    wardName: orderState.shippingAddress.wardName || "",
                                    fullAddress: orderState.shippingAddress.fullAddress || ""
                                },
                                payment: {
                                    method: orderState.paymentMethod || "Thanh toán khi nhận hàng"
                                },
                                shipping: {
                                    fee: orderState.shipping.fee || 0,
                                    serviceId: orderState.shipping.serviceId || 0,
                                    estimatedDeliveryTime: orderState.shipping.estimatedDeliveryTime || ""
                                },
                                note: orderState.note || "123",
                                taxInfo: {
                                    includeVat: includeVat,
                                    vatRate: 0.08,
                                    vatAmount: calculatedValues.orderCalculation.taxAmount
                                },
                                orderItems: calculatedValues.orderItems,
                                orderCalculation: calculatedValues.orderCalculation
                            };

                            console.log("🔄 Mapped data from orderState:", JSON.parse(JSON.stringify(orderState)));

                            return orderData;
                        }

                        // Set up payment method selection
                        function setupPaymentMethodSelection() {
                            if (elements.paymentMethods && elements.paymentMethods.length > 0) {
                                elements.paymentMethods.forEach((method, index) => {
                                    const radioIndicator = method.querySelector('.w-4.h-4');

                                    // Add click handler to each payment method
                                    method.addEventListener('click', function () {
                                        // Deselect all payment methods
                                        elements.paymentMethods.forEach(m => {
                                            const indicator = m.querySelector('.w-4.h-4');
                                            if (indicator) indicator.classList.remove('bg-orange-500');
                                            if (indicator) indicator.classList.add('bg-transparent');
                                        });

                                        // Select this payment method
                                        if (radioIndicator) {
                                            radioIndicator.classList.remove('bg-transparent');
                                            radioIndicator.classList.add('bg-orange-500');
                                        }

                                        // Update payment method in state
                                        const methodText = method.querySelector('span').textContent.trim();
                                        orderState.paymentMethod = methodText;

                                        console.log('Selected payment method:', methodText);
                                    });

                                    // Set the first payment method as default
                                    if (index === 0 && radioIndicator) {
                                        radioIndicator.classList.remove('bg-transparent');
                                        radioIndicator.classList.add('bg-orange-500');
                                        orderState.paymentMethod = method.querySelector('span').textContent.trim();
                                    }
                                });
                            }
                        }

                        // Handle form submission via API
                        function handleOrderSubmission() {
                            // Make sure we have the latest data
                            updateOrderData();

                            // Skip validation and use sample data directly
                            // Prepare data for submission
                            const orderData = prepareOrderDataForSubmission();

                            // Log the final data that would be sent to the server
                            console.log('Submitting order data:', orderData);

                            // Detailed logging of all values
                            console.group("🚀 ORDER DATA DETAIL");
                            console.log("📋 Customer ID:", orderData.customerId);

                            // Check if applied discounts is properly set
                            console.log("🎟️ Applied Discounts:", orderData.orderCalculation.appliedDiscounts);

                            // Customer Info
                            console.group("👤 Customer Info");
                            console.log("Full Name:", orderData.customerInfo.fullName);
                            console.log("Email:", orderData.customerInfo.email);
                            console.log("Phone:", orderData.customerInfo.phone);
                            console.groupEnd();

                            // Shipping Address
                            console.group("📦 Shipping Address");
                            console.log("Recipient Name:", orderData.shippingAddress.recipientName);
                            console.log("Recipient Phone:", orderData.shippingAddress.recipientPhone);
                            console.log("Province ID:", orderData.shippingAddress.provinceId);
                            console.log("District ID:", orderData.shippingAddress.districtId);
                            console.log("District Name:", orderData.shippingAddress.districtName);
                            console.log("Ward Code:", orderData.shippingAddress.wardCode);
                            console.log("Ward Name:", orderData.shippingAddress.wardName);
                            console.groupEnd();

                            // Payment
                            console.group("💳 Payment");
                            console.log("Method:", orderData.payment.method);
                            console.groupEnd();

                            // Shipping
                            console.group("🚚 Shipping");
                            console.log("Fee:", orderData.shipping.fee);
                            console.log("Service ID:", orderData.shipping.serviceId);

                            // Order Calculation - Applied Discounts Detail
                            console.group("🎟️ Applied Discounts Details");
                            if (orderData.orderCalculation.appliedDiscounts && orderData.orderCalculation.appliedDiscounts.length > 0) {
                                orderData.orderCalculation.appliedDiscounts.forEach((discount, index) => {
                                    console.log(`Discount #${index + 1}:`, discount);
                                });
                            } else {
                                console.log("No applied discounts");
                            }
                            console.groupEnd();
                            console.log("Estimated Delivery:", orderData.shipping.estimatedDeliveryTime);
                            console.groupEnd();

                            // Tax Info
                            console.group("💰 Tax Info");
                            console.log("Include VAT:", orderData.taxInfo.includeVat);
                            console.log("VAT Rate:", orderData.taxInfo.vatRate);
                            console.log("VAT Amount:", orderData.taxInfo.vatAmount);
                            console.groupEnd();

                            // Order Calculation
                            console.group("🧮 Order Calculation");
                            console.log("Subtotal:", orderData.orderCalculation.subtotal);
                            console.log("Discount:", orderData.orderCalculation.totalDiscountAmount);
                            console.log("Shipping Fee:", orderData.orderCalculation.shippingFee);
                            console.log("Tax Amount:", orderData.orderCalculation.taxAmount);
                            console.log("Total After Discount:", orderData.orderCalculation.totalAfterDiscount);
                            console.log("Final Total:", orderData.orderCalculation.finalTotal);
                            console.groupEnd();

                            console.groupEnd();

                            // Hiển thị thông báo đang gửi dữ liệu
                            const notifyDiv = document.createElement('div');
                            notifyDiv.style.position = 'fixed';
                            notifyDiv.style.top = '50%';
                            notifyDiv.style.left = '50%';
                            notifyDiv.style.transform = 'translate(-50%, -50%)';
                            notifyDiv.style.backgroundColor = 'rgba(0, 0, 0, 0.8)';
                            notifyDiv.style.color = 'white';
                            notifyDiv.style.padding = '20px 30px';
                            notifyDiv.style.borderRadius = '10px';
                            notifyDiv.style.zIndex = '9999';
                            notifyDiv.style.textAlign = 'center';
                            notifyDiv.innerHTML = '<div>Đang gửi dữ liệu đơn hàng qua API...</div><div style="margin-top:10px;">Vui lòng đợi</div>';
                            document.body.appendChild(notifyDiv);

                            // Get CSRF token from meta tag (if available)
                            const csrfToken = document.querySelector('meta[name="_csrf"]')?.getAttribute('content');
                            const csrfHeader = document.querySelector('meta[name="_csrf_header"]')?.getAttribute('content');

                            // Prepare headers
                            const headers = {
                                'Content-Type': 'application/json'
                            };

                            // Add CSRF header if available
                            if (csrfToken && csrfHeader) {
                                headers[csrfHeader] = csrfToken;
                            }

                            // Log the actual request data being sent
                            console.log('🌐 API Request URL:', '${pageContext.request.contextPath}/api/orders/submit');
                            console.log('🌐 Request Headers:', headers);
                            console.log('🌐 Request Body (as string):', JSON.stringify(orderData, null, 2));

                            // in here viết API 
                            // Send order data to server

                            // Send order data to server
                            fetch('/api/orders/submit', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/json',
                                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]')?.getAttribute('content')
                                },
                                body: JSON.stringify(orderData)
                            })
                                .then(response => {
                                    if (!response.ok) {
                                        throw new Error('Network response was not ok: ' + response.status);
                                    }
                                    return response.json();
                                })
                                .then(data => {
                                    console.log('✅ Order submitted successfully:', data);

                                    if (data.success) {
                                        // Show success message
                                        showToast('Đơn hàng đã được gửi thành công!', 'success');

                                        // Redirect to order confirmation page
                                        setTimeout(() => {
                                            window.location.href = '/order/confirmation?id=' + data.orderId;
                                        }, 1500);
                                    } else {
                                        // Show error if the server response indicates failure
                                        showToast('Có lỗi xảy ra: ' + (data.error || 'Không thể xử lý đơn hàng'), 'error');
                                        orderButton.disabled = false;
                                        orderButton.innerHTML = originalButtonText;
                                    }
                                })
                                .catch(error => {
                                    console.error('❌ Error submitting order:', error);
                                    showToast('Lỗi khi gửi đơn hàng: ' + error.message, 'error');
                                    orderButton.disabled = false;
                                    orderButton.innerHTML = originalButtonText;
                                });


                        }

                        // Populate the hidden form with order data
                        function populateOrderForm(orderData) {
                            console.log("Đang điền dữ liệu vào form ẩn:", orderData);

                            try {
                                // Customer ID
                                document.getElementById('customerId').value = orderData.customerId || "";

                                // Customer Info
                                if (orderData.customerInfo) {
                                    document.getElementById('customerInfoFullName').value = orderData.customerInfo.fullName || "";
                                    document.getElementById('customerInfoEmail').value = orderData.customerInfo.email || "";
                                    document.getElementById('customerInfoPhone').value = orderData.customerInfo.phone || "";
                                }

                                // Shipping Address
                                if (orderData.shippingAddress) {
                                    document.getElementById('shippingAddressRecipientName').value = orderData.shippingAddress.recipientName || "";
                                    document.getElementById('shippingAddressRecipientPhone').value = orderData.shippingAddress.recipientPhone || "";
                                    document.getElementById('shippingAddressProvinceId').value = orderData.shippingAddress.provinceId || "";
                                    document.getElementById('shippingAddressDistrictId').value = orderData.shippingAddress.districtId || "";
                                    document.getElementById('shippingAddressDistrictName').value = orderData.shippingAddress.districtName || "";
                                    document.getElementById('shippingAddressWardCode').value = orderData.shippingAddress.wardCode || "";
                                    document.getElementById('shippingAddressWardName').value = orderData.shippingAddress.wardName || "";
                                }

                                // Payment
                                if (orderData.payment) {
                                    document.getElementById('paymentMethod').value = orderData.payment.method || "";
                                }

                                // Shipping
                                if (orderData.shipping) {
                                    document.getElementById('shippingFee').value = orderData.shipping.fee || 0;
                                    document.getElementById('shippingServiceId').value = orderData.shipping.serviceId || 0;
                                    document.getElementById('shippingEstimatedDeliveryTime').value = orderData.shipping.estimatedDeliveryTime || "";
                                }

                                // Note
                                document.getElementById('orderNote').value = orderData.note || "123";

                                // Tax Info
                                if (orderData.taxInfo) {
                                    document.getElementById('taxInfoIncludeVat').value = orderData.taxInfo.includeVat;
                                    document.getElementById('taxInfoVatRate').value = orderData.taxInfo.vatRate || 0;
                                    document.getElementById('taxInfoVatAmount').value = orderData.taxInfo.vatAmount || 0;
                                }

                                // Order Calculation
                                if (orderData.orderCalculation) {
                                    document.getElementById('orderCalculationSubtotal').value = orderData.orderCalculation.subtotal || 0;
                                    document.getElementById('orderCalculationTotalDiscountAmount').value = orderData.orderCalculation.totalDiscountAmount || 0;
                                    document.getElementById('orderCalculationShippingFee').value = orderData.orderCalculation.shippingFee || 0;
                                    document.getElementById('orderCalculationTaxAmount').value = orderData.orderCalculation.taxAmount || 0;
                                    document.getElementById('orderCalculationTotalAfterDiscount').value = orderData.orderCalculation.totalAfterDiscount || 0;
                                    document.getElementById('orderCalculationFinalTotal').value = orderData.orderCalculation.finalTotal || 0;
                                }

                                console.log("Đã điền xong dữ liệu vào form, chuẩn bị gửi");
                            } catch (error) {
                                console.error("Lỗi khi điền dữ liệu vào form:", error);
                                alert("Lỗi khi điền dữ liệu: " + error.message);
                            }
                        }

                        // Test order data function
                        function testOrderData() {
                            // First make sure we have the latest data
                            updateOrderData();

                            // Prepare the formatted data that would be sent to backend
                            const orderData = prepareOrderDataForSubmission();

                            // Log detailed info to console
                            console.group("📋 ORDER DATA TEST");
                            console.log("📝 Raw order state:", JSON.parse(JSON.stringify(orderState)));
                            console.log("🧾 Formatted for backend:", orderData);
                            console.log("📦 Shipping Address Details:", JSON.parse(JSON.stringify(orderData.shippingAddress)));

                            // Log validation results
                            const validation = validateOrderData();
                            console.log("✅ Validation passed:", validation.isValid);
                            if (!validation.isValid) {
                                console.warn("⚠️ Validation errors:", validation.errors);
                            }

                            // Log GHN shipping data if available
                            if (window.ghnState) {
                                console.log("🚚 GHN Shipping state:", window.ghnState);
                            }

                            // Log address data
                            console.log("📍 Addresses in localStorage:", JSON.parse(localStorage.getItem('userAddresses') || '[]'));
                            console.log("📌 Selected address:", JSON.parse(localStorage.getItem('selectedAddress') || '{}'));
                            console.groupEnd();

                            <!--  -->
                        }

                        // Initialize everything
                        function init() {
                            // Initialize order data
                            initializeOrderData();

                            // Set up payment method selection
                            setupPaymentMethodSelection();

                            // Set up listeners for customer info fields
                            if (elements.fullName) {
                                elements.fullName.addEventListener('change', function () {
                                    orderState.customer.fullName = this.value;
                                    console.log('Updated customer fullName:', this.value);
                                });
                            }

                            if (elements.email) {
                                elements.email.addEventListener('change', function () {
                                    orderState.customer.email = this.value;
                                    console.log('Updated customer email:', this.value);
                                });
                            }

                            if (elements.phone) {
                                elements.phone.addEventListener('change', function () {
                                    orderState.customer.phone = this.value;
                                    console.log('Updated customer phone:', this.value);
                                });
                            }

                            // Set up order submission
                            if (elements.submitOrderBtn) {
                                elements.submitOrderBtn.addEventListener('click', function (e) {
                                    e.preventDefault();
                                    handleOrderSubmission();
                                });
                            }

                            // Set up test button
                            if (elements.testOrderDataBtn) {
                                elements.testOrderDataBtn.addEventListener('click', function (e) {
                                    e.preventDefault();
                                    testOrderData();
                                });
                            }

                            // Listen for changes to the shipping address
                            window.addEventListener('addressChanged', function (e) {
                                updateOrderData();
                            });

                            // Listen for shipping calculation updates
                            if (typeof window.ghnState !== 'undefined') {
                                const originalCalculateShippingFee = window.calculateShippingFee;
                                if (typeof originalCalculateShippingFee === 'function') {
                                    window.calculateShippingFee = async function () {
                                        const result = await originalCalculateShippingFee.apply(this, arguments);
                                        updateOrderData();
                                        return result;
                                    };
                                }
                            }
                        }

                        // Run initialization
                        init();

                        // Expose these functions to the global scope for debugging or external use
                        window.orderHandler = {
                            getOrderState: function () {
                                return JSON.parse(JSON.stringify(orderState));
                            },
                            updateOrderData: updateOrderData,
                            prepareOrderData: prepareOrderDataForSubmission,
                            submitOrder: handleOrderSubmission,
                            testOrder: testOrderData
                        };
                    });
                </script>



                <script>
                    // Thêm sự kiện cho nút gửi đơn hàng
                    document.getElementById('submitDataButton').addEventListener('click', function () {
                        console.log("Đang chuẩn bị gửi dữ liệu đơn hàng...");

                        // Sử dụng hàm gửi đơn hàng đã định nghĩa
                        if (window.orderHandler && typeof window.orderHandler.submitOrder === 'function') {
                            console.log("Gọi hàm submitOrder()");
                            window.orderHandler.submitOrder();
                        } else {
                            // Nếu không tìm thấy hàm, thử gọi trực tiếp
                            console.log("Không tìm thấy orderHandler.submitOrder, thử gọi handleOrderSubmission()");
                            if (typeof handleOrderSubmission === 'function') {
                                handleOrderSubmission();
                            } else {
                                alert("Không thể tìm thấy hàm xử lý gửi đơn hàng!");
                            }
                        }
                    });
                </script>



                <script>
                    // Utility function to format currency
                    function formatCurrency(amount) {
                        return '$' + parseFloat(amount).toFixed(2);
                    }

                    // Utility function to format VND
                    function formatVND(amount) {
                        if (amount === null || amount === undefined) return '0';
                        // Format with commas and add VND suffix
                        return amount.toLocaleString('vi-VN') + ' VND';
                    }

                    // Track if VAT is included (default: yes)
                    let includeVat = true;

                    // Log page load for debugging
                    console.log("Order page loaded, URL:", window.location.href);

                    // Check if shipping-fee-result exists on page load
                    document.addEventListener('DOMContentLoaded', function () {
                        console.log("DOM fully loaded");
                        const shippingFeeResultElement = document.getElementById('shipping-fee-result');
                        console.log("shipping-fee-result element exists:", shippingFeeResultElement ? true : false);
                        if (shippingFeeResultElement) {
                            console.log("shipping-fee-result element ID:", shippingFeeResultElement.id);
                            console.log("shipping-fee-result element class:", shippingFeeResultElement.className);
                        }
                    });

                    // Calculate cart totals properly
                    function calculateCartTotals() {







                        // Get all cart items
                        const cartItems = document.querySelectorAll('.space-y-4.mb-6 > div.flex');
                        let subtotal = 0;
                        console.log('-----------------------------------', subtotal)

                        // Calculate subtotal from each item price * quantity
                        cartItems.forEach(item => {
                            const priceText = item.querySelector('div.text-right > p.text-sm').textContent.trim();
                            const quantityText = item.querySelector('div.text-right > p.text-xs').textContent.trim();

                            // Extract price and quantity values
                            const price = parseFloat(priceText.replace('$', ''));
                            const quantity = parseInt(quantityText.replace('Qty: ', ''));

                            if (!isNaN(price) && !isNaN(quantity)) {
                                subtotal += price * quantity;
                            }
                        });


                        // Calculate tax (8%) only if VAT is included
                        const tax = subtotal * 0.08;

                        // Get shipping cost from GHN state (if available)
                        // Note: Using 'window.ghnState' assumes state is attached to window or accessible globally.
                        // Adjust if state is scoped differently. We'll define ghnState later.
                        const shippingCost = window.ghnState && window.ghnState.shippingFeeValue !== null
                            ? window.ghnState.shippingFeeValue
                            : null;

                        // Calculate total (currently ignoring shipping fee due to currency difference)
                        const total = subtotal + shippingCost;

                        // Update display values
                        const subtotalElement = document.querySelector('.space-y-3.mb-6 > div:nth-child(1) > span:last-child');
                        const shippingElement = document.getElementById('shipping-cost-summary'); // Get shipping span by ID
                        const taxElement = document.getElementById('tax-amount2');
                        const totalElement = document.getElementById('total-with-discount');

                        if (subtotalElement) subtotalElement.textContent = formatCurrency(subtotal);
                        if (shippingElement) {
                            // Display formatted shipping fee or 'Calculating...'
                            shippingElement.textContent = shippingCost !== null ? formatVND(shippingCost) : 'Calculating...';
                        }
                        console.log('shippingCost------------', shippingCost)


                        if (taxElement) taxElement.textContent = tax;
                        if (totalElement) totalElement.textContent = formatCurrency(total); // Display total based on subtotal + tax only

                        // Return calculated values (including shipping cost if needed elsewhere)
                        return { subtotal, tax, shippingCost, total };
                    }

                    // Initialize tax option buttons
                    function initTaxButtons() {
                        const noVatBtn = document.getElementById('noVatBtn');
                        const vatBtn = document.getElementById('vatBtn');

                        noVatBtn.addEventListener('click', function (e) {
                            e.preventDefault();
                            includeVat = false;

                            // Update button styles
                            noVatBtn.classList.add('bg-black', 'text-white');
                            noVatBtn.classList.remove('bg-transparent', 'text-black');

                            vatBtn.classList.remove('bg-black', 'text-white');
                            vatBtn.classList.add('bg-transparent', 'text-black');

                            // Recalculate totals
                            calculateCartTotals();
                        });

                        vatBtn.addEventListener('click', function (e) {
                            e.preventDefault();
                            includeVat = false;

                            // Update button styles
                            vatBtn.classList.add('bg-black', 'text-white');
                            vatBtn.classList.remove('bg-transparent', 'text-black');

                            noVatBtn.classList.remove('bg-black', 'text-white');
                            noVatBtn.classList.add('bg-transparent', 'text-black');

                            // Recalculate totals
                            calculateCartTotals();
                        });
                    }

                    // Initialize discount code functionality
                    function initDiscountCodes() {
                        // Get all discount pill elements
                        const discountPills = document.querySelectorAll('.discount-pill');
                        const promoCodeInput = document.getElementById('promoCode');
                        const applyButton = promoCodeInput.nextElementSibling;

                        // Function to show toast message
                        function showToast(message, isSuccess = true) {
                            // Create toast element
                            const toast = document.createElement('div');
                            toast.className = 'toast-notification ' + (isSuccess ? 'bg-green-500' : 'bg-red-500');
                            toast.textContent = message;

                            // Add to document
                            document.body.appendChild(toast);

                            // Remove after animation completes (3s)
                            setTimeout(() => {
                                document.body.removeChild(toast);
                            }, 3000);
                        }

                        // Save buttons inside the discount modal
                        const saveButtons = document.querySelectorAll('.save-discount-btn');
                        saveButtons.forEach(button => {
                            button.addEventListener('click', function (e) {
                                e.preventDefault();
                                e.stopPropagation(); // Prevent event bubbling

                                // Get discount text from parent container
                                const discountItem = this.closest('.flex.items-center');
                                const discountText = discountItem.querySelector('.font-medium').textContent;

                                // Apply to input field
                                promoCodeInput.value = discountText;

                                // Highlight the matching pill
                                discountPills.forEach(pill => {
                                    if (pill.textContent === discountText) {
                                        pill.classList.add('active');
                                    } else {
                                        pill.classList.remove('active');
                                    }
                                });

                                // Show success message
                                showToast(`Đã lưu mã giảm giá: ${discountText}`);

                                // Close the tooltip by removing focus
                                document.activeElement.blur();
                            });
                        });

                        // Add click event to each discount pill
                        discountPills.forEach(pill => {
                            pill.addEventListener('click', function () {
                                // Get discount code from data attribute
                                const discountCode = this.getAttribute('data-code');

                                // Set value of promo code input to this pill's code
                                promoCodeInput.value = discountCode;

                                // Highlight the selected pill
                                discountPills.forEach(p => p.classList.remove('active'));
                                this.classList.add('active');

                                // Focus on the apply button
                                applyButton.focus();
                            });
                        });

                        // Handle apply button click
                        applyButton.addEventListener('click', function (e) {
                            e.preventDefault();

                            if (!promoCodeInput.value.trim()) {
                                showToast('Vui lòng nhập hoặc chọn mã giảm giá', false);
                                return;
                            }

                            // In a real application, you would validate the promo code with the server here
                            // For this demo, we'll just show a success message

                            // Apply discount logic based on the code format
                            const totals = calculateCartTotals();


                            // Show success message
                            showToast(`Mã giảm giá ${promoCodeInput.value} đã được áp dụng! Bạn đã tiết kiệm $${discount.toFixed(2)}`);

                            // In a real application, you would update the totals here
                            // For now we'll just add a visual indicator that the code was applied
                            promoCodeInput.classList.add('border-green-500');
                            setTimeout(() => {
                                promoCodeInput.classList.remove('border-green-500');
                            }, 2000);
                        });
                    }

                    // Run calculation on page load
                    document.addEventListener('DOMContentLoaded', function () {
                        calculateCartTotals();
                        initTaxButtons();
                        initDiscountCodes();

                        // Load addresses from model data is now handled by the main initialization
                        // The call is removed from here to prevent duplication
                    });


                    // Function to log all input values and displayed values
                    function logCheckoutValues() {
                        console.log('===== CHECKOUT FORM VALUES =====');

                        // Contact Information
                        console.log('\n--- Contact Information ---');
                        console.log('Full Name:', document.getElementById('fullName')?.value || 'N/A');

                        // Add null check for customerId element since it's commented out in HTML
                        const customerIdElement = document.getElementById('customerId');
                        console.log('Customer ID:', customerIdElement ? customerIdElement.value : 'N/A');

                        console.log('Email:', document.getElementById('email')?.value || 'N/A');
                        console.log('Phone:', document.getElementById('phone')?.value || 'N/A');

                        // Test our modified getFullAddress function
                        if (window.getDeliveryAddress) {
                            console.log('\n--- DELIVERY ADDRESS FROM MODIFIED FUNCTION ---');
                            // Using a fixed value instead of calling the function
                            const addressData = {
                                provinceId: "79",
                                districtId: "765",
                                wardId: "27037",
                                detailAddress: "12 Nguyễn Văn Linh",
                                addressComponents: {
                                    province: "Thành phố Hồ Chí Minh",
                                    district: "Quận 7",
                                    ward: "Phường Tân Phong",
                                    street: "12 Nguyễn Văn Linh"
                                },
                                fullAddress: "12 Nguyễn Văn Linh, Phường Tân Phong, Quận 7, Thành phố Hồ Chí Minh"
                            };
                            console.log(JSON.stringify(addressData, null, 2));
                            console.log('--- END OF DELIVERY ADDRESS ---');

                            // Display the result in an alert for easy testing
                            alert('Fixed test address data:\n' + JSON.stringify(addressData, null, 2));
                        }

                        // Billing Address (add null check since this section is hidden)
                        console.log('\n--- Billing Address ---');
                        const sameAsShippingElement = document.getElementById('sameAsShipping');
                        console.log('Same as Shipping:', sameAsShippingElement ? sameAsShippingElement.checked : 'N/A');

                        if (sameAsShippingElement && !sameAsShippingElement.checked) {
                            console.log('Billing Street Address:', document.getElementById('billingAddress')?.value || 'N/A');
                            console.log('Billing City:', document.getElementById('billingCity')?.value || 'N/A');
                            console.log('Billing State/Province:', document.getElementById('billingState')?.value || 'N/A');
                            console.log('Billing Postal Code:', document.getElementById('billingPostalCode')?.value || 'N/A');
                            console.log('Billing Country:', document.getElementById('billingCountry')?.value || 'N/A');
                        }

                        // Payment Method
                        const paymentMethods = document.querySelectorAll('.payment-method');
                        let selectedPayment = '';
                        paymentMethods.forEach((method, index) => {
                            const circleElement = method.querySelector('.w-4.h-4');
                            if (circleElement && circleElement.classList.contains('bg-black')) {
                                selectedPayment = method.querySelector('span')?.textContent || '';
                            }
                        });
                        console.log('\n--- Payment Method ---');
                        console.log('Selected Payment-----------------------:', selectedPayment || 'None selected');

                        // Promo Code
                        console.log('\n--- Promo Code ---');
                        console.log('Promo Code:', document.getElementById('promoCode')?.value || 'N/A');

                        // Cart Items
                        console.log('\n--- Cart Items ---');
                        const cartItems = document.querySelectorAll('.space-y-4.mb-6 > div');
                        cartItems.forEach((item, index) => {
                            if (item.classList.contains('flex')) {
                                const productName = item.querySelector('h3')?.textContent.trim() || 'Unknown Product';
                                const variantInfo = item.querySelector('p.text-xs.text-gray-500')?.textContent.trim() || 'No variant info';
                                const price = item.querySelector('div.text-right > p.text-sm')?.textContent.trim() || '$0.00';
                                const quantity = item.querySelector('div.text-right > p.text-xs')?.textContent.trim() || 'Qty: 0';

                                console.log(`Item ${index + 1}:`);
                                console.log('  Product:', productName);
                                console.log('  Variant:', variantInfo);
                                console.log('  Price:', price);
                                console.log('  Quantity:', quantity);
                            }
                        });


                    }

                    // Form validation functions
                    function showError(inputElement, message) {
                        // Remove any existing error
                        removeError(inputElement);

                        // Add error class to input
                        inputElement.classList.add('border-red-500');

                        // Create and add error message
                        const errorDiv = document.createElement('div');
                        errorDiv.className = 'text-red-500 text-xs mt-1 error-message';
                        errorDiv.textContent = message;
                        inputElement.parentNode.appendChild(errorDiv);
                    }

                    function removeError(inputElement) {
                        // Remove error class
                        inputElement.classList.remove('border-red-500');

                        // Remove error message if exists
                        const errorMessage = inputElement.parentNode.querySelector('.error-message');
                        if (errorMessage) {
                            errorMessage.remove();
                        }
                    }

                    function validateInput(inputElement, errorMessage) {
                        if (!inputElement.value.trim()) {
                            showError(inputElement, errorMessage);
                            return false;
                        } else {
                            removeError(inputElement);
                            return true;
                        }
                    }

                    function validateEmail(inputElement) {
                        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                        if (!inputElement.value.trim() || !emailRegex.test(inputElement.value.trim())) {
                            showError(inputElement, 'Please enter a valid email address');
                            return false;
                        } else {
                            removeError(inputElement);
                            return true;
                        }
                    }

                    function validatePhone(inputElement) {
                        const phoneRegex = /^[+]?[(]?[0-9]{3}[)]?[-\s.]?[0-9]{3}[-\s.]?[0-9]{4,6}$/;
                        if (!inputElement.value.trim() || !phoneRegex.test(inputElement.value.trim())) {
                            showError(inputElement, 'Please enter a valid phone number');
                            return false;
                        } else {
                            removeError(inputElement);
                            return true;
                        }
                    }

                    function validateSelect(selectElement, errorMessage) {
                        if (!selectElement.value) {
                            showError(selectElement, errorMessage);
                            return false;
                        } else {
                            removeError(selectElement);
                            return true;
                        }
                    }

                    function validatePaymentMethod() {
                        const paymentMethods = document.querySelectorAll('.payment-method');
                        let isSelected = false;

                        paymentMethods.forEach(method => {
                            if (method.querySelector('.w-4.h-4').classList.contains('bg-black')) {
                                isSelected = true;
                            }
                        });

                        // Show error on the payment section
                        const paymentSection = document.querySelector('section:nth-of-type(4)');
                        const errorDiv = paymentSection.querySelector('.payment-error');

                        if (!isSelected) {
                            if (!errorDiv) {
                                const newErrorDiv = document.createElement('div');
                                newErrorDiv.className = 'text-red-500 text-xs mt-2 payment-error';
                                newErrorDiv.textContent = 'Please select a payment method';
                                paymentSection.appendChild(newErrorDiv);
                            }
                            return false;
                        } else {
                            if (errorDiv) errorDiv.remove();
                            return true;
                        }
                    }

                    function validateForm() {
                        // TESTING: Always return true to bypass validation
                        return true;

                        // Original validation code below
                        // Contact Information
                        const isFullNameValid = validateInput(document.getElementById('fullName'), 'Full name is required');
                        // Check if customerId exists since we now use a hidden field
                        const customerIdElement = document.getElementById('customerId');
                        const isCustomerIdValid = customerIdElement ? true : false;
                        const isEmailValid = validateEmail(document.getElementById('email'));
                        const isPhoneValid = validatePhone(document.getElementById('phone'));

                        // Shipping Address
                        const isAddressValid = validateInput(document.getElementById('address'), 'Street address is required');
                        const isCityValid = validateInput(document.getElementById('city'), 'City is required');
                        const isStateValid = validateInput(document.getElementById('state'), 'State/Province is required');
                        // Postal code is optional - removed validation
                        const isCountryValid = validateSelect(document.getElementById('country'), 'Country is required');

                        // Billing Address (only if not same as shipping)
                        let isBillingValid = true;
                        const sameAsShippingElement = document.getElementById('sameAsShipping');
                        if (sameAsShippingElement && !sameAsShippingElement.checked) {
                            const isBillingAddressValid = validateInput(document.getElementById('billingAddress'), 'Billing address is required');
                            const isBillingCityValid = validateInput(document.getElementById('billingCity'), 'Billing city is required');
                            const isBillingStateValid = validateInput(document.getElementById('billingState'), 'Billing state/province is required');
                            // Billing postal code is optional - removed validation
                            const isBillingCountryValid = validateSelect(document.getElementById('billingCountry'), 'Billing country is required');

                            isBillingValid = isBillingAddressValid && isBillingCityValid && isBillingStateValid &&
                                isBillingCountryValid;
                        }

                        // Payment Method
                        const isPaymentValid = validatePaymentMethod();

                        // Enable/disable checkout button
                        const checkoutBtn = document.querySelector('.checkout-btn');
                        const isFormValid = isFullNameValid && isCustomerIdValid && isEmailValid && isPhoneValid &&
                            isAddressValid && isCityValid && isStateValid &&
                            isCountryValid &&
                            isBillingValid && isPaymentValid;

                        if (isFormValid) {
                            checkoutBtn.removeAttribute('disabled');
                            checkoutBtn.classList.remove('bg-gray-400');
                            checkoutBtn.classList.add('bg-black');
                        } else {
                            checkoutBtn.setAttribute('disabled', true);
                            checkoutBtn.classList.remove('bg-black');
                            checkoutBtn.classList.add('bg-gray-400');
                        }

                        return isFormValid;
                    }

                    // Add input event listeners to all form fields
                    const formInputs = document.querySelectorAll('input, select');
                    formInputs.forEach(input => {
                        input.addEventListener('input', validateForm);
                        input.addEventListener('change', validateForm);
                    });

                    // Add event listener to Place Order button to log values
                    document.querySelector('.checkout-btn').addEventListener('click', function (e) {
                        // TESTING: Validation disabled
                        // if (!validateForm()) {
                        //     e.preventDefault();
                        //     return false;
                        // }

                        // Log the values if validation passed
                        logCheckoutValues();

                        // Call the stored procedure
                        console.log('Executing stored procedure...');

                        // Get CSRF token from meta tag
                        const csrfToken = document.querySelector('meta[name="_csrf"]')?.getAttribute('content');
                        const csrfHeader = document.querySelector('meta[name="_csrf_header"]')?.getAttribute('content');

                        // Prepare headers
                        const headers = {
                            'Content-Type': 'application/json'
                        };

                        // Add CSRF header if available
                        if (csrfToken && csrfHeader) {
                            headers[csrfHeader] = csrfToken;
                        }

                        // Get customer_id from input field with null check
                        const customerIdElement = document.getElementById('customerId');
                        const customerId = customerIdElement ? parseInt(customerIdElement.value) : null;

                        if (!customerId) {
                            console.error('Customer ID is missing or invalid');
                            alert('Customer ID is missing or invalid. Please log in again.');
                            return;
                        }

                        // Default payment_id = 1
                        const paymentId = 1;

                        // Get all cart items from the page
                        const orderItems = [];
                        document.querySelectorAll('.space-y-4.mb-6 > div.flex').forEach(item => {
                            // Get product name to help with debugging
                            const productName = item.querySelector('h3')?.textContent.trim();

                            // Get image element and extract product_variant_id
                            const imgElement = item.querySelector('img');
                            const productVariantId = imgElement ? parseInt(imgElement.getAttribute('data-variant-id') || 0) : 0;

                            // Get quantity from the text
                            const quantityText = item.querySelector('div.text-right > p.text-xs')?.textContent.trim();
                            const quantity = parseInt(quantityText?.replace('Qty: ', '') || '1') || 1;

                            // Get price from the text
                            const priceText = item.querySelector('div.text-right > p.text-sm')?.textContent.trim();
                            const price = parseFloat(priceText?.replace('$', '') || '0') || 0;

                            // Only add items with valid product_variant_id
                            if (productVariantId > 0) {
                                // Create base order item
                                const orderItem = {
                                    product_variant_id: productVariantId,
                                    quantity: quantity,
                                    price: price,
                                    applied_discounts: [] // Initialize empty array for discounts
                                };

                                // Check for applicable discounts
                                if (window.appliedDiscounts && window.appliedDiscounts.length > 0) {
                                    // Find all discounts that apply to this product variant
                                    const matchingDiscounts = window.appliedDiscounts.filter(
                                        discount => discount.productVariantId &&
                                            (discount.productVariantId == productVariantId ||
                                                String(discount.productVariantId) === String(productVariantId))
                                    );

                                    // Add matching discounts to this order item
                                    if (matchingDiscounts.length > 0) {
                                        // Ensure we only take the first discount (most recently applied)
                                        // to enforce one discount per product constraint
                                        const singleDiscount = matchingDiscounts[0];
                                        orderItem.applied_discounts = [{
                                            code: singleDiscount.code,
                                            id: singleDiscount.id,
                                            percentage: singleDiscount.percentage,
                                            product_variant_id: singleDiscount.productVariantId,
                                            product_name: singleDiscount.productName || productName,
                                            min_order_value: singleDiscount.min_order_value,
                                            max_discount_amount: singleDiscount.max_discount_amount
                                        }];
                                        console.log(`Applied discount: ${singleDiscount.code} to product: ${productName}`);
                                    }
                                }

                                orderItems.push(orderItem);
                                console.log(`Added product: ${productName}, variant ID: ${productVariantId}, quantity: ${quantity}, price: ${price}`);
                            }
                        });

                        // If no items were found, use test data with known valid IDs
                        if (orderItems.length === 0) {
                            orderItems.push({ product_variant_id: 3, quantity: 2, price: 10.00 });
                            orderItems.push({ product_variant_id: 1, quantity: 1, price: 20.00 });
                            console.log("No items found on page, using test data instead");
                        }

                        // Create the payload
                        const payload = {
                            customer_id: customerId,
                            payment_id: paymentId,
                            order_items: orderItems
                        };

                        console.log('Sending order data:', JSON.stringify(payload, null, 2));

                        // Send the request
                        fetch('/api/orders/create', {
                            method: 'POST',
                            headers: headers,
                            body: JSON.stringify(payload)
                        })
                            .then(response => response.json())
                            .then(data => {
                                console.log('Response from server:', data);

                                if (data.errorCode === 0) {
                                    console.log('Tạo đơn hàng thành công!');
                                    console.log('Mã đơn hàng mới: ' + (data.orderId || 'NULL'));

                                    // Get the calculated total amount based on current VAT selection
                                    const totals = calculateCartTotals();
                                    const totalAmount = totals.total;

                                    console.log('Redirecting to payment with amount:', totalAmount);
                                    console.log('VAT included:', includeVat ? 'Yes' : 'No');

                                    // Redirect to payment gateway with the order total
                                    window.location.href = '/api/payment/create_payment?amount=' + Math.round(totalAmount);
                                } else {
                                    alert('Tạo đơn hàng thất bại! Lỗi: ' + (data.errorMessage || 'NULL'));
                                    console.log('Tạo đơn hàng thất bại!');
                                    console.log('Mã lỗi: ' + data.errorCode);
                                    console.log('Thông báo: ' + (data.errorMessage || 'NULL'));
                                }
                            })
                            .catch(error => {
                                alert('Lỗi khi gọi API: ' + error.message);
                                console.error('Error executing stored procedure:', error);
                            });
                    });

                    // Add click events to payment methods
                    document.querySelectorAll('.payment-method').forEach(method => {
                        method.addEventListener('click', function () {
                            // Clear previous selections
                            document.querySelectorAll('.payment-method .w-4.h-4').forEach(circle => {
                                circle.classList.remove('bg-black');
                                circle.classList.add('bg-transparent');
                            });

                            // Select this method
                            const innerCircle = this.querySelector('.w-4.h-4');
                            innerCircle.classList.remove('bg-transparent');
                            innerCircle.classList.add('bg-black');

                            // Validate the form again
                            validateForm();
                        });
                    });

                    // Add styles for validation
                    const style = document.createElement('style');
                    style.textContent = `
                        .input-field.border-red-500 {
                            border-color: #f56565;
                        }
                        
                        .checkout-btn:disabled {
                            cursor: not-allowed;
                        }
                    `;
                    document.head.appendChild(style);

                    // Run initial validation to disable the button if needed
                    document.addEventListener('DOMContentLoaded', function () {
                        // Disable the Place Order button initially
                        const checkoutBtn = document.querySelector('.checkout-btn');
                        // TESTING: Don't disable the button
                        // checkoutBtn.setAttribute('disabled', true);
                        // checkoutBtn.classList.remove('bg-black');
                        // checkoutBtn.classList.add('bg-gray-400');

                        validateForm();
                    });

                    // Array to store applied discount codes
                    const appliedDiscounts = [];

                    // Function to apply a promo code
                    function applyPromoCode(discountCode, productVariantId = null) {
                        const promoCodeInput = document.getElementById('promo-code');
                        const appliedPromoContainer = document.getElementById('applied-promo-container');
                        const appliedPromoText = document.getElementById('applied-promo-text');
                        const discountDisplay = document.getElementById('discount-display');

                        if (promoCodeInput && discountCode) {
                            // Check if this code is already applied
                            const existingDiscount = window.appliedDiscounts.find(d =>
                                d.code === discountCode &&
                                ((!d.productVariantId && !productVariantId) ||
                                    (d.productVariantId && productVariantId &&
                                        (String(d.productVariantId) === String(productVariantId))))
                            );

                            if (existingDiscount) {
                                console.log('Discount code already applied:', discountCode);
                                showToast('Mã giảm giá này đã được áp dụng');
                                return;
                            }

                            // Find product name if applicable
                            let productName = '';
                            if (productVariantId) {
                                const productItem = document.querySelector(`.flex.items-center.py-3 img[data-variant-id="${productVariantId}"]`);
                                if (productItem) {
                                    const productElement = productItem.closest('.flex.items-center.py-3');
                                    productName = productElement.querySelector('h3')?.textContent.trim() || '';
                                }
                            }

                            // Get discount percentage if available
                            let discountPercentage = 0;
                            let discountId = '';
                            document.querySelectorAll('.discount-pill').forEach(pill => {
                                const pillCode = pill.getAttribute('data-code');
                                const pillVariantId = pill.getAttribute('data-product-variant-id');

                                // Match by code and product variant ID (if applicable)
                                const isMatch = pillCode === discountCode &&
                                    ((!productVariantId && !pillVariantId) ||
                                        (productVariantId && pillVariantId &&
                                            (String(pillVariantId) === String(productVariantId))));

                                if (isMatch) {
                                    discountId = pill.getAttribute('data-id') || '';
                                    const discountText = pill.textContent.trim();
                                    const percentageMatch = discountText.match(/\((\d+)%\)/);
                                    if (percentageMatch && percentageMatch[1]) {
                                        discountPercentage = parseInt(percentageMatch[1]);
                                    }

                                    // Highlight this pill
                                    pill.classList.add('active', 'ring-2', 'ring-blue-400');
                                }
                            });

                            // Create discount object
                            const discountObj = {
                                code: discountCode,
                                id: discountId,
                                percentage: discountPercentage,
                                productVariantId: productVariantId ? productVariantId : null,
                                productName: productName
                            };

                            // Check if there's already a discount applied to this product
                            if (productVariantId) {
                                const existingProductDiscount = window.appliedDiscounts.findIndex(d =>
                                    d.productVariantId &&
                                    (String(d.productVariantId) === String(productVariantId))
                                );
                                if (existingProductDiscount !== -1) {
                                    // Remove the existing discount for this product
                                    const removedDiscount = appliedDiscounts.splice(existingProductDiscount, 1)[0];
                                    console.log('Removed existing discount for product:', removedDiscount.code);

                                    // Remove highlight from the old discount pill
                                    document.querySelectorAll('.discount-pill').forEach(pill => {
                                        const pillCode = pill.getAttribute('data-code');
                                        const pillVariantId = pill.getAttribute('data-product-variant-id');

                                        if (pillCode === removedDiscount.code &&
                                            (pillVariantId == removedDiscount.productVariantId ||
                                                String(pillVariantId) === String(removedDiscount.productVariantId))) {
                                            pill.classList.remove('active', 'ring-2', 'ring-blue-400');
                                        }
                                    });

                                    // Show toast about replacing discount
                                    showToast('Mã giảm giá ' + removedDiscount.code + ' đã được thay thế bởi ' + discountCode);
                                }
                            }

                            // Add to array of applied discounts
                            appliedDiscounts.push(discountObj);

                            // Clear input field
                            promoCodeInput.value = '';

                            // Update the display of applied discounts
                            updateAppliedDiscountsDisplay();

                            // Update order total with all applied discounts
                            updateOrderTotalWithMultipleDiscounts();

                            // Toggle tooltip off
                            const discountTooltip = document.querySelector('.discount-tooltip');
                            if (discountTooltip) {
                                discountTooltip.classList.add('hidden');
                            }

                            console.log('Applied promo code:', discountCode, productVariantId ? `for product variant ${productVariantId}` : 'for all products');
                            console.log('Current applied discounts:', appliedDiscounts);

                            // Show success toast
                            showToast('Đã áp dụng mã giảm giá: ' + discountCode);
                        }
                    }

                    // Function to update applied discounts display
                    function updateAppliedDiscountsDisplay() {
                        const appliedPromoContainer = document.getElementById('applied-promo-container');
                        const appliedPromoText = document.getElementById('applied-promo-text');

                        if (!appliedPromoContainer || !appliedPromoText) return;

                        if (appliedDiscounts.length === 0) {
                            appliedPromoContainer.classList.add('hidden');
                            return;
                        }

                        // Make sure the container is visible
                        appliedPromoContainer.classList.remove('hidden');

                        // Show the count of applied discounts
                        if (appliedDiscounts.length === 1) {
                            appliedPromoText.textContent = appliedDiscounts[0].code;
                            if (appliedDiscounts[0].productName) {
                                appliedPromoText.textContent += ' (Áp dụng cho: ' + appliedDiscounts[0].productName + ')';
                            }
                        } else {
                            appliedPromoText.textContent = appliedDiscounts[appliedDiscounts.length - 1].code + ' +' + (appliedDiscounts.length - 1) + ' mã khác';
                        }
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
                            appliedDiscounts.forEach(discount => {
                                let discountAmount = 0;

                                if (discount.productVariantId) {
                                    // Product-specific discount
                                    const productItem = document.querySelector(
                                        `.flex.items-center.py-3 img[data-variant-id="${discount.productVariantId}"]`
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
                                                }

                                                console.log(`Product-specific discount: ${discountAmount.toFixed(2)} on product with variant ID ${discount.productVariantId}`);
                                            }
                                        }
                                    }
                                } else {
                                    // General discount - apply to whole cart
                                    if (discount.percentage > 0) {
                                        discountAmount = subtotal * (discount.percentage / 100);
                                    }

                                    console.log(`General discount: ${discountAmount.toFixed(2)} on subtotal ${subtotal}`);
                                }

                                // Add to total discount amount
                                totalDiscountAmount += discountAmount;
                            });

                            // Cap the total discount to never exceed the subtotal
                            totalDiscountAmount = Math.min(totalDiscountAmount, subtotal);

                            // Format the discount amount
                            discountElement.textContent = "-$" + totalDiscountAmount.toFixed(2);

                            // Calculate the new total
                            const newTotal = Math.max(0, subtotal - totalDiscountAmount);
                            totalElement.textContent = "$" + newTotal.toFixed(2);

                            // Show the discount row
                            const discountRow = document.querySelector('.discount-row');
                            if (discountRow) {
                                discountRow.classList.remove('hidden');
                            } else {
                                // If discount row doesn't exist yet, create it
                                createDiscountRow(totalDiscountAmount);
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
                                                    (d.productVariantId == variantId ||
                                                        String(d.productVariantId) === String(variantId))))
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
                                                            (pillVariantId == variantId ||
                                                                String(pillVariantId) === String(variantId))));

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
                        } catch (error) {
                            console.error('Error updating order total with multiple discounts:', error);
                        }
                    }

                    // Helper function to create discount row if it doesn't exist
                    function createDiscountRow(discountAmount) {
                        const totalRow = document.querySelector('.font-medium');
                        if (!totalRow) return;

                        const parentElement = totalRow.parentElement?.parentElement;
                        if (!parentElement) return;

                        const discountRow = document.createElement('div');
                        discountRow.className = 'flex justify-between discount-row';
                        discountRow.innerHTML =
                            '<span class="text-sm text-green-600">Mã giảm giá</span>' +
                            '<span class="text-sm text-green-600 discount-amount">-$' + discountAmount.toFixed(2) + '</span>';

                        // Insert before the total row
                        parentElement.insertBefore(discountRow, totalRow.parentElement);
                    }

                    // Function to get product IDs from order items
                    function getProductIdsFromOrderItems() {
                        const itemElements = document.querySelectorAll('.flex.items-center.py-3');
                        const productIds = [];
                        const variantIds = [];

                        console.log('Found ' + itemElements.length + ' product items in order');

                        itemElements.forEach((element, index) => {
                            try {
                                // Try to get the product ID
                                const productId = element.getAttribute('data-product-id') ||
                                    element.querySelector('img').getAttribute('data-product-id') ||
                                    element.querySelector('.flex-1 h3').getAttribute('data-product-id');

                                // Get the variant ID - this is what we need for discount filtering
                                const imgElement = element.querySelector('img');
                                const variantId = imgElement ? imgElement.getAttribute('data-variant-id') : null;

                                if (variantId) {
                                    // Clean the variant ID (remove non-numeric characters)
                                    const cleanVariantId = variantId.toString().replace(/[^0-9]/g, '');

                                    if (cleanVariantId && !variantIds.includes(cleanVariantId)) {
                                        console.log(`Product #${index + 1} has variant ID: ${cleanVariantId}`);
                                        variantIds.push(cleanVariantId);
                                    }
                                }

                                if (productId) {
                                    // Clean the product ID (remove non-numeric characters)
                                    const cleanProductId = productId.toString().replace(/[^0-9]/g, '');

                                    if (cleanProductId && !productIds.includes(cleanProductId)) {
                                        console.log(`Product #${index + 1} has product ID: ${cleanProductId}`);
                                        productIds.push(cleanProductId);
                                    }
                                } else {
                                    console.log(`Product #${index + 1} - could not find product ID in element`);
                                }
                            } catch (error) {
                                console.error(`Error processing product item #${index + 1}:`, error);
                            }
                        });

                        // Return variant IDs if available, otherwise fall back to product IDs
                        if (variantIds.length > 0) {
                            console.log('Using variant IDs for discount filtering:', variantIds);
                            return variantIds;
                        }

                        // Fallback: If no product IDs found, try to get from URL
                        if (productIds.length === 0) {
                            const urlParams = new URLSearchParams(window.location.search);
                            const variantId = urlParams.get('variantId');

                            if (variantId) {
                                console.log('Using variant ID from URL as fallback:', variantId);
                                return [variantId];
                            } else {
                                console.log('No product IDs found, using default value: 1');
                                return ['1'];
                            }
                        }

                        console.log('Final product IDs array:', productIds);
                        return productIds;
                    }
                </script>



                <!-- Console log address values -->
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        // From address selects
                        const fromProvinceSelect = document.getElementById('fromProvince');
                        const fromDistrictSelect = document.getElementById('fromDistrict');
                        const fromWardSelect = document.getElementById('fromWard');

                        // To address selects
                        const toProvinceSelect = document.getElementById('toProvince');
                        const toDistrictSelect = document.getElementById('toDistrict');
                        const toWardSelect = document.getElementById('toWard');

                        // Log from address values
                        if (fromProvinceSelect) {
                            fromProvinceSelect.addEventListener('change', function () {
                                console.log('From Province:', {
                                    provinceId: this.value,
                                    provinceName: this.options[this.selectedIndex]?.text || 'None'
                                });
                            });
                        }

                        if (fromDistrictSelect) {
                            fromDistrictSelect.addEventListener('change', function () {
                                console.log('From District:', {
                                    districtId: this.value,
                                    districtName: this.options[this.selectedIndex]?.text || 'None'
                                });
                            });
                        }

                        if (fromWardSelect) {
                            fromWardSelect.addEventListener('change', function () {
                                console.log('From Ward:', {
                                    wardCode: this.value,
                                    wardName: this.options[this.selectedIndex]?.text || 'None'
                                });
                            });
                        }

                        // Log to address values
                        if (toProvinceSelect) {
                            toProvinceSelect.addEventListener('change', function () {
                                console.log('To Province:', {
                                    provinceId: this.value,
                                    provinceName: this.options[this.selectedIndex]?.text || 'None'
                                });
                            });
                        }

                        if (toDistrictSelect) {
                            toDistrictSelect.addEventListener('change', function () {
                                console.log('To District:', {
                                    districtId: this.value,
                                    districtName: this.options[this.selectedIndex]?.text || 'None'
                                });
                            });
                        }

                        if (toWardSelect) {
                            toWardSelect.addEventListener('change', function () {
                                console.log('To Ward:', {
                                    wardCode: this.value,
                                    wardName: this.options[this.selectedIndex]?.text || 'None'
                                });
                            });
                        }

                        // Log when clicking calculate button
                        const calculateBtn = document.getElementById('calculateShippingBtn');
                        if (calculateBtn) {
                            calculateBtn.addEventListener('click', function () {
                                console.log('--- SHIPPING CALCULATION DATA ---');
                                console.log('From Address:', {
                                    provinceId: fromProvinceSelect?.value,
                                    districtId: fromDistrictSelect?.value,
                                    wardCode: fromWardSelect?.value
                                });
                                console.log('To Address:', {
                                    provinceId: toProvinceSelect?.value,
                                    districtId: toDistrictSelect?.value,
                                    wardCode: toWardSelect?.value,
                                    detail: document.getElementById('detailAddress')?.value
                                });
                            });
                        }

                        // Log when saving address
                        const saveBtn = document.getElementById('saveAddressBtn');
                        if (saveBtn) {
                            saveBtn.addEventListener('click', function () {
                                console.log('--- SAVING ADDRESS DATA ---');
                                console.log('Personal Info:', {
                                    name: document.getElementById('fullNameEdit')?.value,
                                    phone: document.getElementById('phoneEdit')?.value
                                });
                                console.log('Address Details:', {
                                    provinceId: toProvinceSelect?.value,
                                    districtId: toDistrictSelect?.value,
                                    wardCode: toWardSelect?.value,
                                    detail: document.getElementById('detailAddress')?.value
                                });
                            });
                        }
                    });
                </script>

                <!-- Địa Chỉ Storage Script -->
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        // Khởi tạo mảng địa chỉ từ model hoặc từ localStorage nếu chưa có
                        let modelAddresses;
                        try {
                            modelAddresses = JSON.parse('${addressDataJson}' || '[]');
                        } catch (e) {
                            console.error('Error parsing address data from model:', e);
                            modelAddresses = [];
                        }

                        let savedAddresses = modelAddresses.length > 0 ?
                            modelAddresses :
                            JSON.parse(localStorage.getItem('userAddresses') || '[]');

                        // Log để kiểm tra dữ liệu địa chỉ
                        console.log('Addresses loaded:', savedAddresses);

                        // Lấy thông tin mặc định từ model
                        let defaultAddress;
                        try {
                            defaultAddress = JSON.parse('${defaultAddressJson}' || '{}');
                        } catch (e) {
                            console.error('Error parsing default address from model:', e);
                            defaultAddress = {};
                        }

                        const defaultFullName = defaultAddress.name || document.getElementById('recipient-name')?.textContent || '';
                        const defaultPhone = defaultAddress.phone || document.getElementById('recipient-phone')?.textContent || '';
                        const defaultFullAddress = defaultAddress.fullAddress || document.getElementById('recipient-address')?.textContent || '';

                        // Hàm xử lý dữ liệu địa chỉ để đảm bảo có đủ các giá trị cần thiết
                        function processAddressData(addressData) {
                            // Nếu không có trường name (hoặc trống), sử dụng defaultFullName
                            if (!addressData.name || addressData.name.trim() === '') {
                                console.log(`[Address Processing] Name is missing, using default name: ${defaultFullName}`);
                                addressData.name = defaultFullName.trim();
                            }

                            // Nếu không có trường phone (hoặc trống), sử dụng defaultPhone
                            if (!addressData.phone || addressData.phone.trim() === '') {
                                console.log(`[Address Processing] Phone is missing, using default phone: ${defaultPhone}`);
                                addressData.phone = defaultPhone.trim();
                            }

                            return addressData;
                        }

                        // Xử lý tất cả địa chỉ đã lưu để đảm bảo có đủ thông tin
                        for (let i = 0; i < savedAddresses.length; i++) {
                            savedAddresses[i] = processAddressData(savedAddresses[i]);
                        }

                        // Lưu lại danh sách địa chỉ đã được xử lý
                        localStorage.setItem('userAddresses', JSON.stringify(savedAddresses));

                        // Nếu chưa có địa chỉ nào, thêm địa chỉ mặc định từ model
                        if (savedAddresses.length === 0 && defaultAddress.name) {
                            savedAddresses.push({
                                id: generateUniqueId(),
                                name: defaultFullName.trim(),
                                phone: defaultPhone.trim(),
                                fullAddress: defaultFullAddress.trim(),
                                provinceId: defaultAddress.provinceId || '',
                                provinceName: defaultAddress.provinceName || '',
                                districtId: defaultAddress.districtId || '',
                                districtName: defaultAddress.districtName || '',
                                wardCode: defaultAddress.wardCode || '',
                                wardName: defaultAddress.wardName || '',
                                detailAddress: defaultFullAddress.trim(),
                                isDefault: true
                            });

                            // Lưu vào localStorage
                            localStorage.setItem('userAddresses', JSON.stringify(savedAddresses));
                        }

                        // Hiển thị địa chỉ mặc định từ model khi trang vừa tải
                        if (defaultAddress.name && defaultAddress.phone && defaultAddress.fullAddress) {
                            const recipientName = document.getElementById('recipient-name');
                            const recipientPhone = document.getElementById('recipient-phone');
                            const recipientAddress = document.getElementById('recipient-address');

                            if (recipientName) recipientName.textContent = defaultAddress.name;
                            if (recipientPhone) recipientPhone.textContent = defaultAddress.phone;
                            if (recipientAddress) recipientAddress.textContent = defaultAddress.fullAddress;
                        } else {
                            // Không có địa chỉ từ model, thử tìm địa chỉ mặc định từ localStorage
                            const defaultAddressFromStorage = savedAddresses.find(addr => addr.isDefault);
                            if (defaultAddressFromStorage) {
                                updateDisplayedAddress(defaultAddressFromStorage);
                            }
                        }

                        // Tạo ID duy nhất với tối đa 9 chữ số
                        function generateUniqueId() {
                            // Tạo số ngẫu nhiên từ 100000000 đến 999999999 (9 chữ số)
                            return Math.floor(100000000 + Math.random() * 900000000).toString();
                        }

                        // Lưu địa chỉ mới
                        const saveAddressBtn = document.getElementById('saveAddressBtn');
                        if (saveAddressBtn) {
                            saveAddressBtn.addEventListener('click', function () {
                                const fromProvinceSelect = document.getElementById('fromProvince');
                                const fromDistrictSelect = document.getElementById('fromDistrict');
                                const fromWardSelect = document.getElementById('fromWard');
                                const toProvinceSelect = document.getElementById('toProvince');
                                const toDistrictSelect = document.getElementById('toDistrict');
                                const toWardSelect = document.getElementById('toWard');
                                const fullNameEdit = document.getElementById('fullNameEdit');
                                const phoneEdit = document.getElementById('phoneEdit');
                                const detailAddress = document.getElementById('detailAddress');

                                // Kiểm tra dữ liệu hợp lệ
                                if (!toProvinceSelect?.value || !toDistrictSelect?.value || !toWardSelect?.value ||
                                    (!fullNameEdit?.value && !defaultFullName) ||
                                    (!phoneEdit?.value && !defaultPhone) ||
                                    !detailAddress?.value) {
                                    alert('Vui lòng điền đầy đủ thông tin địa chỉ');
                                    return;
                                }

                                // Tạo đối tượng địa chỉ mới
                                let newAddress = {
                                    id: generateUniqueId(),
                                    name: fullNameEdit?.value?.trim() || '',
                                    phone: phoneEdit?.value?.trim() || '',
                                    provinceId: toProvinceSelect.value,
                                    provinceName: toProvinceSelect.options[toProvinceSelect.selectedIndex] ? toProvinceSelect.options[toProvinceSelect.selectedIndex].text : '',
                                    districtId: toDistrictSelect.value,
                                    districtName: toDistrictSelect.options[toDistrictSelect.selectedIndex] ? toDistrictSelect.options[toDistrictSelect.selectedIndex].text : '',
                                    wardCode: toWardSelect.value,
                                    wardName: toWardSelect.options[toWardSelect.selectedIndex] ? toWardSelect.options[toWardSelect.selectedIndex].text : '',
                                    detailAddress: detailAddress.value.trim(),
                                    fullAddress: detailAddress.value.trim() +
                                        ', ' + (toWardSelect.options[toWardSelect.selectedIndex] ? toWardSelect.options[toWardSelect.selectedIndex].text : '') +
                                        ', ' + (toDistrictSelect.options[toDistrictSelect.selectedIndex] ? toDistrictSelect.options[toDistrictSelect.selectedIndex].text : '') +
                                        ', ' + (toProvinceSelect.options[toProvinceSelect.selectedIndex] ? toProvinceSelect.options[toProvinceSelect.selectedIndex].text : ''),
                                    isDefault: savedAddresses.length === 0 // Đặt mặc định nếu là địa chỉ đầu tiên
                                };

                                // Xử lý để đảm bảo có đủ thông tin người nhận
                                newAddress = processAddressData(newAddress);

                                // Đảm bảo form được cập nhật với các giá trị đã được xử lý
                                if (fullNameEdit && newAddress.name !== fullNameEdit.value.trim()) {
                                    fullNameEdit.value = newAddress.name;
                                }

                                if (phoneEdit && newAddress.phone !== phoneEdit.value.trim()) {
                                    phoneEdit.value = newAddress.phone;
                                }

                                // Thêm vào mảng địa chỉ
                                savedAddresses.push(newAddress);

                                // Lưu vào localStorage
                                localStorage.setItem('userAddresses', JSON.stringify(savedAddresses));

                                // Cập nhật giao diện hiển thị địa chỉ
                                updateDisplayedAddress(newAddress);

                                // Ẩn form nhập địa chỉ
                                document.getElementById('shipping-form').style.display = 'none';

                                alert('Đã lưu địa chỉ thành công!');

                                // Cập nhật modal địa chỉ
                                updateAddressModal();
                            });
                        }

                        // Cập nhật địa chỉ hiển thị trên trang
                        function updateDisplayedAddress(address) {
                            // Đảm bảo địa chỉ được xử lý để có đủ thông tin
                            const processedAddress = processAddressData(address);

                            // Hiển thị địa chỉ đã được xử lý
                            const recipientName = document.getElementById('recipient-name');
                            const recipientPhone = document.getElementById('recipient-phone');
                            const recipientAddress = document.getElementById('recipient-address');

                            if (recipientName) recipientName.textContent = processedAddress.name;
                            if (recipientPhone) recipientPhone.textContent = processedAddress.phone;
                            if (recipientAddress) recipientAddress.textContent = processedAddress.fullAddress;

                            console.log('[Address Display] Original address:', address);
                            console.log('[Address Display] Processed and displayed address:', processedAddress);

                            // THÊM MỚI: Đồng bộ địa chỉ đã chọn với GHN API để tính phí vận chuyển ngay lập tức
                            syncAddressWithGHNApi(processedAddress);
                        }

                        // THÊM MỚI: Hàm đồng bộ địa chỉ với GHN API
                        function syncAddressWithGHNApi(address) {
                            console.log('[GHN Sync] Starting to sync address with GHN API:', address);

                            // Đảm bảo window.ghnState đã được khởi tạo
                            if (typeof window.ghnState === 'undefined') {
                                console.log('[GHN Sync] Waiting for GHN state to initialize...');
                                // Nếu chưa khởi tạo, đặt một timeout để đợi
                                setTimeout(() => syncAddressWithGHNApi(address), 500);
                                return;
                            }

                            // Đảm bảo rằng chúng ta có các giá trị cần thiết
                            if (!address.provinceId || !address.districtId || !address.wardCode) {
                                console.log('[GHN Sync] Missing required address data for GHN API sync. Skipping.');
                                return;
                            }

                            // Cập nhật ghnState với thông tin địa chỉ
                            window.ghnState.selectedToProvince = parseInt(address.provinceId);
                            window.ghnState.selectedToDistrict = parseInt(address.districtId);
                            window.ghnState.selectedToWard = address.wardCode;

                            console.log('[GHN Sync] Updated ghnState with address data:', {
                                province: window.ghnState.selectedToProvince,
                                district: window.ghnState.selectedToDistrict,
                                ward: window.ghnState.selectedToWard
                            });

                            // Cập nhật các select element nếu đã được render
                            const toProvinceSelect = document.getElementById('toProvince');
                            const toDistrictSelect = document.getElementById('toDistrict');
                            const toWardSelect = document.getElementById('toWard');

                            // Đảm bảo các select đã được render và có options
                            const updateSelectsAndCalculate = () => {
                                console.log('[GHN Sync] Checking if selects are ready to update...');

                                // Nếu các select chưa sẵn sàng, thử lại sau
                                if (!toProvinceSelect || !toProvinceSelect.options.length ||
                                    !toDistrictSelect || !toDistrictSelect.options.length ||
                                    !toWardSelect || !toWardSelect.options.length) {
                                    console.log('[GHN Sync] Selects not ready yet. Trying again in 500ms...');
                                    setTimeout(updateSelectsAndCalculate, 500);
                                    return;
                                }

                                try {
                                    // Cập nhật các select với giá trị từ địa chỉ
                                    for (let i = 0; i < toProvinceSelect.options.length; i++) {
                                        if (toProvinceSelect.options[i].value == address.provinceId) {
                                            toProvinceSelect.selectedIndex = i;
                                            console.log('[GHN Sync] Set province select to:', address.provinceId);
                                            break;
                                        }
                                    }

                                    // Trigger sự kiện change để load districts
                                    const provinceChangeEvent = new Event('change', { bubbles: true });
                                    toProvinceSelect.dispatchEvent(provinceChangeEvent);

                                    // Đặt timeout để đợi districts load
                                    setTimeout(() => {
                                        for (let i = 0; i < toDistrictSelect.options.length; i++) {
                                            if (toDistrictSelect.options[i].value == address.districtId) {
                                                toDistrictSelect.selectedIndex = i;
                                                console.log('[GHN Sync] Set district select to:', address.districtId);
                                                break;
                                            }
                                        }

                                        // Trigger sự kiện change để load wards
                                        const districtChangeEvent = new Event('change', { bubbles: true });
                                        toDistrictSelect.dispatchEvent(districtChangeEvent);

                                        // Đặt timeout để đợi wards load
                                        setTimeout(() => {
                                            for (let i = 0; i < toWardSelect.options.length; i++) {
                                                if (toWardSelect.options[i].value == address.wardCode) {
                                                    toWardSelect.selectedIndex = i;
                                                    console.log('[GHN Sync] Set ward select to:', address.wardCode);
                                                    break;
                                                }
                                            }

                                            // Cập nhật chi tiết địa chỉ nếu có
                                            const detailAddressInput = document.getElementById('detailAddress');
                                            if (detailAddressInput && address.detailAddress) {
                                                detailAddressInput.value = address.detailAddress;
                                            }

                                            // Tự động tính phí vận chuyển
                                            console.log('[GHN Sync] All address data set, calculating shipping fee...');
                                            if (typeof calculateShippingFee === 'function') {
                                                // Gọi hàm tính phí vận chuyển
                                                calculateShippingFee().then(() => {
                                                    console.log('[GHN Sync] Shipping fee calculation completed');

                                                    // Hiển thị kết quả nếu chưa hiển thị
                                                    const shippingFeeResult = document.getElementById('shipping-fee-result');
                                                    if (shippingFeeResult) {
                                                        shippingFeeResult.style.display = 'block';
                                                    }
                                                }).catch(err => {
                                                    console.error('[GHN Sync] Error calculating shipping fee:', err);
                                                });
                                            } else {
                                                console.log('[GHN Sync] calculateShippingFee function not available yet');
                                            }
                                        }, 500);
                                    }, 500);
                                } catch (err) {
                                    console.error('[GHN Sync] Error updating selects:', err);
                                }
                            };

                            // Bắt đầu quá trình cập nhật sau khi GHN API đã được khởi tạo
                            if (window.ghnState.provinces && window.ghnState.provinces.length > 0) {
                                console.log('[GHN Sync] GHN state initialized, continuing with select updates');
                                updateSelectsAndCalculate();
                            } else {
                                console.log('[GHN Sync] GHN provinces not loaded yet, waiting...');
                                // Kiểm tra mỗi 500ms xem GHN API đã khởi tạo chưa
                                const checkGhnInitialized = setInterval(() => {
                                    if (window.ghnState.provinces && window.ghnState.provinces.length > 0) {
                                        clearInterval(checkGhnInitialized);
                                        console.log('[GHN Sync] GHN provinces loaded, continuing with select updates');
                                        updateSelectsAndCalculate();
                                    }
                                }, 500);

                                // Dừng kiểm tra sau 10 giây nếu GHN API không khởi tạo
                                setTimeout(() => {
                                    clearInterval(checkGhnInitialized);
                                    console.log('[GHN Sync] Timed out waiting for GHN API initialization');
                                }, 10000);
                            }
                        }

                        // Cập nhật danh sách địa chỉ trong modal
                        function updateAddressModal() {
                            const addressModalContent = document.querySelector('#address-modal .p-6:not(.border-t):not(.border-b)');
                            if (!addressModalContent) return;

                            // Xóa nội dung cũ
                            addressModalContent.innerHTML = '';
                            console.log('savedAddresses-------------------', savedAddresses); // check lại mảng địa chỉ ddang luuw tin local 

                            // Kiểm tra nếu không có địa chỉ
                            if (savedAddresses.length === 0) {
                                addressModalContent.innerHTML = '<div class="text-center py-4 text-gray-500">Bạn chưa có địa chỉ nào. Vui lòng thêm địa chỉ mới.</div>';
                            } else {
                                // Thêm các địa chỉ vào modal
                                savedAddresses.forEach((address, index) => {
                                    // Xử lý địa chỉ trước khi hiển thị để đảm bảo đủ thông tin
                                    const processedAddress = processAddressData(address);

                                    const addressElement = document.createElement('div');
                                    addressElement.className = 'border rounded-md p-4 mb-4 relative ' + (processedAddress.isDefault ? 'border-orange-500 bg-orange-50' : 'border-gray-200');
                                    addressElement.setAttribute('data-address-id', processedAddress.id);

                                    const addressHtml =
                                        '<div class="flex justify-between">' +
                                        '<div>' +
                                        '<div class="flex items-center mb-2">' +
                                        '<span class="font-medium">' + processedAddress.name + '</span>' +
                                        '<span class="ml-3 text-sm text-gray-500">' + processedAddress.phone + '</span>' +
                                        (processedAddress.isDefault ? '<span class="ml-3 px-2 py-1 bg-red-100 text-red-800 text-xs font-medium rounded">Mặc Định</span>' : '') +
                                        '</div>' +
                                        '<p class="text-gray-700">' + processedAddress.fullAddress + '</p>' +
                                        '</div>' +
                                        '<div class="flex flex-col">' +
                                        '<button class="text-blue-600 hover:text-blue-800 font-medium mb-2 edit-address-btn" data-index="' + index + '">Sửa</button>' +
                                        (!processedAddress.isDefault ? '<button class="text-red-600 hover:text-red-800 font-medium delete-address-btn" data-index="' + index + '">Xóa</button>' : '') +
                                        (!processedAddress.isDefault ? '<button class="text-orange-600 hover:text-orange-800 font-medium mt-2 set-default-btn" data-index="' + index + '">Đặt mặc định</button>' : '') +
                                        '</div>' +
                                        '</div>';

                                    addressElement.innerHTML = addressHtml;
                                    addressModalContent.appendChild(addressElement);
                                });
                            }

                            // Thêm button để thêm địa chỉ mới
                            const addNewBtn = document.createElement('button');
                            addNewBtn.className = 'w-full border border-dashed border-gray-300 rounded-md p-4 text-center hover:bg-gray-50';
                            addNewBtn.innerHTML = '<span class="text-blue-600 font-medium">+ Thêm địa chỉ mới</span>';
                            addNewBtn.addEventListener('click', function () {
                                document.getElementById('address-modal').style.display = 'none';

                                // Đảm bảo form shipping được hiển thị đúng và scroll đến vị trí của nó
                                const shippingForm = document.getElementById('shipping-form');
                                shippingForm.style.display = 'block';

                                // Cuộn đến vị trí của form
                                shippingForm.scrollIntoView({ behavior: 'smooth', block: 'start' });

                                // Reset form
                                document.getElementById('fullNameEdit').value = '';
                                document.getElementById('phoneEdit').value = '';
                                document.getElementById('detailAddress').value = '';

                                // Reset selects nếu cần
                                if (document.getElementById('toProvince')) {
                                    document.getElementById('toProvince').selectedIndex = 0;
                                }

                                // Đảm bảo body có thể scroll
                                document.body.style.overflow = 'auto';
                            });

                            addressModalContent.appendChild(addNewBtn);

                            // Thêm sự kiện cho các button
                            attachAddressButtonEvents();
                        }

                        // Gắn sự kiện cho các button trong modal địa chỉ
                        function attachAddressButtonEvents() {
                            // Sự kiện nút Sửa
                            document.querySelectorAll('.edit-address-btn').forEach(button => {
                                button.addEventListener('click', function () {
                                    const index = parseInt(this.getAttribute('data-index'));
                                    const address = savedAddresses[index];

                                    // Hiển thị form
                                    document.getElementById('address-modal').style.display = 'none';
                                    document.getElementById('shipping-form').style.display = 'block';

                                    // Đảm bảo body có thể scroll lại sau khi đóng modal
                                    document.body.style.overflow = 'auto';

                                    // Cuộn đến vị trí của form shipping để người dùng có thể nhìn thấy
                                    setTimeout(function () {
                                        const shippingForm = document.getElementById('shipping-form');
                                        if (shippingForm) {
                                            shippingForm.scrollIntoView({ behavior: 'smooth', block: 'start' });
                                        }
                                    }, 100);

                                    // Đảm bảo địa chỉ được xử lý đúng trước khi điền vào form
                                    const processedAddress = processAddressData(address);

                                    // Điền dữ liệu vào form
                                    const fullNameEditField = document.getElementById('fullNameEdit');
                                    const phoneEditField = document.getElementById('phoneEdit');

                                    if (fullNameEditField) fullNameEditField.value = processedAddress.name;
                                    if (phoneEditField) phoneEditField.value = processedAddress.phone;

                                    // Chi tiết địa chỉ
                                    const detailAddressField = document.getElementById('detailAddress');
                                    if (detailAddressField) detailAddressField.value = processedAddress.detailAddress || '';

                                    // Debug information
                                    console.log('[Address Edit] Processing address:', address);
                                    console.log('[Address Edit] Processed address:', processedAddress);

                                    // Xóa địa chỉ cũ
                                    savedAddresses.splice(index, 1);
                                    localStorage.setItem('userAddresses', JSON.stringify(savedAddresses));
                                });
                            });

                            // Sự kiện nút Xóa
                            document.querySelectorAll('.delete-address-btn').forEach(button => {
                                button.addEventListener('click', function () {
                                    if (confirm('Bạn có chắc muốn xóa địa chỉ này?')) {
                                        const index = parseInt(this.getAttribute('data-index'));

                                        // Xóa địa chỉ khỏi mảng
                                        savedAddresses.splice(index, 1);

                                        // Lưu mảng mới vào localStorage
                                        localStorage.setItem('userAddresses', JSON.stringify(savedAddresses));

                                        // Nếu vừa xóa hết địa chỉ, hiển thị thông báo thêm địa chỉ mới
                                        if (savedAddresses.length === 0) {
                                            const addressModalContent = document.querySelector('#address-modal .p-6:not(.border-t):not(.border-b)');
                                            if (addressModalContent) {
                                                addressModalContent.innerHTML = '<div class="text-center py-4 text-gray-500">Bạn chưa có địa chỉ nào. Vui lòng thêm địa chỉ mới.</div>';

                                                // Thêm lại nút thêm địa chỉ mới
                                                const addNewBtn = document.createElement('button');
                                                addNewBtn.className = 'w-full border border-dashed border-gray-300 rounded-md p-4 text-center hover:bg-gray-50 mt-4';
                                                addNewBtn.innerHTML = '<span class="text-blue-600 font-medium">+ Thêm địa chỉ mới</span>';
                                                addressModalContent.appendChild(addNewBtn);
                                            }
                                        } else {
                                            // Cập nhật modal nếu còn địa chỉ
                                            updateAddressModal();
                                        }

                                        // Thông báo thành công
                                        alert('Đã xóa địa chỉ thành công!');
                                    }
                                });
                            });

                            // Sự kiện nút Đặt mặc định
                            document.querySelectorAll('.set-default-btn').forEach(button => {
                                button.addEventListener('click', function () {
                                    const index = parseInt(this.getAttribute('data-index'));

                                    // Bỏ mặc định tất cả địa chỉ
                                    savedAddresses.forEach(addr => addr.isDefault = false);

                                    // Đặt địa chỉ được chọn làm mặc định
                                    savedAddresses[index].isDefault = true;
                                    localStorage.setItem('userAddresses', JSON.stringify(savedAddresses));

                                    // Cập nhật giao diện hiển thị địa chỉ
                                    updateDisplayedAddress(savedAddresses[index]);

                                    // THÊM MỚI: Lưu địa chỉ mặc định vào selectedAddress để đảm bảo được sử dụng
                                    localStorage.setItem('selectedAddress', JSON.stringify(savedAddresses[index]));
                                    console.log('Saved default address to selectedAddress:', savedAddresses[index]);

                                    // THÊM MỚI: Đồng bộ trực tiếp với GHN API sau khi đặt địa chỉ mặc định
                                    if (typeof window.ghnState !== 'undefined' && savedAddresses[index].provinceId &&
                                        savedAddresses[index].districtId && savedAddresses[index].wardCode) {
                                        // Cập nhật trực tiếp ghnState
                                        window.ghnState.selectedToProvince = parseInt(savedAddresses[index].provinceId);
                                        window.ghnState.selectedToDistrict = parseInt(savedAddresses[index].districtId);
                                        window.ghnState.selectedToWard = savedAddresses[index].wardCode;

                                        console.log('Updated GHN state with default address data:', {
                                            province: window.ghnState.selectedToProvince,
                                            district: window.ghnState.selectedToDistrict,
                                            ward: window.ghnState.selectedToWard
                                        });

                                        // Tính phí vận chuyển nếu được hiển thị
                                        if (typeof calculateShippingFee === 'function') {
                                            // Đặt timeout để đảm bảo các giá trị đã được cập nhật
                                            setTimeout(() => {
                                                calculateShippingFee().then(() => {
                                                    console.log('Shipping fee calculation completed after setting default address');

                                                    // Hiển thị kết quả
                                                    const shippingFeeResult = document.getElementById('shipping-fee-result');
                                                    if (shippingFeeResult) {
                                                        shippingFeeResult.style.display = 'block';
                                                    }
                                                }).catch(err => {
                                                    console.error('Error calculating shipping fee after setting default address:', err);
                                                });
                                            }, 500);
                                        }
                                    }

                                    // Cập nhật modal
                                    updateAddressModal();

                                    // Thông báo thành công
                                    alert('Đã đặt địa chỉ mặc định thành công!');
                                });
                            });
                        }

                        // Sự kiện hiển thị modal địa chỉ
                        const changeAddressBtn = document.getElementById('change-address-btn');
                        if (changeAddressBtn) {
                            changeAddressBtn.addEventListener('click', function () {
                                updateAddressModal();
                                document.getElementById('address-modal').style.display = 'flex';
                                // Khi hiển thị modal, ngăn body scroll để tránh xung đột
                                document.body.style.overflow = 'hidden';
                            });
                        }

                        // Sự kiện đóng modal
                        const closeModalBtn = document.getElementById('close-modal');
                        const cancelAddressBtn = document.getElementById('cancel-address');

                        if (closeModalBtn) {
                            closeModalBtn.addEventListener('click', function () {
                                document.getElementById('address-modal').style.display = 'none';
                                // Đảm bảo body có thể scroll lại sau khi đóng modal
                                document.body.style.overflow = 'auto'; // Re-enable scrolling
                            });
                        }

                        if (cancelAddressBtn) {
                            cancelAddressBtn.addEventListener('click', function () {
                                document.getElementById('address-modal').style.display = 'none';
                                // Đảm bảo body có thể scroll lại sau khi đóng modal
                                document.body.style.overflow = 'auto';
                            });
                        }

                        // Sự kiện xác nhận địa chỉ từ modal
                        const confirmAddressBtn = document.getElementById('confirm-address');
                        if (confirmAddressBtn) {
                            confirmAddressBtn.addEventListener('click', function () {
                                // Tìm địa chỉ được chọn (có class border-orange-500)
                                const selectedAddressElement = document.querySelector('#address-modal .border-orange-500');
                                if (selectedAddressElement) {
                                    const addressId = selectedAddressElement.getAttribute('data-address-id');
                                    const selectedAddress = savedAddresses.find(addr => addr.id === addressId);

                                    if (selectedAddress) {
                                        // Set the selected address as default in the array
                                        savedAddresses.forEach(address => {
                                            address.isDefault = (address.id === addressId);
                                        });

                                        // Save updated addresses to localStorage
                                        localStorage.setItem('userAddresses', JSON.stringify(savedAddresses));

                                        // Update the displayed address
                                        updateDisplayedAddress(selectedAddress);

                                        // Save the selected address separately to ensure it's used
                                        localStorage.setItem('selectedAddress', JSON.stringify(selectedAddress));

                                        console.log('Updated default addressVV:', selectedAddress);

                                        // THÊM MỚI: Đồng bộ trực tiếp với GHN API sau khi chọn địa chỉ
                                        // Lưu ý: updateDisplayedAddress đã gọi syncAddressWithGHNApi phía trên
                                        // Tuy nhiên, thêm phần này để đảm bảo đồng bộ rõ ràng và dự phòng
                                        console.log('Explicitly syncing selected address with GHN API...');
                                        if (typeof window.ghnState !== 'undefined') {
                                            // Cập nhật trực tiếp ghnState
                                            window.ghnState.selectedToProvince = parseInt(selectedAddress.provinceId);
                                            window.ghnState.selectedToDistrict = parseInt(selectedAddress.districtId);
                                            window.ghnState.selectedToWard = selectedAddress.wardCode;

                                            // Nếu shipping-form đang hiển thị, cập nhật các dropdown
                                            const shippingForm = document.getElementById('shipping-form');
                                            if (shippingForm && shippingForm.style.display !== 'none') {
                                                // Đợi một chút để đảm bảo các dropdown đã được cập nhật
                                                setTimeout(() => {
                                                    // Gọi tính phí vận chuyển
                                                    if (typeof calculateShippingFee === 'function') {
                                                        calculateShippingFee().then(() => {
                                                            console.log('Shipping fee calculation completed after address selection');

                                                            // Hiển thị kết quả
                                                            const shippingFeeResult = document.getElementById('shipping-fee-result');
                                                            if (shippingFeeResult) {
                                                                shippingFeeResult.style.display = 'block';
                                                            }
                                                        }).catch(err => {
                                                            console.error('Error calculating shipping fee after address selection:', err);
                                                        });
                                                    }
                                                }, 500);
                                            }
                                        }
                                    }
                                }

                                document.getElementById('address-modal').style.display = 'none';
                                // Đảm bảo body có thể scroll lại sau khi đóng modal
                                document.body.style.overflow = 'auto';
                            });
                        }

                        // Khởi tạo: hiển thị địa chỉ mặc định từ model hoặc từ localStorage
                        if ('${defaultAddress.name}' && '${defaultAddress.phone}' && '${defaultAddress.fullAddress}') {
                            const recipientName = document.getElementById('recipient-name');
                            const recipientPhone = document.getElementById('recipient-phone');
                            const recipientAddress = document.getElementById('recipient-address');

                            if (recipientName) recipientName.textContent = '${defaultAddress.name}';
                            if (recipientPhone) recipientPhone.textContent = '${defaultAddress.phone}';
                            if (recipientAddress) recipientAddress.textContent = '${defaultAddress.fullAddress}';
                        } else {
                            // Không có địa chỉ từ model, thử tìm địa chỉ mặc định từ localStorage
                            const defaultAddress = savedAddresses.find(addr => addr.isDefault);
                            if (defaultAddress) {
                                updateDisplayedAddress(defaultAddress);
                            }
                        }
                    });
                </script>

            </body>

            </html>