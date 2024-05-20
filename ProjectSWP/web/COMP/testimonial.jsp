<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Clickable Image Carousel</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .carousel-item img {
            width: 100%;
            height: auto;
            max-height: 20rem; /* Limit the max height */
            object-fit: contain; /* Ensure the image covers the area */
            margin-top: 100px;
        }
        
        .carousel-control-prev-icon, .carousel-control-next-icon {
    filter: invert(1);
}
    </style>
</head>
<body>

<div id="clickableCarousel" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-inner">
        <div class="carousel-item active">
            <a href="https://example.com/link1">
                <img src="images/Banner1.png" class="d-block w-100" alt="First Slide">
            </a>
        </div>
        <div class="carousel-item">
            <a href="https://example.com/link2">
                <img src="images/Banner2.png" class="d-block w-100" alt="Second Slide">
            </a>
        </div>
        <div class="carousel-item">
            <a href="https://example.com/link2">
                <img src="images/Banner2.png" class="d-block w-100" alt="Second Slide">
            </a>
        </div>
        <div class="carousel-item">
            <a href="https://example.com/link2">
                <img src="images/Banner2.png" class="d-block w-100" alt="Second Slide">
            </a>
        </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#clickableCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#clickableCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.min.js"></script>
</body>
</html>