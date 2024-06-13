<%-- 
    Document   : cart
    Created on : May 10, 2024, 3:31:17 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css" />
        <link href="css/order.css" rel="stylesheet">
        <title>My Order </title>
        
    </head>

    <body>
        <!-- Include Header/Navigation -->
        <%@ include file="COMP/header.jsp" %>

        <div class="untree_co-section before-footer-section">
            <div class="container">
                <div class="row">
                    <div class="col-md-9">
                        <div class="panel panel-default panel-order">
                            <div class="panel-heading">
                                <strong style="font-size: 32px; color: red;">Order history</strong>
                                <div class="btn-group pull-right">
                                    <div class="btn-group">
                                        <select id="sortOptions" class="form-control w-auto" onchange="applySort(this.value)">
                                            <option value="0" selected>All</option>
                                            <option value="1">Pending Confirmation</option>
                                            <option value="2">Confirmed</option>
                                            <option value="3">Shipped</option>
                                            <option value="4">Delivered</option>
                                            <option value="5">Success</option>
                                            <option value="6">Cancelled</option>
                                            <option value="7">Returned</option>
                                            <option value="8">Unpaid</option>
                                        </select>

                                    </div>
                                </div>
                            </div>

                            <div class="panel-body">
                                <c:forEach items="${orders}" var="o" varStatus="status">
                                    <div class="row" style="font-size: 18px;">
                                        <div class="col-md-1">#${status.index + 1}</div>
                                        <div class="col-md-11">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <c:choose>
                                                        <c:when test="${o.orderStatus == 'Pending Confirmation'}">
                                                            <div class="pull-right" style="background: #ba941f;">${o.orderStatus}</div>
                                                        </c:when>
                                                        <c:when test="${o.orderStatus == 'Confirmed'}">
                                                            <div class="pull-right" style="background: #0b5394;">${o.orderStatus}</div>
                                                        </c:when>
                                                        <c:when test="${o.orderStatus == 'Shipped'}">
                                                            <div class="pull-right" style="background: #6f90af;">${o.orderStatus}</div>
                                                        </c:when>
                                                        <c:when test="${o.orderStatus == 'Delivered'}">
                                                            <div class="pull-right" style="background: #6f90af;">${o.orderStatus}</div>
                                                        </c:when>
                                                        <c:when test="${o.orderStatus == 'Success'}">
                                                            <div class="pull-right" style="background: #54b729;">${o.orderStatus}</div>
                                                            <div class="pull-right small" style="background: orange; margin-right: 10px;"><a href="feedback?id=${o.orderID}">Feedback</a></div>
                                                        </c:when>
                                                        <c:when test="${o.orderStatus == 'Cancelled'}">
                                                            <div class="pull-right" style="background: #c50303;">${o.orderStatus}</div>
                                                        </c:when>
                                                        <c:when test="${o.orderStatus == 'Returned'}">
                                                            <div class="pull-right" style="background: #d88d3e;">${o.orderStatus}</div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="pull-right" style="background: #7a7676;">${o.orderStatus}</div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <a href="orderdetail?orderID=${o.orderID}">
                                                        <span><strong>OrderID: </strong></span>
                                                        <span class="label label-info">${o.orderID}</span>
                                                    </a><br />
                                                    ${o.firstProduct} and ${o.numberOfItems - 1} more... <br />
                                                </div>
                                                <div class="col-md-12" style="font-size: 14px;">
                                                    order made on: ${o.orderDate} by <a href="customerInfo?id=${o.customerID}">${o.customerName}</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>  
                            </div>

                            <c:choose>
                                <c:when test="${empty orders}">
                                    <div class="panel-footer">
                                        You do not have any orders to show. Please consider heading to
                                        <a href="product">Shop</a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="panel-footer">
                                        These are ${sessionScope.acc.user_name}'s orders
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <div class="pagination">
                                <a href="?txt=${param.txt}&page=${param.page - 1 > 0 ? param.page - 1 : 1}" class="pagination-link">&laquo;</a>
                                <c:forEach begin="1" end="${endPage}" var="i">
                                    <a href="?txt=${param.txt}&page=${i}" class="pagination-link ${i == param.page ? 'active' : ''}">${i}</a>
                                </c:forEach>
                                <a href="?txt=${param.txt}${categoriesParam}&page=${param.page + 1 <= endPage ? param.page + 1 : endPage}" class="pagination-link">&raquo;</a>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-12 right-box">
                        <div id="myDIV" style="display: flex; justify-content: right; margin-bottom: 10px;">
                            <form id="searchForm" class="search-form" action="myorder" method="GET">
                                <div class="search-box">
                                    <button type="submit" class="btn-search"><i class="fas fa-search" style="color: black"></i></button>
                                    <input type="text" name="txt" class="input-search" placeholder="Search..." <c:if test="${not empty search}"> value="${search}"</c:if>>
                                    </div>
                                </form>
                            </div>

                        <c:if test="${not empty search}">
                            <div class="card">
                                <div class="header">
                                    <h2>Result: </h2>
                                    <p>These are up to 3 products that contain "${search}" in your order</p>
                                </div>
                                <c:forEach items="${searchList}" var="l">
                                    <div class="body-widget">
                                        <img src="${l.image}" alt="${l.title}">
                                        <h5 style="color: #91140b;">${l.title}</h5>
                                        <p>Price: ${l.salePrice}đ</p>
                                        <p>This product is in <a href="orderdetail?orderID=${l.orderID}" style="color: blue;">OrderID: ${l.orderID}</a>.</p>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>
                        <div class="card">
                            <div class="header">
                                <h2>Latest Products</h2>
                            </div>
                            <div class="body widget popular-post">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <c:if test="${empty products}">
                                            <div class="col-12">
                                                <p style="font-size: 16px;">No products available.</p>
                                            </div>
                                        </c:if>
                                        <c:forEach var="product" items="${products}">
                                            <div class="single_post">
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

        <!-- Include Footer -->
        <%@ include file="COMP/footer.jsp" %>

        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/tiny-slider.js"></script>
        <script src="js/custom.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script>
                                            $(document).ready(function () {
                                                // Handle search form submission via AJAX
                                                $('#searchForm').on('submit', function (event) {
                                                    event.preventDefault(); // Prevent the default form submission

                                                    var form = $(this);
                                                    var url = form.attr('action');
                                                    var formData = form.serialize(); // Serialize the form data

                                                    console.log('Submitting search form via AJAX:', formData);

                                                    $.ajax({
                                                        url: url,
                                                        method: 'GET',
                                                        data: formData,
                                                        dataType: 'html',
                                                        headers: {
                                                            'X-Requested-With': 'XMLHttpRequest'
                                                        },
                                                        success: function (response) {
                                                            var newBody = $(response).find('.panel-body').html();
                                                            $('.panel-body').html(newBody);
                                                            console.log('Search form submission successful.');
                                                        },
                                                        error: function (xhr, status, error) {
                                                            console.error('Error loading orders: ', status, error);
                                                        }
                                                    });
                                                });

                                                // Handle pagination links via AJAX
                                                $(document).on('click', '.pagination-link', function (event) {
                                                    event.preventDefault(); // Prevent the default link navigation

                                                    var url = $(this).attr('href');

                                                    console.log('Loading page via AJAX:', url);

                                                    $.ajax({
                                                        url: url,
                                                        method: 'GET',
                                                        dataType: 'html',
                                                        headers: {
                                                            'X-Requested-With': 'XMLHttpRequest'
                                                        },
                                                        success: function (response) {
                                                            var newBody = $(response).find('.panel-body').html();
                                                            $('.panel-body').html(newBody);
                                                            console.log('Page load successful.');
                                                        },
                                                        error: function (xhr, status, error) {
                                                            console.error('Error loading orders: ', status, error);
                                                        }
                                                    });
                                                });
                                            });

                                            function loadOrders(url) {
                                                console.log('Loading orders via AJAX:', url);

                                                $.ajax({
                                                    url: url,
                                                    method: 'GET',
                                                    dataType: 'html',
                                                    headers: {
                                                        'X-Requested-With': 'XMLHttpRequest'
                                                    },
                                                    success: function (response) {
                                                        var newBody = $(response).find('.panel-body').html();
                                                        $('.panel-body').html(newBody);
                                                        console.log('Orders loaded successfully.');
                                                    },
                                                    error: function (xhr, status, error) {
                                                        console.error('Error loading orders: ', status, error);
                                                    }
                                                });
                                            }

                                            function applySort(sortBy) {
                                                var searchParams = new URLSearchParams(window.location.search);
                                                searchParams.set('orderStatus', sortBy);

                                                var url = 'myorder?' + searchParams.toString();
                                                loadOrders(url); // Call loadOrders function with the constructed URL
                                            }
        </script>
    </body>

</html>
