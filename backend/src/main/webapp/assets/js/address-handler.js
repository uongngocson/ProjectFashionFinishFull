// /**
//  * Address Selection Handler
//  * Manages province, district, ward selection for delivery addresses
//  */

// document.addEventListener('DOMContentLoaded', function () {
//     // DOM elements
//     const provinceSelect = document.getElementById('toProvince');
//     const districtSelect = document.getElementById('toDistrict');
//     const wardSelect = document.getElementById('toWard');
//     const detailAddressInput = document.getElementById('detailAddress');

//     // GHN API constants
//     const GHN_API_BASE = 'https://online-gateway.ghn.vn/shiip/public-api';
//     const GHN_TOKEN = 'a00c1fc5-2454-11f0-8c8d-faf19a0e6e5b';

//     // Console log for debugging
//     console.log("Address handler script loaded");

//     // Load provinces on page load
//     loadProvinces();

//     // Event listeners
//     provinceSelect.addEventListener('change', handleProvinceChange);
//     districtSelect.addEventListener('change', handleDistrictChange);

//     // Add event listeners to log address data when changed
//     provinceSelect.addEventListener('change', logAddressData);
//     districtSelect.addEventListener('change', logAddressData);
//     wardSelect.addEventListener('change', logAddressData);
//     detailAddressInput.addEventListener('input', logAddressData);

//     // Add test button to manually trigger the address logging
//     const calculateBtn = document.getElementById('calculateShippingBtn');
//     if (calculateBtn) {
//         calculateBtn.addEventListener('click', function () {
//             console.log('=== DELIVERY ADDRESS DATA ===');
//             console.log(getFullAddress());
//             console.log('============================');
//         });
//     }

//     // Add event listener for the address check button
//     const logAddressBtn = document.getElementById('logAddressBtn');
//     if (logAddressBtn) {
//         logAddressBtn.addEventListener('click', function () {
//             const addressData = getFullAddress();
//             console.log('=== DELIVERY ADDRESS DATA ===');
//             console.log(JSON.stringify(addressData, null, 2));
//             console.log('============================');

//             // Show alert with full address for visibility
//             alert('Địa chỉ: ' + addressData.fullAddress + '\n(Chi tiết đã được ghi vào console)');
//         });
//     }

//     // Function to log address data
//     function logAddressData() {
//         // Only log if at least province is selected
//         if (provinceSelect.value) {
//             console.log('Current delivery address:', getFullAddress());
//         }
//     }

//     /**
//      * Loads all provinces/cities and populates the province select element
//      */
//     async function loadProvinces() {
//         try {
//             console.log("Fetching provinces...");
//             const response = await fetch(`${GHN_API_BASE}/master-data/province`, {
//                 headers: {
//                     'Token': GHN_TOKEN
//                 }
//             });

//             if (!response.ok) throw new Error('Failed to fetch provinces');

//             const responseData = await response.json();

//             if (responseData.code !== 200) {
//                 throw new Error(responseData.message || 'Failed to fetch provinces');
//             }

//             const provinces = responseData.data || [];
//             console.log(`Fetched ${provinces.length} provinces`);

//             // Clear existing options except the placeholder
//             clearOptions(provinceSelect, true);

//             // Add province options
//             provinces.forEach(province => {
//                 const option = document.createElement('option');
//                 option.value = province.ProvinceID;
//                 option.textContent = province.ProvinceName;
//                 provinceSelect.appendChild(option);
//             });
//         } catch (error) {
//             console.error('Error loading provinces:', error);
//             showError(provinceSelect, 'Không thể tải danh sách tỉnh/thành phố');
//         }
//     }

//     /**
//      * Handles province selection change
//      */
//     async function handleProvinceChange() {
//         const provinceId = provinceSelect.value;

//         // Reset dependent fields
//         clearOptions(districtSelect);
//         clearOptions(wardSelect);
//         districtSelect.disabled = !provinceId;
//         wardSelect.disabled = true;

//         if (!provinceId) return;

//         try {
//             // Update district select status
//             const firstOption = districtSelect.querySelector('option');
//             firstOption.textContent = 'Đang tải...';

//             // Fetch districts for selected province
//             console.log(`Fetching districts for province ID: ${provinceId}`);
//             const response = await fetch(`${GHN_API_BASE}/master-data/district`, {
//                 headers: {
//                     'Token': GHN_TOKEN
//                 }
//             });

//             if (!response.ok) throw new Error('Failed to fetch districts');

//             const responseData = await response.json();

//             if (responseData.code !== 200) {
//                 throw new Error(responseData.message || 'Failed to fetch districts');
//             }

//             // Filter districts for selected province
//             const allDistricts = responseData.data || [];
//             const districts = allDistricts.filter(district => district.ProvinceID == provinceId);

//             console.log(`Fetched ${districts.length} districts for province ${provinceId}`);

//             // Clear and populate district options
//             clearOptions(districtSelect, true);
//             firstOption.textContent = 'Chọn Quận/Huyện';

//             districts.forEach(district => {
//                 const option = document.createElement('option');
//                 option.value = district.DistrictID;
//                 option.textContent = district.DistrictName;
//                 districtSelect.appendChild(option);
//             });

//             districtSelect.disabled = false;
//         } catch (error) {
//             console.error('Error loading districts:', error);
//             showError(districtSelect, 'Không thể tải danh sách quận/huyện');
//         }
//     }

//     /**
//      * Handles district selection change
//      */
//     async function handleDistrictChange() {
//         const districtId = districtSelect.value;

//         // Reset ward field
//         clearOptions(wardSelect);
//         wardSelect.disabled = !districtId;

//         if (!districtId) return;

//         try {
//             // Update ward select status
//             const firstOption = wardSelect.querySelector('option');
//             firstOption.textContent = 'Đang tải...';

//             // Fetch wards for selected district
//             console.log(`Fetching wards for district ID: ${districtId}`);
//             const response = await fetch(`${GHN_API_BASE}/master-data/ward?district_id=${districtId}`, {
//                 headers: {
//                     'Token': GHN_TOKEN
//                 }
//             });

//             if (!response.ok) throw new Error('Failed to fetch wards');

//             const responseData = await response.json();

//             if (responseData.code !== 200) {
//                 throw new Error(responseData.message || 'Failed to fetch wards');
//             }

//             const wards = responseData.data || [];
//             console.log(`Fetched ${wards.length} wards for district ${districtId}`);

//             // Clear and populate ward options
//             clearOptions(wardSelect, true);
//             firstOption.textContent = 'Chọn Phường/Xã';

//             wards.forEach(ward => {
//                 const option = document.createElement('option');
//                 option.value = ward.WardCode;
//                 option.textContent = ward.WardName;
//                 wardSelect.appendChild(option);
//             });

//             wardSelect.disabled = false;
//         } catch (error) {
//             console.error('Error loading wards:', error);
//             showError(wardSelect, 'Không thể tải danh sách phường/xã');
//         }
//     }

//     /**
//      * Clears options from a select element
//      * @param {HTMLSelectElement} selectElement - The select element to clear
//      * @param {boolean} keepFirst - Whether to keep the first option
//      */
//     function clearOptions(selectElement, keepFirst = false) {
//         if (!selectElement) return;

//         // Recreate the select element with just the first option if needed
//         if (keepFirst && selectElement.options.length > 0) {
//             const firstOption = selectElement.options[0];
//             selectElement.innerHTML = '';
//             selectElement.appendChild(firstOption);
//         } else {
//             selectElement.innerHTML = '';
//         }
//     }

//     /**
//      * Displays an error message in a select element
//      * @param {HTMLSelectElement} selectElement - The select element
//      * @param {string} message - Error message to display
//      */
//     function showError(selectElement, message) {
//         clearOptions(selectElement, true);
//         const firstOption = selectElement.querySelector('option');
//         if (firstOption) {
//             firstOption.textContent = message;
//         } else {
//             const option = document.createElement('option');
//             option.textContent = message;
//             selectElement.appendChild(option);
//         }
//         selectElement.disabled = true;

//         // Log error to console
//         console.error(message);
//     }

//     /**
//      * Gets the complete address from form fields
//      * @returns {Object} Address object with all components
//      */
//     function getFullAddress() {
//         const provinceText = provinceSelect.options[provinceSelect.selectedIndex]?.textContent || '';
//         const districtText = districtSelect.options[districtSelect.selectedIndex]?.textContent || '';
//         const wardText = wardSelect.options[wardSelect.selectedIndex]?.textContent || '';
//         const detailText = detailAddressInput.value.trim();

//         // Return a simplified address object for testing
//         return {
//             provinceId: provinceSelect.value,
//             districtId: districtSelect.value,
//             wardId: wardSelect.value,
//             detailAddress: detailText,
//             addressComponents: {
//                 province: provinceText,
//                 district: districtText,
//                 ward: wardText,
//                 street: detailText
//             },
//             fullAddress: [detailText, wardText, districtText, provinceText]
//                 .filter(Boolean).join(', ')
//         };
//     }

//     // Expose the getFullAddress function globally if needed
//     window.getDeliveryAddress = getFullAddress;
// });