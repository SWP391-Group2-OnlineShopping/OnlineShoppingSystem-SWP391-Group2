/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author LENOVO
 */
public class CustomerInformation {

    private int customerInforID;
    private int customerID;
    private String fullName;
    private String address;
    private String mobile;
    private String email;
    private boolean gender;
    private String avatar;
    private String changeDate;

    public CustomerInformation() {
    }

    public CustomerInformation(int customerInforID, int customerID, String fullName, String address, String mobile, String email, boolean gender, String avatar, String changeDate) {
        this.customerInforID = customerInforID;
        this.customerID = customerID;
        this.fullName = fullName;
        this.address = address;
        this.mobile = mobile;
        this.email = email;
        this.gender = gender;
        this.avatar = avatar;
        this.changeDate = changeDate;
    }

    public int getCustomerInforID() {
        return customerInforID;
    }

    public void setCustomerInforID(int customerInforID) {
        this.customerInforID = customerInforID;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getChangeDate() {
        return changeDate;
    }

    public void setChangeDate(String changeDate) {
        this.changeDate = changeDate;
    }

    @Override
    public String toString() {
        return "CustomerInformation{" + "customerInforID=" + customerInforID + ", customerID=" + customerID + ", fullName=" + fullName + ", address=" + address + ", mobile=" + mobile + ", email=" + email + ", gender=" + gender + ", avatar=" + avatar + ", changeDate=" + changeDate + '}';
    }

}
