<%-- 
    Document   : mktvoucherlist
    Created on : 29 Jul 2024, 23:20:09
    Author     : dumspicy
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/vendor/bootstrap/css/bootstrap.min.css">

        <!-- Additional CSS Files -->
        <link href="assets/vendor/fonts/circular-std/style.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/libs/css/style.css">
        <link rel="stylesheet" href="assets/vendor/fonts/fontawesome/css/fontawesome-all.css">
        <link rel="stylesheet" href="assets/vendor/vector-map/jqvmap.css">
        <link rel="stylesheet" href="assets/vendor/jvectormap/jquery-jvectormap-2.0.2.css">
        <link rel="stylesheet" href="assets/vendor/fonts/flag-icon-css/flag-icon.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.7.1/css/buttons.dataTables.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

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

            .table {
                width: 100%;
                table-layout: fixed; /* Ensure fixed table layout */
                border-collapse: collapse; /* Optional: for better appearance */
            }

            .table th, .table td {
                white-space: normal; /* Allow text wrapping */
                text-align: left;
                vertical-align: middle;
                border: 1px solid #ddd; /* Optional: for better appearance */
                padding: 8px; /* Optional: for better appearance */
            }

            .sort-btn {
                display: inline-block;
                margin-left: 5px;
            }

            .centered-cell {
                text-align: center !important;
                align-content: center;

            }

            .thumbnail img {
                max-width: 100px;
                max-height: 100px;
            }

            .statusSwitch {
                display: block;
                margin: 0 auto;
            }
            .featureSwitch {
                display: block;
                margin: 0 auto;
            }
            .actions-cell {

            }

            .actions-cell button {
                margin-right: 5px;
                margin-bottom: 5px;
            }

            .fixed-length-header {
                width: 200px; /* Adjust the width as needed */
            }

            .fixed-length-cell {
                max-width: 200px; /* Match the header width */
                word-wrap: break-word; /* Deprecated, but included for compatibility */
                overflow-wrap: break-word; /* Allow text to wrap */
                word-break: break-word; /* Allow text to break within words */
                white-space: normal; /* Ensure text wraps */
            }
            #modalViewProduct a{
                color: #71748d;
            }
            #modalViewProduct a:hover {
                color: red;
            }
            td a {
                color: black; /* Default color */
                text-decoration: none; /* Remove underline if present */
            }

            td a:hover {
                color: red; /* Color on hover */
            }
        </style>
    </head>
    <body>
        <!-- Include marketing slider bar -->
        <%@ include file="COMP\marketing-sidebar.jsp" %>

        <div class="content">
            <div class="dashboard-wrapper" style="margin-top:80px;">
                <div class="row">
                    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                        <div class="page-header">
                            <div class="page-breadcrumb">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="dashboardmkt" class="breadcrumb-link">Dashboard</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Voucher Manager</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="container">
                    <h1 class="my-4">Voucher List</h1>
                    <div class="mb-4 d-flex justify-content-between">
                        <div>
                            <button class="btn btn-primary" id="addVoucherBtn">Add New Voucher</button>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-12">
                            <div class="d-flex justify-content-between mb-3">
                                <input type="text" class="form-control w-25" id="filterInput" placeholder="Search...">
                                <select class="form-control w-25" id="statusFilter">
                                    <option value="all">All</option>
                                    <option value="shown">Visible</option>
                                    <option value="hidden">Hidden</option>
                                </select>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th class="centered-cell" style="width: 100px;">ID
                                                    <button class="btn btn-link sort-btn" data-sort="voucherID" data-order="asc">
                                                        <i class="fas fa-sort"></i>
                                                    </button>
                                                </th>

                                                <th class="centered-cell">Name
                                                    <button class="btn btn-link sort-btn" data-sort="name" data-order="asc">
                                                        <i class="fas fa-sort"></i>
                                                    </button>
                                                </th>

                                                <th class="centered-cell">Percent
                                                    <button class="btn btn-link sort-btn" data-sort="percent" data-order="asc">
                                                        <i class="fas fa-sort"></i>
                                                    </button>
                                                </th>
                                                <th class="centered-cell">Requirment
                                                    <button class="btn btn-link sort-btn" data-sort="requirement" data-order="asc">
                                                        <i class="fas fa-sort"></i>
                                                    </button>
                                                </th>
                                                <th class="centered-cell" >Description
                                                    <button class="btn btn-link sort-btn" data-sort="description" data-order="asc">
                                                        <i class="fas fa-sort"></i>
                                                    </button>
                                                </th>
                                                <th class="centered-cell">Status
                                                    <button class="btn btn-link sort-btn" data-sort="status" data-order="asc">
                                                        <i class="fas fa-sort"></i>
                                                    </button>
                                                </th>
                                                <th class="centered-cell">Created date
                                                    <button class="btn btn-link sort-btn" data-sort="createdDate" data-order="asc">
                                                        <i class="fas fa-sort"></i>
                                                    </button>
                                                </th>
                                                <th class="centered-cell">Used date
                                                    <button class="btn btn-link sort-btn" data-sort="useDate" data-order="asc">
                                                        <i class="fas fa-sort"></i>
                                                    </button>
                                                </th>
                                                <th class="centered-cell">Expired date
                                                    <button class="btn btn-link sort-btn" data-sort="expireDate" data-order="asc">
                                                        <i class="fas fa-sort"></i>
                                                    </button>
                                                </th>
                                                <th >Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody id="voucherList">
                                        <p id="resultCount"></p>
                                        <c:forEach var="voucher" items="${allVoucher}">
                                            <tr>
                                                <td id="voucherID">${voucher.id}</td>
                                                <td id="name">${voucher.name}</td>
                                                <td id="percent">${voucher.percent}%</td>
                                                <td class="fixed-length-cell" id="requirement"><fmt:formatNumber value="${voucher.requirement}" pattern="###,###"/>đ</td>
                                                <td id="description">${voucher.description}</td>                                                
                                                <td>
                                                    <input type="checkbox" class="statusSwitch" <c:if test="${voucher.status}">checked</c:if> data-id="${voucher.id}">
                                                </td>
                                                <td id="createDate"><fmt:formatDate value="${voucher.createdDate}" pattern="MMMM dd, yyyy"/></td>
                                                <td id="useDate"><fmt:formatDate value="${voucher.usedDate}" pattern="MMMM dd, yyyy"/></td>
                                                <td id="expiredDate"><fmt:formatDate value="${voucher.expiredDate}" pattern="MMMM dd, yyyy"/></td>
                                                <td class="actions-cell">
                                                    <button class="btn btn-primary editBtn" id="EditVoucherBTN" data-id="${voucher.id}">Edit</button>
                                                    <button class="btn btn-secondary deleteBtn" data-id="${voucher.id}">Delete</button>
                                                </td>
                                                </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--  Add Voucher Modal -->
        <div class="modal fade" id="voucherAddModal" tabindex="-1" role="dialog" aria-labelledby="voucherAddModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="voucherAddModalLabel">Add a Voucher</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="voucherAddForm">
                            <input type="hidden" id="addvoucherID" name="voucherID">
                            <div class="form-group">
                                <label for="modalName">Name</label>
                                <input type="text" class="form-control" id="modalName" name="name" required>
                            </div>
                            <div class="form-group">
                                <label for="modalPercent">Percent</label>
                                <input type="text" class="form-control" id="modalPercent" name="percent" required>
                            </div>
                            <div class="form-group">
                                <label for="modalRequirement">Voucher requirement</label>
                                <input type="text" class="form-control" id="modalRequirement" name="requirement" required>
                            </div>
                            <div class="form-group">
                                <label for="modalDescription">Voucher Description </label>
                                <input type="text" class="form-control" id="modalDescription" name="desc" required>
                            </div>
                            <div class="form-group">
                                <label for="modalStatus">Status</label>
                                <select class="form-control" id="editStatus" name="status">
                                    <option value="true">Shown</option>
                                    <option value="false">Hidden</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="modalExpiredDate">Expired Date</label>
                                <input type="date" class="form-control" id="modalExpiredDate" name="expiredDate" placeholder="dd/mm/yyyy" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Add</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        <!--  Edit Voucher Modal -->
        <div class="modal fade" id="voucherEditModal" tabindex="-1" role="dialog" aria-labelledby="voucherEditModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="voucherEditModalLabel">Edit a Voucher</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="voucherEditForm">
                            <input type="hidden" id="editVoucherID" name="voucherID">
                            <div class="form-group">
                                <label for="editName">Name</label>
                                <input type="text" class="form-control" id="editName" name="name" required>
                            </div>
                            <div class="form-group">
                                <label for="editPercent">Percent</label>
                                <input type="text" class="form-control" id="editPercent" name="percent" required>
                            </div>
                            <div class="form-group">
                                <label for="editRequirement">Voucher requirement</label>
                                <input type="text" class="form-control" id="editRequirement" name="requirement" required>
                            </div>
                            <div class="form-group">
                                <label for="editDescription">Voucher Description </label>
                                <input type="text" class="form-control" id="editDescription" name="desc" required>
                            </div>
                            <div class="form-group">
                                <label for="editStatus">Status</label>
                                <select class="form-control" id="editStatus" name="status">
                                    <option value="true">Shown</option>
                                    <option value="false">Hidden</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="editExpiredDate">Expired Date</label>
                                <input type="date" class="form-control" id="editExpiredDate" name="expiredDate" placeholder="dd/mm/yyyy" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Edit</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        
        <!-- Include jquery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <!-- Bootstrap JS -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <!-- Additional JS Libraries -->
        <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/1.7.1/js/dataTables.buttons.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="assets/vendor/slimscroll/jquery.slimscroll.js"></script>
        <script src="assets/libs/js/main-js.js"></script>
        <script src="js/voucher-management.js"></script>
    </body>
</html>
