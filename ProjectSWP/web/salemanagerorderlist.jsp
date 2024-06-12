<!doctype html>
<html lang="en">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ page import="java.util.List" %>
    <%@ page import="model.*" %>
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
                color: white;
                text-align: center;
            }
            .status-badge.pending {
                background-color: #ffc107;
            }
            .status-badge.completed {
                background-color: #28a745;
            }
            .status-badge.cancelled {
                background-color: #dc3545;
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
        </style>
    </head>
    <body>
        <!-- include header -->
        <%@ include file="COMP/manager-header.jsp" %>

        <!-- include sidebar -->
        <%@ include file="COMP/sale-sidebar.jsp" %>

        <!-- ============================================================== -->
        <!-- wrapper  -->
        <!-- ============================================================== -->
        <div class="dashboard-wrapper">
            <div class="container-fluid dashboard-content">
                <!-- ============================================================== -->
                <!-- pageheader  -->
                <!-- ============================================================== -->
                <div class="row">
                    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                        <div class="page-header">
                            <h3 class="mb-2">Sale Dashboard</h3>
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
                                    <th>Title</th>
                                    <th>Items</th>
                                    <th>Receiver Name</th>
                                    <th>Order Date</th>
                                    <th>Total Cost</th>
                                    <th>Status</th>
                                    <th>Staff</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="o" items="${orders}" varStatus="status">
                                    <tr>
                                        <td><a href="salemanagerorderdetail?orderID=${o.orderID}">${o.orderID}</a></td>
                                        <td><a href="salemanagerorderdetail?orderID=${o.orderID}">${o.firstProduct} and <b><u>${o.numberOfItems - 1} more...</u></b></a></td>
                                        <td><a href="salemanagerorderdetail?orderID=${o.orderID}">${o.numberOfItems}</a></td>
                                        <td><a href="salemanagerorderdetail?orderID=${o.orderID}">${o.customerName}</a></td>
                                        <td><a href="salemanagerorderdetail?orderID=${o.orderID}">${o.orderDate}</a></td>
                                        <td><fmt:formatNumber value="${o.totalCost}" pattern="###,###"/> VND</td>
                                        <td>
                                            <a href="salemanagerorderdetail?orderID=${o.orderID}">
                                                <span class="status-badge
                                                      <c:choose>
                                                          <c:when test="${o.orderStatus == 'Pending Confirmation'}">pending</c:when>
                                                          <c:when test="${o.orderStatus == 'Confirmed'}">pending</c:when>
                                                          <c:when test="${o.orderStatus == 'Shipped'}">pending</c:when>
                                                          <c:when test="${o.orderStatus == 'Delivered'}">completed</c:when>
                                                          <c:when test="${o.orderStatus == 'Success'}">completed</c:when>
                                                          <c:when test="${o.orderStatus == 'Cancelled'}">cancelled</c:when>
                                                          <c:when test="${o.orderStatus == 'Returned'}">cancelled</c:when>
                                                          <c:when test="${o.orderStatus == 'Unpaid'}">cancelled</c:when>
                                                      </c:choose>
                                                      ">
                                                    ${o.orderStatus}
                                                </span>
                                            </a>
                                        </td>
                                        <td>
                                            <a href="">${o.staff}</a>
                                        </td>
                                        <td>
                                            <a href="#" onclick="toggleSelect(this); return false;" class="change-btn">Change </a>
                                            <select name="sale" class="form-control input-md" onchange="submitSale(this.value, '${o.orderID}')" onfocusout="hideSelect(this);" style="display: none;">
                                                <option value="0">Choose Sale</option>
                                                <c:forEach items="${sales}" var="s">
                                                    <option value="${s.staffID}" ${sale == s.staffID ? "selected" : ""}>${s.fullName}</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="pagination-container mt-4">
                        <a href="?txt=${param.txt}&page=${param.page - 1 > 0 ? param.page - 1 : 1}" class="pagination-link">&laquo;</a>
                        <c:forEach begin="1" end="${endPage}" var="i">
                            <a href="?txt=${param.txt}&page=${i}" class="pagination-link ${i == param.page ? 'active' : ''}">${i}</a>
                        </c:forEach>
                        <a href="?txt=${param.txt}&page=${param.page + 1 <= endPage ? param.page + 1 : endPage}" class="pagination-link">&raquo;</a>
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
                                                function submitSale(selectedValue, orderId) {
                                                    $.ajax({
                                                        url: 'changesale',
                                                        method: 'GET',
                                                        data: {sale_id: selectedValue, order_id: orderId},
                                                        success: function (response) {
                                                            window.location.reload(); // Reload the page after successful change
                                                        },
                                                        error: function (xhr, status, error) {
                                                            console.error('Error changing sale: ', status, error);
                                                        }
                                                    });
                                                }

                                                function toggleSelect(element) {
                                                    var select = element.nextElementSibling;
                                                    element.style.display = 'none'; // Ẩn nút Change
                                                    select.style.display = 'inline-block'; // Hiển thị thẻ select
                                                    select.focus(); // Đặt tiêu điểm vào thẻ select
                                                }

                                                function hideSelect(select) {
                                                    var changeBtn = select.previousElementSibling;
                                                    if (!select.contains(document.activeElement)) {
                                                        select.style.display = 'none'; // Ẩn thẻ select
                                                        changeBtn.style.display = 'inline'; // Hiển thị nút Change
                                                    }
                                                }

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

                                                    var url = 'salemanagerorderlist?' + searchParams.toString();
                                                    loadOrders(url);
                                                }

        </script>
    </body>
</html>
