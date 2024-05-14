<%-- 
    Document   : about
    Created on : May 10, 2024, 3:31:57 PM
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

        <!-- Include Header/Navigation -->
        <%@ include file="COMP\whychoose.jsp" %>

        <!-- Start Team Section -->
        <div class="untree_co-section">
            <div class="container">

                <div class="row mb-5">
                    <div class="col-lg-5 mx-auto text-center">
                        <h2 class="section-title">Our Team</h2>
                    </div>
                </div>

                <div class="row">

                    <!-- Start Column 1 -->
                    <div class="col-12 col-md-6 col-lg-3 mb-5 mb-md-0">
                        <img src="images/person_1.jpg" class="img-fluid mb-5">
                        <h3 clas><a href="#"><span class="">Trương Nguyễn</span> Việt Quang</a></h3>
                        <span class="d-block position mb-4">CEO, Founder, Atty.</span>
                        <p>Separated they live in.
                            Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean.</p>
                        <p class="mb-0"><a href="#" class="more dark">Learn More <span class="icon-arrow_forward"></span></a></p>
                    </div> 
                    <!-- End Column 1 -->

                    <!-- Start Column 2 -->
                    <div class="col-12 col-md-6 col-lg-3 mb-5 mb-md-0">
                        <img src="images/person_2.jpg" class="img-fluid mb-5">

                        <h3 clas><a href="#"><span class="">Nguyễn </span> Bảo Khánh</a></h3>
                        <span class="d-block position mb-4">CEO, Founder, Atty.</span>
                        <p>Separated they live in.
                            Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean.</p>
                        <p class="mb-0"><a href="#" class="more dark">Learn More <span class="icon-arrow_forward"></span></a></p>

                    </div> 
                    <!-- End Column 2 -->

                    <!-- Start Column 3 -->
                    <div class="col-12 col-md-6 col-lg-3 mb-5 mb-md-0">
                        <img src="images/person_3.jpg" class="img-fluid mb-5">
                        <h3 clas><a href="#"><span class="">Nguyễn</span> Đức Anh</a></h3>
                        <span class="d-block position mb-4">CEO, Founder, Atty.</span>
                        <p>Separated they live in.
                            Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean.</p>
                        <p class="mb-0"><a href="#" class="more dark">Learn More <span class="icon-arrow_forward"></span></a></p>
                    </div> 
                    <!-- End Column 3 -->

                    <!-- Start Column 4 -->
                    <div class="col-12 col-md-6 col-lg-3 mb-5 mb-md-0">
                        <img src="images/person_4.jpg" class="img-fluid mb-5">

                        <h3 clas><a href="#"><span class="">Nguyễn</span> Tùng Lâm</a></h3>
                        <span class="d-block position mb-4">CEO, Founder, Atty.</span>
                        <p>Separated they live in.
                            Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean.</p>
                        <p class="mb-0"><a href="#" class="more dark">Learn More <span class="icon-arrow_forward"></span></a></p>


                    </div> 
                    <!-- End Column 4 -->



                </div>
            </div>
        </div>
        <!-- End Team Section -->

        <!-- Include Testimonial Slider -->
        <%@ include file="COMP\testimonial.jsp" %>
        
        <!-- Include Header/Navigation -->
        <%@ include file="COMP\footer.jsp" %>	

        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/tiny-slider.js"></script>
        <script src="js/custom.js"></script>
    </body>

</html>

