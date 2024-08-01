<%-- 
    Document   : myfeedbacklist
    Created on : 18 Jun 2024, 20:38:21
    Author     : dumspicy
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ page import="dal.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
        <style>
            body {
                font-family: "Inter", sans-serif;
                background-color: #f8f9fa;
            }
            a{
                text-decoration: none;
            }
            .card-header {
                background-color: #CE4B40;
                color: white;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
            .card-header .btn {
                color: white;
            }
            .rating {
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .rating .stars {
                color: #FFD700;
                margin-right: 10px;
            }
            .filter-buttons {
                margin-bottom: 20px;
            }
            .filter-buttons .btn {
                margin: 5px;
            }
            .feedback-item {
                border-bottom: 1px solid #dee2e6;
                padding: 15px;
            }
            .feedback-item img {
                width: 60px;
                height: 75px;
                margin-right: 15px;
            }
            .feedback-item .images img {
                width: 80px;
                height: 80px;
                object-fit: cover;
                margin: 5px;
            }

            .feedback-control__btn img{
                width: 15%;
            }

            .product-information{
                margin-top: 12px;
                background-color: #f1f1f1;
            }

            .product-image img{
                width: 50%;
                height: 90px;
                object-fit: contain;
            }

            .product-title{
                padding: 14px;
            }

            .product-title p{
                font-size: 20px;
                color: #ce4b40;
            }

            .feedback-item-inner{
                position: relative;
            }

            .feedback-control{
                position: absolute;
                right: -65px;
            }

            .page-pagination{
                margin: 12px 0;
            }
        </style>
        <script>
            function showError(message) {
                alert(message);
            }
        </script>
    </head>
    <body>
        <c:if test="${not empty sessionScope.error}">
            <script type="text/javascript">
                // Lấy thông báo lỗi từ session scope và hiển thị nó
                var errorMessage = "${sessionScope.error}";
                showError(errorMessage);
            </script>
            <c:remove var="error" scope="session"/>
        </c:if>
        <div class="container mt-5">
            <div class="card">
                <div class="card-header">
                    <button type="button" class="btn" onclick="window.history.back()">
                        <i class="fas fa-arrow-left"></i>
                    </button>
                    <h5 class="mb-0">Feedbacks</h5>
                </div>
                <div class="card-body">
                    <div class="rating mb-3">
                        <span class="average-rating"></span>
                        <div class="stars">

                        </div>
                    </div>
                    <div class="filter-buttons text-center">
                        <button class="btn btn-outline-secondary filter-btn" data-filter="all">All</button>
                        <button class="btn btn-outline-secondary filter-btn" data-filter="5">5 <i class="fas fa-star"></i></button>
                        <button class="btn btn-outline-secondary filter-btn" data-filter="4">4 <i class="fas fa-star"></i></button>
                        <button class="btn btn-outline-secondary filter-btn" data-filter="3">3 <i class="fas fa-star"></i></button>
                        <button class="btn btn-outline-secondary filter-btn" data-filter="2">2 <i class="fas fa-star"></i></button>
                        <button class="btn btn-outline-secondary filter-btn" data-filter="1">1 <i class="fas fa-star"></i></button>
                        <button class="btn btn-outline-secondary filter-btn" data-filter="comment">have comment</button>
                        <button class="btn btn-outline-secondary filter-btn" data-filter="image">have image/video</button>
                    </div>

                    <c:if test="${empty feedbacks}">
                        <div class="feedback-list">
                            <h2>You have no feedback yet</h2>
                        </div>
                    </c:if>

                    <div id="feedback-list">
                        <c:forEach var="feedbacks" items="${feedbacks}">
                            <div class="feedback-item">
                                <div class="d-flex align-items-center feedback-item-inner">
                                    <%
                                        FeedbackDAO fDAO = new FeedbackDAO();
                                        Feedbacks feedback = (Feedbacks) pageContext.getAttribute("feedbacks");
                                        try {
                                        Customers customer = fDAO.getCustomerByID(feedback.getCustomerID());
                                        request.setAttribute("customer", customer);
                                    %>
                                    <img src="${customer.avatar}" alt="Customer Image" onerror="this.onerror=null;this.src='images/default-avatar.png';">
                                    <div>
                                        <h5 class="customer-name">${customer.user_name}</h5>
                                        <div class="stars">
                                            <c:forEach begin="1" end="5" var="i">
                                                <c:choose>
                                                    <c:when test="${i <= feedbacks.getRatedStar()}">
                                                        <i class="fas fa-star"></i>
                                                    </c:when>
                                                    <c:when test="${i - feedbacks.getRatedStar() < 1}">
                                                        <i class="fas fa-star-half-alt"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="far fa-star"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </div>
                                        <p class="feedback-content">${feedbacks.content}</p>

                                    </div>
                                    <%
                                    } catch (Exception e) {
                                        out.println("Error: " + e.getMessage());
                                        e.printStackTrace();
                                    }
                                    %>
                                    <div class="feedback-control" >
                                        <c:if test="${feedbacks.daySinceFeedback <= 30}">
                                            <a href="editFeedback?feedbackID=${feedbacks.feedbackID}" id="edit" class="feedback-control__btn"><img src="./images/pen-solid.svg" alt="alt"/></a>
                                        </c:if>
                                        <a href="deleteFeedback?feedbackID=${feedbacks.feedbackID}&customerID=${sessionScope.acc.customer_id}" id="delete" class="delete-btn feedback-control__btn"><img src="./images/trash-solid.svg" alt="alt"/></a>
                                    </div>

                                </div>
                                <div class="images">
                                    <c:forEach var="link" items="${feedbacks.imageLinks}">
                                        <img src="${link}" alt="Feedback Image" onerror="this.style.display='none';">
                                    </c:forEach>
                                </div>

                                <%
                                    try{
                                        Products product = fDAO.getProductByID(feedback.getProductID());
                                        request.setAttribute("product", product);
                                %>
                                <div class="product-information container">
                                    <div class="row">
                                        <div class="col-md-4 product-image">
                                            <a href="productdetails?id=${product.productID}"><img src="${product.thumbnailLink}" alt="Product image"></a>
                                        </div>
                                        <div class="col-md-8 product-title">
                                            <a href="productdetails?id=${product.productID}"><p>${product.title}</p></a>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }catch(Exception e){
                                        out.println("Error: " + e.getMessage());
                                        e.printStackTrace();
                                    }
                                %>
                            </div>
                        </c:forEach>
                    </div>
                    <nav class="page-pagination" aria-label="Page navigation example">
                        <ul class="pagination justify-content-center">
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="myfeedback?customerID=${sessionScope.acc.customer_id}&page=${i}&filter=${currentFilter}">${i}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <script>
                        $(document).ready(function () {
                            // Filter buttons click event
                            $('.filter-btn').click(function () {
                                $('.filter-btn').removeClass('active');
                                $(this).addClass('active');
                                var filter = $(this).data('filter');
                                window.location.href = 'myfeedback?customerID=' + ${sessionScope.acc.customer_id} + '&page=1&filter=' + filter;
                            });
                        });

                        document.addEventListener("DOMContentLoaded", function () {
                            var deleteButtons = document.querySelectorAll(".delete-btn");

                            deleteButtons.forEach(function (button) {
                                button.addEventListener("click", function (event) {
                                    var confirmation = confirm("Are you sure you want to delete this feedback?");

                                    if (!confirmation) {
                                        event.preventDefault();
                                    }
                                });
                            });
                        });
        </script>

    </body>
</html>
