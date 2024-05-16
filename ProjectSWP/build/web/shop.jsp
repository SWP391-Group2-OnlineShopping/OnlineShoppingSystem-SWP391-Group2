<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
<<<<<<< HEAD
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
        </style>
    </head>
    <body>
        <c:set var="page" value="shop" />
        <!-- Include Header/Navigation -->
        <%@ include file="COMP/header.jsp" %>
        <%@ include file="COMP/hero.jsp" %>
=======
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="author" content="Untree.co">
        <link rel="shortcut icon" href="favicon.png">
>>>>>>> origin/HoangTienDung

<<<<<<< HEAD
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
                                            <input type="checkbox" name="category" value="${category.productCL}" onchange="this.form.submit()" ${category.checked ? 'checked' : ''}>
                                            ${category.name}
                                        </label><br>
                                    </c:forEach>
                                </div>
                                <h4 onclick="toggleFilter(this)">Shop by price</h4>
                                <div class="filter-content">
                                    <label>
                                        <input type="checkbox" name="price" value="under-1000000" onchange="submitPriceFilter(this)" ${param.price == 'under-1000000' ? 'checked' : ''}> Under 1,000,000₫
                                    </label><br>
                                    <label>
                                        <input type="checkbox" name="price" value="1000000-2000000" onchange="submitPriceFilter(this)" ${param.price == '1000000-2000000' ? 'checked' : ''}> 1,000,000₫ - 2,000,000₫
                                    </label><br>
                                    <label>
                                        <input type="checkbox" name="price" value="2000001-4999999" onchange="submitPriceFilter(this)" ${param.price == '2000001-4999999' ? 'checked' : ''}> 2,000,001₫ - 4,999,999₫
                                    </label><br>
                                    <label>
                                        <input type="checkbox" name="price" value="over-5000000" onchange="submitPriceFilter(this)" ${param.price == 'over-5000000' ? 'checked' : ''}> Over 5,000,000₫
                                    </label>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
=======
        <meta name="description" content="" />
        <meta name="keywords" content="bootstrap, bootstrap4" />
>>>>>>> origin/HoangTienDung

<<<<<<< HEAD
                <!-- Product List -->
                <div class="col-md-9">
                    <div class="product-list" id="productList">
                        <c:if test="${not empty product}">
                            <div class="row">
                                <c:forEach var="product" items="${product}" varStatus="status">
                                    <div class="col-md-4 mb-4">
                                        <div class="card">
                                            <img class="card-img-top" src="images/sneaker.png" alt="${product.title}">
                                            <div class="card-body text-center">
                                                <h5 class="card-title">${product.title}</h5>
                                                <p class="card-text text-danger">${product.formattedPrice}</p>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>
                        <c:if test="${empty product}">
                            <div class="no-products">
                                <p>No products found.</p>
                            </div>
                        </c:if>
                    </div>
=======
        <!-- Bootstrap CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <link href="css/tiny-slider.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <title>Furni Free Bootstrap 5 Template for Furniture and Interior Design Websites by Untree.co </title>
    </head>
>>>>>>> origin/HoangTienDung

<<<<<<< HEAD
                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <nav aria-label="Page navigation" class="text-center">
                            <ul class="pagination justify-content-center">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="product?page=${currentPage - 1}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="product?page=${i}">${i}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="product?page=${currentPage + 1}" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </c:if>
                </div>
            </div>
        </div>
=======
    <body>
>>>>>>> origin/HoangTienDung

<<<<<<< HEAD
        <!-- Include Footer -->
        <%@ include file="COMP/footer.jsp" %> 
=======
        <!-- Include Header/Navigation -->
        <%@ include file="COMP\header.jsp" %>
>>>>>>> origin/HoangTienDung

<<<<<<< HEAD
        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/tiny-slider.js"></script>
        <script src="js/custom.js"></script>
        <script>
                                            function toggleFilter(element) {
                                                const filterContent = element.nextElementSibling;
                                                if (filterContent.style.display === "none" || filterContent.style.display === "") {
                                                    filterContent.style.display = "block";
                                                } else {
                                                    filterContent.style.display = "none";
                                                }
                                            }

                                            function submitPriceFilter(element) {
                                                const form = document.getElementById('filterForm');
                                                form.submit();
                                            }
        </script>
    </body>
=======
        <%@ include file="COMP\hero.jsp" %>



        <div class="untree_co-section product-section before-footer-section">
            <div class="container">
                <div class="row">

                    <!-- Start Column 1 -->
                    <div class="col-12 col-md-4 col-lg-3 mb-5">
                        <a class="product-item" href="#">
                            <img src="images/product-3.png" class="img-fluid product-thumbnail">
                            <h3 class="product-title">Nordic Chair</h3>
                            <strong class="product-price">$50.00</strong>

                            <span class="icon-cross">
                                <img src="images/cross.svg" class="img-fluid">
                            </span>
                        </a>
                    </div> 
                    <!-- End Column 1 -->

                    <!-- Start Column 2 -->
                    <div class="col-12 col-md-4 col-lg-3 mb-5">
                        <a class="product-item" href="#">
                            <img src="images/product-1.png" class="img-fluid product-thumbnail">
                            <h3 class="product-title">Nordic Chair</h3>
                            <strong class="product-price">$50.00</strong>

                            <span class="icon-cross">
                                <img src="images/cross.svg" class="img-fluid">
                            </span>
                        </a>
                    </div> 
                    <!-- End Column 2 -->

                    <!-- Start Column 3 -->
                    <div class="col-12 col-md-4 col-lg-3 mb-5">
                        <a class="product-item" href="#">
                            <img src="images/product-2.png" class="img-fluid product-thumbnail">
                            <h3 class="product-title">Kruzo Aero Chair</h3>
                            <strong class="product-price">$78.00</strong>

                            <span class="icon-cross">
                                <img src="images/cross.svg" class="img-fluid">
                            </span>
                        </a>
                    </div>
                    <!-- End Column 3 -->

                    <!-- Start Column 4 -->
                    <div class="col-12 col-md-4 col-lg-3 mb-5">
                        <a class="product-item" href="#">
                            <img src="images/product-3.png" class="img-fluid product-thumbnail">
                            <h3 class="product-title">Ergonomic Chair</h3>
                            <strong class="product-price">$43.00</strong>

                            <span class="icon-cross">
                                <img src="images/cross.svg" class="img-fluid">
                            </span>
                        </a>
                    </div>
                    <!-- End Column 4 -->


                    <!-- Start Column 1 -->
                    <div class="col-12 col-md-4 col-lg-3 mb-5">
                        <a class="product-item" href="#">
                            <img src="images/product-3.png" class="img-fluid product-thumbnail">
                            <h3 class="product-title">Nordic Chair</h3>
                            <strong class="product-price">$50.00</strong>

                            <span class="icon-cross">
                                <img src="images/cross.svg" class="img-fluid">
                            </span>
                        </a>
                    </div> 
                    <!-- End Column 1 -->

                    <!-- Start Column 2 -->
                    <div class="col-12 col-md-4 col-lg-3 mb-5">
                        <a class="product-item" href="#">
                            <img src="images/product-1.png" class="img-fluid product-thumbnail">
                            <h3 class="product-title">Nordic Chair</h3>
                            <strong class="product-price">$50.00</strong>

                            <span class="icon-cross">
                                <img src="images/cross.svg" class="img-fluid">
                            </span>
                        </a>
                    </div> 
                    <!-- End Column 2 -->

                    <!-- Start Column 3 -->
                    <div class="col-12 col-md-4 col-lg-3 mb-5">
                        <a class="product-item" href="#">
                            <img src="images/product-2.png" class="img-fluid product-thumbnail">
                            <h3 class="product-title">Kruzo Aero Chair</h3>
                            <strong class="product-price">$78.00</strong>

                            <span class="icon-cross">
                                <img src="images/cross.svg" class="img-fluid">
                            </span>
                        </a>
                    </div>
                    <!-- End Column 3 -->

                    <!-- Start Column 4 -->
                    <div class="col-12 col-md-4 col-lg-3 mb-5">
                        <a class="product-item" href="#">
                            <img src="images/product-3.png" class="img-fluid product-thumbnail">
                            <h3 class="product-title">Ergonomic Chair</h3>
                            <strong class="product-price">$43.00</strong>

                            <span class="icon-cross">
                                <img src="images/cross.svg" class="img-fluid">
                            </span>
                        </a>
                    </div>
                    <!-- End Column 4 -->

                </div>
            </div>
        </div>


        <!-- Include Header/Navigation -->
        <%@ include file="COMP\footer.jsp" %>	


        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/tiny-slider.js"></script>
        <script src="js/custom.js"></script>
    </body>

>>>>>>> origin/HoangTienDung
</html>
