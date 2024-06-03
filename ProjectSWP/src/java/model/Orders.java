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


    public Orders() {
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
    public Orders(int orderID, String customerName, float totalCost, int numberOfItems, String orderDate, String orderStatus, String staff, List<OrderDetail> orderDetail, String firstProduct) {
        this.orderID = orderID;
        this.customerName = customerName;
        this.totalCost = totalCost;
        this.numberOfItems = numberOfItems;
        this.orderDate = orderDate;
        this.orderStatus = orderStatus;
        this.staff = staff;
        this.orderDetail = orderDetail;
        this.firstProduct = firstProduct;
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


    @Override
    public String toString() {
        return "Orders{" + "orderID=" + orderID + ", customerName=" + customerName + ", totalCost=" + totalCost + ", numberOfItems=" + numberOfItems + ", orderDate=" + orderDate + ", orderStatus=" + orderStatus + ", staff=" + staff + ", orderDetail=" + orderDetail + ", firstProduct=" + firstProduct + '}';
    }

}
