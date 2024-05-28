<%-- 
    Document   : latestproductlist
    Created on : 27 May 2024, 22:14:47
    Author     : dumspicy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .rec-product-inner {
                background: #fff;
            }

            .rec-product-title {
                background: #fafafa;
            }
        </style>
    </head>
    <body>
        <!-- ====== Start Recommended Product ======== -->

        <c:if test="${not empty lastestPro}">
            <h3 class="rec-product-title p-3 mb-4">Latest Product</h3>
            <div class="product-grid pt-3" style="display: flex; gap: 25px;">

                <c:forEach var="latestProduct" items="${sessionScope.lastestPro}" varStatus="status">

                    <div class="card">
                        <a href="productdetails?id=${latestProduct.productID}"> 
                            <img class="card-img-top" src="${latestProduct.thumbnailLink}" alt="${latestProduct.title}">
                        </a>
                        <div class="card-body text-center">

                            <a href="productdetails?id=${latestProduct.productID}" class="product-link">        
                                <h5 class="card-title">${latestProduct.title}</h5>
                            </a> 

                            <p>${latestProduct.briefInformation}</p>
                            <p class="card-text">
                                <span class="sale-price"><fmt:formatNumber value="${latestProduct.salePrice}" pattern="###,###" /></span>
                                <span class="list-price"><fmt:formatNumber value="${latestProduct.listPrice}" pattern="###,###" /></span>
                            </p> 


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


        <c:if test="${empty latestPro}">
            <div class="product-grid">
                <div class="empty-container">
                    <h1>hasdhashd</h1>
                </div>
            </div>
        </c:if>

        <!-- ====== End Recommended Product =========== -->
    </body>
</html>
