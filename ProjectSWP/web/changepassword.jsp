
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
                            <form action="changepassword" method="post" id="form">
                                <div class="form-group">
                                    <label for="oldpassword">Current Password</label>
                                    <input type="password" class="form-control" id="oldpassword" name="oldpassword" placeholder="Password" required>
                                    <label for="newpassword">New Password</label>
                                    <input type="password" class="form-control" id="newpassword" name="newpassword" placeholder="Password" required>
                                    <label for="passwordcheck">Confirm New Password</label>
                                    <input type="password" class="form-control" id="passwordcheck" name="passwordcheck" placeholder="Password" required>
                                </div>
                                <div class="g-recaptcha" data-sitekey="6LckleEpAAAAAEQGKWDtFrvzbJ1yRPoRBhohKcLT"></div>
                                <p style="margin-top: 10px; margin-bottom: 10px; color: red;">${message}</p>
                                <div id="error" style="margin-top: 10px; margin-bottom: 10px; color: red;"></div>
                                <button type="submit" class="btn btn-primary btn-block">Send</button>
                                <u><a href="login.jsp" style="color:black">Back</a></u>   
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
        <script>
            $(document).ready(function () {
                $('#form').on('submit', function (event) {
                    event.preventDefault();  // Prevent form from submitting the default way

                    const oldPassword = $('#oldpassword').val();
                    const newPassword = $('#newpassword').val();
                    const passwordCheck = $('#passwordcheck').val();
                    const errorDiv = $('#error');

                    if (newPassword !== passwordCheck) {
                        errorDiv.text('New password and confirmation password do not match.');
                        return;
                    } else {
                        errorDiv.text('');  // Clear any previous error messages
                    }

                    const response = grecaptcha.getResponse();
                    if (!response) {
                        errorDiv.text('Please complete the Captcha.');
                        return;
                    }

                    // Perform the AJAX request
                    $.ajax({
                        url: 'changepassword',
                        method: 'POST',
                        data: {
                            oldpassword: oldPassword,
                            newpassword: newPassword,
                            passwordcheck: passwordCheck,
                            'g-recaptcha-response': grecaptcha.getResponse()
                        },
                        success: function (response) {
                            $('#error').text(response);
                            // Handle the response from the server
                            // Display a success message or redirect, etc.


                            // Display a success message or redirect, etc.

                        },
                        error: function (xhr, status, error) {
                            // Handle any errors that occurred during the request
                            errorDiv.text('An error occurred: ' + xhr.responseText);
                        }
                    });
                });
            });
        </script>
    </body>
</html>
