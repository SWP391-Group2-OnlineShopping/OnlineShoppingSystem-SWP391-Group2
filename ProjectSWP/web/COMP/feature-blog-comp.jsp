<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, dal.*, model.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<style>.testimonial-section {
    }

    .testimonial-slider-wrap {
        position: relative;
    }
    .testimonial-slider-wrap .tns-inner {
    }
    .testimonial-slider-wrap .item .testimonial-block blockquote {
        font-size: 16px;
    }
    @media (min-width: 768px) {
        .testimonial-slider-wrap .item .testimonial-block blockquote {
            line-height: 32px;
            font-size: 18px;
        }
    }
    .testimonial-slider-wrap .item .testimonial-block .author-info .author-pic {
        margin-bottom: 20px;
    }
    .testimonial-slider-wrap .item .testimonial-block .author-info .author-pic img {
        max-width: 80rem;
        border-radius: 50%;
    }
    .testimonial-slider-wrap .item .testimonial-block .author-info h3 {
        font-size: 14px;
        font-weight: 700;
        color: #2f2f2f;
        margin-bottom: 0;
    }
    .testimonial-slider-wrap #testimonial-nav {
        position: absolute;
        top: 50%;
        z-index: 99;
        width: 100%;
        display: none;
    }
    @media (min-width: 768px) {
        .testimonial-slider-wrap #testimonial-nav {
            display: block;
        }
    }
    .testimonial-slider-wrap #testimonial-nav > span {
        cursor: pointer;
        position: absolute;
        width: 58px;
        height: 58px;
        line-height: 58px;
        border-radius: 50%;
        background: rgba(59, 93, 80, 0.1);
        color: #2f2f2f;
        -webkit-transition: .3s all ease;
        -o-transition: .3s all ease;
        transition: .3s all ease;
    }
    .testimonial-slider-wrap #testimonial-nav > span:hover {
        background: #3b5d50;
        color: #ffffff;
    }
    .testimonial-slider-wrap #testimonial-nav .prev {
        left: -10px;
    }
    .testimonial-slider-wrap #testimonial-nav .next {
        right: 0;
    }
    .testimonial-slider-wrap .tns-nav {
        position: absolute;
        bottom: -50px;
        left: 50%;
        -webkit-transform: translateX(-50%);
        -ms-transform: translateX(-50%);
        transform: translateX(-50%);
    }
    .testimonial-slider-wrap .tns-nav button {
        background: none;
        border: none;
        display: inline-block;
        position: relative;
        width: 0 !important;
        height: 7px !important;
        margin: 2px;
    }
    .testimonial-slider-wrap .tns-nav button:active, .testimonial-slider-wrap .tns-nav button:focus, .testimonial-slider-wrap .tns-nav button:hover {
        outline: none;
        -webkit-box-shadow: none;
        box-shadow: none;
        background: none;
    }
    .testimonial-slider-wrap .tns-nav button:before {
        display: block;
        width: 7px;
        height: 7px;
        left: 0;
        top: 0;
        position: absolute;
        content: "";
        border-radius: 50%;
        -webkit-transition: .3s all ease;
        -o-transition: .3s all ease;
        transition: .3s all ease;
        background-color: #d6d6d6;
    }
    .testimonial-slider-wrap .tns-nav button:hover:before, .testimonial-slider-wrap .tns-nav button.tns-nav-active:before {
        background-color: #3b5d50;
    }
</style>
<link href="css/productcss.css" rel="stylesheet">
<%
    PostDAO postDAO = new PostDAO();
    List<Posts> blogPosts = postDAO.getAllPost();
    request.setAttribute("blogPosts", blogPosts);
%>
<div class="blog-section py-5 ">

    <div class="container">
        <div class="">
            <div class="col-md-12">
                <h2 class="section-title">Recent Blogs</h2>
            </div>
            <div class="col-md-12">
                <a href="#" class="">View All Posts</a>
            </div>
        </div>
        <div class="">
            <!-- Start Testimonial Slider -->
            <div class="testimonial-section">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-12">
                            <div class="testimonial-slider-wrap text-center">

                                <div id="testimonial-nav">
                                    <span class="prev" data-controls="prev"><span class="fa fa-chevron-left"></span></span>
                                    <span class="next" data-controls="next"><span class="fa fa-chevron-right"></span></span>
                                </div>

                                <div class="testimonial-slider">

                                    <div class="item">
                                        <div class="ml-5 row justify-content-center col-md-10">
                                            <c:forEach var="post" items="${blogPosts}" varStatus="status">
                                                <% 
                                                    StaffDAO staffDAO = new StaffDAO();
                                                    int staffId = ((Posts)pageContext.getAttribute("post")).getStaffID();
                                                    String staffName = staffDAO.getStaffById(staffId).getUsername();
                    
                                                    // Get the first image for the post
                                                    Images postImage = postDAO.getPostImage(((Posts)pageContext.getAttribute("post")).getPostID());
                                                    String imageUrl = (postImage != null) ? postImage.getLink() : "images/post-2.jpg";
                                                %>
                                                <!-- TODO: cap nhat link blog detail -->
                                                <c:if test="${status.index % 3 == 0}">
                                                    <div class="row">
                                                    </c:if>
                                                    <div class="col-12 col-sm-6 col-md-4 mb-4">
                                                        <div class="card h-100">
                                                            <a href="#" class="post-thumbnail"><img src="<%= imageUrl %>" alt="Image" class="card-img-top"></a>
                                                            <div class="card-body">
                                                                <h3 ><a href="#" class="title-link" >${post.title}</a></h3>
                                                                <div class="card-text">
                                                                    <span class="d-block text-muted">by <%= staffName %></span> 
                                                                    <span class="text-muted">on ${post.updatedDate}</span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <c:if test="${status.index % 3 == 2 || status.index == blogPosts.size() - 1}">
                                                    </div>
                                                </c:if>
                                            </c:forEach>

                                        </div>
                                    </div> 
                                    <!-- END item -->
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Testimonial Slider -->
        </div>

    </div>
</div>
