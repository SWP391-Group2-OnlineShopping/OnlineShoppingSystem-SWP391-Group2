<%-- 
    Document   : blog
    Created on : May 10, 2024, 3:31:28 PM
    Author     : admin
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
        <title>Blogs</title>
        <style>
            .clickable-link {
                cursor: pointer;
                text-decoration: none; /* Initial state without underline */
                color: inherit; /* Keep the color of the text the same */
            }
            .clickable-link:hover {
                text-decoration: underline; /* Underline on hover */
            }
        </style>
    </head>
    <body>
        <c:set var="page" value="blog" />
        <%@ include file="COMP/header.jsp" %>
        <%@ include file="COMP/hero.jsp" %>
        <%@ include file="COMP/blog.jsp" %>

        <div class="container" style="padding-bottom: 200px">
            <div class="row">
                <!-- Filter Panel -->
                <div class="col-md-4">
                    <div class="filter-panel">
                        <h3>Blog Categories</h3>
                        <h4 class="clickable-link" onclick="toggleFilter(this)">Toggle Filter</h4>
                        <!-- Modified: Include all filters within a single form -->
                        <form id="filterForm" action="blog" method="post">
                            <c:forEach items="${category}" var="c">
                                <label>
                                    <input type="checkbox" name="category" value="${c.getPostCL()}" ${c.checked ? 'checked' : ''}>
                                    ${c.name}
                                </label><br>
                            </c:forEach>
                            <!-- Added: Include sorting options within the form -->
                            <label for="sortOptions">Sort By:</label>
                            <select name="sortCriteria" class="form-control w-auto" style="margin-bottom: 10px;">
                                <option value="1" <c:if test="${sortCriteria == 1}">selected</c:if>>Updated Date</option>
                                <option value="2" <c:if test="${sortCriteria == 2}">selected</c:if>>A-Z</option>
                                </select>
                                <select name="sortOptions" class="form-control w-auto">
                                    <option value="1" <c:if test="${sortOptions == 1}">selected</c:if>>Ascending</option>
                                <option value="2" <c:if test="${sortOptions == 2}">selected</c:if>>Descending</option>
                                </select>

                                <!-- Added: Submit button -->
                                <button type="submit" class="btn btn-primary mt-2">Apply Filters</button>
                            </form>
                        </div>
                    </div>

                    <!-- Blog Posts List -->
                    <div class="col-md-8">
                        <!-- Content will be refreshed upon form submission -->
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h3 class="mb-0">Recent Blog</h3>
                        </div>
                        <div class="blog-section" id="blogList">
                            <!-- Content loaded via server-side rendering -->
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
        </div>


        <%@ include file="COMP/testimonial.jsp" %>
        <%@ include file="COMP/footer.jsp" %>

        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/tiny-slider.js"></script>
        <script src="js/custom.js"></script>
        <script>
                            function toggleFilter(element) {
                                const filterContent = element.nextElementSibling;
                                if (filterContent.style.display === "none" || filterContent.style.display === "") {
                                    filterContent.style.display = "block";
                                } else {
                                    filterContent.style.display = "none";
                                }
                            }
        </script>
    </body>
</html>
