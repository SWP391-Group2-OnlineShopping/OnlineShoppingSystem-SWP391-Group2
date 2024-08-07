/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class ProductCategoryList {

    private int productCL;
    private String name;
    private String description;
    private boolean checked;

    public ProductCategoryList() {
    }

    public ProductCategoryList(int productCL, String name, String description) {
        this.productCL = productCL;
        this.name = name;
        this.description = description;
    }

    public int getProductCL() {
        return productCL;
    }

    public void setProductCL(int productCL) {
        this.productCL = productCL;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isChecked() {
        return checked;
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
    }
    @Override
    public String toString() {
        return "ProductCategoryList{" + "productCL=" + productCL + ", name=" + name + ", description=" + description + ", checked=" + checked + '}';
    }
}