<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>ÉLÉGANCE | Our Story</title>
                <script src="https://cdn.tailwindcss.com"></script>
                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link
                    href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Montserrat:wght@300;400;500&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="${ctx}/resources/assets/client/css/aboutus.css">
            </head>

            <body class="bg-white">

                <!-- Navigation -->
                <jsp:include page="../layout/navbar.jsp" />


                <!-- Hero Banner -->
                <div class="pt-20 relative pt-[64px]">
                    <div class="h-screen-70 max-h-[700px] overflow-hidden">
                        <img src="https://images.unsplash.com/photo-1483985988355-763728e1935b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80"
                            alt="Fashion Atelier" class="w-full h-full object-cover object-center">
                    </div>
                    <div class="absolute inset-0 flex items-center justify-center bg-black bg-opacity-20">
                        <h1 class="playfair text-5xl md:text-7xl text-white tracking-wider">OUR STORY</h1>
                    </div>
                </div>

                <!-- Brand Story Section -->
                <div class="max-w-7xl mx-auto px-6 py-20 md:py-28">
                    <div class="flex flex-col md:flex-row gap-12">
                        <div class="md:w-1/2">
                            <h2 class="playfair text-3xl md:text-4xl mb-8">The ÉLÉGANCE Manifesto</h2>
                            <p class="mb-6 leading-relaxed">
                                Founded in Paris, 1987, ÉLÉGANCE emerged from a singular vision: to create garments that
                                transcend time.
                                Our collections are not dictated by seasons, but by the enduring principles of
                                craftsmanship, proportion,
                                and the finest materials.
                            </p>
                            <p class="leading-relaxed">
                                Each piece is conceived in our ateliers where master tailors employ techniques passed
                                down through generations.
                                We believe true luxury lies in the details—the precise drape of fabric, the exacting
                                placement of each seam,
                                the whisper of silk against skin. This is fashion as art, as legacy, as the purest
                                expression of self.
                            </p>
                        </div>
                        <div class="md:w-1/2">
                            <div class="h-96 md:h-full overflow-hidden">
                                <img src="https://images.unsplash.com/photo-1595341595379-cf2df1c6cbfe?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80"
                                    alt="Designer's Studio" class="w-full h-full object-cover object-center">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Timeline Section -->
                <div class="bg-gray-50 py-20">
                    <div class="max-w-4xl mx-auto px-6">
                        <h2 class="playfair text-3xl text-center mb-16">Our Journey</h2>
                        <div class="grid grid-cols-1 md:grid-cols-5 gap-8">
                            <!-- Timeline Item 1 -->
                            <div class="timeline-item relative text-center">
                                <div
                                    class="w-12 h-12 mx-auto mb-4 flex items-center justify-center border border-black rounded-full">
                                    <i class="fas fa-flag"></i>
                                </div>
                                <h3 class="playfair font-bold mb-2">1987</h3>
                                <p class="text-sm">Founded in Paris by Isabelle Laurent</p>
                            </div>
                            <!-- Timeline Item 2 -->
                            <div class="timeline-item relative text-center">
                                <div
                                    class="w-12 h-12 mx-auto mb-4 flex items-center justify-center border border-black rounded-full">
                                    <i class="fas fa-store"></i>
                                </div>
                                <h3 class="playfair font-bold mb-2">1995</h3>
                                <p class="text-sm">First flagship opens on Avenue Montaigne</p>
                            </div>
                            <!-- Timeline Item 3 -->
                            <div class="timeline-item relative text-center">
                                <div
                                    class="w-12 h-12 mx-auto mb-4 flex items-center justify-center border border-black rounded-full">
                                    <i class="fas fa-globe"></i>
                                </div>
                                <h3 class="playfair font-bold mb-2">2003</h3>
                                <p class="text-sm">International expansion begins</p>
                            </div>
                            <!-- Timeline Item 4 -->
                            <div class="timeline-item relative text-center">
                                <div
                                    class="w-12 h-12 mx-auto mb-4 flex items-center justify-center border border-black rounded-full">
                                    <i class="fas fa-leaf"></i>
                                </div>
                                <h3 class="playfair font-bold mb-2">2012</h3>
                                <p class="text-sm">Sustainable luxury initiative launched</p>
                            </div>
                            <!-- Timeline Item 5 -->
                            <div class="timeline-item relative text-center">
                                <div
                                    class="w-12 h-12 mx-auto mb-4 flex items-center justify-center border border-black rounded-full">
                                    <i class="fas fa-award"></i>
                                </div>
                                <h3 class="playfair font-bold mb-2">2020</h3>
                                <p class="text-sm">CFDA International Designer Award</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Meet the Team -->
                <div class="max-w-7xl mx-auto px-6 py-20">
                    <h2 class="playfair text-3xl text-center mb-16">The Visionaries</h2>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                        <!-- Team Member 1 -->
                        <div class="team-card relative overflow-hidden">
                            <div class="h-96 overflow-hidden">
                                <img src="https://images.unsplash.com/photo-1551836022-d5d88e9218df?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80"
                                    alt="Isabelle Laurent" class="w-full h-full object-cover object-center">
                            </div>
                            <div
                                class="team-overlay absolute inset-0 bg-black bg-opacity-50 flex items-center justify-center opacity-0 transition-opacity duration-300">
                                <div class="text-center text-white px-4">
                                    <p class="text-sm mb-4">"Fashion is the armor to survive reality."</p>
                                    <div class="flex justify-center space-x-4">
                                        <a href="#"><i class="fab fa-instagram"></i></a>
                                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                                    </div>
                                </div>
                            </div>
                            <div class="mt-4 text-center">
                                <h3 class="playfair font-bold">Isabelle Laurent</h3>
                                <p class="text-sm">Founder & Creative Director</p>
                            </div>
                        </div>
                        <!-- Team Member 2 -->
                        <div class="team-card relative overflow-hidden">
                            <div class="h-96 overflow-hidden">
                                <img src="https://images.unsplash.com/photo-1560259937-1d0f9856d3bf?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80"
                                    alt="Jean-Luc Moreau" class="w-full h-full object-cover object-center">
                            </div>
                            <div
                                class="team-overlay absolute inset-0 bg-black bg-opacity-50 flex items-center justify-center opacity-0 transition-opacity duration-300">
                                <div class="text-center text-white px-4">
                                    <p class="text-sm mb-4">"Precision is the difference between clothing and couture."
                                    </p>
                                    <div class="flex justify-center space-x-4">
                                        <a href="#"><i class="fab fa-instagram"></i></a>
                                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                                    </div>
                                </div>
                            </div>
                            <div class="mt-4 text-center">
                                <h3 class="playfair font-bold">Jean-Luc Moreau</h3>
                                <p class="text-sm">Head of Design</p>
                            </div>
                        </div>
                        <!-- Team Member 3 -->
                        <div class="team-card relative overflow-hidden">
                            <div class="h-96 overflow-hidden">
                                <img src="https://images.unsplash.com/photo-1573496359142-b8d87734a5cd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1976&q=80"
                                    alt="Sophie Dubois" class="w-full h-full object-cover object-center">
                            </div>
                            <div
                                class="team-overlay absolute inset-0 bg-black bg-opacity-50 flex items-center justify-center opacity-0 transition-opacity duration-300">
                                <div class="text-center text-white px-4">
                                    <p class="text-sm mb-4">"Sustainability is the future of true luxury."</p>
                                    <div class="flex justify-center space-x-4">
                                        <a href="#"><i class="fab fa-instagram"></i></a>
                                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                                    </div>
                                </div>
                            </div>
                            <div class="mt-4 text-center">
                                <h3 class="playfair font-bold">Sophie Dubois</h3>
                                <p class="text-sm">Director of Sustainability</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Mission Statement -->

                <section class="py-20 bg-white">
                    <div class="max-w-7xl mx-auto px-6 grid grid-cols-1 lg:grid-cols-2 gap-12 items-start">

                        <!-- Google Map -->
                        <div class="w-full h-[400px]">
                            <iframe
                                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d593.931523505795!2d106.70042706755679!3d10.789476977757996!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x317528b545b5903b%3A0x2381a6fe3f690419!2zSOG7jWMgdmnhu4duIEPDtG5nIG5naOG7hyBCxrB1IGNow61uaCBWaeG7hW4gdGjDtG5nIEPGoSBz4bufIHThuqFpIFRQLiBI4buTIENow60gTWluaA!5e0!3m2!1svi!2s!4v1745320296397!5m2!1svi!2s"
                                width="600" height="450" style="border: 2px solid black;" allowfullscreen=""
                                loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                        </div>

                        <!-- Contact Form -->
                        <div class="w-full">
                            <h2 class="text-2xl font-serif mb-6">Liên hệ với chúng tôi</h2>
                            <form class="space-y-4">
                                <input type="text" placeholder="Họ và tên"
                                    class="w-full px-4 py-3 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-black transition">

                                <input type="email" placeholder="Email"
                                    class="w-full px-4 py-3 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-black transition">

                                <textarea rows="5" placeholder="Nội dung tin nhắn"
                                    class="w-full px-4 py-3 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-black transition"></textarea>

                                <button type="submit"
                                    class="px-6 py-3 bg-black text-white uppercase tracking-wider hover:bg-gray-800 transition rounded">
                                    Gửi tin nhắn
                                </button>
                            </form>
                        </div>

                    </div>
                </section>

                <!-- Footer -->
                <jsp:include page="../layout/footer.jsp" />
            </body>

            </html>