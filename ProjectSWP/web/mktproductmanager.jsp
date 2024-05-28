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
    th, td {
        padding: 8px 12px;
    }
    table.dataTable th, table.dataTable td {
        white-space: nowrap;
    }
    .select2-container {
        width: auto !important;
    }
    .select2-dropdown {
        width: auto !important;
        min-width: 150px;
    }
    .select2-selection__rendered {
        word-wrap: break-word !important;
        text-overflow: inherit !important;
        white-space: normal !important;
    }
</style>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- DataTables JS -->
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/1.7.1/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
</head>
  <body>
    <!-- include header -->
    <%@ include file="COMP/manager-header.jsp" %>
    <!-- include sidebar -->
    <%@ include file="COMP/marketing-sidebar.jsp" %>
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
                <div class="mb-4">
                    <a href="addProduct.jsp" class="btn btn-primary">Add New Product</a>
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
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="product" items="${products}">
                                    <tr>
                                        <td>${product.productID}</td>
                                        <td><img src="${product.thumbnailLink}" alt="Thumbnail" width="50" height="50"></td>
                                        <td>${product.title}</td>
                                        <td>${product.category}</td>
                                        <td>${product.listPrice}</td>
                                        <td>${product.salePrice}</td>
                                        <td>${product.size}</td>
                                        <td>
                                            <a href="editProduct.jsp?id=${product.productID}" class="btn btn-link">Edit</a>
                                            <a href="productdetails?id=${product.productID}" class="btn btn-link">View</a>
                                            <a href="hideProduct.jsp?id=${product.productID}" class="btn btn-link">Hide</a>
                                            <a href="showProduct.jsp?id=${product.productID}" class="btn btn-link">Show</a>
                                        </td>
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
        <!-- include footer -->
        <%@ include file="COMP/manager-footer.jsp" %>
    </div>
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.js"></script>
    <script src="assets/vendor/slimscroll/jquery.slimscroll.js"></script>
    <script src="assets/libs/js/main-js.js"></script>
    <script>
        $(document).ready(function() {
            // Initialize DataTables with column-specific search inputs
            var table = $('#productTable').DataTable({
                "columnDefs": [
                    { "orderable": true, "targets": [0, 2, 4, 5, 6] }, // Các cột có thể sắp xếp (loại bỏ cột 3 - Category)
                    { "orderable": false, "targets": [1, 3, 7] } // Các cột không thể sắp xếp (thêm cột 3 - Category)
                ],
                initComplete: function () {
                    this.api().columns().every(function () {
                        var column = this;
                        if (column.index() == 3) { // Thêm select cho cột Category
                            var select = $('<select multiple="multiple" class="form-control"><option value=""></option></select>')
                                .appendTo($(column.header()).empty())
                                .on('change', function () {
                                    var vals = $(this).val();
                                    var searchStr = '';
                                    if (vals) {
                                        searchStr = vals.join('|');
                                    }
                                    column.search(searchStr, true, false).draw();
                                });
                            column.data().unique().sort().each(function (d, j) {
                                select.append('<option value="' + d + '">' + d + '</option>')
                            });
                            $(select).select2({
                                placeholder: 'Category',
                                allowClear: true,
                                closeOnSelect: false,
                                dropdownAutoWidth: true,
                                width: 'auto'
                            });
                        }
                    });
                }
            });
        });
    </script>
</body>
</html>