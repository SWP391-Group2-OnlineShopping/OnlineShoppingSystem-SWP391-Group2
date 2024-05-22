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

    private int postCL;
    private String name;
    private String description;
    private boolean checked;

    //Default constructor
    public PostCategoryList() {
    }

    public PostCategoryList(int postCL, String name, String description, boolean checked) {
        this.postCL = postCL;
        this.name = name;
        this.description = description;
        this.checked = checked;
    }

    //constructor with params
    public PostCategoryList(int PostCL, String Name, String Description) {
        this.postCL = PostCL;
        this.name = Name;
        this.description = Description;
    }

    public int getPostCL() {
        return postCL;
    }

    public void setPostCL(int postCL) {
        this.postCL = postCL;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isChecked() {
        return checked;
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
    }

    @Override
    public String toString() {
        return "" + getName();
    }

}
