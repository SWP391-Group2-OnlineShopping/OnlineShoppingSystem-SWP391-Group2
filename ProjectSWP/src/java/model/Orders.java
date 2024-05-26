/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author LENOVO
 */
public class Orders {

    private int orderID;
    private int customerID;
    private float totalCost;
    private int numberOfItems;
    private String orderDate;
    private int orderStatusID;
    private int staffID;

    public Orders() {
    }

    public Orders(int orderID, int customerID, float totalCost, int numberOfItems, String orderDate, int orderStatusID, int staffID) {
        this.orderID = orderID;
        this.customerID = customerID;
        this.totalCost = totalCost;
        this.numberOfItems = numberOfItems;
        this.orderDate = orderDate;
        this.orderStatusID = orderStatusID;
        this.staffID = staffID;
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

    @Override
    public String toString() {
        return "Orders{" + "orderID=" + orderID + ", customerID=" + customerID + ", totalCost=" + totalCost + ", numberOfItems=" + numberOfItems + ", orderDate=" + orderDate + ", orderStatusID=" + orderStatusID + ", staffID=" + staffID + '}';
    }

}
