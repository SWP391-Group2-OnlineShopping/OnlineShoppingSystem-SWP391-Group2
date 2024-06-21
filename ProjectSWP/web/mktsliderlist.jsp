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
            h4 {
                display: flex;
                align-items: center;
                justify-content: right;
            }
            input, select {
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
        </style>
    </head>
    <body>
        <!-- include header -->
        <c:set var="page" value="sliderlist" />
        <%@ include file="COMP/manager-header.jsp" %>
        <!-- include sidebar -->
        <%@ include file="COMP/marketing-sidebar.jsp" %>
        <!-- wrapper  -->
        <div class="dashboard-wrapper">
            <div class="container-fluid dashboard-content">
                <!-- Page Header -->
                <div class="row">
                    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                        <div class="page-header">
                            <h3 class="mb-2 mt-5">Slider List</h3>
                            <div class="page-breadcrumb">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="dashboardmkt" class="breadcrumb-link">Dashboard</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Marketing Slider List</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Page Header End -->

                <!-- Banner List Section -->
                <div class="row">
                    <div class="col-12">
                        <div class="d-flex justify-content-between mb-3">
                            <input type="text" class="form-control w-25" id="filterInput" placeholder="Search...">
                            <select class="form-control w-25" id="statusFilter">
                                <option value="all">All</option>
                                <option value="shown">Visible</option>
                                <option value="hidden">Hidden</option>
                            </select>
                            <button class="btn btn-primary" id="addBannerBtn">Add Slider</button>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Status</th>
                                            <th>Image</th>
                                            <th>BackLink</th>
                                            <th>Title</th>
                                            <th>Staff</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody id="bannerList">
                                    <p id="resultCount"></p>

                                    <c:forEach var="slider" items="${sliders}">
                                        <tr>
                                            <td>${slider.sliderID}</td>
                                            <td>
                                                <input type="checkbox" class="statusSwitch" <c:if test="${slider.status}">checked</c:if> data-id="${slider.sliderID}">
                                                </td>
                                                <td><img src="${slider.imageLink}" style="height:30px;" alt="${slider.imageLink}"></td>
                                            <td>${slider.backLink}</td>
                                            <td>${slider.title}</td>
                                            <td>${slider.staff}</td>
                                            <td>
                                                <button class="btn btn-primary editBtn" data-id="${slider.sliderID}">Edit</button>
                                                <button class="btn btn-danger deleteBtn" data-id="${slider.sliderID}">Delete</button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Banner List Section End -->

                <!-- Add Banner Form -->
                <div class="modal fade" id="addBannerModal" tabindex="-1" role="dialog" aria-labelledby="addBannerModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addBannerModalLabel">Add New Slider</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form id="addBannerForm">
                                    <div class="form-group">
                                        <label for="status">Status</label>
                                        <input type="checkbox" class="form-control" id="status" name="status">
                                    </div>
                                    <div class="form-group">
                                        <label for="imageLink">Image Link</label>
                                        <input type="text" class="form-control" id="imageLink" name="imageLink" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="backLink">BackLink</label>
                                        <input type="text" class="form-control" id="backLink" name="backLink" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="title">Title</label>
                                        <input type="text" class="form-control" id="title" name="title" required>
                                    </div>
                                    <%
                                        Staffs staff = (Staffs) session.getAttribute("staff");
                                        int staffID = (staff != null) ? staff.getStaffID() : 0;
                                        // Default to 0 or handle as needed if staff is null
                                        request.setAttribute("staffID", staffID);
                                    %>
                                    <input type="hidden" class="form-control" id="staffID" name="staffID" value="${staffID}">
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Add Banner Form End -->

                <!-- Edit Banner Form -->
                <div class="modal fade" id="editBannerModal" tabindex="-1" role="dialog" aria-labelledby="editBannerModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editBannerModalLabel">Edit Slider</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form id="editBannerForm">
                                    <div class="form-group">
                                        <label for="editStatus">Status</label>
                                        <input type="checkbox" class="form-control" id="editStatus" name="status">
                                    </div>
                                    <div class="form-group">
                                        <label for="editImageLink">Image Link</label>
                                        <input type="text" class="form-control" id="editImageLink" name="imageLink" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="editBackLink">BackLink</label>
                                        <input type="text" class="form-control" id="editBackLink" name="backLink" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="editTitle">Title</label>
                                        <input type="text" class="form-control" id="editTitle" name="title" required>
                                    </div>
                                    <input type="hidden" class="form-control" id="editSliderID" name="sliderID">
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Edit Banner Form End -->

            </div>
            <!-- include footer -->
            <%@ include file="COMP/manager-footer.jsp" %>
        </div>
        <!-- Optional JavaScript -->
        <!-- jquery 3.3.1 js-->
        <script src="assets/vendor/jquery/jquery-3.3.1.min.js"></script>
        <!-- bootstrap bundle js-->
        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.js"></script>
        <!-- slimscroll js-->
        <script src="assets/vendor/slimscroll/jquery.slimscroll.js"></script>
        <!-- main js-->
        <script src="assets/libs/js/main-js.js"></script>

        <!-- AJAX for Buttons -->
        <script>
            $(document).ready(function () {
                function filterResults() {
                    var searchValue = $('#filterInput').val().toLowerCase();
                    var statusValue = $('#statusFilter').val();
                    var visibleRows = 0;

                    $('#bannerList tr').filter(function () {
                        var textMatch = $(this).text().toLowerCase().indexOf(searchValue) > -1;
                        var statusMatch = (statusValue === 'all') ||
                                (statusValue === 'shown' && $(this).find('.statusSwitch').is(':checked')) ||
                                (statusValue === 'hidden' && !$(this).find('.statusSwitch').is(':checked'));
                        var shouldDisplay = textMatch && statusMatch;
                        $(this).toggle(shouldDisplay);

                        if (shouldDisplay)
                            visibleRows++;
                    });

                    $('#resultCount').text('Number of results: ' + visibleRows);
                }

                // Initial count
                filterResults();

                // Filter functionality
                $('#filterInput').on('keyup', filterResults);
                $('#statusFilter').on('change', filterResults);

                // Add Banner button click
                $('#addBannerBtn').click(function () {
                    $('#addBannerModal').modal('show');
                });

                // Status switch button click
                $('.statusSwitch').change(function () {
                    var sliderID = $(this).data('id');
                    var status = $(this).is(':checked') ? 'true' : 'false'; // Send status as "true" or "false"
                    $.ajax({
                        url: 'updateSliderStatus',
                        method: 'POST',
                        data: {sliderID: sliderID, status: status},
                        success: function (response) {
                            filterResults(); // Re-filter results after status change
                        },
                        error: function () {
                            alert('Error updating status');
                        }
                    });
                });

                // Delete button click
                $('.deleteBtn').click(function () {
                    if (confirm('Are you sure you want to delete this slider?')) {
                        var sliderID = $(this).data('id');
                        $.ajax({
                            url: 'deleteBanner',
                            method: 'POST',
                            data: {sliderID: sliderID},
                            success: function (response) {
                                alert('Slider deleted successfully');
                                location.reload();
                            },
                            error: function () {
                                alert('Error deleting banner');
                            }
                        });
                    }
                });

                // Edit button click
                $('.editBtn').click(function () {
                    var sliderID = $(this).data('id');
                    $.ajax({
                        url: 'getSliderDetails',
                        method: 'GET',
                        data: {sliderID: sliderID},
                        success: function (slider) {
                            $('#editSliderID').val(slider.sliderID);
                            $('#editStatus').prop('checked', slider.status);
                            $('#editImageLink').val(slider.imageLink);
                            $('#editBackLink').val(slider.backLink);
                            $('#editTitle').val(slider.title);
                            $('#editBannerModal').modal('show');
                        },
                        error: function () {
                            alert('Error fetching slider details');
                        }
                    });
                });

                // Add Banner form submission
                $('#addBannerForm').submit(function (e) {
                    e.preventDefault();
                    var formData = $(this).serialize();
                    $.ajax({
                        url: 'addBanner',
                        method: 'POST',
                        data: formData,
                        success: function (response) {
                            alert('Banner added successfully');
                            $('#addBannerModal').modal('hide');
                            location.reload();
                        },
                        error: function () {
                            alert('Error adding banner');
                        }
                    });
                });

                // Edit Banner form submission
                $('#editBannerForm').submit(function (e) {
                    e.preventDefault();
                    var formData = $(this).serialize();
                    $.ajax({
                        url: 'editBanner',
                        method: 'POST',
                        data: formData,
                        success: function (response) {
                            alert('Banner edited successfully');
                            $('#editBannerModal').modal('hide');
                            location.reload();
                        },
                        error: function () {
                            alert('Error editing banner');
                        }
                    });
                });
            });
        </script>
    </body>
</html>