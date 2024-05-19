<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, dal.*, model.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>

<%
    PostDAO postDAO = new PostDAO();
    List<Posts> blogPosts = postDAO.getMostRecentBlogs();
    request.setAttribute("blogPosts", blogPosts);
%>
<div class="blog-section py-5 ">

    <div class="container mb-5">
        <div class=" col-md-2">
            <div class="col-md-12">
                <h2 class="section-title">Recent Blog</h2>
            </div>
            <div class="col-md-12">
                <a href="#" class="">View All Posts</a>
            </div>
        </div>

        <div class="ml-5 row justify-content-center col-md-10">
            <c:forEach var="post" items="${blogPosts}" varStatus="status">
                <% 
                    StaffDAO staffDAO = new StaffDAO();
                    int staffId = ((Posts)pageContext.getAttribute("post")).getStaffId();
                    String staffName = staffDAO.getStaffById(staffId).getUsername();
                %>
                <c:if test="${status.index % 3 == 0}">
                    <div class="row">
                    </c:if>
                    <div class="col-12 col-sm-6 col-md-4 mb-4">
                        <div class="card h-100">
                            <a href="#" class="post-thumbnail"><img src="images/post-1.jpg" alt="Image" class="card-img-top"></a>
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
</div>