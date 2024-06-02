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
        <%@ include file="COMP\hero.jsp" %>

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

                            <!--                            <div class="form-group">
                                                            <label for="c_create_account" class="text-black" data-bs-toggle="collapse" href="#create_an_account" role="button" aria-expanded="false" aria-controls="create_an_account"><input type="checkbox" value="1" id="c_create_account"> Create an account?</label>
                                                            <div class="collapse" id="create_an_account">
                                                                <div class="py-2 mb-4">
                                                                    <p class="mb-3">Create an account by entering the information below. If you are a returning customer please login at the top of the page.</p>
                                                                    <div class="form-group">
                                                                        <label for="c_account_password" class="text-black">Account Password</label>
                                                                        <input type="email" class="form-control" id="c_account_password" name="c_account_password" placeholder="">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>-->


                            <!--                            <div class="form-group">
                                                            <label for="c_ship_different_address" class="text-black" data-bs-toggle="collapse" href="#ship_different_address" role="button" aria-expanded="false" aria-controls="ship_different_address"><input type="checkbox" value="1" id="c_ship_different_address"> Ship To A Different Address?</label>
                                                            <div class="collapse" id="ship_different_address">
                                                                <div class="py-2">
                            
                                                                    <div class="form-group">
                                                                        <label for="c_diff_country" class="text-black">Country <span class="text-danger">*</span></label>
                                                                        <select id="c_diff_country" class="form-control">
                                                                            <option value="1">Select a country</option>    
                                                                            <option value="2">bangladesh</option>    
                                                                            <option value="3">Algeria</option>    
                                                                            <option value="4">Afghanistan</option>    
                                                                            <option value="5">Ghana</option>    
                                                                            <option value="6">Albania</option>    
                                                                            <option value="7">Bahrain</option>    
                                                                            <option value="8">Colombia</option>    
                                                                            <option value="9">Dominican Republic</option>    
                                                                        </select>
                                                                    </div>
                            
                            
                                                                    <div class="form-group row">
                                                                        <div class="col-md-6">
                                                                            <label for="c_diff_fname" class="text-black">First Name <span class="text-danger">*</span></label>
                                                                            <input type="text" class="form-control" id="c_diff_fname" name="c_diff_fname">
                                                                        </div>
                                                                        <div class="col-md-6">
                                                                            <label for="c_diff_lname" class="text-black">Last Name <span class="text-danger">*</span></label>
                                                                            <input type="text" class="form-control" id="c_diff_lname" name="c_diff_lname">
                                                                        </div>
                                                                    </div>
                            
                                                                    <div class="form-group row">
                                                                        <div class="col-md-12">
                                                                            <label for="c_diff_companyname" class="text-black">Company Name </label>
                                                                            <input type="text" class="form-control" id="c_diff_companyname" name="c_diff_companyname">
                                                                        </div>
                                                                    </div>
                            
                                                                    <div class="form-group row  mb-3">
                                                                        <div class="col-md-12">
                                                                            <label for="c_diff_address" class="text-black">Address <span class="text-danger">*</span></label>
                                                                            <input type="text" class="form-control" id="c_diff_address" name="c_diff_address" placeholder="Street address">
                                                                        </div>
                                                                    </div>
                            
                                                                    <div class="form-group">
                                                                        <input type="text" class="form-control" placeholder="Apartment, suite, unit etc. (optional)">
                                                                    </div>
                            
                                                                    <div class="form-group row">
                                                                        <div class="col-md-6">
                                                                            <label for="c_diff_state_country" class="text-black">State / Country <span class="text-danger">*</span></label>
                                                                            <input type="text" class="form-control" id="c_diff_state_country" name="c_diff_state_country">
                                                                        </div>
                                                                        <div class="col-md-6">
                                                                            <label for="c_diff_postal_zip" class="text-black">Posta / Zip <span class="text-danger">*</span></label>
                                                                            <input type="text" class="form-control" id="c_diff_postal_zip" name="c_diff_postal_zip">
                                                                        </div>
                                                                    </div>
                            
                                                                    <div class="form-group row mb-5">
                                                                        <div class="col-md-6">
                                                                            <label for="c_diff_email_address" class="text-black">Email Address <span class="text-danger">*</span></label>
                                                                            <input type="text" class="form-control" id="c_diff_email_address" name="c_diff_email_address">
                                                                        </div>
                                                                        <div class="col-md-6">
                                                                            <label for="c_diff_phone" class="text-black">Phone <span class="text-danger">*</span></label>
                                                                            <input type="text" class="form-control" id="c_diff_phone" name="c_diff_phone" placeholder="Phone Number">
                                                                        </div>
                                                                    </div>
                            
                                                                </div>
                            
                                                            </div>
                                                        </div>-->

                            <div class="form-group">
                                <label for="order_notes" class="text-black mt-5">Order Notes</label>
                                <textarea name="order_notes" id="order_notes" cols="30" rows="10" class="form-control" placeholder="Write your notes here..."></textarea>
                            </div>

                        </div>
                    </div>
                    <div class="col-md-7">

                        <!--                        <div class="row mb-5">
                                                    <div class="col-md-12">
                                                        <h2 class="h3 mb-3 text-black">Coupon Code</h2>
                                                        <div class="p-3 p-lg-5 border bg-white">
                        
                                                            <label for="c_code" class="text-black mb-3">Enter your coupon code if you have one</label>
                                                            <div class="input-group w-75 couponcode-wrap">
                                                                <input type="text" class="form-control me-2" id="c_code" placeholder="Coupon Code" aria-label="Coupon Code" aria-describedby="button-addon2">
                                                                <div class="input-group-append">
                                                                    <button class="btn btn-black btn-sm" type="button" id="button-addon2">Apply</button>
                                                                </div>
                                                            </div>
                        
                                                        </div>
                                                    </div>
                                                </div>-->

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
                                            <c:forEach var="cartItem" items="${cart.getItems()}">

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
                                                        <p class="text-black m-0"><fmt:formatNumber value="${cartItem.getQuantity() * cartItem.getProduct().getSalePrice()}" pattern="###,### "/> </p>
                                                    </td>
                                                </tr>

                                            </c:forEach>
                                            <!--                                            <tr>
                                                                                            <td class="text-black font-weight-bold"><strong>Cart Subtotal</strong></td>
                                                                                            <td class="text-black">$350.00</td>
                                                                                        </tr>-->
                                            <tr>
                                                <td class="text-black font-weight-bold"><strong>Order Total</strong></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td class="text-black font-weight-bold "><strong><fmt:formatNumber value="${totalPrice}" pattern="###,### "/></strong></td>
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
