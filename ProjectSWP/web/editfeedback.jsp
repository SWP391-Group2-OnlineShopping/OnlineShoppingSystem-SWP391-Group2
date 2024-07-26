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

            .feedback-image img{
                width: 70%;
                object-fit: cover;
                margin-right: 15px;
            }

            .preview {
                margin-top: 20px;
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
            }
            .image-container {
                position: relative;
                display: inline-block;
                width: 100px;
                height: 100px;
                overflow: hidden;
                border: 1px solid #ccc;
                border-radius: 10px;
                margin-bottom: 50px;
            }
            .image-container img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            .image-container .close-icon {
                position: absolute;
                top: 5px;
                right: 5px;
                background: rgba(255, 255, 255, 0.8);
                border-radius: 50%;
                cursor: pointer;
                padding: 5px;
                font-size: 14px;
            }
        </style>
    </head>
    <body>
        <c:set var="feedback" value="${feedback}"/>
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <div class="header-icons">
                                <a type="button" class="btn" href="myfeedback?customerID=${sessionScope.acc.customer_id}&page=1&filter=''">
                                    <i class="fas fa-arrow-left"></i>
                                </a>
                                <h1 class="mb-0">Feedback</h1>
                                <button type="submit" onclick="document.getElementById('feedbackForm').submit()" class="btn">
                                    <i class="fas fa-check"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                            <form id="feedbackForm" method="POST">
                                <input type="hidden" name="feedbackID" value="${feedback.feedbackID}">
                                <input type="hidden" name="customerID" value="${feedback.customerID}">
                                <input type="hidden" name="productID" value="${feedback.productID}">
                                <div class="mb-5">
                                    <label for="rating" class="form-label">Rate the product:</label>
                                    <div class="rating">
                                        <c:set var="ratedStar" value="${feedback.getRatedStar()}"/>
                                            <input type="radio" name="rating" id="rating-5" value="5" <c:if test="${ratedStar == 5}">checked</c:if>>
                                            <label for="rating-5" title="5 stars"></label>

                                            <input type="radio" name="rating" id="rating-4" value="4" <c:if test="${ratedStar == 4}">checked</c:if>>
                                            <label for="rating-4" title="4 stars"></label>

                                            <input type="radio" name="rating" id="rating-3" value="3" <c:if test="${ratedStar == 3}">checked</c:if>>
                                            <label for="rating-3" title="3 stars"></label>

                                            <input type="radio" name="rating" id="rating-2" value="2" <c:if test="${ratedStar == 2}">checked</c:if>>
                                            <label for="rating-2" title="2 stars"></label>

                                            <input type="radio" name="rating" id="rating-1" value="1" <c:if test="${ratedStar == 1}">checked</c:if>>
                                            <label for="rating-1" title="1 star"></label>
                                        </div>
                                        <div class="error-message" id="rating-error">Please select a rating.</div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="content" class="form-label">Comment: </label>
                                        <textarea class="form-control" id="content" name="content" rows="5">${feedback.content}</textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="image" class="form-label">Upload images/videos:</label>
                                    <div class="col-md-3 d-flex feedback-image">
                                        <c:forEach var="link" items="${feedback.images}">
                                            <img src="${link.link}" alt="Feedback Image" onerror="this.style.display='none';" />
                                            <a style="position: relative;
                                                  top: 5px;
                                                  right: 5px;
                                                  background: rgba(255, 255, 255, 0.8);
                                                  border-radius: 50%;
                                                  cursor: pointer;
                                                  padding: 5px;
                                                  font-size: 14px;" href="remove-image?imageID=${link.imageID}&feedbackID=${feedback.feedbackID}">X</a>
                                            <input type="hidden" name="imgeURL" value="${images.link}">
                                        </c:forEach>
                                    </div>

                                    <div class="preview" id="preview"></div>
                                    <div class="base64Output" id="base64Output"></div>

                                    <input id="fileInput" type="file" class="form-control" id="image" name="image" accept="image/*,video/*" multiple>
                                    <div class="error-message" id="file-error">You can upload up to 5 files only.</div>
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
                                    let files = [];
                                    document.getElementById('fileInput').addEventListener('change', function (event) {
                                        files = Array.from(event.target.files);
                                        updatePreviews();
                                    });

                                    function updatePreviews() {
                                        const previewContainer = document.getElementById('preview');
                                        const base64OutputContainer = document.getElementById('base64Output');

                                        previewContainer.innerHTML = ''; // Clear previous previews
                                        base64OutputContainer.innerHTML = ''; // Clear previous Base64 outputs

                                        if (files.length > (5 - ${feedback.imageLinks.size()})) {
                                            alert("You can upload a maximum of 5 files.");
                                                return;
                                            }

                                        files.forEach((file, index) => {
                                            const reader = new FileReader();
                                            reader.onload = function (e) {
                                                const base64String = e.target.result;

                                                // Create container for image and close icon
                                                const imageContainer = document.createElement('div');
                                                imageContainer.classList.add('image-container');

                                                // Create image element for preview
                                                const img = document.createElement('img');
                                                img.src = base64String;
                                                imageContainer.appendChild(img);

                                                // Create close icon
                                                const closeIcon = document.createElement('span');
                                                closeIcon.textContent = '✖';
                                                closeIcon.classList.add('close-icon');
                                                closeIcon.addEventListener('click', function () {
                                                    files.splice(index, 1);
                                                    updateFileInput(files);
                                                    updatePreviews(); // Re-render previews after removal
                                            });
                                                imageContainer.appendChild(closeIcon);

                                                previewContainer.appendChild(imageContainer);

                                                const base64Input = document.createElement('input');
                                                base64Input.type = 'hidden';
                                                base64Input.name = 'imageURL';
                                                base64Input.value = base64String;
                                                base64OutputContainer.appendChild(base64Input);
                                            };
                                            reader.readAsDataURL(file);
                                        });
                                    }

                                    function updateFileInput(fileArray) {
                                        const dataTransfer = new DataTransfer();
                                        fileArray.forEach(file => {
                                            dataTransfer.items.add(file);
                                    });
                                        document.getElementById('fileInput').files = dataTransfer.files;
                                    }
        </script>
    </body>
</html>
