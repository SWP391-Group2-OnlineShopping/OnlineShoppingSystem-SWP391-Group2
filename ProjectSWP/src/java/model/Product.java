package model;

import java.sql.Date;

public class Product {
    private int productID;
    private String title;
    private float salePrice;
    private float listPrice;
    private String description;
    private String briefInformation;
    private int  Thumbnail ; // Thay đổi kiểu dữ liệu thành Image
    private Date lastDateUpdate;
    private String formattedPrice;

    public Product() {
    }

    public Product(int productID, String title, float salePrice, float listPrice, String description, String briefInformation, int Thumbnail, Date lastDateUpdate, String formattedPrice) {
        this.productID = productID;
        this.title = title;
        this.salePrice = salePrice;
        this.listPrice = listPrice;
        this.description = description;
        this.briefInformation = briefInformation;
        this.Thumbnail = Thumbnail;
        this.lastDateUpdate = lastDateUpdate;
        this.formattedPrice = formattedPrice;
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

    public float getListPrice() {
        return listPrice;
    }

    public void setListPrice(float listPrice) {
        this.listPrice = listPrice;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getBriefInformation() {
        return briefInformation;
    }

    public void setBriefInformation(String briefInformation) {
        this.briefInformation = briefInformation;
    }

    public int getThumbnail() {
        return Thumbnail;
    }

    public void setThumbnail(int Thumbnail) {
        this.Thumbnail = Thumbnail;
    }

    public Date getLastDateUpdate() {
        return lastDateUpdate;
    }

    public void setLastDateUpdate(Date lastDateUpdate) {
        this.lastDateUpdate = lastDateUpdate;
    }

    public String getFormattedPrice() {
        return formattedPrice;
    }

    public void setFormattedPrice(String formattedPrice) {
        this.formattedPrice = formattedPrice;
    }
    
    
   
    
   
}