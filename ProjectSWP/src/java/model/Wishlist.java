/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author dumspicy
 */
public class Wishlist {
    private int wishlistID;
    private int customerID;
    private int productID;
    private boolean status;

    public Wishlist() {
    }

    public Wishlist(int customerID, int productID){
        this.customerID = customerID;
        this.productID = productID;
    }
    
    public Wishlist(int wishlistID, int customerID, int productID) {
        this.wishlistID = wishlistID;
        this.customerID = customerID;
        this.productID = productID;
    }

    public int getWishlistID() {
        return wishlistID;
    }

    public void setWishlistID(int wishlistID) {
        this.wishlistID = wishlistID;
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

    public boolean isStatus() {
        return status;
    }
    
    public void setStatus(boolean status) {
        this.status = status;
    }
    
    @Override
    public String toString() {
        return "Wishlist{" + "wishlistID=" + wishlistID + ", customerID=" + customerID + ", productID=" + productID + '}';
    }
    
    
}
