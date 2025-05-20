// (function ($) {
//     "use strict";
//     $('.quantity button').on('click', function () {
//         let change = 0;

//         var button = $(this);
//         var oldValue = button.parent().parent().find('input').val();
//         if (button.hasClass('btn-plus')) {
//             var newVal = parseFloat(oldValue) + 1;
//             change = 1;
//         } else {
//             if (oldValue > 1) {
//                 var newVal = parseFloat(oldValue) - 1;
//                 change = -1;
//             } else {
//                 newVal = 1;
//             }
//         }
//         const input = button.parent().parent().find('input');
//         input.val(newVal);

//         //set form index
//         const index = input.attr("data-cart-detail-index")
//         const el = document.getElementById(`cartDetails${index}.quantity`);
//         $(el).val(newVal);



//         //get price
//         const price = input.attr("data-cart-detail-price");
//         const id = input.attr("data-cart-detail-id");

//         const priceElement = $(`p[data-cart-detail-id='${id}']`);
//         if (priceElement) {
//             const newPrice = +price * newVal;
//             priceElement.text(formatCurrency(newPrice.toFixed(2)) + " đ");
//         }

//         //update total cart price
//         const totalPriceElement = $(`p[data-cart-total-price]`);

//         if (totalPriceElement && totalPriceElement.length) {
//             const currentTotal = totalPriceElement.first().attr("data-cart-total-price");
//             let newTotal = +currentTotal;
//             if (change === 0) {
//                 newTotal = +currentTotal;
//             } else {
//                 newTotal = change * (+price) + (+currentTotal);
//             }

//             //reset change
//             change = 0;

//             //update
//             totalPriceElement?.each(function (index, element) {
//                 //update text
//                 $(totalPriceElement[index]).text(formatCurrency(newTotal.toFixed(2)) + " đ");

//                 //update data-attribute
//                 $(totalPriceElement[index]).attr("data-cart-total-price", newTotal);
//             });
//         }
//     });

//     function formatCurrency(value) {
//         // Use the 'vi-VN' locale to format the number according to Vietnamese currency format
//         // and 'VND' as the currency type for Vietnamese đồng
//         const formatter = new Intl.NumberFormat('vi-VN', {
//             style: 'decimal',
//             minimumFractionDigits: 0, // No decimal part for whole numbers
//         });

//         let formatted = formatter.format(value);
//         // Replace dots with commas for thousands separator
//         formatted = formatted.replace(/\./g, ',');
//         return formatted;
//     }

//     //handle filter products
//     $('#btnFilter').click(function (event) {
//         event.preventDefault();

//         let factoryArr = [];
//         let targetArr = [];
//         let priceArr = [];
//         //factory filter
//         $("#factoryFilter .form-check-input:checked").each(function () {
//             factoryArr.push($(this).val());
//         });

//         //target filter
//         $("#targetFilter .form-check-input:checked").each(function () {
//             targetArr.push($(this).val());
//         });

//         //price filter
//         $("#priceFilter .form-check-input:checked").each(function () {
//             priceArr.push($(this).val());
//         });

//         //sort order
//         let sortValue = $('input[name="radio-sort"]:checked').val();

//         const currentUrl = new URL(window.location.href);
//         const searchParams = currentUrl.searchParams;

//         // Add or update query parameters
//         searchParams.set('page', '1');
//         searchParams.set('sort', sortValue);

//         //reset
//         searchParams.delete('factory');
//         searchParams.delete('target');
//         searchParams.delete('price');

//         if (factoryArr.length > 0) {
//             searchParams.set('factory', factoryArr.join(','));
//         }

//         if (targetArr.length > 0) {
//             searchParams.set('target', targetArr.join(','));
//         }

//         if (priceArr.length > 0) {
//             searchParams.set('price', priceArr.join(','));
//         }

//         // Update the URL and reload the page
//         window.location.href = currentUrl.toString();
//     });

//     //handle auto checkbox after page loading
//     // Parse the URL parameters
//     const params = new URLSearchParams(window.location.search);

//     // Set checkboxes for 'factory'
//     if (params.has('factory')) {
//         const factories = params.get('factory').split(',');
//         factories.forEach(factory => {
//             $(`#factoryFilter .form-check-input[value="${factory}"]`).prop('checked', true);
//         });
//     }

//     // Set checkboxes for 'target'
//     if (params.has('target')) {
//         const targets = params.get('target').split(',');
//         targets.forEach(target => {
//             $(`#targetFilter .form-check-input[value="${target}"]`).prop('checked', true);
//         });
//     }

//     // Set checkboxes for 'price'
//     if (params.has('price')) {
//         const prices = params.get('price').split(',');
//         prices.forEach(price => {
//             $(`#priceFilter .form-check-input[value="${price}"]`).prop('checked', true);
//         });
//     }

//     // Set radio buttons for 'sort'
//     if (params.has('sort')) {
//         const sort = params.get('sort');
//         $(`input[type="radio"][name="radio-sort"][value="${sort}"]`).prop('checked', true);
//     }


//     //////////////////////////
//     //handle add to cart with ajax
//     $('.btnAddToCartHomepage').click(function (event) {
//         event.preventDefault();

//         if (!isLogin()) {
//             $.toast({
//                 heading: 'Lỗi thao tác',
//                 text: 'Bạn cần đăng nhập tài khoản',
//                 position: 'top-right',
//                 icon: 'error'
//             })
//             return;
//         }

//         const productId = $(this).attr('data-product-id');
//         const token = $("meta[name='_csrf']").attr("content");
//         const header = $("meta[name='_csrf_header']").attr("content");

//         $.ajax({
//             url: `${window.location.origin}/api/add-product-to-cart`,
//             beforeSend: function (xhr) {
//                 xhr.setRequestHeader(header, token);
//             },
//             type: "POST",
//             data: JSON.stringify({ quantity: 1, productId: productId }),
//             contentType: "application/json",

//             success: function (response) {
//                 const sum = +response;
//                 //update cart
//                 $("#sumCart").text(sum)
//                 //show message
//                 $.toast({
//                     heading: 'Giỏ hàng',
//                     text: 'Thêm sản phẩm vào giỏ hàng thành công',
//                     position: 'top-right',

//                 })

//             },
//             error: function (response) {
//                 alert("có lỗi xảy ra, check code đi ba :v")
//                 console.log("error: ", response);
//             }

//         });
//     });

//     $('.btnAddToCartDetail').click(function (event) {
//         event.preventDefault();
//         if (!isLogin()) {
//             $.toast({
//                 heading: 'Lỗi thao tác',
//                 text: 'Bạn cần đăng nhập tài khoản',
//                 position: 'top-right',
//                 icon: 'error'
//             })
//             return;
//         }

//         const productId = $(this).attr('data-product-id');
//         const token = $("meta[name='_csrf']").attr("content");
//         const header = $("meta[name='_csrf_header']").attr("content");
//         const quantity = $("#cartDetails0\\.quantity").val();
//         $.ajax({
//             url: `${window.location.origin}/api/add-product-to-cart`,
//             beforeSend: function (xhr) {
//                 xhr.setRequestHeader(header, token);
//             },
//             type: "POST",
//             data: JSON.stringify({ quantity: quantity, productId: productId }),
//             contentType: "application/json",

//             success: function (response) {
//                 const sum = +response;
//                 //update cart
//                 $("#sumCart").text(sum)
//                 //show message
//                 $.toast({
//                     heading: 'Giỏ hàng',
//                     text: 'Thêm sản phẩm vào giỏ hàng thành công',
//                     position: 'top-right',

//                 })

//             },
//             error: function (response) {
//                 alert("có lỗi xảy ra, check code đi ba :v")
//                 console.log("error: ", response);
//             }

//         });
//     });

//     function isLogin() {
//         const navElement = $("#navbarCollapse");
//         const childLogin = navElement.find('a.a-login');
//         if (childLogin.length > 0) {
//             return false;
//         }
//         return true;
//     }

// })(jQuery);

