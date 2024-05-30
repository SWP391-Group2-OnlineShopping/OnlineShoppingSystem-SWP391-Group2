/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package dal;

import model.ProductCategoryList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author admin
 */
public class CategoriesDAO extends DBContext{

     public List<ProductCategoryList> getAllCategories() {
        List<ProductCategoryList> categories = new ArrayList<>();
        String query = "SELECT ProductCL AS id, Name AS name FROM Product_Category_List";
        
        try (PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                ProductCategoryList category = new ProductCategoryList();
                category.setProductCL(rs.getInt("id"));
                category.setName(rs.getString("name"));
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return categories;
    }
    public static void main(String[] args) {
        CategoriesDAO d = new CategoriesDAO();
        System.out.println(d.getAllCategories());
    }
}
