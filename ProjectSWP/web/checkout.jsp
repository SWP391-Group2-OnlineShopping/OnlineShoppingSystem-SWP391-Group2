<%-- 
    Document   : checkout
    Created on : May 10, 2024, 3:30:46 PM
    Author     : admin
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>Cart Checkout</title>
    </head>

    <body>

        <!-- Include Header/Navigation -->
        <%@ include file="COMP\header.jsp" %>

        <!-- Include Header/Navigation -->


        <div class="untree_co-section">
            <div class="container">
                <div class="row bg-light p-2 mb-5">
                    <div class="col-md-12">
                        <a href="homepage">Home</a> <span> > </span>
                        <a href="product">Shop</a> <span>  > </span>
                        <a href="cart.jsp">Shopping Cart</a> <span> > </span>
                        <a href="#">Cart Checkout</a>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-5 mb-5 mb-md-0">
                        <h2 class="h3 mb-3 text-black">Billing Details</h2>
                        <div class="p-3 p-lg-5 border bg-white">

                            <div class="form-group row">
                                <div class="col-md-12">
                                    <label for="c_email_address" class="text-black">Email Address <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="c_email_address" name="email" value="${customerInfo.email}" readonly/>
                                </div>
                                <div class="col-md-12 mt-5">
                                    <label for="fullname" class="text-black">Full Name <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="fullname" name="fullName" value="${customerInfo.full_name}">
                                </div>

                                <div class="col-md-12 mt-5">
                                    <label for="specific_address" class="text-black">Specific Address <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="specific_address" name="address" placeholder="Street address" value="${customerInfo.address}">
                                </div>

                                <div class="col-md-12 mt-5">
                                    <label for="c_phone" class="text-black">Phone <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="c_phone" name="phoneNumber" placeholder="Phone Number" value="${customerInfo.phone_number}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="order_notes" class="text-black mt-5">Order Notes</label>
                                <textarea name="order_notes" id="order_notes" cols="30" rows="10" class="form-control" placeholder="Write your notes here..."></textarea>
                            </div>

                        </div>
                    </div>
                    <div class="col-md-7">

                        <div class="row mb-5">
                            <div class="col-md-12">
                                <h2 class="h3 mb-3 text-black">Your Order</h2>
                                <div class="p-3 p-lg-5 border bg-white">
                                    <table class="table site-block-order-table mb-5">
                                        <thead>
                                        <th class="productId">ID</th>
                                        <th class="productImage">Image</th>
                                        <th class="productTitle">Title</th>
                                        <th class="productPrice">Price</th>
                                        <th class="productSize">Size</th>
                                        <th class="productQuanity">Quantity</th>
                                        <th class="productTotalPrice">Total</th>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="cartItem" items="${selectedCart.getItems()}">
                                                <tr>
                                                    <td class="productID">
                                                        <p class="text-black m-0">${cartItem.getProduct().getProductID()}</p>
                                                    </td>
                                                    <td class="productImage">
                                                        <img src="${cartItem.getProduct().getThumbnailLink()}" class="image-fluid w-50"/>
                                                    </td>
                                                    <td class="productTitle">
                                                        <p class="fw-bolder m-0" style="color: #CE4B40;">${cartItem.getProduct().getTitle()}</p>
                                                    </td>
                                                    <td class="productPrice">
                                                        <p class="text-black m-0"><fmt:formatNumber value="${cartItem.getProduct().getSalePrice()}" pattern="###,### "/></p>
                                                    </td>
                                                    <td class="productSize">
                                                        <p class="text-black m-0">${cartItem.size}</p>
                                                    </td>
                                                    <td class="productQuantity">
                                                        <p class="text-black m-0 text-center">${cartItem.getQuantity()}</p>
                                                    </td>
                                                    <td class="productTotalPrice">
                                                        <p class="text-black m-0"><fmt:formatNumber value="${cartItem.getQuantity() * cartItem.getProduct().getSalePrice()}" pattern="###,### "/></p>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <tr>
                                                <td class="text-black font-weight-bold"><strong>Order Total</strong></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td class="text-black font-weight-bold"><strong><fmt:formatNumber value="${totalPrice}" pattern="###,### "/></strong></td>
                                            </tr>
                                        </tbody>
                                    </table>

                                    <div class="border p-3 mb-3">
                                        <h3 class="h6 mb-0"><a class="d-block" data-bs-toggle="collapse" href="#collapsebank" role="button" aria-expanded="false" aria-controls="collapsebank">Direct Bank Transfer</a></h3>

                                        <div class="collapse" id="collapsebank">
                                            <div class="py-2">
                                                <p class="mb-0">Make your payment directly into our bank account. Please use your Order ID as the payment reference. Your order won’t be shipped until the funds have cleared in our account.</p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="border p-3 mb-3">
                                        <h3 class="h6 mb-0"><a class="d-block" data-bs-toggle="collapse" href="#collapsecheque" role="button" aria-expanded="false" aria-controls="collapsecheque">Cheque Payment</a></h3>

                                        <div class="collapse" id="collapsecheque">
                                            <div class="py-2">
                                                <p class="mb-0">Make your payment directly into our bank account. Please use your Order ID as the payment reference. Your order won’t be shipped until the funds have cleared in our account.</p>

                                            </div>
                                        </div>
                                    </div>

                                    <div class="border p-3 mb-5">
                                        <h3 class="h6 mb-0"><a class="d-block" data-bs-toggle="collapse" href="#collapsepaypal" role="button" aria-expanded="false" aria-controls="collapsepaypal">Paypal</a></h3>

                                        <div class="collapse" id="collapsepaypal">
                                            <div class="py-2">
                                                <p class="mb-0">Make your payment directly into our bank account. Please use your Order ID as the payment reference. Your order won’t be shipped until the funds have cleared in our account.</p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <button class="btn btn-black btn-lg py-3 btn-block" onclick="window.location = 'cart.jsp'">Change Product</button>
                                        <button class="btn btn-black btn-lg py-3 float-end btn-block" onclick="window.location = 'thankyou.jsp'">Place Order</button>
                                    </div>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <!-- </form> -->
                <div class="row mt-5">
                    <div class="col-md-12">
                        <%@include file="COMP/latestproductlist.jsp" %>
                    </div>
                </div>
            </div>


        </div>

        <!-- Include Header/Navigation -->
        <%@ include file="COMP\footer.jsp" %>


        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/tiny-slider.js"></script>
        <script src="js/custom.js"></script>
    </body>

</html>
