/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author DELL
 */
public class Posts {
    private int postId;
    private int staffId;
    private String content;
    private int thumbnail;
    private String title;
    private Date updatedDate;

    
    //create default post constructor
    public Posts() {
        
    }

    //create post constructor with params
    public Posts(int postId, int staffId, String content, int thumbnail, String title, Date updatedDate) {
        this.postId = postId;
        this.staffId = staffId;
        this.content = content;
        this.thumbnail = thumbnail;
        this.title = title;
        this.updatedDate = updatedDate;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
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

    @Override
    public String toString() {
        return "Posts{" + "postId=" + postId + ", staffId=" + staffId + ", content=" + content + ", thumbnail=" + thumbnail + ", title=" + title + ", updatedDate=" + updatedDate + '}';
    }
     
}
