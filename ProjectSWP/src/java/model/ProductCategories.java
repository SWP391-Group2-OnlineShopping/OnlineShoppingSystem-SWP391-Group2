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
    private Product ProductID;

    public ProductCategories() {
    }

    public ProductCategories(int mProductCID, ProductCategoryList ProductCL, Product ProductID) {
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

    public Product getProductID() {
        return ProductID;
    }

    public void setProductID(Product ProductID) {
        this.ProductID = ProductID;
    }

    
    
    
    
}
