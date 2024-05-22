<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, dal.*, model.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>

<%
    ProductDAO productDAO = new ProductDAO();
    List<Products> products = productDAO.getProducts();
    request.setAttribute("products", products);
%>
<div class="blog-section py-5 ">

    <div class="container mb-5">
        <div class=" col-md-2">
            <div class="col-md-12">
                <h2 class="section-title">Featured Products</h2>
            </div>
            <div class="col-md-12">
                <a href="product" class="">View All Products</a>
            </div>
        </div>
        <!-- TODO: cap nhat link product detail -->
        <div class="ml-5 row justify-content-center col-md-10">
            <c:forEach var="product" items="${products}" varStatus="status" begin="0" end="2">
                <div class="col-md-4 mb-4">
                    <div class="card">
                        <a href="#" ><img class="card-img-top" src="${product.thumbnailLink}" alt="${product.title}"></a>
                        <div class="card-body text-center">
                            <h5 class="card-title"><a href="#">${product.title}</a></h5>
                            <p class="card-text text-danger">${product.formattedPrice}</p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>