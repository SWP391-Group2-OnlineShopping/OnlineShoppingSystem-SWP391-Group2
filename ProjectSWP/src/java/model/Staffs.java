package model;

import java.io.Serializable;
import java.util.Date;

public class Staffs implements Serializable {
    private static final long serialVersionUID = 1L;

    private int staffID;
    private String username;
    private String password;
    private String email;
    private boolean gender;
    private String address;
    private String fullName;
    private boolean status;
    private String mobile;
    private Date dob;
    private int role; // 1 is Admin, 2 is Sale Manager, 3 is Sale, 4 is Marketer

    // Default constructor
    public Staffs() {
    }

    // Constructor with parameters
    public Staffs(int staffID, String username, String password, String email, boolean gender, String address, String fullName, boolean status, String mobile, Date dob, int role) {
        this.staffID = staffID;
        this.username = username;
        this.password = password;
        this.email = email;
        this.gender = gender;
        this.address = address;
        this.fullName = fullName;
        this.status = status;
        this.mobile = mobile;
        this.dob = dob;
        this.role = role;
    }

    // Getters and Setters
    public int getStaffID() {
        return staffID;
    }

    public void setStaffID(int staffID) {
        this.staffID = staffID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "Staff{" +
                "staffID=" + staffID +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", gender=" + gender +
                ", address='" + address + '\'' +
                ", fullName='" + fullName + '\'' +
                ", status=" + status +
                ", mobile='" + mobile + '\'' +
                ", dob=" + dob +
                ", role=" + role +
                '}';
    }
}