/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author dumspicy
 */
public class ViewedProduct {
    private int viewedProductID;
    private int customerID;
    private int productID;

    public ViewedProduct() {
    }
    
    public ViewedProduct(int customerID, int productID){
        this.customerID = customerID;
        this.productID = productID;
    }

    public ViewedProduct(int viewedProductID, int customerID, int productID) {
        this.viewedProductID = viewedProductID;
        this.customerID = customerID;
        this.productID = productID;
    }

    public int getViewedProductID() {
        return viewedProductID;
    }

    public void setViewedProductID(int viewedProductID) {
        this.viewedProductID = viewedProductID;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    @Override
    public String toString() {
        return "ViewedProduct{" + "viewedProductID=" + viewedProductID + ", customerID=" + customerID + ", productID=" + productID + '}';
    }
    
    
}
