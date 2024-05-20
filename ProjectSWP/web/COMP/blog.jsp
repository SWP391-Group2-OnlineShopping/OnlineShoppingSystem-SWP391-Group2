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
        <div class="row ">
            <div class="col-md-6">
                <h2 class="section-title">Recent Blog</h2>
            </div>
            
        </div>

        <div class="row">
            <c:if test="${empty posts}">
                <p>No posts available.</p>
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