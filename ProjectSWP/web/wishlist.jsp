<%-- 
    Document   : wishlist
    Created on : 10 Jun 2024, 20:59:17
    Author     : dumspicy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="author" content="Untree.co">
        <link rel="shortcut icon" href="favicon.png">
        <meta name="description" content="" />
        <meta name="keywords" content="bootstrap, bootstrap4" />

        <!-- Bootstrap CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <link href="css/tiny-slider.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <link href="./css/product-details.css" rel="stylesheet" />
        <link href="css/productcss.css" rel="stylesheet">
        <style>
            .main-container{
                margin-top: 8rem;
            }
            .latest-product{
                margin-bottom: 12rem;
            }
        </style>
        <title>Wishlist</title>
        <script>
            function showError(message) {
                alert(message);
            }
        </script>
    </head>
    <body>

        <!--Include header.jsp-->
        <%@include file="./COMP/header.jsp"%>
        <c:if test="${not empty sessionScope.error}">
            <script type="text/javascript">
                // Lấy thông báo lỗi từ session scope và hiển thị nó
                var errorMessage = "${sessionScope.error}";
                showError(errorMessage);
            </script>
            <c:remove var="error" scope="session"/>
        </c:if>

        <c:if test="${empty wishlistProduct}">
            <!--latest product when no product on wishlist product list-->
            <div class="container main-container">
                <h1 class="text-dark">My Wishlist</h1>
                <p class="text-opacity-50 fs-4">0 items</p>
                <p class="text-opacity-50 fs-4">You haven't save any items to your wishlist yet. Start shopping and choose your favorite items to your wishlist.</p>
                <div class="row">
                    <div class="col-md-12 latest-product pt-3 bg-white">
                        <%@include file="./COMP/latestproductlist.jsp" %>
                    </div>
                </div>
            </div>
        </c:if>

        <c:if test="${not empty wishlistProduct }">
            <div class="container main-container">
                <h1 class="text-dark">My Wishlist</h1>
                <p id="wishlist-item-count" class="text-opacity-50 fs-4">${wishlistProduct.size()} items</p>
                <div class="row">
                    <!-- Left Column -->
                    <div class="col-md-12 bg-white mt-5 mb-5">
                        <div class="row">
                            <c:forEach var="product" items="${wishlistProduct}">
                                <div class="col-md-3 mb-3">
                                    <div class="card">
                                        <a href="productdetails?id=${product.productID}">
                                            <img src="${product.thumbnailLink}" alt="" class="card-img-top"/>
                                        </a>
                                        <div class="card-body">
                                            <a href="productdetails?id=${product.productID}">
                                                <h5 class="card-title">${product.title}</h5>
                                            </a>
                                            <p>${product.briefInformation}</p>
                                            <p class="card-text">
                                                <span class="sale-price"><fmt:formatNumber value="${product.salePrice}" pattern="###,###" /></span>
                                                <span class="list-price"><fmt:formatNumber value="${product.listPrice}" pattern="###,###" /></span>
                                            </p>
                                            <span>
                                                <a id="wishlist-btn" href="#" data-action="delete" data-customer-id="${sessionScope.acc.customer_id}" data-product-id="${sessionScope.product.productID}" class="wishlist-btn">
                                                    <img src="images/heart-solid-red.svg" alt="alt"/>
                                                </a>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 latest-product pt-3 bg-white">
                        <%@include file="./COMP/latestproductlist.jsp" %>
                    </div>
                </div>
            </div>
        </c:if>


        <!--Include footer.jsp-->
        <%@include file="./COMP/footer.jsp" %>

        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/tiny-slider.js"></script>
        <script src="js/custom.js"></script>
        <script>
                document.addEventListener('DOMContentLoaded', function () {
                    var wishlistButtons = document.querySelectorAll('#wishlist-btn');
                    wishlistButtons.forEach(function (button) {
                        button.addEventListener('click', function (event) {
                            event.preventDefault(); // Ngăn chặn hành động mặc định của thẻ a

                            // Lấy các thông tin từ thuộc tính data của thẻ a
                            var action = button.dataset.action;
                            var customerID = button.dataset.customerId;
                            var productID = button.dataset.productId;

                            // Gửi yêu cầu AJAX tới servlet
                            var xhr = new XMLHttpRequest();
                            xhr.open('GET', 'adddeleteWishlist?action=' + action + '&customerID=' + customerID + '&productID=' + productID, true);
                            xhr.onload = function () {
                                if (xhr.status == 200) {
                                    // Xử lý kết quả tùy thuộc vào action (add hoặc delete)
                                    if (action === 'delete') {
                                        // Xóa sản phẩm thành công
                                        button.closest('.col-md-3.mb-3').remove(); // Xóa sản phẩm khỏi DOM
                                        updatewishlistItemCount(xhr.responseText);
                                    }
                                } else {
                                    // Xử lý lỗi nếu có
                                    console.error('Lỗi khi gửi yêu cầu AJAX.');
                                }
                            };
                            xhr.onerror = function () {
                                // Xử lý lỗi kết nối
                                console.error('Lỗi kết nối.');
                            };
                            xhr.send();
                        });
                    });
                });
                // Hàm để cập nhật số lượng sản phẩm trong wishlist
                function updateWishlistItemCount(count) {
                    var itemCountElement = document.getElementById('wishlist-item-count');
                    if (itemCountElement) {
                        itemCountElement.textContent = count + " items";
                    }
                }

        </script>
    </body>
</html>
