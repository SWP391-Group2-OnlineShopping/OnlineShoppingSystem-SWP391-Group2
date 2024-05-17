<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Card Game</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #EFF2F1;
            }
            .card-container {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .card {
                margin: 20px;
                box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
            }

            .title {
                font-size: 2.5rem;
                font-weight: bold;
                margin-bottom: 30px;
                text-align: center;
            }
        </style>
    </head>
    <body>

        <div class="container card-container">
            <div class="title">Are you...</div>
            <div class="card" style="width: 18rem;">
                <div class="card-body">
                    <h5 class="card-title">Admin</h5>
                    <a href="stafflogin.jsp?role=1" class="btn btn-primary">Go to</a>
                </div>
            </div>
            <div class="card" style="width: 18rem;">
                <div class="card-body">
                    <h5 class="card-title">Sale Manager</h5>
                    <a href="stafflogin.jsp?role=2" class="btn btn-primary">Go to</a>
                </div>
            </div>
            <div class="card" style="width: 18rem;">
                <div class="card-body">
                    <h5 class="card-title">Sale</h5>
                    <a href="stafflogin.jsp?role=3" class="btn btn-primary">Go to</a>
                </div>
            </div>
            <div class="card" style="width: 18rem;">
                <div class="card-body">
                    <h5 class="card-title">Marketer</h5>
                    <a href="stafflogin.jsp?role=4" class="btn btn-primary">Go to</a>
                </div>
            </div>

        </div>
        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>