<%-- 
    Document   : login
    Created on : May 13, 2024, 8:51:56 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="dal.StaffDAO"%>
<%@page import="model.Staffs"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .login-form {
                padding: 1rem;
                box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
                margin-top: 8rem;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-5">
                    <div class="card login-form">
                        <div class="card-header text-center">
                            <%
                                int role = Integer.parseInt(request.getParameter("role"));
                                String name;
                                if (role == 1) {
                                    name = "Admin";
                                } else if (role == 2) {
                                    name = "Sale Manager";
                                } else if (role == 3) {
                                    name = "Sale";
                                } else {
                                    name = "Marketer";
                                }
                                out.println("<h2>" + name + " Login</h2>");
                            %>
                        </div>
                        <div class="card-body">
                            <form action="staffvalidate" method="post">
                                <input type="hidden" name="role" value="<c:out value='${param.role}'/>">
                                <div class="form-group">
                                    <label for="username">Username</label>
                                    <input type="text" class="form-control" id="username" name="username" placeholder="User name" value="<c:out value='${param.username}'/>" required>
                                </div>
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="password" class="form-control" id="password" name="password" placeholder="Password" value="<c:out value='${param.password}'/>" required>
                                </div>
                                <%-- Display error message if exists --%>
                                <c:if test="${not empty errorMessage}">
                                    <p class="error-message" style="color: red">${errorMessage}</p>
                                </c:if>
                                <button type="submit" class="btn btn-primary btn-block">Login</button>
                            </form>
                        </div>
                        <div class="text-center mt-2">
                            <a href="staff.jsp">Back</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>