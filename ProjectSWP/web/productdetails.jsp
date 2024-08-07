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

            .light-text {
                color: gray;
            }
            .radio-container {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
            }

            .size-group {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .availability-label, .details-label {
                border: none;
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


                            <form class="add-to-cart-form" id="addToCartForm" action="addtocart" method="get">
                                <input type="hidden" name="productID" value="${sessionScope.product.productID}"/>
                                <input type="hidden" name="productPrice" value="${sessionScope.product.salePrice}"/>
                                <span class="me-3">Size:</span><br/>
                                <div class="radio-container">
                                    <c:forEach var="sizes" items="${sessionScope.quantities}" varStatus="status">
                                        <div class="size-group">
                                            <input type="radio" name="size" id="size-${status.index}" value="${sizes.getProductCSID()}" data-quantity="${sizes.quantities - sizes.hold}" required/>
                                            <label for="size-${status.index}"> ${sizes.size} </label>
                                            <label name="quantities" class="availability-label" style="border:none;"> ${sizes.quantities - sizes.hold} available </label>
                                            <c:choose>
                                                <c:when test="${sessionScope.staff != null}">
                                                    <label name="quantities" class="details-label" style="border:none;">Quantities: ${sizes.quantities} <br> Hold: ${sizes.hold} </label>
                                                    </c:when>
                                                </c:choose>
                                        </div>
                                    </c:forEach>
                                </div>


                                <div class="alert alert-danger d-none" id="sizeError" role="alert">
                                    Please choose your size.
                                </div>
                                <br/>
                                <c:choose>
                                    <c:when test="${sessionScope.staff != null}">
                                    </c:when>
                                    <c:when test="${sessionScope.acc == null}">
                                        <button class="add-to-cart-btn">
                                            <a href="login?error=You must login before adding to cart" style="text-decoration: none; color: #fff;">Add to cart</a>
                                        </button>


                                        <div class="mt-2">
                                            <button class="btn btn-primary">
                                                <a href="LoadFeedbacks?productID=${sessionScope.product.productID}&page=1&filter=''" style="text-decoration: none; color: #fff;">
                                                    View feedbacks <i class="fas fa-comments"></i>
                                                </a>
                                            </button>
                                            <a href="login?error=You must login first" class="wishlist-btn">
                                                <img src="images/heart-regular.svg" alt="Add to wishlist"/>
                                            </a>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <label for="quantity" class="me-3">Quantity: </label>
                                        <div class="quantity-wrapper">
                                            <button type="button" class="quantity-btn minus" onclick="decreaseQuantity()">
                                                <img src="./images/minus-solid.svg" alt="" class="idBtn" />
                                            </button>
                                            <input type="text" id="quantity" name="quantity" value="1"  class="amount-input"/>
                                            <button type="button" class="quantity-btn plus" onclick="increaseQuantity()">
                                                <img src="./images/plus-solid.svg" alt="" class="idBtn" />
                                            </button>
                                        </div>
                                        <br /><br />
                                        <button type="button" class="add-to-cart-btn" id="addToCartButton">Add to cart</button>


                                        <c:set var="isProductInWishlist" value="${false}"/>
                                        <c:forEach var="item" items="${sessionScope.wishlistProduct}">
                                            <c:if test="${item.productID == sessionScope.product.productID}">
                                                <c:set var="isProductInWishlist" value="${true}"/>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${!isProductInWishlist}">
                                            <a id="wishlist-btn" href="#" data-action="add" data-customer-id="${sessionScope.acc.customer_id}" data-product-id="${sessionScope.product.productID}" class="wishlist-btn">
                                                <img src="images/heart-regular.svg" alt="Add to wishlist"/>
                                            </a>
                                        </c:if>
                                        <c:if test="${isProductInWishlist}">
                                            <a id="wishlist-btn" href="#" data-action="delete" data-customer-id="${sessionScope.acc.customer_id}" data-product-id="${sessionScope.product.productID}" class="wishlist-btn">
                                                <img src="images/heart-solid-red.svg" alt="Remove from wishlist"/>
                                            </a>
                                        </c:if>
                                        <div class="mt-2">
                                            <button class="btn btn-primary">
                                                <a href="LoadFeedbacks?productID=${sessionScope.product.productID}&page=1&filter=''" style="text-decoration: none; color: #fff;">
                                                    View feedbacks <i class="fas fa-comments"></i>
                                                </a>
                                            </button>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </form>



                        </div>
                    </div>
                </div>
            </div>
        </div>



        <!-- Modal Add to Cart Success -->
        <div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="successModalLabel">Notification</h5>
                        <button type="button" class="close"  data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body text-center">
                        <i class="fas fa-check-circle" style="color: green; font-size: 3rem;"></i>
                        <p class="mt-3">Add to cart successfully!</p>
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
        <script>
                                                 $(document).ready(function () {
                                                     $("#addToCartButton").click(function () {
                                                         var sizeSelected = $("input[name='size']:checked").val();
                                                         var availableQuantity = $("input[name='size']:checked").data("quantity");
                                                         var requestedQuantity = parseInt($("#quantity").val());

                                                         if (requestedQuantity < 1) {
                                                             $("#sizeError").removeClass("d-none").text("Quantity must be greater than 0.");
                                                             return;
                                                         }

                                                         if (!sizeSelected) {
                                                             // Hiển thị lỗi nếu chưa chọn size
                                                             $("#sizeError").removeClass("d-none").text("Please choose your size.");
                                                             return;
                                                         } else if (requestedQuantity > availableQuantity) {
                                                             // Hiển thị lỗi nếu số lượng yêu cầu lớn hơn số lượng có sẵn
                                                             $("#sizeError").removeClass("d-none").text("Not enough amount available.");
                                                             return;
                                                         } else {
                                                             // Ẩn lỗi nếu đã chọn size và số lượng hợp lệ
                                                             $("#sizeError").addClass("d-none");

                                                             var postData = $("#addToCartForm").serialize();
                                                             var submitUrl = $("#addToCartForm").attr("action");
                                                             $.ajax({
                                                                 type: "GET",
                                                                 url: submitUrl,
                                                                 data: postData,
                                                                 success: function (response) {
                                                                     // Hiển thị modal thông báo
                                                                     $("#successModal").modal('show');
                                                                     // Tải lại trang sau khi hiển thị modal
                                                                     $("#successModal").on('shown.bs.modal', function () {
                                                                         setTimeout(function () {
                                                                             location.reload();
                                                                         }, 700); // Đợi 2 giây trước khi tải lại trang
                                                                     });
                                                                 },
                                                                 error: function (xhr, status, error) {
                                                                     alert("Something went wrong. Please try again.");
                                                                 }
                                                             });
                                                         }
                                                     });
                                                 });

                                                 function increaseQuantity() {
                                                     var quantityField = document.getElementById("quantity");
                                                     var quantity = parseInt(quantityField.value);
                                                     if (isNaN(quantity) || quantity < 0) {
                                                         quantity = 0;
                                                     }
                                                     quantityField.value = quantity + 1;
                                                     checkQuantity();
                                                 }

                                                 function decreaseQuantity() {
                                                     var quantityField = document.getElementById("quantity");
                                                     var quantity = parseInt(quantityField.value);
                                                     if (!isNaN(quantity) && quantity > 1) {
                                                         quantityField.value = quantity - 1;
                                                     } else {
                                                         quantityField.value = 1;
                                                     }
                                                     checkQuantity();
                                                 }

                                                 function checkQuantity() {
                                                     var quantityField = document.getElementById("quantity");
                                                     var quantity = parseInt(quantityField.value);
                                                     var addToCartButton = document.getElementById("addToCartButton");
                                                     var sizeError = document.getElementById("sizeError");

                                                     if (quantity < 1) {
                                                         addToCartButton.disabled = true;
                                                         sizeError.classList.remove("d-none");
                                                         sizeError.textContent = "Quantity must be greater than 0.";
                                                     } else {
                                                         addToCartButton.disabled = false;
                                                         sizeError.classList.add("d-none");
                                                     }
                                                 }

                                                 function changeImage(subImageElement) {
                                                     var mainImage = document.getElementById('main_image');
                                                     mainImage.src = subImageElement.src;
                                                 }

                                                 document.addEventListener('DOMContentLoaded', function () {
                                                     function attachClickEvent() {
                                                         var wishlistBtn = document.getElementById('wishlist-btn');
                                                         if (wishlistBtn) {
                                                             wishlistBtn.addEventListener('click', function (event) {
                                                                 event.preventDefault();
                                                                 var action = wishlistBtn.dataset.action;
                                                                 var customerID = wishlistBtn.dataset.customerId;
                                                                 var productID = wishlistBtn.dataset.productId;

                                                                 updateWishlist(action, customerID, productID);
                                                             });
                                                         }
                                                     }

                                                     function updateWishlist(action, customerID, productID) {
                                                         var xhr = new XMLHttpRequest();
                                                         var url = 'adddeleteWishlist?action=' + action + '&customerID=' + customerID + '&productID=' + productID;

                                                         xhr.open('GET', url, true);
                                                         xhr.onreadystatechange = function () {
                                                             if (xhr.readyState === 4 && xhr.status === 200) {
                                                                 var newAction = action === 'add' ? 'delete' : 'add';
                                                                 var newImgSrc = action === 'add' ? 'images/heart-solid-red.svg' : 'images/heart-regular.svg';
                                                                 var newAltText = action === 'add' ? 'Remove from wishlist' : 'Add to wishlist';

                                                                 var wishlistBtn = document.getElementById('wishlist-btn');
                                                                 wishlistBtn.dataset.action = newAction;
                                                                 wishlistBtn.innerHTML = '<img src="' + newImgSrc + '" alt="' + newAltText + '"/>';

                                                                 attachClickEvent();
                                                             }
                                                         };
                                                         xhr.send();
                                                     }

                                                     attachClickEvent();
                                                 });

        </script>



        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/tiny-slider.js"></script>
        <script src="js/custom.js"></script>
    </body>
</html>