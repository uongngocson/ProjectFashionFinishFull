<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
                <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                    <!DOCTYPE html>
                    <html lang="en">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>DDTS |
                            <spring:message code="category.title" />
                        </title>
                        <c:set var="ctx" value="${pageContext.request.contextPath}" />
                        <script src="https://cdn.tailwindcss.com"></script>
                        <link rel="stylesheet"
                            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                        <link rel="stylesheet" href="${ctx}/resources/assets/client/css/category.css">



                        <style>
                            /* Thêm style cho dropdown item được chọn */
                            .dropdown-menu a.font-bold {
                                background-color: #f3f4f6;
                                /* Màu nền nhẹ để dễ nhận biết */
                            }
                        </style>
                    </head>

                    <body class="bg-white text-gray-900">

                        <!-- Sticky Navigation -->
                        <jsp:include page="../layout/navbar.jsp" />

                        <!-- Hero Banner -->
                        <section class="pt-24 pb-16 pt-[64px]">
                            <div class="max-w-7xl mx-auto px-6">
                                <div class="relative h-96 w-full bg-gray-50 flex items-center justify-center">
                                    <img src="${ctx}/resources/assets/client/images/image2.avif"
                                        alt="Women's Collection"
                                        class="absolute inset-0 w-full h-full object-cover opacity-90">
                                    <div class="relative text-center px-6">
                                        <h1 class="font-serif text-5xl md:text-6xl font-light mb-4">Women's Collection
                                        </h1>
                                        <p class="max-w-2xl mx-auto text-lg">Timeless pieces crafted for the modern
                                            woman</p>
                                    </div>
                                </div>
                            </div>
                        </section>

                        <!-- Filter and Sort Bar -->
                        <section class="py-6 border-b border-gray-100 pt-[64px]">
                            <div class="max-w-7xl mx-auto px-6">
                                <div
                                    class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
                                    <div class="text-sm">
                                        <%-- Tính toán và hiển thị số lượng sản phẩm --%>
                                            <c:set var="startItem" value="${(currentPage - 1) * pageSize + 1}" />
                                            <c:set var="endItem" value="${currentPage * pageSize}" />
                                            <c:if test="${endItem > totalElements}">
                                                <c:set var="endItem" value="${totalElements}" />
                                            </c:if>
                                            <c:if test="${totalElements == 0}">
                                                <c:set var="startItem" value="0" />
                                            </c:if>
                                            <spring:message code="category.showingProducts"
                                                arguments="${startItem},${endItem},${totalElements}" />
                                    </div>

                                    <div class="flex flex-wrap gap-3">
                                        <%-- Tạo URL cơ sở với các tham số hiện tại (trừ tham số của dropdown này) --%>
                                            <%-- Brand Dropdown --%>
                                                <c:url var="baseBrandUrl" value="/product/category">
                                                    <c:if test="${not empty selectedCategoryId}">
                                                        <c:param name="categoryId" value="${selectedCategoryId}" />
                                                    </c:if>
                                                    <c:if test="${not empty selectedSizeId}">
                                                        <c:param name="sizeId" value="${selectedSizeId}" />
                                                    </c:if>
                                                    <c:if test="${not empty selectedColorId}">
                                                        <c:param name="colorId" value="${selectedColorId}" />
                                                    </c:if>
                                                    <c:if test="${selectedType != null}"> <%-- Thêm điều kiện cho type
                                                            --%>
                                                            <c:param name="type" value="${selectedType}" />
                                                    </c:if>
                                                    <c:if
                                                        test="${not empty selectedPriceRange && selectedPriceRange != 'all'}">
                                                        <c:param name="priceRange" value="${selectedPriceRange}" />
                                                    </c:if>
                                                    <c:if test="${not empty selectedSortBy}">
                                                        <c:param name="sortBy" value="${selectedSortBy}" />
                                                    </c:if>
                                                    <c:param name="page" value="1" />
                                                </c:url>
                                                <!-- Brand Dropdown -->
                                                <div class="dropdown relative">
                                                    <button
                                                        class="flex items-center gap-2 px-4 py-2 border border-gray-200 text-sm hover:bg-gray-50">
                                                        <spring:message code="category.dropdown.brand" /> <i
                                                            class="fa-solid fa-chevron-down text-xs"></i>
                                                    </button>
                                                    <div
                                                        class="dropdown-menu absolute hidden mt-1 w-48 bg-white border border-gray-200 shadow-lg z-10">
                                                        <c:url var="allBrandsUrl" value="${baseBrandUrl}" />
                                                        <a href="${allBrandsUrl}"
                                                            class="block px-4 py-2 text-sm hover:bg-gray-50 ${empty selectedBrandId ? 'font-bold' : ''}">
                                                            <spring:message code="category.dropdown.all" />
                                                        </a>
                                                        <c:forEach items="${brands}" var="brand">
                                                            <c:url var="brandUrl" value="${baseBrandUrl}">
                                                                <c:param name="brandId" value="${brand.brandId}" />
                                                            </c:url>
                                                            <a href="${brandUrl}"
                                                                class="block px-4 py-2 text-sm hover:bg-gray-50 ${selectedBrandId eq brand.brandId ? 'font-bold' : ''}">
                                                                ${brand.brandName}
                                                            </a>
                                                        </c:forEach>
                                                    </div>
                                                </div>

                                                <%-- Category Dropdown --%>
                                                    <c:url var="baseCategoryUrl" value="/product/category">
                                                        <c:if test="${not empty selectedBrandId}">
                                                            <c:param name="brandId" value="${selectedBrandId}" />
                                                        </c:if>
                                                        <c:if test="${not empty selectedSizeId}">
                                                            <c:param name="sizeId" value="${selectedSizeId}" />
                                                        </c:if>
                                                        <c:if test="${not empty selectedColorId}">
                                                            <c:param name="colorId" value="${selectedColorId}" />
                                                        </c:if>
                                                        <c:if test="${selectedType != null}"> <%-- Thêm điều kiện type
                                                                --%>
                                                                <c:param name="type" value="${selectedType}" />
                                                        </c:if>
                                                        <c:if
                                                            test="${not empty selectedPriceRange && selectedPriceRange != 'all'}">
                                                            <c:param name="priceRange" value="${selectedPriceRange}" />
                                                        </c:if>
                                                        <c:if test="${not empty selectedSortBy}">
                                                            <c:param name="sortBy" value="${selectedSortBy}" />
                                                        </c:if>
                                                        <c:param name="page" value="1" />
                                                    </c:url>
                                                    <!-- Category Dropdown -->
                                                    <div class="dropdown relative">
                                                        <button
                                                            class="flex items-center gap-2 px-4 py-2 border border-gray-200 text-sm hover:bg-gray-50">
                                                            <spring:message code="category.dropdown.category" /> <i
                                                                class="fa-solid fa-chevron-down text-xs"></i>
                                                        </button>
                                                        <div
                                                            class="dropdown-menu absolute hidden mt-1 w-48 bg-white border border-gray-200 shadow-lg z-10">
                                                            <c:url var="allCategoriesUrl" value="${baseCategoryUrl}" />
                                                            <a href="${allCategoriesUrl}"
                                                                class="block px-4 py-2 text-sm hover:bg-gray-50 ${empty selectedCategoryId ? 'font-bold' : ''}">
                                                                <spring:message code="category.dropdown.all" />
                                                            </a>
                                                            <c:forEach items="${categories}" var="category">
                                                                <c:url var="categoryUrl" value="${baseCategoryUrl}">
                                                                    <c:param name="categoryId"
                                                                        value="${category.categoryId}" />
                                                                </c:url>
                                                                <a href="${categoryUrl}"
                                                                    class="block px-4 py-2 text-sm hover:bg-gray-50 ${selectedCategoryId eq category.categoryId ? 'font-bold' : ''}">
                                                                    ${category.categoryName}
                                                                </a>
                                                            </c:forEach>
                                                        </div>
                                                    </div>

                                                    <%-- Size Dropdown --%>
                                                        <c:url var="baseSizeUrl" value="/product/category">
                                                            <c:if test="${not empty selectedBrandId}">
                                                                <c:param name="brandId" value="${selectedBrandId}" />
                                                            </c:if>
                                                            <c:if test="${not empty selectedCategoryId}">
                                                                <c:param name="categoryId"
                                                                    value="${selectedCategoryId}" />
                                                            </c:if>
                                                            <c:if test="${not empty selectedColorId}">
                                                                <c:param name="colorId" value="${selectedColorId}" />
                                                            </c:if>
                                                            <c:if test="${selectedType != null}"> <%-- Thêm điều kiện
                                                                    cho type --%>
                                                                    <c:param name="type" value="${selectedType}" />
                                                            </c:if>
                                                            <c:if
                                                                test="${not empty selectedPriceRange && selectedPriceRange != 'all'}">
                                                                <c:param name="priceRange"
                                                                    value="${selectedPriceRange}" />
                                                            </c:if>
                                                            <c:if test="${not empty selectedSortBy}">
                                                                <c:param name="sortBy" value="${selectedSortBy}" />
                                                            </c:if>
                                                            <c:param name="page" value="1" />
                                                        </c:url>
                                                        <!-- Size Dropdown -->
                                                        <div class="dropdown relative">
                                                            <button
                                                                class="flex items-center gap-2 px-4 py-2 border border-gray-200 text-sm hover:bg-gray-50">
                                                                <spring:message code="category.dropdown.size" /> <i
                                                                    class="fa-solid fa-chevron-down text-xs"></i>
                                                            </button>
                                                            <div
                                                                class="dropdown-menu absolute hidden mt-1 w-48 bg-white border border-gray-200 shadow-lg z-10">
                                                                <c:url var="allSizesUrl" value="${baseSizeUrl}" />
                                                                <a href="${allSizesUrl}"
                                                                    class="block px-4 py-2 text-sm hover:bg-gray-50 ${empty selectedSizeId ? 'font-bold' : ''}">
                                                                    <spring:message code="category.dropdown.all" />
                                                                </a>
                                                                <c:forEach items="${sizes}" var="size">
                                                                    <c:url var="sizeUrl" value="${baseSizeUrl}">
                                                                        <c:param name="sizeId" value="${size.sizeId}" />
                                                                    </c:url>
                                                                    <a href="${sizeUrl}"
                                                                        class="block px-4 py-2 text-sm hover:bg-gray-50 ${selectedSizeId eq size.sizeId ? 'font-bold' : ''}">
                                                                        ${size.sizeName}
                                                                    </a>
                                                                </c:forEach>
                                                            </div>
                                                        </div>

                                                        <%-- Color Dropdown --%>
                                                            <c:url var="baseColorUrl" value="/product/category">
                                                                <c:if test="${not empty selectedBrandId}">
                                                                    <c:param name="brandId"
                                                                        value="${selectedBrandId}" />
                                                                </c:if>
                                                                <c:if test="${not empty selectedCategoryId}">
                                                                    <c:param name="categoryId"
                                                                        value="${selectedCategoryId}" />
                                                                </c:if>
                                                                <c:if test="${not empty selectedSizeId}">
                                                                    <c:param name="sizeId" value="${selectedSizeId}" />
                                                                </c:if>
                                                                <c:if test="${selectedType != null}"> <%-- Thêm điều
                                                                        kiện cho type --%>
                                                                        <c:param name="type" value="${selectedType}" />
                                                                </c:if>
                                                                <c:if
                                                                    test="${not empty selectedPriceRange && selectedPriceRange != 'all'}">
                                                                    <c:param name="priceRange"
                                                                        value="${selectedPriceRange}" />
                                                                </c:if>
                                                                <c:if test="${not empty selectedSortBy}">
                                                                    <c:param name="sortBy" value="${selectedSortBy}" />
                                                                </c:if>
                                                                <c:param name="page" value="1" />
                                                            </c:url>
                                                            <!-- Color Dropdown -->
                                                            <div class="dropdown relative">
                                                                <button
                                                                    class="flex items-center gap-2 px-4 py-2 border border-gray-200 text-sm hover:bg-gray-50">
                                                                    <spring:message code="category.dropdown.color" /> <i
                                                                        class="fa-solid fa-chevron-down text-xs"></i>
                                                                </button>
                                                                <div
                                                                    class="dropdown-menu absolute hidden mt-1 w-48 bg-white border border-gray-200 shadow-lg z-10">
                                                                    <c:url var="allColorsUrl" value="${baseColorUrl}" />
                                                                    <a href="${allColorsUrl}"
                                                                        class="block px-4 py-2 text-sm hover:bg-gray-50 ${empty selectedColorId ? 'font-bold' : ''}">
                                                                        <spring:message code="category.dropdown.all" />
                                                                    </a>
                                                                    <c:forEach items="${colors}" var="color">
                                                                        <c:url var="colorUrl" value="${baseColorUrl}">
                                                                            <c:param name="colorId"
                                                                                value="${color.colorId}" />
                                                                        </c:url>
                                                                        <a href="${colorUrl}"
                                                                            class="block px-4 py-2 text-sm hover:bg-gray-50 ${selectedColorId eq color.colorId ? 'font-bold' : ''}">
                                                                            ${color.colorName}
                                                                        </a>
                                                                    </c:forEach>
                                                                </div>
                                                            </div>

                                                            <%-- Thêm Fashion Dropdown --%>
                                                                <c:url var="baseFashionUrl" value="/product/category">
                                                                    <c:if test="${not empty selectedBrandId}">
                                                                        <c:param name="brandId"
                                                                            value="${selectedBrandId}" />
                                                                    </c:if>
                                                                    <c:if test="${not empty selectedCategoryId}">
                                                                        <c:param name="categoryId"
                                                                            value="${selectedCategoryId}" />
                                                                    </c:if>
                                                                    <c:if test="${not empty selectedSizeId}">
                                                                        <c:param name="sizeId"
                                                                            value="${selectedSizeId}" />
                                                                    </c:if>
                                                                    <c:if test="${not empty selectedColorId}">
                                                                        <c:param name="colorId"
                                                                            value="${selectedColorId}" />
                                                                    </c:if>
                                                                    <c:if
                                                                        test="${not empty selectedPriceRange && selectedPriceRange != 'all'}">
                                                                        <c:param name="priceRange"
                                                                            value="${selectedPriceRange}" />
                                                                    </c:if>
                                                                    <c:if test="${not empty selectedSortBy}">
                                                                        <c:param name="sortBy"
                                                                            value="${selectedSortBy}" />
                                                                    </c:if>
                                                                    <c:param name="type" value="false" />
                                                                    <c:param name="page" value="1" />
                                                                </c:url>
                                                                <%-- Fashion dropdown removed, type=false hardcoded --%>


                                                                    <%-- Price Range Dropdown --%>
                                                                        <c:url var="basePriceUrl"
                                                                            value="/product/category">
                                                                            <c:if test="${not empty selectedBrandId}">
                                                                                <c:param name="brandId"
                                                                                    value="${selectedBrandId}" />
                                                                            </c:if>
                                                                            <c:if
                                                                                test="${not empty selectedCategoryId}">
                                                                                <c:param name="categoryId"
                                                                                    value="${selectedCategoryId}" />
                                                                            </c:if>
                                                                            <c:if test="${not empty selectedSizeId}">
                                                                                <c:param name="sizeId"
                                                                                    value="${selectedSizeId}" />
                                                                            </c:if>
                                                                            <c:if test="${not empty selectedColorId}">
                                                                                <c:param name="colorId"
                                                                                    value="${selectedColorId}" />
                                                                            </c:if>
                                                                            <c:if test="${selectedType != null}"> <%--
                                                                                    Thêm điều kiện cho type --%>
                                                                                    <c:param name="type"
                                                                                        value="${selectedType}" />
                                                                            </c:if>
                                                                            <c:if test="${not empty selectedSortBy}">
                                                                                <c:param name="sortBy"
                                                                                    value="${selectedSortBy}" />
                                                                            </c:if>
                                                                            <c:param name="page" value="1" />
                                                                        </c:url>
                                                                        <!-- Price Range Dropdown -->
                                                                        <!-- <div class="dropdown relative">
                                                                        <button
                                                                            class="flex items-center gap-2 px-4 py-2 border border-gray-200 text-sm hover:bg-gray-50">
                                                                            <spring:message
                                                                                code="category.dropdown.price" /> <i
                                                                                class="fa-solid fa-chevron-down text-xs"></i>
                                                                        </button>
                                                                        <div
                                                                            class="dropdown-menu absolute hidden mt-1 w-48 bg-white border border-gray-200 shadow-lg z-10">
                                                                            <c:url var="allPricesUrl"
                                                                                value="${basePriceUrl}" /> <%-- URL
                                                                                không có priceRange --%>
                                                                                <a href="${allPricesUrl}"
                                                                                    class="block px-4 py-2 text-sm hover:bg-gray-50 ${selectedPriceRange == 'all' ? 'font-bold' : ''}">
                                                                                    <spring:message
                                                                                        code="category.dropdown.all" />
                                                                                </a>
                                                                                <%-- Các khoảng giá khác --%>
                                                                                    <c:forEach var="range"
                                                                                        items="${['0-00', '50-100', '100-200', '200+']}">
                                                                                        <%-- Ví dụ các khoảng giá --%>
                                                                                            <c:url var="priceUrl"
                                                                                                value="${basePriceUrl}">
                                                                                                <c:param
                                                                                                    name="priceRange"
                                                                                                    value="${range}" />
                                                                                            </c:url>
                                                                                            <a href="${priceUrl}"
                                                                                                class="block px-4 py-2 text-sm hover:bg-gray-50 ${selectedPriceRange == range ? 'font-bold' : ''}">
                                                                                                <c:choose>
                                                                                                    <c:when
                                                                                                        test="${range == '0-50'}">
                                                                                                        Under $50
                                                                                                    </c:when>
                                                                                                    <c:when
                                                                                                        test="${range == '50-100'}">
                                                                                                        $50 - $100
                                                                                                    </c:when>
                                                                                                    <c:when
                                                                                                        test="${range == '100-200'}">
                                                                                                        $100 - $200
                                                                                                    </c:when>
                                                                                                    <c:when
                                                                                                        test="${range == '200+'}">
                                                                                                        $200+</c:when>
                                                                                                    <c:otherwise>
                                                                                                        ${range}
                                                                                                    </c:otherwise> <%--
                                                                                                        Fallback --%>
                                                                                                </c:choose>
                                                                                            </a>
                                                                                    </c:forEach>
                                                                        </div>
                                                                    </div> -->

                                                                        <!-- Price Range Dropdown -->
                                                                        <div class="dropdown relative">
                                                                            <button
                                                                                class="flex items-center gap-2 px-4 py-2 border border-gray-200 text-sm hover:bg-gray-50">
                                                                                <spring:message
                                                                                    code="category.dropdown.price" /> <i
                                                                                    class="fa-solid fa-chevron-down text-xs"></i>
                                                                            </button>
                                                                            <div
                                                                                class="dropdown-menu absolute hidden mt-1 w-48 bg-white border border-gray-200 shadow-lg z-10">
                                                                                <%-- All Prices --%>
                                                                                    <c:url var="allPricesUrl"
                                                                                        value="${basePriceUrl}" /> <%--
                                                                                        URL không có priceRange --%>
                                                                                        <a href="${allPricesUrl}"
                                                                                            class="block px-4 py-2 text-sm hover:bg-gray-50 ${selectedPriceRange eq 'all' or empty selectedPriceRange ? 'font-bold' : ''}">
                                                                                            <%-- Sửa điều kiện kiểm
                                                                                                tra 'all' hoặc rỗng --%>
                                                                                                <spring:message
                                                                                                    code="category.dropdown.all" />
                                                                                        </a>

                                                                                        <%-- Define Price Ranges Map
                                                                                            --%>
                                                                                            <jsp:useBean
                                                                                                id="priceRangesMap"
                                                                                                class="java.util.LinkedHashMap"
                                                                                                scope="page" />
                                                                                            <c:set
                                                                                                target="${priceRangesMap}"
                                                                                                property="0-200000"
                                                                                                value="Dưới 200K" />
                                                                                            <c:set
                                                                                                target="${priceRangesMap}"
                                                                                                property="200000-400000"
                                                                                                value="200K – 400K" />
                                                                                            <c:set
                                                                                                target="${priceRangesMap}"
                                                                                                property="400000-600000"
                                                                                                value="400K – 600K" />
                                                                                            <c:set
                                                                                                target="${priceRangesMap}"
                                                                                                property="600000-800000"
                                                                                                value="600K – 800K" />
                                                                                            <c:set
                                                                                                target="${priceRangesMap}"
                                                                                                property="800000-1000000"
                                                                                                value="800K – 1M" />
                                                                                            <c:set
                                                                                                target="${priceRangesMap}"
                                                                                                property="1000000-2000000"
                                                                                                value="1M – 2M" />
                                                                                            <c:set
                                                                                                target="${priceRangesMap}"
                                                                                                property="2000000+"
                                                                                                value="Trên 2M" /> <%--
                                                                                                Sử dụng 2000000+ --%>

                                                                                                <%-- Iterate over the
                                                                                                    map --%>
                                                                                                    <c:forEach
                                                                                                        items="${priceRangesMap}"
                                                                                                        var="rangeEntry">
                                                                                                        <c:url
                                                                                                            var="priceUrl"
                                                                                                            value="${basePriceUrl}">
                                                                                                            <c:param
                                                                                                                name="priceRange"
                                                                                                                value="${rangeEntry.key}" />
                                                                                                            <%-- Sử dụng
                                                                                                                key của
                                                                                                                map
                                                                                                                entry
                                                                                                                --%>
                                                                                                        </c:url>
                                                                                                        <a href="${priceUrl}"
                                                                                                            class="block px-4 py-2 text-sm hover:bg-gray-50 ${selectedPriceRange eq rangeEntry.key ? 'font-bold' : ''}">
                                                                                                            ${rangeEntry.value}
                                                                                                            <%-- Sử dụng
                                                                                                                value
                                                                                                                của map
                                                                                                                entry
                                                                                                                --%>
                                                                                                        </a>
                                                                                                    </c:forEach>
                                                                            </div>
                                                                        </div>

                                                                        <%-- Sort Dropdown --%>
                                                                            <c:url var="baseSortUrl"
                                                                                value="/product/category">
                                                                                <c:if
                                                                                    test="${not empty selectedBrandId}">
                                                                                    <c:param name="brandId"
                                                                                        value="${selectedBrandId}" />
                                                                                </c:if>
                                                                                <c:if
                                                                                    test="${not empty selectedCategoryId}">
                                                                                    <c:param name="categoryId"
                                                                                        value="${selectedCategoryId}" />
                                                                                </c:if>
                                                                                <c:if
                                                                                    test="${not empty selectedSizeId}">
                                                                                    <c:param name="sizeId"
                                                                                        value="${selectedSizeId}" />
                                                                                </c:if>
                                                                                <c:if
                                                                                    test="${not empty selectedColorId}">
                                                                                    <c:param name="colorId"
                                                                                        value="${selectedColorId}" />
                                                                                </c:if>
                                                                                <c:if test="${selectedType != null}">
                                                                                    <%-- Thêm điều kiện cho type --%>
                                                                                        <c:param name="type"
                                                                                            value="${selectedType}" />
                                                                                </c:if>
                                                                                <c:if
                                                                                    test="${not empty selectedPriceRange && selectedPriceRange != 'all'}">
                                                                                    <c:param name="priceRange"
                                                                                        value="${selectedPriceRange}" />
                                                                                </c:if>
                                                                                <%-- Không cần page=1 ở đây vì sắp xếp
                                                                                    không nên reset trang --%>
                                                                                    <c:if test="${currentPage > 1}">
                                                                                        <c:param name="page"
                                                                                            value="${currentPage}" />
                                                                                    </c:if>
                                                                            </c:url>
                                                                            <!-- Sort Dropdown -->
                                                                            <div class="dropdown relative">
                                                                                <button
                                                                                    class="flex items-center gap-2 px-4 py-2 border border-gray-200 text-sm hover:bg-gray-50">
                                                                                    <spring:message
                                                                                        code="category.dropdown.sortBy" />
                                                                                    <i
                                                                                        class="fa-solid fa-chevron-down text-xs"></i>
                                                                                </button>
                                                                                <div
                                                                                    class="dropdown-menu absolute hidden right-0 mt-1 w-48 bg-white border border-gray-200 shadow-lg z-10">
                                                                                    <c:url var="sortNewestUrl"
                                                                                        value="${baseSortUrl}">
                                                                                        <c:param name="sortBy"
                                                                                            value="newest" />
                                                                                    </c:url>
                                                                                    <a href="${sortNewestUrl}"
                                                                                        class="block px-4 py-2 text-sm hover:bg-gray-50 ${selectedSortBy == 'newest' ? 'font-bold' : ''}">
                                                                                        <spring:message
                                                                                            code="category.sort.newest" />
                                                                                    </a>
                                                                                    <c:url var="sortPriceAscUrl"
                                                                                        value="${baseSortUrl}">
                                                                                        <c:param name="sortBy"
                                                                                            value="priceAsc" />
                                                                                    </c:url>
                                                                                    <a href="${sortPriceAscUrl}"
                                                                                        class="block px-4 py-2 text-sm hover:bg-gray-50 ${selectedSortBy == 'priceAsc' ? 'font-bold' : ''}">
                                                                                        <spring:message
                                                                                            code="category.sort.priceAsc" />
                                                                                    </a>
                                                                                    <c:url var="sortPriceDescUrl"
                                                                                        value="${baseSortUrl}">
                                                                                        <c:param name="sortBy"
                                                                                            value="priceDesc" />
                                                                                    </c:url>
                                                                                    <a href="${sortPriceDescUrl}"
                                                                                        class="block px-4 py-2 text-sm hover:bg-gray-50 ${selectedSortBy == 'priceDesc' ? 'font-bold' : ''}">
                                                                                        <spring:message
                                                                                            code="category.sort.priceDesc" />
                                                                                    </a>
                                                                                    <c:url var="sortBestSellersUrl"
                                                                                        value="${baseSortUrl}">
                                                                                        <c:param name="sortBy"
                                                                                            value="bestSellers" />
                                                                                    </c:url>
                                                                                    <a href="${sortBestSellersUrl}"
                                                                                        class="block px-4 py-2 text-sm hover:bg-gray-50 ${selectedSortBy == 'bestSellers' ? 'font-bold' : ''}">
                                                                                        <spring:message
                                                                                            code="category.sort.bestSellers" />
                                                                                    </a>
                                                                                </div>
                                                                            </div>
                                    </div>
                                </div>
                            </div>
                        </section>

                        <!-- Product Grid -->
                        <section class="py-12">
                            <div class="max-w-7xl mx-auto px-6">
                                <c:choose>
                                    <c:when test="${not empty products}">
                                        <div
                                            class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8">
                                            <%-- Sửa tên biến từ product thành products --%>
                                                <c:forEach items="${products}" var="p">
                                                    <div class="product-card group relative">
                                                        <div class="relative overflow-hidden mb-4 h-96">
                                                            <!-- Product Image -->
                                                            <%-- Sử dụng đường dẫn tương đối hoặc tuyệt đối phù hợp --%>
                                                                <img src="<c:url value='/${p.imageUrl}'/>"
                                                                    alt="${p.productName}"
                                                                    class="w-full h-full object-cover transition duration-500 group-hover:opacity-75">

                                                                <!-- Dark Overlay (appears on hover) -->
                                                                <div
                                                                    class="absolute inset-0 bg-black bg-opacity-0 transition duration-500 group-hover:bg-opacity-60">
                                                                </div>

                                                                <!-- Quick View Button -->
                                                                <div
                                                                    class="absolute inset-0 flex items-center justify-center opacity-0 group-hover:opacity-100 transition duration-300">
                                                                    <c:url var="detailUrl" value="/product/detail">
                                                                        <c:param name="id" value="${p.productId}" />
                                                                    </c:url>
                                                                    <a href="${detailUrl}"
                                                                        class="bg-white px-6 py-2 text-sm tracking-wider border border-black hover:bg-black hover:text-white transition duration-300">
                                                                        <spring:message code="category.quickView" />
                                                                    </a>
                                                                </div>
                                                        </div>
                                                        <div class="text-center">
                                                            <h3 class="font-serif text-xl mb-1">${p.productName}
                                                            </h3>
                                                            <%-- Định dạng giá tiền --%>
                                                                <p class="text-gray-500">
                                                                    <fmt:formatNumber value="${p.price}" type="currency"
                                                                        currencySymbol="$" />
                                                                </p>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center py-10 text-gray-500">
                                            <p>
                                                <spring:message code="category.noProductsFound" />
                                            </p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>


                                <!-- Pagination -->
                                <c:if test="${totalPages > 1}">
                                    <div class="mt-16 flex justify-center">
                                        <nav aria-label="Page navigation">
                                            <ul class="flex items-center gap-1">
                                                <%-- Tạo URL cơ sở cho Pagination (giữ nguyên tất cả filter/sort) --%>
                                                    <c:url var="basePageUrl" value="/product/category">
                                                        <c:if test="${not empty selectedBrandId}">
                                                            <c:param name="brandId" value="${selectedBrandId}" />
                                                        </c:if>
                                                        <c:if test="${not empty selectedCategoryId}">
                                                            <c:param name="categoryId" value="${selectedCategoryId}" />
                                                        </c:if>
                                                        <c:if test="${not empty selectedSizeId}">
                                                            <c:param name="sizeId" value="${selectedSizeId}" />
                                                        </c:if>
                                                        <c:if test="${not empty selectedColorId}">
                                                            <c:param name="colorId" value="${selectedColorId}" />
                                                        </c:if>
                                                        <c:if test="${not empty selectedSortBy}">
                                                            <c:param name="sortBy" value="${selectedSortBy}" />
                                                        </c:if>
                                                        <c:param name="type" value="false" />
                                                    </c:url>

                                                    <%-- Previous Button --%>
                                                        <li>
                                                            <c:url var="prevUrl" value="${basePageUrl}">
                                                                <c:param name="page" value="${currentPage - 1}" />
                                                            </c:url>
                                                            <a href="${currentPage > 1 ? prevUrl : '#'}"
                                                                class="pagination-item w-10 h-10 flex items-center justify-center rounded-full ${currentPage <= 1 ? 'text-gray-400 pointer-events-none' : 'hover:bg-gray-100'}"
                                                                aria-label="Previous" ${currentPage <=1
                                                                ? 'tabindex="-1" aria-disabled="true"' : '' }>
                                                                <i class="fa-solid fa-chevron-left text-xs"></i>
                                                            </a>
                                                        </li>

                                                        <%-- Page Numbers --%>
                                                            <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                                                                <li>
                                                                    <c:url var="pageUrl" value="${basePageUrl}">
                                                                        <c:param name="page" value="${pageNumber}" />
                                                                    </c:url>
                                                                    <a href="${pageUrl}"
                                                                        class="pagination-item w-10 h-10 flex items-center justify-center rounded-full ${pageNumber eq currentPage ? 'bg-black text-white font-semibold pointer-events-none' : 'hover:bg-gray-100'}">
                                                                        ${pageNumber}
                                                                    </a>
                                                                </li>
                                                            </c:forEach>

                                                            <%-- Next Button --%>
                                                                <li>
                                                                    <c:url var="nextUrl" value="${basePageUrl}">
                                                                        <c:param name="page"
                                                                            value="${currentPage + 1}" />
                                                                    </c:url>
                                                                    <a href="${currentPage < totalPages ? nextUrl : '#'}"
                                                                        class="pagination-item w-10 h-10 flex items-center justify-center rounded-full ${currentPage >= totalPages ? 'text-gray-400 pointer-events-none' : 'hover:bg-gray-100'}"
                                                                        aria-label="Next" ${currentPage>= totalPages
                                                                        ? 'tabindex="-1" aria-disabled="true"' :
                                                                        ''}>
                                                                        <i
                                                                            class="fa-solid fa-chevron-right text-xs"></i>
                                                                    </a>
                                                                </li>
                                            </ul>
                                        </nav>
                                    </div>
                                </c:if> <%-- End if totalPages> 1 --%>
                            </div>
                        </section>

                        <!-- Footer -->
                        <jsp:include page="../layout/footer.jsp" />



                    </body>

                    </html>

                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            // Handle dropdown toggle
                            document.querySelectorAll('.dropdown button').forEach(button => {
                                button.addEventListener('click', function (e) {
                                    e.stopPropagation();
                                    const menu = this.nextElementSibling;
                                    menu.classList.toggle('hidden');
                                });
                            });

                            // Close dropdown when clicking outside
                            document.addEventListener('click', function () {
                                document.querySelectorAll('.dropdown-menu').forEach(menu => {
                                    menu.classList.add('hidden');
                                });
                            });
                        });
                    </script>