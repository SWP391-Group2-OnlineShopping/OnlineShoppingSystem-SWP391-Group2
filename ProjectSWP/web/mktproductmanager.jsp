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
        <style>
            body {
                display: flex;
                height: 100vh;
                margin: 0;
                overflow-x: hidden; /* Prevent horizontal overflow */
            }

            .sidebar {
                width: 250px;
                flex-shrink: 0;
                background-color: #343a40;
                color: white;
                height: 100vh;
                position: fixed;
                z-index: 1000; /* Ensure it stays on top */
            }

            .content {
                margin-left: 40px; /* This should match the width of the sidebar */
                flex-grow: 1;
                overflow-y: auto; /* Ensure vertical scroll if content is long */
            }

            @media (max-width: 768px) {
                .sidebar {
                    width: 100%;
                    height: auto;
                    position: relative;
                }
                .content {
                    margin-left: 0;
                }
            }
            @media (max-width: 992px) {
                .sidebar {
                    width: 200px;
                }
                .content {
                    margin-left: 200px;
                }
            }
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
            .error {
                color: red;
                font-size: 12px;
                display: none;
            }
        </style>
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
                                <label for="thumbnail">Thumbnail</label>
                                <input type="text" class="form-control" id="thumbnail" name="thumbnail" required>
                                <div class="error" id="thumbnailError" style="display:none;">Please enter a thumbnail link.</div>
                            </div>
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
                            <div class="form-group">
                                <label for="status">Status</label>
                                <input type="checkbox" id="status" name="status">
                            </div>
                            <div class="form-group">
                                <label for="feature">Feature</label>
                                <input type="checkbox" id="feature" name="feature">
                            </div>
                            <button type="submit" class="btn btn-primary">Submit</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

       
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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

                // Sử dụng sự kiện 'on' để gắn kết sự kiện động cho các checkbox
                $(document).on('change', 'input[id^="status-"]', function () {
                    var checkbox = $(this);
                    var productId = checkbox.attr('id').split('-')[1];
                    var status = checkbox.is(':checked') ? 'active' : 'inactive';

                    console.log('Sending:', {productID: productId, status: status});

                    $.ajax({
                        url: 'updateProductStatus',
                        type: 'POST',
                        data: {
                            productID: productId,
                            status: status
                        },
                        success: function (response) {
                            console.log('Response:', response);
                            if (!response.updated) {
                                checkbox.prop('checked', status === 'inactive');
                            }
                        },
                        error: function (error) {
                            console.log('Error:', error);
                            checkbox.prop('checked', status === 'inactive');
                        }
                    });
                });

                // Load categories
                $.ajax({
                    url: 'getCategories',
                    method: 'GET',
                    success: function (response) {
                        response.forEach(function (category) {
                            $('#category').append(new Option(category.name, category.productCL));
                        });
                    },
                    error: function () {
                        alert('Error loading categories');
                    }
                });

                $('#addProductBtn').click(function () {
                    $('#addProductModal').modal('show');
                });

                // Validate input fields in real-time
                function validateField(field, errorField, validationFn) {
                    $(field).on('input change', function () {
                        if (!validationFn($(this).val())) {
                            $(errorField).show();
                        } else {
                            $(errorField).hide();
                        }
                    });
                }

                // Validation functions
                const isNotEmpty = value => value.trim() !== '';
                const isGreaterThanZero = value => parseFloat(value) > 0;
                const isValidSize = value => parseInt(value) >= 35 && parseInt(value) <= 48;
                // Real-time validations
                validateField('#title', '#titleError', isNotEmpty);
                validateField('#salePrice', '#salePriceError', isGreaterThanZero);
                validateField('#listPrice', '#listPriceError', isGreaterThanZero);
                validateField('#description', '#descriptionError', isNotEmpty);
                validateField('#briefInformation', '#briefInformationError', isNotEmpty);
                validateField('#thumbnail', '#thumbnailError', isNotEmpty);
                validateField('#size', '#sizeError', isValidSize);
                validateField('#quantities', '#quantitiesError', isGreaterThanZero);
                validateField('#category', '#categoryError', isNotEmpty);

                // Handle form submission
                $('#addProductForm').submit(function (e) {
                    e.preventDefault();
                    let isValid = true;
                    // Check if any error messages are visible
                    $('.error').each(function () {
                        if ($(this).is(':visible')) {
                            isValid = false;
                        }
                    });
                    if (isValid) {
                        var formData = $(this).serialize();
                        $.ajax({
                            url: 'AddProduct',
                            method: 'POST',
                            data: formData,
                            success: function (response) {
                                if (response.status === 'success') {
                                    alert('Product added successfully');
                                    $('#addProductModal').modal('hide');
                                    location.reload(); // Reload the page to see the new product
                                } else {
                                    alert('Error adding product');
                                }
                            },
                            error: function () {
                                alert('Error adding product');
                            }
                        });
                    }
                });
                //Delete product
                $(document).on('click', '.deleteBtn', function () {
        var productId = $(this).closest('tr').find('td:first').text();
        
        Swal.fire({
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: 'deleteProduct',
                    type: 'POST',
                    data: {
                        productID: productId
                    },
                    success: function (response) {
                        if (response.deleted) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Your product has been deleted',
                                showConfirmButton: false,
                                timer: 1500,
                                position: 'center'
                            }).then(() => {
                                location.reload(); // Reload the page to see the changes
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Oops...',
                                text: 'Something went wrong!',
                                position: 'center'
                            });
                        }
                    },
                    error: function (error) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Oops...',
                            text: 'Something went wrong!',
                            position: 'center'
                        });
                    }
                });
            }
        });
    });
});
        </script>
    </body>
</html>