<%@ page import="model.Product" %>
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
                border: none;
                transition: transform 0.2s;
            }
            .card:hover {
                transform: scale(1.05);
            }
            .card-img-top {
                width: 100%;
                height: auto;
            }
            .card-title {
                font-size: 1.1rem;
                font-weight: bold;
            }
            .card-text {
                font-size: 1rem;
            }
            .no-products-container {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100%;
            }
            .no-products {
                text-align: center;
            }
            .no-products p {
                font-size: 1.5rem;
                color: #ff0000;
            }
            .pagination-container {
                display: flex;
                justify-content: center;
                margin-top: 20px;
                width: 100%;
            }
        </style>
    </head>
    <body>
        <!-- Include Header/Navigation -->
        <%@ include file="COMP/header.jsp" %>
        <%@ include file="COMP/hero.jsp" %>

        <div class="container" style="padding-bottom: 200px">
        <div class="row">
            <!-- Filter Panel -->
            <div class="col-md-3">
                <div class="filter-panel">
                    <h3>Shop </h3>
                    <div class="categories">
                        <form id="filterForm" action="product" method="get">
                            <h4 onclick="toggleFilter(this)">Product Categories</h4>
                            <div class="filter-content">
                                <c:forEach var="category" items="${productcategory}">
                                    <label>
                                        <input type="checkbox" name="category" value="${category.productCL}" ${category.checked ? 'checked' : ''}>
                                        ${category.name}
                                    </label><br>
                                </c:forEach>
                            </div>
                            <h4 onclick="toggleFilter(this)">Shop by price</h4>
                            <div class="filter-content">
                                <label>
                                    <input type="radio" name="price" id="price-under-1000000" value="under-1000000" ${param.price == 'under-1000000' ? 'checked' : ''}> Under 1,000,000₫
                                </label><br>
                                <label>
                                    <input type="radio" name="price" id="price-1000000-2000000" value="1000000-2000000" ${param.price == '1000000-2000000' ? 'checked' : ''}> 1,000,000₫ - 2,000,000₫
                                </label><br>
                                <label>
                                    <input type="radio" name="price" id="price-2000001-4999999" value="2000001-4999999" ${param.price == '2000001-4999999' ? 'checked' : ''}> 2,000,001₫ - 4,999,999₫
                                </label><br>
                                <label>
                                    <input type="radio" name="price" id="price-over-5000000" value="over-5000000" ${param.price == 'over-5000000' ? 'checked' : ''}> Over 5,000,000₫
                                </label>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Product List -->
            <div class="col-md-9">
                <div class="product-list" id="productList">
                    <!-- Content loaded via AJAX -->
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
        function toggleFilter(element) {
            const filterContent = element.nextElementSibling;
            if (filterContent.style.display === "none" || filterContent.style.display === "") {
                filterContent.style.display = "block";
            } else {
                filterContent.style.display = "none";
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
            $('#filterForm input[type="checkbox"]').change(function () {
                var url = $('#filterForm').attr('action') + '?' + $('#filterForm').serialize();
                loadProducts(url);
            });

            $('#filterForm input[type="radio"]').change(function () {
                var url = $('#filterForm').attr('action') + '?' + $('#filterForm').serialize();
                loadProducts(url);
            });

            $(document).on('click', '.pagination a.page-link', function (e) {
                e.preventDefault();
                var url = $(this).attr('href');
                loadProducts(url);
            });
        });
    </script>
</body>
</html>