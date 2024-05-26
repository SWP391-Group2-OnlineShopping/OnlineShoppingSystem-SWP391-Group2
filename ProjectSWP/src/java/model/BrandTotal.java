/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author LENOVO
 */
public class BrandTotal {

    private String brandName;
    private double totalAmount;

    public BrandTotal(String brandName, double totalAmount) {
        this.brandName = brandName;
        this.totalAmount = totalAmount;
    }

    public String getBrandName() {
        return brandName;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    @Override
    public String toString() {
        return "BrandTotal{" + "brandName=" + brandName + ", totalAmount=" + totalAmount + '}';
    }
    
}
