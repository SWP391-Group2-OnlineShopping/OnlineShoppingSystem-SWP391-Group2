/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package dal;

import java.util.List;

/**
 *
 * @author admin
 */
public class CategoriesDAO extends DBContext{

     public List<ProductCategoryList> getAllCategories() {
        List<ProductCategoryList> categories = new ArrayList<>();
        String query = "SELECT * FROM Product_Category_List";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                ProductCategoryList category = new ProductCategoryList();
                category.setProductCL(resultSet.getInt("ProductCL"));
                category.setName(resultSet.getString("Name"));
                category.setDescription(resultSet.getString("Description"));
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }
   
}
