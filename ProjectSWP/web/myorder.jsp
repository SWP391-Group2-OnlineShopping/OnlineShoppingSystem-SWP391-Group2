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
            .panel-order .row .col-md-1  {
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
            .pull-right{
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
        </style>
    </head>

    <body>

        <!-- Include Header/Navigation -->
        <%@ include file="COMP\header.jsp" %>

        <div class="untree_co-section before-footer-section">
            <div class="container">
                <div class="col-md-9">



                    <div class="panel panel-default panel-order">
                        <div class="panel-heading">
                            <strong style="font-size: 32px; color: red; ">Order history</strong>
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
                                <div class="row" style="font-size: 18px;" id="resultContainer">
                                    <div class="col-md-1">#${status.index+1}</div>
                                    <div class="col-md-11">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="pull-right" style="background: red;">${o.orderStatus}</div>
                                                <a href="your-link-here">
                                                    <span><strong>OrderID: </strong></span> 
                                                    <span class="label label-info">${o.orderID}</span>
                                                </a><br />
                                                ${o.firstProduct} and ${o.numberOfItems-1} more...  <br />
                                            </div>
                                            <div class="col-md-12" style="font-size: 14px;">order made on: ${o.orderDate} by <a href="customerInfo?id=${o.customerID}">${o.customerName} </a></div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="panel-footer">Put here some note for example: bootdey si a gallery of free bootstrap snippets bootdeys</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Include Header/Navigation -->
        <%@ include file="COMP\footer.jsp" %>


        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/tiny-slider.js"></script>
        <script src="js/custom.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script>
                                        function loadOrders(url) {
                                            $.ajax({
                                                url: url,
                                                method: 'GET',
                                                dataType: 'html',
                                                headers: {
                                                    'X-Requested-With': 'XMLHttpRequest'
                                                },
                                                success: function (response) {
                                                    $('#resultContainer').html(response);
                                                },
                                                error: function (xhr, status, error) {
                                                    console.error('Error loading orders: ', status, error);
                                                }
                                            });
                                        }

                                        function applySort(sortBy) {
                                            var url = 'myorder?orderStatus=' + sortBy; // Construct URL with sorting option
                                            loadOrders(url); // Call loadOrders function with the constructed URL
                                        }
        </script>
    </body>

</html>
