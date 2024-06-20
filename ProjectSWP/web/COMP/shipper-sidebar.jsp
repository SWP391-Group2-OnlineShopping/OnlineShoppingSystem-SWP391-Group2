<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Staffs" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<div class="nav-left-sidebar sidebar-dark">
    <div class="menu-list">
        <nav class="navbar navbar-expand-lg navbar-light">
            <a class="d-xl-none d-lg-none" href="homepage">DiLuri</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <!-- User Info -->

                <!-- End of User Info -->

                <ul class="navbar-nav flex-column">
                    <li>
                        <div class="d-flex align-items-center">
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
                    <li class="nav-item">
                        <a class="nav-link" href="homepage" onclick="setActive(this)">
                            <i class="fa fa-fw fa-home"></i>
                            Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="shipperdashboard" onclick="setActive(this)">
                            <i class="fa fa-fw fa-chart-pie"></i>
                            Dashboard
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="shipperordermanager" onclick="setActive(this)">
                            <i class="fa fa-fw fa-box"></i>
                            Order Manager
                        </a>
                    </li>
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