<%@ page import="model.Products" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${not empty product}">
    <div class="row">
        <c:forEach var="product" items="${product}" varStatus="status">
            <div class="col-md-4 mb-4">
                <div class="card">
                    <a href="productdetails?id=${product.productID}">
                        <img class="card-img-top" src="${product.thumbnailLink}" alt="${product.title}">
                        <div class="card-body text-center">
                            <h5 class="card-title">${product.title}</h5>
                            <p class="card-text text-danger">${product.formattedPrice}</p>
                        </div>
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>
</c:if>
<c:if test="${empty product}">
    <div class="row">
        <div class="no-products">
            <p>No products found.</p>
        </div>
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

