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
        <title>Marketing Feedback Dashboard</title>
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
        <%@ include file="COMP/manager-header.jsp" %>
        <!-- include sidebar -->
        <c:set var="page" value="feedbackmanager" />
        <%@ include file="COMP/marketing-sidebar.jsp" %>
        <!-- wrapper  -->
        <div class="dashboard-wrapper">
            <div class="container-fluid dashboard-content">
                <!-- Page Header -->
                <div class="row">
                    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                        <div class="page-header">
                            <h3 class="mb-2">Marketing Feedback Dashboard</h3>
                            <div class="page-breadcrumb">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="dashboardmkt" class="breadcrumb-link">Dashboard</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Marketing Feedback Manager</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Page Header End -->

                <!-- Feedback List Section -->
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
                                            <th>ID
                                                <button class="btn btn-link sort-btn" data-sort="feedbackID" data-order="asc">
                                                    <i class="fas fa-sort"></i>
                                                </button>
                                            </th>
                                            <th>Status
                                                <button class="btn btn-link sort-btn" data-sort="status" data-order="asc">
                                                    <i class="fas fa-sort"></i>
                                                </button>
                                            </th>
                                            <th>Customer Full Name
                                                <button class="btn btn-link sort-btn" data-sort="customerFullname" data-order="asc">
                                                    <i class="fas fa-sort"></i>
                                                </button>
                                            </th>
                                            <th>Product Title
                                                <button class="btn btn-link sort-btn" data-sort="productTitle" data-order="asc">
                                                    <i class="fas fa-sort"></i>
                                                </button>
                                            </th>
                                            <th>Rated Star
                                                <button class="btn btn-link sort-btn" data-sort="ratedStar" data-order="asc">
                                                    <i class="fas fa-sort"></i>
                                                </button>
                                            </th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody id="feedbackList">
                                    <p id="resultCount"></p>
                                    <c:forEach var="feedback" items="${feedbacks}">
                                        <tr>
                                            <td>${feedback.feedbackID}</td>
                                            <td>
                                                <input type="checkbox" class="statusSwitch" <c:if test="${feedback.status}">checked</c:if> data-id="${feedback.feedbackID}">
                                                </td>
                                                <td>${feedback.customerFullname}</td>
                                            <td>${feedback.productTitle}</td>
                                            <td>${feedback.ratedStar}</td>
                                            <td>
                                                <button class="btn btn-primary viewBtn" data-id="${feedback.feedbackID}">View</button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Feedback List Section End -->

                <!-- Feedback Detail Modal -->
                <div class="modal fade" id="feedbackDetailModal" tabindex="-1" role="dialog" aria-labelledby="feedbackDetailModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="feedbackDetailModalLabel">Feedback Details</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <p><strong>Feedback ID:</strong> <span id="modalFeedbackID"></span></p>
                                <p><strong>Product Title:</strong> <span id="modalProductTitle"></span></p>
                                <p><strong>Customer Fullname:</strong> <span id="modalCustomerFullname"></span></p>
                                <p><strong>Rated Star:</strong> <span id="modalRatedStar"></span></p>
                                <p><strong>Status:</strong> <span id="modalStatus"></span></p>
                                <p><strong>Content:</strong> <span id="modalContent"></span></p>
                                <div><strong>Images:</strong> <div id="modalImageLinks"></div></div>
                            </div>
                        </div>
                    </div>
                </div>

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
            // Event delegation for view button click event
            $('#feedbackList').on('click', '.viewBtn', function () {
                var feedbackID = $(this).data('id');
                console.log("View button clicked, feedbackID:", feedbackID);

                // AJAX request to fetch feedback details
                $.ajax({
                    url: 'MKTFeedbackDetails',
                    method: 'GET',
                    data: {feedbackID: feedbackID},
                    success: function (feedback) {
   
                            $('#modalFeedbackID').text(feedback.feedbackID);
                            $('#modalProductTitle').text(feedback.productTitle);
                            $('#modalCustomerFullname').text(feedback.customerFullname);
                            $('#modalRatedStar').text(feedback.ratedStar);
                            $('#modalStatus').text(feedback.status ? 'Shown' : 'Hidden');
                            $('#modalContent').text(feedback.content);
                            // Handle image links
                            var imageLinksContainer = $('#modalImageLinks');
                            imageLinksContainer.empty(); // Clear previous images
                            if (feedback.imageLinks) {
                                feedback.imageLinks.forEach(function (link) {
                                    imageLinksContainer.append('<img src="' + link + '" alt="Feedback Image" class="img-thumbnail" style="width: 100px; margin: 5px;">');
                                });
                            }

                            // Show the modal
                            $('#feedbackDetailModal').modal('show');
                    },
                    error: function (xhr, status, error) {
                        alert('Error fetching feedback details');
                    }
                });
            });

            // Existing sortable and filter functionality
            $('.sort-btn').on('click', function () {
                var sortField = $(this).data('sort');
                var sortOrder = $(this).data('order');
                var newOrder = sortOrder === 'asc' ? 'desc' : 'asc';
                $(this).data('order', newOrder);

                sortTable(sortField, newOrder);
            });

            function sortTable(field, order) {
                var rows = $('#feedbackList tr').get();
                rows.sort(function (a, b) {
                    var A, B;
                    if (field === 'status') {
                        A = $(a).find('input.statusSwitch').is(':checked') ? 'shown' : 'hidden';
                        B = $(b).find('input.statusSwitch').is(':checked') ? 'shown' : 'hidden';
                    } else {
                        A = $(a).children('td').eq(getColumnIndex(field)).text().toUpperCase();
                        B = $(b).children('td').eq(getColumnIndex(field)).text().toUpperCase();
                    }

                    if (field === 'feedbackID') {
                        A = parseInt(A, 10);
                        B = parseInt(B, 10);
                    }

                    if (order === 'asc') {
                        return (A < B) ? -1 : (A > B) ? 1 : 0;
                    } else {
                        return (A > B) ? -1 : (A < B) ? 1 : 0;
                    }
                });

                $.each(rows, function (index, row) {
                    $('#feedbackList').append(row);
                });
            }

            function getColumnIndex(field) {
                switch (field) {
                    case 'feedbackID':
                        return 0;
                    case 'status':
                        return 1;
                    case 'customerFullname':
                        return 2;
                    case 'productTitle':
                        return 3;
                    case 'ratedStar':
                        return 4;
                    default:
                        return 0;
                }
            }

            function filterResults() {
                var searchValue = $('#filterInput').val().toLowerCase();
                var statusValue = $('#statusFilter').val();
                var visibleRows = 0;

                $('#feedbackList tr').filter(function () {
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

            // Status switch button click
            $('.statusSwitch').change(function () {
                var feedbackID = $(this).data('id');
                var status = $(this).is(':checked') ? 'true' : 'false'; // Send status as "true" or "false"
                $.ajax({
                    url: 'updateFeedbackStatus',
                    method: 'POST',
                    data: {feedbackID: feedbackID, status: status},
                    success: function (response) {
                        filterResults(); // Re-filter results after status change
                    },
                    error: function () {
                        alert('Error updating status');
                    }
                });
            });

        </script>
    </body>
</html>