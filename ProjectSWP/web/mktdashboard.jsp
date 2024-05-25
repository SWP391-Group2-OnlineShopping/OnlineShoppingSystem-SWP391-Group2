<!doctype html>
<html lang="en">
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page import="java.util.List" %>
    <%@ page import="model.Orders" %>
    <%@ page import="model.BrandTotal" %>
    <%@ page import="model.OrderDetail" %>
    <%@ page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>Marketing Dashboard </title>
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
        </style>
    </head>

    <body>
        <!-- ============================================================== -->
        <!-- main wrapper -->
        <!-- ============================================================== -->
        <div class="dashboard-main-wrapper" id="dataContainer">
            <!-- ============================================================== -->
            <!-- navbar -->
            <!-- ============================================================== -->
            <div class="dashboard-header">
                <nav class="navbar navbar-expand-lg bg-white fixed-top">
                    <a class="navbar-brand" href="index.jsp">DiLuri</a>
                </nav>
            </div>
            <!-- ============================================================== -->
            <!-- end navbar -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- left sidebar -->
            <!-- ============================================================== -->
            <div class="nav-left-sidebar sidebar-dark">
                <div class="menu-list">
                    <nav class="navbar navbar-expand-lg navbar-light">
                        <a class="d-xl-none d-lg-none" href="home">Dashboard</a>
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarNav">
                            <!-- User Info -->

                            <!-- End of User Info -->

                            <ul class="navbar-nav flex-column">
                                <li>
                                    <div class="d-flex align-items-center">
                                        <img src="https://t3.ftcdn.net/jpg/05/16/27/58/360_F_516275801_f3Fsp17x6HQK0xQgDQEELoTuERO4SsWV.jpg" class="rounded-circle" alt="Avatar" width="200" height="190">
                                    </div>
                                </li>
                                <li>
                                    <div class="user-info my-3">
                                        <div class="d-flex align-items-center">
                                            <div class="ml-3">
                                                <h5 class="mb-0 text-white">${staff.username}</h5>
                                                <h6 class="mb-0 text-white">${staff.email}</h6>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                                <li class="nav-divider">
                                    Menu
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link active" href="dashboardmkt" onclick="setActive(this)">
                                        <i class="fa fa-fw fa-user-circle"></i>
                                        Dashboard
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="index.jsp" onclick="setActive(this)">
                                        <i class="fas fa-fw fa-chart-pie"></i>
                                        Home
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="productmanager" onclick="setActive(this)">
                                        <i class="fas fa-fw fa-chart-pie"></i>
                                        Product Manager
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link " href="customerlist" onclick="setActive(this)">
                                        <i class="fas fa-fw fa-chart-pie"></i>
                                        Customers List
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="blogmanager" onclick="setActive(this)">
                                        <i class="fas fa-fw fa-chart-pie"></i>
                                        Blog Manager
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link " href="sliderlist" onclick="setActive(this)">
                                        <i class="fas fa-fw fa-chart-pie"></i>
                                        Slider List
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link  " href="feedbacklist" onclick="setActive(this)">
                                        <i class="fas fa-fw fa-chart-pie"></i>
                                        Feedback List
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </nav>
                </div>
            </div>
            <!-- ============================================================== -->
            <!-- end left sidebar -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- wrapper  -->
            <!-- ============================================================== -->
            <div class="dashboard-wrapper">
                <div class="container-fluid  dashboard-content">
                    <!-- ============================================================== -->
                    <!-- pagehader  -->
                    <!-- ============================================================== -->
                    <div class="row">
                        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                            <div class="page-header">
                                <h3 class="mb-2">Maketing Dashboard</h3>


                                <div class="page-breadcrumb">
                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb">
                                            <li class="breadcrumb-item"><a href="dashboardmkt" class="breadcrumb-link">Dashboard</a></li>
                                            <li class="breadcrumb-item active" aria-current="page">Maketing Dashboard</li>

                                        </ol>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- ============================================================== -->
                    <!-- pagehader  -->
                    <!-- ============================================================== -->
                    <h4>
                        <form action="dashboardmkt">
                            <a><input id="startDate" value="${start}" type="datetime-local" name="startDate"/></a>
                            <a>To</a>
                            <a><input id="endDate" value="${end}"  type="datetime-local" name="endDate"/></a>
                            <a><input type="submit" value="Find" /></a> 
                        </form>
                    </h4>

                    <div class="row">
                        <!-- metric -->

                        <div class="col-xl-3 col-lg-6 col-md-6 col-sm-12 col-12">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="text-muted">Customers</h5>
                                    <div class="metric-value d-inline-block">
                                        <h1 class="mb-1 text-primary">${cus}</h1>
                                    </div>
                                    <div class="metric-label d-inline-block float-right text-success">
                                        <i class="fa fa-fw fa-caret-up"></i><span>${newCus}</span>
                                    </div>
                                </div>
                                <div id="sparkline"></div>
                            </div>
                        </div>
                        <!-- /. metric -->
                        <!-- metric -->
                        <div class="col-xl-3 col-lg-6 col-md-6 col-sm-12 col-12">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="text-muted">Post</h5>
                                    <div class="metric-value d-inline-block">
                                        <h1 class="mb-1 text-primary">${post} </h1>
                                    </div>
                                    <div class="metric-label d-inline-block float-right text-success">
                                        <i class="fa fa-fw fa-caret-up"></i><span>${percentP} %</span>
                                    </div>
                                </div>
                                <div id="sparkline"></div>
                            </div>
                        </div>
                        <!-- /. metric -->
                        <!-- metric -->
                        <div class="col-xl-3 col-lg-6 col-md-6 col-sm-12 col-12">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="text-muted">Revenue</h5>
                                    <div class="metric-value d-inline-block">
                                        <h1 class="mb-1 text-primary original-price">${revenue}đ</h1>
                                    </div>
                                    <div class="metric-label d-inline-block float-right text-success">
                                        <i class="fa fa-fw fa-caret-up"></i><span class="original-price">${revenue7day}đ</span>
                                    </div>
                                </div>
                                <div id="sparkline">
                                </div>
                            </div>
                        </div>
                        <!-- /. metric -->
                        <!-- metric -->
                        <div class="col-xl-3 col-lg-6 col-md-6 col-sm-12 col-12">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="text-muted">FeedBack</h5>
                                    <div class="metric-value d-inline-block">
                                        <h1 class="mb-1 text-primary">+28.45% </h1>
                                    </div>
                                    <div class="metric-label d-inline-block float-right text-success">
                                        <i class="fa fa-fw fa-caret-up"></i><span>4.87%</span>
                                    </div>
                                </div>
                                <div id="sparkline"></div>
                            </div>
                        </div>
                        <!-- /. metric -->
                    </div>
                    <!-- ============================================================== -->
                    <!-- revenue  -->
                    <!-- ============================================================== -->
                    <div class="row" >
                        <div class="col-xl-8 col-lg-12 col-md-8 col-sm-12 col-12">
                            <div class="card">

                                <h5 class="card-header">Revenue<a>

                                    </a>
                                </h5>  


                                <div class="card-body" >
                                    <canvas id="myChart" width="400" height="150"></canvas>
                                </div>
                                <div class="card-body border-top">
                                    <div class="row">
                                        <div class="offset-xl-1 col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12 p-3">
                                            <h4> Today's Earning: <a class="original-price">${erning}đ</a></h4>

                                            </p>
                                        </div>
                                        <div class="offset-xl-1 col-xl-3 col-lg-3 col-md-6 col-sm-12 col-12 p-3">
                                            <h2 class="font-weight-normal mb-3"><span  class="original-price">${high.totalCost}đ</span>                                                    </h2>
                                            <div class="mb-0 mt-3 legend-item">

                                                <span class="legend-text"> Highest Month</span></div>
                                        </div>
                                        <div class="offset-xl-1 col-xl-3 col-lg-3 col-md-6 col-sm-12 col-12 p-3">
                                            <h2 class="font-weight-normal mb-3">

                                                <span class="original-price">${low.totalCost}đ</span>
                                            </h2>
                                            <div class="text-muted mb-0 mt-3 legend-item"><span class="legend-text">Lowest Month</span></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- ============================================================== -->
                        <!-- end reveune  -->
                        <!-- ============================================================== -->
                        <!-- ============================================================== -->
                        <!-- total sale  -->
                        <!-- ============================================================== -->
                        <div class="col-xl-4 col-lg-12 col-md-4 col-sm-12 col-12">
                            <div class="card">
                                <h5 class="card-header">Total Sale</h5>
                                <div class="card-body">
                                    <canvas  id="myPieChart" width="220" height="155"></canvas>
                                    <div class="chart-widget-list" style="text-align: center;">
                                        <h5 style="display: block;">Brand Total Amount</h5>    
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- ============================================================== -->
                        <!-- end total sale  -->
                        <!-- ============================================================== -->
                    </div>
                    <div class="row">
                        <!-- ============================================================== -->
                        <!-- top selling products  -->
                        <!-- ============================================================== -->
                        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                            <div class="card">
                                <h5 class="card-header">Top Selling Products</h5>
                                <div class="card-body p-0">
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead class="bg-light">
                                                <tr class="border-0">
                                                    <th class="border-0">#</th>
                                                    <th class="border-0">Image</th>
                                                    <th class="border-0">Product Name</th>
                                                    <th class="border-0">Product Id</th>
                                                    <th class="border-0">Price</th>
                                                    <th class="border-0">Quantity Sold</th>
                                                    <th class="border-0">Price Sold</th>
                                                </tr>
                                            </thead>
                                            <%
                                                List<OrderDetail> listo = (List<OrderDetail>) request.getAttribute("listo");
                                            %>
                                            <tbody>
                                                <c:forEach items="${listo}" var="o">
                                                    <tr>
                                                        <td>1</td>
                                                        <td>
                                                            <div class="m-r-10"><img src="${o.image}" alt="product" class="rounded" width="45"></div>
                                                        </td>
                                                        <td>${o.title}</td>
                                                        <td>${o.productID}</td>
                                                        <td class="original-price">${o.salePrice}đ</td>
                                                        <td>${o.quantitySold}</td>
                                                        <td class="original-price">${o.priceSold}đ</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- ============================================================== -->
                        <!-- end revenue locations  -->
                        <!-- ============================================================== -->
                    </div>

                </div>
                <!-- ============================================================== -->
                <!-- footer -->
                <!-- ============================================================== -->
                <div class="footer">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-12">
                                Copyright © 2018 Concept. All rights reserved. Dashboard by <a href="https://colorlib.com/wp/">Colorlib</a>.
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-12">
                                <div class="text-md-right footer-links d-none d-sm-block">
                                    <a href="javascript: void(0);">About</a>
                                    <a href="javascript: void(0);">Support</a>
                                    <a href="javascript: void(0);">Contact Us</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- ============================================================== -->
                <!-- end footer -->
                <!-- ============================================================== -->
            </div>
            <!-- ============================================================== -->
            <!-- end wrapper  -->
            <!-- ============================================================== -->
        </div>
        <!-- ============================================================== -->
        <!-- end main wrapper  -->
        <!-- ============================================================== -->
        <!-- Optional JavaScript -->
        <!-- jquery 3.3.1 js-->
        <script src="assets/vendor/jquery/jquery-3.3.1.min.js"></script>
        <!-- bootstrap bundle js-->
        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.js"></script>
        <!-- slimscroll js-->
        <script src="assets/vendor/slimscroll/jquery.slimscroll.js"></script>
        <!-- chartjs js-->
        <script src="assets/vendor/charts/charts-bundle/Chart.bundle.js"></script>
        <script src="assets/vendor/charts/charts-bundle/chartjs.js"></script>

        <!-- main js-->
        <script src="assets/libs/js/main-js.js"></script>
        <!-- jvactormap js-->
        <script src="assets/vendor/jvectormap/jquery-jvectormap-2.0.2.min.js"></script>
        <script src="assets/vendor/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
        <!-- sparkline js-->
        <script src="assets/vendor/charts/sparkline/jquery.sparkline.js"></script>
        <script src="assets/vendor/charts/sparkline/spark-js.js"></script>
        <!-- dashboard sales js-->
        <script src="assets/libs/js/dashboard-sales.js"></script>

        <%
            List<Orders> listbt = (List<Orders>) request.getAttribute("listr");
        %>
        <script>
                                        var xValues = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
                                        var yValues = [
            <%
                    for (Orders order : listbt) {
                        out.print(order.getTotalCost() + ",");
                    }
            %>
                                        ];
                                        var barColors = ["#9c9ab5", "#9c9ab5", "#9c9ab5", "#9c9ab5", "#9c9ab5", "#9c9ab5", "#9c9ab5", "#9c9ab5", "#9c9ab5", "#9c9ab5", "#9c9ab5", "#9c9ab5"];
                                        new Chart("myChart", {
                                            type: "bar",
                                            data: {
                                                labels: xValues,
                                                datasets: [{
                                                        backgroundColor: barColors,
                                                        data: yValues
                                                    }]
                                            },
                                            options: {
                                                legend: {display: false},
                                                title: {
                                                    display: true,
                                                    text: "Revenue"
                                                }
                                            }
                                        });
        </script>

        <%
            List<BrandTotal> list = (List<BrandTotal>) request.getAttribute("listbt");
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
            var barColors = ["#b91d47", "#00aba9", "#2b5797", "#e8c3b9", "#1e7145"];
            new Chart("myPieChart", {
                type: "pie",
                data: {
                    labels: xValues,
                    datasets: [{
                            backgroundColor: barColors,
                            data: yValues
                        }]
                },
                options: {
                    title: {
                        display: false,
                    }
                }
            });
        </script>

        <script>
            var xValues = [
            <%
                    for (BrandTotal b : list) {
                        out.println("\"" + b.getBrandName() + "\"" + ",");
                    }
            %>
            ];


            var yValues = [
            <%
                    for (BrandTotal b : list) {
                        out.println(b.getTotalAmount() + ",");
                    }
            %>
            ];
            var barColors = [
                "#b91d47",
                "#00aba9",
                "#2b5797",
                "#e8c3b9",
                "#1e7145"
            ];

            new Chart("myPieChart", {
                type: "pie",
                data: {
                    labels: xValues,
                    datasets: [{
                            backgroundColor: barColors,
                            data: yValues
                        }]
                },
                options: {
                    title: {
                        display: false,

                    }
                }
            });
        </script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var originalPrices = document.querySelectorAll('.original-price');
                originalPrices.forEach(function (originalPrice) {
                    originalPrice.textContent = formatPrice(originalPrice.textContent.trim());
                });

                function formatPrice(price) {
                    return (parseFloat(price)).toLocaleString('vi-VN', {style: 'currency', currency: 'VND'}).replace('VND', '');
                }

                // Set max attribute to current date and time using local time
                var now = new Date();
                var year = now.getFullYear();
                var month = ('0' + (now.getMonth() + 1)).slice(-2);
                var day = ('0' + now.getDate()).slice(-2);
                var hours = ('0' + now.getHours()).slice(-2);
                var minutes = ('0' + now.getMinutes()).slice(-2);
                var seconds = ('0' + now.getSeconds()).slice(-2);
                var maxDateTime = year + '-' + month + '-' + day + 'T' + hours + ':' + minutes + ':' + seconds;

                document.getElementById('startDate').max = maxDateTime;
                document.getElementById('endDate').max = maxDateTime;
            });


        </script>

    </body>
</html>
