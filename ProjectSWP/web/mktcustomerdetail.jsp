<!doctype html>
<html lang="en">
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <title>Marketing Dashboard</title>
        <style>
            body {
                background-color: #f8f9fa;
            }
            .breadcrumb {
                background: none;
                padding: 0;
            }
            .breadcrumb-item + .breadcrumb-item::before {
                content: ">";
            }
            .user-profile-info {
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            .user-profile-desc {
                margin-top: 20px;
            }
            .user-profile-image {
                text-align: center;
                margin-bottom: 20px;
            }
            .user-profile-image img {
                width: 100%;
                height: auto;
                max-width: 250px;
                max-height: 290px;
                object-fit: cover;
            }
            .form-group label {
                font-weight: bold;
            }
            .form-control[readonly] {
                background-color: #e9ecef;
                opacity: 1;
            }
            .card {
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            .card-header {
                background: #fff;
                border-bottom: none;
            }
            .card-header h4 {
                margin: 0;
            }
            .table th, .table td {
                vertical-align: middle;
            }
            .status-label {
                padding: 5px 10px;
                border-radius: 4px;
                color: #fff;
                text-align: center;
            }
            .status-1 {
                background-color: #28a745;
            } /* Active */
            .status-2 {
                background-color: #dc3545;
            } /* Ban */
            .status-3 {
                background-color: #6c757d;
            } /* Closed */
            .status-4 {
                background-color: #ffc107;
            } /* Suspended */
            .status-5 {
                background-color: #343a40;
            }
            /* Locked */

            .icon-back {
                vertical-align: middle;
                margin-right: 5px;
            }
        </style>
    </head>
    <body>
        <!-- include header -->
        <%@ include file="COMP/manager-header.jsp" %>
        <!-- include sidebar -->
        <%@ include file="COMP/marketing-sidebar.jsp" %>
        <div class="dashboard-wrapper">
            <div class="container-fluid dashboard-content">
                <div class="row">
                    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                        <div class="page-header">
                            <h3 class="mb-2">Marketing Dashboard</h3>
                            <div class="page-breadcrumb">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="dashboardmkt" class="breadcrumb-link">Dashboard</a></li>
                                        <li class="breadcrumb-item"><a href="mktcustomerlist" class="breadcrumb-link">Customer Manager</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">${sessionScope.customer.full_name}</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <!-- Customer Information Section -->
                    <div class="col-lg-4">
                        <div class="user-profile-info">
                            <div class="user-profile-image">
                                <img src="${sessionScope.customer.avatar}" alt="Customer Avatar" />
                            </div>
                            <div class="user-profile-desc">
                                <h4 class="text-center">${sessionScope.customer.full_name}</h4>
                                <div class="form-group">
                                    <label>Email</label>
                                    <input type="email" class="form-control" value="${sessionScope.customer.email}" readonly />
                                </div>
                                <div class="form-group">
                                    <label>Phone</label>
                                    <input type="text" class="form-control" value="${sessionScope.customer.phone_number}" readonly />
                                </div>
                                <div class="form-group">
                                    <label>Address</label>
                                    <input type="text" class="form-control" value="${sessionScope.customer.address}" readonly />
                                </div>
                                <div class="form-group">
                                    <label>Gender</label>
                                    <input type="text" class="form-control" value="${sessionScope.customer.gender ? 'Male' : 'Female'}" readonly />
                                </div>
                                <div class="form-group">
                                    <label>Status</label>
                                    <div>
                                        <c:choose>
                                            <c:when test="${sessionScope.customer.status == 1}">
                                                <span class="status-label status-1">Active</span>
                                            </c:when>
                                            <c:when test="${sessionScope.customer.status == 2}">
                                                <span class="status-label status-2">Ban</span>
                                            </c:when>
                                            <c:when test="${sessionScope.customer.status == 3}">
                                                <span class="status-label status-3">Closed</span>
                                            </c:when>
                                            <c:when test="${sessionScope.customer.status == 4}">
                                                <span class="status-label status-4">Suspended</span>
                                            </c:when>
                                            <c:when test="${sessionScope.customer.status == 5}">
                                                <span class="status-label status-5">Locked</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-label status-0">Unknown</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Customer History Section -->
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header">
                                <h4>Customer History</h4>
                            </div>
                            <div class="card-body">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Change Date</th>
                                            <th>Full Name</th>
                                            <th>Address</th>
                                            <th>Mobile</th>
                                            <th>Email</th>
                                            <th>Gender</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="history" items="${history}">
                                            <tr>
                                                <td>${history.changeDate}</td>
                                                <td>${history.fullName}</td>
                                                <td>${history.address}</td>
                                                <td>${history.mobile}</td>
                                                <td>${history.email}</td>
                                                <td>${history.gender ? 'Male' : 'Female'}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div>
                    <h4>
                        <a href="mktcustomerlist">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-box-arrow-in-left icon-back" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M10 3.5a.5.5 0 0 0-.5-.5h-8a.5.5 0 0 0-.5.5v9a.5.5 0 0 0 .5.5h8a.5.5 0 0 0 .5-.5v-2a.5.5 0 0 1 1 0v2A1.5 1.5 0 0 1 9.5 14h-8A1.5 1.5 0 0 1 0 12.5v-9A1.5 1.5 0 0 1 1.5 2h8A1.5 1.5 0 0 1 11 3.5v2a.5.5 0 0 1-1 0z"/>
                            <path fill-rule="evenodd" d="M4.146 8.354a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5H14.5a.5.5 0 0 1 0 1H5.707l2.147 2.146a.5.5 0 0 1-.708.708z"/>
                            </svg>
                            Back
                        </a>
                    </h4>
                </div>
                <!-- ============================================================== -->
                <!-- End code for your page -->
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

    </body>
</html>
