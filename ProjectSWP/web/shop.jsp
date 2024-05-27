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
        <link href="css/productcss.css" rel="stylesheet">
    </head>
    <body>
        <c:set var="page" value="shop" />
        <!-- Include Header/Navigation -->
        <%@ include file="COMP/header.jsp" %>
        <div class="container" style="padding-top: 110px; padding-bottom: 200px">
            <div class="row">
                <!-- Url button <button id="generateUrlButton" class="btn btn-primary">Generate URL</button> -->

                <!-- Filter Panel -->
                <div class="col-md-3">
                    <div class="filter-panel">
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
                                    <input type="hidden" id="defaultPrice" value="" />
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
                                <option value="all" sellected="">All</option>
                                <option value="newest" >Newest</option>
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
                                        document.getElementById('defaultPrice').value = '';
                                        document.querySelectorAll('input[name="price"]').forEach((r) => r.checked = false);
                                        updateProducts();
                                    } else {
                                        lastChecked = radio;
                                        document.getElementById('defaultPrice').value = '';
                                        updateProducts();
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

                                    return true;
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

                                function updateProducts() {
                                    var searchKeyword = $('#searchInput').val();
                                    var sortBy = $('#sortOptions').val();
                                    var url = $('#filterForm').attr('action') + '?' + $('#filterForm').serialize();

                                    if (sortBy) {
                                        url += '&sort=' + encodeURIComponent(sortBy);
                                    }

                                    if (searchKeyword) {
                                        url += '&search=' + encodeURIComponent(searchKeyword);
                                    } else {
                                        loadProducts(url);
                                    }
                                }


                                $(document).ready(function () {

                                    $('#filterForm input[type="checkbox"], #filterForm input[type="radio"]').change(function () {
                                        updateProducts();
                                    });

                                    $('#sortOptions').change(function () {
                                        updateProducts();
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

                                function generateUrl() {
                                    var baseUrl = window.location.origin + window.location.pathname;
                                    var queryParams = $('#filterForm').serialize();
                                    var sortOption = $('#sortOptions').val();
                                    if (sortOption) {
                                        queryParams += '&sort=' + sortOption;
                                    }
                                    var fullUrl = baseUrl + '?' + queryParams;
                                    alert('Shareable URL: ' + fullUrl);
                                }

                                $(document).ready(function () {
                                    $('#generateUrlButton').click(function () {
                                        generateUrl();
                                    });
                                });
        </script>
    </body>
</html>
