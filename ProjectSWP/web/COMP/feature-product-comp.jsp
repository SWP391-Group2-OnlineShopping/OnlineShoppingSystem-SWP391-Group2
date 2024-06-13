<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, dal.*, model.*, Format.CurrencyFormatter" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<link href="css/productcss.css" rel="stylesheet">
<style>.testimonial-section {
        padding: 3rem 0 7rem 0;
    }

    .testimonial-slider-wrap {
        position: relative;
    }
    .testimonial-slider-wrap .tns-inner {
        padding-top: 30px;
    }
    .testimonial-slider-wrap .item .testimonial-block blockquote {
        font-size: 16px;
    }
    @media (min-width: 768px) {
        .testimonial-slider-wrap .item .testimonial-block blockquote {
            line-height: 32px;
            font-size: 18px;
        }
    }
    .testimonial-slider-wrap .item .testimonial-block .author-info .author-pic {
        margin-bottom: 20px;
    }
    .testimonial-slider-wrap .item .testimonial-block .author-info .author-pic img {
        max-width: 80px;
        border-radius: 50%;
    }
    .testimonial-slider-wrap .item .testimonial-block .author-info h3 {
        font-size: 14px;
        font-weight: 700;
        color: #2f2f2f;
        margin-bottom: 0;
    }
    .testimonial-slider-wrap #testimonial-nav {
        position: absolute;
        top: 50%;
        z-index: 99;
        width: 100%;
        display: none;
    }
    @media (min-width: 768px) {
        .testimonial-slider-wrap #testimonial-nav {
            display: block;
        }
    }
    .testimonial-slider-wrap #testimonial-nav > span {
        cursor: pointer;
        position: absolute;
        width: 58px;
        height: 58px;
        line-height: 58px;
        border-radius: 50%;
        background: rgba(59, 93, 80, 0.1);
        color: #2f2f2f;
        -webkit-transition: .3s all ease;
        -o-transition: .3s all ease;
        transition: .3s all ease;
    }
    .testimonial-slider-wrap #testimonial-nav > span:hover {
        background: #3b5d50;
        color: #ffffff;
    }
    .testimonial-slider-wrap #testimonial-nav .prev {
        left: -10px;
    }
    .testimonial-slider-wrap #testimonial-nav .next {
        right: 0;
    }
    .testimonial-slider-wrap .tns-nav {
        position: absolute;
        bottom: -50px;
        left: 50%;
        -webkit-transform: translateX(-50%);
        -ms-transform: translateX(-50%);
        transform: translateX(-50%);
    }
    .testimonial-slider-wrap .tns-nav button {
        background: none;
        border: none;
        display: inline-block;
        position: relative;
        width: 0 !important;
        height: 7px !important;
        margin: 2px;
    }
    .testimonial-slider-wrap .tns-nav button:active, .testimonial-slider-wrap .tns-nav button:focus, .testimonial-slider-wrap .tns-nav button:hover {
        outline: none;
        -webkit-box-shadow: none;
        box-shadow: none;
        background: none;
    }
    .testimonial-slider-wrap .tns-nav button:before {
        display: block;
        width: 7px;
        height: 7px;
        left: 0;
        top: 0;
        position: absolute;
        content: "";
        border-radius: 50%;
        -webkit-transition: .3s all ease;
        -o-transition: .3s all ease;
        transition: .3s all ease;
        background-color: #d6d6d6;
    }
    .testimonial-slider-wrap .tns-nav button:hover:before, .testimonial-slider-wrap .tns-nav button.tns-nav-active:before {
        background-color: #3b5d50;
    }
</style>

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
        <!-- Start Product Testimonial Slider -->
        <div class="testimonial-section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-12 ">
                        <div class="testimonial-slider-wrap text-center">

                            <div id="testimonial-nav">
                                <span class="prev" data-controls="prev"><span class="fa fa-chevron-left"></span></span>
                                <span class="next" data-controls="next"><span class="fa fa-chevron-right"></span></span>
                            </div>

                            <%  
                                ProductDAO productDAO = new ProductDAO();
                                List<Products> products = productDAO.getProductsWithFeature();
                                request.setAttribute("products", products);
                                for (Products product : products) {
                                        product.setFormattedPrice(CurrencyFormatter.formatCurrency(product.getSalePrice()));
                                        product.setFormattedListPrice(CurrencyFormatter.formatCurrency(product.getListPrice()));
                                    }
                            %>
                            <div class="testimonial-slider">
                                <c:forEach var="product" items="${products}" varStatus="status">
                                    <c:if test="${status.index % 3 == 0}">
                                        <div class="testimonial-item">
                                            <div class="row">
                                            </c:if>

                                            <div class="col-md-4 mb-4">
                                                <div class="card">
                                                    <a href="productdetails?id=${product.productID}"> 
                                                        <img class="card-img-top" src="${product.thumbnailLink}" alt="${product.title}">
                                                    </a>
                                                    <div class="card-body text-center">
                                                        <a href="productdetails?id=${product.productID}"> 
                                                            <h5 class="card-title">${product.title}</h5>
                                                            <p class="card-text">
                                                                <span class="sale-price">${product.formattedPrice}</span>
                                                                <span class="list-price">${product.formattedListPrice}</span>
                                                            </p>
                                                        </a>
                                                        <div class="button-container d-flex justify-content-between">
                                                            <c:choose>
                                                                <c:when test="${sessionScope.staff != null}">
                                                                </c:when>
                                                                <c:when test="${sessionScope.acc == null}">
                                                                    <button class="btn btn-primary">
                                                                        <a href="login?error=You must login before adding to cart"><img src="images/shopping-bag.png" alt="Add to Cart" class="button-icon"></a>
                                                                    </button>
                                                                    <button class="btn btn-secondary">
                                                                        <img src="images/feedback.png" alt="Feed" class="button-icon">
                                                                    </button>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <button class="btn btn-primary">    
                                                                        <a href="productdetails?id=${product.productID}"><img src="images/shopping-bag.png" alt="Add to Cart" class="button-icon"></a>
                                                                    </button>
                                                                    <button class="btn btn-secondary">
                                                                        <img src="images/feedback.png" alt="Feed" class="button-icon">
                                                                    </button>
                                                                </c:otherwise>
                                                            </c:choose>
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
        <!-- End Product Testimonial Slider -->
    </div>


</div>