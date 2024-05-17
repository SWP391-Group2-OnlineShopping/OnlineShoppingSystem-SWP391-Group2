<%-- 
    Document   : userProfile
    Created on : 15 May 2024, 07:43:16
    Author     : dumspicy
--%>
<%@page import="model.Customers"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="author" content="Untree.co">
        <link rel="shortcut icon" href="favicon.png">

        <meta name="description" content="" />
        <meta name="keywords" content="bootstrap, bootstrap4" />

        <!-- Boostrap CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/userProfileStyle.css"/>
        <link href="css/style.css" rel="stylesheet">
        <title>User Profile</title>
    </head>
    <body >
        <!-- Include header.jsp -->
        <%@include file="COMP/header.jsp" %>
        <div class="user-profile">
            <div class="container">
                <div class="row justify-content-between user-profile-container">
                    <div class="col-lg-3 user-profile-nav">
                        <h4>Thông tin khách hàng</h4>
                        <div class="menu-nav">
                            <a href="" class="menu-nav-item user-info"><img src="./images/user-solid.svg" alt="" class="nav-item-icon" />Thông tin cá nhân</a>
                            <a href="" class="menu-nav-item buy-history"><img src="./images/bag-shopping-solid.svg" alt="" class="nav-item-icon" />Lịch sử mua hàng</a>
                            <a href="" class="menu-nav-item logout"><img src="./images/right-to-bracket-solid.svg" alt="" class="nav-item-icon"/>Đăng xuất</a>
                        </div>
                    </div>
                    
                    <!--                    user profile information -->
                    <div class="col-sm-8 user-profile-info">
                        <div class="row">
                            <div class="col-sm-5 user-profile-image">
                                <img src="./images/person-1.jpg" alt="" class="user-img" />
                                <input type="file" name="img-file" id="img-change" />
                            </div>
                            <div class="col-sm-7 user-profile-desc">
                                <h3 class="text-center">Thông tin cá nhân</h3>
                                <form action="" class="edit-form" >
                                    <label for="fullname">Họ và tên</label>
                                    <input type="text" name="fullname" id="fullname" value="${sessionScope.userInfo.full_name}"/>
                                    <label for="address">Địa chỉ</label>
                                    <input type="text" name="address" id="address" value="${sessionScope.userInfo.address}"/>

                                    <label for="phone">Số điện thoại</label>
                                    <input type="text" name="phone" id="phone" value="${sessionScope.userInfo.phone_number}"/>

                                    <label for="email">Email của bạn</label>
                                    <input type="email" name="email" id="email" value="${sessionScope.userInfo.email}" readonly />

                                    <label for="Gender">Giới tính</label>
                                    <input type="radio" name="gender" id="male" value="male" ${sessionScope.userInfo.gender ? 'checked' : ''}>
                                    <label for="male">Male</label>

                                    <input type="radio" name="gender" id="female" value="female" ${!sessionScope.userInfo.gender ? 'checked' : ''}>
                                    <label for="male">Female</label>
                                    
                                    <input type="submit" value="Submit" />
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- Include footer.jsp -->
        <%@include file="COMP/footer.jsp"%>
    </body>
</html>
