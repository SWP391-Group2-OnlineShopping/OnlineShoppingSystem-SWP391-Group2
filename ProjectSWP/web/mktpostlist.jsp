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
                                <button class="btn btn-secondary ml-2" id="addCategoryBtn">Add New Category</button>
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
                                                    <td class="thumbnail"><img src="${post.thumbnailLink}" alt="Image"></td>
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

        <!-- Modal Part -->         



        <!--  Add Post Modal -->
        <div class="modal fade" id="postAddModal" tabindex="-1" role="dialog" aria-labelledby="postAddModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="postAddModalLabel">Add a Post</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="postAddForm">
                            <input type="hidden" id="addPostID" name="postID">
                            <div class="form-group">
                                <label for="modalTitle">Title</label>
                                <input type="text" class="form-control" id="modalTitle" name="title" required>
                            </div>
                            <div class="form-group">
                                <label for="modalAuthor">Author</label>
                                <div id="modalAuthor" class="form-control-plaintext">${sessionScope.staff.username}</div> <!-- Non-editable field -->
                            </div>
                            <div class="form-group">
                                <label for="modalCategories">Categories</label>
                                <select class="form-control" id="modalCategories" name="categories" required>
                                    <c:forEach items="${cate}" var="c">
                                        <option value="${c.postCL}">${c.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="modalStatus">Status</label>
                                <select class="form-control" id="editStatus" name="status">
                                    <option value="true">Shown</option>
                                    <option value="false">Hidden</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="modalContent">Content</label>
                                <textarea class="form-control" id="modalContent" name="content" rows="4" required></textarea>
                            </div>
                            <div class="form-group">
                                <label for="modalImageLinks">Images</label>
                                <input type="text" class="form-control" id="modalImageLinks" name="imageLinks" placeholder="Enter image URL (only .png, .jpeg, .jpg, .webg are allowed)">
                            </div>
                            <button type="submit" class="btn btn-primary">Add</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>



        <!-- Add Category Modal -->
        <div class="modal fade" id="categoryAddModal" tabindex="-1" role="dialog" aria-labelledby="categoryAddModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="categoryAddModalLabel">Add a Category</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="categoryAddForm">
                            <div class="form-group">
                                <label for="modalCategoryName">Name</label>
                                <input type="text" class="form-control" id="modalCategoryName" name="name" required>
                            </div>
                            <div class="form-group">
                                <label for="modalCategoryDescription">Description</label>
                                <textarea class="form-control" id="modalCategoryDescription" name="description" required></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">Add</button>
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
                        <p><strong>Post ID:</strong> <span id="modalViewPostID"></span></p>
                        <p><strong>Title: </strong> <span id="modalViewTitle"></span></p>
                        <p><strong>Author:</strong> <span id="modalViewAuthor"></span></p>
                        <p><strong>Categories</strong> <span id="modalViewCategories"></span></p>
                        <p><strong>Updated Date:</strong> <span id="modalViewUpdatedDate"></span></p>
                        <p><strong>Status:</strong> <span id="modalViewStatus"></span></p>
                        <p><strong>Content:</strong> <span id="modalViewContent"></span></p>
                        <div><strong>Images:</strong> <div id="modalViewImageLinks"></div></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Edit Post Modal -->
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
                                <input type="text" class="form-control" value="" id="editTitle" name="title" required>
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
                                                                        $('#modalViewPostID').text(post.postID);
                                                                        console.log('Post ID:', post.postID); // Log the post ID
                                                                        $('#modalViewTitle').text(post.title);
                                                                        console.log('Title:', post.title); // Log the title
                                                                        $('#modalViewAuthor').text(post.staff);
                                                                        console.log('Author:', post.staff); // Log the author

                                                                        $('#modalViewContent').text(post.content);
                                                                        console.log('Content:', post.content); // Log the content
                                                                        $('#modalViewStatus').text(post.status ? 'Shown' : 'Hidden');
                                                                        console.log('Status:', post.status ? 'Shown' : 'Hidden'); // Log the status
                                                                        $('#modalViewUpdatedDate').text(post.updatedDate);
                                                                        console.log('Updated Date:', post.updatedDate); // Log the updated date
                                                                        var link = $('#modalViewImageLinks');
                                                                        link
                                                                        link.append('<img src="' + post.thumbnailLink + '" alt="Post Image" class="img-thumbnail" style="width: 100px; margin: 5px;">');
                                                                        console.log('Thumbnail Link:', post.thumbnailLink); // Log the thumbnail link

                                                                        var categoriesContainer = $('#modalViewCategories');
                                                                        categoriesContainer.empty(); // Clear previous images
                                                                        if (post.categories) {
                                                                            post.categories.forEach(function (cate) {
                                                                                categoriesContainer.append(cate.name);
                                                                                console.log('Category:', cate.name); // Log each category name
                                                                            });
                                                                        }
                                                                        console.log(categoriesContainer);
                                                                        console.log(post.postID);
                                                                        // Show the modal
                                                                        $('#postDetailModal').modal('show');
                                                                    },
                                                                    error: function (xhr, status, error) {
                                                                        alert('Error fetching post details');
                                                                    }
                                                                });
                                                            });



                                                            // AJAX request to fetch post to edit
                                                            $('#postList').on('click', '.editBtn', function () {
                                                                var postID = $(this).data('id');
                                                                console.log("View button clicked, postID:", postID);

                                                                // AJAX request to fetch post details
                                                                $.ajax({
                                                                    url: 'MKTPostDetail',
                                                                    method: 'GET',
                                                                    data: {postID: postID},
                                                                    success: function (post) {
                                                                        $('#editPostID').val(post.postID);
                                                                        $('#editTitle').val(post.title);
                                                                        $('#editAuthor').val(post.staff);
                                                                        $('#editContent').val(post.content);
                                                                        $('#editlStatus').val(post.status ? 'Shown' : 'Hidden');
                                                                        $('#editThumbnailLink').val(post.thumbnailLink);
                                                                        $('#editCategories').val(post.categories.map(c => c.name).join(', '));

                                                                        // Show the modal
                                                                        $('#postEditModal').modal('show');
                                                                    },
                                                                    error: function (xhr, status, error) {
                                                                        alert('Error fetching post details');
                                                                    }
                                                                });
                                                            });
                                                            //AJAX to handle Edit form
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
                                                                        console.log("Form Data: ", formData);
                                                                        loadResult('mktpostlist');
                                                                    },
                                                                    error: function (xhr, status, error) {
                                                                        alert('Error updating post details');
                                                                        console.log("Form Data: ", formData);
                                                                    }
                                                                });
                                                            });
                                                            //show the modal
                                                            document.getElementById('addPostBtn').addEventListener('click', function () {
                                                                $('#postAddModal').modal('show');
                                                            });
                                                            //AJAX to handle Add form
                                                            $('#postAddForm').on('submit', function (event) {
                                                                event.preventDefault(); // Prevent the default form submission

                                                                // Get the value of the modalImageLinks input
                                                                var imageLinks = $('#modalImageLinks').val().trim();

                                                                // Define the allowed extensions
                                                                var allowedExtensions = ['.png', '.jpeg', '.jpg', '.webp'];

                                                                // Function to check if the URL ends with one of the allowed extensions
                                                                function hasValidExtension(url) {
                                                                    return allowedExtensions.some(function (extension) {
                                                                        return url.toLowerCase().endsWith(extension);
                                                                    });
                                                                }

                                                                // Check if the imageLinks is not empty and has a valid extension
                                                                if (imageLinks && !hasValidExtension(imageLinks)) {
                                                                    alert('Invalid image URL. Only .png, .jpeg, .jpg, .webp extensions are allowed.');
                                                                    return;
                                                                }

                                                                var formData = $(this).serialize();

                                                                $.ajax({
                                                                    type: 'POST',
                                                                    url: 'MKTAddPost',
                                                                    data: formData,
                                                                    success: function (response) {
                                                                        // Handle success
                                                                        alert('Post added successfully!');
                                                                        $('#postAddModal').modal('hide');
                                                                        console.log("Form Data: ", formData);
                                                                        loadResult('mktpostlist');
                                                                    },
                                                                    error: function (xhr, status, error) {
                                                                        // Handle error
                                                                        alert('An error occurred: ' + error);
                                                                    }
                                                                });
                                                            });

                                                            //Show the add category modal
                                                            document.getElementById('addCategoryBtn').addEventListener('click', function () {
                                                                $('#categoryAddModal').modal('show');
                                                            });

                                                            //AJAX to handle Add Category form
                                                            $('#categoryAddForm').on('submit', function (e) {
                                                                e.preventDefault();
                                                                var formData = $(this).serialize();
                                                                $.ajax({
                                                                    url: 'MKTAddCategory',
                                                                    method: 'POST',
                                                                    data: formData,
                                                                    success: function (response) {
                                                                        alert('Category added successfully!');
                                                                        $('#categoryAddModal').modal('hide');
                                                                        console.log("Form Data: ", formData);
                                                                        location.reload();
                                                                    },
                                                                    error: function (xhr, status, error) {
                                                                        alert('Error adding category details');
                                                                        console.log("Form Data: ", formData);
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