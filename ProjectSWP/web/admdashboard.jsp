<%-- 
    Document   : admdashboard
    Created on : Jun 12, 2024, 1:19:35 PM
    Author     : admin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="model.BrandTotal" %>
<%@ page import="model.OrderTrend" %>
<%@ page import="model.FeedbackByCategory" %>
<%@ page import="model.RevenueByCategory" %>
<%@ page import="model.CustomerCount" %>
<%@ page import="model.OrderStatusCount" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.time.LocalDate" %>

<%
    // Get total revenue from request attribute
    float totalRevenue = (float) request.getAttribute("totalRevenue");

    // Format total revenue
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
    String formattedTotalRevenue = currencyFormat.format(totalRevenue).replace("₫", " VND");
%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/vendor/bootstrap/css/bootstrap.min.css">
        <link href="assets/vendor/fonts/circular-std/style.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/libs/css/style.css">
        <link rel="stylesheet" href="assets/vendor/fonts/fontawesome/css/fontawesome-all.css">
        <link rel="stylesheet" href="assets/vendor/vector-map/jqvmap.css">
        <link rel="stylesheet" href="assets/vendor/jvectormap/jquery-jvectormap-2.0.2.css">
        <link rel="stylesheet" href="assets/vendor/fonts/flag-icon-css/flag-icon.min.css">
        <title>Admin Dashboard</title>
        <style>
            /* Custom styles */
            h4 {
                display: flex;
                align-items: center;
                justify-content: right;
            }
            input {
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 3px;
                outline: none;
            }
            a {
                color: #fff;
                text-decoration: none;
                margin: 0 10px;
            }
            .dashboard-card {
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                padding: 20px;
                margin-bottom: 20px;
                background: #fff;
            }
            .dashboard-card h5 {
                font-size: 1.2em;
                margin-bottom: 10px;
            }
            .dashboard-card .card-content {
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
            .dashboard-card .card-content .value {
                font-size: 2em;
                font-weight: bold;
            }
            .chart-container {
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                padding: 20px;
                margin-bottom: 20px;
                height: 400px;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
            }
            .recent-sales {
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                padding: 20px;
                margin-bottom: 20px;
            }
            .filter-select {
                width: auto;
                max-width: 80px;
                padding: 5px;
            }
            .star-icon {
                width: 20px; /* Adjust size as needed */
                height: 20px; /* Adjust size as needed */
            }
        </style>
    </head>
    <body>
        <!-- include header -->

        <!-- include sidebar -->
        <%@ include file="COMP/adm-sidebar.jsp" %>

        <!-- wrapper  -->
        <div class="dashboard-wrapper">
            <div class="container-fluid dashboard-content">
                <!-- pageheader  -->
                <div class="row">
                    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                        <div class="page-header">
                            <h3 class="mb-2">Admin Dashboard</h3>
                            <div class="page-breadcrumb">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item" aria-current="page"><a href="admdashboard" class="breadcrumb-link">Dashboard</a></li>
                                        <li class="breadcrumb-item active">Admin Dashboard</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Check for error messages -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger">
                        ${errorMessage}
                    </div>
                </c:if>

                <!-- dashboard cards -->
                <div class="row">
                    <!-- Orders Today, filter by sort options -->
                    <div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12">
                        <div class="dashboard-card">
                            <div class="d-flex justify-content-between align-items-center">
                                <h5>Orders | Today</h5>
                                <select id="sortOptions" class="form-control filter-select" onchange="applySort(this.value)">
                                    <option value="0" selected>All</option>
                                    <option value="1">Pending Confirmation</option>
                                    <option value="2">Confirmed</option>
                                    <option value="3">Shipped</option>
                                    <option value="4">Delivered</option>
                                    <option value="5">Success</option>
                                    <option value="6">Cancelled</option>
                                    <option value="7">Returned</option>
                                    <option value="8">Unpaid</option>
                                </select>
                            </div>
                            <div class="card-content mt-3" id="orderCountContent">
                                <div class="value">
                                    <c:forEach var="order" items="${newOrders}">
                                        ${order.orderStatus}: ${order.count}<br>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Customers Amount for today -->
                    <div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12">
                        <div class="dashboard-card">
                            <h5>Customers Amount</h5>
                            <div class="card-content">
                                <c:forEach var="customer" items="${customers}">
                                    <c:if test="${customer.date == today}">
                                        ${customer.type}: ${customer.count}<br>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </div>

                    <!-- Revenue for the month -->
                    <div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12">
                        <div class="dashboard-card">
                            <h5>Revenue </h5>
                            <div class="card-content">
                                <div class="value">
                                    <%= formattedTotalRevenue %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end dashboard cards -->

                <!-- Feedbacks and Revenue by Brand -->
                <div class="row">
                    <!-- Feedbacks -->
                    <div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
                        <div class="dashboard-card">
                            <h5>Feedbacks</h5>
                            <div class="card-content">
                                <table class="table">
                                    <tbody>
                                        <c:forEach var="feedback" items="${feedbacks}">
                                            <tr>
                                                <td>${feedback.category}</td>
                                                <td>${fn:substring(feedback.averageStar, 0, 3)}</td>
                                                <td><img src="images//star.png" alt="Stars" class="star-icon"></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- Total Revenue by Brand -->
                    <div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
                        <div class="chart-container">
                            <h5>Revenue By Brand</h5>
                            <canvas id="trafficChart"></canvas>
                        </div>
                    </div>
                </div>
                <!-- end feedbacks -->

                <!-- Order Trends -->
                <div class="row">
                    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                        <div class="chart-container">
                            <h5>Order Trends</h5>
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div>
                                    <label for="startDate">Start Date:</label>
                                    <input type="date" id="startDate" value="${startDate}" onchange="applyDateFilter()">
                                </div>
                                <div>
                                    <label for="endDate">End Date:</label>
                                    <input type="date" id="endDate" value="${endDate}" onchange="applyDateFilter()">
                                </div>
                            </div>
                            <canvas id="orderTrendChart"></canvas>
                        </div>
                    </div>
                </div>
                <!-- end order trends -->

                <!-- include footer -->
                <%@ include file="COMP/manager-footer.jsp" %>
            </div>
        </div>
        <!-- end wrapper -->

        <!-- Optional JavaScript -->
        <script src="assets/vendor/jquery/jquery-3.3.1.min.js"></script>
        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.js"></script>
        <script src="assets/vendor/slimscroll/jquery.slimscroll.js"></script>
        <script src="assets/libs/js/main-js.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            function loadOrders(url) {
                $.ajax({
                    url: url,
                    method: 'GET',
                    dataType: 'html',
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    },
                    success: function (response) {
                        var newOrderCount = $(response).find('#orderCountContent').html();
                        $('#orderCountContent').html(newOrderCount);

                        var newRevenue = $(response).find('#revenue').html();
                        $('#revenue').html(newRevenue);
                    },
                    error: function (xhr, status, error) {
                        console.error('Error loading orders: ', status, error);
                    }
                });
            }

            function applySort(sortBy) {
                var searchParams = new URLSearchParams(window.location.search);
                searchParams.set('orderStatus', sortBy);
                var url = 'admdashboard?' + searchParams.toString();
                loadOrders(url);
            }

            function applyDateFilter() {
                var searchParams = new URLSearchParams(window.location.search);
                var startDate = document.getElementById('startDate').value;
                var endDate = document.getElementById('endDate').value;
                searchParams.set('startDate', startDate);
                searchParams.set('endDate', endDate);
                var url = 'admdashboard?' + searchParams.toString();
                loadOrders(url);
            }

            function formatCurrency(value) {
                return value.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'}).replace('₫', 'VND');
            }

            var xValues = [
            <%
                List<BrandTotal> list = (List<BrandTotal>) request.getAttribute("totalByBrand");
                for (BrandTotal b : list) {
                    out.print("\"" + b.getBrandName() + "\",");
                }
            %>
            ];
            var yValues = [
            <%
                for (BrandTotal b : list) {
                    out.print(b.getTotalAmount() + ",");
                }
            %>
            ];

            var ctxPie = document.getElementById('trafficChart').getContext('2d');
            var trafficChart = new Chart(ctxPie, {
                type: 'pie',
                data: {
                    labels: xValues,
                    datasets: [{
                        data: yValues,
                        backgroundColor: ['#007bff', '#28a745', '#ffc107', '#dc3545', '#17a2b8'],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'top',
                        },
                        tooltip: {
                            callbacks: {
                                label: function (tooltipItem) {
                                    var label = tooltipItem.label || '';
                                    var value = tooltipItem.raw || 0;
                                    return label + ': ' + formatCurrency(value);
                                }
                            }
                        }
                    }
                }
            });

            var orderDates = [
            <%
                List<OrderTrend> trends = (List<OrderTrend>) request.getAttribute("orderTrends");
                for (OrderTrend trend : trends) {
                    out.print("\"" + trend.getOrderDate() + "\",");
                }
            %>
            ];
            var orderCounts = [
            <%
                for (OrderTrend trend : trends) {
                    out.print(trend.getOrderCount() + ",");
                }
            %>
            ];
            var successCounts = [
            <%
                for (OrderTrend trend : trends) {
                    out.print(trend.getSuccessCount() + ",");
                }
            %>
            ];

            var ctxBar = document.getElementById('orderTrendChart').getContext('2d');
            var orderTrendChart = new Chart(ctxBar, {
                type: 'bar',
                data: {
                    labels: orderDates,
                    datasets: [
                        {
                            label: 'Total Orders',
                            data: orderCounts,
                            backgroundColor: 'rgba(54, 162, 235, 0.5)',
                            borderWidth: 1
                        },
                        {
                            label: 'Successful Orders',
                            data: successCounts,
                            backgroundColor: 'rgba(75, 192, 192, 0.5)',
                            borderWidth: 1
                        }
                    ]
                },
                options: {
                    responsive: true,
                    scales: {
                        x: {
                            beginAtZero: true
                        },
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        </script>
    </body>
</html>