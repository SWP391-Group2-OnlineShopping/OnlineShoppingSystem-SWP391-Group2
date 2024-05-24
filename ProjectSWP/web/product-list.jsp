<%@ page import="model.Products" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
    .product-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 10px;
        min-height: 50vh; /* Đảm bảo chiều cao tối thiểu */
        width: 100%; /* Đảm bảo chiều rộng */
    }

    .product-grid .card {
        margin: 0;
    }

    .empty-container {
        grid-column: span 3; /* Đảm bảo container chiếm toàn bộ chiều rộng */
        height: 50vh; /* Đảm bảo chiều cao */
        background-color: transparent; /* Chỉ để đảm bảo không bị thu hẹp */
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
                                <!-- Custom logic for staff if needed -->
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
                                    <a href="cart.jsp"><img src="images/shopping-bag.png" alt="Add to Cart" class="button-icon"></a>
                                </button>
                                <button class="btn btn-secondary">
                                    <img src="images/feedback.png" alt="Feed" class="button-icon">
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

