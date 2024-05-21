/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author LENOVO
 */
public class OrderDetail {

    private int orderDetailID;
    private int cartDetailID;
    private int orderID;
    private int productID;
    private String title;
    private float salePrice;
    private String image;
    private int quantitySold;
    private float priceSold;

    public OrderDetail() {
    }

    public OrderDetail(int productID, String title, float salePrice, String image, int quantitySold, float priceSold) {
        this.productID = productID;
        this.title = title;
        this.salePrice = salePrice;
        this.image = image;
        this.quantitySold = quantitySold;
        this.priceSold = priceSold;
    }

    public OrderDetail(int orderDetailID, int cartDetailID, int orderID, int productID, String title, float salePrice, String image, int quantitySold, float priceSold) {
        this.orderDetailID = orderDetailID;
        this.cartDetailID = cartDetailID;
        this.orderID = orderID;
        this.productID = productID;
        this.title = title;
        this.salePrice = salePrice;
        this.image = image;
        this.quantitySold = quantitySold;
        this.priceSold = priceSold;
    }

    public int getOrderDetailID() {
        return orderDetailID;
    }

    public void setOrderDetailID(int orderDetailID) {
        this.orderDetailID = orderDetailID;
    }

    public int getCartDetailID() {
        return cartDetailID;
    }

    public void setCartDetailID(int cartDetailID) {
        this.cartDetailID = cartDetailID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public float getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(float salePrice) {
        this.salePrice = salePrice;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getQuantitySold() {
        return quantitySold;
    }

    public void setQuantitySold(int quantitySold) {
        this.quantitySold = quantitySold;
    }

    public float getPriceSold() {
        return priceSold;
    }

    public void setPriceSold(float priceSold) {
        this.priceSold = priceSold;
    }

    @Override
    public String toString() {
        return "OrderDetail{" + "orderDetailID=" + orderDetailID + ", cartDetailID=" + cartDetailID + ", orderID=" + orderID + ", productID=" + productID + ", title=" + title + ", salePrice=" + salePrice + ", image=" + image + ", quantitySold=" + quantitySold + ", priceSold=" + priceSold + '}';
    }

}
