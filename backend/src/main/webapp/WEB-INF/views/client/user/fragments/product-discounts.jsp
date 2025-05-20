<%@page contentType="text/html" pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!-- Product Discounts Fragment -->
        <div id="discountsList">
            <!-- Hidden JSON data for JavaScript use if needed -->
            <input type="hidden" id="discounts-data" value='<c:out value="${discountsJson}" />' />

            <!-- Discount list container -->
            <div class="py-3 px-4 border-b border-gray-100">
                <h4 class="text-sm font-medium">Mã giảm giá có sẵn</h4>
                <p class="text-xs text-gray-500 mt-1">Chọn mã giảm giá phù hợp cho đơn hàng của bạn</p>
            </div>

            <div class="max-h-[250px] overflow-y-auto">
                <c:choose>
                    <c:when test="${empty discounts}">
                        <div class="p-4 text-center text-gray-500">Không có mã giảm giá khả dụng.</div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${discounts}" var="discount">
                            <div class="flex items-center p-3 border-b border-gray-100 hover:bg-gray-50">
                                <div class="w-10 h-10 flex-shrink-0 mr-3">
                                    <img src="${pageContext.request.contextPath}/resources/assets/client/images/logo-audio365.png"
                                        alt="Shop Logo" class="w-full h-full object-contain">
                                </div>
                                <div class="flex-grow">
                                    <p class="text-sm font-medium">
                                        <c:choose>
                                            <c:when test="${not empty discount.discount_percentage}">
                                                ${discount.discount_percentage}%
                                            </c:when>
                                            <c:otherwise>
                                                ${discount.discount_amount}₫
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                    <p class="text-sm font-medium">${discount.discount_code}</p>
                                    <p class="text-xs text-gray-500">${discount.discount_name}</p>

                                    <c:if test="${not empty discount.min_order_value}">
                                        <p class="text-xs text-gray-500">Đơn tối thiểu: ${discount.min_order_value}₫</p>
                                    </c:if>

                                    <c:if test="${not empty discount.max_discount_amount}">
                                        <p class="text-xs text-gray-500">Tối đa: ${discount.max_discount_amount}₫</p>
                                    </c:if>
                                </div>
                                <button
                                    class="apply-discount-btn bg-black text-white px-3 py-1 text-xs rounded hover:bg-gray-800"
                                    data-code="${discount.discount_code}">
                                    Áp dụng
                                </button>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Error message if any -->
            <c:if test="${not empty error}">
                <div class="p-4 text-center text-red-500">${error}</div>
            </c:if>
        </div>

        <!-- Pills Container for Discount Codes (outside the fragment) -->
        <div id="discount-pills-container">
            <c:if test="${not empty discounts}">
                <c:forEach items="${discounts}" var="discount">
                    <div class="inline-block mr-2 mb-2">
                        <button
                            class="discount-pill bg-blue-50 hover:bg-blue-100 text-blue-600 rounded-full px-3 py-1 text-xs"
                            data-code="${discount.discount_code}" data-id="${discount.discount_id}">
                            ${discount.discount_code}
                        </button>
                    </div>
                </c:forEach>
            </c:if>
        </div>