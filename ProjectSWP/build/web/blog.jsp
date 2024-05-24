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
            .hidden {
                display: none;
            }

            #searchBox {
                margin-top: 10px;
            }

            #searchInput {
                padding: 5px;
                margin-right: 5px;
            }
            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 10px 0;
                font-size: 20px;
            }

            .pagination a {
                color: black;
                float: left;
                padding: 8px 16px;
                text-decoration: none;
                border: 1px solid black;
                border-radius: 5px; 
                margin: 0 4px; 
                transition: background-color .3s, border-color .3s; 
            }

            .pagination a.active {
                background-color: #4CAF50;
                color: white;
                border: 1px solid #4CAF50; 
            }

            .pagination a:hover:not(.active) {
                background-color: #ddd;
                border-color: orange; 
            }

        </style>
    </head>
    <body>
        <c:set var="page" value="blog" />
        <!-- Include Header/Navigation -->
        <%@ include file="COMP\header.jsp" %>
        <!-- Include Banner slider -->
        <%@ include file="COMP\testimonial.jsp" %>

        <div class="container" style="padding-bottom: 200px">
            <div class="row">
                <!-- Filter Panel -->
                <div class="col-md-4">
                    <div class="filter-panel">
                        <h3>Blog Categories</h3>



                        <h4 class="clickable-link" onclick="toggleFilter(this)">Toggle Filter</h4>
                        <!-- Modified: Include all filters within a single form -->
                        <form id="filterForm" action="blog" method="post">
                            <input type="hidden" id="formSubmitted" name="formSubmitted" value="${param.formSubmitted != null ? 'true' : 'false'}">
                            <div id="filterContent" class="<c:if test='${param.formSubmitted == null}'>hidden</c:if>">
                                <div id="searchBox" class="<c:if test='${param.formSubmitted == null}'>hidden</c:if>">
                                    <input type="text" id="searchInput" name="txt" value="${search}" placeholder="Search...">

                                </div>
                                <c:forEach items="${category}" var="c">

                                    <input type="checkbox" style="margin-bottom: 10px;" name="category" value="${c.getPostCL()}" ${c.checked ? 'checked' : ''}>
                                    ${c.name}
                                    <br>
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
                                </div>
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
                                        <a href="blogdetail?id=${p.postID}" class="post-thumbnail"><img src="images/post-1.jpg" alt="Image" class="img-fluid"></a>
                                        <div class="post-content-entry">
                                            <h3><a href="blogdetail?id=${p.postID}">${p.title}</a></h3>
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
        <div class="pagination">
            <a href="#">&laquo;</a>
            <a href="#">1</a>
            <a href="#">2</a>
            <a href="#">3</a>
            <a href="#">4</a>
            <a href="#">5</a>
            <a href="#">6</a>
            <a href="#">&raquo;</a>
        </div>

        <%@ include file="COMP/footer.jsp" %>

        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/tiny-slider.js"></script>
        <script src="js/custom.js"></script>
        <script>

                            function toggleFilter(element) {
                                const filterContent = document.getElementById('filterContent');
                                if (filterContent.classList.contains('hidden')) {
                                    filterContent.classList.remove('hidden');
                                } else {
                                    filterContent.classList.add('hidden');
                                }

                                var searchBox = document.getElementById('searchBox');
                                if (searchBox.classList.contains('hidden')) {
                                    searchBox.classList.remove('hidden');
                                } else {
                                    searchBox.classList.add('hidden');
                                }
                            }
        </script>
    </body>
</html>
