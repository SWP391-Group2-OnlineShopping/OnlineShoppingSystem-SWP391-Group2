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
        <link href="css/blogcommon.css" rel="stylesheet">
        <title>Posts</title>

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
                                    <a class="img-link" href="productdetails?id=${product.productID}">
                                        <img class="d-block img-fluid" src="${post.thumbnailLink}" alt="${post.title}">
                                        <div class="overlay">
                                            <div class="overlay-text"> ${post.product.title}</div>
                                        </div>
                                    </a>
                                </div>
                                <div style="display: flex; justify-content: space-between; align-items: center;">
                                    <div class="post-container">
                                        <a href="productdetails?id=${product.productID}" class="title-link">
                                            <h4>${post.title}</h4>
                                            <div class="title-overlay">${post.product.title}</div>
                                        </a>
                                    </div>
                                    <h6 style="white-space: nowrap;">From ${post.updatedDate}</h6>
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
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const titleLinks = document.querySelectorAll('.title-link');

                titleLinks.forEach(titleLink => {
                    titleLink.addEventListener('mouseenter', function () {
                        const overlay = titleLink.querySelector('.title-overlay');
                        const rect = titleLink.getBoundingClientRect();
                        const overlayHeight = overlay.offsetHeight;

                        // Check if there is enough space above
                        if (rect.top < overlayHeight) {
                            // Not enough space above, position below
                            overlay.classList.remove('above');
                            overlay.classList.add('below');
                        } else {
                            // Enough space above, position above
                            overlay.classList.remove('below');
                            overlay.classList.add('above');
                        }
                    });
                });
            });
        </script>
    </body>
</html>
