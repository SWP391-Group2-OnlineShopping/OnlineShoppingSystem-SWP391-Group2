package model;

import java.util.Date;

public class Products {
    private int productID;
    private String title;
    private float salePrice;
    private float listPrice;
    private String description;
    private String briefInformation;
    private int Thumbnail; // Assuming this is an integer representing image ID
    private Date lastDateUpdate;
    private String formattedPrice;
    private String thumbnailLink;
    private String formattedListPrice;
    private String category; // Assuming you need a category field
    private String size;
    private String QuantitiesSizes; 
    private boolean Status;
    private boolean Feature;

    public Products() {
    }

    public Products(int productID, String title, float salePrice, float listPrice, String description, String briefInformation, int Thumbnail, Date lastDateUpdate, String formattedPrice, String thumbnailLink, String formattedListPrice, String category, String size, String QuantitiesSizes, boolean Status, boolean Feature) {
        this.productID = productID;
        this.title = title;
        this.salePrice = salePrice;
        this.listPrice = listPrice;
        this.description = description;
        this.briefInformation = briefInformation;
        this.Thumbnail = Thumbnail;
        this.lastDateUpdate = lastDateUpdate;
        this.formattedPrice = formattedPrice;
        this.thumbnailLink = thumbnailLink;
        this.formattedListPrice = formattedListPrice;
        this.category = category;
        this.size = size;
        this.QuantitiesSizes = QuantitiesSizes;
        this.Status = Status;
        this.Feature = Feature;
    }
    
     
    // Getters and setters

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

    public String getThumbnailLink() {
        return thumbnailLink;
    }

    public void setThumbnailLink(String thumbnailLink) {
        this.thumbnailLink = thumbnailLink;
    }

    public String getFormattedListPrice() {
        return formattedListPrice;
    }

    public void setFormattedListPrice(String formattedListPrice) {
        this.formattedListPrice = formattedListPrice;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getQuantitiesSizes() {
        return QuantitiesSizes;
    }

    public void setQuantitiesSizes(String QuantitiesSizes) {
        this.QuantitiesSizes = QuantitiesSizes;
    }

    public boolean isStatus() {
        return Status;
    }

    public void setStatus(boolean Status) {
        this.Status = Status;
    }

    public boolean isFeature() {
        return Feature;
    }

    public void setFeature(boolean Feature) {
        this.Feature = Feature;
    }
   
    
}
