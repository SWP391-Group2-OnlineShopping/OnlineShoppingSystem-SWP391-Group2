<!doctype html>
<html lang="en">
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <title>Marketing Dashboard </title>
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Circular Std', sans-serif;
            }
            h1, h3, h5 {
                font-weight: bold;
            }
            input, select {
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 5px;
                outline: none;
                transition: border-color 0.3s;
            }
            input:focus, select:focus {
                border-color: #80bdff;
            }
            a {
                color: #007bff;
                text-decoration: none;
                transition: color 0.3s;
            }
            a:hover {
                color: #0056b3;
            }
            .status-badge {
                padding: 0.5em 1em;
                border-radius: 0.25em;
                font-size: 0.9em;
                color: white;
                text-align: center;
            }
            .status-badge.pending {
                background-color: #ffc107; /* yellow */
            }
            .status-badge.confirmed {
                background-color: #007bff; /* blue */
            }
            .status-badge.shipped {
                background-color: #fd7e14; /* orange */
            }
            .status-badge.delivered {
                background-color: #0056b3; /* dark blue */
            }
            .status-badge.success {
                background-color: #28a745; /* green */
            }
            .status-badge.cancelled, .status-badge.unpaid {
                background-color: #dc3545; /* red */
            }
            .status-badge.returned {
                background-color: #fffd55; /* yellow-green */
                color: black; /* Adjust text color for readability */
            }
            .table a {
                color: #007bff;
                text-decoration: none;
            }
            .table td, .table th {
                white-space: nowrap;
            }
            .filter-container {
                background-color: #fff;
                padding: 15px;
                border-radius: 5px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }
            .table-responsive {
                border-radius: 5px;
                overflow: hidden;
                background-color: #fff;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            }
            .pagination-container {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 20px;
            }
            .pagination-link {
                padding: 10px 15px;
                margin: 0 5px;
                border: 1px solid #dee2e6;
                border-radius: 5px;
                color: #007bff;
                text-decoration: none;
                transition: background-color 0.3s, color 0.3s;
            }
            .pagination-link:hover {
                background-color: #007bff;
                color: white;
            }
            .pagination-link.active {
                background-color: #007bff;
                color: white;
                cursor: default;
            }
            .change-btn {
                text-decoration: underline;
                color: #6c757d; /* Màu hơi mờ nhạt */
                margin-left: 10px; /* Dịch sang bên phải */
            }
            .sale-select {
                margin-top: 10px;
            }
            .btn-confirm {
                color: #fff;
                background-color: #28a745;
                border-color: #28a745;
                margin-right: 5px;
            }
            .btn-cancel {
                color: #fff;
                background-color: #dc3545;
                border-color: #dc3545;
            }
            .btn-print {
                color: #fff;
                background-color: orange;
                border-color: orange;
            }
        </style>
    </head>

    <body>
        <!-- include header -->
        <%@ include file="COMP\manager-header.jsp" %>

        <!-- include sidebar -->
        <%@ include file="COMP\warehouse-sidebar.jsp" %>

        <!-- ============================================================== -->
        <!-- wrapper  -->
        <!-- ============================================================== -->
        <div class="dashboard-wrapper">
            <div class="container-fluid  dashboard-content">
                <!-- ============================================================== -->
                <!-- TODO: change pagehader  -->
                <!-- ============================================================== -->
                <div class="row">
                    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                        <div class="page-header">
                            <h3 class="mb-2">Warehouse Dashboard</h3>


                            <div class="page-breadcrumb">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="dashboardmkt" class="breadcrumb-link">Dashboard</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Order List</li>

                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- ============================================================== -->
                <!-- pagehader  -->
                <!-- ============================================================== -->
                <div class="container-fluid">
                    <h1 class="mb-4">Order List</h1>

                    <div class="filter-container">
                        <div class="row mb-2">
                            <div class="col-md-12">
                                <h5>Search:</h5>
                                <input type="text" class="form-control" id="searchQuery" placeholder="Search by ID or customer's name..." onkeyup="applyFiltersSearch()">
                            </div>
                        </div>
                        <div class="row mb-2">

                            <div class="col-md-3 col-sm-6 mb-2">
                                <h5>Order by Status:</h5>
                                <select id="statusSort" class="form-control" onchange="applyFilters()">
                                    <option value="0">All</option>
                                    <option value="2">Confirmed</option>
                                    <option value="3">Shipping</option>
                                    <option value="4">Delivered</option>
                                    <option value="5">Success</option>
                                    <option value="7">Returned</option>
                                    <option value="9">Ship Fail</option>
                                    <option value="10">Packaged</option>
                                </select>
                            </div>
                            <div class="col-md-3 col-sm-6 mb-2">
                                <h5>From:</h5>
                                <input type="date" class="form-control" id="dateFrom" onchange="applyFilters()">
                            </div>
                            <div class="col-md-3 col-sm-6 mb-2">
                                <h5>To:</h5>
                                <input type="date" class="form-control" id="dateTo" onchange="applyFilters()">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12 text-right">
                                <button class="btn btn-outline-primary btn-lg" onclick="clearFilters()">
                                    <i class="fas fa-undo-alt"></i> Clear Filter
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="table-responsive mt-4">
                        <table class="table table-striped table-bordered">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Title</th>
                                    <th>Items</th>
                                    <th>Receiver Name</th>
                                    <th>Order Date</th>
                                    <th>Total Cost</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="o" items="${orders}" varStatus="status">
                                    <tr>
                                        <td><a href="warehouseorderdetail?orderID=${o.orderID}">${o.orderID}</a></td>
                                        <td><a href="warehouseorderdetail?orderID=${o.orderID}">${o.firstProduct} and <b><u>${o.numberOfItems - 1} more...</u></b></a></td>
                                        <td><a href="warehouseorderdetail?orderID=${o.orderID}">${o.numberOfItems}</a></td>
                                        <td><a href="warehouseorderdetail?orderID=${o.orderID}">${o.customerName}</a></td>
                                        <td><a href="warehouseorderdetail?orderID=${o.orderID}">${o.orderDate}</a></td>
                                        <td><fmt:formatNumber value="${o.totalCost}" pattern="###,###"/> VND</td>
                                        <td>
                                            <a href="warehouseorderdetail?orderID=${o.orderID}">
                                                <span class="status-badge
                                                      <c:choose>
                                                          <c:when test="${o.orderStatus == 'Pending Confirmation'}">pending</c:when>
                                                          <c:when test="${o.orderStatus == 'Confirmed'}">confirmed</c:when>
                                                          <c:when test="${o.orderStatus == 'Shipped'}">shipped</c:when>
                                                          <c:when test="${o.orderStatus == 'Delivered'}">delivered</c:when>
                                                          <c:when test="${o.orderStatus == 'Success'}">success</c:when>
                                                          <c:when test="${o.orderStatus == 'Cancelled'}">cancelled</c:when>
                                                          <c:when test="${o.orderStatus == 'Returned'}">returned</c:when>
                                                          <c:when test="${o.orderStatus == 'Unpaid'}">unpaid</c:when>
                                                          <c:when test="${o.orderStatus == 'Failed Delivery'}">cancelled</c:when>
                                                          <c:when test="${o.orderStatus == 'Packaged'}">pending</c:when>
                                                      </c:choose>
                                                      ">
                                                    ${o.orderStatus}
                                                </span>
                                            </a>
                                        </td>
                                        <td>
                                            <c:if test="${o.orderStatusID == 2}">
                                                <a class="btn btn-confirm btn-sm text-white" href="changestatuswarehouse?order_id=${o.orderID}&status=${o.orderStatusID}&value=10">Packaged</a>

                                            </c:if>
                                            <a class="btn btn-print btn-sm text-white" href="createorderlabel?orderID=${o.orderID}" target="_blank">Print Label Order</a>
                                        </td>
                                    </tr>
                                </c:forEach>

                            </tbody>
                        </table>
                    </div>

                    <div class="pagination-container mt-4">
                        <a href="?page=${param.index - 1 > 0 ? param.page - 1 : 1}" class="pagination-link">&laquo;</a>
                        <c:forEach begin="1" end="${endPage}" var="i">
                            <a href="?page=${i}" class="pagination-link ${i == param.page ? 'active' : ''}">${i}</a>
                        </c:forEach>
                        <a href="?page=${param.index + 1 <= endPage ? param.index + 1 : endPage}" class="pagination-link">&raquo;</a>
                    </div>
                </div>
                <!-- ============================================================== -->
                <!-- TODO: Start code your page here!!>
                <!-- ============================================================== -->
                <!-- ============================================================== -->
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

        <!-- main js-->
        <script src="assets/libs/js/main-js.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script>
                                    document.addEventListener('DOMContentLoaded', function () {
                                        var today = new Date();
                                        var sevenDaysAgo = new Date();
                                        sevenDaysAgo.setDate(today.getDate() - 7);

                                        var formatDate = function (date) {
                                            var day = ("0" + date.getDate()).slice(-2);
                                            var month = ("0" + (date.getMonth() + 1)).slice(-2);
                                            return date.getFullYear() + "-" + month + "-" + day;
                                        };

                                        document.getElementById('dateFrom').value = formatDate(sevenDaysAgo);
                                        document.getElementById('dateTo').value = formatDate(today);
                                    });

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
                                                var newTableContent = $(response).find('.table-responsive').html();
                                                $('.table-responsive').html(newTableContent);
                                                console.log('Orders loaded successfully.');
                                            },
                                            error: function (xhr, status, error) {
                                                console.error('Error loading orders: ', status, error);
                                            }
                                        });
                                    }

                                    function clearFilters() {
                                        document.getElementById('statusSort').value = '0';
                                        document.getElementById('searchQuery').value = '';

                                        var today = new Date();
                                        var sevenDaysAgo = new Date();
                                        sevenDaysAgo.setDate(today.getDate() - 7);

                                        var formatDate = function (date) {
                                            var day = ("0" + date.getDate()).slice(-2);
                                            var month = ("0" + (date.getMonth() + 1)).slice(-2);
                                            return date.getFullYear() + "-" + month + "-" + day;
                                        };

                                        document.getElementById('dateFrom').value = formatDate(sevenDaysAgo);
                                        document.getElementById('dateTo').value = formatDate(today);

                                        applyFilters();
                                    }

                                    function applyFilters() {
                                        var statusSort = document.getElementById('statusSort').value;
                                        var dateFrom = document.getElementById('dateFrom').value;
                                        var dateTo = document.getElementById('dateTo').value;
                                        var searchQuery = document.getElementById('searchQuery').value;

                                        var searchParams = new URLSearchParams(window.location.search);
                                        searchParams.set('statusSort', statusSort);
                                        searchParams.set('dateFrom', dateFrom);
                                        searchParams.set('dateTo', dateTo);
                                        searchParams.set('searchQuery', searchQuery);

                                        var url = 'warehouseorderlist?' + searchParams.toString();
                                        loadOrders(url);
                                    }

                                    function applyFiltersSearch() {
                                        var statusSort = document.getElementById('statusSort').value;
                                        var dateFrom = document.getElementById('dateFrom').value;
                                        var dateTo = document.getElementById('dateTo').value;
                                        var searchQuery = document.getElementById('searchQuery').value;

                                        var searchParams = new URLSearchParams(window.location.search);
                                        searchParams.set('statusSort', statusSort);
                                        searchParams.set('dateFrom', dateFrom);
                                        searchParams.set('dateTo', dateTo);
                                        searchParams.set('searchQuery', searchQuery);

                                        var url = 'warehouseorderlist?' + searchParams.toString();
                                        loadOrders(url);
                                    }
        </script>
    </body>
</html>
