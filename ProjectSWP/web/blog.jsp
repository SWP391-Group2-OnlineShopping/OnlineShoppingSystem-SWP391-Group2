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
            .post-thumbnail {
                width: 100%;
            }

            .post-entry .row {
                display: flex;
            }

            .post-entry .col-6 {
                flex: 0 0 50%;
                max-width: 50%;
            }

            .post-entry .post-content-entry {
                padding-left: 15px;
            }

        </style>
    </head>
    <body>
        <c:set var="page" value="blog" />
        <!-- Include Header/Navigation -->
        <%@ include file="COMP\header.jsp" %>
        <%@ include file="COMP\feature-blog-comp.jsp" %>
        <div class="container" style="padding-top:110px; padding-bottom: 200px">
            <div class="row">
                <!-- Filter Panel -->


                <!-- Blog Posts List -->
                <div class="col-md-8">
                    <!-- Content will be refreshed upon form submission -->
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h3 class="mb-0"> Result: </h3>
                    </div>
                    <div class="blog-section" id="blogList">
                        <!-- Content loaded via server-side rendering -->
                        <c:if test="${empty posts}">
                            <div class="col-12">
                                <p>No posts available.</p>
                            </div>
                        </c:if>
                        <c:forEach items="${posts}" var="p">
                            <div class="col-12 col-sm-12 col-md-10">
                                <div class="post-entry">
                                    <div class="row">
                                        <div class="col-6">
                                            <a href="blogdetail?id=${p.postID}" class="post-thumbnail"><img style="margin-bottom: 15px;" src=${p.thumbnailLink} alt="Image" class="img-fluid"></a>
                                        </div>
                                        <div class="col-6" >
                                            <div class="post-content-entry">
                                                <h3><a href="blogdetail?id=${p.postID}">${p.title}</a></h3>
                                                <div class="meta">
                                                    <span>by <a href="#">${p.staff}</a></span> <span>on <a href="#">${p.updatedDate}</a></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                    </div>
                </div>
                <div class="col-md-4">
                    <div class="filter-panel">
                        <h3>Blog Categories</h3>



                        <h4 class="clickable-link" onclick="toggleFilter(this)">Toggle Filter</h4>
                        <!-- Modified: Include all filters within a single form -->
                        <form id="filterForm" action="blog" method="get">
                            <input type="hidden" id="formSubmitted" name="formSubmitted" value="true">
                            <input type="hidden" name="page" value="${param.page != null ? param.page : 1}">
                            <div id="filterContent" class="<c:if test='${param.formSubmitted == null}'>hidden</c:if>">
                                <div id="searchBox" class="<c:if test='${param.formSubmitted == null}'>hidden</c:if>">
                                    <input type="text" id="searchInput" name="txt" value="${param.txt}" placeholder="Search...">
                                </div>
                                <c:forEach items="${category}" var="c">
                                    <input type="checkbox" style="margin-bottom: 10px;" name="category" value="${c.getPostCL()}" <c:if test="${c.checked}">checked</c:if>>
                                    ${c.name}
                                    <br>
                                </c:forEach>
                                <label for="sortOptions">Sort By:</label>
                                <select name="sortCriteria" class="form-control w-auto" style="margin-bottom: 10px;">
                                    <option value="1" <c:if test="${param.sortCriteria == 1}">selected</c:if>>Updated Date</option>
                                    <option value="2" <c:if test="${param.sortCriteria == 2}">selected</c:if>>A-Z</option>
                                    </select>
                                    <select name="sortOptions" class="form-control w-auto">
                                        <option value="1" <c:if test="${param.sortOptions == 1}">selected</c:if>>Ascending</option>
                                    <option value="2" <c:if test="${param.sortOptions == 2}">selected</c:if>>Descending</option>
                                    </select>
                                    <button type="submit" class="btn btn-primary mt-2">Apply Filters</button>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
            <div class="pagination">
                <a href="?formSubmitted=true&page=${param.page - 1 > 0 ? param.page - 1 : 1}&txt=${param.txt}${categoriesParam}&sortCriteria=${param.sortCriteria}&sortOptions=${param.sortOptions}">&laquo;</a>
            <c:forEach begin="1" end="${endPage}" var="i">
                <a href="?formSubmitted=true&page=${i}&txt=${param.txt}${categoriesParam}&sortCriteria=${param.sortCriteria}&sortOptions=${param.sortOptions}" class="${i == param.page ? 'active' : ''}">${i}</a>
            </c:forEach>
            <a href="?formSubmitted=true&page=${param.page + 1 <= endPage ? param.page + 1 : endPage}&txt=${param.txt}${categoriesParam}&sortCriteria=${param.sortCriteria}&sortOptions=${param.sortOptions}">&raquo;</a>
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
