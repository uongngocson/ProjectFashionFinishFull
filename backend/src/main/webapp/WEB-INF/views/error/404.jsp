<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Không tìm thấy trang | FullStackWeb2025News</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
            <style>
                body {
                    background-color: #f8f9fa;
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    color: #333;
                }

                .error-container {
                    max-width: 800px;
                    margin: 0 auto;
                    padding: 60px 20px;
                    text-align: center;
                }

                .error-code {
                    font-size: 120px;
                    font-weight: 700;
                    margin: 0;
                    color: #3f51b5;
                    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
                }

                .error-message {
                    font-size: 24px;
                    font-weight: 500;
                    margin: 20px 0 30px;
                }

                .error-description {
                    font-size: 18px;
                    margin-bottom: 30px;
                    color: #6c757d;
                }

                .btn-home {
                    background-color: #3f51b5;
                    color: white;
                    padding: 12px 25px;
                    border-radius: 4px;
                    font-weight: 500;
                    text-decoration: none;
                    transition: all 0.3s ease;
                }

                .btn-home:hover {
                    background-color: #303f9f;
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                    color: white;
                }

                .error-illustration {
                    max-width: 100%;
                    height: auto;
                    margin: 20px 0 40px;
                }
            </style>
        </head>

        <body>
            <div class="container">
                <div class="error-container">
                    <h1 class="error-code">404</h1>
                    <h2 class="error-message">Không tìm thấy trang</h2>
                    <p class="error-description">
                        Trang bạn đang tìm kiếm có thể đã bị xóa, đổi tên hoặc tạm thời không khả dụng.
                    </p>
                    <img src="https://cdn.dribbble.com/users/285475/screenshots/2083086/dribbble_1.gif"
                        alt="404 Illustration" class="error-illustration">
                    <div class="mb-4">
                        <p>Bạn có thể:</p>
                        <ul class="list-unstyled">
                            <li><i class="fas fa-arrow-left me-2"></i> Quay lại trang trước đó</li>
                            <li><i class="fas fa-home me-2"></i> Trở về trang chủ</li>
                            <li><i class="fas fa-search me-2"></i> Tìm kiếm nội dung khác</li>
                        </ul>
                    </div>
                    <a href="<c:url value='/' />" class="btn btn-home">
                        <i class="fas fa-home me-2"></i> Trở về trang chủ
                    </a>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                // Add click event to back button
                document.addEventListener('DOMContentLoaded', function () {
                    document.querySelector('.list-unstyled li:first-child').addEventListener('click', function () {
                        window.history.back();
                    });
                });
            </script>
        </body>

        </html>