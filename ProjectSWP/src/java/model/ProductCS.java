/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package model;

/**
 *
 * @author dumspicy
 */
public class ProductCS {
    private int productCSID;
    private int size;
    private int quantities;
    private int productID;

    public ProductCS() {
    }

    public ProductCS(int productCSID, int size, int quantities, int productID) {
        this.productCSID = productCSID;
        this.size = size;
        this.quantities = quantities;
        this.productID = productID;
    }

    public int getProductCSID() {
        return productCSID;
    }

    public void setProductCSID(int productCSID) {
        this.productCSID = productCSID;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public int getQuantities() {
        return quantities;
    }

    public void setQuantities(int quantities) {
        this.quantities = quantities;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    @Override
    public String toString() {
        return "ProductCS{" + "productCSID=" + productCSID + ", size=" + size + ", quantities=" + quantities + ", productID=" + productID + '}';
    }
    
    
}
