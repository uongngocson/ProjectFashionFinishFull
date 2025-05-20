<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

                <footer class="bg-white py-16 border-t border-gray-100">
                    <div class="max-w-7xl mx-auto px-6">
                        <div class="grid grid-cols-1 md:grid-cols-4 gap-12">
                            <div>
                                <h3 class="text-xl mb-6">DDTS</h3>
                                <p class="text-sm text-gray-600 mb-6">
                                    <spring:message code="footer.description" />
                                </p>
                                <div class="flex space-x-4">
                                    <a href="#"><i class="fa-brands fa-instagram"></i></a>
                                    <a href="#"><i class="fa-brands fa-facebook-f"></i></a>
                                    <a href="#"><i class="fa-brands fa-pinterest-p"></i></a>
                                    <a href="#"><i class="fa-brands fa-twitter"></i></a>
                                </div>
                            </div>

                            <div>
                                <h4 class="uppercase text-sm tracking-wider mb-6">
                                    <spring:message code="footer.shop" />
                                </h4>
                                <ul class="space-y-3">
                                    <li><a href="#"
                                            class="text-sm text-gray-600 hover:text-black transition duration-300">
                                            <spring:message code="footer.women" />
                                        </a></li>
                                    <li><a href="#"
                                            class="text-sm text-gray-600 hover:text-black transition duration-300">
                                            <spring:message code="footer.men" />
                                        </a></li>
                                    <li><a href="#"
                                            class="text-sm text-gray-600 hover:text-black transition duration-300">
                                            <spring:message code="footer.accessories" />
                                        </a></li>
                                    <li><a href="#"
                                            class="text-sm text-gray-600 hover:text-black transition duration-300">
                                            <spring:message code="footer.newArrivals" />
                                        </a></li>
                                    <li><a href="#"
                                            class="text-sm text-gray-600 hover:text-black transition duration-300">
                                            <spring:message code="footer.promotions" />
                                        </a></li>
                                </ul>
                            </div>

                            <div>
                                <h4 class="uppercase text-sm tracking-wider mb-6">
                                    <spring:message code="footer.info" />
                                </h4>
                                <ul class="space-y-3">
                                    <li><a href="/about"
                                            class="text-sm text-gray-600 hover:text-black transition duration-300">
                                            <spring:message code="footer.aboutUs" />
                                        </a></li>
                                    <li><a href="#"
                                            class="text-sm text-gray-600 hover:text-black transition duration-300">
                                            <spring:message code="footer.magazine" />
                                        </a></li>
                                    <li><a href="#"
                                            class="text-sm text-gray-600 hover:text-black transition duration-300">
                                            <spring:message code="footer.sustainability" />
                                        </a></li>
                                    <li><a href="#"
                                            class="text-sm text-gray-600 hover:text-black transition duration-300">
                                            <spring:message code="footer.careers" />
                                        </a></li>
                                    <li><a href="#"
                                            class="text-sm text-gray-600 hover:text-black transition duration-300">
                                            <spring:message code="footer.contact" />
                                        </a></li>
                                </ul>
                            </div>

                            <div>
                                <h4 class="uppercase text-sm tracking-wider mb-6">
                                    <spring:message code="footer.customerService" />
                                </h4>
                                <ul class="space-y-3">
                                    <li><a href="#"
                                            class="text-sm text-gray-600 hover:text-black transition duration-300">
                                            <spring:message code="footer.shippingReturns" />
                                        </a></li>
                                    <li><a href="#"
                                            class="text-sm text-gray-600 hover:text-black transition duration-300">
                                            <spring:message code="footer.storePolicy" />
                                        </a></li>
                                    <li><a href="#"
                                            class="text-sm text-gray-600 hover:text-black transition duration-300">
                                            <spring:message code="footer.paymentMethods" />
                                        </a></li>
                                    <li><a href="/faq"
                                            class="text-sm text-gray-600 hover:text-black transition duration-300">
                                            <spring:message code="footer.faq" />
                                        </a></li>
                                </ul>
                            </div>
                        </div>

                        <div
                            class="border-t border-gray-100 mt-16 pt-8 flex flex-col md:flex-row justify-between items-center">
                            <p class="text-xs text-gray-500 mb-4 md:mb-0">
                                <spring:message code="footer.copyright" />
                            </p>
                            <div class="flex space-x-6">
                                <a href="#" class="text-xs text-gray-500 hover:text-black transition duration-300">
                                    <spring:message code="footer.privacyPolicy" />
                                </a>
                                <a href="#" class="text-xs text-gray-500 hover:text-black transition duration-300">
                                    <spring:message code="footer.termsOfUse" />
                                </a>
                            </div>
                        </div>
                    </div>
                </footer>