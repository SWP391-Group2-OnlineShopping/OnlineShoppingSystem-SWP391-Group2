<%-- 
    Document   : blog-detail
    Created on : May 22, 2024, 10:30:30 AM
    Author     : DELL
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
        <title>Posts    </title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: Arial, sans-serif;
                line-height: 1.6;
                padding: 20px;
            }

            .container {
                display: flex;
                flex-direction: row;
                justify-content: space-between;
            }

            .main-content {
                flex: 3;
                margin-right: 20px;
            }

            .ad {
                width: 100%;
                height: 200px;
                margin-bottom: 20px;
                overflow: hidden; /* Ensures the image stays within the bounds */
            }

            .ad img {
                width: 100%;
                height: 100%;
                object-fit: cover; /* Ensures the image covers the div without distortion */
            }

            .info {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
            }

            .info .author,
            .info .categories {
                background-color: #f0f0f0;
                padding: 10px;
                border-radius: 5px;
            }

            .text-content {
                font-size: 16px;
            }

            .sidebar {
                flex: 1;
                margin-left: 20px;
            }

            .related-posts {
                background-color: #f9f9f9;
                padding: 20px;
                border-radius: 5px;
            }

            .related-posts h3 {
                margin-bottom: 20px;
            }

            .related-post {
                display: flex;
                margin-bottom: 20px;
            }

            .related-post .thumbnail {
                width: 60px;
                height: 60px;
                background-color: #ddd;
                margin-right: 10px;
            }

            .related-post .details {
                display: flex;
                align-items: center;
            }

            .related-post .title {
                font-size: 14px;
            }

        </style>

    </head>
    <body>

        <c:set var="page" value="blog-detail" />
        <%@ include file="COMP/header.jsp" %>
        <%@ include file="COMP/hero.jsp" %>
        <%@ include file="COMP/blog.jsp" %>

        <div class="container">
            <div class="main-content">
                <div class="ad">
                    <img src="path/to/your/ad-image.jpg" alt="Ad">
                </div>
                <div class="info">
                    <div class="author">Author: ???</div>
                    <div class="categories">Categories: Category1, Category2</div>
                </div>
                <div class="text-content">
                    <p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.</p>
                </div>
            </div>
            <div class="sidebar">
                <div class="related-posts">
                    <h3>Related Posts</h3>
                    <div class="related-post">
                        <div class="thumbnail"></div>
                        <div class="details">
                            <div class="title">Title, Author, and Date Created</div>
                        </div>
                    </div>
                    <div class="related-post">
                        <div class="thumbnail"></div>
                        <div class="details">
                            <div class="title">Title, Author, and Date Created</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="COMP/testimonial.jsp" %>
        <%@ include file="COMP/footer.jsp" %>

        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/tiny-slider.js"></script>
        <script src="js/custom.js"></script>
    </body>
</html>
