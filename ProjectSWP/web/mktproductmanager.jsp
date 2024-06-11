<!doctype html>
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
        <title>Marketing Dashboard</title>
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
                                            <li class="breadcrumb-item active" aria-current="page">Product Manager</li>
                                        </ol>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="container">
                        <h1 class="my-4">Product List</h1>
                        <div class="mb-4 d-flex justify-content-between">
                            <div>
                                <button class="btn btn-primary" id="addProductBtn">Add New Product</button>
                                <button class="btn btn-secondary ml-2" id="addBrandBtn">Add New Brand</button>
                            </div>
                        </div>
                        <c:choose>
                            <c:when test="${not empty products}">
                                <table id="productTable" class="display table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Thumbnail</th>
                                            <th>Title</th>
                                            <th>Category</th>
                                            <th>List Price</th>
                                            <th>Sale Price</th>
                                            <th>Size</th>
                                            <th>Quantities(size)</th>
                                            <th>Status</th>
                                            <th>Feature</th>
                                            <th>Actions</th>
                                            <th style="display: none;">List Price (Numeric)</th>
                                            <th style="display: none;">Sale Price (Numeric)</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="product" items="${products}">
                                            <tr>
                                                <td>${product.productID}</td>
                                                <td class="thumbnail"><img src="${product.thumbnailLink}" alt="Thumbnail"></td>
                                                <td>${product.title}</td>
                                                <td>${product.category}</td>
                                                <td>${product.formattedListPrice}</td>
                                                <td>${product.formattedPrice}</td>
                                                <td>${product.size}</td>
                                                <td>${product.quantitiesSizes}</td>
                                                <td>
                                                    <div class="checkbox-wrapper-19">
                                                        <input type="checkbox" id="status-${product.productID}" data-status="${product.status ? 'active' : 'inactive'}" ${product.status ? 'checked' : ''} />
                                                        <label for="status-${product.productID}" class="check-box"></label>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="checkbox-wrapper-18">
                                                        <div class="round">
                                                            <input type="checkbox" id="feature-${product.productID}" data-feature="${product.feature ? 'active' : 'inactive'}" ${product.feature ? 'checked' : ''} disabled />
                                                            <label for="feature-${product.productID}"></label>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <button class="btn btn-primary editBtn" data-id="${product.productID}">Edit</button>
                                                    <button class="btn btn-secondary viewBtn" data-id="${product.productID}">View</button>
                                                    <button class="btn btn-danger deleteBtn">Delete</button>
                                                </td>
                                                <td style="display: none;">${product.listPrice}</td>
                                                <td style="display: none;">${product.salePrice}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <p>Products list is empty</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
        <!-- Add Product Modal -->
        <div class="modal fade" id="addProductModal" tabindex="-1" role="dialog" aria-labelledby="addProductModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addProductModalLabel">Add New Product</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="addProductForm">
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
                            <button type="submit" class="btn btn-primary">Add Product</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Add Brand Modal -->
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

        <!-- View Product Modal -->
        <div class="modal fade" id="viewProductModal" tabindex="-1" role="dialog" aria-labelledby="viewProductModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="viewProductModalLabel">Product Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="viewProductForm">
                            <input type="hidden" id="viewProductId" name="productId">
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

        <!-- Edit Product Modal -->
        <div class="modal fade" id="editProductModal" tabindex="-1" role="dialog" aria-labelledby="editProductModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editProductModalLabel">Edit Product</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="editProductForm">
                            <input type="hidden" id="editProductId" name="productId">
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
                            <button type="button" class="btn btn-primary" id="updateProductBtn">Update</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>



        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="assets/vendor/slimscroll/jquery.slimscroll.js"></script>
        <script src="assets/libs/js/main-js.js"></script>
        <script src="js/product-management.js"></script>
    </body>
</html>
