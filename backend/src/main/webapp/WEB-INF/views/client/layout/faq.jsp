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
                    <div id="faq"
                        class="mx-auto max-w-2xl divide-y divide-gray-900/10 lg:max-w-7xl p-4 md:p-8 dark:bg-gray-800">
                        <h2
                            class="mt-2 font-header text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl dark:text-white">
                            Frequently asked questions
                        </h2>
                        <dl class="mt-10 space-y-8 divide-y divide-gray-900/10">
                            <div class="pt-8 lg:grid lg:grid-cols-12 lg:gap-8">
                                <dt
                                    class="text-base font-semibold leading-7 text-gray-900 lg:col-span-3 dark:text-gray-300">
                                    What are the benefits of regular
                                    exercise?</dt>
                                <dd class="mt-4 lg:col-span-9 lg:mt-0">
                                    <p class="text-base leading-7 text-gray-600 dark:text-gray-400">Regular exercise has
                                        numerous benefits, including improved
                                        cardiovascular health, increased muscle strength and endurance, better mood and
                                        mental health, and reduced
                                        risk of chronic diseases such as diabetes and heart disease.</p>
                                </dd>
                            </div>
                            <div class="pt-8 lg:grid lg:grid-cols-12 lg:gap-8">
                                <dt
                                    class="text-base font-semibold leading-7 text-gray-900 lg:col-span-3 dark:text-gray-300">
                                    What is a balanced diet?</dt>
                                <dd class="mt-4 lg:col-span-9 lg:mt-0">
                                    <p class="text-base leading-7 text-gray-600 dark:text-gray-400">A balanced diet
                                        includes a variety of foods from all food groups,
                                        such as fruits, vegetables, whole grains, lean proteins, and healthy fats. It
                                        provides the nutrients your body
                                        needs to function optimally and maintain good health.</p>
                                </dd>
                            </div>
                            <div class="pt-8 lg:grid lg:grid-cols-12 lg:gap-8">
                                <dt
                                    class="text-base font-semibold leading-7 text-gray-900 lg:col-span-3 dark:text-gray-300">
                                    How much water should I drink per day?</dt>
                                <dd class="mt-4 lg:col-span-9 lg:mt-0">
                                    <p class="text-base leading-7 text-gray-600 dark:text-gray-400">The amount of water
                                        you need to drink per day varies depending on
                                        factors such as your age, gender, activity level, and climate. As a general
                                        guideline, aim to drink at least 8
                                        glasses (64 ounces) of water per day, but adjust this amount based on your
                                        individual needs.</p>
                                </dd>
                            </div>
                            <div class="pt-8 lg:grid lg:grid-cols-12 lg:gap-8">
                                <dt
                                    class="text-base font-semibold leading-7 text-gray-900 lg:col-span-3 dark:text-gray-300">
                                    How can I improve my sleep quality?</dt>
                                <dd class="mt-4 lg:col-span-9 lg:mt-0">
                                    <p class="text-base leading-7 text-gray-600 dark:text-gray-400">To improve your
                                        sleep quality, establish a regular sleep schedule,
                                        create a relaxing bedtime routine, ensure your sleep environment is comfortable
                                        and conducive to sleep, limit
                                        screen time before bed, avoid caffeine and heavy meals close to bedtime, and
                                        manage stress through relaxation
                                        techniques such as meditation or deep breathing exercises.</p>
                                </dd>
                            </div>
                            <div class="pt-8 lg:grid lg:grid-cols-12 lg:gap-8">
                                <dt
                                    class="text-base font-semibold leading-7 text-gray-900 lg:col-span-3 dark:text-gray-300">
                                    What are the benefits of mindfulness meditation?</dt>
                                <dd class="mt-4 lg:col-span-9 lg:mt-0">
                                    <p class="text-base leading-7 text-gray-600 dark:text-gray-400">Mindfulness
                                        meditation has been shown to reduce stress, anxiety,
                                        and depression, improve attention and focus, promote emotional well-being,
                                        enhance self-awareness and
                                        introspection, and contribute to overall mental and physical health.</p>
                                </dd>
                            </div>
                            <div class="pt-8 lg:grid lg:grid-cols-12 lg:gap-8">
                                <dt
                                    class="text-base font-semibold leading-7 text-gray-900 lg:col-span-3 dark:text-gray-300">
                                    What are the signs of dehydration?</dt>
                                <dd class="mt-4 lg:col-span-9 lg:mt-0">
                                    <p class="text-base leading-7 text-gray-600 dark:text-gray-400">Signs of dehydration
                                        include thirst, dark-colored urine, infrequent
                                        urination, dry mouth, fatigue, dizziness, and confusion. It's important to drink
                                        water regularly throughout
                                        the day to prevent dehydration.</p>
                                </dd>
                            </div>
                            <div class="pt-8 lg:grid lg:grid-cols-12 lg:gap-8">
                                <dt
                                    class="text-base font-semibold leading-7 text-gray-900 lg:col-span-3 dark:text-gray-300">
                                    How can I reduce stress in my daily life?</dt>
                                <dd class="mt-4 lg:col-span-9 lg:mt-0">
                                    <p class="text-base leading-7 text-gray-600 dark:text-gray-400">To reduce stress,
                                        incorporate stress-relief techniques into your
                                        daily routine, such as exercise, meditation, deep breathing exercises, spending
                                        time in nature, engaging in
                                        hobbies you enjoy, getting enough sleep, and maintaining a healthy work-life
                                        balance.</p>
                                </dd>
                            </div>
                            <div class="pt-8 lg:grid lg:grid-cols-12 lg:gap-8">
                                <dt
                                    class="text-base font-semibold leading-7 text-gray-900 lg:col-span-3 dark:text-gray-300">
                                    What are the benefits of quitting smoking?</dt>
                                <dd class="mt-4 lg:col-span-9 lg:mt-0">
                                    <p class="text-base leading-7 text-gray-600 dark:text-gray-400">Quitting smoking has
                                        numerous health benefits, including reduced
                                        risk of cancer, heart disease, stroke, respiratory diseases, and other
                                        smoking-related illnesses. It also
                                        improves lung function, enhances circulation, boosts immune function, and
                                        increases life expectancy.</p>
                                </dd>
                            </div>
                        </dl>
                    </div>
                    <jsp:include page="footer.jsp" />


                </body>

                </html>
                <!-- Font Awesome -->