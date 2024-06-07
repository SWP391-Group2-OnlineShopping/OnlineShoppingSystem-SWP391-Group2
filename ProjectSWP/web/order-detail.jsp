<%-- 
    Document   : blog
    Created on : May 10, 2024, 3:31:28 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        </style>
    </head>
    <body>
        <c:set var="page" value="order-detail" />
        <!-- Include Header/Navigation -->
        <%@ include file="COMP\header.jsp" %>


        <div class="container-fluid"style="margin-top: 100px;">
            <div class="container">
                <!-- Title -->
                <div class="d-flex justify-content-between align-items-center py-3">
                    <h2 class="h5 mb-0"><a href="#" class="text-muted"></a> OrderID : ${order.orderID}</h2>
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
                                        <span class="badge rounded-pill bg-info">${order.orderStatus}</span>
                                    </div>
                                </div>
                                <table class="table table-borderless">
                                    <tbody>
                                        <c:forEach items="${order.orderDetail}" var="od">
                                            <tr>
                                                <td>
                                                    <div class="d-flex mb-2">
                                                        <div class="flex-shrink-0">
                                                            <img src="${od.image}" alt="" width="35" class="img-fluid">
                                                        </div>
                                                        <div class="flex-lg-grow-1 ms-3">
                                                            <h6 class="small mb-0"><a href="#" class="text-reset">${od.title}</a></h6>
                                                            <span class="small">Size: ${od.size}</span>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>${od.quantitySold}</td>
                                                <td class="text-end">${od.priceSold}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td colspan="2">Subtotal</td>
                                            <td class="text-end">${order.totalCost}đ</td>
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
                                            <td class="text-end">$169,98</td>
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
                                        <p>Visa -1234 <br>
                                            Total: $169,98 <span class="badge bg-success rounded-pill">PAID</span></p>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>



                    <div class="col-lg-3">
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
