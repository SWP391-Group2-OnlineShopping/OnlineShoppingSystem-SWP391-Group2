<!doctype html>
<html lang="en">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <title>Order Detail Manager</title>
        <style>
            .status-badge {
                padding: 0.5em 1em;
                border-radius: 0.25em;
                font-size: 0.9em;
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
            .table td, .table th {
                white-space: nowrap;
            }
        </style>
    </head>
    <body>
        <!-- include header -->
        <%@ include file="COMP/manager-header.jsp" %>

        <!-- include sidebar -->
        <%@ include file="COMP/sale-sidebar.jsp" %>

        <div class="dashboard-wrapper">
            <div class="container-fluid dashboard-content">
                <div class="row">
                    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                        <div class="page-header">
                            <h3 class="mb-2 mt-5">Sale Order Detail</h3>
                            <div class="page-breadcrumb">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="salemanagerdashboard" class="breadcrumb-link">Dashboard</a></li>
                                        <li class="breadcrumb-item"><a href="salemanagerorderlist" class="breadcrumb-link">Order List</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Order Details</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-9">
                        <!-- Order Details -->
                        <div class="card mb-4">
                            <div class="card-body">
                                <div class="mb-3 d-flex justify-content-between">
                                    <div>
                                        <span class="me-3">${order.orderDate}</span>
                                        <span class="status-badge
                                              <c:choose>
                                                  <c:when test="${order.orderStatus == 'Pending Confirmation'}">pending</c:when>
                                                  <c:when test="${order.orderStatus == 'Confirmed'}">confirmed</c:when>
                                                  <c:when test="${order.orderStatus == 'Shipped'}">shipped</c:when>
                                                  <c:when test="${order.orderStatus == 'Delivered'}">delivered</c:when>
                                                  <c:when test="${order.orderStatus == 'Success'}">success</c:when>
                                                  <c:when test="${order.orderStatus == 'Cancelled'}">cancelled</c:when>
                                                  <c:when test="${order.orderStatus == 'Returned'}">returned</c:when>
                                                  <c:when test="${order.orderStatus == 'Unpaid'}">unpaid</c:when>
                                                  <c:when test="${order.orderStatus == 'Failed Delivery'}">cancelled</c:when>
                                                  <c:when test="${order.orderStatus == 'Packaged'}">pending</c:when>
                                                  <c:when test="${order.orderStatus == 'Packaging'}">pending</c:when>
                                                  <c:when test="${order.orderStatus == 'Returning'}">shipped</c:when>
                                              </c:choose>
                                              ">
                                            ${order.orderStatus}
                                        </span>
                                    </div>
                                </div>
                                <table class="table table-borderless">
                                    <thead>
                                        <tr>
                                            <th>Item</th>
                                            <th>Quantity</th>
                                            <th>Price</th>
                                            <th>Total</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${order.orderDetail}" var="od">
                                            <tr>
                                                <td>
                                                    <div class="d-flex mb-2">
                                                        <div class="flex-shrink-0">
                                                            <img src="${od.image}" alt="" width="35" class="img-fluid">
                                                        </div>
                                                        <div class="flex-lg-grow-1 ms-3">
                                                            <h6 class="small mb-0"><a href="#" class="text-reset">${od.title}</a></h6>
                                                            <span class="small">Size: ${od.size}</span>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>${od.quantitySold}</td>
                                                <td class="text-end"><fmt:formatNumber value="${od.priceSold}" pattern="###,###"/> VND</td>
                                                <td class="text-end"><fmt:formatNumber value="${od.quantitySold * od.priceSold}" pattern="###,###"/> VND</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                    <tfoot>
                                        <tr class="fw-bold">
                                            <td colspan="3">TOTAL</td>
                                            <td class="text-end"><fmt:formatNumber value="${order.totalCost}" pattern="###,###"/> VND</td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                        <!-- Payment -->
                        <div class="card mb-4">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-lg-6">
                                        <h3 class="h6">Payment Method</h3>
                                        <p>
                                            ${order.paymentMethods} <br>
                                            Total: <fmt:formatNumber value="${order.totalCost}" pattern="###,###"/> VND<br>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <a href="saleorderlist">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-box-arrow-in-left icon-back" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M10 3.5a.5.5 0 0 0-.5-.5h-8a.5.5 0 0 0-.5.5v9a.5.5 0 0 0 .5.5h8a.5.5 0 0 0 .5-.5v-2a.5.5 0 0 1 1 0v2A1.5 1.5 0 0 1 9.5 14h-8A1.5 1.5 0 0 1 0 12.5v-9A1.5 1.5 0 0 1 1.5 2h8A1.5 1.5 0 0 1 11 3.5v2a.5.5 0 0 1-1 0z"/>
                            <path fill-rule="evenodd" d="M4.146 8.354a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5H14.5a.5.5 0 0 1 0 1H5.707l2.147 2.146a.5.5 0 0 1-.708.708z"/>
                            </svg>
                            Back
                        </a>
                    </div>

                    <div class="col-lg-3">
                        <!-- Customer Information -->
                        <div class="card mb-4">
                            <div class="card-body text-center">
                                <img src="${cus.avatar}" alt="" width="100" class="rounded-circle mb-3">
                                <h3 class="h6">Customer Information</h3>
                                <strong>${order.customerName} (${cus.email})</strong><br>
                                <hr>
                                <h3 class="h6">${cus.full_name}</h3>
                                <h3 class="h6">Address</h3>
                                <address>
                                    ${cus.address}<br>
                                    <abbr title="Phone">Mobile:</abbr> ${cus.phone_number}
                                </address>
                            </div>
                        </div>
                        <!-- Order Notes -->
                        <div class="card mb-4">
                            <div class="card-body">
                                <h3 class="h6">Order Notes</h3>
                                <hr>
                                <p>${order.orderNotes}</p>
                            </div>
                        </div>
                    </div>        
                </div>
            </div>
            <!-- include footer -->
            <%@ include file="COMP/manager-footer.jsp" %>
        </div>

        <!-- Optional JavaScript -->
        <script src="assets/vendor/jquery/jquery-3.3.1.min.js"></script>
        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.js"></script>
        <script src="assets/vendor/slimscroll/jquery.slimscroll.js"></script>
        <script src="assets/libs/js/main-js.js"></script>
    </body>
</html>
