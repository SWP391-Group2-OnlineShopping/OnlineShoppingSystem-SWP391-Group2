<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, dal.*, model.*, Format.CurrencyFormatter" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<link href="css/productcss.css" rel="stylesheet">
<%  
    ProductDAO productDAO = new ProductDAO();
    List<Products> products = productDAO.getProducts();
    request.setAttribute("products", products);
    for (Products product : products) {
            product.setFormattedPrice(CurrencyFormatter.formatCurrency(product.getSalePrice()));
            product.setFormattedListPrice(CurrencyFormatter.formatCurrency(product.getListPrice()));
        }
%>
<div class="blog-section py-5 ">

    <div class="container mb-5">
        <div class="mb-5">
            <div class="col-md-12">
                <h2 class="section-title">Featured Products</h2>
            </div>
            <div class="col-md-12">
                <a href="product" class="">View All Products</a>
            </div>
        </div>
        <!-- TODO: cap nhat link product detail -->
        <!-- Start Testimonial Slider -->
        <div class="testimonial-section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-12 ">
                        <div class="testimonial-slider-wrap text-center">

                            <div id="testimonial-nav">
                                <span class="prev" data-controls="prev"><span class="fa fa-chevron-left"></span></span>
                                <span class="next" data-controls="next"><span class="fa fa-chevron-right"></span></span>
                            </div>

                            <div class="testimonial-slider">
                                <c:forEach var="product" items="${products}" varStatus="status">
                                    <c:if test="${status.index % 3 == 0}">
                                        <div class="testimonial-item">
                                            <div class="row">
                                            </c:if>

                                            <div class="col-md-4 mb-4">
                                                <div class="card">
                                                    <img class="card-img-top" src="${product.thumbnailLink}" alt="${product.title}">
                                                    <div class="card-body text-center">
                                                        <h5 class="card-title">${product.title}</h5>
                                                        <p class="card-text">
                                                            <span class="sale-price">${product.formattedPrice}</span>
                                                            <span class="list-price">${product.formattedListPrice}</span>
                                                        </p>
                                                        <div class="button-container d-flex justify-content-between">
                                                            <button class="btn btn-primary">
                                                                <img src="images/shopping-bag.png" alt="Add to Cart" class="button-icon">
                                                            </button>
                                                            <button class="btn btn-secondary">
                                                                <img src="images/feedback.png" alt="Feed" class="button-icon">
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <c:if test="${status.index % 3 == 2 || status.last}">
                                            </div> <!-- End row -->
                                        </div> <!-- End testimonial-item -->
                                    </c:if>
                                </c:forEach>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Testimonial Slider -->
    </div>
</div>