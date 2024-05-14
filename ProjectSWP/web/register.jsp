<%-- 
    Document   : register
    Created on : May 13, 2024, 8:51:56 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign up</title>
        <link href="css/register.css" rel="stylesheet">
    </head>
    <body>
        <div class="register-form">
            <h2>Sign up an account</h2>
            <form action="register" method="post">
                <input type="text" name="firstname" placeholder="First Name" required>
                <input type="text" name="lastname" placeholder="Last Name" required>
                <div class="gender">
                    <input type="radio" id="female" name="gender" value="0">
                    <label for="female">Female</label>
                    <input type="radio" id="male" name="gender" value="1">
                    <label for="male">Male</label>
                </div>
                <input type="text" name="dob" placeholder="mm/dd/yyyy" required>
                <input type="email" name="email" placeholder="Email" required>
                 <input type="text" name="phonenumber" placeholder="Phone Number" required>
                <input type="text" name="address" placeholder="Address" required>
                <input type="text" name="username" placeholder="User Name" required>
                <input type="password" name="password" placeholder="Password" required>
                <input type="password" name="confirmpassword" placeholder="Confirm Password" required>
                <input type="submit" value="Sign up">
            </form>
            <div class="navigation-links">
                <a href="login.jsp">← Back</a>
            </div>
        </div>
    </body>
</html>
