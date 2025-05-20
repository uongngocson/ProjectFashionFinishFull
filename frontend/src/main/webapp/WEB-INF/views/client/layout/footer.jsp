<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

                <footer class="bg-gradient-to-br from-zinc-800 to-black text-white py-12 mt-8">
                    <div class="container mx-auto px-4">
                        <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
                            <div>
                                <img src="/client/img/logo.webp" alt="Logo" class="h-12 mb-4">
                                <p class="text-gray-400 mb-4 text-sm">Your one-stop shop for affordable and stylish clothing.</p>
                                <div class="flex space-x-4">
                                    <a href="#" class="text-gray-400 hover:text-white transition">
                                        <i class="fab fa-facebook-f"></i>
                                    </a>
                                    <a href="#" class="text-gray-400 hover:text-white transition">
                                        <i class="fab fa-twitter"></i>
                                    </a>
                                    <a href="#" class="text-gray-400 hover:text-white transition">
                                        <i class="fab fa-instagram"></i>
                                    </a>
                                    <a href="#" class="text-gray-400 hover:text-white transition">
                                        <i class="fab fa-youtube"></i>
                                    </a>
                                </div>
                            </div>

                            <div>
                                <h4 class="text-lg font-semibold mb-4">Quick Links</h4>
                                <ul class="space-y-2 text-sm text-gray-400">
                                    <li><a href="#" class="hover:text-white transition">Home</a></li>
                                    <li><a href="#" class="hover:text-white transition">Shop</a></li>
                                    <li><a href="#" class="hover:text-white transition">Categories</a></li>
                                    <li><a href="#" class="hover:text-white transition">About Us</a></li>
                                    <li><a href="#" class="hover:text-white transition">Contact</a></li>
                                </ul>
                            </div>

                            <div>
                                <h4 class="text-lg font-semibold mb-4">Customer Service</h4>
                                <ul class="space-y-2 text-sm text-gray-400">
                                    <li><a href="#" class="hover:text-white transition">FAQ</a></li>
                                    <li><a href="#" class="hover:text-white transition">Shipping & Returns</a></li>
                                    <li><a href="#" class="hover:text-white transition">Store Policy</a></li>
                                    <li><a href="#" class="hover:text-white transition">Payment Methods</a></li>
                                    <li><a href="#" class="hover:text-white transition">Loyalty Program</a></li>
                                </ul>
                            </div>

                            <div>
                                <h4 class="text-lg font-semibold mb-4">Subscribe to Our Newsletter</h4>
                                <p class="text-gray-400 mb-4 text-sm">Get updates on new arrivals, special offers and more.</p>
                                <form class="flex">
                                    <input type="email" placeholder="Your email address"
                                        class="px-4 py-2 bg-zinc-700 text-white placeholder-gray-400 rounded-l-md flex-grow text-sm focus:outline-none">
                                    <button type="submit"
                                        class="bg-purple-600 text-white px-4 py-2 rounded-r-md hover:bg-purple-700 transition text-sm">
                                        Subscribe
                                    </button>
                                </form>
                            </div>
                        </div>

                        <hr class="border-zinc-700 my-8">

                        <div class="flex flex-col md:flex-row justify-between items-center text-sm text-gray-400">
                            <div>© 2023 AlphaMart. All rights reserved.</div>
                            <div class="mt-4 md:mt-0 flex space-x-4">
                                <a href="#" class="hover:text-white transition">Privacy Policy</a>
                                <a href="#" class="hover:text-white transition">Terms of Service</a>
                                <a href="#" class="hover:text-white transition">Cookie Policy</a>
                            </div>
                        </div>
                    </div>
                </footer>

                <!-- Include chatbot button -->
                <jsp:include page="chatbot-button.jsp" />