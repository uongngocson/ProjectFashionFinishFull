<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

                <!-- Navigation -->
                <!-- <nav class="fixed w-full z-50 bg-white bg-opacity-90 border-b border-gray-100">
                    <div class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
                        <div class="text-2xl font-semibold tracking-widest">DDTS</div>

                        <div class="hidden md:flex space-x-8">
                            <a href="/"
                                class="nav-link uppercase text-sm tracking-wider hover:after:w-full after:block after:w-0 after:h-px after:bg-black after:transition-all after:duration-300">
                                <spring:message code="navbar.home" />
                            </a>
                            <a href="/product/category"
                                class="nav-link uppercase text-sm tracking-wider hover:after:w-full after:block after:w-0 after:h-px after:bg-black after:transition-all after:duration-300">
                                <spring:message code="navbar.categories" />
                            </a>
                            <a href="/product/item-male"
                                class="nav-link uppercase text-sm tracking-wider hover:after:w-full after:block after:w-0 after:h-px after:bg-black after:transition-all after:duration-300">
                                <spring:message code="navbar.men" />
                            </a>
                            <a href="/product/item-female"
                                class="nav-link uppercase text-sm tracking-wider hover:after:w-full after:block after:w-0 after:h-px after:bg-black after:transition-all after:duration-300">
                                <spring:message code="navbar.women" />
                            </a>
                            <a href="/about"
                                class="nav-link uppercase text-sm tracking-wider hover:after:w-full after:block after:w-0 after:h-px after:bg-black after:transition-all after:duration-300">
                                <spring:message code="navbar.about" />
                            </a>
                        </div>

                        <div class="flex items-center space-x-6">
                            <div class="flex space-x-2">
                                <a href="?lang=en"
                                    class="text-sm ${pageContext.response.locale == 'en' ? 'font-bold text-blue-600' : 'text-gray-600'}">EN</a>
                                <span class="text-gray-400">|</span>
                                <a href="?lang=vi"
                                    class="text-sm ${pageContext.response.locale == 'vi' ? 'font-bold text-blue-600' : 'text-gray-600'}">VI</a>
                            </div>
                            <c:if test="${not empty pageContext.request.userPrincipal}">
                                <a href="/user/cart" class="relative me-4 my-auto">
                                    <i class="fa fa-shopping-bag fa-lg"></i>
                                    <span
                                        class="absolute -top-1 -right-2 bg-blue-200 rounded-full flex items-center justify-center text-dark px-1 h-5 w-5 text-xs"
                                        id="sumCart">
                                        ${sessionScope.sum}
                                    </span>
                                </a>
                                <div class="relative my-auto group">
                                    <button type="button" class="focus:outline-none">
                                        <i class="fas fa-user fa-lg"></i>
                                    </button>
                                    <div
                                        class="absolute right-0 mt-2 w-72 bg-white rounded-md shadow-lg z-50 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-300 transform group-hover:translate-y-0 translate-y-1">
                                        <div class="p-4">
                                            <div class="flex flex-col items-center">
                                                <img class="w-24 h-24 rounded-full object-cover mb-3"
                                                    src="${sessionScope.avatar}" />
                                                <div class="text-center font-medium mb-3">
                                                    <c:out value="${sessionScope.fullName}" />
                                                </div>
                                            </div>
                                            <hr class="my-2 border-gray-200">
                                            <a href="#" class="block px-4 py-2 text-gray-800 hover:bg-gray-100">
                                                <spring:message code="navbar.account" />
                                            </a>
                                            <a href="/order-history"
                                                class="block px-4 py-2 text-gray-800 hover:bg-gray-100">
                                                <spring:message code="navbar.orderHistory" />
                                            </a>
                                            <hr class="my-2 border-gray-200">
                                            <form method="post" action="/logout">
                                                <input type="hidden" name="${_csrf.parameterName}"
                                                    value="${_csrf.token}" />
                                                <button type="submit"
                                                    class="w-full text-left block px-4 py-2 text-gray-800 hover:bg-gray-100">
                                                    <spring:message code="navbar.logout" />
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <c:if test="${empty pageContext.request.userPrincipal}">
                                <a href="/login" class="text-sm hover:text-blue-600">
                                    <spring:message code="navbar.login" />
                                </a>
                            </c:if>
                        </div>
                    </div>
                </nav> -->
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta http-equiv="X-UA-Compatible" content="IE=edge">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Document</title>
                    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap"
                        rel="stylesheet">
                    <link rel="stylesheet"
                        href="${pageContext.request.contextPath}/resources/assets/client/css/style.css">
                    <link rel="stylesheet"
                        href="${pageContext.request.contextPath}/resources/assets/client/css/sontest.css">

                    <link rel="icon"
                        href="${pageContext.request.contextPath}/resources/assets/client/images/icon-adidas-logo.svg"
                        type="image/icon type">
                </head>


                <body>

                    <main>

                        <section class="popular">
                            <h1>POPULAR RIGHT NOW</h1>
                            <div class="popular-product">
                                <a href="">ULTRABOOST</a>
                                <a href="">NMD</a>
                                <a href="">BACKPACKS</a>
                                <a href="">CLEATS</a>
                                <a href="">STAN SMITH</a>
                            </div>
                        </section>
                        <section class="clothes">
                            <div class="clothes-item">
                                <img src="${pageContext.request.contextPath}/resources/assets/client/images/shoes.webp"
                                    alt="">
                                <a>SHOES</a>
                            </div>
                            <div class="clothes-item">
                                <img src="${pageContext.request.contextPath}/resources/assets/client/images/clothing.webp"
                                    alt="">
                                <a>CLOTHING</a>
                            </div>
                            <div class="clothes-item">
                                <img src="${pageContext.request.contextPath}/resources/assets/client/images/bestsellers.webp"
                                    alt="">
                                <a>BEST SELLERS</a>
                            </div>
                            <div class="clothes-item">
                                <img src="${pageContext.request.contextPath}/resources/assets/client/images/new-arrivals.webp"
                                    alt="">
                                <a>NEW ARRIVALS</a>
                            </div>
                        </section>
                        <section class="arrivals-section">
                            <div class="arrivals">
                                <div class="new-arrivals">
                                    <a href="" class="active">NEW ARRIVALS</a>
                                    <a href="" class="trending">WHAT's TRENDING</a>
                                </div>
                                <div class="view-all">
                                    <a href="">VIEW ALL</a>
                                </div>
                            </div>
                            <div class="wrapper">
                                <div class="arrivals-slider">
                                    <c:choose>
                                        <c:when test="${empty featuredProducts}">
                                            <!-- Original slider items when no products are available -->
                                            <div class="slider-item">
                                                <div class="slider-img off">
                                                    <img src="${pageContext.request.contextPath}/resources/assets/client/images/arrivals-img1.webp"
                                                        alt="">
                                                </div>
                                                <div class="slider-content">
                                                    <h5>NMD_V3 Shoes</h5>
                                                    <p>Men's Originals</p>
                                                    <span>new</span>
                                                </div>
                                                <i class="uil uil-heart"></i>
                                            </div>
                                            <div class="slider-item">
                                                <div class="slider-img off">
                                                    <img src="${pageContext.request.contextPath}/resources/assets/client/images/arrivals-img2.webp"
                                                        alt="">
                                                </div>
                                                <div class="slider-content">
                                                    <h5>NMD_V3 Shoes</h5>
                                                    <p>Woen's Originals</p>
                                                    <span>new</span>
                                                </div>
                                                <i class="uil uil-heart"></i>
                                            </div>
                                            <div class="slider-item">
                                                <div class="slider-img">
                                                    <img src="${pageContext.request.contextPath}/resources/assets/client/images/arrivals-img3.webp"
                                                        alt="">
                                                </div>
                                                <div class="slider-content">
                                                    <h5>COLLEGIATE SKIRT</h5>
                                                    <p>Women's Originals</p>
                                                    <span>new</span>
                                                </div>
                                                <i class="uil uil-heart"></i>
                                            </div>
                                            <div class="slider-item">
                                                <div class="slider-img">
                                                    <img src="${pageContext.request.contextPath}/resources/assets/client/images/arrivals-img4.webp"
                                                        alt="">
                                                </div>
                                                <div class="slider-content">
                                                    <h5>adidas Originals Class of 72 Crop Vest</h5>
                                                    <p>Women's Originals</p>
                                                    <span>new</span>
                                                </div>
                                                <i class="uil uil-heart"></i>
                                            </div>
                                            <div class="slider-item">
                                                <div class="slider-img">
                                                    <img src="${pageContext.request.contextPath}/resources/assets/client/images/arrivals-img5.webp"
                                                        alt="">
                                                </div>
                                                <div class="slider-content">
                                                    <h5>Capable of Greatness Joggers</h5>
                                                    <p>Men's Training</p>
                                                    <span>new</span>
                                                </div>
                                                <i class="uil uil-heart"></i>
                                            </div>
                                            <div class="slider-item">
                                                <div class="slider-img">
                                                    <img src="${pageContext.request.contextPath}/resources/assets/client/images/arrivals-img6.webp"
                                                        alt="">
                                                </div>
                                                <div class="slider-content">
                                                    <h5>adidas x Peloton jacket</h5>
                                                    <p>Men's Training</p>
                                                    <span>new</span>
                                                </div>
                                                <i class="uil uil-heart"></i>
                                            </div>
                                            <div class="slider-item">
                                                <div class="slider-img">
                                                    <img src="${pageContext.request.contextPath}/resources/assets/client/images/arrivals-img7.webp"
                                                        alt="">
                                                </div>
                                                <div class="slider-content">
                                                    <h5>adidas x Peloton jacket</h5>
                                                    <p>Men's Training</p>
                                                    <span>new</span>
                                                </div>
                                                <i class="uil uil-heart"></i>
                                            </div>
                                            <div class="slider-item">
                                                <div class="slider-img">
                                                    <img src="${pageContext.request.contextPath}/resources/assets/client/images/arrivals-img8.webp"
                                                        alt="">
                                                </div>
                                                <div class="slider-content">
                                                    <h5>Capable of Greatness 7/8 Tights</h5>
                                                    <p>Women's Training</p>
                                                    <span>new</span>
                                                </div>
                                                <i class="uil uil-heart"></i>
                                            </div>
                                            <div class="slider-item">
                                                <div class="slider-img">
                                                    <img src="${pageContext.request.contextPath}/resources/assets/client/images/arrivals-img9.webp"
                                                        alt="">
                                                </div>
                                                <div class="slider-content">
                                                    <h5>Dust Coat (Gender Neutral)</h5>
                                                    <p>Sportswear</p>
                                                    <span>new</span>
                                                </div>
                                                <i class="uil uil-heart"></i>
                                            </div>
                                            <div class="slider-item">
                                                <div class="slider-img">
                                                    <img src="${pageContext.request.contextPath}/resources/assets/client/images/arrivals-img10.webp"
                                                        alt="">
                                                </div>
                                                <div class="slider-content">
                                                    <h5>Adilette Slides</h5>
                                                    <p>Men's Originals</p>
                                                    <span>new</span>
                                                </div>
                                                <i class="uil uil-heart"></i>
                                            </div>
                                            <div class="slider-item">
                                                <div class="slider-img">
                                                    <img src="${pageContext.request.contextPath}/resources/assets/client/images/arrivals-img12.webp"
                                                        alt="">
                                                </div>
                                                <div class="slider-content">
                                                    <h5>adidas x LEGO® Sport Pro Shoes</h5>
                                                    <p>Youth Sportswear</p>
                                                    <span>new</span>
                                                </div>
                                                <i class="uil uil-heart"></i>
                                            </div>
                                            <div class="slider-item">
                                                <div class="slider-img">
                                                    <img src="${pageContext.request.contextPath}/resources/assets/client/images/arrivals-img13.webp"
                                                        alt="">
                                                </div>
                                                <div class="slider-content">
                                                    <h5>Ultraboost 19.5 DNA Shoes</h5>
                                                    <p>Men's Sportswear</p>
                                                    <span>new</span>
                                                </div>
                                                <i class="uil uil-heart"></i>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- Use featuredProducts data for slider -->
                                            <c:forEach items="${featuredProducts}" var="product" varStatus="status">
                                                <div class="slider-item">
                                                    <div class="slider-img ${status.index < 2 ? 'off' : ''}">
                                                        <img src="${pageContext.request.contextPath}/resources/assets/client/images/arrivals-img${status.index + 1 > 13 ? 1 : status.index + 1}.webp"
                                                            alt="${product.product_name}">
                                                        <div class="price-tag">$${product.price}</div>

                                                        <!-- Quick View Button -->
                                                        <div class="quick-view-overlay">
                                                            <c:url var="detailUrl" value="/product/detail">
                                                                <c:param name="id" value="${product.product_id}" />
                                                            </c:url>
                                                            <a href="${detailUrl}" class="quick-view-btn">
                                                                <spring:message code="category.quickView"
                                                                    text="QUICK VIEW" />
                                                            </a>
                                                        </div>
                                                    </div>
                                                    <div class="slider-content">
                                                        <h5>${product.product_name}</h5>
                                                        <p>${product.category_name != null ? product.category_name :
                                                            'Originals'}</p>
                                                        <span>new</span>
                                                    </div>
                                                    <i class="uil uil-heart"></i>
                                                </div>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <a class="prev">&larr;</a>
                                <a class="next">&rarr;</a>
                            </div>

                        </section>

                    </main>


                    <script src="https://kit.fontawesome.com/73713bf219.js" crossorigin="anonymous"></script>
                    <script src="${pageContext.request.contextPath}/resources/assets/client/js/mainson.js"></script>

                    <style>
                        .slider-img {
                            position: relative;
                            overflow: hidden;
                        }

                        .price-tag {
                            position: absolute;
                            top: 10px;
                            left: 10px;
                            background-color: rgba(0, 0, 0, 0.7);
                            color: white;
                            padding: 4px 8px;
                            font-size: 14px;
                            font-weight: bold;
                            border-radius: 4px;
                            z-index: 5;
                        }

                        .quick-view-overlay {
                            position: absolute;
                            top: 0;
                            left: 0;
                            width: 100%;
                            height: 100%;
                            background-color: rgba(0, 0, 0, 0.5);
                            display: flex;
                            justify-content: center;
                            align-items: center;
                            opacity: 0;
                            visibility: hidden;
                            transition: opacity 0.5s ease, visibility 0.5s ease;
                            z-index: 10;
                        }

                        .slider-img:hover .quick-view-overlay {
                            opacity: 1;
                            visibility: visible;
                        }

                        .quick-view-btn {
                            background-color: white;
                            color: black;
                            padding: 8px 12px;
                            border: 1px solid black;
                            text-transform: uppercase;
                            font-size: 12px;
                            letter-spacing: 1px;
                            transition: all 0.4s ease;
                            transform: translateY(20px);
                            opacity: 0;
                        }

                        .slider-img:hover .quick-view-btn {
                            transform: translateY(0);
                            opacity: 1;
                            transition-delay: 0.1s;
                        }

                        .quick-view-btn:hover {
                            background-color: black;
                            color: white;
                        }
                    </style>
                </body>

                </html>
                <!-- Font Awesome -->