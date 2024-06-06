/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Objects;

/**
 *
 * @author dumspicy
 */
public class CartItem {

    private Products product;
    private int quantity;
    private int productCSID;
    private float price;
    private int size;

    public CartItem() {
    }

    public CartItem(Products product, int quantity, float price) {
        this.product = product;
        this.quantity = quantity;
        this.price = price;
    }

    public CartItem(Products product,int productCSID, int quantity, float price, int size) {
        this.product = product;
        this.productCSID = productCSID;
        this.quantity = quantity;
        this.price = price;
        this.size = size;
    }

    public CartItem(Products product, int size) {
        this.product = product;
        this.size = size;
    }

    public int getProductCSID() {
        return productCSID;
    }

    public void setProductCSID(int productCSID) {
        this.productCSID = productCSID;
    }

    public Products getProduct() {
        return product;
    }

    public void setProduct(Products product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 29 * hash + Objects.hashCode(this.product);
        hash = 29 * hash + this.quantity;
        hash = 29 * hash + (int) (Double.doubleToLongBits(this.price) ^ (Double.doubleToLongBits(this.price) >>> 32));
        hash = 29 * hash + this.size;
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }
        CartItem cartItem = (CartItem) obj;
        return product == cartItem.product && size == cartItem.size;
    }

    @Override
    public String toString() {
        return "CartItem{" + "product=" + product + ", quantity=" + quantity + ", price=" + price + ", size=" + size + '}';
    }

}
