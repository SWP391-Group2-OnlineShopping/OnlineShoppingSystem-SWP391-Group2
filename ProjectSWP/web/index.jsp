<%-- 
    Document   : index
    Created on : May 10, 2024, 3:30:10 PM
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
        <title>Furni Free Bootstrap 5 Template for Furniture and Interior Design Websites by Untree.co </title>
    </head>


    <body>

        <!-- Include Header/Navigation -->
        <%@ include file="COMP\header.jsp" %>

        <!-- Include Header/Navigation -->
        <%@ include file="COMP\hero.jsp" %>
<
        <!-- Start Product Section -->
        <div class="product-section">
            <div class="container">
                <div class="row">

                    <!-- Start Column 1 -->
                    <div class="col-md-12 col-lg-3 mb-5 mb-lg-0">
                        <h2 class="mb-4 section-title">Crafted with excellent material.</h2>
                        <p class="mb-4">Donec vitae odio quis nisl dapibus malesuada. Nullam ac aliquet velit. Aliquam vulputate velit imperdiet dolor tempor tristique. </p>
                        <p><a href="shop.jsp" class="btn">Explore</a></p>
                    </div> 
                    <!-- End Column 1 -->

                    <!-- Start Column 2 -->
                    <div class="col-12 col-md-4 col-lg-3 mb-5 mb-md-0">
                        <a class="product-item" href="cart.jsp">
                            <img src="images/product-1.png" class="img-fluid product-thumbnail">
                            <h3 class="product-title">Nordic Chair</h3>
                            <strong class="product-price">$50.00</strong>

                            <span class="icon-cross">
                                <img src="images/cross.svg" class="img-fluid">
                            </span>
                        </a>
                    </div> 
                    <!-- End Column 2 -->

                    <!-- Start Column 3 -->
                    <div class="col-12 col-md-4 col-lg-3 mb-5 mb-md-0">
                        <a class="product-item" href="cart.jsp">
                            <img src="images/product-2.png" class="img-fluid product-thumbnail">
                            <h3 class="product-title">Kruzo Aero Chair</h3>
                            <strong class="product-price">$78.00</strong>

                            <span class="icon-cross">
                                <img src="images/cross.svg" class="img-fluid">
                            </span>
                        </a>
                    </div>
                    <!-- End Column 3 -->

                    <!-- Start Column 4 -->
                    <div class="col-12 col-md-4 col-lg-3 mb-5 mb-md-0">
                        <a class="product-item" href="cart.jsp">
                            <img src="images/product-3.png" class="img-fluid product-thumbnail">
                            <h3 class="product-title">Ergonomic Chair</h3>
                            <strong class="product-price">$43.00</strong>

                            <span class="icon-cross">
                                <img src="images/cross.svg" class="img-fluid">
                            </span>
                        </a>
                    </div>
                    <!-- End Column 4 -->

                </div>
            </div>
        </div>
        <!-- End Product Section -->

        <!-- Include Header/Navigation -->
        <%@ include file="COMP\whychoose.jsp" %>

        <!-- Start We Help Section -->
        <div class="we-help-section">
            <div class="container">
                <div class="row justify-content-between">
                    <div class="col-lg-7 mb-5 mb-lg-0">
                        <div class="imgs-grid">
                            <div class="grid grid-1"><img src="images/img-grid-1.jpg" alt="Untree.co"></div>
                            <div class="grid grid-2"><img src="images/img-grid-2.jpg" alt="Untree.co"></div>
                            <div class="grid grid-3"><img src="images/img-grid-3.jpg" alt="Untree.co"></div>
                        </div>
                    </div>
                    <div class="col-lg-5 ps-lg-5">
                        <h2 class="section-title mb-4">We Help You Make Modern Interior Design</h2>
                        <p>Donec facilisis quam ut purus rutrum lobortis. Donec vitae odio quis nisl dapibus malesuada. Nullam ac aliquet velit. Aliquam vulputate velit imperdiet dolor tempor tristique. Pellentesque habitant morbi tristique senectus et netus et malesuada</p>

                        <ul class="list-unstyled custom-list my-4">
                            <li>Donec vitae odio quis nisl dapibus malesuada</li>
                            <li>Donec vitae odio quis nisl dapibus malesuada</li>
                            <li>Donec vitae odio quis nisl dapibus malesuada</li>
                            <li>Donec vitae odio quis nisl dapibus malesuada</li>
                        </ul>
                        <p><a herf="#" class="btn">Explore</a></p>
                    </div>
                </div>
            </div>
        </div>
        <!-- End We Help Section -->

        <!-- Start Popular Product -->
        <div class="popular-product">
            <div class="container">
                <div class="row">

                    <div class="col-12 col-md-6 col-lg-4 mb-4 mb-lg-0">
                        <div class="product-item-sm d-flex">
                            <div class="thumbnail">
                                <img src="images/product-1.png" alt="Image" class="img-fluid">
                            </div>
                            <div class="pt-3">
                                <h3>Nordic Chair</h3>
                                <p>Donec facilisis quam ut purus rutrum lobortis. Donec vitae odio </p>
                                <p><a href="#">Read More</a></p>
                            </div>
                        </div>
                    </div>

                    <div class="col-12 col-md-6 col-lg-4 mb-4 mb-lg-0">
                        <div class="product-item-sm d-flex">
                            <div class="thumbnail">
                                <img src="images/product-2.png" alt="Image" class="img-fluid">
                            </div>
                            <div class="pt-3">
                                <h3>Kruzo Aero Chair</h3>
                                <p>Donec facilisis quam ut purus rutrum lobortis. Donec vitae odio </p>
                                <p><a href="#">Read More</a></p>
                            </div>
                        </div>
                    </div>

                    <div class="col-12 col-md-6 col-lg-4 mb-4 mb-lg-0">
                        <div class="product-item-sm d-flex">
                            <div class="thumbnail">
                                <img src="images/product-3.png" alt="Image" class="img-fluid">
                            </div>
                            <div class="pt-3">
                                <h3>Ergonomic Chair</h3>
                                <p>Donec facilisis quam ut purus rutrum lobortis. Donec vitae odio </p>
                                <p><a href="#">Read More</a></p>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <!-- End Popular Product -->
        
        <!-- Include Header/Navigation -->
        <%@ include file="COMP\testimonial.jsp" %>
        
        <!-- Include Blog Section -->
        <%@ include file="COMP\blog.jsp" %>	

        <!-- Include Header/Navigation -->
        <%@ include file="COMP\footer.jsp" %>


        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/tiny-slider.js"></script>
        <script src="js/custom.js"></script>
    </body>

</html>
