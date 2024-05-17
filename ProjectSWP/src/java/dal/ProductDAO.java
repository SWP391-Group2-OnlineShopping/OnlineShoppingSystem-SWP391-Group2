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
import model.Image;
import model.Product;

/**
 *
 * @author admin
 */
public class ProductDAO extends DBContext {

    public List<Product> getProducts(int limit, int offset) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT p.*, i.Link AS ThumbnailLink FROM Product p JOIN Images i ON p.Thumbnail = i.ImageID LIMIT ? OFFSET ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, limit);
            preparedStatement.setInt(2, offset);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setProductID(rs.getInt("ProductID"));
                    product.setTitle(rs.getString("Title"));
                    product.setSalePrice(rs.getFloat("SalePrice"));
                    product.setListPrice(rs.getFloat("ListPrice"));
                    product.setDescription(rs.getString("Description"));
                    product.setBriefInformation(rs.getString("BriefInformation"));
                    product.setThumbnail(rs.getInt("Thumbnail"));
                    product.setLastDateUpdate(rs.getDate("LastDateUpdate"));

                    products.add(product);
                }
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
                    product.setThumbnail(rs.getInt("Thumbnail"));
                    product.setLastDateUpdate(rs.getDate("LastDateUpdate"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    public List<Product> getProductsByCategories(String[] categoryIds) {
        List<Product> products = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT p.*, i.Link AS ThumbnailLink FROM Product p JOIN Images i ON p.Thumbnail = i.ImageID JOIN Product_Categories pc ON p.ProductID = pc.ProductID WHERE pc.ProductCL IN (");
        for (int i = 0; i < categoryIds.length; i++) {
            query.append("?");
            if (i < categoryIds.length - 1) {
                query.append(",");
            }
        }
        query.append(")");

        try (PreparedStatement preparedStatement = connection.prepareStatement(query.toString())) {
            for (int i = 0; i < categoryIds.length; i++) {
                preparedStatement.setString(i + 1, categoryIds[i]);
            }
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setProductID(rs.getInt("ProductID"));
                    product.setTitle(rs.getString("Title"));
                    product.setSalePrice(rs.getFloat("SalePrice"));
                    product.setListPrice(rs.getFloat("ListPrice"));
                    product.setDescription(rs.getString("Description"));
                    product.setBriefInformation(rs.getString("BriefInformation"));

                    Image thumbnailImage = new Image();
                    thumbnailImage.setImageID(rs.getInt("Thumbnail"));
                    thumbnailImage.setLink(rs.getString("ThumbnailLink"));

                    product.setLastDateUpdate(rs.getDate("LastDateUpdate"));
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> getProductsByPriceRange(float minPrice, float maxPrice) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT p.*, i.Link AS ThumbnailLink FROM Product p JOIN Images i ON p.Thumbnail = i.ImageID WHERE p.SalePrice BETWEEN ? AND ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setFloat(1, minPrice);
            preparedStatement.setFloat(2, maxPrice);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setProductID(rs.getInt("ProductID"));
                    product.setTitle(rs.getString("Title"));
                    product.setSalePrice(rs.getFloat("SalePrice"));
                    product.setListPrice(rs.getFloat("ListPrice"));
                    product.setDescription(rs.getString("Description"));
                    product.setBriefInformation(rs.getString("BriefInformation"));

                    Image thumbnailImage = new Image();
                    thumbnailImage.setImageID(rs.getInt("Thumbnail"));
                    thumbnailImage.setLink(rs.getString("ThumbnailLink"));

                    product.setLastDateUpdate(rs.getDate("LastDateUpdate"));
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> getProductsByCategoriesAndPrice(String[] categoryIds, float minPrice, float maxPrice) {
        List<Product> products = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT p.*, i.Link AS ThumbnailLink FROM Product p JOIN Images i ON p.Thumbnail = i.ImageID JOIN Product_Categories pc ON p.ProductID = pc.ProductID WHERE pc.ProductCL IN (");
        for (int i = 0; i < categoryIds.length; i++) {
            query.append("?");
            if (i < categoryIds.length - 1) {
                query.append(",");
            }
        }
        query.append(") AND p.SalePrice BETWEEN ? AND ?");

        try (PreparedStatement preparedStatement = connection.prepareStatement(query.toString())) {
            for (int i = 0; i < categoryIds.length; i++) {
                preparedStatement.setString(i + 1, categoryIds[i]);
            }
            preparedStatement.setFloat(categoryIds.length + 1, minPrice);
            preparedStatement.setFloat(categoryIds.length + 2, maxPrice);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setProductID(rs.getInt("ProductID"));
                    product.setTitle(rs.getString("Title"));
                    product.setSalePrice(rs.getFloat("SalePrice"));
                    product.setListPrice(rs.getFloat("ListPrice"));
                    product.setDescription(rs.getString("Description"));
                    product.setBriefInformation(rs.getString("BriefInformation"));

                    Image thumbnailImage = new Image();
                    thumbnailImage.setImageID(rs.getInt("Thumbnail"));
                    thumbnailImage.setLink(rs.getString("ThumbnailLink"));

                    product.setLastDateUpdate(rs.getDate("LastDateUpdate"));
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> getProductsBySearchKeyword(List<Product> products, String keyword) {
        keyword = keyword.toLowerCase();
        List<Product> filteredProducts = new ArrayList<>();
        for (Product product : products) {
            if (product.getTitle().toLowerCase().contains(keyword)
                    || product.getDescription().toLowerCase().contains(keyword)) {
                filteredProducts.add(product);
            }
        }
        return filteredProducts;
    }

}
