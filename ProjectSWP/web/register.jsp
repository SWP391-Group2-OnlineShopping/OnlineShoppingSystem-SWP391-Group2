<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign up</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #CE4B40;
            }
            .register-form {
                background: #EFF2F1;
                padding: 10px;
                box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
                margin: 50px 0 50px;
            }
            .error {
                color: red;
                font-size: 0.9em;
            }
        </style>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const today = new Date().toISOString().split('T')[0];
                document.getElementById('dob').setAttribute('max', today);
            });

            document.getElementById('registerForm').addEventListener('submit', function (event) {
                if (!validateForm()) {
                    event.preventDefault();
                }
            });

        </script>
    </head>
    <body>
        <div class="container">
            <div>
                <img src="images/Black-Sneaker.png" class="img-fluid mt-3" style="max-width: 28rem; left: 2rem; top: 0rem; position: absolute" alt="Decorative Image">
                <img src="images/Running-Shoes.png" class="img-fluid mt-3" style="max-width: 25rem; right: 2rem; bottom: 2rem; position: absolute" alt="Decorative Image">
            </div>
            <div class="row justify-content-center">
                <div class="col-md-5">
                    <div class="card mt-3 register-form">
                        <div class="card-header text-center">
                            <h2>Sign Up</h2>
                            <div>
                                Already have an account? <a href="login.jsp" style="color: #F9BF29">Log In</a>
                            </div>
                        </div>
                        <div class="card-body">

                            <c:if test="${not empty error}">
                                <div class="alert alert-danger" role="alert">
                                    ${error}
                                </div>
                            </c:if>

                            <form id="registerForm" action="register" method="POST">
                                <div class="form-group">
                                    <label for="firstname">First Name</label>
                                    <input type="text" class="form-control" id="firstname" name="firstname" placeholder="First Name" required>
                                    <div id="firstnameError" class="error"></div>
                                </div>

                                <div class="form-group">
                                    <label for="lastname">Last Name</label>
                                    <input type="text" class="form-control" id="lastname" name="lastname" placeholder="Last Name" required>
                                    <div id="lastnameError" class="error"></div>
                                </div>

                                <div class="form-group">
                                    <label>Gender</label><br>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" id="female" name="gender" value="Female" >
                                        <label class="form-check-label" for="female">Female</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" id="male" name="gender" value="Male" >
                                        <label class="form-check-label" for="male">Male</label>
                                    </div>
                                    <div id="genderError" class="error"></div>
                                </div>

                                <div class="form-group">
                                    <label for="dob">Date of Birth</label>
                                    <input type="date" class="form-control" id="dob" name="dob" placeholder="mm/dd/yyyy" required>
                                    <div id="dobError" class="error"></div>
                                </div>

                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
                                    <div id="emailError" class="error"></div>
                                </div>

                                <div class="form-group">
                                    <label for="phonenumber">Phone Number</label>
                                    <input type="text" class="form-control" id="phonenumber" name="phonenumber" placeholder="Phone Number" required>
                                    <div id="phonenumberError" class="error"></div>
                                </div>

                                <div class="form-group">
                                    <label for="address">Address</label>
                                    <input type="text" class="form-control" id="address" name="address" placeholder="Address" required>
                                    <div id="addressError" class="error"></div>
                                </div>
                                <div class="form-group">
                                    <label for="username">User Name</label>
                                    <input type="text" class="form-control" id="username" name="username" placeholder="User Name" required>
                                </div>
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                                    <div id="passwordError" class="error"></div>
                                </div>

                                <div class="form-group">
                                    <label for="confirmpassword">Confirm Password</label>
                                    <input type="password" class="form-control" id="confirmpassword" name="confirmpassword" placeholder="Confirm Password" required>
                                    <div id="confirmpasswordError" class="error"></div>
                                </div>
                                <button type="submit" class="btn btn-primary btn-block" style="background-color: #F9BF29; border: none; color: #000; text-decoration: underline" onClick ="return validateForm()">Sign up</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="js/validateSignUp.js"></script>
    </body>
</html>
