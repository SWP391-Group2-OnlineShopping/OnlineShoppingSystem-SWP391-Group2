/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author DELL
 */
public class Posts {

    private int postID;
    private int staffID;
    private String content;
    private int thumbnail;
    private String title;
    private Date updatedDate;
    private String staff;
    private String thumbnailLink;
    private List<PostCategoryList> categories;
    private boolean status;
    private boolean feature;
    private int productID;
    //create default post constructor
    public Posts() {

    }

    //create post constructor SQL Params
    public Posts(int postID, int staffID, String content, int thumbnail, String title, Date updatedDate) {
        this.postID = postID;
        this.staffID = staffID;
        this.content = content;
        this.thumbnail = thumbnail;
        this.title = title;
        this.updatedDate = updatedDate;
    }

    
    //create post constructor for displaying purpose
    public Posts(int postID, String content, String title, Date updatedDate, String Staff, String thumbnailLink, List<PostCategoryList> categories,boolean status) {
        this.postID = postID;
        this.content = content;
        this.title = title;
        this.updatedDate = updatedDate;
        this.staff = Staff;
        this.thumbnailLink = thumbnailLink;
        this.categories = categories;
        this.status = status;
    }
    public Posts(int postID, String content, String title, Date updatedDate, String Staff, String thumbnailLink, List<PostCategoryList> categories,boolean status,boolean feature) {
        this.postID = postID;
        this.content = content;
        this.title = title;
        this.updatedDate = updatedDate;
        this.staff = Staff;
        this.thumbnailLink = thumbnailLink;
        this.categories = categories;
        this.status = status;
        this.feature = feature;
    }
    

    public int getPostID() {
        return postID;
    }

    public void setPostID(int postID) {
        this.postID = postID;
    }

    public int getStaffID() {
        return staffID;
    }

    public void setStaffID(int staffID) {
        this.staffID = staffID;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(int thumbnail) {
        this.thumbnail = thumbnail;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }


    public String getThumbnailLink() {
        return thumbnailLink;
    }

    public void setThumbnailLink(String thumbnailLink) {
        this.thumbnailLink = thumbnailLink;
    }

    public List<PostCategoryList> getCategories() {
        return categories;
    }

    public void setCategories(List<PostCategoryList> categories) {
        this.categories = categories;
    }

    public String getStaff() {
        return staff;
    }

    public void setStaff(String staff) {
        this.staff = staff;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public boolean isFeature() {
        return feature;
    }

    public void setFeature(boolean feature) {
        this.feature = feature;
    }

    @Override
    public String toString() {
        return "Posts{" + "postID=" + postID + ", content=" + content + ", title=" + title + ", updatedDate=" + updatedDate + ", Staff=" + staff + ", thumbnailLink=" + thumbnailLink + ", categories=" + categories.toString() + '}';
    }

    

    

}
