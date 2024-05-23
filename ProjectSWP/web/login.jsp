<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
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
                            <h2>Login</h2>
                        </div>
                        <c:set var="cookie" value="${pageContext.request.cookies}"/>
                        <div class="card-body">
                            <c:if test="${not empty param.message}">
                                <div class="alert alert-danger" role="alert">
                                    ${param.message}
                                </div>
                            </c:if>

                            <c:if test="${not empty error}">
                                <div class="alert alert-danger" role="alert">
                                    ${error}
                                </div>
                            </c:if>

                            <c:if test="${not empty errors}">
                                <div class="alert alert-danger" role="alert">
                                    ${errors}
                                </div>
                            </c:if>


                            <c:if test="${not empty Notification}">
                                <div class="alert alert-info" role="alert">
                                    ${Notification}
                                </div>
                            </c:if>


                            <form action="login" method="post">
                                <div class="form-group">
                                    <label for="username">Username</label>
                                    <input type="text" value="${cookie.cusername.value}" class="form-control" id="username" name="username" placeholder="User name" required>
                                </div>
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="password" value="${cookie.cpass.value}" class="form-control" id="password" name="password" placeholder="Password" required>
                                </div>
                                <div class="form-group">
                                    <input type="checkbox" ${(cookie.crem!=null?'checked':'')} name="rem" id="rem" value="ON" class="agree-term" />
                                    <label for="rem"  class="label-agree-term"><span><span></span></span>Remember me</label>
                                </div>
                                <div class="form-group text-right">
                                    <a href="resetpassword.jsp" class="small" style="color: #F9BF29">Forgot Password?</a>
                                </div>
                                <button type="submit" class="btn btn-primary btn-block">Login</button>
                            </form>
                            <div class="text-center mt-2">
                                Don't have an Account? <a href="register.jsp" style="color: #F9BF29">Create one</a>
                            </div>  
                        </div>
                        <u> <a href="index.jsp" style="color:black">Back</a></u>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
