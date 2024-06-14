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
                        <h1 class="my-4">Post List</h1>
                        <div class="mb-4 d-flex justify-content-between">
                            <div>
                                <button class="btn btn-primary" id="addPostBtn">Add New Post</button>
                                <button class="btn btn-secondary ml-2" id="addBrandBtn">Add New Brand</button>
                            </div>
                        </div>
                        <c:choose>
                            <c:when test="${not empty list}">
                                <table id="postTable" class="display table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Thumbnail</th>
                                            <th>Title</th>
                                            <th>Category</th>
                                            <th>Author</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="list" items="${list}">
                                            <tr>
                                                <td>${list.postID}</td>
                                                <td class="thumbnail"><img src="${list.thumbnailLink}" alt="Thumbnail"></td>
                                                <td>${list.title}</td>
                                                <td>${list.categories}</td>
                                                <td>${list.staff}</td>
                                                <td>
                                                    <div class="checkbox-wrapper-19">
                                                        <input type="checkbox" id="status-${list.postID}" data-status="${list.status ? 'active' : 'inactive'}" ${list.status ? 'checked' : ''} />
                                                        <label for="status-${list.postID}" class="check-box"></label>
                                                    </div>
                                                </td>

                                                <td>
                                                    <button class="btn btn-primary editBtn" data-id="${list.postID}">Edit</button>
                                                    <button class="btn btn-secondary viewBtn" data-id="${list.postID}">View</button>
                                                    <button class="btn btn-danger deleteBtn">Delete</button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <p>Posts list is empty</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
        <!-- Add Post Modal -->
        <div class="modal fade" id="addPostModal" tabindex="-1" role="dialog" aria-labelledby="addPostModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addPostModalLabel">Add New Post</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="addPostForm">
                            <div class="form-group">
                                <label for="title">Title</label>
                                <input type="text" class="form-control" id="title" name="title" required>
                                <div class="error" id="titleError" style="display:none;">Please enter a title.</div>
                            </div>
                            <div class="form-group">
                                <label for="salePrice">Sale Price</label>
                                <input type="number" step="0.01" class="form-control" id="salePrice" name="salePrice" required>
                                <div class="error" id="salePriceError" style="display:none;">Sale Price must be greater than 0.</div>
                            </div>
                            <div class="form-group">
                                <label for="listPrice">List Price</label>
                                <input type="number" step="0.01" class="form-control" id="listPrice" name="listPrice" required>
                                <div class="error" id="listPriceError" style="display:none;">List Price must be greater than 0.</div>
                            </div>
                            <div class="form-group">
                                <label for="description">Description</label>
                                <textarea class="form-control" id="description" name="description" required></textarea>
                                <div class="error" id="descriptionError" style="display:none;">Please enter a description.</div>
                            </div>
                            <div class="form-group">
                                <label for="briefInformation">Brief Information</label>
                                <textarea class="form-control" id="briefInformation" name="briefInformation" required></textarea>
                                <div class="error" id="briefInformationError" style="display:none;">Please enter brief information.</div>
                            </div>
                            <div class="form-group">
                                <label for="thumbnail">Thumbnail Link</label>
                                <input type="text" class="form-control" id="thumbnail" name="thumbnail" required>
                                <div class="error" id="thumbnailError" style="display:none;">Please enter a thumbnail link.</div>
                            </div>
                            <div class="form-group">
                                <label for="imageDetail">Image Detail</label>
                                <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="imageDetail" name="imageDetail" placeholder="Enter image link">
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-secondary" type="button" id="addImageDetail">Add</button>
                                    </div>
                                </div>
                            </div>
                            <div id="addImageDetailsContainer"></div>
                            <input type="hidden" id="imageDetails" name="imageDetails">
                            <div class="form-group">
                                <label for="size">Size</label>
                                <input type="number" class="form-control" id="size" name="size" required>
                                <div class="error" id="sizeError" style="display:none;">Size must be between 35 and 48.</div>
                            </div>
                            <div class="form-group">
                                <label for="quantities">Quantities</label>
                                <input type="number" class="form-control" id="quantities" name="quantities" required>
                                <div class="error" id="quantitiesError" style="display:none;">Quantities must be greater than 0.</div>
                            </div>
                            <div class="form-group">
                                <label for="category">Category</label>
                                <select class="form-control" id="category" name="category" required>
                                    <option value="">Select Category</option>
                                </select>
                                <div class="error" id="categoryError" style="display:none;">Please select a category.</div>
                            </div>
                            <div class="form-group form-check">
                                <input type="checkbox" class="form-check-input" id="status" name="status">
                                <label class="form-check-label" for="status">Active</label>
                            </div>
                            <div class="form-group form-check">
                                <input type="checkbox" class="form-check-input" id="feature" name="feature">
                                <label class="form-check-label" for="feature">Feature</label>
                            </div>
                            <button type="submit" class="btn btn-primary">Add Post</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

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
        <div class="modal fade" id="viewPostModal" tabindex="-1" role="dialog" aria-labelledby="viewPostModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="viewPostModalLabel">Post Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="viewPostForm">
                            <input type="hidden" id="viewPostId" name="productId">
                            <div class="form-group">
                                <label for="viewTitle">Title</label>
                                <input type="text" class="form-control" id="viewTitle" name="title" readonly>
                            </div>
                            <div class="form-group">
                                <label for="viewSalePrice">Sale Price</label>
                                <input type="number" step="0.01" class="form-control" id="viewSalePrice" name="salePrice" readonly>
                            </div>
                            <div class="form-group">
                                <label for="viewListPrice">List Price</label>
                                <input type="number" step="0.01" class="form-control" id="viewListPrice" name="listPrice" readonly>
                            </div>
                            <div class="form-group">
                                <label for="viewDescription">Description</label>
                                <textarea class="form-control" id="viewDescription" name="description" rows="3" readonly></textarea>
                            </div>
                            <div class="form-group">
                                <label for="viewBriefInformation">Brief Information</label>
                                <textarea class="form-control" id="viewBriefInformation" name="briefInformation" rows="2" readonly></textarea>
                            </div>
                            <div class="form-group">
                                <label for="viewThumbnail">Thumbnail</label>
                                <div id="viewThumbnailContainer"></div>
                            </div>
                            <!-- Image Details Container -->
                            <div class="form-group">
                                <label for="viewImageDetails">Attached Images</label>
                                <div id="viewImageDetailsContainer"></div>
                            </div>
                            <div class="form-group">
                                <label for="viewSize">Size</label>
                                <input type="text" class="form-control" id="viewSize" name="size" readonly>
                            </div>
                            <div class="form-group">
                                <label for="viewCategory">Category</label>
                                <input type="text" class="form-control" id="viewCategory" name="category" readonly>
                            </div>
                            <div class="form-group">
                                <label for="viewStatus">Status</label>
                                <div class="checkbox-wrapper-19">
                                    <input type="checkbox" id="viewStatus" name="status" disabled>
                                    <label for="viewStatus" class="check-box"></label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="viewFeature">Feature</label>
                                <div class="checkbox-wrapper-18">
                                    <div class="round">
                                        <input type="checkbox" id="viewFeature" name="feature" disabled>
                                        <label for="viewFeature"></label>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Edit Post Modal -->
        <div class="modal fade" id="editPostModal" tabindex="-1" role="dialog" aria-labelledby="editPostModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editPostModalLabel">Edit Post</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="editPostForm">
                            <input type="hidden" id="editPostId" name="productId">
                            <div class="form-group">
                                <label for="editTitle">Title</label>
                                <input type="text" class="form-control" id="editTitle" name="title">
                            </div>
                            <div class="form-group">
                                <label for="editSalePrice">Sale Price</label>
                                <input type="number" step="0.01" class="form-control" id="editSalePrice" name="salePrice">
                            </div>
                            <div class="form-group">
                                <label for="editListPrice">List Price</label>
                                <input type="number" step="0.01" class="form-control" id="editListPrice" name="listPrice">
                            </div>
                            <div class="form-group">
                                <label for="editDescription">Description</label>
                                <textarea class="form-control" id="editDescription" name="description" rows="3"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="editBriefInformation">Brief Information</label>
                                <textarea class="form-control" id="editBriefInformation" name="briefInformation" rows="2"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="editThumbnailLink">Thumbnail Link</label>
                                <input type="text" class="form-control" id="editThumbnailLink" name="thumbnailLink">
                                <div id="editThumbnailContainer"></div>
                            </div>
                            <div class="form-group">
                                <label for="editImageDetail">Image Detail</label>
                                <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="editImageDetail" placeholder="Enter image link">
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-secondary" type="button" id="addEditImageDetail">Add</button>
                                    </div>
                                </div>
                            </div>
                            <div id="editImageDetailsContainer"></div>
                            <input type="hidden" id="editImageDetails" name="imageDetails">
                            <input type="hidden" id="editSize" name="size">
                            <input type="hidden" id="editQuantitiesSizes" name="quantitiesSizes">
                            <div class="form-group">
                                <label for="editCategory">Category</label>
                                <select class="form-control" id="editCategory" name="category"></select>
                            </div>
                            <div class="form-group">
                                <label for="editStatus">Status</label>
                                <div class="checkbox-wrapper-19">
                                    <input type="checkbox" id="editStatus" name="status">
                                    <label for="editStatus" class="check-box"></label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="editFeature">Feature</label>
                                <div class="checkbox-wrapper-18">
                                    <div class="round">
                                        <input type="checkbox" id="editFeature" name="feature">
                                        <label for="editFeature"></label>
                                    </div>
                                </div>
                            </div>
                            <button type="button" class="btn btn-primary" id="updatePostBtn">Update</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
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
        <script>
        $(document).ready(function() {
            // Show the modal when the button is clicked
            $('#addPostBtn').click(function () {
                console.log('Button clicked'); // For debugging
                $('#addPostModal').modal('show');
            });
        });
    </script>
    </body>
</html>
