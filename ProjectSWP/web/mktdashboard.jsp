<!doctype html>
<html lang="en">
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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


        <!-- include sidebar -->
        <c:set var="page" value="dashboard" />
        <%@ include file="COMP\marketing-sidebar.jsp" %>

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
                            <h3 class="mb-2">Marketing Dashboard</h3>


                            <div class="page-breadcrumb">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item" aria-current="page"><a href="dashboardmkt" class="breadcrumb-link">Dashboard</a></li>
                                        <li class="breadcrumb-item active">Marketing Dashboard</li>

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
                                    <h1 class="mb-1 text-primary">${feedbacks} </h1>
                                </div>
                                <div class="metric-label d-inline-block float-right text-success">
                                    <i class="fa fa-fw fa-caret-up"></i><span>${percentF}</span>
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
                                                <th class="border-0">Product Id</th>
                                                <th class="border-0">Image</th>
                                                <th class="border-0">Product Name</th>
                                                <th class="border-0">Price</th>
                                                <th class="border-0">Quantity Sold</th>
                                                <th class="border-0">Revenue</th>
                                            </tr>
                                        </thead>
                                        <%
                                            List<OrderDetail> listo = (List<OrderDetail>) request.getAttribute("listo");
                                        %>
                                        <tbody>
                                            <c:forEach items="${listo}" var="o">
                                                <tr>
                                                    <td>${o.productID}</td>
                                                    <td>
                                                        <div class="m-r-10"><img src="${o.image}" alt="product" class="rounded" width="45"></div>
                                                    </td>
                                                    <td>${o.title}</td>
                                                    <td> <fmt:formatNumber value="${o.salePrice}" pattern="###,###"/> VND</td>
                                                    <td>${o.quantitySold}</td>
                                                    <td><fmt:formatNumber value="${o.priceSold}" pattern="###,###"/> VND</td>

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
            <!-- include footer -->
            <%@ include file="COMP\manager-footer.jsp" %>
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
