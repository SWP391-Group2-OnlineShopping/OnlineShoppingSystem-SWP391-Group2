<%-- 
    Document   : blog
    Created on : May 10, 2024, 3:31:28 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="author" content="Untree.co">
        <link rel="shortcut icon" href="favicon.png">
        <meta name="description" content="" />
        <meta name="keywords" content="bootstrap, bootstrap4" />
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <link href="css/tiny-slider.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <title>Blogs</title>
        <style>
            .card {
                box-shadow: 0 20px 27px 0 rgb(0 0 0 / 5%);
            }
            .card {
                position: relative;
                display: flex;
                flex-direction: column;
                min-width: 0;
                word-wrap: break-word;
                background-color: #fff;
                background-clip: border-box;
                border: 0 solid rgba(0,0,0,.125);
                border-radius: 1rem;
            }
            .text-reset {
                --bs-text-opacity: 1;
                color: inherit!important;
            }
            a {
                color: #5465ff;
                text-decoration: none;
            }
            .search-box{
                width: fit-content;
                height: fit-content;
                position: relative;
            }
            .input-search{
                height: 50px;
                width: 50px;
                border-style: none;
                padding: 10px;
                font-size: 18px;
                letter-spacing: 2px;
                outline: none;
                border-radius: 25px;
                transition: all .5s ease-in-out;
                background-color: #22a6b3;
                padding-right: 40px;
                color:#000000;
            }
            .input-search::hover{
                color:rgba(0,0,0,.5);
                font-size: 18px;
                letter-spacing: 2px;
                font-weight: 100;
            }
            .btn-search{
                width: 50px;
                height: 50px;
                border-style: none;
                font-size: 20px;
                font-weight: bold;
                outline: none;
                cursor: pointer;
                border-radius: 50%;
                position: absolute;
                right: 0px;
                color:#000000 ;
                background-color:transparent;
                pointer-events: painted;
            }
            .btn-search:hover ~ .input-search{
                width: 300px;
                border-radius: 0px;
                background-color: transparent;
                border-bottom:1px solid rgba(255,255,255,.5);
                transition: all 500ms cubic-bezier(0, 0.110, 0.35, 2);
            }
            .input-search:hover{
                width: 300px;
                border-radius: 0px;
                background-color: transparent;
                border-bottom:1px solid rgba(255,255,255,.5);
                transition: all 500ms cubic-bezier(0, 0.110, 0.35, 2);
            }
        </style>
    </head>
    <body>
        <c:set var="page" value="order-detail" />
        <!-- Include Header/Navigation -->
        <%@ include file="COMP\header.jsp" %>
        <!-- ======= Start static link  ======= -->
        <div class="static-link pt-5 px-5" style="margin-top: 80px;">
            <div class="container">
                <div class="col-lg-12 align-items-center bg-light p-2">
                    <a href="homepage">Home</a> <span> > </span>
                    <a href="javascript:window.history.back()">My Order</a> <span>   > </span>
                    <p style="width: 30%; display: inline;">${order.orderID}</p>
                </div>
            </div>
        </div>

        <!-- ======= End static link ======= -->

        <div class="container-fluid"style="margin-top: 10px;">
            <div class="container">
                <form class="search-form" action="myorder" method="GET">
                    <div class="search-box">
                        <button type="submit"class="btn-search"><i class="fas fa-search" style="color: black"></i></button>
                        <input type="text" name="txt" class="input-search" placeholder="Search...">
                    </div>
                </form>
                <!-- Title -->


                <div class="d-flex justify-content-between align-items-center py-3">
                    <h2 class="h5 mb-0"><a href="#" class="text-muted"></a> OrderID : ${order.orderID}</h2>
                    <c:if test="${order.orderStatus == 'Delivered'}">
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#confirmModal">
                            I have received the Order
                        </button>
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#returnModal">
                            I want to return the Order
                        </button>
                    </c:if>
                    <c:if test="${order.orderStatus == 'Confirmed' || order.orderStatus == 'Pending Confirmation'}">
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#cancelOrderModal">
                            Cancel Order
                        </button>
                    </c:if>
                </div>
                <p style="color: red;font-size: 16px;"> ${message}</p>


                <div class="modal fade" id="cancelOrderModal" tabindex="-1" aria-labelledby="cancelOrderModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="cancelOrderModalLabel">Do you want to cancel the order?</h5>

                                <button type="button" class="close"  data-bs-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>

                            <div class="modal-body text-center">
                                <form action="orderdetail" method="GET">
                                    <input type="hidden" value="1" name="check">
                                    <input type="hidden" value="${order.orderID}" name="orderID">
                                    <input type="submit" value="Cancel the order" class="rounded-pill" style="font-size: 16px; background-color: #FA7216; color: white;">
                                </form>
                                <p class="mt-3">Note: The process cannot be redo</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModal" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="confirmModalLabel">Order Delivery Confirmation</h5>

                                <button type="button" class="close"  data-bs-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>

                            <div class="modal-body text-center">
                                <form action="orderdetail" method="GET">
                                    <input type="hidden" value="2" name="check">
                                    <input type="hidden" value="${order.orderID}" name="orderID">
                                    <input type="submit" value="Confirm" class="rounded-pill" style="font-size: 16px; background-color: #FA7216; color: white;">
                                </form>
                                <p class="mt-3">Note: The process cannot be redo</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="returnModal" tabindex="-1" aria-labelledby="returnModal" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="returnModalLabel">Please provide reason to return</h5>

                                <button type="button" class="close"  data-bs-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>

                            <div class="modal-body text-center">
                                
                                <form action="returnorder" method="POST" enctype="multipart/form-data">
                                    <input type="hidden" value="2" name="check">
                                    <input type="hidden" value="${order.orderID}" name="orderID">
                                    <div class="mb-3">
                                        <label for="reason" class="form-label"><b>Reason: </b></label>
                                        <textarea class="form-control" id="reason" name="reason" rows="5"></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label for="phonenumber" class="form-label"><b>Phone Number </b></label>
                                        <textarea class="form-control" id="phonenumber" name="phonenumber" rows="1"></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label for="bankaccount" class="form-label"><b style="color:  red">Please provide your bank account name and number in case to return </b></label>
                                        <textarea class="form-control" id="bankaccount" name="bankaccount" rows="2"></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label for="image" class="form-label">Upload evidence images/videos:</label>
                                        <input type="file" class="form-control" id="image" name="image" accept="image/*,video/*" multiple>
                                        <div class="error-message" id="file-error">You can upload up to 5 files only.</div>
                                    </div>
                                    <input type="submit" value="Send" class="rounded-pill" style="font-size: 16px; background-color: #FA7216; color: white;">
                                </form>
                                    
                                <p class="mt-3">Note: The process cannot be redo</p>
                            </div>
                        </div>
                    </div>
                </div>


                <!-- Main content -->
                <div class="row">
                    <div class="col-lg-9">
                        <!-- Details -->
                        <div class="card mb-4">
                            <div class="card-body">
                                <div class="mb-3 d-flex justify-content-between">
                                    <div>
                                        <span class="me-3">${order.orderDate}</span>
                                        <span class="me-3">#${order.orderID}</span>
                                        <c:choose>
                                            <c:when test="${order.orderStatus == 'Pending Confirmation'}">
                                                <span class="badge rounded-pill" style="background: #ba941f;">${order.orderStatus}</span>
                                            </c:when>
                                            <c:when test="${order.orderStatus == 'Confirmed'}">
                                                <span class="badge rounded-pill" style="background: #0b5394;">${order.orderStatus}</span>

                                            </c:when>
                                            <c:when test="${order.orderStatus == 'Shipped'}">
                                                <span class="badge rounded-pill" style="background: #6f90af;">${order.orderStatus}</span>

                                            </c:when>
                                            <c:when test="${order.orderStatus == 'Delivered'}">
                                                <span class="badge rounded-pill" style="background: #6f90af;">${order.orderStatus}</span>

                                            </c:when>
                                            <c:when test="${order.orderStatus == 'Success'}">
                                                <span class="badge rounded-pill bg-info" style="background: #54b729;">${order.orderStatus}</span>

                                            </c:when>
                                            <c:when test="${order.orderStatus == 'Cancelled'}">
                                                <span class="badge rounded-pill" style="background: #c50303;">${order.orderStatus}</span>

                                            </c:when>
                                            <c:when test="${order.orderStatus == 'Returned'}">
                                                <span class="badge rounded-pill" style="background: #d88d3e;">${order.orderStatus}</span>

                                            </c:when>
                                            <c:when test="${order.orderStatus == 'Want Return'}">
                                                <span class="badge rounded-pill" style="background: #d88d3e;">${order.orderStatus}</span>

                                            </c:when>
                                            <c:when test="${order.orderStatus == 'Waiting Return'}">
                                                <span class="badge rounded-pill" style="background: #ba941f;">${order.orderStatus}</span>

                                            </c:when>
                                            <c:when test="${order.orderStatus == 'Denied Return'}">
                                                <span class="badge rounded-pill" style="background: #c50303;">${order.orderStatus}</span>

                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge rounded-pill" style="background: #7a7676;">${order.orderStatus}</span>

                                            </c:otherwise>
                                        </c:choose>

                                    </div>
                                </div>
                                <table class="table table-borderless">
                                    <tbody>
                                        <c:forEach items="${order.orderDetail}" var="od">
                                            <tr>
                                                <td>
                                                    <div class="d-flex mb-2">
                                                        <div class="flex-shrink-0">
                                                            <a href="productdetails?id=${od.productID}&error=Please%20choose%20your%20size">
                                                                <img src="${od.image}" alt="" width="35" class="img-fluid">
                                                            </a>
                                                        </div>
                                                        <div class="flex-lg-grow-1 ms-3">
                                                            <h6 class="small mb-0"><a href="productdetails?id=${od.productID}&error=Please%20choose%20your%20size" class="text-reset">${od.title}</a></h6>
                                                            <span class="small">Size: ${od.size}</span>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>${od.quantitySold}</td>

                                                <td class="text-end"><fmt:formatNumber value="${od.priceSold}" pattern="###,###" />VND</td>
                                                <c:choose>
                                                    <c:when test="${order.orderStatus == 'Pending Confirmation' || order.orderStatus == 'Confirmed' || order.orderStatus == 'Shipped' || order.orderStatus == 'Delivered'}">
                                                        <!-- No action needed -->
                                                    </c:when>
                                                    <c:when test="${order.orderStatus == 'Success' || order.orderStatus == 'Cancelled' || order.orderStatus == 'Returned' || order.orderStatus == 'Denied Return'}">
                                                        <td>
                                                            <a href="productdetails?id=${od.productID}" class="btn btn-primary btn-sm">
                                                                Rebuy
                                                            </a>
                                                        </td>
                                                        <c:if test="${order.orderStatus == 'Success' && od.feedbackID == 0}">
                                                            <td>
                                                                <a href="feedback.jsp?orderDetailID=${od.orderDetailID}" class="btn btn-primary btn-sm" style="color:white; background-color: #CF7919">
                                                                Feedback
                                                            </a>
                                                        </td>
                                                        </c:if>
                                                        
                                                        <c:if test="${order.orderStatus == 'Denied Return' && od.feedbackID == 0}">
                                                            <td>
                                                                <a href="feedback.jsp?orderDetailID=${od.orderDetailID}" class="btn btn-primary btn-sm" style="color:white; background-color: #CF7919">
                                                                    Feedback
                                                                </a>
                                                            </td>
                                                        </c:if>

                                                    </c:when>
                                                    <c:otherwise>
                                                        <!-- No action needed -->
                                                    </c:otherwise>
                                                </c:choose>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td colspan="2">Subtotal</td>
                                            <td class="text-end"><fmt:formatNumber value="${order.totalCost}" pattern="###,###"/> VND</td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">Shipping</td>
                                            <td class="text-end">$20.00</td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">Discount (Code: NEWYEAR)</td>
                                            <td class="text-danger text-end">-$10.00</td>
                                        </tr>
                                        <tr class="fw-bold">
                                            <td colspan="2">TOTAL</td>
                                            <td class="text-end"><fmt:formatNumber value="${order.totalCost}" pattern="###,###"/> VND</td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                        <!-- Payment -->
                        <div class="card mb-4">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-lg-6">
                                        <h3 class="h6">Payment Method</h3>
                                        <p>
                                            ${order.paymentMethods} <br>
                                            Total: <fmt:formatNumber value="${order.totalCost}" pattern="###,###"/> VND
                                            <span class="badge bg-success rounded-pill">${order.orderStatus}</span>
                                        </p>
                                    </div>
                                    <c:if test="${(order.paymentMethods == 'VNPay' || order.paymentMethods == 'Banking Online Transfer') && order.orderStatus == 'Unpaid'}">
                                        <div class="col-lg-6 d-flex align-items-center flex-column">
                                            <form action="repayvnpay" method="post" class="w-100 text-end mb-2">
                                                <button type="submit" class="btn btn-primary">Proceed to Payment</button>
                                            </form>
                                            <form action="repaybanking" method="post" class="w-100 text-end">
                                                <button type="submit" class="btn btn-primary">Change to Pay by Banking Transfer</button>
                                            </form>
                                        </div>
                                    </c:if>

                                </div>
                            </div>
                        </div>


                    </div>



                    <div class="col-lg-3" style="margin-bottom: 100px;">
                        <!-- Customer Notes -->


                        <div class="card mb-4">
                            <!-- Shipping information -->

                            <div class="card-body">

                                <img src="${cus.avatar}" alt="" width="35">

                                <h3 class="h6">Customer Information</h3>
                                <strong>${order.customerName} (${cus.email})</strong><br>
                                <strong></strong>
                                <hr>
                                <h3 class="h6">${cus.full_name}</h3>
                                <h3 class="h6">Address</h3>
                                <address>
                                    ${cus.address}<br>
                                    <abbr title="Phone">Mobile:</abbr> ${cus.phone_number}
                                </address>
                            </div>
                        </div>
                        <div class="card mb-4">
                            <!-- Ordernote -->
                            <div class="card-body">
                                <h3 class="h6">Order Notes</h3>    
                                <hr>
                                <p> ${order.orderNotes} </p>
                            </div>
                        </div>

                        <div class="card mb-4">
                            <div class="header">
                                <h2 style="margin-top:5px; margin-left: 5px;">Latest Products</h2>
                            </div>
                            <div class="body widget popular-post">
                                <div class="row">
                                    <div class="col-lg-12 text-center">
                                        <c:if test="${empty products}">
                                            <div class="col-12">
                                                <p style="font-size: 16px;">No products available.</p>
                                            </div>
                                        </c:if>
                                        <c:forEach var="product" items="${products}">
                                            <div class="single_post" style="margin-bottom: 20px;">
                                                <a href="productdetails?id=${product.productID}">
                                                    <img src="${product.thumbnailLink}" alt="${product.title}" class="img-fluid" style="width: 200px; height: 144px; object-fit: cover;">
                                                </a>
                                                <h5 class="m-b-0"><a href="productdetails?id=${product.productID}">${product.title}</a></h5>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>        
                </div>                   
            </div>
        </div>



        <%@ include file="COMP/footer.jsp" %>

        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/tiny-slider.js"></script>
        <script src="js/custom.js"></script>

    </body>
</html>