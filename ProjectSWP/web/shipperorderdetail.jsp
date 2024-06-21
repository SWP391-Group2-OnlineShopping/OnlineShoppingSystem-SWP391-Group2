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
                background-color: #ffc107;
                color: white;
            }
            .status-badge.completed {
                background-color: #28a745;
                color: white;
            }
            .status-badge.cancelled {
                background-color: #dc3545;
                color: white;
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
        <%@ include file="COMP/shipper-sidebar.jsp" %>

        <div class="dashboard-wrapper">
            <div class="container-fluid dashboard-content">
                <div class="row">
                    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                        <div class="page-header">
                            <h3 class="mb-2 mt-5">Shipper Order Detail</h3>
                            <div class="page-breadcrumb">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="shipperdashboard" class="breadcrumb-link">Dashboard</a></li>
                                        <li class="breadcrumb-item"><a href="shipperordermanager" class="breadcrumb-link">Order Manager</a></li>
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
                                                  <c:when test="${order.orderStatus == 'Confirmed'}">pending</c:when>
                                                  <c:when test="${order.orderStatus == 'Shipped'}">pending</c:when>
                                                  <c:when test="${order.orderStatus == 'Delivered'}">completed</c:when>
                                                  <c:when test="${order.orderStatus == 'Success'}">completed</c:when>
                                                  <c:when test="${order.orderStatus == 'Cancelled'}">cancelled</c:when>
                                                  <c:when test="${order.orderStatus == 'Returned'}">cancelled</c:when>
                                                  <c:when test="${order.orderStatus == 'Unpaid'}">cancelled</c:when>
                                              </c:choose>
                                              ">
                                            ${order.orderStatus}
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Payment -->
                        <div class="card mb-4">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-lg-6">
                                        <h3 class="h6">Collect receiver money on delivery</h3>
                                        <p>
                                            <c:choose>
                                                <c:when test="${order.paymentMethods == 'Ship COD'}">
                                                    Total: <fmt:formatNumber value="${order.totalCost}" pattern="###,###"/> VND<br>
                                                </c:when>
                                                <c:otherwise>
                                                    Total: 0 VND<br>
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
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
