<!doctype html>
<html lang="en">
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page import="java.util.List" %>
    <%@ page import="model.*" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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

        <!-- include header -->
        <div class="sidebar">
            <%@ include file="COMP/marketing-sidebar.jsp" %>
        </div>
        <div class="content">
            <div class="dashboard-wrapper" style="margin-top:80px;">
                <div class="row">
                    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                        <div class="page-header">
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
                                                <th class="centered-cell" style="width: 100px;">ID
                                                    <button class="btn btn-link sort-btn" data-sort="postID" data-order="asc">
                                                        <i class="fas fa-sort"></i>
                                                    </button>
                                                </th>
                                                <th class="centered-cell">Thumbnail</th>
                                                <th class="centered-cell">Title
                                                    <button class="btn btn-link sort-btn" data-sort="title" data-order="asc">
                                                        <i class="fas fa-sort"></i>
                                                    </button>
                                                </th>
                                                <th class="fixed-length-header">
                                                    Category
                                                    <select id="sortOptions" onchange="applySort(this.value)" style="width: 150px;">
                                                        <option value="all" selected>All</option>
                                                        <c:forEach items="${cate}" var="c">
                                                            <option value="${c.postCL}">${c.name}</option>
                                                        </c:forEach>
                                                    </select>
                                                </th>
                                                <th class="centered-cell">Link Product
                                                    <button class="btn btn-link sort-btn" data-sort="product" data-order="asc">
                                                        <i class="fas fa-sort"></i>
                                                    </button>
                                                </th>
                                                <th class="centered-cell">Author
                                                    <button class="btn btn-link sort-btn" data-sort="author" data-order="asc">
                                                        <i class="fas fa-sort"></i>
                                                    </button>
                                                </th>
                                                <th class="centered-cell" >Date Created
                                                    <button class="btn btn-link sort-btn" data-sort="title" data-order="asc">
                                                        <i class="fas fa-sort"></i>
                                                    </button>
                                                </th>
                                                <th class="centered-cell">Status
                                                    <button class="btn btn-link sort-btn" data-sort="status" data-order="asc">
                                                        <i class="fas fa-sort"></i>
                                                    </button>
                                                </th>
                                                <th class="centered-cell">Feature
                                                    <button class="btn btn-link sort-btn" data-sort="feature" data-order="asc">
                                                        <i class="fas fa-sort"></i>
                                                    </button>
                                                </th>
                                                <th >Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody id="postList">
                                        <p id="resultCount"></p>
                                        <c:forEach var="post" items="${list}">
                                            <tr>
                                                <td>${post.postID}</td>
                                                <td class="thumbnail"><img src="${post.thumbnailLink}" alt="Image"></td>
                                                <td>${post.title}</td>
                                                <td class="fixed-length-cell">${post.categories}</td>
                                                <td><a href="productdetails?id=${post.product.productID}">${post.product.title}</a></td>                                                
                                                <td>${post.staff}</td>
                                                <td><fmt:formatDate value="${post.updatedDate}" pattern="MMMM dd, yyyy"/></td>
                                                <td>
                                                    <input type="checkbox" class="statusSwitch" <c:if test="${post.status}">checked</c:if> data-id="${post.postID}">
                                                    </td>
                                                    <td>
                                                        <input type="checkbox" class="featureSwitch" <c:if test="${post.feature}">checked</c:if> data-id="${post.postID}">
                                                    </td>
                                                    <td class="actions-cell">
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
                                <label for="modalProduct">Link Product: </label>
                                <select class="form-control" id="modalProducts" name="products" required>
                                    <c:forEach items="${products}" var="p">
                                        <option value="${p.productID}">${p.title}</option>
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
                                <label for="modalFeature">Feature</label>
                                <select class="form-control" id="editFeature" name="feature">
                                    <option value="true">True</option>
                                    <option value="false">False</option>
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
                        <p><strong>Title: </strong> <span id="modalViewTitle"></span> </p>
                        <p><strong>Link Product: </strong> <span id="modalViewProduct"></span> </p>
                        <p><strong>Author:</strong> <span id="modalViewAuthor"></span></p>
                        <p><strong>Categories:</strong> <span id="modalViewCategories"></span></p>
                        <p><strong>Updated Date:</strong> <span id="modalViewUpdatedDate"></span></p>
                        <p><strong>Status:</strong> <span id="modalViewStatus"></span></p>
                        <p><strong>Feature:</strong> <span id="modalViewFeature"></span></p>
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
                                <select class="form-control" id="editCategories" name="categories">
                                    <c:forEach items="${cate}" var="c">
                                        <option value="${c.postCL}">${c.name}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="editProducts">Link Product: </label>
                                <select class="form-control" id="editProducts" name="products">
                                    <c:forEach items="${products}" var="p">
                                        <option value="${p.productID}">${p.title}</option>
                                    </c:forEach>
                                </select>
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
                                <label for="editFeature">Feature:</label>
                                <select class="form-control" id="editFeature" name="feature">
                                    <option value="true">True</option>
                                    <option value="false">False</option>
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
        <script src="js/post-management.js"></script>

    </body>
</html>