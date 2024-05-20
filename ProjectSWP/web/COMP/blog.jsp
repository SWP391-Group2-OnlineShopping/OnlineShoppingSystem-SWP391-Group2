<%-- 
    Document   : blog
    Created on : May 14, 2024, 2:54:44 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<link href="css/tiny-slider.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<div class="blog-section">
    <div class="container">
        <div class="row col-md-3">
            <c:forEach items="${category}" var="c">
                    <div class="col-12 col-sm-6 col-md-4 mb-4 mb-md-0">
                        <div class="post-entry">
                            <div class="post-content-entry">
                                <h3><a href="#">${c.name}</a></h3>
                                <div class="meta">
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
        </div>

        <div class="row blog-section col-sm-9">

            <div class="row justify-content-center">
                <div class="col-md-12 text-center">
                    <h2 class="section-title" style="margin-bottom: 10px;">Recent Blog</h2>
                </div>
            </div>
            <c:if test="${empty posts}">
                <div class="col-12">
                    <p>No posts available.</p>
                </div>
            </c:if>
            <c:if test="${!empty posts}">
                <c:forEach items="${posts}" var="p">
                    <div class="col-12 col-sm-6 col-md-4 mb-4 mb-md-0">
                        <div class="post-entry">
                            <a href="#" class="post-thumbnail"><img src="images/post-1.jpg" alt="Image" class="img-fluid"></a>
                            <div class="post-content-entry">
                                <h3><a href="#">${p.title}</a></h3>
                                <div class="meta">
                                    <span>by <a href="#">${p.staff}</a></span> <span>on <a href="#">${p.updatedDate}</a></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
        </div>

    </div>
</div>