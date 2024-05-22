<%-- 
    Document   : index
    Created on : May 10, 2024, 3:30:10 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, dal.*, model.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <title>Furni Free Bootstrap 5 Template for Furniture and Interior Design Websites by Untree.co </title>
    </head>


    <body>


        <c:set var="page" value="index" />
        <!-- Include Header/Navigation -->
        <%@ include file="COMP\header.jsp" %>
        <!-- Include Banner slider -->
        <%@ include file="COMP\testimonial.jsp" %>
        <!-- Start Brand Section -->
        <div class="product-section">
            <div class="container">
                <div class="row">

                    <!-- Start Column 1 -->
                    <div class="col-md-12 col-lg-3 mb-5 mb-lg-0">
                        <h2 class="mb-4 section-title">Discover a Wide Range of Shoe Brands</h2>
                        <p class="mb-4">Welcome to our collection of premium footwear. We offer an extensive selection of authentic and stylish shoes to elevate your wardrobe.</p>
                        <p><a href="product" class="btn btn-primary">Explore Our Collection</a></p>
                    </div> 
                    <!-- End Column 1 -->

                    <!-- Start Column 2 -->
                    <div class="col-12 col-md-4 col-lg-3 mb-5 mb-md-0">
                        <a class="product-item" href="product?category=1&sort=newest">
                            <img src="images/Adidas.png" class="img-fluid product-thumbnail">
                            <h3 class="product-title">Adidas</h3>
                            <span class="icon-cross">
                                <img src="images/cross.svg" class="img-fluid">
                            </span>
                        </a>
                    </div> 
                    <!-- End Column 2 -->

                    <!-- Start Column 3 -->
                    <div class="col-12 col-md-4 col-lg-3 mb-5 mb-md-0">
                        <a class="product-item" href="product?category=2&sort=newest">
                            <img src="images/Nike.png" class="img-fluid product-thumbnail">
                            <h3 class="product-title">Nike</h3>
                            <span class="icon-cross">
                                <img src="images/cross.svg" class="img-fluid">
                            </span>
                        </a>
                    </div> 
                    <!-- End Column 3 -->

                    <!-- Start Column 4 -->
                    <div class="col-12 col-md-4 col-lg-3 mb-5 mb-md-0">
                        <a class="product-item" href="product?category=3&sort=newest">
                            <img src="images/Converse.png" class="img-fluid product-thumbnail">
                            <h3 class="product-title">Converse</h3>
                            <span class="icon-cross">
                                <img src="images/cross.svg" class="img-fluid">
                            </span>
                        </a>
                    </div>
                    <!-- End Column 4 -->

                </div>
            </div>
        </div>

        <!-- End Brand Section -->


        <!-- Include Popular Product -->
        <%@ include file="COMP\feature-product-comp.jsp" %>

        <!-- Include Blog Section -->
        <%@ include file="COMP\feature-blog-comp.jsp" %>	

        <!-- Include Header/Navigation -->
        <%@ include file="COMP\whychoose.jsp" %>

        <!-- Include Header/Navigation -->
        <%@ include file="COMP\footer.jsp" %>


        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/tiny-slider.js"></script>
        <script src="js/custom.js"></script>
    </body>

</html> 