<%-- 
    Document   : header
    Created on : May 14, 2024, 1:25:40 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<nav class="custom-navbar navbar navbar navbar-expand-md navbar-dark bg-dark" aria-label="Furni navigation bar">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">DiLuri<span>.</span></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsFurni" aria-controls="navbarsFurni" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarsFurni">
            <ul class="custom-navbar-nav navbar-nav mx-auto mb-2 mb-md-0">
                <li class="nav-item active ms-5">
                    <a class="nav-link" href="index.jsp">Home</a>
                </li>
                <li><a class="nav-link" href="shop.jsp">Shop</a></li>
                <li><a class="nav-link" href="about.jsp">About us</a></li>
                <li><a class="nav-link" href="blog.jsp">Blog</a></li>
            </ul>
            <ul class="custom-navbar-cta navbar-nav mb-2 mb-md-0 ms-5">
                <li><a class="nav-link" href="login.jsp"><img src="images/user.svg"></a></li>
                <li><a class="nav-link" href="cart.jsp"><img src="images/cart.svg"></a></li>
                <li>
                    <form class="d-flex" action="product" method="get">
                        <input class="form-control me-2" type="search" placeholder="Tìm kiếm" aria-label="Search" name="search" id="searchInput">
                        <button class="btn btn-outline-success" type="submit">Tìm kiếm</button>
                    </form>
                </li>
            </ul>
        </div>
    </div>
</nav>


