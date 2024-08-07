/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;
import java.util.List;

/**
 *
 * @author LENOVO
 */
public class Orders {

    private int orderID;
    private int customerID;
    private String customerName;
    private float totalCost;
    private int numberOfItems;
    private String orderDate;
    private int orderStatusID;
    private String orderStatus;
    private int staffID;
    private String staff;
    private List<OrderDetail> orderDetail;
    private String firstProduct;
    private int receiverID;
    private String orderNotes;
    private String paymentMethods;
    private String title;
    private String image;
    private String receiverName;
    private String receiverAddress;

    public Orders() {
    }

    public Orders(int orderID, int customerID, float totalCost, int numberOfItems, String orderDate, int orderStatusID, String orderStatus, int staffID, int receiverID, String orderNotes) {
        this.orderID = orderID;
        this.customerID = customerID;
        this.totalCost = totalCost;
        this.numberOfItems = numberOfItems;
        this.orderDate = orderDate;
        this.orderStatusID = orderStatusID;
        this.orderStatus = orderStatus;
        this.staffID = staffID;
        this.receiverID = receiverID;
    }

    //This one for sale dashboard
    public Orders(int orderID, int customerID, float totalCost, int numberOfItems, String orderDate, int orderStatusID, int staffID) {
        this.orderID = orderID;
        this.customerID = customerID;
        this.totalCost = totalCost;
        this.numberOfItems = numberOfItems;
        this.orderDate = orderDate;
        this.orderStatusID = orderStatusID;
        this.staffID = staffID;
    }

//This one for order information
    public Orders(int orderID, String customerName, float totalCost, int numberOfItems, String orderDate, String orderStatus, String staff, List<OrderDetail> orderDetail, String firstProduct, String orderNotes, String paymentMethods) {
        this.orderID = orderID;
        this.customerName = customerName;
        this.totalCost = totalCost;
        this.numberOfItems = numberOfItems;
        this.orderDate = orderDate;
        this.orderStatus = orderStatus;
        this.staff = staff;
        this.orderDetail = orderDetail;
        this.firstProduct = firstProduct;
        this.orderNotes = orderNotes;
        this.paymentMethods = paymentMethods;
    }

    public Orders(int orderID, int customerID, String customerName, float totalCost, int numberOfItems, String orderDate, String orderStatus, String staff, List<OrderDetail> orderDetail, String firstProduct, String orderNotes, String paymentMethods) {
        this.orderID = orderID;
        this.customerID = customerID;
        this.customerName = customerName;
        this.totalCost = totalCost;
        this.numberOfItems = numberOfItems;
        this.orderDate = orderDate;
        this.orderStatus = orderStatus;
        this.staff = staff;
        this.orderDetail = orderDetail;
        this.firstProduct = firstProduct;
        this.orderNotes = orderNotes;
        this.paymentMethods = paymentMethods;
    }

    public Orders(int orderID, String customerName, float totalCost, int numberOfItems, String orderDate, String orderStatus, String staff, List<OrderDetail> orderDetail, String firstProduct, String orderNotes, String paymentMethods, int orderStatusID) {
        this.orderID = orderID;
        this.customerName = customerName;
        this.totalCost = totalCost;
        this.numberOfItems = numberOfItems;
        this.orderDate = orderDate;
        this.orderStatus = orderStatus;
        this.staff = staff;
        this.orderDetail = orderDetail;
        this.firstProduct = firstProduct;
        this.orderNotes = orderNotes;
        this.paymentMethods = paymentMethods;
        this.orderStatusID = orderStatusID;
    }

    public Orders(int orderID, int customerID, String customerName, float totalCost, int numberOfItems, String orderDate, String orderStatus, String staff, List<OrderDetail> orderDetail, String firstProduct, String orderNotes, String paymentMethods, String receiverName, String receiverAddress) {
        this.orderID = orderID;
        this.customerID = customerID;
        this.customerName = customerName;
        this.totalCost = totalCost;
        this.numberOfItems = numberOfItems;
        this.orderDate = orderDate;
        this.orderStatus = orderStatus;
        this.staff = staff;
        this.orderDetail = orderDetail;
        this.firstProduct = firstProduct;
        this.orderNotes = orderNotes;
        this.paymentMethods = paymentMethods;
        this.receiverName = receiverName;
        this.receiverAddress = receiverAddress;
    }

    public int getReceiverID() {
        return receiverID;
    }

    public void setReceiverID(int receiverID) {
        this.receiverID = receiverID;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getStaff() {
        return staff;
    }

    public void setStaff(String staff) {
        this.staff = staff;
    }

    public List<OrderDetail> getOrderDetail() {
        return orderDetail;
    }

    public void setOrderDetail(List<OrderDetail> orderDetail) {
        this.orderDetail = orderDetail;
    }

    public Orders(String orderDate, int totalCost) {
        this.orderDate = orderDate;
        this.totalCost = totalCost;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public float getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(float totalCost) {
        this.totalCost = totalCost;
    }

    public int getNumberOfItems() {
        return numberOfItems;
    }

    public void setNumberOfItems(int numberOfItems) {
        this.numberOfItems = numberOfItems;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public int getOrderStatusID() {
        return orderStatusID;
    }

    public void setOrderStatusID(int orderStatusID) {
        this.orderStatusID = orderStatusID;
    }

    public int getStaffID() {
        return staffID;
    }

    public void setStaffID(int staffID) {
        this.staffID = staffID;
    }

    public String getFirstProduct() {
        return firstProduct;
    }

    public void setFirstProduct(String firstProduct) {
        this.firstProduct = firstProduct;
    }

    public String getOrderNotes() {
        return orderNotes;
    }

    public void setOrderNotes(String orderNotes) {
        this.orderNotes = orderNotes;
    }

    public String getPaymentMethods() {
        return paymentMethods;
    }

    public void setPaymentMethods(String paymentMethods) {
        this.paymentMethods = paymentMethods;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getReceiverAddress() {
        return receiverAddress;
    }

    public void setReceiverAddress(String receiverAddress) {
        this.receiverAddress = receiverAddress;
    }

    @Override
    public String toString() {
        return "Orders{" + "orderID=" + orderID + ", customerName=" + customerName + ", totalCost=" + totalCost + ", numberOfItems=" + numberOfItems + ", orderDate=" + orderDate + ", orderStatus=" + orderStatus + ", staff=" + staff + ", orderDetail=" + orderDetail + ", firstProduct=" + firstProduct + '}';
    }

}