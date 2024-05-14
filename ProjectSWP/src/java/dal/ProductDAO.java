/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;

/**
 *
 * @author admin
 */
public class ProductDAO extends DBContext {

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String query = "SELECT p.*, i.Link AS ThumbnailLink "
                + "FROM Product p "
                + "JOIN Images i ON p.Thumbnail = i.ImageID";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query); ResultSet rs = preparedStatement.executeQuery()) {
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setTitle(rs.getString("Title"));
                product.setSalePrice(rs.getFloat("SalePrice"));
                product.setListPrice(rs.getFloat("ListPrice"));
                product.setDescription(rs.getString("Description"));
                product.setBriefInformation(rs.getString("BriefInformation"));
                product.setQuantities(rs.getInt("Quantities"));
                product.setThumbnail(rs.getInt("Thumbnail"));
                product.setLastDateUpdate(rs.getDate("LastDateUpdate"));

                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public Product getProductByID(int productID) {
        Product product = null;
        String query = "SELECT * FROM Product WHERE ProductID = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, productID);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    product = new Product();
                    product.setProductID(rs.getInt("ProductID"));
                    product.setTitle(rs.getString("Title"));
                    product.setSalePrice(rs.getFloat("SalePrice"));
                    product.setListPrice(rs.getFloat("ListPrice"));
                    product.setDescription(rs.getString("Description"));
                    product.setBriefInformation(rs.getString("BriefInformation"));
                    product.setQuantities(rs.getInt("Quantities"));
                    product.setThumbnail(rs.getInt("Thumbnail"));
                    product.setLastDateUpdate(rs.getDate("LastDateUpdate"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    public static void main(String[] args) {
        ProductDAO d = new ProductDAO();
        System.out.println(d.getAllProducts());
    }

}
