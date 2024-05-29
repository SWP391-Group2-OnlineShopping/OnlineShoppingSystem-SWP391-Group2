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
                padding: 4px 8px;
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
            .thumbnail img {
                max-width: 50px; /* Adjust image width */
                max-height: 50px; /* Adjust image height */
                display: block;
                margin: auto;
            }
            table.dataTable {
                width: 100%;
            }
            table.dataTable tbody tr {
                height: auto; /* Make sure row height adjusts based on content */
            }
            select.form-control {
                width: auto !important;
                min-width: 400px; /* Bạn có thể tăng giá trị này nếu cần thiết */
            }
            .select2-selection--multiple {
                width: auto !important;
            }

            .select2-selection__rendered {
                word-wrap: break-word !important;
                text-overflow: inherit !important;
                white-space: normal !important;
                min-width: 150px; /* Bạn có thể tăng giá trị này nếu cần thiết */
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
                                        <th>Quantities(size)</th> <!-- New column for Quantities and Sizes -->
                                        <th>Actions</th>
                                        <th style="display: none;">List Price (Numeric)</th> <!-- Hidden column for sorting -->
                                        <th style="display: none;">Sale Price (Numeric)</th> <!-- Hidden column for sorting -->
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
                                            <td>${product.quantitiesSizes}</td> <!-- Display Quantities and Sizes -->
                                            <td>
                                                <a href="editProduct.jsp?id=${product.productID}" class="btn btn-link">Edit</a>
                                                <a href="productdetails?id=${product.productID}" class="btn btn-link">View</a>
                                            </td>
                                            <td style="display: none;">${product.listPrice}</td> <!-- Hidden column for sorting -->
                                            <td style="display: none;">${product.salePrice}</td> <!-- Hidden column for sorting -->
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
            <!-- Include footer here -->
        </div>
        <script src="assets/vendor/slimscroll/jquery.slimscroll.js"></script>
        <script src="assets/libs/js/main-js.js"></script>
        <script>
            $(document).ready(function () {
                // Initialize DataTables with hidden columns for numeric sorting
                var table = $('#productTable').DataTable({
                    "autoWidth": false, // Disable automatic column width calculation
                    "columnDefs": [
                        {"orderable": true, "targets": [0, 2, 4, 5, 6, 7]}, // Make these columns orderable
                        {"orderable": false, "targets": [1, 3, 8]}, // Make these columns not orderable
                        {"visible": false, "targets": [9, 10]}, // Hide numeric columns used for sorting
                        {"width": "150px", "targets": 3} // Set fixed width for Category column
                    ],
                    "order": [[0, "asc"]], // Default sort
                    "columns": [
                        null, // ID
                        null, // Thumbnail
                        null, // Title
                        null, // Category
                        {"orderData": 9}, // List Price (formatted, sort by numeric)
                        {"orderData": 10}, // Sale Price (formatted, sort by numeric)
                        null, // Size
                        null, // Quantities and Sizes
                        null, // Actions
                        null, // Hidden column for numeric List Price
                        null  // Hidden column for numeric Sale Price
                    ]
                });

                // Initialize Select2 for category filter
                table.columns().every(function () {
                    var column = this;
                    if (column.index() == 3) {
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
                            select.append('<option value="' + d + '">' + d + '</option>');
                        });

                        $(select).select2({
                            placeholder: 'Brand',
                            allowClear: false,
                            width: 'resolve',
                            dropdownAutoWidth: true
                        }).on('select2:unselecting', function (e) {
                            $(this).data('unselecting', true);
                        }).on('select2:open', function (e) {
                            if ($(this).data('unselecting')) {
                                $(this).select2('close');
                                $(this).removeData('unselecting');
                            }
                        });
                    }
                });
            });

        </script>
    </body>
</html>