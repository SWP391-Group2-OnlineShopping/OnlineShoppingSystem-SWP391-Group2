<%-- 
    Document   : cart
    Created on : May 10, 2024, 3:31:17 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
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
        <link href="css/productcss.css" rel="stylesheet"/>
        <style>
            .product-tile{
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            td.produc-name h2{
                color: #CE4B40;
            }
        </style>
    </head>

    <body>

        <!-- Include Header/Navigation -->
        <%@ include file="COMP\header.jsp" %>

        <div class="untree_co-section before-footer-section">
            <div class="container">
                <div class="row bg-light p-2">
                    <div class="col-md-12">
                        <a href="homepage">Home</a> <span> > </span>
                        <a href="product">Shop</a> <span>  > </span>
                        <a href="#">Shopping Cart</a>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${cart.getItems() == null}">
                        <h3 class="pt-3">Your Shopping Cart is empty</h3>
                        <button class="btn btn-black btn-sm btn-block"><a href="product" class="text-white">Choose More Product</a></button>
                    </c:when>
                    <c:otherwise>
                        <div class="row mb-5">
                            <div class="col-md-12" method="post" action="">
                                <div class="site-blocks-table">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th class="product-thumbnail">Image</th>
                                                <th class="product-name">Product</th>
                                                <th class="product-size">Size</th>
                                                <th class="product-price">Price</th>
                                                <th class="product-quantity">Quantity</th>
                                                <th class="product-total">Total</th>
                                                <!--<th class="choose-product">Choose</th>-->
                                                <th class="product-remove">Remove</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="cartItem" items="${cart.getItems()}">
                                                <tr>
                                                    <td class="product-thumbnail">
                                                        <img src="${cartItem.getProduct().getThumbnailLink()}" alt="Image" class="img-fluid">
                                                    </td>
                                                    <td class="product-name">
                                                        <a href="productdetails?id=${cartItem.getProduct().getProductID()}"><h2 class="h5" style="color: #CE4B40;">${cartItem.getProduct().getTitle()}</h2></a>
                                                    </td>
                                                    <td class="product-size">
                                                        <h2 class="h5 text-black">${cartItem.size}</h2>
                                                    </td>
                                                    <td><h6 class="text-black"><fmt:formatNumber value="${cartItem.getProduct().getSalePrice()}" pattern="###,###" /></h6></td>
                                                    <td>
                                                        <div class="input-group mb-3 d-flex align-items-center quantity-container" style="max-width: 120px;">
                                                            <div class="input-group-prepend">
                                                                <button class="btn btn-outline-black decrease" type="button"><a href="updatePrice?productId=${cartItem.getProduct().getProductID()}&size=${cartItem.size}&quantity=${cartItem.getQuantity()}&option=Decrease">&minus;</a></button>
                                                            </div>
                                                            <input type="text" class="form-control text-center quantity-amount" value="${cartItem.getQuantity()}" placeholder="" aria-label="Example text with button addon" aria-describedby="button-addon1" readonly>
                                                            <div class="input-group-append">
                                                                <button class="btn btn-outline-black increase" type="button"><a href="updatePrice?productId=${cartItem.getProduct().getProductID()}&size=${cartItem.size}&quantity=${cartItem.getQuantity()}&option=Increase">&plus;</a></button>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td><h6 class="text-black"><fmt:formatNumber value="${cartItem.getQuantity() * cartItem.getProduct().getSalePrice()}" pattern="###,###" /></h6></td>
                                                    <!--                                                    <td>
                                                                                                            <input type="checkbox" class="selectedProduct" value="${cartItem.getProduct().getProductID()}_${cartItem.size}"/>
                                                                                                        </td>-->
                                                    <td><a href="removeProduct?productId=${cartItem.getProduct().getProductID()}&size=${cartItem.size}" class="btn btn-black btn-sm" onclick="return Delete(this)">X</a></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="row mb-5">
                                    <div class="col-md-6 mb-3 mb-md-0">
                                        <button class="btn btn-black btn-sm btn-block"><a href="product" class="text-white">Choose More Product</a></button>
                                    </div>
                                </div>
                            </div>
                            <!--======= Start Proceed To Checkout ========-->
                            <div class="col-md-6 pl-5">
                                <div class="row justify-content-end">
                                    <div class="col-md-7">
                                        <div class="row">
                                            <div class="col-md-12 text-right border-bottom mb-5">
                                                <h3 class="text-black h4 text-uppercase">Cart Totals</h3>
                                            </div>
                                        </div>
                                        <!--                                        <div class="row mb-3">
                                                                                    <div class="col-md-6">
                                                                                        <span class="text-black">Select Product Total</span>
                                                                                    </div>
                                                                                    <div class="col-md-6 text-right">
                                                                                        <strong class="text-black" id="totalSelectedListPrice">0&#8363</strong>
                                                                                    </div>
                                                                                </div>-->
                                        <form class="row mb-5" action="processProduct" method="post">
                                            <input type="hidden" name="customerID" value="${sessionScope.acc.customer_id}">
                                            <input type="hidden" name="selectedList" value="${cart.getItems()}">
                                            <div class="col-md-6">
                                                <span class="text-black">Total</span>
                                            </div>
                                            <div class="col-md-6 text-right">
                                                <strong class="text-black" id="totalCartPrice"><fmt:formatNumber value="${totalPrice}" pattern="###,###"/>&#8363</strong>
                                            </div>
                                            <div class="col-md-12 mt-5">
                                                <button class="btn btn-black btn-lg py-3 btn-block" onclick="window.location = 'checkout.jsp'">Proceed To Checkout</button>
                                            </div>
                                        </form>
                                        <!--======= End Proceed To Checkout ========-->
                                    </div>
                                </div>
                            </div>

                        </c:otherwise>
                    </c:choose>
                    <!--======= Start latest product list ========-->
                    <div class="row pt-5">
                        <div class="col-md-12">
                            <%@include file="COMP/latestproductlist.jsp" %>
                        </div>
                    </div>
                    <!--======= End latest product list ========-->
                </div>
            </div>
        </div>


        <!-- Include Header/Navigation -->
        <%@ include file="COMP\footer.jsp" %>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/tiny-slider.js"></script>
        <script src="js/custom.js"></script>
        <script>
                                                    function Delete(element) {
                                                        var confirmation = confirm("Are you sure you want to delete this product from your cart?");
                                                        if (confirmation) {
                                                            return true;
                                                        } else {
                                                            return false;
                                                        }
                                                    }
                                                    $(document).ready(function () {
                                                        // Event listener for checkboxes
                                                        $('.selectedProduct').change(function () {
                                                            var selectedProducts = [];
                                                            $('.selectedProduct:checked').each(function () {
                                                                selectedProducts.push($(this).val());
                                                            });

                                                            $.ajax({
                                                                url: 'processSelectedProducts',
                                                                type: 'POST',
                                                                data: {'selectedProducts[]': selectedProducts},
                                                                traditional: true,
                                                                success: function (response) {
                                                                    $('#totalSelectedPrice').text(response.totalSelectedPrice);
                                                                },
                                                                error: function (xhr, status, error) {
                                                                    console.error("AJAX Error: ", status, error);
                                                                }
                                                            });
                                                        });
                                                    });
        </script>
    </body>

</html>
