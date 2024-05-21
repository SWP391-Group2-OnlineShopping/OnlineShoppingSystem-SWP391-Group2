<%@ page import="model.Products" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Shop</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <link href="css/tiny-slider.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <style>
            .categories {
                padding: 20px;
                background-color: #f9f9f9;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                max-width: 300px;
                margin: 20px auto;
            }

            .filter-heading {
                font-size: 18px;
                color: #333;
                cursor: pointer;
                margin-bottom: 10px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .filter-content {
                margin-bottom: 20px;
                display: none; /* Hide by default */
            }

            .filter-label {
                display: flex;
                align-items: center;
                padding: 10px;
                background-color: #fff;
                border: 1px solid #ddd;
                border-radius: 4px;
                margin-bottom: 5px;
                transition: background-color 0.3s, border-color 0.3s;
            }

            .filter-label:hover {
                background-color: #f1f1f1;
                border-color: #ccc;
            }

            input[type="checkbox"]:checked + label,
            input[type="radio"]:checked + label {
                background-color: #e0f7fa;
                border-color: #26a69a;
            }

            .checkbox-wrapper-20 {
                --slider-height: 8px;
                --slider-width: calc(var(--slider-height) * 4);
                --switch-height: calc(var(--slider-height) * 3);
                --switch-width: var(--switch-height);
                --switch-shift: var(--slider-height);
                --transition: all 0.2s ease;

                --switch-on-color: #ef0460;
                --slider-on-color: #fc5d9b;

                --switch-off-color: #eeeeee;
                --slider-off-color: #c5c5c5;
            }

            .checkbox-wrapper-20 .switch {
                display: block;
            }

            .checkbox-wrapper-20 .switch .slider {
                position: relative;
                display: inline-block;
                height: var(--slider-height);
                width: var(--slider-width);
                border-radius: var(--slider-height);
                cursor: pointer;
                background: var(--slider-off-color);
                transition: var(--transition);
            }

            .checkbox-wrapper-20 .switch .slider:after {
                background: var(--switch-off-color);
                position: absolute;
                left: calc(-1 * var(--switch-shift));
                top: calc((var(--slider-height) - var(--switch-height)) / 2);
                display: block;
                width: var(--switch-height);
                height: var(--switch-width);
                border-radius: 50%;
                box-shadow: 0px 2px 2px rgba(0, 0, 0, .2);
                content: '';
                transition: var(--transition);
            }

            .checkbox-wrapper-20 .switch label {
                margin-right: 7px;
            }

            .checkbox-wrapper-20 .switch .input {
                display: none;
            }

            .checkbox-wrapper-20 .switch .input ~ .label {
                margin-left: var(--slider-height);
            }

            .checkbox-wrapper-20 .switch .input:checked ~ .slider:after {
                left: calc(var(--slider-width) - var(--switch-width) + var(--switch-shift));
            }

            .checkbox-wrapper-20 .switch .input:checked ~ .slider {
                background: var(--slider-on-color);
            }

            .checkbox-wrapper-20 .switch .input:checked ~ .slider:after {
                background: var(--switch-on-color);
            }

            /* Styling for radio buttons */

            .radio-wrapper-20 {
                display: flex;
                align-items: center;
                --radio-size: 20px;
                --radio-border-width: 2px;
                --radio-color: #fc5d9b;
                --radio-background: #fff;
                --radio-border-color: #ddd;
                --transition: all 0.2s ease;
            }

            .radio-wrapper-20 .radio-switch {
                position: relative;
                display: inline-block;
                margin-right: 10px;
            }

            .radio-wrapper-20 .radio-switch .radio-input {
                display: none;
            }

            .radio-wrapper-20 .radio-switch .radio-slider {
                position: relative;
                display: inline-block;
                height: var(--radio-size);
                width: var(--radio-size);
                border-radius: 50%;
                background: var(--radio-background);
                border: var(--radio-border-width) solid var(--radio-border-color);
                cursor: pointer;
                transition: var(--transition);
            }

            .radio-wrapper-20 .radio-switch .radio-slider:after {
                content: '';
                position: absolute;
                top: 50%;
                left: 50%;
                width: calc(var(--radio-size) / 2);
                height: calc(var(--radio-size) / 2);
                background: var(--radio-color);
                border-radius: 50%;
                transform: translate(-50%, -50%) scale(0);
                transition: var(--transition);
            }

            .radio-wrapper-20 .radio-switch .radio-input:checked + .radio-slider {
                border-color: var(--radio-color);
            }

            .radio-wrapper-20 .radio-switch .radio-input:checked + .radio-slider:after {
                transform: translate(-50%, -50%) scale(1);
            }

            .toggle-icon {
                width: 16px;
                height: 16px;
                transition: transform 0.3s ease;
            }

            .filter-heading.collapsed .toggle-icon {
                transform: rotate(180deg);
            }

            @media (max-width: 600px) {
                .categories {
                    max-width: 100%;
                }
            }

            .filter-panel h4 {
                cursor: pointer;
            }

            .filter-panel .filter-content {
                display: none;
                padding-left: 10px;
            }

            .filter-panel input[type="checkbox"] {
                appearance: none;
                -webkit-appearance: none;
                width: 18px;
                height: 18px;
                border: 1px solid #000;
                border-radius: 3px;
                outline: none;
                cursor: pointer;
            }

            .filter-panel input[type="checkbox"]:checked {
                background-color: #000;
                color: #fff;
            }

            .filter-panel input[type="checkbox"]:checked:before {
                content: "\2714";
                display: block;
                text-align: center;
                color: #fff;
                font-size: 14px;
            }

            .card {
                width: 301.98px; /* Đặt chiều rộng cố định */
                margin: 10px;
                border: none;
                transition: transform 0.2s;
            }

            .card:hover {
                transform: scale(1.05);
            }

            .card-img-top {
                width: 100%;
                height: 301.98px;
                object-fit: contain;
                background-color: #f8f8f8;
            }

            .card-body {
                flex: 1;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                padding: 15px;
            }

            .card-title {
                font-size: 1.1rem;
                font-weight: bold;
                text-align: center;
            }

            .card-text {
                font-size: 1rem;
                text-align: center;
            }

            .no-products-container {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100%;
            }



            .pagination-container {
                display: flex;
                justify-content: center;
                margin-top: 20px;
                width: 100%;
            }

            .sale-price {
                color: #d9534f;
                font-weight: bold;
                font-size: 1.2em;
            }

            .list-price {
                color: #6c757d;
                text-decoration: line-through;
                margin-left: 10px;
                font-size: 1em;
            }
            .product-grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 10px;
                min-height: 50vh; /* Đảm bảo chiều cao tối thiểu */
                width: 100%; /* Đảm bảo chiều rộng */
            }

            .product-grid .card {
                margin: 0;
            }

            .empty-container {
                grid-column: span 3; /* Đảm bảo container chiếm toàn bộ chiều rộng */
                height: 50vh; /* Đảm bảo chiều cao */
                background-color: transparent; /* Chỉ để đảm bảo không bị thu hẹp */
            }
        </style>
    </head>
    <body>
        <c:set var="page" value="shop" />
        <!-- Include Header/Navigation -->
        <%@ include file="COMP/header.jsp" %>
        <!-- Include Banner slider -->
        <%@ include file="COMP\testimonial.jsp" %>
        <div class="container" style="padding-bottom: 200px">
            <div class="row">
                <!-- Filter Panel -->
                <div class="col-md-3">
                    <div class="filter-panel">
                        <h3>Shop</h3>
                        <div class="categories">
                            <form id="filterForm" action="product" method="get" onsubmit="return checkForm();">
                                <h4 class="filter-heading" onclick="toggleFilter(this)">
                                    Brand <img src="images/chevron-down-solid.svg" class="toggle-icon" alt="toggle icon">
                                </h4>
                                <div class="filter-content">
                                    <c:forEach var="category" items="${productcategory}">
                                        <label class="filter-label">
                                            <div class="checkbox-wrapper-20">
                                                <div class="switch">
                                                    <input id="category-${category.productCL}" class="input" type="checkbox" name="category" value="${category.productCL}" ${category.checked ? 'checked' : ''} />
                                                    <label for="category-${category.productCL}" class="slider"></label>
                                                </div>
                                                ${category.name}
                                            </div>
                                        </label>
                                    </c:forEach>
                                </div>
                                <h4 class="filter-heading" onclick="toggleFilter(this)">
                                    Shop by price <img src="images/chevron-down-solid.svg" class="toggle-icon" alt="toggle icon">
                                </h4>
                                <div class="filter-content">
                                    <label class="filter-label">
                                        <div class="radio-wrapper-20">
                                            <div class="radio-switch">
                                                <input id="price-under-1000000" class="radio-input" type="radio" name="price" value="under-1000000" ${param.price == 'under-1000000' ? 'checked' : ''} onclick="toggleRadio(this)" />
                                                <label for="price-under-1000000" class="radio-slider"></label>
                                            </div>
                                            Under 1,000,000₫
                                        </div>
                                    </label>
                                    <label class="filter-label">
                                        <div class="radio-wrapper-20">
                                            <div class="radio-switch">
                                                <input id="price-1000000-2000000" class="radio-input" type="radio" name="price" value="1000000-2000000" ${param.price == '1000000-2000000' ? 'checked' : ''} onclick="toggleRadio(this)" />
                                                <label for="price-1000000-2000000" class="radio-slider"></label>
                                            </div>
                                            1,000,000₫ - 2,000,000₫
                                        </div>
                                    </label>
                                    <label class="filter-label">
                                        <div class="radio-wrapper-20">
                                            <div class="radio-switch">
                                                <input id="price-2000001-4999999" class="radio-input" type="radio" name="price" value="2000001-4999999" ${param.price == '2000001-4999999' ? 'checked' : ''} onclick="toggleRadio(this)" />
                                                <label for="price-2000001-4999999" class="radio-slider"></label>
                                            </div>
                                            2,000,001₫ - 4,999,999₫
                                        </div>
                                    </label>
                                    <label class="filter-label">
                                        <div class="radio-wrapper-20">
                                            <div class="radio-switch">
                                                <input id="price-over-5000000" class="radio-input" type="radio" name="price" value="over-5000000" ${param.price == 'over-5000000' ? 'checked' : ''} onclick="toggleRadio(this)" />
                                                <label for="price-over-5000000" class="radio-slider"></label>
                                            </div>
                                            Over 5,000,000₫
                                        </div>
                                    </label>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>

                <!-- Product List -->
                <div class="col-md-9">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h3 class="mb-0">Products</h3>
                        <div class="d-flex justify-content-end mb-4">
                            <label for="sortOptions" class="mr-2">Sort By:</label>
                            <select id="sortOptions" class="form-control w-auto" onchange="applySort(this.value)">
                                <option value="newest">Newest</option>
                                <option value="price-asc">Price: Low-High</option>
                                <option value="price-desc">Price: High-Low</option>
                                <option value="name-asc">Name: A-Z</option>
                                <option value="name-desc">Name: Z-A</option>
                            </select>
                        </div>
                    </div>
                    <div class="product-list" id="productList">
                        <jsp:include page="product-list.jsp" />
                    </div>
                </div>
            </div>
        </div>

        <!-- Include Footer -->
        <%@ include file="COMP/footer.jsp" %> 

        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/tiny-slider.js"></script>
        <script src="js/custom.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script>
                                let lastChecked = null;

                                function toggleRadio(radio) {
                                    if (radio === lastChecked) {
                                        radio.checked = false;
                                        lastChecked = null;
                                        document.getElementById('defaultPrice').value = ''; // Đặt giá trị mặc định
                                    } else {
                                        lastChecked = radio;
                                        document.getElementById('defaultPrice').value = ''; // Xóa giá trị mặc định khi có giá trị mới
                                    }
                                }

                                function checkForm() {
                                    const radios = document.querySelectorAll('input[type="radio"][name="price"]');
                                    let isAnyChecked = false;

                                    radios.forEach(radio => {
                                        if (radio.checked) {
                                            isAnyChecked = true;
                                        }
                                    });

                                    if (!isAnyChecked) {
                                        document.getElementById('defaultPrice').value = '';
                                    }

                                    return true; // Cho phép gửi form
                                }
                                function toggleFilter(element) {
                                    const content = element.nextElementSibling;
                                    const icon = element.querySelector('.toggle-icon');

                                    if (content.style.display === "none" || content.style.display === "") {
                                        content.style.display = "block";
                                        icon.src = "images/chevron-up-solid.svg";
                                    } else {
                                        content.style.display = "none";
                                        icon.src = "images/chevron-down-solid.svg";
                                    }
                                }
                                function loadProducts(url) {
                                    $.ajax({
                                        url: url,
                                        method: 'GET',
                                        dataType: 'html',
                                        headers: {
                                            'X-Requested-With': 'XMLHttpRequest'
                                        },
                                        success: function (response) {
                                            $('#productList').html(response);
                                        },
                                        error: function (xhr, status, error) {
                                            console.error('Error loading products:', status, error);
                                        }
                                    });
                                }

                                $(document).ready(function () {
                                    $('#filterForm input[type="checkbox"], #filterForm input[type="radio"]').change(function () {
                                        var url = $('#filterForm').attr('action') + '?' + $('#filterForm').serialize();
                                        loadProducts(url);
                                    });

                                    $('#sortOptions').change(function () {
                                        var url = $('#filterForm').attr('action') + '?' + $('#filterForm').serialize() + '&sort=' + $(this).val();
                                        loadProducts(url);
                                    });

                                    $(document).on('click', '.pagination a.page-link', function (e) {
                                        e.preventDefault();
                                        var url = $(this).attr('href');
                                        loadProducts(url);
                                    });
                                });

                                function applySort(sortBy) {
                                    var url = $('#filterForm').attr('action') + '?' + $('#filterForm').serialize() + '&sort=' + sortBy;
                                    loadProducts(url);
                                }
        </script>
    </body>
</html>