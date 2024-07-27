<!doctype html>
<html lang="en">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ page import="java.util.List" %>
    <%@ page import="model.*" %>
    <%@ page import="model.BrandTotal" %>
    <%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="assets/vendor/bootstrap/css/bootstrap.min.css">
        <link href="assets/vendor/fonts/circular-std/style.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/libs/css/style.css">
        <link rel="stylesheet" href="assets/vendor/fonts/fontawesome/css/fontawesome-all.css">
        <link rel="stylesheet" href="assets/vendor/vector-map/jqvmap.css">
        <link rel="stylesheet" href="assets/vendor/jvectormap/jquery-jvectormap-2.0.2.css">
        <link rel="stylesheet" href="assets/vendor/fonts/flag-icon-css/flag-icon.min.css">
        <title>Marketing Dashboard</title>
        <style>
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

            .dashboard-card .card-content .change {
                font-size: 0.9em;
                color: #28a745;
            }

            .dashboard-card .card-content .change.decrease {
                color: #dc3545;
            }

            .chart-container {
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                padding: 20px;
                margin-bottom: 20px;
                height: 400px; /* Ensure consistent height */
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
                max-width: 80px; /* Adjust the max-width as needed */
                padding: 5px; /* Adjust the padding as needed */
            }
        </style>
    </head>

    <body>

        <!-- include sidebar -->
        <%@ include file="COMP/sale-sidebar.jsp" %>

        <!-- wrapper -->
        <div class="dashboard-wrapper">
            <div class="container-fluid dashboard-content">
                <!-- pageheader -->
                <div class="row">
                    <div class="col-12">
                        <div class="page-header">
                            <h3 class="mb-2">Sale Manager Dashboard</h3>
                            <div class="page-breadcrumb">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="dashboardmkt" class="breadcrumb-link">Dashboard</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Marketing Dashboard</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end pageheader -->

                <!-- dashboard cards -->
                <div class="row">
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
                                <div class="value">${countOrderToday}</div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12">
                        <div class="dashboard-card">

                            <div class="d-flex justify-content-between align-items-center">
                                <h5>Revenue | Month</h5>  
                                <select id="monthOptions" class="form-control filter-select" onchange="applySortMonth(this.value)">
                                    <option value="1">January</option>
                                    <option value="2">February</option>
                                    <option value="3">March</option>
                                    <option value="4">April</option>
                                    <option value="5">May</option>
                                    <option value="6">June</option>
                                    <option value="7" selected>July</option>
                                    <option value="8">August</option>
                                    <option value="9">September</option>
                                    <option value="10">October</option>
                                    <option value="11">November</option>
                                    <option value="12">December</option>
                                </select>
                            </div>
                            <div class="card-content" id="revenue">
                                <div class="value">  <fmt:formatNumber value="${revenue}" pattern="###,###"/> VND </div>

                            </div>
                        </div>
                    </div>

                    <div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12">
                        <div class="dashboard-card">
                            <h5>Customers Amount</h5>
                            <div class="card-content">
                                <div class="value">${totalCustomer}</div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end dashboard cards -->

                <!-- sales overview and traffic chart -->
                <div class="row">
                    <div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
                        <div class="card z-index-2">
                            <div class="card-header pb-0">
                                <h6>Sales overview</h6>
                            </div>
                            <div class="card-body p-3">
                                <form id="filter-form">
                                    <div class="row">
                                        <div class="col-4">
                                            <label for="startdate">Start Date</label>
                                            <input type="date" id="startdate" name="startdate" class="form-control">
                                        </div>
                                        <div class="col-4">
                                            <label for="enddate">End Date</label>
                                            <input type="date" id="enddate" name="enddate" class="form-control">
                                        </div>
                                        <div class="col-4">
                                            <label for="salers">Salers</label>
                                            <select id="salers" name="salers" class="form-control">
                                                <option value="0">All</option>
                                                <c:forEach var="sale" items="${saleList}" varStatus="status">
                                                    <option value="${sale.staffID}">${sale.fullName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </form>
                                <div class="chart mt-4">
                                    <canvas id="chart-line" class="chart-canvas" height="300"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
                        <div class="chart-container">
                            <h5>Revenue By Brand</h5>
                            <canvas id="trafficChart"></canvas>
                        </div>
                    </div>
                </div>
                <!-- end sales overview and traffic chart -->

                <!-- recent sales -->
                <div class="recent-sales">
                    <h5>Top best selling products</h5>
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>ProductID</th>
                                <th>Image</th>
                                <th>Product Name</th>
                                <th>Description</th>
                                <th>Price</th>
                                <th>Total Sold</th>
                                <th>Revenue</th>

                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${bestSeller}">
                                <tr>
                                    <td>${p.productID}</td>
                                    <td><img src="${p.thumbnailLink}" alt="" width="70" class="img-fluid"> </td>
                                    <td>${p.title}</td>
                                    <td>${p.description}</td>
                                    <td> <fmt:formatNumber value="${p.salePrice}" pattern="###,###"/> VND  </td>
                                    <td>${p.quantity}</td>
                                    <td><fmt:formatNumber value="${p.salePrice * p.quantity}" pattern="###,###"/> VND</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <!-- end recent sales -->
            </div>
            <!-- include footer -->
            <%@ include file="COMP/manager-footer.jsp" %>
        </div>
        <!-- end wrapper -->

        <!-- Optional JavaScript -->
        <!-- jquery 3.3.1 js-->
        <script src="assets/vendor/jquery/jquery-3.3.1.min.js"></script>
        <!-- bootstrap bundle js-->
        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.js"></script>
        <!-- slimscroll js-->
        <script src="assets/vendor/slimscroll/jquery.slimscroll.js"></script>
        <!-- main js-->
        <script src="assets/libs/js/main-js.js"></script>
        <!-- chart js-->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
                                    function loadOrders(url) {
                                        console.log('Loading orders via AJAX:', url);
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
                                                console.log('Orders loaded successfully.');

                                                var newRevenue = $(response).find('#revenue').html();
                                                $('#revenue').html(newRevenue);
                                                console.log('Revenue loaded successfully.');
                                            },
                                            error: function (xhr, status, error) {
                                                console.error('Error loading orders: ', status, error);
                                            }
                                        });
                                    }

                                    function applySort(sortBy) {
                                        var searchParams = new URLSearchParams(window.location.search);
                                        searchParams.set('orderStatus', sortBy);
                                        var url = 'salemanagerdashboard?' + searchParams.toString();
                                        loadOrders(url); // Call loadOrders function with the constructed URL
                                    }

                                    function applySortMonth(month) {
                                        var searchParams = new URLSearchParams(window.location.search);
                                        searchParams.set('month', month);
                                        var url = 'salemanagerdashboard?' + searchParams.toString();
                                        loadOrders(url); // Call loadOrders function with the constructed URL
                                    }

                                    function sendFormData() {
                                        var formData = {
                                            startdate: $('#startdate').val(),
                                            enddate: $('#enddate').val(),
                                            salers: $('#salers').val()
                                        };

                                        $.ajax({
                                            type: 'POST',
                                            url: 'salemanagerdashboard',
                                            contentType: 'application/json',
                                            data: JSON.stringify(formData),
                                            success: function (response) {
                                                // Handle the response from the servlet here
                                                console.log(response);

                                                // Update chart data
                                                chart.data.labels = response.labels;
                                                chart.data.datasets[0].data = response.revenue;
                                                chart.data.datasets[1].data = response.orders;
                                                chart.update();
                                            },
                                            error: function (error) {
                                                console.error(error);
                                            }
                                        });
                                    }

                                    $('#startdate, #enddate, #salers').on('change', function () {
                                        sendFormData();
                                    });


                                    //Chart setup
                                    var ctx2 = document.getElementById("chart-line").getContext("2d");
                                    var gradientStroke1 = ctx2.createLinearGradient(0, 230, 0, 50);
                                    gradientStroke1.addColorStop(1, 'rgba(203,12,159,0.2)');
                                    gradientStroke1.addColorStop(0.2, 'rgba(72,72,176,0.0)');
                                    gradientStroke1.addColorStop(0, 'rgba(203,12,159,0)');
                                    var gradientStroke2 = ctx2.createLinearGradient(0, 230, 0, 50);
                                    gradientStroke2.addColorStop(1, 'rgba(20,23,39,0.2)');
                                    gradientStroke2.addColorStop(0.2, 'rgba(72,72,176,0.0)');
                                    gradientStroke2.addColorStop(0, 'rgba(20,23,39,0)');

                                    var chart = new Chart(ctx2, {
                                        type: "line",
                                        data: {
                                            labels: [], // Placeholder, will be updated dynamically
                                            datasets: [{
                                                    label: "Revenue",
                                                    tension: 0.4,
                                                    borderWidth: 0,
                                                    pointRadius: 0,
                                                    borderColor: "#cb0c9f",
                                                    borderWidth: 3,
                                                    backgroundColor: gradientStroke1,
                                                    fill: true,
                                                    data: [], // Placeholder, will be updated dynamically
                                                    maxBarThickness: 6
                                                },
                                                {
                                                    label: "Total Orders",
                                                    tension: 0.4,
                                                    borderWidth: 0,
                                                    pointRadius: 0,
                                                    borderColor: "#3A416F",
                                                    borderWidth: 3,
                                                    backgroundColor: gradientStroke2,
                                                    fill: true,
                                                    data: [], // Placeholder, will be updated dynamically
                                                    maxBarThickness: 6
                                                }],
                                        },
                                        options: {
                                            responsive: true,
                                            maintainAspectRatio: false,
                                            plugins: {
                                                legend: {
                                                    display: false,
                                                }
                                            },
                                            interaction: {
                                                intersect: false,
                                                mode: 'index',
                                            },
                                            scales: {
                                                y: {
                                                    grid: {
                                                        drawBorder: false,
                                                        display: true,
                                                        drawOnChartArea: true,
                                                        drawTicks: false,
                                                        borderDash: [5, 5]
                                                    },
                                                    ticks: {
                                                        display: true,
                                                        padding: 10,
                                                        color: '#b2b9bf',
                                                        font: {
                                                            size: 11,
                                                            family: "Open Sans",
                                                            style: 'normal',
                                                            lineHeight: 2
                                                        },
                                                    }
                                                },
                                                x: {
                                                    grid: {
                                                        drawBorder: false,
                                                        display: false,
                                                        drawOnChartArea: false,
                                                        drawTicks: false,
                                                        borderDash: [5, 5]
                                                    },
                                                    ticks: {
                                                        display: true,
                                                        color: '#b2b9bf',
                                                        padding: 20,
                                                        font: {
                                                            size: 11,
                                                            family: "Open Sans",
                                                            style: 'normal',
                                                            lineHeight: 2
                                                        },
                                                    }
                                                },
                                            },
                                        },
                                    });

        </script>
        <%
            List<BrandTotal> list = (List<BrandTotal>) request.getAttribute("totalByBrand");
        %>
        <script>
            var xValues = [
            <%
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

            function formatCurrency(value) {
                return value.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'}).replace('₫', 'VND');
            }

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
        </script>

    </body>
</html>
