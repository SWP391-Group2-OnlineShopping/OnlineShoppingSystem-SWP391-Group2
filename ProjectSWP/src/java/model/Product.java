/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author dumspicy
 */
public class Product {

    private int ProductId;
    private String title;
    private float SalePrice;
    private float ListPrice;
    private String Description;
    private String BriefInformation;
    private int Quantities;
    private int Thumbnail;
    private Date LastDateUpdate;

    public Product() {
    }

    public Product(int ProductId, String title, float SalePrice, float ListPrice, String Description, String BriefInformation, int Quantities, int Thumbnail, Date LastDateUpdate) {
        this.ProductId = ProductId;
        this.title = title;
        this.SalePrice = SalePrice;
        this.ListPrice = ListPrice;
        this.Description = Description;
        this.BriefInformation = BriefInformation;
        this.Quantities = Quantities;
        this.Thumbnail = Thumbnail;
        this.LastDateUpdate = LastDateUpdate;
    }

    public int getProductId() {
        return ProductId;
    }

    public void setProductId(int ProductId) {
        this.ProductId = ProductId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public float getSalePrice() {
        return SalePrice;
    }

    public void setSalePrice(float SalePrice) {
        this.SalePrice = SalePrice;
    }

    public float getListPrice() {
        return ListPrice;
    }

    public void setListPrice(float ListPrice) {
        this.ListPrice = ListPrice;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    public String getBriefInformation() {
        return BriefInformation;
    }

    public void setBriefInformation(String BriefInformation) {
        this.BriefInformation = BriefInformation;
    }

    public int getQuantities() {
        return Quantities;
    }

    public void setQuantities(int Quantities) {
        this.Quantities = Quantities;
    }

    public int getThumbnail() {
        return Thumbnail;
    }

    public void setThumbnail(int Thumbnail) {
        this.Thumbnail = Thumbnail;
    }

    public Date getLastDateUpdate() {
        return LastDateUpdate;
    }

    public void setLastDateUpdate(Date LastDateUpdate) {
        this.LastDateUpdate = LastDateUpdate;
    }

    @Override
    public String toString() {
        return "Product{" + "ProductId=" + ProductId + ", title=" + title + ", SalePrice=" + SalePrice + ", ListPrice=" + ListPrice + ", Description=" + Description + ", BriefInformation=" + BriefInformation + ", Quantities=" + Quantities + ", Thumbnail=" + Thumbnail + ", LastDateUpdate=" + LastDateUpdate + '}';
    }
}
