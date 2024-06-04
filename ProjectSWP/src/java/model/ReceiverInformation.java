/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author LENOVO
 */
public class ReceiverInformation {

    private int receiverInforID;
    private int customerID;
    private String receiverFullName;
    private String phoneNumber;
    private String address;
    private boolean addressType;//true(1) is priority false(0) is none priority

    public ReceiverInformation() {
    }

    public ReceiverInformation(int receiverInforID, int customerID, String receiverFullName, String phoneNumber, String address, boolean addressType) {
        this.receiverInforID = receiverInforID;
        this.customerID = customerID;
        this.receiverFullName = receiverFullName;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.addressType = addressType;
    }

    public int getReceiverInforID() {
        return receiverInforID;
    }

    public void setReceiverInforID(int receiverInforID) {
        this.receiverInforID = receiverInforID;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public String getReceiverFullName() {
        return receiverFullName;
    }

    public void setReceiverFullName(String receiverFullName) {
        this.receiverFullName = receiverFullName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public boolean isAddressType() {
        return addressType;
    }

    public void setAddressType(boolean addressType) {
        this.addressType = addressType;
    }

    @Override
    public String toString() {
        return "ReceiverInformation{" + "receiverInforID=" + receiverInforID + ", customerID=" + customerID + ", receiverFullName=" + receiverFullName + ", phoneNumber=" + phoneNumber + ", address=" + address + ", addressType=" + addressType + '}';
    }

}
