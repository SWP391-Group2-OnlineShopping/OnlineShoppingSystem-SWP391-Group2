<%-- 
    Document   : resetpassword
    Created on : May 17, 2024, 9:09:55 PM
    Author     : LENOVO
--%>
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
                <img src="images/Black-Sneaker.png" class="img-fluid mt-3" style="max-width: 28rem; left: 2rem; top: 0rem; position: absolute" alt="Decorative Image">
                <img src="images/Running-Shoes.png" class="img-fluid mt-3" style="max-width: 25rem; right: 2rem; bottom: 2rem; position: absolute" alt="Decorative Image">
            </div>

            <div class="row justify-content-center">
                <div class="col-md-5">

                    <div class="card login-form">

                        <div class="card-header text-center">
                            <h2>Reset Password</h2>
                        </div>

                        <div class="card-body">
                            <form id="registerForm" action="resetpassword" method="post" onsubmit="return validateForm()">
                                <div class="form-group">
                                    <label for="newpass">Password</label>
                                    <input type="password" class="form-control" name="newpass" id="newpass" placeholder="Password" required />
                                    <div id="passwordError" class="error" style="color: red;"></div>
                                </div>   

                                <div class="form-group">
                                    <label for="re_newpass">Confirm Password</label>
                                    <input type="password" class="form-control" name="re_newpass" id="re_newpass" placeholder="Repeat your password" required />
                                    <div id="confirmpasswordError" class="error" style="color: red;"></div>
                                </div>                               
                                <button type="submit" class="btn btn-primary btn-block">Confirm</button>
                                <u><a href="login.jsp" style="color:black">Back</a></u>   
                                <h6 style="color: green">${Notification}</h6>
                                <h6 style="color: red">${error}</h6>
                            </form>
                        </div>                             
                    </div>
                </div>
            </div>
        </div>
        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
                                function validatePassword() {
                                    const password = $('#newpass').val();
                                    if (password.length < 10 || password.length > 15) {
                                        $('#passwordError').text('Password must be between 10 to 15 characters.');
                                        return false;
                                    } else {
                                        $('#passwordError').text('');
                                        return true;
                                    }
                                }

                                function validateConfirmPassword() {
                                    const password = $('#newpass').val();
                                    const confirmPassword = $('#re_newpass').val();
                                    if (password !== confirmPassword) {
                                        $('#confirmpasswordError').text('Passwords do not match.');
                                        return false;
                                    } else {
                                        $('#confirmpasswordError').text('');
                                        return true;
                                    }
                                }

                                function validateForm() {
                                    const isPasswordValid = validatePassword();
                                    const isConfirmPasswordValid = validateConfirmPassword();
                                    return isPasswordValid && isConfirmPasswordValid;
                                }

                                $(document).ready(function () {
                                    $('#newpass').on('input', validatePassword);
                                    $('#re_newpass').on('input', validateConfirmPassword);
                                });
        </script>
    </body>
</html>
