/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DELL
 */
public class PostCategoryList {
    private int PostCL;
    private String Name;
    private String Description;
    
    //Default constructor
    public PostCategoryList() {
    }
    //constructor with params
    public PostCategoryList(int PostCL, String Name, String Description) {
        this.PostCL = PostCL;
        this.Name = Name;
        this.Description = Description;
    }

    public int getPostCL() {
        return PostCL;
    }

    public void setPostCL(int PostCL) {
        this.PostCL = PostCL;
    }

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    @Override
    public String toString() {
        return ""+getName();
    }
    
}
