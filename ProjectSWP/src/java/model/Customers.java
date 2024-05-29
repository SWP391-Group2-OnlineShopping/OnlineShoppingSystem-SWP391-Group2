/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author LENOVO
 */
public class Customers {

    private int customer_id;
    private String user_name;
    private String pass_word;
    private String email;
    private boolean gender;
    private String address;
    private String full_name;
    private boolean status;
    private String phone_number;
    private String avatar;
    private Date dob;

    public Customers() {
    }

    public Customers(int customer_id, String user_name, String pass_word, String email, boolean gender, String address, String full_name, boolean status, String phone_number, String avatar, Date dob) {
        this.customer_id = customer_id;
        this.user_name = user_name;
        this.pass_word = pass_word;
        this.email = email;
        this.gender = gender;
        this.address = address;
        this.full_name = full_name;
        this.status = status;
        this.phone_number = phone_number;
        this.avatar = avatar;
        this.dob = dob;
    }
    

    public Customers(int customer_id, String user_name, String pass_word, String email, boolean gender, String address, String full_name, boolean status, String phone_number, Date dob) {
        this.customer_id = customer_id;
        this.user_name = user_name;
        this.pass_word = pass_word;
        this.email = email;
        this.gender = gender;
        this.address = address;
        this.full_name = full_name;
        this.status = status;
        this.phone_number = phone_number;
        this.dob = dob;
    }

    public Customers(int customer_id, String user_name, String pass_word, String email, boolean gender, String address, String full_name, String phone_number, Date dob) {
        this.customer_id = customer_id;
        this.user_name = user_name;
        this.pass_word = pass_word;
        this.email = email;
        this.gender = gender;
        this.address = address;
        this.full_name = full_name;
        this.phone_number = phone_number;
        this.dob = dob;
    }
    
    public Customers(String full_name, String address, String email, String phone_number, boolean gender){
        this.full_name = full_name;
        this.address = address;
        this.email = email;
        this.phone_number = phone_number;
        this.gender = gender;
    }

    public Customers(String email) {
        this.email = email;
    }
     public Customers(String user_name, String pass_word) {
        this.user_name = user_name;
        this.pass_word = pass_word;
        
    }

    public int getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getPass_word() {
        return pass_word;
    }

    public void setPass_word(String pass_word) {
        this.pass_word = pass_word;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean getGender() {
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

    public String getFull_name() {
        return full_name;
    }

    public void setFull_name(String full_name) {
        this.full_name = full_name;
    }

    public boolean getStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    
    @Override
    public String toString() {
        return "Customers{" + "customer_id=" + customer_id + ", user_name=" + user_name + ", pass_word=" + pass_word + ", email=" + email + ", gender=" + gender + ", address=" + address + ", full_name=" + full_name + ", status=" + status + ", phone_number=" + phone_number + ", dob=" + dob + '}';
    }


}
