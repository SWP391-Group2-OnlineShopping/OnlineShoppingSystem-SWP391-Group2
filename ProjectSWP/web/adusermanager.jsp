<html lang="en">
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page import="java.util.List" %>
    <%@ page import="model.*" %>
    <%@ page import="model.Products" %>
    <%@ page contentType="text/html" pageEncoding="UTF-8"%>
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/vendor/bootstrap/css/bootstrap.min.css">
        <link href="assets/vendor/fonts/circular-std/style.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/libs/css/style.css">
        <link rel="stylesheet" href="assets/vendor/fonts/fontawesome/css/fontawesome-all.css">
        <link rel="stylesheet" href="assets/vendor/vector-map/jqvmap.css">
        <link rel="stylesheet" href="assets/vendor/jvectormap/jquery-jvectormap-2.0.2.css">
        <link rel="stylesheet" href="assets/vendor/fonts/flag-icon-css/flag-icon.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.7.1/css/buttons.dataTables.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css">
        <title>Admin User</title>
        <link rel="stylesheet" type="text/css" href="css/productmana.css">

        <!-- jQuery -->

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/1.7.1/js/dataTables.buttons.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
        <script src="assets/vendor/slimscroll/jquery.slimscroll.js"></script>
        <script src="assets/libs/js/main-js.js"></script>
        <style>
            .status-active {
                color: green;
                font-weight: bold;
            }

            .status-ban {
                color: red;
                font-weight: bold;
            }

            .status-closed {
                color: gray;
                font-weight: bold;
            }

            .status-suspended {
                color: orange;
                font-weight: bold;
            }

            .status-locked {
                color: darkred;
                font-weight: bold;
            }

        </style>
    </head>

    <body>
        <!-- include header -->
        <%@ include file="COMP/manager-header.jsp" %>
        <div class="sidebar">
            <%@ include file="COMP/adm-sidebar.jsp" %>
        </div>
        <div class="content">
            <div class="dashboard-wrapper">
                <div class="container-fluid dashboard-content">
                    <div class="row">
                        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                            <div class="page-header">
                                <h3 class="mb-2">Admin Dashboard</h3>
                                <div class="page-breadcrumb">
                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb">
                                            <li class="breadcrumb-item"><a href="adm-dashboard.jsp" class="breadcrumb-link">Dashboard</a></li>
                                            <li class="breadcrumb-item active" aria-current="page">Staff Manager</li>
                                        </ol>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="container">
                        <h1 class="my-4">Staff List</h1>
                        <div class="mb-4 d-flex justify-content-between">
                            <div>
                                <button class="btn btn-primary" id="addStaffBtn">Add New Staff</button>
                            </div>
                        </div>
                        <c:choose>
                            <c:when test="${not empty staffList}">
                                <table id="staffTable" class="display table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Full Name</th>
                                            <th>Gender</th>
                                            <th>Email</th>
                                            <th>Mobile</th>
                                            <th>Role</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="staff" items="${staffList}">
                                            <tr>
                                                <td>${staff.staffID}</td>
                                                <td>${staff.fullName}</td>
                                                <td>${staff.gender ? 'Male' : 'Female'}</td>
                                                <td>${staff.email}</td>
                                                <td>${staff.mobile}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${staff.role == 1}">Admin</c:when>
                                                        <c:when test="${staff.role == 2}">Sale Manager</c:when>
                                                        <c:when test="${staff.role == 3}">Sale</c:when>
                                                        <c:when test="${staff.role == 4}">Marketer</c:when>
                                                    </c:choose>
                                                </td>
                                                <td>${staff.statusDescription}</td>
                                                <td>
                                                    <button class="btn btn-primary editBtn" data-id="${staff.staffID}">Edit</button>
                                                    <button class="btn btn-secondary viewBtn" data-id="${staff.staffID}">View</button>
                                                </td>
                                            </tr>

                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <p>Staff list is empty</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
        <!-- Add Staff Modal -->
        <div class="modal fade" id="addStaffModal" tabindex="-1" role="dialog" aria-labelledby="addStaffModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addStaffModalLabel">Add New Staff</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="addStaffForm" enctype="multipart/form-data">
                            <div class="form-group">
                                <label for="fullName">Full Name</label>
                                <input type="text" class="form-control" id="fullName" name="fullName" required>
                                <div class="error" id="fullNameError" style="display:none;">Please enter a full name.</div>
                            </div>
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                                <div class="error" id="emailError" style="display:none;">Please enter a valid email.</div>
                            </div>
                            <div class="form-group">
                                <label for="mobile">Mobile</label>
                                <input type="text" class="form-control" id="mobile" name="mobile" required>
                                <div class="error" id="mobileError" style="display:none;">Please enter a valid mobile number.</div>
                            </div>
                            <div class="form-group">
                                <label for="role">Role</label>
                                <select class="form-control" id="role" name="role" required>
                                    <option value="1">Admin</option>
                                    <option value="2">Sale Manager</option>
                                    <option value="3">Sale</option>
                                    <option value="4">Marketer</option>
                                </select>
                                <div class="error" id="roleError" style="display:none;">Please select a role.</div>
                            </div>
                            <div class="form-group">
                                <label for="gender">Gender</label>
                                <select class="form-control" id="gender" name="gender" required>
                                    <option value="true">Male</option>
                                    <option value="false">Female</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="address">Address</label>
                                <input type="text" class="form-control" id="address" name="address" required>
                            </div>
                            <div class="form-group">
                                <label for="avatar">Avatar</label>
                                <input type="file" class="form-control-file" id="avatar" name="avatar">
                            </div>
                            <button type="submit" class="btn btn-primary">Add Staff</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- Edit Staff Modal -->
        <div class="modal fade" id="editStaffModal" tabindex="-1" role="dialog" aria-labelledby="editStaffModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editStaffModalLabel">Edit Staff</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="editStaffForm" enctype="multipart/form-data">
                            <input type="hidden" id="editStaffId" name="staffId">
                            <div class="form-group">
                                <label for="editFullName">Full Name</label>
                                <input type="text" class="form-control" id="editFullName" name="fullName" required>
                            </div>
                            <div class="form-group">
                                <label for="editEmail">Email</label>
                                <input type="email" class="form-control" id="editEmail" name="email" required>
                            </div>
                            <div class="form-group">
                                <label for="editMobile">Mobile</label>
                                <input type="text" class="form-control" id="editMobile" name="mobile" required>
                            </div>
                            <div class="form-group">
                                <label for="editRole">Role</label>
                                <select class="form-control" id="editRole" name="role" required>
                                    <option value="1">Admin</option>
                                    <option value="2">Sale Manager</option>
                                    <option value="3">Sale</option>
                                    <option value="4">Marketer</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="editGender">Gender</label>
                                <select class="form-control" id="editGender" name="gender" required>
                                    <option value="true">Male</option>
                                    <option value="false">Female</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="editAddress">Address</label>
                                <input type="text" class="form-control" id="editAddress" name="address" required>
                            </div>
                            <div class="form-group">
                                <label for="editAvatar">Avatar</label>
                                <input type="file" class="form-control-file" id="editAvatar" name="avatar">
                            </div>
                            <button type="submit" class="btn btn-primary">Update Staff</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- View Staff Modal -->
        <div class="modal fade" id="viewStaffModal" tabindex="-1" role="dialog" aria-labelledby="viewStaffModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="viewStaffModalLabel">View Staff Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <img id="viewAvatar" src="" alt="Avatar" class="img-fluid rounded-circle mb-3">
                        <p><strong>ID:</strong> <span id="viewStaffId"></span></p>
                        <p><strong>Full Name:</strong> <span id="viewFullName"></span></p>
                        <p><strong>Gender:</strong> <span id="viewGender"></span></p>
                        <p><strong>Email:</strong> <span id="viewEmail"></span></p>
                        <p><strong>Mobile:</strong> <span id="viewMobile"></span></p>
                        <p><strong>Role:</strong> <span id="viewRole"></span></p>
                        <p><strong>Address:</strong> <span id="viewAddress"></span></p>
                        <p><strong>Status:</strong> <span id="viewStatus"></span></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="assets/vendor/slimscroll/jquery.slimscroll.js"></script>
        <script src="assets/libs/js/main-js.js"></script>
        <script src="js/admin-user.js"></script>
    </body>
</html>