<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta http-equiv="X-UA-Compatible" content="IE=edge">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Document</title>
                    <script src="https://cdn.tailwindcss.com"></script>

                    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link rel="stylesheet" href="../../../../resources/assets/client/css/sontest.css">
                    <link
                        href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap"
                        rel="stylesheet">
                    <!-- <link rel="stylesheet"
                        href="${pageContext.request.contextPath}/resources/assets/client/css/style.css"> -->

                    <link rel="icon"
                        href="${pageContext.request.contextPath}/resources/assets/client/images/icon-adidas-logo.svg"
                        type="image/icon type">

                </head>



                <body>
                    <jsp:include page="navbar.jsp" />
                    <div class="relative bg-gray-50 px-6 pt-16 pb-20 lg:px-8 lg:pt-24 lg:pb-28">
                        <div class="absolute inset-0">
                            <div class="h-1/3 bg-white sm:h-2/3"></div>
                        </div>
                        <div class="relative mx-auto max-w-7xl">
                            <div class="text-center">
                                <h2 class="text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl">Column me
                                    neatly.</h2>
                                <p class="mx-auto mt-3 max-w-2xl text-xl text-gray-500 sm:mt-4">
                                    This is your life and it's ending one minute @ a time...</p>
                            </div>
                            <div class="mx-auto mt-12 grid max-w-lg gap-5 lg:max-w-none lg:grid-cols-3">

                                <div class="flex flex-col overflow-hidden rounded-lg shadow-lg">
                                    <div class="flex-shrink-0">
                                        <img class="h-48 w-full object-cover"
                                            src="https://images.unsplash.com/photo-1496128858413-b36217c2ce36?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=crop&amp;w=1679&amp;q=80"
                                            alt="">
                                    </div>
                                    <div class="flex flex-1 flex-col justify-between bg-white p-6">
                                        <div class="flex-1">
                                            <p class="text-sm font-medium text-indigo-600">
                                                <a href="#" class="hover:underline">Article</a>
                                            </p>
                                            <a href="#" class="mt-2 block">
                                                <p class="text-xl font-semibold text-gray-900">Boost your conversion
                                                    rate</p>
                                                <p class="mt-3 text-base text-gray-500">Lorem ipsum dolor sit amet
                                                    consectetur adipisicing elit.
                                                    Architecto accusantium praesentium eius, ut atque fuga culpa,
                                                    similique sequi cum eos quis dolorum.</p>
                                            </a>
                                        </div>
                                        <div class="mt-6 flex items-center">
                                            <div class="flex-shrink-0">
                                                <a href="#">
                                                    <span class="sr-only">Roel Aufderehar</span>
                                                    <img class="h-10 w-10 rounded-full"
                                                        src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=facearea&amp;facepad=2&amp;w=256&amp;h=256&amp;q=80"
                                                        alt="">
                                                </a>
                                            </div>
                                            <div class="ml-3">
                                                <p class="text-sm font-medium text-gray-900">
                                                    <a href="#" class="hover:underline">Roel Aufderehar</a>
                                                </p>
                                                <div class="flex space-x-1 text-sm text-gray-500">
                                                    <time datetime="2020-03-16">Mar 16, 2020</time>
                                                    <span aria-hidden="true">·</span>
                                                    <span>6 min read</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="flex flex-col overflow-hidden rounded-lg shadow-lg">
                                    <div class="flex-shrink-0">
                                        <img class="h-48 w-full object-cover"
                                            src="https://images.unsplash.com/photo-1547586696-ea22b4d4235d?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=crop&amp;w=1679&amp;q=80"
                                            alt="">
                                    </div>
                                    <div class="flex flex-1 flex-col justify-between bg-white p-6">
                                        <div class="flex-1">
                                            <p class="text-sm font-medium text-indigo-600">
                                                <a href="#" class="hover:underline">Video</a>
                                            </p>
                                            <a href="#" class="mt-2 block">
                                                <p class="text-xl font-semibold text-gray-900">How to use search engine
                                                    optimization to drive sales</p>
                                                <p class="mt-3 text-base text-gray-500">Lorem ipsum dolor sit amet
                                                    consectetur adipisicing elit. Velit
                                                    facilis asperiores porro quaerat doloribus, eveniet dolore. Adipisci
                                                    tempora aut inventore optio animi.,
                                                    tempore temporibus quo laudantium.</p>
                                            </a>
                                        </div>
                                        <div class="mt-6 flex items-center">
                                            <div class="flex-shrink-0">
                                                <a href="#">
                                                    <span class="sr-only">Brenna Goyette</span>
                                                    <img class="h-10 w-10 rounded-full"
                                                        src="https://images.unsplash.com/photo-1550525811-e5869dd03032?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=facearea&amp;facepad=2&amp;w=256&amp;h=256&amp;q=80"
                                                        alt="">
                                                </a>
                                            </div>
                                            <div class="ml-3">
                                                <p class="text-sm font-medium text-gray-900">
                                                    <a href="#" class="hover:underline">Brenna Goyette</a>
                                                </p>
                                                <div class="flex space-x-1 text-sm text-gray-500">
                                                    <time datetime="2020-03-10">Mar 10, 2020</time>
                                                    <span aria-hidden="true">·</span>
                                                    <span>4 min read</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="flex flex-col overflow-hidden rounded-lg shadow-lg">
                                    <div class="flex-shrink-0">
                                        <img class="h-48 w-full object-cover"
                                            src="https://images.unsplash.com/photo-1492724441997-5dc865305da7?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=crop&amp;w=1679&amp;q=80"
                                            alt="">
                                    </div>
                                    <div class="flex flex-1 flex-col justify-between bg-white p-6">
                                        <div class="flex-1">
                                            <p class="text-sm font-medium text-indigo-600">
                                                <a href="#" class="hover:underline">Case Study</a>
                                            </p>
                                            <a href="#" class="mt-2 block">
                                                <p class="text-xl font-semibold text-gray-900">Improve your customer
                                                    experience</p>
                                                <p class="mt-3 text-base text-gray-500">Lorem ipsum dolor sit amet
                                                    consectetur adipisicing elit. Sint
                                                    harum rerum voluptatem quo recusandae magni placeat saepe molestiae,
                                                    sed excepturi cumque corporis
                                                    perferendis hic.</p>
                                            </a>
                                        </div>
                                        <div class="mt-6 flex items-center">
                                            <div class="flex-shrink-0">
                                                <a href="#">
                                                    <span class="sr-only">Daniela Metz</span>
                                                    <img class="h-10 w-10 rounded-full"
                                                        src="https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=facearea&amp;facepad=2&amp;w=256&amp;h=256&amp;q=80"
                                                        alt="">
                                                </a>
                                            </div>
                                            <div class="ml-3">
                                                <p class="text-sm font-medium text-gray-900">
                                                    <a href="#" class="hover:underline">Daniela Metz</a>
                                                </p>
                                                <div class="flex space-x-1 text-sm text-gray-500">
                                                    <time datetime="2020-02-12">Feb 12, 2020</time>
                                                    <span aria-hidden="true">·</span>
                                                    <span>11 min read</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div class="relative mx-auto max-w-7xl">

                            <div class="mx-auto mt-12 grid max-w-lg gap-5 lg:max-w-none lg:grid-cols-3">

                                <div class="flex flex-col overflow-hidden rounded-lg shadow-lg">
                                    <div class="flex-shrink-0">
                                        <img class="h-48 w-full object-cover"
                                            src="https://images.unsplash.com/photo-1496128858413-b36217c2ce36?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=crop&amp;w=1679&amp;q=80"
                                            alt="">
                                    </div>
                                    <div class="flex flex-1 flex-col justify-between bg-white p-6">
                                        <div class="flex-1">
                                            <p class="text-sm font-medium text-indigo-600">
                                                <a href="#" class="hover:underline">Article</a>
                                            </p>
                                            <a href="#" class="mt-2 block">
                                                <p class="text-xl font-semibold text-gray-900">Boost your conversion
                                                    rate</p>
                                                <p class="mt-3 text-base text-gray-500">Lorem ipsum dolor sit amet
                                                    consectetur adipisicing elit.
                                                    Architecto accusantium praesentium eius, ut atque fuga culpa,
                                                    similique sequi cum eos quis dolorum.</p>
                                            </a>
                                        </div>
                                        <div class="mt-6 flex items-center">
                                            <div class="flex-shrink-0">
                                                <a href="#">
                                                    <span class="sr-only">Roel Aufderehar</span>
                                                    <img class="h-10 w-10 rounded-full"
                                                        src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=facearea&amp;facepad=2&amp;w=256&amp;h=256&amp;q=80"
                                                        alt="">
                                                </a>
                                            </div>
                                            <div class="ml-3">
                                                <p class="text-sm font-medium text-gray-900">
                                                    <a href="#" class="hover:underline">Roel Aufderehar</a>
                                                </p>
                                                <div class="flex space-x-1 text-sm text-gray-500">
                                                    <time datetime="2020-03-16">Mar 16, 2020</time>
                                                    <span aria-hidden="true">·</span>
                                                    <span>6 min read</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="flex flex-col overflow-hidden rounded-lg shadow-lg">
                                    <div class="flex-shrink-0">
                                        <img class="h-48 w-full object-cover"
                                            src="https://images.unsplash.com/photo-1547586696-ea22b4d4235d?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=crop&amp;w=1679&amp;q=80"
                                            alt="">
                                    </div>
                                    <div class="flex flex-1 flex-col justify-between bg-white p-6">
                                        <div class="flex-1">
                                            <p class="text-sm font-medium text-indigo-600">
                                                <a href="#" class="hover:underline">Video</a>
                                            </p>
                                            <a href="#" class="mt-2 block">
                                                <p class="text-xl font-semibold text-gray-900">How to use search engine
                                                    optimization to drive sales</p>
                                                <p class="mt-3 text-base text-gray-500">Lorem ipsum dolor sit amet
                                                    consectetur adipisicing elit. Velit
                                                    facilis asperiores porro quaerat doloribus, eveniet dolore. Adipisci
                                                    tempora aut inventore optio animi.,
                                                    tempore temporibus quo laudantium.</p>
                                            </a>
                                        </div>
                                        <div class="mt-6 flex items-center">
                                            <div class="flex-shrink-0">
                                                <a href="#">
                                                    <span class="sr-only">Brenna Goyette</span>
                                                    <img class="h-10 w-10 rounded-full"
                                                        src="https://images.unsplash.com/photo-1550525811-e5869dd03032?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=facearea&amp;facepad=2&amp;w=256&amp;h=256&amp;q=80"
                                                        alt="">
                                                </a>
                                            </div>
                                            <div class="ml-3">
                                                <p class="text-sm font-medium text-gray-900">
                                                    <a href="#" class="hover:underline">Brenna Goyette</a>
                                                </p>
                                                <div class="flex space-x-1 text-sm text-gray-500">
                                                    <time datetime="2020-03-10">Mar 10, 2020</time>
                                                    <span aria-hidden="true">·</span>
                                                    <span>4 min read</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="flex flex-col overflow-hidden rounded-lg shadow-lg">
                                    <div class="flex-shrink-0">
                                        <img class="h-48 w-full object-cover"
                                            src="https://images.unsplash.com/photo-1492724441997-5dc865305da7?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=crop&amp;w=1679&amp;q=80"
                                            alt="">
                                    </div>
                                    <div class="flex flex-1 flex-col justify-between bg-white p-6">
                                        <div class="flex-1">
                                            <p class="text-sm font-medium text-indigo-600">
                                                <a href="#" class="hover:underline">Case Study</a>
                                            </p>
                                            <a href="#" class="mt-2 block">
                                                <p class="text-xl font-semibold text-gray-900">Improve your customer
                                                    experience</p>
                                                <p class="mt-3 text-base text-gray-500">Lorem ipsum dolor sit amet
                                                    consectetur adipisicing elit. Sint
                                                    harum rerum voluptatem quo recusandae magni placeat saepe molestiae,
                                                    sed excepturi cumque corporis
                                                    perferendis hic.</p>
                                            </a>
                                        </div>
                                        <div class="mt-6 flex items-center">
                                            <div class="flex-shrink-0">
                                                <a href="#">
                                                    <span class="sr-only">Daniela Metz</span>
                                                    <img class="h-10 w-10 rounded-full"
                                                        src="https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=facearea&amp;facepad=2&amp;w=256&amp;h=256&amp;q=80"
                                                        alt="">
                                                </a>
                                            </div>
                                            <div class="ml-3">
                                                <p class="text-sm font-medium text-gray-900">
                                                    <a href="#" class="hover:underline">Daniela Metz</a>
                                                </p>
                                                <div class="flex space-x-1 text-sm text-gray-500">
                                                    <time datetime="2020-02-12">Feb 12, 2020</time>
                                                    <span aria-hidden="true">·</span>
                                                    <span>11 min read</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <jsp:include page="footer.jsp" />


                </body>

                </html>
                <!-- Font Awesome -->