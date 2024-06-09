package model;

import java.sql.Date;

public class Products {

    private int productID;
    private String title;
    private float salePrice;
    private float listPrice;
    private String description;
    private String briefInformation;
    private int Thumbnail; // Thay đổi kiểu dữ liệu thành Image
    private Date lastDateUpdate;
    private String formattedPrice;
    private String thumbnailLink;
    private String formattedListPrice;
    private String size;
    private int quantity;
    private boolean status;
    private boolean feature;
    private int productCSID;

    public Products() {
    }

    public Products(int productID, String title, float salePrice, float listPrice, String description, String briefInformation, int Thumbnail, Date lastDateUpdate, String thumbnailLink, boolean status, boolean feature) {
        this.productID = productID;
        this.title = title;
        this.salePrice = salePrice;
        this.listPrice = listPrice;
        this.description = description;
        this.briefInformation = briefInformation;
        this.Thumbnail = Thumbnail;
        this.lastDateUpdate = lastDateUpdate;
        this.thumbnailLink = thumbnailLink;
        this.status = status;
        this.feature = feature;
    }

   

    public Products(int productID, String title, float salePrice, float listPrice, String description, String briefInformation, int Thumbnail, Date lastDateUpdate, String formattedPrice, String thumbnailLink, String formattedListPrice) {
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
    }

    public Products(int productID, String title, float salePrice, String size, int quantity, String thumbnailLink) {
        this.productID = productID;
        this.title = title;
        this.salePrice = salePrice;
        this.size = size;
        this.quantity = quantity;
        this.thumbnailLink = thumbnailLink;
    }
    public Products(int productID, String title, float salePrice, String size, int quantity, String thumbnailLink,int productCSID) {
        this.productID = productID;
        this.title = title;
        this.salePrice = salePrice;
        this.size = size;
        this.quantity = quantity;
        this.thumbnailLink = thumbnailLink;
        this.productCSID = productCSID;
    }

    public int getProductCSID() {
        return productCSID;
    }

    public void setProductCSID(int productCSID) {
        this.productCSID = productCSID;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public boolean isFeature() {
        return feature;
    }

    public void setFeature(boolean feature) {
        this.feature = feature;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
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

    @Override
    public String toString() {
        return "Products{" + "productID=" + productID + ", title=" + title + ", salePrice=" + salePrice + ", listPrice=" + listPrice + ", description=" + description + ", briefInformation=" + briefInformation + ", Thumbnail=" + Thumbnail + ", lastDateUpdate=" + lastDateUpdate + ", formattedPrice=" + formattedPrice + ", thumbnailLink=" + thumbnailLink + ", formattedListPrice=" + formattedListPrice + ", size=" + size + ", quantity=" + quantity + '}';
    }

}
