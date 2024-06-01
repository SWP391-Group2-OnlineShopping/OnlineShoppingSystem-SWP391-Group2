<!doctype html>
<html lang="en">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page import="java.util.List" %>
    <%@ page import="model.*" %>
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
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

            table.dataTable td img {
                width: 50px;
                height: 50px;
                border-radius: 50%;
            }

            .chart-container {
                height: 400px; /* Adjust this height to match the height of Total Sales Unit chart */
            }
        </style>
    </head>

    <body>
        <!-- include header -->
        <%@ include file="COMP/manager-header.jsp" %>

        <!-- include sidebar -->
        <%@ include file="COMP/marketing-sidebar.jsp" %>

        <!-- ============================================================== -->
        <!-- wrapper  -->
        <!-- ============================================================== -->
        <div class="dashboard-wrapper">
            <div class="container-fluid dashboard-content">
                <!-- ============================================================== -->
                <!-- pageheader -->
                <!-- ============================================================== -->
                <div class="row">
                    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                        <div class="page-header">
                            <h3 class="mb-2">Marketing Dashboard</h3>
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
                <!-- ============================================================== -->
                <!-- end pageheader -->
                <!-- ============================================================== -->

                <!-- Filters -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <label for="startDate">Start Date:</label>
                        <input type="date" id="startDate" class="form-control">
                    </div>
                    <div class="col-md-3">
                        <label for="endDate">End Date:</label>
                        <input type="date" id="endDate" class="form-control">
                    </div>
                    <div class="col-md-3">
                        <label for="salesPerson">Salesperson:</label>
                        <select id="salesPerson" class="form-control">
                            <option value="">All</option>
                            <!-- Add dynamic options here -->
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label for="orderStatus">Order Status:</label>
                        <select id="orderStatus" class="form-control">
                            <option value="">All</option>
                            <option value="success">Success</option>
                            <option value="pending">Pending</option>
                            <option value="cancelled">Cancelled</option>
                        </select>
                    </div>
                </div>

                <!-- Charts -->
                <div class="row">
                    <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-12">
                        <div class="card chart-container">
                            <h5 class="card-header">Orders Trend</h5>
                            <div class="card-body">
                                <canvas id="ordersTrendChart"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-12">
                        <div class="card chart-container">
                            <h5 class="card-header">Revenue Trend</h5>
                            <div class="card-body">
                                <canvas id="revenueTrendChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-12">
                        <div class="card">
                            <h5 class="card-header">Total Sales Unit</h5>
                            <div class="card-body">
                                <canvas id="salesUnitChart"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-12">
                        <div class="card">
                            <h5 class="card-header">Order Status</h5>
                            <div class="card-body">
                                <canvas id="orderStatusChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tables -->
                <div class="row">
                    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                        <div class="card">
                            <h5 class="card-header">Exclusive Datatable</h5>
                            <div class="card-body">
                                <table id="datatable" class="display">
                                    <thead>
                                        <tr>
                                            <th>Profile</th>
                                            <th>Manage By</th>
                                            <th>Company</th>
                                            <th>Date</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Example Data -->
                                        <tr>
                                            <td><img src="assets/images/avatar1.png" alt="Profile"></td>
                                            <td>Barb Ackue</td>
                                            <td>IIFL Finance</td>
                                            <td>07 April 2020</td>
                                            <td><span class="badge badge-success">Success</span></td>
                                            <td>
                                                <a href="#" class="btn btn-primary btn-sm">View</a>
                                                <a href="#" class="btn btn-warning btn-sm">Edit</a>
                                                <a href="#" class="btn btn-danger btn-sm">Delete</a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><img src="assets/images/avatar2.png" alt="Profile"></td>
                                            <td>Ira Membrit</td>
                                            <td>Shubham Housing</td>
                                            <td>10 April 2020</td>
                                            <td><span class="badge badge-info">Done</span></td>
                                            <td>
                                                <a href="#" class="btn btn-primary btn-sm">View</a>
                                                <a href="#" class="btn btn-warning btn-sm">Edit</a>
                                                <a href="#" class="btn btn-danger btn-sm">Delete</a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><img src="assets/images/avatar3.png" alt="Profile"></td>
                                            <td>Pete Sariya</td>
                                            <td>Achiva Nidhi Limited</td>
                                            <td>12 April 2020</td>
                                            <td><span class="badge badge-success">Success</span></td>
                                            <td>
                                                <a href="#" class="btn btn-primary btn-sm">View</a>
                                                <a href="#" class="btn btn-warning btn-sm">Edit</a>
                                                <a href="#" class="btn btn-danger btn-sm">Delete</a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><img src="assets/images/avatar4.png" alt="Profile"></td>
                                            <td>Anna Mull</td>
                                            <td>Marwadi Shares</td>
                                            <td>17 April 2020</td>
                                            <td><span class="badge badge-warning">Pending</span></td>
                                            <td>
                                                <a href="#" class="btn btn-primary btn-sm">View</a>
                                                <a href="#" class="btn btn-warning btn-sm">Edit</a>
                                                <a href="#" class="btn btn-danger btn-sm">Delete</a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><img src="assets/images/avatar5.png" alt="Profile"></td>
                                            <td>Paul Molive</td>
                                            <td>Gruh Finance Limited</td>
                                            <td>20 April 2020</td>
                                            <td><span class="badge badge-danger">Cancelled</span></td>
                                            <td>
                                                <a href="#" class="btn btn-primary btn-sm">View</a>
                                                <a href="#" class="btn btn-warning btn-sm">Edit</a>
                                                <a href="#" class="btn btn-danger btn-sm">Delete</a>
                                            </td>
                                        </tr>
                                        <!-- Add your dynamic data here -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <!-- include footer -->
            <%@ include file="COMP/manager-footer.jsp" %>
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
        <!-- datatables js -->
        <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
        <!-- main js-->
        <script src="assets/libs/js/main-js.js"></script>

        <script>
            $(document).ready(function() {
                $('#datatable').DataTable();

                // Orders Trend Chart
                var ordersTrendCtx = document.getElementById('ordersTrendChart').getContext('2d');
                var ordersTrendChart = new Chart(ordersTrendCtx, {
                    type: 'line',
                    data: {
                        labels: ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7'],
                        datasets: [{
                            label: 'Success Orders',
                            data: [30, 25, 35, 40, 50, 45, 60],
                            backgroundColor: 'rgba(0, 123, 255, 0.2)',
                            borderColor: 'rgba(0, 123, 255, 1)',
                            borderWidth: 1
                        }, {
                            label: 'Total Orders',
                            data: [50, 45, 55, 60, 70, 65, 80],
                            backgroundColor: 'rgba(255, 99, 132, 0.2)',
                            borderColor: 'rgba(255, 99, 132, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });

                // Revenue Trend Chart
                var revenueTrendCtx = document.getElementById('revenueTrendChart').getContext('2d');
                var revenueTrendChart = new Chart(revenueTrendCtx, {
                    type: 'line',
                    data: {
                        labels: ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7'],
                        datasets: [{
                            label: 'Revenue',
                            data: [3000, 2500, 3500, 4000, 4500, 4200, 4800],
                            backgroundColor: 'rgba(0, 123, 255, 0.2)',
                            borderColor: 'rgba(0, 123, 255, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });

                // Total Sales Unit Chart
                var salesUnitCtx = document.getElementById('salesUnitChart').getContext('2d');
                var salesUnitChart = new Chart(salesUnitCtx, {
                    type: 'pie',
                    data: {
                        labels: ['Sales', 'Profit', 'Growth', 'Loss'],
                        datasets: [{
                            data: [45, 25, 20, 10],
                            backgroundColor: ['#007bff', '#28a745', '#ffc107', '#dc3545']
                        }]
                    }
                });

                // Order Status Chart
                var orderStatusCtx = document.getElementById('orderStatusChart').getContext('2d');
                var orderStatusChart = new Chart(orderStatusCtx, {
                    type: 'pie',
                    data: {
                        labels: ['Success', 'Pending', 'Cancelled'],
                        datasets: [{
                            data: [50, 30, 20],
                            backgroundColor: ['#28a745', '#ffc107', '#dc3545']
                        }]
                    }
                });
            });
        </script>
    </body>
</html>
