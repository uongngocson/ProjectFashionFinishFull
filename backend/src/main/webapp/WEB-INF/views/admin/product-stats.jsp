<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Product Statistics</title>
    <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
    <link rel="icon" href="${pageContext.request.contextPath}/resources/assets/dashboard/img/kaiadmin/favicon.ico" type="image/x-icon" />
    <script src="${pageContext.request.contextPath}/resources/assets/dashboard/js/plugin/webfont/webfont.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/dashboard/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/dashboard/css/plugins.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/dashboard/css/kaiadmin.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/dashboard/css/demo.css" />
    <style>
        #previewTable {
            margin-top: 20px;
            border-collapse: collapse;
            width: 100%;
        }
        #previewTable th, #previewTable td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        #previewTable th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
        #previewTable tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        #previewTable tr:hover {
            background-color: #f1f1f1;
        }
        @media print {
            body * {
                visibility: hidden;
            }
            #previewTable, #previewTable * {
                visibility: visible;
            }
            #previewTable {
                position: absolute;
                left: 0;
                top: 0;
            }
            .no-print {
                display: none;
            }
        }
    </style>
    <script>
        WebFont.load({
            google: { families: ["Public Sans:300,400,500,600,700"] },
            custom: {
                families: [
                    "Font Awesome 5 Solid",
                    "Font Awesome 5 Regular",
                    "Font Awesome 5 Brands",
                    "simple-line-icons",
                ],
                urls: ["${pageContext.request.contextPath}/resources/assets/dashboard/css/fonts.min.css"],
            },
            active: function () {
                sessionStorage.fonts = true;
            },
        });

        function printPreview() {
            window.print();
        }

        function setAction(action) {
            document.getElementById("reportForm").querySelector('input[name="action"]').value = action;
        }
    </script>
</head>
<body>
    <div class="wrapper">
        <jsp:include page="layout/sidebar.jsp" />
        <div class="main-panel">
            <jsp:include page="layout/header.jsp" />
            <div class="container">
                <div class="page-inner">
                    <div class="page-header">
                        <h3 class="fw-bold mb-3">Product Statistics</h3>
                        <ul class="breadcrumbs mb-3">
                            <li class="nav-home">
                                <a href="${pageContext.request.contextPath}/admin/dashboard/index">
                                    <i class="icon-home"></i>
                                </a>
                            </li>
                            <li class="separator">
                                <i class="icon-arrow-right"></i>
                            </li>
                            <li class="nav-item">
                                <a href="#">Product Statistics</a>
                            </li>
                        </ul>
                    </div>
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${errorMessage}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                    </c:if>
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${successMessage}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                    </c:if>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">Generate Product Revenue Report</h4>
                                </div>
                                <div class="card-body">
                                    <form id="reportForm" action="${pageContext.request.contextPath}/admin/product-stats/generate-report" method="post">
                                        <sec:csrfInput />
                                        <input type="hidden" name="action" value="preview" />
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="year">Year</label>
                                                    <input type="number" class="form-control" id="year" name="year" value="${year != null ? year : defaultYear}" min="2000" max="2100" required />
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="month">Month</label>
                                                    <select class="form-control" id="month" name="month" required>
                                                        <c:forEach var="m" begin="1" end="12">
                                                            <option value="${m}" ${m == (month != null ? month : defaultMonth) ? 'selected' : ''}>Month ${m}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <button type="submit" class="btn btn-primary" onclick="setAction('preview')">
                                                <i class="fas fa-eye"></i> Preview Report
                                            </button>
                                            <button type="submit" class="btn btn-info" onclick="setAction('download')">
                                                <i class="fas fa-file-pdf"></i> Download PDF
                                            </button>
                                            <a href="${pageContext.request.contextPath}/admin/dashboard/index" class="btn btn-secondary">
                                                <i class="fas fa-arrow-left"></i> Back to Dashboard
                                            </a>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Preview Table -->
                    <c:if test="${not empty productStats}">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h4 class="card-title">Product Revenue Report Preview</h4>
                                        <h5>Month: ${month}/${year}</h5>
                                    </div>
                                    <div class="card-body">
                                        <table id="previewTable">
                                            <thead>
                                                <tr>
                                                    <th>Product ID</th>
                                                    <th>Product Name</th>
                                                    <th>Total Revenue</th>
                                                    <th>Total Quantity</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="row" items="${productStats}">
                                                    <tr>
                                                        <td>${row[0] != null ? row[0] : 'Unknown'}</td>
                                                        <td>${row[1] != null ? row[1] : 'Unknown'}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${row[2] != null}">
                                                                    $<fmt:formatNumber value="${row[2]}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    Unknown
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>${row[3] != null ? row[3] : 'Unknown'}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                        <div class="form-group mt-3 no-print">
                                            <button type="button" class="btn btn-success" onclick="printPreview()">
                                                <i class="fas fa-print"></i> Print Preview
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
            <jsp:include page="layout/footer.jsp" />
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/resources/assets/dashboard/js/core/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/dashboard/js/core/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/dashboard/js/core/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/dashboard/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/dashboard/js/kaiadmin.min.js"></script>
</body>
</html>