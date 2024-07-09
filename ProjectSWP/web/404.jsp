<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
     <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="author" content="Untree.co">
        <link rel="shortcut icon" href="favicon.png">
        <meta name="description" content="" />
        <meta name="keywords" content="bootstrap, bootstrap4" />
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <link href="css/tiny-slider.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
    <title>Error 404 - Page Not Found</title>
    <style>
        html, body {
            height: 100%; 
            margin: 0;
        }
        .error-container {
            display: flex; 
            flex-direction: column; 
            justify-content: center; 
            align-items: center; 
            height: 100vh; 
            text-align: center;
            background-color: #333;
        }
        .error-image {
            width: 200px; 
            height: auto; 
            margin-bottom: 20px;
        }
        .error-message {
            font-size: 24px; /* Điều chỉnh kích thước chữ */
            color: red; /* Đổi màu chữ */
            font-weight: bold; /* Đậm chữ */
        }
    </style>
</head>
<body>
    <%@ include file="COMP\header.jsp" %>
    <div class="error-container">
        <img src="images/404.png" alt="404 Error Image" class="error-image">
        <p class="error-message">Error page not found</p>
    </div>
        <%@ include file="COMP/footer.jsp" %>
</body>
</html>