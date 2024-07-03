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
        <title>Posts</title>
        <style>
            body {
                background-color: #f4f7f6;
                margin-top: 20px;
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
            @media (max-width: 640px) {
                .blog-page .left-box .single-comment-box>ul>li {
                    padding: 25px 0;
                }
                .blog-page .left-box .single-comment-box ul li .icon-box {
                    display: inline-block;
                }
                .blog-page .left-box .single-comment-box ul li .text-box {
                    display: block;
                    padding-left: 0;
                    margin-top: 10px;
                }
                .blog-page .single_post .footer .stats {
                    float: none;
                    margin-top: 10px;
                }
                .blog-page .single_post .body,
                .blog-page .single_post .footer {
                    padding: 30px;
                }
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

            .single_post .img-post .img-link img {
                width: auto;
                height: 100%;
                object-fit: cover;
                object-position: center;
                transform: scale(1);
                opacity: 1;
                transition: transform .4s ease, opacity .4s ease;
                max-width: 100%;
                filter: none;
                transform: scale(1.01);
            }

            .single_post .img-post .img-link:hover img {
                transform: scale(1.02);
                opacity: .7;
                filter: grayscale(1);
                transition: all .8s ease-in-out;
            }
            .search-form {
                display: inline-block;
                justify-content: flex-end;
            }

            .search-form input[type="text"],
            .search-form button {
                display: inline-block;
                vertical-align: top;
            }

            .search-form input[type="text"] {
                width: 200px; /* Adjust width as needed */
                padding: 8px;
            }

            .search-form button {
                padding: 8px 15px;
                background-color: #007bff;
                color: #fff;
                border: none;
                cursor: pointer;
            }

            .search-form button:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>

        <c:set var="page" value="blog" />

        <!-- Include Header/Navigation -->
        <%@ include file="COMP/header.jsp" %>
        <!-- Include Blog Section -->

        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />

        <div id="main-content" class="blog-page" style="padding-top: 100px;">



            <div class="container">
                <div class="row clearfix">
                    <div class="col-lg-8 col-md-12 left-box">

                        <div class="card single_post">
                            <div class="body">
                                <div class="img-post">
                                    <a href="productdetails?id=${product.productID}">
                                        <img class="d-block img-fluid" src="${post.thumbnailLink}" alt="${post.title}">
                                    </a>
                                </div>
                                <div style="display: flex; justify-content: space-between; align-items: center;">
                                     <a href="productdetails?id=${product.productID}">
                                    <h3 style="font-size: 28px;">${post.title}</h3>
                                    </a>
                                    <h5>From ${post.updatedDate}</h5>
                                </div>
                                <h5>By ${post.staff}</h5>
                                <p>${post.content}</p>
                            </div>                        
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-12 right-box">
                        <div id="myDIV" style="display: flex; justify-content: right; margin-bottom: 10px;">
                            <form class="search-form" style="" action="blog" method="GET">
                                <input type="text" name="txt" placeholder="Search...">
                                <button type="submit">Search</button>
                            </form>

                        </div>
                        <div class="card">
                            <div class="header">
                                <h2>Categories</h2>
                            </div>
                            <div class="body widget">
                                <ul class="list-unstyled categories-clouds m-b-0">
                                    <c:forEach items="${pcl}" var="pcl">
                                        <li><a href="blog?formSubmitted=false&txt=&category=${pcl.postCL}&sortCriteria=1&sortOptions=1">${pcl.name}</a></li>
                                        </c:forEach>
                                </ul>
                            </div>
                        </div>
                        <div class="card">
                            <div class="header">
                                <h2>Related Posts</h2>                        
                            </div>
                            <div class="body widget popular-post">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <c:if test="${empty posts}">
                                            <div class="col-12">
                                                <p style="font-size: 16px;">No posts available.</p>
                                            </div>
                                        </c:if>
                                        <c:forEach items="${recentPosts}" var="rp">
                                            <div class="single_post">
                                                <p class="m-b-0">${rp.title}</p>
                                                <span>By ${rp.staff} in ${rp.updatedDate}</span>
                                                <div class="img-post" style="max-height: 144px; overflow: hidden; position: relative; display: flex; justify-content: center; align-items: center;">
                                                    <a href="blogdetail?id=${rp.postID}"><img src="${rp.thumbnailLink}" alt="Awesome Image" style="width: auto; height: 100%; object-fit: cover; object-position: center;"></a>
                                                </div>                                       
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

        <%@ include file="COMP/footer.jsp" %>

        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/tiny-slider.js"></script>
        <script src="js/custom.js"></script>
    </body>
</html>
