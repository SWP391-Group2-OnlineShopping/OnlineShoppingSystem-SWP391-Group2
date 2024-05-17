/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class ProductCategories {
    private int mProductCID;
    private ProductCategoryList ProductCL;
    private Products ProductID;

    public ProductCategories() {
    }

    public ProductCategories(int mProductCID, ProductCategoryList ProductCL, Products ProductID) {
        this.mProductCID = mProductCID;
        this.ProductCL = ProductCL;
        this.ProductID = ProductID;
    }

    public int getmProductCID() {
        return mProductCID;
    }

    public void setmProductCID(int mProductCID) {
        this.mProductCID = mProductCID;
    }

    public ProductCategoryList getProductCL() {
        return ProductCL;
    }

    public void setProductCL(ProductCategoryList ProductCL) {
        this.ProductCL = ProductCL;
    }

    public Products getProductID() {
        return ProductID;
    }

    public void setProductID(Products ProductID) {
        this.ProductID = ProductID;
    }

    
    
    
    
}
