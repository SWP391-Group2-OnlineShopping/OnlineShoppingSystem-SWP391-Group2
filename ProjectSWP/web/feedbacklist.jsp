<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ page import="dal.*" %>
<%@ page import="java.sql.Date" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Feedback List</title>

        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
        <style>
            body {
                font-family: "Inter", sans-serif;
                background-color: #f8f9fa;
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
        </style>
    <body>
        <%  
            FeedbackDAO customerDAO = new FeedbackDAO();
            int productID = Integer.parseInt(request.getParameter("productID"));
            float avg = customerDAO.getAvgRating(productID);
            String formattedAvg = String.format("%.1f", avg);  // Format to one decimal place
            request.setAttribute("avg", formattedAvg);
        %>
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
                        <span class="average-rating"><%= formattedAvg %> on 5</span>
                        <div class="stars">
                            <%
                                int fullStars = (int) avg;
                                boolean hasHalfStar = (avg - fullStars) >= 0.5;
                                int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

                                for (int i = 0; i < fullStars; i++) {
                                    out.print("<i class='fas fa-star'></i>");
                                }
                                if (hasHalfStar) {
                                    out.print("<i class='fas fa-star-half-alt'></i>");
                                }
                                for (int i = 0; i < emptyStars; i++) {
                                    out.print("<i class='far fa-star'></i>");
                                }
                            %>
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



                    <div id="feedback-list">
                        <c:forEach var="feedback" items="${feedbacks}">
                            <div class="feedback-item">
                                <div class="d-flex align-items-center">
                                    <%
                                        Feedbacks feedback = (Feedbacks) pageContext.getAttribute("feedback");
                                        try {
                                        Customers customer = customerDAO.getCustomerByID(feedback.getCustomerID());
                                        request.setAttribute("customer", customer);
                                    %>
                                    <a href="userprofilefeedback?id=${customer.customer_id}&productID=${productID}&page=1&filter=''">
                                        <img src="images/${customer.avatar}" alt="Customer Image" onerror="this.onerror=null;this.src='images/default-avatar.png';">
                                    </a>
                                    <div>
                                        <p><%= feedback.getDate() %></p>
                                        <h5>${customer.full_name}</h5>
                                        <div class="stars">
                                            <c:forEach begin="1" end="5" var="i">
                                                <c:choose>
                                                    <c:when test="${i <= feedback.getRatedStar()}">
                                                        <i class="fas fa-star"></i>
                                                    </c:when>
                                                    <c:when test="${i - feedback.getRatedStar() < 1}">
                                                        <i class="fas fa-star-half-alt"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="far fa-star"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </div>
                                        <p><%= feedback.getContent() %></p>

                                    </div>
                                    <%
                                    } catch (Exception e) {
                                        out.println("Error: " + e.getMessage());
                                        e.printStackTrace();
                                    }
                                    %>
                                </div>
                                <div class="images">

                                    <c:forEach var="link" items="${feedback.imageLinks}">
                                        <c:choose>
                                            <c:when test="${fn:endsWith(link, '.mp4') || fn:endsWith(link, '.avi') || fn:endsWith(link, '.mov') || fn:endsWith(link, '.wmv') || fn:endsWith(link, '.flv')}">
                                                <video controls width="240" height="180">
                                                    <source src="${link}" type="video/mp4">
                                                    Your browser does not support the video tag.
                                                </video>
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${link}" alt="Feedback Image" width="240" height="180" onerror="this.style.display='none';">
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>


                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <nav aria-label="Page navigation example">
                        <ul class="pagination justify-content-center">
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="LoadFeedbacks?productID=${productID}&page=${i}&filter=${currentFilter}">${i}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>

        <!-- jQuery and Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <script>
                        $(document).ready(function () {
                            // Filter buttons click event
                            $('.filter-btn').click(function () {
                                $('.filter-btn').removeClass('active');
                                $(this).addClass('active');
                                var filter = $(this).data('filter');
                                window.location.href = 'LoadFeedbacks?productID=' + ${productID} + '&productpage=1&filter=' + filter;
                            });
                        });
        </script>
    </body>
</html>