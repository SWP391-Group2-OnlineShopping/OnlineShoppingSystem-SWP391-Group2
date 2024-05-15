<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<c:if test="${not empty product}">
    <c:forEach var="product" items="${product}">
        <div class="product">
            <img src="images/sneaker.png">
            <h3>${product.title}</h3>
            <p style="color: red;">${product.salePrice}₫</p>
        </div>
    </c:forEach>
</c:if>
<c:if test="${empty product}">
    <p>No products found.</p>
</c:if>
