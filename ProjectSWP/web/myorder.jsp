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

        <title>My Order </title>
        <style>
            .panel-order .row {
                border-bottom: 1px solid #ccc;
            }
            .panel-order .row:last-child {
                border: 0px;
            }
            .panel-order .row .col-md-1 {
                text-align: center;
                padding-top: 15px;
            }
            .panel-order .row .col-md-1 img {
                width: 50px;
                max-height: 50px;
            }
            .panel-order .row .row {
                border-bottom: 0;
            }
            .panel-order .row .col-md-11 {
                border-left: 1px solid #ccc;
            }
            .panel-order .row .row .col-md-12 {
                padding-top: 7px;
                padding-bottom: 7px;
            }
            .panel-order .row .row .col-md-12:last-child {
                font-size: 11px;
                color: #555;
                background: #efefef;
            }
            .panel-order .btn-group {
                margin: 0px;
                padding: 0px;
            }
            .panel-order .panel-body {
                padding-top: 0px;
                padding-bottom: 0px;
            }
            .panel-order .panel-heading {
                margin-bottom: 40px;
            }
            .pull-right {
                background-color: #ddd;
                border: none;
                color: white;
                padding: 10px 20px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                cursor: pointer;
                border-radius: 16px;
            }
            .hover-link:hover {
                color: blue;
                text-decoration: underline;
            }
            .card {
                background: #fff;
                transition: .5s;
                border: 0;
                margin-bottom: 30px;
                border-radius: .55rem;
                position: relative;
                width: 100%;
                box-shadow: 0 1px 2px 0 rgb(0 0 0 / 10%);
            }
            .card .body {
                color: #444;
                padding: 20px;
                font-weight: 400;
            }
            .card .header {
                color: #444;
                padding: 20px;
                position: relative;
                box-shadow: none;
            }
            .single_post {
                transition: all .4s ease;
            }
            .single_post .body {
                padding: 30px;
            }
            .single_post .img-post {
                position: relative;
                overflow: hidden;
                max-height: 500px;
                margin-bottom: 30px;
                display: flex;
                justify-content: center;
                align-items: center;
            }
            .single_post .img-post img {
                width: auto;
                height: 100%;
                object-fit: cover;
                object-position: center;
            }
            .single_post .img-post>img {
                transform: scale(1);
                opacity: 1;
                transition: transform .4s ease, opacity .4s ease;
                max-width: 100%;
                filter: none;
                transform: scale(1.01);
            }
            .single_post .img-post:hover img {
                transform: scale(1.02);
                opacity: .7;
                filter: grayscale(1);
                transition: all .8s ease-in-out;
            }
            .single_post .footer {
                padding: 0 30px 30px 30px;
            }
            .single_post .footer .actions {
                display: inline-block;
            }
            .single_post .footer .stats {
                cursor: default;
                list-style: none;
                padding: 0;
                display: inline-block;
                float: right;
                margin: 0;
                line-height: 35px;
            }
            .single_post .footer .stats li {
                border-left: solid 1px rgba(160, 160, 160, 0.3);
                display: inline-block;
                font-weight: 400;
                letter-spacing: 0.25em;
                line-height: 1;
                margin: 0 0 0 2em;
                padding: 0 0 0 2em;
                text-transform: uppercase;
                font-size: 13px;
            }
            .single_post .footer .stats li a {
                color: #777;
            }
            .single_post .footer .stats li:first-child {
                border-left: 0;
                margin-left: 0;
                padding-left: 0;
            }
            .single_post h3 {
                font-size: 20px;
                text-transform: uppercase;
            }
            .single_post h3 a {
                color: #242424;
                text-decoration: none;
            }
            .single_post p {
                font-size: 16px;
                line-height: 26px;
                font-weight: 300;
                margin: 0;
            }
            .single_post .blockquote p {
                margin-top: 0 !important;
            }
            .single_post .meta {
                list-style: none;
                padding: 0;
                margin: 0;
            }
            .single_post .meta li {
                display: inline-block;
                margin-right: 15px;
            }
            .single_post .meta li a {
                font-style: italic;
                color: #959595;
                text-decoration: none;
                font-size: 12px;
            }
            .single_post .meta li a i {
                margin-right: 6px;
                font-size: 12px;
            }
            .single_post2 {
                overflow: hidden;
            }
            .single_post2 .content {
                margin-top: 15px;
                margin-bottom: 15px;
                padding-left: 80px;
                position: relative;
            }
            .single_post2 .content .actions_sidebar {
                position: absolute;
                top: 0px;
                left: 0px;
                width: 60px;
            }
            .single_post2 .content .actions_sidebar a {
                display: inline-block;
                width: 100%;
                height: 60px;
                line-height: 60px;
                margin-right: 0;
                text-align: center;
                border-right: 1px solid #e4eaec;
            }
            .single_post2 .content .title {
                font-weight: 100;
            }
            .single_post2 .content .text {
                font-size: 15px;
            }
            .right-box .categories-clouds li {
                display: inline-block;
                margin-bottom: 5px;
            }
            .right-box .categories-clouds li a {
                display: block;
                border: 1px solid;
                padding: 6px 10px;
                border-radius: 3px;
            }
            .right-box .instagram-plugin {
                overflow: hidden;
            }
            .right-box .instagram-plugin li {
                float: left;
                overflow: hidden;
                border: 1px solid #fff;
            }
            .comment-reply li {
                margin-bottom: 15px;
            }
            .comment-reply li:last-child {
                margin-bottom: none;
            }
            .comment-reply li h5 {
                font-size: 18px;
            }
            .comment-reply li p {
                margin-bottom: 0px;
                font-size: 15px;
                color: #777;
            }
            .comment-reply .list-inline li {
                display: inline-block;
                margin: 0;
                padding-right: 20px;
            }
            .comment-reply .list-inline li a {
                font-size: 13px;
            }
            .body-widget {
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 16px;
                max-width: 300px;
                margin: 20px auto;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                background-color: #f9f9f9;
                text-align: start;
                font-size: 16px;
            }
            .body-widget img {
                max-width: 100px;
                ;
                height: auto;
                border-radius: 8px;
                margin-bottom: 15px;
            }
            .body-widget h5 {
                font-size: 18px;
                margin-bottom: 10px;
            }
            .body-widget p {
                margin: 5px 0;
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
            .input-search:hover{
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
            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 10px 0;
                font-size: 20px;
            }

            .pagination a {
                color: black;
                float: left;
                padding: 8px 16px;
                text-decoration: none;
                border: 1px solid black;
                border-radius: 5px;
                margin: 0 4px;
                transition: background-color .3s, border-color .3s;
            }

            .pagination a.active {
                background-color: #4CAF50;
                color: white;
                border: 1px solid #4CAF50;
            }

            .pagination a:hover:not(.active) {
                background-color: #ddd;
                border-color: orange;
            }
        </style>
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
                                            <option value="5">Cancelled</option>
                                            <option value="6">Returned</option>
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

                    <div class="pagination">
                        <a href="?txt=${param.txt}&page=${param.page - 1 > 0 ? param.page - 1 : 1}" class="pagination-link">&laquo;</a>
                        <c:forEach begin="1" end="${endPage}" var="i">
                            <a href="?txt=${param.txt}&page=${i}" class="pagination-link ${i == param.page ? 'active' : ''}">${i}</a>
                        </c:forEach>
                        <a href="?txt=${param.txt}${categoriesParam}&page=${param.page + 1 <= endPage ? param.page + 1 : endPage}" class="pagination-link">&raquo;</a>
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