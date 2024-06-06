<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
                        <p class="lead mb-5 ">Your order will be on delivery soon.</p>
                        <div class="order-details text-left mx-auto" >
                            <h1 class="h3 mb-3">Order Confirmation Success!</h1>
                            <p><strong>Full Name:</strong> ${fullName}</p>
                            <p><strong>Address:</strong> ${address}</p>
                            <p><strong>Phone Number:</strong> ${phoneNumber}</p>
                            <p><strong>Order Notes:</strong> ${orderNotes}</p>
                            
                            <h2 class="h4 mt-4">Products</h2>
                            <table class="product-table">
                                <thead>
                                    <tr>
                                        <th>Image</th>
                                        <th>Title</th>
                                        <th>Size</th>
                                        <th>Total Price</th>
                                        <th>Quantity</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="product" items="${products}">
                                        <tr>
                                            <td class="product-image">
                                                <img src="${product.thumbnailLink}" class="img-fluid" alt="${product.title}">
                                            </td>
                                            <td>${product.title}</td>
                                            <td>${product.size}</td>
                                            <td><fmt:formatNumber value="${product.salePrice * product.quantity}" pattern="###,###"/> VND</td>
                                            <td>${product.quantity}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                       
                        <p class="mt-5"><a href="product" class="btn btn-sm btn-outline-dark">Continue Shopping</a></p>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="COMP/footer.jsp" %>

        <!-- Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
