<%-- 
    Document   : header
    Created on : May 14, 2024, 1:25:40 PM
    Author     : Admin
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<nav class="custom-navbar navbar navbar navbar-expand-md navbar-dark bg-dark" aria-label="Furni navigation bar">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">DiLuri<span>.</span></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsFurni" aria-controls="navbarsFurni" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarsFurni">
            <ul class="custom-navbar-nav navbar-nav mx-auto mb-2 mb-md-0">
                <li class="nav-item <c:if test="${page == 'index'}">active</c:if> ms-5">
                        <a class="nav-link" href="index.jsp">Home</a>
                    </li>
                    <li class="nav-item <c:if test="${page == 'shop'}">active</c:if>">
                    <li><a class="nav-link" href="product">Shop</a></li>
                    </li>
                    <li class="nav-item <c:if test="${page == 'about'}">active</c:if>">
                        <a class="nav-link" href="about.jsp">About Us</a>
                    </li>
                    <li class="nav-item <c:if test="${page == 'blog'}">active</c:if>">
                        <a class="nav-link" href="blog">Blog</a>
                    </li>
                </ul>
                <ul class="custom-navbar-cta navbar-nav mb-2 mb-md-0 ms-5">


                <c:if test="${sessionScope.acc==null}">
                    <li><a class="nav-link" href="login.jsp"><img src="images/user.svg"></a></li>
                    <!--                    <li><a class="nav-link" href="cart.jsp"><img src="images/cart.svg"></a></li> -->
                </c:if>

                <c:if test="${sessionScope.acc!=null}">
                    <div class="header__top__hover">
                        <span>${sessionScope.acc.user_name} <i class="arrow_carrot-down"></i></span>
                        <ul>
                            <li><a href="customerInfo?id=${sessionScope.acc.customer_id}">Profile</a> </li>
                            <!--                            <li><a href="myorder?acid=sessionScope.acc.user_id">My Order</a> </li>-->

                            <li><a href="logout">Log out</a></li>
                        </ul>
                    </div>
                    <li><a class="nav-link" href="cart.jsp"><img src="images/cart.svg"></a></li> 
                        </c:if>

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


