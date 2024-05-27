<%-- 
    Document   : productdetails
    Created on : 20 May 2024, 11:58:37
    Author     : dumspicy
--%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="author" content="Untree.co" />
        <link rel="shortcut icon" href="favicon.png" />

        <meta name="description" content="" />
        <meta name="keywords" content="bootstrap, bootstrap4" />

        <!-- Bootstrap CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet"/>
        <link href="css/style.css" rel="stylesheet" />
        <link href="./css/product-details.css" rel="stylesheet" />
        <link href="css/productcss.css" rel="stylesheet">
        <style>
            .wishlist-btn{
                display: inline-block;
                border: none;
                outline: none;
                padding: 10px 10px;
                border-radius: 5px;
            }
        </style>
        <title>JSP Page</title>
    </head>
    <body>
        <!--========== Include header ========-->
        <%@include file="./COMP/header.jsp" %>

        <!-- ======= Start static link  ======= -->
        <div class="static-link pt-5 px-5" style="margin-top: 150px;">
            <div class="container">
                <div class="col-lg-12 align-items-center bg-light p-2">
                    <a href="homepage">Home</a> <span> > </span>
                    <a href="product">Shop</a> <span>   > </span>
                    <p style="width: 30%; display: inline;">${sessionScope.product.title}</p>
                </div>
            </div>
        </div>

        <!-- ======= End static link ======= -->

        <!--======== Start Category ========-->
        <div class="product-category pt-5 px-5">
            <div class="w-100">

                <nav class="category-nav">
                    <form>
                        <ul class="category-list">
                            <li class="category-list-item"><a href="#" class="category">Brand</a>
                                <ul class="category-sublist">
                                    <c:forEach var="category" items="${sessionScope.listCategories}">
                                        <li class="category-sublist-item"><a href="productcategory?id=${category.productCL}" class="category category-item">${category.name}</a></li>
                                        </c:forEach>
                                </ul>
                            </li>
                        </ul>
                    </form>
                </nav>
            </div>
        </div>
        <!--======== End Category =========-->

        <!-- ======= Start product detail image ======= -->
        <div class="product-details-top pt-5">
            <div class="container">
                <div class="row product-details_inner py-3">
                    <div class="col-lg-6 product-details-image">
                        <img src="${sessionScope.product.thumbnailLink}" alt="" class="product-image" id="main_image"/>
                        <div class="row sub-image-list mt-3">
                            <c:forEach var="subImage" items="${sessionScope.subImages}">
                                <div class="col-lg-2 sub-image-item">
                                    <img
                                        src="${subImage}"
                                        alt="alt"
                                        id="sub-image"
                                        onmouseover="changeImage(this)"
                                        style="width: 100%"
                                        />
                                </div>
                            </c:forEach>
                        </div>

                    </div>

                    <div class="col-lg-5 offset-lg-1">
                        <div class="product-details_text">
                            <h3 class="product-name mb-3 fw-bold">${sessionScope.product.title}</h3>
                            <h4 class="product-category fw-light">${sessionScope.productCategory.name}</h4> <!--later-->
                            <h3 class="product-listPrice fw-light text-decoration-line-through fs-5 d-inline"><fmt:formatNumber value="${sessionScope.product.listPrice}" pattern="###,###" /></h3>
                            <h2 class="product-salePrice d-inline ms-5 mb-5"><fmt:formatNumber value="${sessionScope.product.salePrice}" pattern="###,###" /></h2>
                            <p class="product-brief mt-3">
                                ${sessionScope.product.briefInformation}
                            </p>
                            <br/>
                            <form class="add-to-cart-form" action="cartdetail" method="get">
                                <input type="hidden" name="productID" value="${sessionScope.product.productID}"/>
                                <input type="hidden" name="productPrice" value="${sessionScope.product.salePrice}"/>
                                <span class="me-3">Size:</span><br/>
                                <div class="radio-container">
                                    <c:forEach var="sizes" items="${sessionScope.sizes}" varStatus="status">
                                        <input type="radio" name="size" id="size-${status.index}" value="${sizes.size}" required/>
                                        <label for="size-${status.index}"> ${sizes.size} </label>
                                    </c:forEach>
                                </div>
                                <br/>
                                <label for="quantity" class="me-3">Quantity: </label>
                                <div class="quantity-wrapper">
                                    <button type="button" class="quantity-btn minus" onclick="decreaseQuantity()">
                                        <img src="./images/minus-solid.svg" alt="" class="idBtn" />
                                    </button>
                                    <input type="text" id="quantity" name="quantity" value="1" readonly class="amount-input"/>
                                    <button type="button" class="quantity-btn plus" onclick="increaseQuantity()">
                                        <img src="./images/plus-solid.svg" alt="" class="idBtn" />
                                    </button>
                                </div>
                                <br /><br />
                                <c:choose>
                                    <c:when test="${sessionScope.staff != null}">
                                    </c:when>
                                    <c:when test="${sessionScope.acc == null}">
                                        <button class="add-to-cart-btn">
                                            <a href="login?error=You must login before adding to cart" style="text-decoration: none; color: #fff;">Add to cart</a>
                                        </button>
                                        <button class="wishlist-btn">
                                            <a href=""><img src="images/heart-regular.svg" alt="alt"/></a>
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="submit" class="add-to-cart-btn">
                                            Add to cart
                                        </button>

                                        <button class="wishlist-btn">
                                            <a href=""><img src="images/heart-regular.svg" alt="alt"/></a>
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ====== End Product detail Image ====== -->

        <!-- ====== Start Recommended Product ======== -->
        <div class="rec-product-area pt-3">
            <div class="container">
                <div class="row rec-product-inner p-3">
                    <%@include file="COMP/latestproductlist.jsp" %>
                </div>

            </div>
        </div>

        <!-- ====== End Recommended Product =========== -->

        <!-- ====== Start Product description ========= -->
        <div class="product-desc-area pt-3">
            <div class="container">
                <div class="row product-desc-inner">
                    <div class="col-lg-12 product-desc">
                        <h2 class="product-desc-title m-3 p-3">Product Description</h2>
                        <p class="desc p-3">
                            ${sessionScope.product.description}
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <!-- ======= End Product description ========= -->

        <!--========== Include footer ========-->
        <%@include file="./COMP/footer.jsp" %>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/tiny-slider.js"></script>
        <script src="js/custom.js"></script>
        <script>
                                        function increaseQuantity() {
                                            var quantityField = document.getElementById("quantity");
                                            var quantity = parseInt(quantityField.value);
                                            quantityField.value = quantity + 1;
                                        }

                                        function decreaseQuantity() {
                                            var quantityField = document.getElementById("quantity");
                                            var quantity = parseInt(quantityField.value);
                                            if (quantity > 1) {
                                                quantityField.value = quantity - 1;
                                            }
                                        }

                                        function changeImage(subImageElement) {
                                            var mainImage = document.getElementById('main_image');
                                            mainImage.src = subImageElement.src;
                                        }
        </script>
    </body>
</html>
