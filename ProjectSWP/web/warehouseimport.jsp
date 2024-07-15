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
        <title>Warehouse Dashboard</title>
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
        <!-- include sidebar -->
        <%@ include file="COMP/warehouse-sidebar.jsp" %>
        <!-- ============================================================== -->
        <!-- wrapper  -->
        <!-- ============================================================== -->
        <div class="dashboard-wrapper">
            <div class="container-fluid dashboard-content">
                <!-- ============================================================== -->
                <!-- pageheader  -->
                <!-- ============================================================== -->
                <div class="row">
                    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                        <div class="page-header">
                            <h3 class="mb-2">Inventory Management</h3>
                            <div class="page-breadcrumb">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="warehouseimport" class="breadcrumb-link">Inventory Management</a></li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- ============================================================== -->
                <!-- pageheader  -->
                <!-- ============================================================== -->

                <!-- ============================================================== -->
                <!-- Start code your page here -->
                <!-- ============================================================== -->
                <div class="container">
                    <h1 class="my-4">Import Product Data</h1>
                    <div class="mb-4 d-flex justify-content-between">
                        
                    </div>
                    <c:choose>
                        <c:when test="${not empty products}">
                            <table id="productTable" class="display table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Title</th>
                                        <th>Category</th>
                                        <th>Import Price</th>
                                        <th>Size</th>
                                        <th>Quantities</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="product" items="${products}">
                                        <tr>
                                            <td>${product.productID}</td>
                                            <td>${product.title}</td>
                                            <td>${product.category}</td>
                                            <td>${product.importPrice}</td>
                                            <td>${product.size}</td>
                                            <td>${product.quantity}</td>
                                            <td>
                                                <button class="btn btn-primary editBtn" data-id="${product.productID}" data-import-price="${product.importPrice}" data-size="${product.size}" data-quantities="${product.quantity}">Edit</button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <nav aria-label="Page navigation">
                                <ul class="pagination">
                                    <c:forEach var="i" begin="1" end="${noOfPages}">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="warehouseimport?page=${i}">${i}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </nav>
                        </c:when>
                        <c:otherwise>
                            <p>Products list is empty</p>
                        </c:otherwise>
                    </c:choose>
                </div>
                <!-- ============================================================== -->
                <!-- End code your page here -->
                <!-- ============================================================== -->
            </div>
            <!-- include footer -->
            <%@ include file="COMP/manager-footer.jsp" %>
        </div>
        <!-- ============================================================== -->
        <!-- end main wrapper  -->
        <!-- ============================================================== -->
        <!-- Modal for editing product data -->
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
                        <label for="editImportPrice">Import Price</label>
                        <input type="number" class="form-control" id="editImportPrice" name="importPrice" required>
                    </div>
                    <div id="sizeQuantityContainer">
                        <div class="form-group">
                            <label for="editSize">Size</label>
                            <input type="text" class="form-control" id="editSize" name="size[]" required>
                        </div>
                        <div class="form-group">
                            <label for="editQuantities">Quantities</label>
                            <input type="number" class="form-control" id="editQuantities" name="quantities[]" required>
                        </div>
                    </div>
                    <button type="button" id="addSizeQuantity" class="btn btn-secondary">Add Size and Quantities</button>
                    <button type="submit" class="btn btn-primary">Save changes</button>
                </form>
            </div>
        </div>
    </div>
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
        <script>
            $(document).ready(function () {
                // Edit button click
                $(document).on('click', '.editBtn', function () {
                    var productId = $(this).data('id');
                    var importPrice = $(this).data('import-price');
                    var size = $(this).data('size');
                    var quantities = $(this).data('quantities');

                    $('#editProductId').val(productId);
                    $('#editImportPrice').val(importPrice);
                    $('#editSize').val(size);
                    $('#editQuantities').val(quantities);

                    $('#editProductModal').modal('show');
                });

                // Add Size and Quantities button click
                $('#addSizeQuantity').click(function () {
                    $('#sizeQuantityContainer').append(`
                        <div class="form-group">
                            <label for="editSize">Size</label>
                            <input type="text" class="form-control" name="size[]" required>
                        </div>
                        <div class="form-group">
                            <label for="editQuantities">Quantities</label>
                            <input type="number" class="form-control" name="quantities[]" required>
                        </div>
                    `);
                });

                // Save changes in modal
                $('#editProductForm').submit(function (e) {
                    e.preventDefault();
                    var productId = $('#editProductId').val();
                    var importPrice = $('#editImportPrice').val();
                    var sizes = $('input[name="size[]"]').map(function() { return $(this).val(); }).get();
                    var quantities = $('input[name="quantities[]"]').map(function() { return $(this).val(); }).get();

                    $.ajax({
                        url: 'warehouseimport',
                        method: 'POST',
                        data: {
                            productId: productId,
                            importPrice: importPrice,
                            sizes: sizes,
                            quantities: quantities
                        },
                        success: function (response) {
                            if (response.status === 'success') {
                                alert('Product data saved successfully');
                                location.reload();
                            } else {
                                alert('Error saving product data: ' + response.message);
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert('Error saving product data');
                        }
                    });
                });
            });
        </script>
    </body>
</html>
