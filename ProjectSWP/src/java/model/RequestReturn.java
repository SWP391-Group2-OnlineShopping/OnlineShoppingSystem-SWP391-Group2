/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author LENOVO
 */
public class RequestReturn {

    private int requestID;
    private int orderID;
    private int customerID;
    private String reason;
    private String phoneNumber;
    private String bankAccount;
    private Date date;
    private boolean isAccecpt;
    private String receiverFullName;
    private ArrayList<String> imageLinks;

    public RequestReturn() {
    }

    public RequestReturn(int requestID, int orderID, int customerID, String reason, String phoneNumber, String bankAccount, Date date, boolean isAccecpt, String receiverFullName, ArrayList<String> imageLinks) {
        this.requestID = requestID;
        this.orderID = orderID;
        this.customerID = customerID;
        this.reason = reason;
        this.phoneNumber = phoneNumber;
        this.bankAccount = bankAccount;
        this.date = date;
        this.isAccecpt = isAccecpt;
        this.receiverFullName = receiverFullName;
        this.imageLinks = imageLinks;
    }

    public int getRequestID() {
        return requestID;
    }

    public void setRequestID(int requestID) {
        this.requestID = requestID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getBankAccount() {
        return bankAccount;
    }

    public void setBankAccount(String bankAccount) {
        this.bankAccount = bankAccount;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public boolean isIsAccecpt() {
        return isAccecpt;
    }

    public void setIsAccecpt(boolean isAccecpt) {
        this.isAccecpt = isAccecpt;
    }

    public String getReceiverFullName() {
        return receiverFullName;
    }

    public void setReceiverFullName(String receiverFullName) {
        this.receiverFullName = receiverFullName;
    }

    public ArrayList<String> getImageLinks() {
        return imageLinks;
    }

    public void setImageLinks(ArrayList<String> imageLinks) {
        this.imageLinks = imageLinks;
    }

    @Override
    public String toString() {
        return "RequestReturn{" + "requestID=" + requestID + ", orderID=" + orderID + ", customerID=" + customerID + ", reason=" + reason + ", phoneNumber=" + phoneNumber + ", bankAccount=" + bankAccount + ", date=" + date + ", isAccecpt=" + isAccecpt + ", receiverFullName=" + receiverFullName + ", imageLinks=" + imageLinks + '}';
    }

}
