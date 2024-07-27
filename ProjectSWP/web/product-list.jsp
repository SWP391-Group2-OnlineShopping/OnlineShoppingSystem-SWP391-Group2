<%@ page import="model.Products" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
    .discount-badge {
        position: absolute;
        top: 10px;
        right: 10px;
        background-color: red;
        color: white;
        padding: 5px 10px;
        border-radius: 5px;
        font-size: 14px;
        font-weight: bold;
    }
</style>


<c:if test="${not empty product}">
    <div class="product-grid">

        <c:forEach var="product" items="${product}" varStatus="status">

            <div class="card">
                <a href="productdetails?id=${product.productID}"> 
                    <img class="card-img-top" src="${product.thumbnailLink}" alt="${product.title}">
                </a>
                <div class="card-body text-center">

                    <a href="productdetails?id=${product.productID}" class="product-link">        
                        <h5 class="card-title">${product.title}</h5>
                    </a> 

                    <p>${product.briefInformation}</p>
                    <p class="card-text">
                        <span class="sale-price">${product.formattedPrice}</span>
                        <span class="list-price">${product.formattedListPrice}</span>
                    </p>

                    <c:set var="discountPercent" value="${((product.listPrice - product.salePrice) / product.listPrice) * 100}" />
                    <c:if test="${discountPercent > 0}">
                        <div class="discount-badge">
                            -<fmt:formatNumber value="${discountPercent}" type="number" maxFractionDigits="0"/>%
                        </div>
                    </c:if>


                    <div class="button-container d-flex justify-content-between">
                        <c:choose>
                            <c:when test="${sessionScope.staff != null}">
                            </c:when>
                            <c:when test="${sessionScope.acc == null}">
                                <button class="btn btn-primary">
                                    <a href="login?error=You must login before adding to cart&redirect=productdetails?id=${product.productID}&error=Please%20choose%20your%20size"><img src="images/shopping-bag.png" alt="Add to Cart" class="button-icon"></a>
                                </button>
                                <button class="btn btn-secondary">
                                    <img src="images/feedback.png" alt="Feed" class="button-icon">
                                </button>
                            </c:when>
                            <c:otherwise>
                                <button class="btn btn-primary">    
                                    <a href="productdetails?id=${product.productID}&error=Please choose your size"><img src="images/shopping-bag.png" alt="Add to Cart" class="button-icon"></a>
                                </button>
                                <button class="btn btn-secondary">
                                    <a href="LoadFeedbacks?productID=${sessionScope.product.productID}&page=1&filter=''">
                                        <img src="images/feedback.png" alt="Feed" class="button-icon">
                                    </a>

                                </button>
                            </c:otherwise>
                        </c:choose>
                    </div>

                </div>

            </div>

        </c:forEach>

    </div>
</c:if>


<c:if test="${empty product}">
    <div class="product-grid">
        <div class="empty-container"></div>
    </div>
</c:if>

<!-- Pagination -->
<c:if test="${totalProducts > productsPerPage}">
    <div class="pagination-container">
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <c:if test="${currentPage > 1}">
                    <li class="page-item">
                        <a class="page-link" href="product?page=${currentPage - 1}&sort=${sortCriteria}<c:forEach var='category' items='${selectedCategories}'>&category=${category}</c:forEach>&price=${selectedPrice}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                </c:if>
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                        <a class="page-link" href="product?page=${i}&sort=${sortCriteria}<c:forEach var='category' items='${selectedCategories}'>&category=${category}</c:forEach>&price=${selectedPrice}">${i}</a>
                        </li>
                </c:forEach>
                <c:if test="${currentPage < totalPages}">
                    <li class="page-item">
                        <a class="page-link" href="product?page=${currentPage + 1}&sort=${sortCriteria}<c:forEach var='category' items='${selectedCategories}'>&category=${category}</c:forEach>&price=${selectedPrice}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                </c:if>
            </ul>
        </nav>
    </div>
</c:if>

