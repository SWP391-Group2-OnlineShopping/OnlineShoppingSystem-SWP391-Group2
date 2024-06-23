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
                background-color: #ffc107;
            } /* yellow */
            .status-badge.confirmed {
                background-color: #007bff;
            } /* blue */
            .status-badge.shipped {
                background-color: #fd7e14;
            } /* orange */
            .status-badge.delivered {
                background-color: #0056b3;
            } /* dark blue */
            .status-badge.success {
                background-color: #28a745;
            } /* green */
            .status-badge.cancelled, .status-badge.unpaid {
                background-color: #dc3545;
            } /* red */
            .status-badge.returned {
                background-color: #fffd55;
                color: black;
            } /* yellow-green */
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
                color: #6c757d;
                margin-left: 10px;
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
            .sort-btn {
                display: flex;
                align-items: center;
                cursor: pointer;
                color: #007bff;
                text-decoration: none;
            }
            .sort-btn:hover {
                color: #0056b3;
            }
            .filter-label {
                margin-top: 10px;
            }

            /* Responsive styles */
            @media only screen and (max-width: 760px),
            (min-device-width: 768px) and (max-device-width: 1024px) {
                    #order-table, #order-table thead, #order-table tbody, #order-table th, #order-table td, #order-table tr {
                        display: block;
                    }
                    #order-table thead tr {
                        position: absolute;
                        top: -9999px;
                        left: -9999px;
                    }
                    #order-table tr {
                        border: 1px solid #ccc;
                    }
                    #order-table td {
                        border: none;
                        border-bottom: 1px solid #eee;
                        position: relative;
                    }

                    #order-table td:before {
                        width: 45%;
                        white-space: nowrap;
                    }
                    #order-table td:nth-of-type(1):before {
                        content: "ID";
                    }
                    #order-table td:nth-of-type(2):before {
                        content: "Receiver Name";
                    }
                    #order-table td:nth-of-type(3):before {
                        content: "Order Date";
                    }
                    #order-table td:nth-of-type(4):before {
                        content: "Collect amount";
                    }
                    #order-table td:nth-of-type(5):before {
                        content: "Status";
                    }
                    #order-table td:nth-of-type(6):before {
                        content: "Handle1";
                    }
                    #order-table td:nth-of-type(7):before {
                        content: "Handle2";
                    }

                    #order-table a {
                        position: absolute;
                        top: 10px;
                        right: 6px;
                        width: 45%;
                    }
            }
                </style>
            </head>
            <body>

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
                                    <h3 class="mb-2">Shipper Order Manager</h3>
                                    <div class="page-breadcrumb">
                                        <nav aria-label="breadcrumb">
                                            <ol class="breadcrumb">
                                                <li class="breadcrumb-item"><a href="shipperdashboard" class="breadcrumb-link">Dashboard</a></li>
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
                            <div class="filter-container">
                                <div class="row mb-2">
                                    <div class="col-md-3 col-sm-6 mb-2">
                                        <input type="text" class="form-control" id="filterInput" placeholder="Search...">
                                    </div>
                                    <div class="col-md-3 col-sm-6 mb-2">
                                        <select class="form-control" id="statusFilter">
                                            <option value="All">All</option>
                                            <option value="Packaged">Packaged</option>
                                            <option value="Shipping">Shipping</option>
                                            <option value="Delivered">Delivered</option>
                                            <option value="Failed Delivery">Failed Delivery</option>
                                            <option value="Returning">Returning</option>
                                            <option value="Returned">Returned</option>
                                        </select>
                                    </div>
                                    <!-- Added date range filters -->
                                    <div class="col-md-2 col-sm-6 mb-2">
                                        <input type="date" class="form-control" id="dateFrom" placeholder="From Date">
                                    </div>
                                    <div class="col-md-2 col-sm-6 mb-2">
                                        <input type="date" class="form-control" id="dateTo" placeholder="To Date">
                                    </div>
                                    <div class="col-md-2 col-sm-6 mb-2 text-right">
                                        <button class="btn btn-outline-primary" onclick="clearFilters()">
                                            <i class="fas fa-undo-alt"></i> Clear Filters
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <div class="table-responsive mt-4">
                                <table id="order-table" class="table table-striped table-bordered">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Receiver Name</th>
                                            <th>Order Date</th>
                                            <th>Collect Amount</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>

                                    <tbody id="orderList">
                                    <p id="resultCount"></p>
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
                                                    
                                                <!-- waiting return -> returning -->
                                                <c:if test="${o.orderStatusID == 14}">
                                                    <a class="btn btn-confirm btn-sm text-white" href="shipperchangestatus?order_id=${o.orderID}&status=12">Returning</a>
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
                                                    %> <!-- delivery fail -> returning  --><a class="btn btn-confirm btn-sm text-white" href="shipperchangestatus?order_id=${o.orderID}&status=12">Returning</a> <%
                                                            } else {
                                                    %> <!-- delivery fail -> ship again --><a class="btn btn-confirm btn-sm text-white" href="shipperchangestatus?order_id=${o.orderID}&status=3">Ship again</a> <%
                                                        }
                                                    }
                                                    %>
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

                            <div class="pagination-container mt-4">
                                <a href="?page=${param.index - 1 > 0 ? param.page - 1 : 1}" class="pagination-link">&laquo;</a>
                                <c:forEach begin="1" end="${endPage}" var="i">
                                    <a href="?page=${i}" class="pagination-link ${i == param.page ? 'active' : ''}">${i}</a>
                                </c:forEach>
                                <a href="?page=${param.index + 1 <= endPage ? param.index + 1 : endPage}" class="pagination-link">&raquo;</a>
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
                                            $(document).ready(function () {
                                                // Bind the filter functions to the input elements
                                                $('#filterInput').on('keyup', filterResults);
                                                $('#statusFilter').on('change', filterResults);
                                                $('#dateFrom, #dateTo').on('change', filterResults); // Added date range change event

                                                function filterResults() {
                                                    var searchValue = $('#filterInput').val().toLowerCase();
                                                    var statusValue = $('#statusFilter').val();
                                                    var dateFrom = $('#dateFrom').val();
                                                    var dateTo = $('#dateTo').val();
                                                    var visibleRows = 0;

                                                    $('#orderList tr').each(function () {
                                                        var row = $(this);
                                                        var receiverName = row.find('td:nth-child(2)').text().toLowerCase();
                                                        var orderStatus = row.find('td:nth-child(5)').text();
                                                        var orderDate = row.find('td:nth-child(3)').text();

                                                        var textMatch = receiverName.indexOf(searchValue) > -1;
                                                        var statusMatch = (statusValue === 'All') || (orderStatus.indexOf(statusValue) > -1);

                                                        // Date range filter logic
                                                        var dateMatch = true;
                                                        if (dateFrom && dateTo) {
                                                            var orderDateObj = new Date(orderDate);
                                                            var fromDate = new Date(dateFrom);
                                                            var toDate = new Date(dateTo);
                                                            dateMatch = orderDateObj >= fromDate && orderDateObj <= toDate;
                                                        }

                                                        var shouldDisplay = textMatch && statusMatch && dateMatch;
                                                        row.toggle(shouldDisplay);

                                                        if (shouldDisplay) {
                                                            visibleRows++;
                                                        }
                                                    });

                                                    $('#resultCount').text('Number of results: ' + visibleRows);
                                                }

                                                // Initial count
                                                filterResults();


                                            });
                                            function clearFilters() {
                                                $('#filterInput').val('');
                                                $('#statusFilter').val('All');
                                                $('#dateFrom').val('');
                                                $('#dateTo').val('');
                                                filterResults(); // Apply empty filters to reset the view
                                            }


                </script>

