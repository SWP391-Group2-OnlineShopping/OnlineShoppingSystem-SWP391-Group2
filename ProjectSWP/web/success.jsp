<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reset Password</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #CE4B40;
            }

            .card .btn-primary {
                background-color: #F9BF29;
                border: none;
            }
            .card .btn-primary:hover {
                background-color: #d4a028;
            }

            .login-form {
                background: #EFF2F1;
                padding: 1rem;
                box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
                margin-top: 8rem;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div>
                <img src="images/Black-Sneaker.png" class="img-fluid mt-3" style = "max-width: 28rem; left: 2rem; top: 0rem ; position: absolute" alt="Decorative Image">
                <img src="images/Running-Shoes.png" class="img-fluid mt-3" style = "max-width: 25rem; right: 2rem; bottom: 2rem ; position: absolute" alt="Decorative Image">
            </div>

            <div class="row justify-content-center">
                <div class="col-md-5">

                    <div class="card login-form">

                        <div class="card-header text-center">
                            <h2>Change Password</h2>
                        </div>



                        <div class="card-body">
                            <form action="homepage" method="post">
                                <h6 style="color: green">Your password has been changed successfully. Now you can head back to Homepage</h6>
                                <p  style="margin-top: 10px; margin-bottom: 10px; color: red;">${message}</p>
                                <div id="error" style="margin-top: 10px; margin-bottom: 10px; color: red;"></div>
                                <button type="submit" class="btn btn-primary btn-block">Back to Home page</button>
                                  
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>