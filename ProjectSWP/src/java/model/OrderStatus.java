/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author LENOVO
 */
public class OrderStatus {

    private int orderStatusID;
    private String orderStatus;

    public OrderStatus() {
    }

    public OrderStatus(int orderStatusID, String orderStatus) {
        this.orderStatusID = orderStatusID;
        this.orderStatus = orderStatus;
    }

    public int getOrderStatusID() {
        return orderStatusID;
    }

    public void setOrderStatusID(int orderStatusID) {
        this.orderStatusID = orderStatusID;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    @Override
    public String toString() {
        return "OrderStatus{" + "orderStatusID=" + orderStatusID + ", orderStatus=" + orderStatus + '}';
    }

}
