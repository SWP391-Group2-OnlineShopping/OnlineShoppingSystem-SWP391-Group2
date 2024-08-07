<%-- 
    Document   : header
    Created on : May 17, 2024, 4:24:14 PM
    Author     : Admin
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="controller.auth.Authorization" %>
<%@ page import="model.Staffs" %>
<%@ page import="java.util.List" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="model.Customers" %>
<%@ page import="dal.CustomersDAO" %>
<%@ page import="model.CartItem" %>
<style>
    .dropdown-menu {
        color: black !important;
        z-index: 1050; /* Thiết lập độ ưu tiên cao */
    }
    .nav-link{
        position: relative;
    }
    .cart-size{
        position: absolute;
        top: 10px;
    }
</style>

<c:if test="${sessionScope.message != null}">
    <script>
        alert("${sessionScope.message}");
    </script>
    <%
        session.removeAttribute("message");
    %>
</c:if>

<nav class="custom-navbar navbar navbar-expand-md navbar-dark bg-dark" aria-label="Furni navigation bar">
    <div class="container">
        <a class="navbar-brand" href="homepage">DiLuri<span>.</span></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsFurni" aria-controls="navbarsFurni" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarsFurni">
            <ul class="custom-navbar-nav navbar-nav mx-auto mb-md-0">
                <li class="nav-item <c:if test="${page == 'index'}">active</c:if> ms-5">
                        <a class="nav-link" href="homepage">Home</a>
                    </li>
                    <li class="nav-item <c:if test="${page == 'shop'}">active</c:if>">
                        <a class="nav-link" href="product">Shop</a>
                    </li>
                    <li class="nav-item <c:if test="${page == 'blog'}">active</c:if>">
                        <a class="nav-link" href="blog">Blog</a>
                    </li>
<!--                    <li class="nav-item <c:if test="${page == 'about'}">active</c:if>">
                        <a class="nav-link" href="about.jsp">About us</a>
                    </li>-->
                </ul>

                <ul class="custom-navbar-cta navbar-nav mb-2 mb-md-0 ms-5">
                    <li class="nav-item">
                        <form class="d-flex" action="product" method="get" id="searchForm">
                            <input class="form-control form-control-sm me-2 thin-search-bar" type="search" placeholder="Search for products..." aria-label="Search" name="search" id="searchInput">
                        </form>
                    </li>
                    <!--------------------------------------------------------------------------------------------------------------------------------------------------- -->
                    <!--------------------------------------------------------------------------------------------------------------------------------------------------- -->
                    <!--------------------------------------------------------------------------------------------------------------------------------------------------- -->
                <c:choose>
                    <c:when test="${sessionScope.acc == null && sessionScope.staff == null}">
                        <li><a class="nav-link" href="login"><img src="images/user.svg"></a></li>
                            </c:when>

                    <c:when test="${sessionScope.acc != null}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                ${sessionScope.acc.user_name}
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="customerInfo?id=${sessionScope.acc.customer_id}">Profile</a></li>
                                <li><a class="dropdown-item" href="myorder">My Order</a></li>
                                <li><a class="dropdown-item" href="wishlist?customerID=${sessionScope.acc.customer_id}">My Wishlist</a></li>
                                <li><a class="dropdown-item" href="ViewedProductServlet?customerID=${sessionScope.acc.customer_id}">Viewed Product</a></li>
                                <li><a class="dropdown-item" href="myfeedback?customerID=${sessionScope.acc.customer_id}&page=1&filter=''">My Feedback</a></li>
                                <li><a class="dropdown-item" href="logout">Log out</a></li>
                            </ul>
                        </li>

                        <% 
                            Customers customers = (Customers) session.getAttribute("acc");
                            if (customers != null) {
                                CustomersDAO cDAO = new CustomersDAO();
                                List<CartItem> listItem = cDAO.getCart(customers.getCustomer_id());
                        %>
                        <li><a class="nav-link" href="viewcartdetail"><img src="images/cart.svg"><span class="cart-size fs-5 text-white">(<%= listItem != null ? listItem.size() : 0 %>)</span></a></li>
                                <% 
                                    }
                                %>
                            </c:when>
                        </c:choose>
                <!--------------------------------------------------------------------------------------------------------------------------------------------------- -->
                <!--------------------------------------------------------------------------------------------------------------------------------------------------- -->
                <!--------------------------------------------------------------------------------------------------------------------------------------------------- -->
                <c:if test="${sessionScope.staff != null}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            ${sessionScope.staff.username}
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <% if (Authorization.isMarketer((Staffs) session.getAttribute("staff"))) { %>
                            <li><a class="dropdown-item" href="dashboardmkt">Dashboard</a></li>
                                <% } else if (Authorization.isAdmin((Staffs) session.getAttribute("staff"))) { %>
                            <li><a class="dropdown-item" href="admdashboard">Dashboard</a></li>
                                <% } else if (Authorization.isSaleManager((Staffs) session.getAttribute("staff"))) { %>
                            <li><a class="dropdown-item" href="salemanagerdashboard">Dashboard</a></li>
                                <% } else if (Authorization.isSaler((Staffs) session.getAttribute("staff"))) { %>
                            <li><a class="dropdown-item" href="saledashboard">Dashboard</a></li>
                                <% } else if (Authorization.isWarehouseStaff((Staffs) session.getAttribute("staff"))) { %>
                            <li><a class="dropdown-item" href="warehouseorderlist">Dashboard</a></li>
                                <% } else { %>
                            <li><a class="dropdown-item" href="shipperordermanager">Dashboard</a></li>

                            <% } %>
                            <li><a class="dropdown-item" href="logout">Log out</a></li>
                        </ul>
                    </li>

                    <% if (Authorization.isMarketer((Staffs) session.getAttribute("staff"))) { %>
                    <li><a class="nav-link" href="dashboardmkt"><img src="images/setting.png" style="height:30px"></a></li>
                            <% } else if (Authorization.isAdmin((Staffs) session.getAttribute("staff"))) { %>
                    <li><a class="nav-link" href="admdashboard"><img src="images/setting.png" style="height:30px"></a></li>
                            <% } else if (Authorization.isSaleManager((Staffs) session.getAttribute("staff"))) { %>
                    <li><a class="nav-link" href="salemanagerdashboard"><img src="images/setting.png" style="height:30px"></a></li>
                            <% } else if (Authorization.isSaler((Staffs) session.getAttribute("staff"))) { %>
                    <li><a class="nav-link" href="saledashboard"><img src="images/setting.png" style="height:30px"></a></li>
                            <% } else if (Authorization.isWarehouseStaff((Staffs) session.getAttribute("staff"))) { %>
                    <li><a class="nav-link" href="warehouseorderlist"><img src="images/setting.png" style="height:30px"></a></li>
                            <% } else { %>
                    <li><a class="nav-link" href="shipperordermanager"><img src="images/setting.png" style="height:30px"></a></li>        
                            <% } %>
                        </c:if>
            </ul>
        </div>
</nav>

<script>
    document.getElementById("searchInput").addEventListener("keypress", function (event) {
        if (event.keyCode === 13) { // 'Enter' key
            event.preventDefault(); // Prevent default form submission
            document.getElementById("searchForm").submit(); // Submit the form
        }
    });
</script>
