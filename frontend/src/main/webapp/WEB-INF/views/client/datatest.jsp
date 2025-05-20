<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>GHN Shipping Integration</title>
                    <!-- Tailwind CSS CDN -->
                    <script src="https://cdn.tailwindcss.com"></script>
                    <!-- Lucide Icons (untuk ikon Bot, User, Send) -->
                    <script src="https://unpkg.com/lucide/dist/umd/lucide.min.js"></script>
                    <!-- Axios for API calls -->
                    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
                    <style>
                        /* Custom styles to ensure proper text color in select elements */
                        select {
                            background-color: white !important;
                            color: black !important;
                        }

                        select option {
                            background-color: white !important;
                            color: black !important;
                        }

                        /* Fix for selected options */
                        select option:checked,
                        select option:hover,
                        select option:focus {
                            background-color: #edf2f7 !important;
                            color: black !important;
                        }
                    </style>
                    <script>
                        document.addEventListener('DOMContentLoaded', () => {
                            lucide.createIcons();

                            // GHN API constants
                            const GHN_API_BASE = 'https://online-gateway.ghn.vn/shiip/public-api/v2';
                            const GHN_TOKEN = 'a00c1fc5-2454-11f0-8c8d-faf19a0e6e5b'; // Add your token here
                            const SHOP_ID = '5754757'; // Add your shop ID here

                            // App state
                            let state = {
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
                                    weight: 1000,
                                    length: 20,
                                    width: 15,
                                    height: 15,
                                    insurance_value: 500000,
                                },
                                shippingFee: null,
                                orderForm: {
                                    payment_type_id: 2,
                                    note: "Giao hàng trong giờ hành chính",
                                    required_note: "KHONGCHOXEMHANG",
                                    return_phone: "",
                                    return_address: "",
                                    return_district_id: 0,
                                    return_ward_code: "",
                                    client_order_code: `DH\${Date.now()}`,
                                    to_name: "",
                                    to_phone: "",
                                    to_address: "",
                                    to_ward_code: "",
                                    to_district_id: 0,
                                    cod_amount: 0,
                                    content: "Đơn hàng",
                                    weight: 1000,
                                    length: 20,
                                    width: 15,
                                    height: 15,
                                    service_id: 0,
                                    service_type_id: 2,
                                    items: [
                                        {
                                            name: "Sản phẩm",
                                            code: "SP001",
                                            quantity: 1,
                                            price: 500000,
                                            length: 20,
                                            width: 15,
                                            height: 15,
                                            weight: 1000
                                        }
                                    ]
                                },
                                orderResult: null,
                                orderCode: "",
                                orderDetail: null
                            };

                            // DOM Elements
                            const errorContainer = document.getElementById('error-container');
                            const loadingContainer = document.getElementById('loading-container');
                            const shippingFeeResult = document.getElementById('shipping-fee-result');
                            const orderDetailContainer = document.getElementById('order-detail-container');

                            // Helper to set loading state
                            function setLoading(isLoading) {
                                state.loading = isLoading;
                                loadingContainer.style.display = isLoading ? 'block' : 'none';
                            }

                            // Helper to set error
                            function setError(message) {
                                state.error = message;
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
                                    const response = await axios.get('https://online-gateway.ghn.vn/shiip/public-api/master-data/province', {
                                        headers: {
                                            Token: GHN_TOKEN
                                        }
                                    });

                                    if (response.data.code === 200) {
                                        state.provinces = response.data.data;

                                        // Find Ho Chi Minh City in the response data
                                        const hcmCity = state.provinces.find(p =>
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
                                            state.selectedFromProvince = hcmCity.ProvinceID;

                                            // Fetch districts for HCM
                                            fetchDistricts(hcmCity.ProvinceID, true);
                                        }

                                        // Update toProvince as normal
                                        updateSelectOptions('toProvince', state.provinces, 'ProvinceID', 'ProvinceName');
                                    } else {
                                        setError(`Error fetching provinces: \${response.data.message}`);
                                    }
                                } catch (err) {
                                    setError(`Error fetching provinces: \${err.message}`);
                                } finally {
                                    setLoading(false);
                                }
                            }

                            // Fetch districts
                            async function fetchDistricts(provinceId, isFrom = true) {
                                setLoading(true);
                                setError(null);
                                try {
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
                                                state.selectedFromDistrict = goVapDistrict.DistrictID;

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
                                        }
                                    } else {
                                        setError(`Error fetching districts: \${response.data.message}`);
                                    }
                                } catch (err) {
                                    setError(`Error fetching districts: \${err.message}`);
                                } finally {
                                    setLoading(false);
                                }
                            }

                            // Fetch wards
                            async function fetchWards(districtId, isFrom = true) {
                                setLoading(true);
                                setError(null);
                                try {
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
                                                opt.textContent = "F17";
                                                opt.selected = true;
                                                select.appendChild(opt);

                                                // Save the selected ward
                                                state.selectedFromWard = ward17.WardCode;
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
                                        }
                                    } else {
                                        setError(`Error fetching wards: \${response.data.message}`);
                                    }
                                } catch (err) {
                                    setError(`Error fetching wards: \${err.message}`);
                                } finally {
                                    setLoading(false);
                                }
                            }

                            // Fetch services
                            async function fetchServices(fromDistrictId, toDistrictId) {
                                setLoading(true);
                                setError(null);
                                try {
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

                                    if (response.data.code === 200) {
                                        state.services = response.data.data;
                                        // Look for a lightweight shipping option first
                                        let selectedService = null;

                                        // First try to find a service with "value" or similar in the name
                                        // Using optional chaining and null checks to prevent the toLowerCase error
                                        selectedService = state.services.find(s => {
                                            const serviceName = s.service_name || '';
                                            return serviceName.toLowerCase().includes('value') ||
                                                serviceName.toLowerCase().includes('tiết kiệm') ||
                                                serviceName.toLowerCase().includes('chuẩn');
                                        });

                                        // If no value service found, use the first available service
                                        if (!selectedService && state.services.length > 0) {
                                            selectedService = state.services[0];
                                        }

                                        if (selectedService) {
                                            console.log("Selected service:", selectedService.service_name);
                                            state.selectedService = selectedService.service_id;
                                            state.orderForm.service_id = selectedService.service_id;
                                            state.orderForm.service_type_id = selectedService.service_type_id;

                                            // Set default package details since we've removed the inputs
                                            state.packageDetails = {
                                                weight: 500,  // 500g - lightweight package
                                                length: 20,
                                                width: 15,
                                                height: 15,
                                                insurance_value: 500000
                                            };

                                            // Always calculate fee after selecting a service
                                            setTimeout(() => calculateShippingFee(), 200);
                                        }
                                    } else {
                                        setError(`Error fetching services: \${response.data.message}`);
                                    }
                                } catch (err) {
                                    setError(`Error fetching services: \${err.message}`);
                                } finally {
                                    setLoading(false);
                                }
                            }

                            // Calculate shipping fee
                            async function calculateShippingFee() {
                                if (!state.selectedFromDistrict) {
                                    setError("Vui lòng chọn đầy đủ thông tin địa chỉ");
                                    return;
                                }
                                if (!state.selectedToDistrict) {
                                    setError("Vui lòng chọn đầy đủ thông tin địa chỉ");
                                    return;
                                }
                                if (!state.selectedToWard) {
                                    setError("Vui lòng chọn đầy đủ thông tin địa chỉ");
                                    return;
                                }
                                if (!state.selectedService) {
                                    setError("Vui lòng chọn đầy đủ thông tin dịch vụ");
                                    return;
                                }

                                setLoading(true);
                                setError(null);

                                // Use the default package details
                                const payload = {
                                    from_district_id: parseInt(state.selectedFromDistrict),
                                    service_id: parseInt(state.selectedService),
                                    to_district_id: parseInt(state.selectedToDistrict),
                                    to_ward_code: state.selectedToWard,
                                    height: parseInt(state.packageDetails.height),
                                    length: parseInt(state.packageDetails.length),
                                    weight: parseInt(state.packageDetails.weight),
                                    width: parseInt(state.packageDetails.width),
                                    insurance_value: parseInt(state.packageDetails.insurance_value),
                                    coupon: null
                                };

                                try {
                                    console.log("Calculating shipping fee with payload:", payload);
                                    const response = await axios.post('https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee', payload, {
                                        headers: {
                                            Token: GHN_TOKEN,
                                            ShopId: parseInt(SHOP_ID),
                                            'Content-Type': 'application/json'
                                        }
                                    });

                                    if (response.data.code === 200) {
                                        state.shippingFee = response.data.data.total;
                                        const selectedServiceName = state.services.find(s => s.service_id === state.selectedService)?.service_name || 'Standard';
                                        shippingFeeResult.innerHTML = `
                                            <p class="font-semibold text-black">Phí vận chuyển: <span class="text-black">\${state.shippingFee.toLocaleString()} VND</span></p>
                                            <p class="text-sm text-gray-600">Dịch vụ: \${selectedServiceName}</p>
                                            <p class="text-sm text-gray-600">Gói hàng: 500g, 20×15×15 cm</p>
                                        `;
                                        shippingFeeResult.style.display = 'block';
                                    } else {
                                        setError(`Lỗi tính phí vận chuyển: \${response.data.message}`);
                                    }
                                } catch (err) {
                                    setError(`Lỗi tính phí vận chuyển: \${err.response && err.response.data && err.response.data.message ? err.response.data.message : err.message}`);
                                } finally {
                                    setLoading(false);
                                }
                            }

                            // Create order
                            async function createOrder() {
                                console.log("Order creation is disabled");
                            }

                            // Get order detail
                            async function getOrderDetail() {
                                console.log("Order lookup is disabled");
                            }

                            // Cancel order
                            async function cancelOrder() {
                                if (!state.orderCode) {
                                    setError("Please enter order code");
                                    return;
                                }

                                setLoading(true);
                                setError(null);

                                try {
                                    const response = await axios.post('https://online-gateway.ghn.vn/shiip/public-api/v2/switch-status/cancel', {
                                        order_codes: [state.orderCode]
                                    }, {
                                        headers: {
                                            Token: GHN_TOKEN,
                                            ShopId: SHOP_ID,
                                            'Content-Type': 'application/json'
                                        }
                                    });

                                    if (response.data.code === 200) {
                                        alert("Order cancelled successfully");
                                        state.orderDetail = null;
                                        orderDetailContainer.style.display = 'none';
                                    } else {
                                        setError(`Error cancelling order: \${response.data.message}`);
                                    }
                                } catch (err) {
                                    setError(`Error cancelling order: \${err.message}`);
                                } finally {
                                    setLoading(false);
                                }
                            }

                            // Event Listeners for form inputs
                            document.getElementById('fromProvince').addEventListener('change', function (e) {
                                state.selectedFromProvince = e.target.value;
                                if (state.selectedFromProvince) {
                                    fetchDistricts(state.selectedFromProvince, true);
                                    document.getElementById('fromDistrict').disabled = false;
                                } else {
                                    document.getElementById('fromDistrict').disabled = true;
                                    document.getElementById('fromWard').disabled = true;
                                }
                            });

                            document.getElementById('fromDistrict').addEventListener('change', function (e) {
                                state.selectedFromDistrict = e.target.value;
                                if (state.selectedFromDistrict) {
                                    fetchWards(state.selectedFromDistrict, true);
                                    document.getElementById('fromWard').disabled = false;

                                    if (state.selectedToDistrict) {
                                        fetchServices(state.selectedFromDistrict, state.selectedToDistrict);
                                    }
                                } else {
                                    document.getElementById('fromWard').disabled = true;
                                }
                            });

                            document.getElementById('fromWard').addEventListener('change', function (e) {
                                state.selectedFromWard = e.target.value;
                            });

                            document.getElementById('toProvince').addEventListener('change', function (e) {
                                state.selectedToProvince = e.target.value;
                                if (state.selectedToProvince) {
                                    fetchDistricts(state.selectedToProvince, false);
                                    document.getElementById('toDistrict').disabled = false;
                                } else {
                                    document.getElementById('toDistrict').disabled = true;
                                    document.getElementById('toWard').disabled = true;
                                }
                            });

                            document.getElementById('toDistrict').addEventListener('change', function (e) {
                                state.selectedToDistrict = e.target.value;
                                state.orderForm.to_district_id = parseInt(e.target.value);
                                if (state.selectedToDistrict) {
                                    fetchWards(state.selectedToDistrict, false);
                                    document.getElementById('toWard').disabled = false;

                                    if (state.selectedFromDistrict) {
                                        fetchServices(state.selectedFromDistrict, state.selectedToDistrict);
                                    }
                                } else {
                                    document.getElementById('toWard').disabled = true;
                                }
                            });

                            document.getElementById('toWard').addEventListener('change', function (e) {
                                state.selectedToWard = e.target.value;
                                state.orderForm.to_ward_code = e.target.value;

                                // Try to calculate fee automatically
                                tryCalculateFeeAutomatically();
                            });

                            // Add event listeners for package details
                            document.querySelectorAll('.package-detail').forEach(input => {
                                input.addEventListener('change', function (e) {
                                    state.packageDetails[e.target.name] = parseInt(e.target.value);

                                    // Update order form as well
                                    if (['weight', 'length', 'width', 'height'].includes(e.target.name)) {
                                        state.orderForm[e.target.name] = parseInt(e.target.value);

                                        // Update item
                                        if (state.orderForm.items.length > 0) {
                                            state.orderForm.items[0][e.target.name] = parseInt(e.target.value);
                                        }
                                    }

                                    // Try to calculate fee automatically
                                    tryCalculateFeeAutomatically();
                                });
                            });

                            // Add event listeners for order form
                            document.querySelectorAll('.order-form-input').forEach(input => {
                                input.addEventListener('change', function (e) {
                                    const name = e.target.name;
                                    const value = e.target.value;

                                    // Check if it's a numeric field
                                    const numericFields = ['cod_amount', 'weight', 'length', 'width', 'height', 'payment_type_id', 'service_id', 'service_type_id', 'return_district_id', 'to_district_id'];

                                    state.orderForm[name] = numericFields.includes(name) ? parseInt(value) : value;
                                });
                            });

                            // Button event listeners
                            document.getElementById('calculateFeeBtn').addEventListener('click', calculateShippingFee);

                            // Initialize
                            fetchProvinces();

                            // Disable the sender address fields
                            setTimeout(() => {
                                document.getElementById('fromProvince').disabled = true;
                                document.getElementById('fromDistrict').disabled = true;
                                document.getElementById('fromWard').disabled = true;
                            }, 1500); // Add a delay to ensure the fields are populated first

                            // Function to try calculating fee automatically
                            async function tryCalculateFeeAutomatically() {
                                // Check if all required fields are available
                                if (!state.selectedFromDistrict) return;
                                if (!state.selectedToDistrict) return;
                                if (!state.selectedToWard) return;

                                // If we have a destination district and ward but no service yet,
                                // fetch services which will then trigger calculation
                                if (!state.selectedService) {
                                    if (state.selectedFromDistrict && state.selectedToDistrict) {
                                        fetchServices(state.selectedFromDistrict, state.selectedToDistrict);
                                        return;
                                    }
                                    return;
                                }

                                // Since all required data is available, calculate fee
                                await calculateShippingFee();
                            }
                        });
                    </script>
                </head>

                <body class="min-h-screen bg-gray-100 flex flex-col items-center justify-center p-4">
                    <div class="container mx-auto p-4">

                        <div id="error-container"
                            class="bg-red-100 border border-red-400 text-black px-4 py-3 rounded mb-4"
                            style="display: none;"></div>

                        <div id="loading-container"
                            class="bg-blue-100 border border-blue-400 text-black px-4 py-3 rounded mb-4"
                            style="display: none;">
                            Loading...
                        </div>

                        <div class="grid grid-cols-1 gap-6 md:w-1/2">
                            <div class="bg-white p-6 rounded-lg shadow-md">
                                <h2 class="text-xl font-semibold mb-4 text-black">1. Tính phí vận chuyển</h2>

                                <div class="mb-4">
                                    <h3 class="font-medium mb-2 text-black">Địa chỉ gửi hàng</h3>
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                        <div>
                                            <label class="block text-sm font-medium text-black mb-1">Tỉnh/Thành
                                                phố</label>
                                            <select id="fromProvince"
                                                class="w-full p-2 border rounded-md text-black bg-white">
                                                <option value="">Đang tải...</option>
                                            </select>
                                        </div>

                                        <div>
                                            <label class="block text-sm font-medium text-black mb-1">Quận/Huyện</label>
                                            <select id="fromDistrict"
                                                class="w-full p-2 border rounded-md text-black bg-white">
                                                <option value="">Đang tải...</option>
                                            </select>
                                        </div>

                                        <div>
                                            <label class="block text-sm font-medium text-black mb-1">Phường/Xã</label>
                                            <select id="fromWard"
                                                class="w-full p-2 border rounded-md text-black bg-white">
                                                <option value="">Đang tải...</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <h3 class="font-medium mb-2 text-black">Địa chỉ nhận hàng</h3>
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                        <div>
                                            <label class="block text-sm font-medium text-black mb-1">Tỉnh/Thành
                                                phố</label>
                                            <select id="toProvince"
                                                class="w-full p-2 border rounded-md text-black bg-white">
                                                <option value="">Chọn Tỉnh/TP</option>
                                            </select>
                                        </div>

                                        <div>
                                            <label class="block text-sm font-medium text-black mb-1">Quận/Huyện</label>
                                            <select id="toDistrict"
                                                class="w-full p-2 border rounded-md text-black bg-white" disabled>
                                                <option value="">Đang tải...</option>
                                            </select>
                                        </div>

                                        <div>
                                            <label class="block text-sm font-medium text-black mb-1">Phường/Xã</label>
                                            <select id="toWard" class="w-full p-2 border rounded-md text-black bg-white"
                                                disabled>
                                                <option value="">Đang tải...</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <button id="calculateFeeBtn"
                                    class="bg-blue-500 hover:bg-blue-600 text-white font-semibold py-2 px-4 rounded">
                                    Tính phí vận chuyển thủ công
                                </button>

                                <div id="shipping-fee-result" class="mt-4 p-4 bg-green-100 rounded-md"
                                    style="display: none;"></div>
                            </div>
                        </div>

                        <div class="mt-6 grid grid-cols-1 gap-6 md:w-1/2">
                            <div class="bg-white p-6 rounded-lg shadow-md">
                                <div id="order-detail-container" class="mt-4 p-4 bg-gray-100 rounded-md"
                                    style="display: none;"></div>
                            </div>
                        </div>

                    </div>
                </body>

                </html>