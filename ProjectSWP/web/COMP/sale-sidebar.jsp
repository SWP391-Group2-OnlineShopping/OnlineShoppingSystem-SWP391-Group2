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
    @media (min-width: 768px) {
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }

        .nav-left-sidebar {
            height: 100%;
            position: fixed; /* Ensure the sidebar stays fixed while scrolling */
            top: 0;
            left: 0;
            width: 225px; /* Adjust width as needed */
            overflow-y: auto; /* Add vertical scrolling if the content overflows */
        }

        .image-container img {
            height: 150px;
            width: 150px;
        }
    }
</style>
<div class="nav-left-sidebar sidebar-dark">
    <div class="menu-list">
        <nav class="navbar navbar-expand-lg navbar-light">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <!-- User Info -->

                <!-- End of User Info -->

                <ul class="navbar-nav flex-column">
                    <li>
                        <a class="navbar-brand" style="color: #007bff" href="homepage">DiLuri</a>
                    <li>
                    <li>
                        <div class="d-flex align-items-center image-container ml-3">
                            <img src="https://t3.ftcdn.net/jpg/05/16/27/58/360_F_516275801_f3Fsp17x6HQK0xQgDQEELoTuERO4SsWV.jpg" class="rounded-circle" alt="Avatar" width="200" height="190">
                        </div>
                    </li>
                    <li>
                        <div class="user-info my-3">
                            <div class="d-flex align-items-center">
                                <div class="ml-3">
                                    <h5 class="mb-0 text-white">${staff.username}</h5>
                                    <h6 class="mb-0 text-white">${staff.email}</h6>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li class="nav-divider">
                        Menu
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="homepage" onclick="setActive(this)">
                            <i class="fa fa-fw fa-home"></i>
                            Home
                        </a>
                    </li>
                    
                    <c:if test="${sessionScope.staff != null}">
                        <%
                        boolean isSaleManager = Authorization.isSaleManager((Staffs) session.getAttribute("staff"));
                        %>
                        <li class="nav-item">
                            <a class="nav-link" href="<%= isSaleManager ? "salemanagerdashboard" : "saledashboard" %>" onclick="setActive(this)">
                                <i class="fa fa-fw fa-box"></i>
                                Dashboard
                            </a>
                        </li>
                    </c:if>
                    
   

                    <c:if test="${sessionScope.staff != null}">
                        <%
                        boolean isSaleManager = Authorization.isSaleManager((Staffs) session.getAttribute("staff"));
                        %>
                        <li class="nav-item">
                            <a class="nav-link" href="<%= isSaleManager ? "salemanagerorderlist" : "saleorderlist" %>" onclick="setActive(this)">
                                <i class="fa fa-fw fa-box"></i>
                                Order Manager
                            </a>
                        </li>
                    </c:if>
                        
                    <c:if test="${sessionScope.staff != null}">
                        <%
                        boolean isSaleManager = Authorization.isSaleManager((Staffs) session.getAttribute("staff"));
                        %>
                        <li class="nav-item">
                            <a class="nav-link" href="<%= isSaleManager ? "salemanagerreturnorder" : "salereturnorder" %>" onclick="setActive(this)">
                                <i class="fa fa-fw fa-box"></i>
                                Return Order (${sessionScope.wantreturnorder})
                            </a>
                        </li>
                    </c:if>

                    <li class="nav-item">
                        <a class="nav-link" href="logout" onclick="setActive(this)">
                            <i class="fa fa-fw fa-sign-out-alt"></i>
                            Log Out
                        </a>
                    </li>

                </ul>
            </div>
        </nav>
    </div>
</div>
