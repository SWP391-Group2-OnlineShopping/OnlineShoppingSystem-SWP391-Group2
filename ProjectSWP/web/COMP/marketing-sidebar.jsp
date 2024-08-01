<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <a class="d-xl-none d-lg-none" href="home">Dashboard</a>
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
                            <i class="fas fa-fw fa-home"></i> <!-- Home icon -->
                            Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <c:if test="${page == 'dashboard'}">active</c:if>" href="dashboardmkt" onclick="setActive(this)">
                                <i class="fas fa-fw fa-chart-pie"></i> <!-- Dashboard icon -->
                                Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link <c:if test="${page == 'index'}">active</c:if>" href="productmanager" onclick="setActive(this)">
                                <i class="fas fa-fw fa-box"></i> <!-- Product Manager icon -->
                                Product Manager
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link <c:if test="${page == 'mktcustomerlist'}">active</c:if>" href="mktcustomerlist" onclick="setActive(this)">
                                <i class="fas fa-fw fa-users"></i> <!-- Customer Manager icon -->
                                Customer Manager
                            </a>
                        </li>
                        <!-- todo: fill name -->
                        <li class="nav-item ">
                            <a class="nav-link <c:if test="${page == 'mktpostlist'}">active</c:if>" href="mktpostlist" onclick="setActive(this)">
                                <i class="fas fa-fw fa-chart-pie"></i>
                                Blog Manager
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link <c:if test="${page == 'sliderlist'}">active</c:if>" href="MKTSliderList" onclick="setActive(this)">
                                <i class="fas fa-fw fa-sliders-h"></i> <!-- Banner Manager icon -->
                                Banner Manager
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link <c:if test="${page == 'feedbackmanager'}">active</c:if>" href="MKTFeedbackManager" onclick="setActive(this)">
                            <i class="fas fa-fw fa-comment"></i> <!-- Feedback Manager icon -->
                            Feedback Manager
                        </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link <c:if test="${page == 'MKTVoucherList'}">active</c:if>" href="MKTVoucherList" onclick="setActive(this)">
                            <i class="fas fa-fw fa-"></i> <!-- Feedback Manager icon -->
                            Discount Manager
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
