package model;

public class Sliders {

    private int sliderID;
    private boolean status;
    private String backLink;
    private String title;
    private int staffID;
    private String staff;
    private String imageLink;

    // Default constructor
    public Sliders() {
    }

    // Parameterized constructor

    public Sliders(int sliderID, boolean status, String backLink, String title, int staffID, String staff, String imageLink) {
        this.sliderID = sliderID;
        this.status = status;
        this.backLink = backLink;
        this.title = title;
        this.staffID = staffID;
        this.staff = staff;
        this.imageLink = imageLink;
    }

    public String getStaff() {
        return staff;
    }

    public void setStaff(String staff) {
        this.staff = staff;
    }


    
    // Getter and setter methods
    public int getSliderID() {
        return sliderID;
    }

    public void setSliderID(int sliderID) {
        this.sliderID = sliderID;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getBackLink() {
        return backLink;
    }

    public void setBackLink(String backLink) {
        this.backLink = backLink;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getStaffID() {
        return staffID;
    }

    public void setStaffID(int staffID) {
        this.staffID = staffID;
    }

    // Override toString method
    @Override
    public String toString() {
        return "Sliders{"
                + "sliderID=" + sliderID
                + ", status=" + status
                + ", backLink='" + backLink + '\''
                + ", title='" + title + '\''
                + ", staffID=" + staffID
                + ", imageLink='" + imageLink + '\''
                + '}';
    }

    public String getImageLink() {
        return imageLink;
    }

    public void setImageLink(String imageLink) {
        this.imageLink = imageLink;
    }

}
