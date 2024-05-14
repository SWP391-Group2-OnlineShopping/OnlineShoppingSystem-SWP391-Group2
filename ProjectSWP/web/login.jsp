<%-- 
    Document   : login
    Created on : May 13, 2024, 8:51:56 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link href="css/login.css" rel="stylesheet">
    </head>
    <body>
        <div class="login-form">
            <h2>Login</h2>
            <form action="login" method="post">
                <input type="text" name="username" placeholder="User name" required>
                <input type="password" name="password" placeholder="Password" required>
                <div class="forgot-password">
                    <a href="#">Forgot Password?</a>
                </div>
                <input type="submit" value="Login">
            </form>
            <div class="account-options">
                <a href="register.jsp" class="create-account">Create Account</a>
            </div>
            <h4 style="color: green">${Notification}</h4> 
            <h4 style="color: red">${error}</h4>
            
            <div class="social-buttons">
                <a href="#" class="facebook">Facebook</a>
                <a href="#" class="google">Google</a>
            </div>
        </div>
    </body>
</html>
