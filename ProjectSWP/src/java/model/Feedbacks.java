package model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Feedbacks {
    private int feedbackID;
    private int productID;
    private int customerID;
    private String content;
    private boolean status;
    private float ratedStar;
    private String productTitle; // Title of the product from the Products table
    private String customerFullname; // Fullname of the customer from the Customers table
    private ArrayList<String> imageLinks; // List of image links
    private Date date;
    private int daySinceFeedback; //number of day after feedback
    private ArrayList<Images> images;

    

    // Getters and Setters
    
    
    public void setImages(ArrayList<Images> images) {
        this.images = images;
    }

    public ArrayList<Images> getImages() {
        return images;
    }

    public int getFeedbackID() {
        return feedbackID;
    }

    public void setFeedbackID(int feedbackID) {
        this.feedbackID = feedbackID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public float getRatedStar() {
        return ratedStar;
    }

    public void setRatedStar(float ratedStar) {
        this.ratedStar = ratedStar;
    }

    public String getProductTitle() {
        return productTitle;
    }

    public void setProductTitle(String productTitle) {
        this.productTitle = productTitle;
    }

    public String getCustomerFullname() {
        return customerFullname;
    }

    public void setCustomerFullname(String customerFullname) {
        this.customerFullname = customerFullname;
    }

    public ArrayList<String> getImageLinks() {
        return imageLinks;
    }

    public void setImageLinks(ArrayList<String> imageLinks) {
        this.imageLinks = imageLinks;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getDaySinceFeedback() {
        return daySinceFeedback;
    }

    public void setDaySinceFeedback(int daySinceFeedback) {
        this.daySinceFeedback = daySinceFeedback;
    }
    
    @Override
    public String toString() {
        return "Feedbacks{, date= " + date + "daySinceFeedback=" + daySinceFeedback + '}';
    }
    
    
}
