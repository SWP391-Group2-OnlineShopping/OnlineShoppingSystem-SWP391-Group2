<!doctype html>
<html lang="en">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="model.*" %>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            .table-wrapper {
                margin: 20px 0;
            }
            .table-title {
                padding-bottom: 15px;
                background: #343a40;
                color: #fff;
                padding: 16px 30px;
                margin: -20px -25px 10px;
                border-radius: 3px 3px 0 0;
            }
            .table-title h2 {
                margin: 5px 0 0;
                font-size: 24px;
            }
            .table-title .form-inline {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .table th, .table td {
                border-color: #e9e9e9;
            }
            .table-striped tbody tr:nth-of-type(odd) {
                background-color: #f3f3f3;
            }
            .table td img {
                width: 100px;
                height: 100px;
                object-fit: cover;
            }
            .status-label {
                padding: 5px 10px;
                border-radius: 4px;
                color: #fff;
                text-align: center;
            }
            .status-1 {
                background-color: #28a745; /* Active */
            }
            .status-2 {
                background-color: #dc3545; /* Ban */
            }
            .status-3 {
                background-color: #6c757d; /* Closed */
            }
            .status-4 {
                background-color: #ffc107; /* Suspended */
            }
            .status-5 {
                background-color: #343a40; /* Locked */
            }
        </style>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="js/filterStatusAjax.js"></script>
    </head>
    <body>
        <!-- include header -->
        <%@ include file="/COMP/manager-header.jsp" %>
        <!-- include sidebar -->
        <%@ include file="/COMP/marketing-sidebar.jsp" %>

        <!-- ============================================================== -->
        <!-- wrapper  -->
        <!-- ============================================================== -->
        <div class="dashboard-wrapper">
            <div class="container-fluid  dashboard-content">
                <!-- ============================================================== -->
                <!-- page header -->
                <!-- ============================================================== -->
                <div class="row">
                    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                        <div class="page-header">
                            <h3 class="mb-2">Marketing Dashboard</h3>
                            <div class="page-breadcrumb">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="dashboardmkt" class="breadcrumb-link">Dashboard</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Customer Manager</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- ============================================================== -->
                <!-- page header -->
                <!-- ============================================================== -->
                <div class="row">
                    <div class="col-12">
                        <div class="table-wrapper">
                            <div class="table-title">
                                <div class="form-inline">
                                    <form class="form-inline">
                                        <div class="form-group mr-2">
                                            <label for="status">Filter by Status:</label>
                                            <select class="form-control ml-2" id="status" name="status">
                                                <option value="">All</option>
                                                <option value="1">Active</option>
                                                <option value="2">Ban</option>
                                                <option value="3">Closed</option>
                                                <option value="4">Suspended</option>
                                                <option value="5">Locked</option>
                                            </select>
                                        </div>
                                        <div class="form-group mr-2">
                                            <label for="search">Search:</label>
                                            <input type="text" class="form-control ml-2" id="search" placeholder="Full Name, Email, Phone, Address">
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Avatar</th>
                                        <th>Full Name</th>
                                        <th>Gender</th>
                                        <th>Email</th>
                                        <th>Address</th>
                                        <th>Mobile</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="customer" items="${customerList}">
                                        <tr>
                                            <td>${customer.customer_id}</td>
                                            <td><img src="${customer.avatar}" style="height:140px; width:100px "></td>
                                            <td>${customer.full_name}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${customer.gender == true}">
                                                        Male
                                                    </c:when>
                                                    <c:otherwise>
                                                        Female
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${customer.email}</td>
                                            <td>${customer.address}</td>
                                            <td>${customer.phone_number}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${customer.status == 1}">
                                                        <span class="status-label status-1">Active</span>
                                                    </c:when>
                                                    <c:when test="${customer.status == 2}">
                                                        <span class="status-label status-2">Ban</span>
                                                    </c:when>
                                                    <c:when test="${customer.status == 3}">
                                                        <span class="status-label status-3">Closed</span>
                                                    </c:when>
                                                    <c:when test="${customer.status == 4}">
                                                        <span class="status-label status-4">Suspended</span>
                                                    </c:when>
                                                    <c:when test="${customer.status == 5}">
                                                        <span class="status-label status-5">Locked</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-label status-0">Unknown</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <div class="clearfix">
                                <div class="hint-text">Showing <b>${param.page}</b> to <b>${noOfPages}</b> of <b>${totalRecords}</b> entries</div>
                                <ul class="pagination">
                                    <li class="page-item <c:if test="${param.page == 1}">disabled</c:if>"><a href="mktcustomerlist?page=${param.page - 1}&status=${status}" class="page-link">Previous</a></li>
                                    <c:forEach var="i" begin="1" end="${noOfPages}">
                                        <li class="page-item <c:if test="${param.page == i}">active</c:if>"><a href="mktcustomerlist?page=${i}&status=${status}" class="page-link">${i}</a></li>
                                    </c:forEach>
                                    <li class="page-item <c:if test="${param.page == noOfPages}">disabled</c:if>"><a href="mktcustomerlist?page=${param.page + 1}&status=${status}" class="page-link">Next</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- ============================================================== -->
                <!-- End code for your page -->
                <!-- ============================================================== -->
            </div>
            <!-- include footer -->
            <%@ include file="/COMP/manager-footer.jsp" %>
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
    </body>
</html>
