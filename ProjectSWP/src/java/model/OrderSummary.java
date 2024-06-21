/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author LENOVO
 */
public class OrderSummary {

    private String orderDate;
    private int staffID;
    private String fullName;
    private int totalRevenue;
    private int totalOrders;

    // Getters và setters cho từng thuộc tính
    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public int getStaffID() {
        return staffID;
    }

    public void setStaffID(int staffID) {
        this.staffID = staffID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public int getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(int totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public int getTotalOrders() {
        return totalOrders;
    }

    public void setTotalOrders(int totalOrders) {
        this.totalOrders = totalOrders;
    }

    @Override
    public String toString() {
        return "OrderSummary{" + "orderDate=" + orderDate + ", staffID=" + staffID + ", fullName=" + fullName + ", totalRevenue=" + totalRevenue + ", totalOrders=" + totalOrders + '}';
    }
    
}
