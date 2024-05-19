/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;
import java.util.Date;

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
    private String Staff;
    private String thumbnailLink;
    private ArrayList categories;
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
    public Posts(int postID, String content, String title, Date updatedDate, String Staff, String thumbnailLink, ArrayList categories) {
        this.postID = postID;
        this.content = content;
        this.title = title;
        this.updatedDate = updatedDate;
        this.Staff = Staff;
        this.thumbnailLink = thumbnailLink;
        this.categories = categories;
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

    public String getStaff() {
        return Staff;
    }

    public void setStaff(String Staff) {
        this.Staff = Staff;
    }

    public String getThumbnailLink() {
        return thumbnailLink;
    }

    public void setThumbnailLink(String thumbnailLink) {
        this.thumbnailLink = thumbnailLink;
    }

    public ArrayList getCategories() {
        return categories;
    }

    public void setCategories(ArrayList categories) {
        this.categories = categories;
    }

    @Override
    public String toString() {
        return "Posts{" + "postID=" + postID + ", content=" + content + ", title=" + title + ", updatedDate=" + updatedDate + ", Staff=" + Staff + ", thumbnailLink=" + thumbnailLink + ", categories=" + categories + '}';
    }

    

    

}
