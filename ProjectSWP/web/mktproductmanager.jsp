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
            .checkbox-wrapper-19 {
                box-sizing: border-box;
                --background-color: #fff;
                --checkbox-height: 25px;
            }

            @-moz-keyframes dothabottomcheck-19 {
                0% {
                    height: 0;
                }
                100% {
                    height: calc(var(--checkbox-height) / 2);
                }
            }

            @-webkit-keyframes dothabottomcheck-19 {
                0% {
                    height: 0;
                }
                100% {
                    height: calc(var(--checkbox-height) / 2);
                }
            }

            @keyframes dothabottomcheck-19 {
                0% {
                    height: 0;
                }
                100% {
                    height: calc(var(--checkbox-height) / 2);
                }
            }

            @keyframes dothatopcheck-19 {
                0% {
                    height: 0;
                }
                50% {
                    height: 0;
                }
                100% {
                    height: calc(var(--checkbox-height) * 1.2);
                }
            }

            @-webkit-keyframes dothatopcheck-19 {
                0% {
                    height: 0;
                }
                50% {
                    height: 0;
                }
                100% {
                    height: calc(var(--checkbox-height) * 1.2);
                }
            }

            @-moz-keyframes dothatopcheck-19 {
                0% {
                    height: 0;
                }
                50% {
                    height: 0;
                }
                100% {
                    height: calc(var(--checkbox-height) * 1.2);
                }
            }

            .checkbox-wrapper-19 input[type=checkbox] {
                display: none;
            }

            .checkbox-wrapper-19 .check-box {
                height: var(--checkbox-height);
                width: var(--checkbox-height);
                background-color: transparent;
                border: calc(var(--checkbox-height) * .1) solid #000;
                border-radius: 5px;
                position: relative;
                display: inline-block;
                -moz-box-sizing: border-box;
                -webkit-box-sizing: border-box;
                box-sizing: border-box;
                -moz-transition: border-color ease 0.2s;
                -o-transition: border-color ease 0.2s;
                -webkit-transition: border-color ease 0.2s;
                transition: border-color ease 0.2s;
                cursor: pointer;
            }
            .checkbox-wrapper-19 .check-box::before,
            .checkbox-wrapper-19 .check-box::after {
                -moz-box-sizing: border-box;
                -webkit-box-sizing: border-box;
                box-sizing: border-box;
                position: absolute;
                height: 0;
                width: calc(var(--checkbox-height) * .2);
                background-color: #34b93d;
                display: inline-block;
                -moz-transform-origin: left top;
                -ms-transform-origin: left top;
                -o-transform-origin: left top;
                -webkit-transform-origin: left top;
                transform-origin: left top;
                border-radius: 5px;
                content: " ";
                -webkit-transition: opacity ease 0.5;
                -moz-transition: opacity ease 0.5;
                transition: opacity ease 0.5;
            }
            .checkbox-wrapper-19 .check-box::before {
                top: calc(var(--checkbox-height) * .72);
                left: calc(var(--checkbox-height) * .41);
                box-shadow: 0 0 0 calc(var(--checkbox-height) * .05) var(--background-color);
                -moz-transform: rotate(-135deg);
                -ms-transform: rotate(-135deg);
                -o-transform: rotate(-135deg);
                -webkit-transform: rotate(-135deg);
                transform: rotate(-135deg);
            }
            .checkbox-wrapper-19 .check-box::after {
                top: calc(var(--checkbox-height) * .37);
                left: calc(var(--checkbox-height) * .05);
                -moz-transform: rotate(-45deg);
                -ms-transform: rotate(-45deg);
                -o-transform: rotate(-45deg);
                -webkit-transform: rotate(-45deg);
                transform: rotate(-45deg);
            }

            .checkbox-wrapper-19 input[type=checkbox]:checked + .check-box,
            .checkbox-wrapper-19 .check-box.checked {
                border-color: #34b93d;
            }
            .checkbox-wrapper-19 input[type=checkbox]:checked + .check-box::after,
            .checkbox-wrapper-19 .check-box.checked::after {
                height: calc(var(--checkbox-height) / 2);
                -moz-animation: dothabottomcheck-19 0.2s ease 0s forwards;
                -o-animation: dothabottomcheck-19 0.2s ease 0s forwards;
                -webkit-animation: dothabottomcheck-19 0.2s ease 0s forwards;
                animation: dothabottomcheck-19 0.2s ease 0s forwards;
            }
            .checkbox-wrapper-19 input[type=checkbox]:checked + .check-box::before,
            .checkbox-wrapper-19 .check-box.checked::before {
                height: calc(var(--checkbox-height) * 1.2);
                -moz-animation: dothatopcheck-19 0.4s ease 0s forwards;
                -o-animation: dothatopcheck-19 0.4s ease 0s forwards;
                -webkit-animation: dothatopcheck-19 0.4s ease 0s forwards;
                animation: dothatopcheck-19 0.4s ease 0s forwards;
            }


            .checkbox-wrapper-18 .round {
                position: relative;
            }

            .checkbox-wrapper-18 .round label {
                background-color: #fff;
                border: 1px solid #ccc;
                border-radius: 50%;
                cursor: pointer;
                height: 28px;
                width: 28px;
                display: block;
            }

            .checkbox-wrapper-18 .round label:after {
                border: 2px solid #fff;
                border-top: none;
                border-right: none;
                content: "";
                height: 6px;
                left: 8px;
                opacity: 0;
                position: absolute;
                top: 9px;
                transform: rotate(-45deg);
                width: 12px;
            }

            .checkbox-wrapper-18 .round input[type="checkbox"] {
                visibility: hidden;
                display: none;
                opacity: 0;
            }

            .checkbox-wrapper-18 .round input[type="checkbox"]:checked + label {
                background-color: #66bb6a;
                border-color: #66bb6a;
            }

            .checkbox-wrapper-18 .round input[type="checkbox"]:checked + label:after {
                opacity: 1;
            }
            .container{
                margin-left: 40px;
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
                    <div class="mb-4 d-flex justify-content-between">
                        <div>
                            <a href="addProduct.jsp" class="btn btn-primary">Add New Product</a>
                            <a href="addBrand.jsp" class="btn btn-secondary ml-2">Add New Brand</a>
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
                                                <a href="editProduct.jsp?id=${product.productID}" class="btn btn-primary editBtn">Edit</a>
                                                <a href="productdetails?id=${product.productID}" class="btn btn-secondary viewBtn">View</a>
                                                <a href="#"  class="btn btn-danger deleteBtn">Delete</a>
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
                        {"orderable": false, "targets": [1, 3, 10, 9, 8]}, // Make these columns not orderable
                        {"visible": false, "targets": [11, 12]}, // Hide numeric columns used for sorting
                        {"width": "150px", "targets": 3} // Set fixed width for Category column
                    ],
                    "order": [[0, "asc"]], // Default sort
                    "columns": [
                        null, // ID
                        null, // Thumbnail
                        null, // Title
                        null, // Category
                        {"orderData": 11}, // List Price (formatted, sort by numeric)
                        {"orderData": 12}, // Sale Price (formatted, sort by numeric)
                        null, // Size
                        null, // Quantities and Sizes
                        null, // Status
                        null, // Feature
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
                $('input[id^="status-"]').change(function () {
                    var checkbox = $(this);
                    var productId = checkbox.attr('id').split('-')[1];
                    var status = checkbox.is(':checked') ? 'active' : 'inactive';

                    $.ajax({
                        url: 'updateProductStatus',
                        type: 'POST',
                        data: {
                            productID: productId,
                            status: status
                        },
                        success: function (response) {
                            if (!response.updated) {
                                checkbox.prop('checked', status === 'inactive');
                            }
                        },
                        error: function (error) {
                            checkbox.prop('checked', status === 'inactive');
                        }
                    });
                });
            });
        </script>
    </body>
</html>