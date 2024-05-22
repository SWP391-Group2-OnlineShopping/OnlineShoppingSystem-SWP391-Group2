<%-- 
    Document   : header
    Created on : May 17, 2024, 4:24:14 PM
    Author     : Admin
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="header__top__left">
    <c:if test="${sessionScope.message != null}">
        <script>

            alert("${sessionScope.message}");
            

            <%
                session.removeAttribute("message");
            %>
        </script>
    </c:if>
</div>

<nav class="custom-navbar navbar navbar-expand-md navbar-dark bg-dark" aria-label="Furni navigation bar">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">DiLuri<span>.</span></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsFurni" aria-controls="navbarsFurni" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarsFurni">
            <ul class="custom-navbar-nav navbar-nav mx-auto mb-md-0">
                <li class="nav-item <c:if test="${page == 'index'}">active</c:if> ms-5">
                        <a class="nav-link" href="index.jsp">Home</a>
                    </li>
                    <li class="nav-item <c:if test="${page == 'shop'}">active</c:if>">
                        <a class="nav-link" href="product">Shop</a>
                    </li>
                    <li class="nav-item <c:if test="${page == 'blog'}">active</c:if>">
                        <a class="nav-link" href="blog.jsp">Blog</a>
                    </li>
                    <li class="nav-item <c:if test="${page == 'about'}">active</c:if>">
                        <a class="nav-link" href="about.jsp">About us</a>
                    </li>

                </ul>
                <ul class="custom-navbar-cta navbar-nav mb-2 mb-md-0 ms-5">
                    <li class="nav-item">
                        <form class="d-flex" action="product" method="get" id="searchForm">
                            <input class="form-control form-control-sm me-2 thin-search-bar" type="search" placeholder="Tìm kiếm..." aria-label="Search" name="search" id="searchInput">
                        </form>
                    </li>
                <c:if test="${sessionScope.acc == null}">
                    <li><a class="nav-link" href="login.jsp"><img src="images/user.svg"></a></li>
                        </c:if>
                        <c:if test="${sessionScope.acc != null}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            ${sessionScope.acc.user_name}
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="customerInfo?id=${sessionScope.acc.customer_id}">Profile</a></li>
                            <li><a class="dropdown-item" href="logout">Log out</a></li>
                        </ul>
                    </li>
                    <li><a class="nav-link" href="cart.jsp"><img src="images/cart.svg"></a></li>
                        </c:if>

                <c:if test="${sessionScope.staff != null}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            ${sessionScope.staff.username}
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="customerInfo?id=${sessionScope.staff.staffID}">Profile</a></li>
                            <li><a class="dropdown-item" href="logout">Log out</a></li>
                        </ul>
                    </li>
                    <li><a class="nav-link" href="dashboardmkt"><img src="images/cart.svg"></a></li>
                        </c:if>
            </ul>
        </div>

        <script>
            document.getElementById("searchInput").addEventListener("keypress", function (event) {
                if (event.keyCode === 13) { // 'Enter' key
                    event.preventDefault(); // Prevent default form submission
                    document.getElementById("searchForm").submit(); // Submit the form
                }
            });
        </script>
    </div>
</nav>
