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
        <title>Marketing Dashboard</title>

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
        <link rel="stylesheet" type="text/css" href="css/productmana.css">
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
            .centered-cell {

                justify-content: center;
                align-items: center;
                vertical-align: middle;
            }

        </style>
    </head>

    <body>
        <!-- include header -->
        <%@ include file="COMP/manager-header.jsp" %>
        <div class="sidebar">
            <%@ include file="COMP/marketing-sidebar.jsp" %>
        </div>
        <div class="content">
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
                                            <li class="breadcrumb-item active" aria-current="page">Post Manager</li>
                                        </ol>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="container">
                        ${size}
                        ${selectedCategory}
                        <h1 class="my-4">Post List</h1>
                        <div class="mb-4 d-flex justify-content-between">
                            <div>
                                <button class="btn btn-primary" id="addPostBtn">Add New Post</button>
                                <button class="btn btn-secondary ml-2" id="addBrandBtn">Add New Brand</button>
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
                                                    <th>ID
                                                        <button class="btn btn-link sort-btn" data-sort="postID" data-order="asc">
                                                            <i class="fas fa-sort"></i>
                                                        </button>
                                                    </th>
                                                    <th class="centered-cell">Thumbnail</th>
                                                    <th>Title
                                                        <button class="btn btn-link sort-btn" data-sort="title" data-order="asc">
                                                            <i class="fas fa-sort"></i>
                                                        </button>
                                                    </th>
                                                    <th>
                                                        Category
                                                        <select id="sortOptions" onchange="applySort(this.value)">
                                                            <option value="all" selected>All</option>
                                                            <c:forEach items="${cate}" var="c">
                                                                <option value="${c.postCL}">${c.name}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </th>
                                                    <th>Author
                                                        <button class="btn btn-link sort-btn centered-cell" data-sort="author" data-order="asc">
                                                            <i class="fas fa-sort"></i>
                                                        </button>
                                                    </th>
                                                    <th>Status
                                                        <button class="btn btn-link sort-btn centered-cell" data-sort="status" data-order="asc">
                                                            <i class="fas fa-sort"></i>
                                                        </button>
                                                    </th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody id="postList">
                                            <p id="resultCount"></p>
                                            <c:forEach var="post" items="${list}">
                                                <tr>
                                                    <td>${post.postID}</td>
                                                    <td class="thumbnail"><img src="${post.thumbnailLink}" alt="Thumbnail"></td>
                                                    <td>${post.title}</td>
                                                    <td>${post.categories}</td>
                                                    <td>${post.staff}</td>
                                                    <td>
                                                        <input type="checkbox" class="statusSwitch" <c:if test="${post.status}">checked</c:if> data-id="${post.postID}">
                                                        </td>
                                                        <td>
                                                            <button class="btn btn-primary editBtn" data-id="${post.postID}">Edit</button>
                                                        <button class="btn btn-secondary viewBtn" data-id="${post.postID}">View</button>

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
        </div>
        <!-- Add Post Modal -->


        <!-- Add Category Modal -->
        <div class="modal fade" id="addBrandModal" tabindex="-1" role="dialog" aria-labelledby="addBrandModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addBrandModalLabel">Add New Brand</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="addBrandForm">
                            <div class="form-group">
                                <label for="brandName">Brand Name</label>
                                <input type="text" class="form-control" id="brandName" name="brandName" required>
                                <div class="error" id="brandNameError" style="display:none;">Please enter a brand name.</div>
                            </div>
                            <div class="form-group">
                                <label for="brandDescription">Brand Description</label>
                                <textarea class="form-control" id="brandDescription" name="brandDescription" required></textarea>
                                <div class="error" id="brandDescriptionError" style="display:none;">Please enter a brand description.</div>
                            </div>
                            <button type="submit" class="btn btn-primary">Submit</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- View Post Modal -->
        <div class="modal fade" id="postDetailModal" tabindex="-1" role="dialog" aria-labelledby="postDetailModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="postDetailModalLabel">Post Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p><strong>Post ID:</strong> <span id="modalPostID"></span></p>
                        <p><strong>Title: </strong> <span id="modalTitle"></span></p>
                        <p><strong>Author:</strong> <span id="modalAuthor"></span></p>
                        <p><strong>Categories</strong> <span id="modalCategories"></span></p>
                        <p><strong>Updated Date:</strong> <span id="modalUpdatedDate"></span></p>
                        <p><strong>Status:</strong> <span id="modalStatus"></span></p>
                        <p><strong>Content:</strong> <span id="modalContent"></span></p>
                        <div><strong>Images:</strong> <div id="modalImageLinks"></div></div>
                    </div>
                </div>
            </div>
        </div>


        <div class="modal fade" id="postEditModal" tabindex="-1" role="dialog" aria-labelledby="postEditModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="postEditModalLabel">Edit Post</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="editPostForm">
                            <input type="hidden" id="editPostID" name="postID">
                            <div class="form-group">
                                <label for="editTitle">Title:</label>
                                <input type="text" class="form-control" id="editTitle" name="title" required>
                            </div>
                            <div class="form-group">
                                <label for="editAuthor">Author:</label>
                                <input type="text" class="form-control" id="editAuthor" name="author" required>
                            </div>
                            <div class="form-group">
                                <label for="editCategories">Categories:</label>
                                <input type="text" class="form-control" id="editCategories" name="categories" required>
                            </div>
                            <div class="form-group">
                                <label for="editContent">Content:</label>
                                <textarea class="form-control" id="editContent" name="content" rows="4" required></textarea>
                            </div>
                            <div class="form-group">
                                <label for="editStatus">Status:</label>
                                <select class="form-control" id="editStatus" name="status">
                                    <option value="true">Shown</option>
                                    <option value="false">Hidden</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="editUpdatedDate">Updated Date:</label>
                                <input type="date" class="form-control" id="editUpdatedDate" name="updatedDate" required>
                            </div>
                            <div class="form-group">
                                <label for="editThumbnailLink">Thumbnail Link:</label>
                                <input type="url" class="form-control" id="editThumbnailLink" name="thumbnailLink" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>





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
        <!--        <script src="js/post-management.js"></script>-->
        <script>
                                                            $('#postList').on('click', '.viewBtn', function () {
                                                                var postID = $(this).data('id');
                                                                console.log("View button clicked, postID:", postID);

                                                                // AJAX request to fetch post details
                                                                $.ajax({
                                                                    url: 'MKTPostDetail',
                                                                    method: 'GET',
                                                                    data: {postID: postID},
                                                                    success: function (post) {
                                                                        $('#modalPostID').text(post.postID);
                                                                        $('#modalTitle').text(post.title);
                                                                        $('#modalAuthor').text(post.staff);
                                                                        $('#modalContent').text(post.content);
                                                                        $('#modalStatus').text(post.status ? 'Shown' : 'Hidden');
                                                                        $('#modalUpdatedDate').text(post.updatedDate);
                                                                        var link = $('#modalImageLinks');
                                                                        link.append('<img src="' + post.thumbnailLink + '" alt="Post Image" class="img-thumbnail" style="width: 100px; margin: 5px;">');
                                                                        var categoriesContainer = $('#modalCategories');
                                                                        categoriesContainer.empty(); // Clear previous images
                                                                        if (post.categories) {
                                                                            post.categories.forEach(function (cate) {
                                                                                categoriesContainer.append(cate.name);
                                                                            });
                                                                        }
                                                                        console.log(categoriesContainer);
                                                                        // Show the modal
                                                                        $('#postDetailModal').modal('show');
                                                                    },
                                                                    error: function (xhr, status, error) {
                                                                        alert('Error fetching post details');
                                                                    }
                                                                });
                                                            });
                                                            $('#editPostForm').on('submit', function (e) {
                                                                e.preventDefault();
                                                                var formData = $(this).serialize();
                                                                $.ajax({
                                                                    url: 'MKTEditPost',
                                                                    method: 'POST',
                                                                    data: formData,
                                                                    success: function (response) {
                                                                        alert('Post updated successfully!');
                                                                        $('#postEditModal').modal('hide');
                                                                        // Optionally, refresh the post list or update the UI
                                                                    },
                                                                    error: function (xhr, status, error) {
                                                                        alert('Error updating post details');
                                                                    }
                                                                });
                                                            });

                                                            $(document).ready(function () {
                                                                $('.sort-btn').on('click', function () {
                                                                    var sortField = $(this).data('sort');
                                                                    var sortOrder = $(this).data('order');
                                                                    var newOrder = sortOrder === 'asc' ? 'desc' : 'asc';
                                                                    $(this).data('order', newOrder);

                                                                    sortTable(sortField, newOrder);
                                                                });
                                                                function getColumnIndex(field) {
                                                                    switch (field) {
                                                                        case 'postID':
                                                                            return 0;
                                                                        case 'thumbnail':
                                                                            return 1;
                                                                        case 'title':
                                                                            return 2;
                                                                        case 'category':
                                                                            return 3;
                                                                        case 'author':
                                                                            return 4;
                                                                        case 'status':
                                                                            return 5;
                                                                        default:
                                                                            return 0;
                                                                    }
                                                                }
                                                                function sortTable(field, order) {
                                                                    var rows = $('#postList tr').get();
                                                                    rows.sort(function (a, b) {
                                                                        var A, B;
                                                                        if (field === 'status') {
                                                                            A = $(a).find('input.statusSwitch').is(':checked') ? 'shown' : 'hidden';
                                                                            B = $(b).find('input.statusSwitch').is(':checked') ? 'shown' : 'hidden';
                                                                        } else {
                                                                            A = $(a).children('td').eq(getColumnIndex(field)).text().toUpperCase();
                                                                            B = $(b).children('td').eq(getColumnIndex(field)).text().toUpperCase();
                                                                        }

                                                                        if (field === 'postID') {
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
                                                                        $('#postList').append(row);
                                                                    });
                                                                }
                                                                function filterResults() {
                                                                    var searchValue = $('#filterInput').val().toLowerCase();
                                                                    var statusValue = $('#statusFilter').val();
                                                                    var visibleRows = 0;

                                                                    $('#postList tr').filter(function () {
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
                                                                    var postID = $(this).data('id');
                                                                    var status = $(this).is(':checked') ? 'true' : 'false'; // Send status as "true" or "false"
                                                                    $.ajax({
                                                                        url: 'updatePostServlet',
                                                                        method: 'POST',
                                                                        data: {postID: postID, status: status},
                                                                        success: function (response) {
                                                                            filterResults(); // Re-filter results after status change
                                                                            console.log(status);
                                                                        },
                                                                        error: function () {
                                                                            alert('Error updating status');
                                                                        }
                                                                    });
                                                                });

                                                            });
                                                            function loadResult(url) {
                                                                console.log('Loading orders via AJAX:', url);
                                                                $.ajax({
                                                                    url: url,
                                                                    method: 'GET',
                                                                    dataType: 'html',
                                                                    headers: {
                                                                        'X-Requested-With': 'XMLHttpRequest'
                                                                    },
                                                                    success: function (response) {
                                                                        var newRows = $(response).find('#postList tr');
                                                                        $('#postList').html(newRows);

                                                                        // Apply filtering logic
                                                                        var searchValue = $('#filterInput').val().toLowerCase();
                                                                        var statusValue = $('#statusFilter').val();
                                                                        var visibleRows = 0;

                                                                        $('#postList tr').filter(function () {
                                                                            var textMatch = $(this).text().toLowerCase().indexOf(searchValue) > -1;
                                                                            var statusMatch = (statusValue === 'all') ||
                                                                                    (statusValue === 'shown' && $(this).find('.statusSwitch').is(':checked')) ||
                                                                                    (statusValue === 'hidden' && !$(this).find('.statusSwitch').is(':checked'));
                                                                            var shouldDisplay = textMatch && statusMatch;
                                                                            $(this).toggle(shouldDisplay);

                                                                            if (shouldDisplay) {
                                                                                visibleRows++;
                                                                            }
                                                                        });

                                                                        $('#resultCount').text('Number of results: ' + visibleRows);
                                                                        console.log('Result loaded and filtered successfully. Number of results:', visibleRows);
                                                                    },
                                                                    error: function (xhr, status, error) {
                                                                        console.error('Error loading orders: ', status, error);
                                                                    }
                                                                });
                                                            }

                                                            function applySort(sortBy) {
                                                                var searchParams = new URLSearchParams(window.location.search);
                                                                searchParams.set('category', sortBy);
                                                                var url = 'mktpostlist?' + searchParams.toString();
                                                                loadResult(url); // Call loadOrders function with the constructed URL
                                                            }
        </script>
    </body>
</html>
