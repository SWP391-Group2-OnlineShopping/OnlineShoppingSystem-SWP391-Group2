/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.*;

/**
 *
 * @author dumspicy
 */
public class Voucher {

    private int id;
    private String name;
    private int percent;
    private float requirement;
    private String description;
    private boolean status;
    private Date createdDate;
    private Date usedDate;
    private Date expiredDate;

    public Voucher() {
    }

    public Voucher(int id, String name, int percent, float requirement, String description, boolean status, Date createdDate, Date usedDate, Date expiredDate) {
        this.id = id;
        this.name = name;
        this.percent = percent;
        this.requirement = requirement;
        this.description = description;
        this.status = status;
        this.createdDate = createdDate;
        this.usedDate = usedDate;
        this.expiredDate = expiredDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPercent() {
        return percent;
    }

    public void setPercent(int percent) {
        this.percent = percent;
    }

    public float getRequirement() {
        return requirement;
    }

    public void setRequirement(float requirement) {
        this.requirement = requirement;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getUsedDate() {
        return usedDate;
    }

    public void setUsedDate(Date usedDate) {
        this.usedDate = usedDate;
    }

    public Date getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(Date expiredDate) {
        this.expiredDate = expiredDate;
    }

    @Override
    public String toString() {
        return "Voucher{" + "id=" + id + ", name=" + name + ", percent=" + percent + ", requirement=" + requirement + ", description=" + description + ", status=" + status + ", createdDate=" + createdDate + ", usedDate=" + usedDate + ", expiredDate=" + expiredDate + '}';
    }

    
}
