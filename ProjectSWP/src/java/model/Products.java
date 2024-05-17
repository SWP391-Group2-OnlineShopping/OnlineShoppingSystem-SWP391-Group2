package model;

import java.util.Date;

public class Products {

    private int productID;
    private String title;
    private float salePrice;
    private float listPrice;
    private String description;
    private String briefInformation;
    private int quantities;
    private int Thumbnail; // Thay đổi kiểu dữ liệu thành Image
    private Date lastDateUpdate;
    private String formattedPrice;

    public Products() {
    }

    public Products(int productID, String title, float salePrice, float listPrice, String description, String briefInformation, int quantities, int Thumbnail, Date lastDateUpdate) {
        this.productID = productID;
        this.title = title;
        this.salePrice = salePrice;
        this.listPrice = listPrice;
        this.description = description;
        this.briefInformation = briefInformation;
        this.quantities = quantities;
        this.Thumbnail = Thumbnail;
        this.lastDateUpdate = lastDateUpdate;
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

    public int getQuantities() {
        return quantities;
    }

    public void setQuantities(int quantities) {
        this.quantities = quantities;
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

    @Override
    public String toString() {
        return "Product{" + "productID=" + productID + ", title=" + title + ", salePrice=" + salePrice + ", listPrice=" + listPrice + ", description=" + description + ", briefInformation=" + briefInformation + ", quantities=" + quantities + ", Thumbnail=" + Thumbnail + ", lastDateUpdate=" + lastDateUpdate + ", formattedPrice=" + formattedPrice + '}';
    }

}
