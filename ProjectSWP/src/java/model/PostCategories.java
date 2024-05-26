/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DELL
 */
public class PostCategories {
    private int mPostCID;
    private int postCL;
    private int postID;

    public PostCategories() {
    }

    public PostCategories(int mPostCID, int postCL, int postID) {
        this.mPostCID = mPostCID;
        this.postCL = postCL;
        this.postID = postID;
    }

    public int getmPostCID() {
        return mPostCID;
    }

    public void setmPostCID(int mPostCID) {
        this.mPostCID = mPostCID;
    }

    public int getPostCL() {
        return postCL;
    }

    public void setPostCL(int postCL) {
        this.postCL = postCL;
    }

    public int getPostID() {
        return postID;
    }

    public void setPostID(int postID) {
        this.postID = postID;
    }

    @Override
    public String toString() {
        return "PostCategories{" + "mPostCID=" + mPostCID + ", postCL=" + postCL + ", postID=" + postID + '}';
    }
    
}
