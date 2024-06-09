<%-- orders.jsp --%>
<%@ page import="model.Products" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<c:forEach items="${orders}" var="o" varStatus="status">
    <div class="row" style="font-size: 18px;">
        <div class="col-md-1">#${status.index+1}</div>
        <div class="col-md-11">
            <div class="row">
                <div class="col-md-12">
                    <div class="pull-right" style="background: red;">${o.orderStatus}</div>
                    <a href="orderdetail?orderID=${o.orderID}">
                        <span><strong>OrderID: </strong></span>
                        <span class="label label-info">${o.orderID}</span>
                    </a><br />
                    ${o.firstProduct} and ${o.numberOfItems-1} more...  <br />
                </div>
                <div class="col-md-12" style="font-size: 14px;">order made on: ${o.orderDate} by <a href="customerInfo?id=${o.customerID}">${o.customerName}</a></div>
            </div>
        </div>
    </div>
</c:forEach>
