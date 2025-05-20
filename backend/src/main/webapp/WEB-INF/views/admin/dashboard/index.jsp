<%@page contentType="text/html" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
          <meta http-equiv="X-UA-Compatible" content="IE=edge" />
          <title>Dashboard</title>
          <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />

          <c:set var="ctx" value="${pageContext.request.contextPath}" />
          <link rel="icon" href="${ctx}/resources/assets/user/img/home/walmart-logo.webp" type="image/x-icon" />

          <!-- Fonts and icons -->
          <script src="<c:url value='/resources/assets/dashboard/js/plugin/webfont/webfont.min.js'/>"></script>

          <!-- CSS Files -->
          <link rel="stylesheet" href="<c:url value='/resources/assets/dashboard/css/bootstrap.min.css'/>" />
          <link rel="stylesheet" href="<c:url value='/resources/assets/dashboard/css/plugins.min.css'/>" />
          <link rel="stylesheet" href="<c:url value='/resources/assets/dashboard/css/kaiadmin.min.css'/>" />

          <!-- CSS Just for demo purpose, don't include it in your project -->
          <link rel="stylesheet" href="<c:url value='/resources/assets/dashboard/css/demo.css'/>" />

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
                urls: ["<c:url value='/resources/assets/dashboard/css/fonts.min.css'/>"],
              },
              active: function () {
                sessionStorage.fonts = true;
              },
            });
          </script>

          <style>
            /* Đặt chiều cao cố định cho card-body chứa biểu đồ */
            #monthlyRevenueChart,
            #monthlyImportChart,
            #weeklyRevenueChart,
            #weeklyImportChart,
            #rangeRevenueChart,
            #rangeImportChart {
              max-height: 300px;
              /* Hoặc một giá trị chiều cao phù hợp khác */
              width: 100% !important;
              /* Đảm bảo chiều rộng vẫn linh hoạt */
            }

            .card-body canvas {
              height: 300px !important;
              /* Thử đặt chiều cao cố định cho canvas */
              width: 100% !important;
            }

            /* Optional: Đảm bảo card-body có thể chứa canvas */
            .card-body {
              position: relative;
              /* Cần thiết để canvas định vị đúng */
              /* Bạn có thể thử đặt min-height ở đây nếu cần */
              /* min-height: 320px; */
            }
          </style>


        </head>

        <body>
          <div class="wrapper">
            <!-- Start Sidebar -->
            <jsp:include page="../layout/sidebar.jsp" />
            <!-- End Sidebar -->

            <div class="main-panel">
              <jsp:include page="../layout/header.jsp" />

              <div class="container">
                <div class="page-inner">
                  <div class="d-flex align-items-left align-items-md-center flex-column flex-md-row pt-2 pb-4">
                    <div>
                      <h3 class="fw-bold mb-3">Thống Kê Chung</h3>
                    </div>
                  </div>
                  <%-- Form Lọc --%>
                    <div class="row mb-4">
                      <div class="col-md-12">
                        <div class="card card-round">
                          <div class="card-header">
                            <div class="card-title">Bộ lọc Thống kê</div>
                          </div>
                          <div class="card-body">
                            <form method="GET" action="<c:url value='/admin/dashboard/index'/>">
                              <div class="row g-3">
                                <%-- Bộ lọc cho Biểu đồ theo Khoảng Ngày --%>
                                  <div class="col-lg-6 border-end pe-4">
                                    <h5 class="mb-3">Lọc theo Khoảng Ngày</h5>
                                    <div class="row g-3 align-items-center mb-2">
                                      <div class="col-md-6">
                                        <label for="startDate" class="form-label">Từ ngày</label>
                                        <input type="date" class="form-control" id="startDate" name="startDate"
                                          value="${startDate}">
                                      </div>
                                      <div class="col-md-6">
                                        <label for="endDate" class="form-label">Đến ngày</label>
                                        <input type="date" class="form-control" id="endDate" name="endDate"
                                          value="${endDate}">
                                      </div>
                                    </div>
                                    <small class="form-text text-muted">Áp dụng cho biểu đồ Doanh thu/Nhập hàng theo
                                      Ngày.</small>
                                  </div>

                                  <%-- Bộ lọc cho Biểu đồ theo Tuần --%>
                                    <div class="col-lg-6 ps-4">
                                      <h5 class="mb-3">Lọc theo Tuần</h5>
                                      <div class="row g-3 align-items-center mb-2">
                                        <div class="col-md-6">
                                          <label for="year" class="form-label">Năm</label>
                                          <input type="number" class="form-control" id="year" name="year"
                                            value="${selectedYear}" min="2000" max="${currentYear + 5}">
                                        </div>
                                        <div class="col-md-6">
                                          <label for="month" class="form-label">Tháng</label>
                                          <select class="form-select" id="month" name="month">
                                            <c:forEach var="m" begin="1" end="12">
                                              <option value="${m}" ${m==selectedMonth ? 'selected' : '' }>Tháng ${m}
                                              </option>
                                            </c:forEach>
                                          </select>
                                        </div>
                                      </div>
                                      <small class="form-text text-muted">Áp dụng cho biểu đồ Doanh thu/Nhập hàng theo
                                        Tuần.</small>
                                    </div>
                              </div>
                              <div class="row mt-4">
                                <div class="col-md-12 text-center">
                                  <button type="submit" class="btn btn-primary px-4">Áp dụng bộ lọc</button>
                                </div>
                              </div>
                            </form>
                          </div>
                        </div>
                      </div>
                    </div>

                    <%-- Thẻ hiển thị các giá trị tổng --%>
                      <div class="row">
                        <div class="col-sm-6 col-md-4"> <%-- Thay đổi col-md-3 thành col-md-4 --%>
                            <div class="card card-stats card-round">
                              <div class="card-body">
                                <div class="row align-items-center">
                                  <div class="col-icon">
                                    <div class="icon-big text-center icon-success bubble-shadow-small">
                                      <i class="fas fa-dollar-sign"></i>
                                    </div>
                                  </div>
                                  <div class="col col-stats ms-3 ms-sm-0">
                                    <div class="numbers">
                                      <p class="card-category">Tổng Doanh Thu</p>
                                      <h4 class="card-title">
                                        <fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="$" />
                                      </h4>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-4"> <%-- Thêm thẻ Tổng Tiền Nhập --%>
                            <div class="card card-stats card-round">
                              <div class="card-body">
                                <div class="row align-items-center">
                                  <div class="col-icon">
                                    <div class="icon-big text-center icon-warning bubble-shadow-small">
                                      <i class="fas fa-cart-arrow-down"></i> <%-- Icon nhập hàng --%>
                                    </div>
                                  </div>
                                  <div class="col col-stats ms-3 ms-sm-0">
                                    <div class="numbers">
                                      <p class="card-category">Tổng Tiền Nhập</p>
                                      <h4 class="card-title">
                                        <fmt:formatNumber value="${totalImportValue}" type="currency"
                                          currencySymbol="$" />
                                      </h4>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-4"> <%-- Thêm thẻ Lợi Nhuận --%>
                            <div class="card card-stats card-round">
                              <div class="card-body">
                                <div class="row align-items-center">
                                  <div class="col-icon">
                                    <div class="icon-big text-center icon-info bubble-shadow-small">
                                      <i class="fas fa-chart-line"></i> <%-- Icon lợi nhuận --%>
                                    </div>
                                  </div>
                                  <div class="col col-stats ms-3 ms-sm-0">
                                    <div class="numbers">
                                      <p class="card-category">Lợi Nhuận</p>
                                      <h4 class="card-title">
                                        <fmt:formatNumber value="${profit}" type="currency" currencySymbol="$" />
                                      </h4>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                        </div>
                      </div>

                      <%-- Hàng 1: Biểu đồ theo tháng --%>
                        <div class="row">
                          <div class="col-md-6">
                            <div class="card card-round">
                              <div class="card-header">
                                <div class="card-title">Doanh Thu Theo Tháng (Năm ${currentYear})</div>
                              </div>
                              <div class="card-body">
                                <canvas id="monthlyRevenueChart" height="250"></canvas>
                              </div>
                            </div>
                          </div>
                          <div class="col-md-6">
                            <div class="card card-round">
                              <div class="card-header">
                                <div class="card-title">Giá Trị Nhập Hàng Theo Tháng (Năm ${currentYear})</div>
                              </div>
                              <div class="card-body">
                                <canvas id="monthlyImportChart" height="250"></canvas>
                              </div>
                            </div>
                          </div>
                        </div>

                        <%-- Hàng 2: Biểu đồ theo tuần (Ẩn ban đầu) --%>
                          <div class="row mt-4" id="weeklyChartsRow" style="display: none;">
                            <div class="col-md-6">
                              <div class="card card-round">
                                <div class="card-header">
                                  <div class="card-title">Doanh Thu Theo Tuần (Tháng ${selectedMonth}/${selectedYear})
                                  </div>
                                </div>
                                <div class="card-body"> <%-- Sửa vị trí --%>
                                    <canvas id="weeklyRevenueChart"></canvas> <%-- Đã bỏ height --%>
                                </div>
                              </div>
                            </div>
                            <div class="col-md-6">
                              <div class="card card-round">
                                <div class="card-header">
                                  <div class="card-title">Giá Trị Nhập Hàng Theo Tuần (Tháng
                                    ${selectedMonth}/${selectedYear})</div>
                                </div>
                                <div class="card-body"> <%-- Sửa vị trí --%>
                                    <canvas id="weeklyImportChart"></canvas> <%-- Đã bỏ height --%>
                                </div>
                              </div>
                            </div>
                          </div>

                          <%-- Hàng 3: Biểu đồ theo khoảng ngày (Ẩn ban đầu) --%>
                            <div class="row mt-4" id="dailyChartsRow" style="display: none;">
                              <div class="col-md-6">
                                <div class="card card-round">
                                  <div class="card-header">
                                    <div class="card-title">Doanh Thu Theo Ngày (${fn:escapeXml(startDate)} -
                                      ${fn:escapeXml(endDate)})</div>
                                  </div>
                                  <div class="card-body">
                                    <canvas id="rangeRevenueChart"></canvas> <%-- Đã bỏ height --%>
                                  </div>
                                </div>
                              </div>
                              <div class="col-md-6">
                                <div class="card card-round">
                                  <div class="card-header">
                                    <div class="card-title">Giá Trị Nhập Hàng Theo Ngày (${fn:escapeXml(startDate)} -
                                      ${fn:escapeXml(endDate)})</div>
                                  </div>
                                  <div class="card-body">
                                    <canvas id="rangeImportChart"></canvas> <%-- Đã bỏ height --%>
                                  </div>
                                </div>
                              </div>
                            </div>

                </div>
              </div>
              <!--   Core JS Files   -->
              <script src="<c:url value='/resources/assets/dashboard/js/core/jquery-3.7.1.min.js'/>"></script>
              <script src="<c:url value='/resources/assets/dashboard/js/core/popper.min.js'/>"></script>
              <script src="<c:url value='/resources/assets/dashboard/js/core/bootstrap.min.js'/>"></script>

              <!-- jQuery Scrollbar -->
              <script
                src="<c:url value='/resources/assets/dashboard/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js'/>"></script>

              <!-- Chart JS -->
              <script src="<c:url value='/resources/assets/dashboard/js/plugin/chart.js/chart.min.js'/>"></script>

              <!-- jQuery Sparkline -->
              <script
                src="<c:url value='/resources/assets/dashboard/js/plugin/jquery.sparkline/jquery.sparkline.min.js'/>"></script>

              <!-- Chart Circle -->
              <script src="<c:url value='/resources/assets/dashboard/js/plugin/chart-circle/circles.min.js'/>"></script>

              <!-- Datatables -->
              <script
                src="<c:url value='/resources/assets/dashboard/js/plugin/datatables/datatables.min.js'/>"></script>

              <!-- Bootstrap Notify -->
              <script
                src="<c:url value='/resources/assets/dashboard/js/plugin/bootstrap-notify/bootstrap-notify.min.js'/>"></script>

              <!-- jQuery Vector Maps -->
              <script
                src="<c:url value='/resources/assets/dashboard/js/plugin/jsvectormap/jsvectormap.min.js'/>"></script>
              <script src="<c:url value='/resources/assets/dashboard/js/plugin/jsvectormap/world.js'/>"></script>

              <!-- Sweet Alert -->
              <script
                src="<c:url value='/resources/assets/dashboard/js/plugin/sweetalert/sweetalert.min.js'/>"></script>

              <!-- Kaiadmin JS -->
              <script src="<c:url value='/resources/assets/dashboard/js/kaiadmin.min.js'/>"></script>

              <!-- Kaiadmin DEMO methods, don't include it in your project! -->
              <script src="<c:url value='/resources/assets/dashboard/js/setting-demo.js'/>"></script>

              <script>
                // Dữ liệu từ Controller
                const monthlyRevenueData = JSON.parse('${monthlyRevenueJson}');
                const monthlyImportData = JSON.parse('${monthlyImportJson}');
                const weeklyRevenueData = JSON.parse('${weeklyRevenueJson}');
                const weeklyImportData = JSON.parse('${weeklyImportJson}');
                const rangeRevenueData = JSON.parse('${rangeRevenueJson}');
                const rangeImportData = JSON.parse('${dailyImportJson}');
                const currentYear = '${currentYear}';
                const selectedYear = '${selectedYear}';
                const selectedMonth = '${selectedMonth}';

                // Nhãn tháng
                const monthLabels = ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'];

                // Hàm định dạng tiền tệ và tooltip
                const currencyFormatter = (value) => '$' + value.toLocaleString();
                const tooltipLabelCallback = (context) => {
                  let label = context.dataset.label || '';
                  if (label) { label += ': '; }
                  if (context.parsed.y !== null) { label += currencyFormatter(context.parsed.y); }
                  return label;
                };
                const commonChartOptions = (isLineChart = false) => ({
                  responsive: true,
                  maintainAspectRatio: false,
                  scales: {
                    y: {
                      beginAtZero: true,
                      ticks: { callback: currencyFormatter }
                    },
                    x: {
                      ticks: {
                        // Giảm số lượng nhãn nếu là biểu đồ đường có nhiều điểm dữ liệu
                        autoSkip: isLineChart,
                        maxTicksLimit: isLineChart ? 30 : undefined // Giới hạn số nhãn trục X cho biểu đồ đường
                      }
                    }
                  },
                  plugins: {
                    tooltip: { callbacks: { label: tooltipLabelCallback } }
                  }
                });

                // --- Biểu đồ Doanh thu theo tháng ---
                const monthlyRevenueCtx = document.getElementById('monthlyRevenueChart').getContext('2d');
                new Chart(monthlyRevenueCtx, {
                  type: 'bar',
                  data: {
                    labels: monthLabels,
                    datasets: [{
                      label: `Doanh thu ${currentYear}`,
                      data: monthLabels.map((l, i) => monthlyRevenueData[i + 1] || 0),
                      backgroundColor: 'rgba(54, 162, 235, 0.6)',
                      borderColor: 'rgba(54, 162, 235, 1)',
                      borderWidth: 1
                    }]
                  },
                  options: commonChartOptions()
                });

                // --- Biểu đồ Nhập hàng theo tháng ---
                const monthlyImportCtx = document.getElementById('monthlyImportChart').getContext('2d');
                new Chart(monthlyImportCtx, {
                  type: 'bar',
                  data: {
                    labels: monthLabels,
                    datasets: [{
                      label: `Nhập hàng ${currentYear}`,
                      data: monthLabels.map((l, i) => monthlyImportData[i + 1] || 0),
                      backgroundColor: 'rgba(255, 159, 64, 0.6)',
                      borderColor: 'rgba(255, 159, 64, 1)',
                      borderWidth: 1
                    }]
                  },
                  options: commonChartOptions()
                });

                // --- Biểu đồ Doanh thu theo tuần ---
                const weeklyRevenueCtx = document.getElementById('weeklyRevenueChart').getContext('2d');
                const weekRevenueLabels = Object.keys(weeklyRevenueData).map(week => `Tuần ${week}`);
                const weekRevenueValues = Object.values(weeklyRevenueData);
                new Chart(weeklyRevenueCtx, {
                  type: 'bar',
                  data: {
                    labels: weekRevenueLabels,
                    datasets: [{
                      label: `Doanh thu T${selectedMonth}/${selectedYear}`,
                      data: weekRevenueValues,
                      backgroundColor: 'rgba(75, 192, 192, 0.6)',
                      borderColor: 'rgba(75, 192, 192, 1)',
                      borderWidth: 1
                    }]
                  },
                  options: commonChartOptions()
                });

                // --- Biểu đồ Nhập hàng theo tuần ---
                const weeklyImportCtx = document.getElementById('weeklyImportChart').getContext('2d');
                const weekImportLabels = Object.keys(weeklyImportData).map(week => `Tuần ${week}`);
                const weekImportValues = Object.values(weeklyImportData);
                new Chart(weeklyImportCtx, {
                  type: 'bar',
                  data: {
                    labels: weekImportLabels,
                    datasets: [{
                      label: `Nhập hàng T${selectedMonth}/${selectedYear}`,
                      data: weekImportValues,
                      backgroundColor: 'rgba(255, 99, 132, 0.6)',
                      borderColor: 'rgba(255, 99, 132, 1)',
                      borderWidth: 1
                    }]
                  },
                  options: commonChartOptions()
                });

                // --- Biểu đồ Doanh thu theo khoảng ngày ---
                const rangeRevenueCtx = document.getElementById('rangeRevenueChart').getContext('2d');
                const rangeRevenueLabels = Object.keys(rangeRevenueData).sort(); // Sắp xếp ngày
                const rangeRevenueValues = rangeRevenueLabels.map(key => rangeRevenueData[key]);
                new Chart(rangeRevenueCtx, {
                  type: 'line',
                  data: {
                    labels: rangeRevenueLabels,
                    datasets: [{
                      label: 'Doanh thu theo ngày',
                      data: rangeRevenueValues,
                      borderColor: 'rgb(153, 102, 255)',
                      tension: 0.1,
                      fill: false
                    }]
                  },
                  options: commonChartOptions(true) // true để bật autoSkip cho trục X
                });

                // --- Biểu đồ Nhập hàng theo khoảng ngày ---
                const rangeImportCtx = document.getElementById('rangeImportChart')?.getContext('2d');
                if (rangeImportCtx) {
                  const rangeImportLabels = Object.keys(rangeImportData).sort(); // Sắp xếp ngày
                  const rangeImportValues = rangeImportLabels.map(key => rangeImportData[key]);
                  new Chart(rangeImportCtx, {
                    type: 'line',
                    data: {
                      labels: rangeImportLabels,
                      datasets: [{
                        label: 'Nhập hàng theo ngày',
                        data: rangeImportValues,
                        borderColor: 'rgb(255, 205, 86)',
                        tension: 0.1,
                        fill: false
                      }]
                    },
                    options: commonChartOptions(true) // true để bật autoSkip cho trục X
                  });
                }

                // --- Logic hiển thị biểu đồ dựa trên bộ lọc --- 
                document.addEventListener('DOMContentLoaded', function () {
                  const urlParams = new URLSearchParams(window.location.search);
                  const weeklyChartsRow = document.getElementById('weeklyChartsRow');
                  const dailyChartsRow = document.getElementById('dailyChartsRow');
                  const hasWeeklyFilter = urlParams.has('year') || urlParams.has('month');
                  const hasDailyFilter = urlParams.has('startDate') || urlParams.has('endDate');

                  // Chỉ hiển thị nếu có tham số lọc tương ứng và phần tử tồn tại
                  if (hasWeeklyFilter && weeklyChartsRow) {
                    // Kiểm tra giá trị thực tế của year và month nếu cần
                    const yearParam = urlParams.get('year');
                    const monthParam = urlParams.get('month');
                    // Chỉ hiển thị nếu có giá trị hợp lệ (không rỗng)
                    if ((yearParam && yearParam !== '') || (monthParam && monthParam !== '')) {
                      weeklyChartsRow.style.display = 'flex';
                    }
                  }

                  if (hasDailyFilter && dailyChartsRow) {
                    // Kiểm tra giá trị thực tế của startDate và endDate nếu cần
                    const startParam = urlParams.get('startDate');
                    const endParam = urlParams.get('endDate');
                    // Chỉ hiển thị nếu có giá trị hợp lệ (không rỗng)
                    if ((startParam && startParam !== '') || (endParam && endParam !== '')) {
                      dailyChartsRow.style.display = 'flex';
                    }
                  }
                });

              </script>

        </body>

        </html>