<!doctype html>
<html lang="en">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ page import="java.util.List" %>
    <%@ page import="model.*" %>
    <%@ page import="dal.OrderDAO" %>
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
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <title>Order List Manager</title>
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Circular Std', sans-serif;
            }
            h4 {
                display: flex;
                align-items: center;
                justify-content: right;
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

            /* Responsive styles */
            @media only screen and (max-width: 760px),
            (min-device-width: 768px) and (max-device-width: 1024px) {
                .table-responsive table, thead, tbody, th, td, tr {
                    display: block;
                }
                thead tr {
                    position: absolute;
                    top: -9999px;
                    left: -9999px;
                }
                tr {
                    border: 1px solid #ccc;
                }
                td {
                    border: none;
                    border-bottom: 1px solid #eee;
                    position: relative;
                    padding-left: 50%;
                }
                td:before {

                    width: 45%;
                    padding-right: 10px;
                    white-space: nowrap;
                }
                td:nth-of-type(1):before {
                    content: "ID";
                }
                td:nth-of-type(2):before {
                    content: "Receiver Name";
                }
                td:nth-of-type(3):before {
                    content: "Order Date";
                }
                td:nth-of-type(4):before {
                    content: "Collect amount";
                }
                td:nth-of-type(5):before {
                    content: "Status";
                }
                td:nth-of-type(6):before {
                    content: "Handle1";
                }
                td:nth-of-type(7):before {
                    content: "Handle2";
                }

                a {
                    position: absolute;
                    top: 10px;
                    right: 6px;
                    width: 45%;
                }
            }
        </style>
    </head>
    <body>
        <!-- include header -->
        <%@ include file="COMP/manager-header.jsp" %>

        <!-- include sidebar -->
        <%@ include file="COMP/shipper-sidebar.jsp" %>

        <!-- ============================================================== -->
        <!-- wrapper  -->
        <!-- ============================================================== -->
        <div class="dashboard-wrapper ">
            <div class="container-fluid dashboard-content ">
                <!-- ============================================================== -->
                <!-- pageheader  -->
                <!-- ============================================================== -->
                <div class="row ">
                    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                        <div class="page-header">
                            <h3 class="mb-2 mt-5">Shipper Order Manager</h3>
                            <div class="page-breadcrumb">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="dashboardmkt" class="breadcrumb-link">Dashboard</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Order Manager</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- ============================================================== -->
                <!-- pageheader  -->
                <!-- ============================================================== -->
                <!-- ============================================================== -->
                <!-- Order List -->
                <!-- ============================================================== -->
                <div class="container-fluid">
                    <h1 class="mb-4">Order List</h1>
                    <div class="filter-container row">
                        <div class="col-md-3 col-sm-6 mb-2">
                            <input type="text" class="form-control" id="saleName" placeholder="Sale Name">
                        </div>
                        <div class="col-md-3 col-sm-6 mb-2">
                            <select id="sortOptions" class="form-control w-auto" onchange="applySort(this.value)">
                                <option value="0">All</option>
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
                        <div class="col-md-3 col-sm-6 mb-2">
                            <input type="date" class="form-control" id="dateFrom" placeholder="From Date">
                        </div>
                        <div class="col-md-3 col-sm-6 mb-2">
                            <input type="date" class="form-control" id="dateTo" placeholder="To Date">
                        </div>
                    </div>
                    <div class="table-responsive mt-4">
                        <table class="table table-striped table-bordered">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Receiver Name</th>
                                    <th>Order Date</th>
                                    <th>Collect payment amount</th>
                                    <th>Status</th>
                                    <th>Handle1</th>
                                    <th>Handle2</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="o" items="${orders}" varStatus="status">
                                    <tr>
                                        <td><a href="shipperorderdetail?orderID=${o.orderID}">${o.orderID}</a></td>
                                        <td><a href="shipperorderdetail?orderID=${o.orderID}">${o.customerName}</a></td>
                                        <td><a href="shipperorderdetail?orderID=${o.orderID}">${o.orderDate}</a></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${o.paymentMethods == 'Ship COD'}">
                                                    <a href="shipperorderdetail?orderID=${o.orderID}"><fmt:formatNumber value="${o.totalCost}" pattern="###,###"/> VND</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="shipperorderdetail?orderID=${o.orderID}">0 VND</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <a href="shipperorderdetail?orderID=${o.orderID}">
                                                ${o.orderStatus}
                                            </a>
                                        </td>
                                        <td>
                                            <!-- packaged -> shipping -->
                                            <c:if test="${o.orderStatusID == 10}">
                                                <a class="btn btn-confirm btn-sm text-white" href="shipperchangestatus?order_id=${o.orderID}&status=3">Shipping</a>
                                            </c:if>
                                            <!-- shipping -> delivered -->
                                            <c:if test="${o.orderStatusID == 3}">
                                                <a class="btn btn-confirm btn-sm text-white" href="shipperchangestatus?order_id=${o.orderID}&status=4">Success</a>
                                            </c:if>

                                            <!-- delivery fail -> shipping -->
                                            <c:if test="${o.orderStatusID == 9}">
                                                <% 
                                                    // Retrieve the 'o' variable from the PageContext
                                                    Orders order = (Orders) pageContext.getAttribute("o");
                                                    if (order != null) {
                                                        OrderDAO orderDAO = new OrderDAO();
                                                        if (orderDAO.isOrderFailed(order.getOrderID())) {
                                                %> <!-- delivery fail -> returning->  --><a class="btn btn-confirm btn-sm text-white" href="shipperchangestatus?order_id=${o.orderID}&status=12">Returning</a> <%
                                                        } else {
                                                %> <!-- delivery fail -> ship again --><a class="btn btn-confirm btn-sm text-white" href="shipperchangestatus?order_id=${o.orderID}&status=3">Ship again</a> <%
                                                    }
                                                }
                                                %>
                                                
                                            </c:if>
                                            <!-- returning -> returned -->
                                            <c:if test="${o.orderStatusID == 12}">
                                                <a class="btn btn-confirm btn-sm text-white" href="shipperchangestatus?order_id=${o.orderID}&status=7">Returned</a>
                                            </c:if>
            
                                        </td>
                                        <td>
                                            <c:if test="${o.orderStatusID == 3}">
                                                <!-- shipping -> delivery fail --><a class="btn btn-confirm btn-sm text-white" href="shipperchangestatus?order_id=${o.orderID}&status=9">Failed</a>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                </div>

                <!-- ============================================================== -->
                <!-- End Order List -->
                <!-- ============================================================== -->
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
        <!-- main js-->
        <script src="assets/libs/js/main-js.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
                                            var newTableContent = $(response).find('.table-responsive').html();
                                            $('.table-responsive').html(newTableContent);
                                            console.log('Orders loaded successfully.');
                                        },
                                        error: function (xhr, status, error) {
                                            console.error('Error loading orders: ', status, error);
                                        }
                                    });
                                }

                                function applySort(sortBy) {
                                    console.log('Selected sort option:', sortBy);
                                    var searchParams = new URLSearchParams(window.location.search);
                                    searchParams.set('orderStatus', sortBy);

                                    var url = 'shipperordermanager?' + searchParams.toString();
                                    loadOrders(url);
                                }
        </script>
    </body>
</html>