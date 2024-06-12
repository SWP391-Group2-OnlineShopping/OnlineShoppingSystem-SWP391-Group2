<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="dal.FeedbackDAO" %>
<%@ page import="model.Feedbacks" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Write Feedback</title>

        <!-- Bootstrap CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
        <style>
            @import url("https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap");
            body {
                overflow-x: hidden;
                position: relative;
            }

            body {
                font-family: "Inter", sans-serif;
                font-weight: 400;
                line-height: 28px;
                color: #6a6a6a;
                font-size: 14px;
                background-color: #eff2f1;
            }
            .card-header {
                background-color: #CE4B40;
                color: white;
            }

            .rating {
                display: flex;
                flex-direction: row-reverse;
                justify-content: center;
            }
            .rating input {
                display: none;
            }
            .rating label {
                position: relative;
                width: 1em;
                font-size: 3vw;
                color: #ccc; /* Gray color for unselected stars */
                cursor: pointer;
            }
            .rating label::before {
                content: "★";
                position: absolute;
                opacity: 1;
            }
            .rating label:hover::before,
            .rating label:hover ~ label::before {
                color: #FFD700; /* Gold color on hover */
            }
            .rating input:checked ~ label::before {
                color: #FFD700; /* Gold color for selected stars */
            }
            .rating input:checked ~ label:hover::before,
            .rating input:checked ~ label:hover ~ label::before,
            .rating label:hover ~ input:checked ~ label::before {
                opacity: 0.4;
            }
            .header-icons {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .header-icons .btn {
                background: none;
                border: none;
                color: white;
            }
            .product-detail {
                display: flex;
                align-items: center;
                padding: 15px;
                border-bottom: 1px solid #dee2e6;
            }
            .product-detail img {
                width: 50px;
                height: 50px;
                object-fit: cover;
                margin-right: 50px;
                margin-left: 14px;
            }
            .error-message {
                color: red;
                font-size: 12px;
                display: none;
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <div class="header-icons">
                                <button type="button" class="btn" onclick="window.history.back()">
                                    <i class="fas fa-arrow-left"></i>
                                </button>
                                <h1 class="mb-0">Rate Product</h1>
                                <button type="submit" form="feedbackForm" class="btn">
                                    <i class="fas fa-check"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                            <form id="feedbackForm" method="POST" enctype="multipart/form-data">
                                <input type="hidden" name="OrderDetailID" value="${param.orderDetailID}">
                                <div class="mb-5">
                                    <label for="rating" class="form-label">Rate the product:</label>
                                    <div class="rating">
                                        <input type="radio" name="rating" id="rating-5" value="5"><label for="rating-5" title="5 stars"></label>
                                        <input type="radio" name="rating" id="rating-4" value="4"><label for="rating-4" title="4 stars"></label>
                                        <input type="radio" name="rating" id="rating-3" value="3"><label for="rating-3" title="3 stars"></label>
                                        <input type="radio" name="rating" id="rating-2" value="2"><label for="rating-2" title="2 stars"></label>
                                        <input type="radio" name="rating" id="rating-1" value="1"><label for="rating-1" title="1 star"></label>
                                    </div>
                                    <div class="error-message" id="rating-error">Please select a rating.</div>
                                </div>
                                <div class="mb-3">
                                    <label for="content" class="form-label">Your feedback:</label>
                                    <textarea class="form-control" id="content" name="content" rows="5"></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="image" class="form-label">Upload images:</label>
                                    <input type="file" class="form-control" id="image" name="image" multiple>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.min.js"></script>
        <script>
                                    $(document).ready(function () {
                                        $('#feedbackForm').on('submit', function (e) {
                                            e.preventDefault();

                                            // Check if a rating is selected
                                            if (!$('input[name="rating"]:checked').val()) {
                                                $('#rating-error').show();
                                                return;
                                            } else {
                                                $('#rating-error').hide();
                                            }

                                            var formData = new FormData(this);

                                            $.ajax({
                                                url: 'Feedback',
                                                type: 'POST',
                                                data: formData,
                                                contentType: false,
                                                processData: false,
                                                success: function (response) {
                                                    alert('Feedback submitted successfully!');
                                                    window.location = document.referrer;
                                                },
                                                error: function (xhr, status, error) {
                                                    alert('An error occurred while submitting your feedback. Please try again.');
                                                }
                                            });
                                        });
                                    });
        </script>
    </body>
</html>