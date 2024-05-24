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
        <c:if test="${sessionScope.acc != null}">
            <div class="user-profile">
                <div class="container">
                    <div class="row justify-content-between user-profile-container">
                        <div class="col-lg-3 user-profile-nav">
                            <h4>Customer Information</h4>
                            <div class="menu-nav">
                                <a href="customerInfo?id=${userInfo.customer_id}" class="menu-nav-item user-info"><img src="./images/user-solid.svg" alt="" class="nav-item-icon" />User Information</a>
                                <a href="" class="menu-nav-item buy-history"><img src="./images/bag-shopping-solid.svg" alt="" class="nav-item-icon" />Order History</a>
                                <a href="logout" class="menu-nav-item logout"><img src="./images/right-to-bracket-solid.svg" alt="" class="nav-item-icon"/>Log-out</a>
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
                                    <h3 class="text-center">User Information</h3>
                                    <form action="customerInfo?id=${userInfo.customer_id}" method="post" class="edit-form" >
                                        <label for="fullname">Full Name</label>
                                        <input type="text" name="fullname" id="fullname" value="${userInfo.full_name}"/>
                                        <label for="address">Address</label>
                                        <input type="text" name="address" id="address" value="${userInfo.address}"/>

                                        <label for="phone">Phone number</label>
                                        <input type="text" name="phone" id="phone" value="${userInfo.phone_number}"/>
                                        <span></span>

                                        <label for="email">Your Email</label>
                                        <input type="email" name="email" id="email" value="${userInfo.email}" readonly />

                                        <label for="Gender">Gender</label>
                                        <input type="radio" name="gender" id="male" value="true" ${userInfo.gender ? 'checked' : ''}>
                                        <label for="male">Male</label>

                                        <input type="radio" name="gender" id="female" value="false" ${!userInfo.gender ? 'checked' : ''}>
                                        <label for="male">Female</label>

                                        <input type="submit" value="Submit" />
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </c:if>
        <!-- Include footer.jsp -->
        <%@include file="COMP/footer.jsp"%>
    </body>
</html>
