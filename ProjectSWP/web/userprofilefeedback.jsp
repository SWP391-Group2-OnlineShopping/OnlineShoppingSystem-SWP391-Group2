<%-- 
    Document   : userprofilefeedback
    Created on : 18 Jun 2024, 23:22:07
    Author     : dumspicy
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="author" content="Untree.co">
        <link rel="shortcut icon" href="favicon.png">
        <meta name="description" content="" />
        <meta name="keywords" content="bootstrap, bootstrap4" />

        <!-- Bootstrap CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <!--<link rel="stylesheet" href="css/userProfileStyle.css"/>-->
        <link href="css/tiny-slider.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <title>User Profile</title>   
        <style>
            .dropdown-menu {
                color: black !important;
                z-index: 1050;
            }

            .user-image-ava img {
                width: 100%;
                height: auto;
                border-radius: 50%;
            }
            .user-info-title {
                font-weight: bold;
                font-size: 16px;
            }
            .user-info {
                display: inline-block;
                margin-bottom: 0.5rem;
            }
            
            .user-desc{
                margin-left: 12px;
                font-weight: 500;
            }

            .main-container {
                margin-top: 200px;
            }
        </style>
    </head>
    <body>

        <!-- Include header.jsp -->
        <%@include file="COMP/header.jsp" %>

        <c:if test="${sessionScope.acc != null}">
            <c:set var="customer" value="${customer}"/>
            <c:set var="totalFeedback" value="${totalFeedback}"/>
            <div class="container main-container">
                <div class="row">
                    <div class="user-image col-md-3">
                        <div class="user-image-ava">
                            <img src="images/${customer.avatar}" alt="Customer Image" onerror="this.onerror=null;this.src='images/default-avatar.png';">
                        </div>
                    </div>

                    <div class="user-information col-md-9">
                        <p class="user-info-title">Full name: <span class="user-info user-desc">${customer.full_name}</span></p>
                        <p class="user-info-title">Date of birth: <span class="user-info user-desc">${customer.dob}</span></p>
                        <p class="user-info-title">Gender: <span class="user-info user-desc">${customer.gender == true ? "Male" : "Female"}</span></p>
                        <p class="user-info-title">Total feedback: <span class="user-info user-desc">${totalFeedback}</span></p>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- Include footer.jsp -->
        <%@include file="COMP/footer.jsp"%>
        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/tiny-slider.js"></script>
        <script src="js/custom.js"></script>
    </body>
</html>
