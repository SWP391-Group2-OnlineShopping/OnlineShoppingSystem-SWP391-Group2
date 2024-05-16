/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author dumspicy
 */
public class Staff {
    private int StaffId;
    private String Username;
    private String Password;
    private String Email;
    private boolean Gender;
    private String Address;
    private String FullName;
    private boolean Status;
    private String Mobile;
    private Date DOB;
    private int Role;

    public Staff() {
    }

    public Staff(int StaffId, String Username, String Password, String Email, boolean Gender, String Address, String FullName, boolean Status, String Mobile, Date DOB, int Role) {
        this.StaffId = StaffId;
        this.Username = Username;
        this.Password = Password;
        this.Email = Email;
        this.Gender = Gender;
        this.Address = Address;
        this.FullName = FullName;
        this.Status = Status;
        this.Mobile = Mobile;
        this.DOB = DOB;
        this.Role = Role;
    }

    public int getStaffId() {
        return StaffId;
    }

    public void setStaffId(int StaffId) {
        this.StaffId = StaffId;
    }

    public String getUsername() {
        return Username;
    }

    public void setUsername(String Username) {
        this.Username = Username;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public boolean isGender() {
        return Gender;
    }

    public void setGender(boolean Gender) {
        this.Gender = Gender;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }

    public String getFullName() {
        return FullName;
    }

    public void setFullName(String FullName) {
        this.FullName = FullName;
    }

    public boolean isStatus() {
        return Status;
    }

    public void setStatus(boolean Status) {
        this.Status = Status;
    }

    public String getMobile() {
        return Mobile;
    }

    public void setMobile(String Mobile) {
        this.Mobile = Mobile;
    }

    public Date getDOB() {
        return DOB;
    }

    public void setDOB(Date DOB) {
        this.DOB = DOB;
    }

    public int getRole() {
        return Role;
    }

    public void setRole(int Role) {
        this.Role = Role;
    }

    @Override
    public String toString() {
        return "Staff{" + "StaffId=" + StaffId + ", Username=" + Username + ", Password=" + Password + ", Email=" + Email + ", Gender=" + Gender + ", Address=" + Address + ", FullName=" + FullName + ", Status=" + Status + ", Mobile=" + Mobile + ", DOB=" + DOB + ", Role=" + Role + '}';
    }
}
