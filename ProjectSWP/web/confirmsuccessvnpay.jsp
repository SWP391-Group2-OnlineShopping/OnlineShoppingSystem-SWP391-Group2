<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="com.vnpay.common.Config"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="dal.OrderDAO"%>
<%@ page import="model.Customers" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        <link href="css/productcss.css" rel="stylesheet">
        <title>Confirmation</title>
        <style>
            .order-details {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            .product-image img {
                max-width: 100px;
                border-radius: 10px;
            }
            .product-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            .product-table th, .product-table td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }
            .product-table th {
                background-color: #f2f2f2;
            }
        </style>
    </head>
    <body>
        <%
           //Begin process return from VNPAY
           Map fields = new HashMap();
           for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
               String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
               String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
               if ((fieldValue != null) && (fieldValue.length() > 0)) {
                   fields.put(fieldName, fieldValue);
               }
           }

           String vnp_SecureHash = request.getParameter("vnp_SecureHash");
           if (fields.containsKey("vnp_SecureHashType")) {
               fields.remove("vnp_SecureHashType");
           }
           if (fields.containsKey("vnp_SecureHash")) {
               fields.remove("vnp_SecureHash");
           }
           String signValue = Config.hashAllFields(fields);

        %>
        <%@ include file="COMP/header.jsp" %> 
        <!-- Include Banner slider -->

        <div class="hero">
            <div class="container">
                <div class="row justify-content-between">
                    <div class="col-lg-5">
                        <div class="intro-excerpt">
                            <h1>Confirmation</h1>
                        </div>
                    </div>
                    <div class="col-lg-7">
                    </div>
                </div>
            </div>
        </div>

        <div class="untree_co-section">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 text-center pt-5">
                        <span class="display-3 thankyou-icon text-primary">
                            <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-cart-check mb-5" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" d="M11.354 5.646a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L8 8.293l2.646-2.647a.5.5 0 0 1 .708 0z"/>
                            <path fill-rule="evenodd" d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l1.313 7h8.17l1.313-7H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm7 0a1 1 0 1 0 0 2 1 1 0 0 0 0-2z"/>
                            </svg>
                        </span>
                        <h2 class="display-3 text-black">Thank you for your order!</h2>
                        <p class="lead mb-5 " style="color: red"> If you complete order you can skip this notice but If you have not paid or fail to pay yet, please complete your order by click again in Order History and find the Order payment by VNPay you are not complete order. If you have not paid within 24 hours, your order will be canceled.</p>
                        <div class="order-details text-left mx-auto" >
                            <h1 class="h3 mb-3">Order Confirmation Success!</h1>
                            <p><strong>Full Name:</strong> ${fullName_vnpay}</p>
                            <p><strong>Address:</strong> ${address_vnpay}</p>
                            <p><strong>Phone Number:</strong> ${phoneNumber_vnpay}</p>
                            <p><strong>Order Notes:</strong> ${orderNotes_vnpay}</p>

                            <h2 class="h4 mt-4">Products</h2>
                            <table class="product-table">
                                <thead>
                                    <tr>
                                        <th>Image</th>
                                        <th>Title</th>
                                        <th>Size</th>
                                        <th>Unit Price</th>
                                        <th>Total Price</th>
                                        <th>Quantity</th>
                                        <th>Status Payment</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="product" items="${products_vnpay}">
                                        <tr>
                                            <td class="product-image">
                                                <img src="${product.thumbnailLink}" class="img-fluid" alt="${product.title}">
                                            </td>
                                            <td>${product.title}</td>
                                            <td>${product.size}</td>
                                            <td><fmt:formatNumber value="${product.salePrice}" pattern="###,###"/> VND</td>
                                            <td><fmt:formatNumber value="${product.salePrice * product.quantity}" pattern="###,###"/> VND</td>
                                            <td>${product.quantity}</td>
                                            <td><label>
                                                    <%
                                                        if (signValue.equals(vnp_SecureHash)) {
                                                            if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
                                                    %><b style="color: green"><%= "Success" %></b><%
                                                                Customers customers = (Customers) session.getAttribute("acc");
                                                                OrderDAO oDAO = new OrderDAO();
                                                                oDAO.UpdateOrderStatus(customers.getCustomer_id(), 2);
                                                            } else {
                                                    %><b style="color: red"><%= "Unsuccessful" %></b><%
                                                            }
                                                        } else {
                                                            out.print("invalid signature");
                                                        }
                                                        %>
                                                </label></td>


                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>





                        <p class="mt-5"><a href="product" class="btn btn-sm btn-outline-dark">Continue Shopping</a></p>
                    </div>
                    <div class="rec-product-area pt-3">
                        <div class="container">
                            <div class="row rec-product-inner p-3">
                                <%@include file="COMP/latestproductlist.jsp" %>
                            </div>

                        </div>
                    </div>      
                </div>
            </div>
        </div>

        <br>
        <br>
        <br>
        <%@ include file="COMP/footer.jsp" %>

        <!-- Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/tiny-slider.js"></script>
        <script src="js/custom.js"></script>
    </body>
</html>
