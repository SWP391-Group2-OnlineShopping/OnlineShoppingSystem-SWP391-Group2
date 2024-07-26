/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author admin
 */
public class OrderTrend {

    private Date orderDate;
    private int orderCount;
    private int successCount;

    public OrderTrend() {
    }

    public OrderTrend(Date orderDate, int orderCount, int successCount) {
        this.orderDate = orderDate;
        this.orderCount = orderCount;
        this.successCount = successCount;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public int getOrderCount() {
        return orderCount;
    }

    public void setOrderCount(int orderCount) {
        this.orderCount = orderCount;
    }

    public int getSuccessCount() {
        return successCount;
    }

    public void setSuccessCount(int successCount) {
        this.successCount = successCount;
    }
    
    
}
