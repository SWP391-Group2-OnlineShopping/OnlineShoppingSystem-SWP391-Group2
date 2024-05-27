/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
<<<<<<< HEAD
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package dal;

import java.sql.Statement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Products;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Images;
import model.ProductCS;
import model.ProductCategories;
import model.ProductCategoryList;
import model.Products;

/**
 *
 * @author admin
 */
public class ProductDAO extends DBContext {

    public List<Products> getProducts() {
        List<Products> products = new ArrayList<>();
        String query = "SELECT p.*, i.Link AS ThumbnailLink FROM Products p JOIN Images i ON p.Thumbnail = i.ImageID";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Products product = new Products();
                    product.setProductID(rs.getInt("ProductID"));
                    product.setTitle(rs.getString("Title"));
                    product.setSalePrice(rs.getFloat("SalePrice"));
                    product.setListPrice(rs.getFloat("ListPrice"));
                    product.setDescription(rs.getString("Description"));
                    product.setBriefInformation(rs.getString("BriefInformation"));
                    product.setThumbnail(rs.getInt("Thumbnail"));
                    product.setLastDateUpdate(rs.getDate("LastDateUpdate"));
                    product.setThumbnailLink(rs.getString("ThumbnailLink"));

                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Products> getProducts(int limit, int offset) {
        List<Products> products = new ArrayList<>();
        String query = "SELECT p.*, i.Link AS ThumbnailLink FROM Products p JOIN Images i ON p.Thumbnail = i.ImageID LIMIT ? OFFSET ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, limit);
            preparedStatement.setInt(2, offset);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Products product = new Products();
                    product.setProductID(rs.getInt("ProductID"));
                    product.setTitle(rs.getString("Title"));
                    product.setSalePrice(rs.getFloat("SalePrice"));
                    product.setListPrice(rs.getFloat("ListPrice"));
                    product.setDescription(rs.getString("Description"));
                    product.setBriefInformation(rs.getString("BriefInformation"));
                    product.setThumbnail(rs.getInt("Thumbnail"));
                    product.setLastDateUpdate(rs.getDate("LastDateUpdate"));
                    product.setThumbnailLink(rs.getString("ThumbnailLink"));

                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public Products getProductByID(int productID) {
        Products product = null;
        String query = "SELECT p.*, i.Link AS ThumbnailLink FROM Products p JOIN Images i ON p.Thumbnail = i.ImageID WHERE p.ProductID = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, productID);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    product = new Products();
                    product.setProductID(rs.getInt("ProductID"));
                    product.setTitle(rs.getString("Title"));
                    product.setSalePrice(rs.getFloat("SalePrice"));
                    product.setListPrice(rs.getFloat("ListPrice"));
                    product.setDescription(rs.getString("Description"));
                    product.setBriefInformation(rs.getString("BriefInformation"));
                    product.setThumbnail(rs.getInt("Thumbnail"));
                    product.setThumbnailLink(rs.getString("ThumbnailLink"));
                    product.setLastDateUpdate(rs.getDate("LastDateUpdate"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    public List<Products> getProductsByCategories(String[] categoryIds) {
        List<Products> products = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT p.*, i.Link AS ThumbnailLink FROM Products p JOIN Images i ON p.Thumbnail = i.ImageID JOIN Product_Categories pc ON p.ProductID = pc.ProductID WHERE pc.ProductCL IN (");
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
                    Products product = new Products();
                    product.setProductID(rs.getInt("ProductID"));
                    product.setTitle(rs.getString("Title"));
                    product.setSalePrice(rs.getFloat("SalePrice"));
                    product.setListPrice(rs.getFloat("ListPrice"));
                    product.setDescription(rs.getString("Description"));
                    product.setBriefInformation(rs.getString("BriefInformation"));
                    product.setThumbnail(rs.getInt("Thumbnail"));
                    product.setThumbnailLink(rs.getString("ThumbnailLink"));
                    product.setLastDateUpdate(rs.getDate("LastDateUpdate"));
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Products> getProductsByPriceRange(float minPrice, float maxPrice) {
        List<Products> products = new ArrayList<>();
        String query = "SELECT p.*, i.Link AS ThumbnailLink FROM Products p JOIN Images i ON p.Thumbnail = i.ImageID WHERE p.SalePrice BETWEEN ? AND ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setFloat(1, minPrice);
            preparedStatement.setFloat(2, maxPrice);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Products product = new Products();
                    product.setProductID(rs.getInt("ProductID"));
                    product.setTitle(rs.getString("Title"));
                    product.setSalePrice(rs.getFloat("SalePrice"));
                    product.setListPrice(rs.getFloat("ListPrice"));
                    product.setDescription(rs.getString("Description"));
                    product.setBriefInformation(rs.getString("BriefInformation"));
                    product.setThumbnail(rs.getInt("Thumbnail"));
                    product.setThumbnailLink(rs.getString("ThumbnailLink")); // Lấy đường dẫn hình ảnh
                    product.setLastDateUpdate(rs.getDate("LastDateUpdate"));
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Products> getProductsByCategoriesAndPrice(String[] categoryIds, float minPrice, float maxPrice) {

        List<Products> products = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT p.*, i.Link AS ThumbnailLink FROM Products p JOIN Images i ON p.Thumbnail = i.ImageID JOIN Product_Categories pc ON p.ProductID = pc.ProductID WHERE pc.ProductCL IN (");
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
                    Products product = new Products();
                    product.setProductID(rs.getInt("ProductID"));
                    product.setTitle(rs.getString("Title"));
                    product.setSalePrice(rs.getFloat("SalePrice"));
                    product.setListPrice(rs.getFloat("ListPrice"));
                    product.setDescription(rs.getString("Description"));
                    product.setBriefInformation(rs.getString("BriefInformation"));
                    product.setThumbnail(rs.getInt("Thumbnail"));
                    product.setThumbnailLink(rs.getString("ThumbnailLink")); // Lấy đường dẫn hình ảnh
                    product.setLastDateUpdate(rs.getDate("LastDateUpdate"));
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Products> getProductsBySearchKeyword(List<Products> products, String keyword) {
        keyword = keyword.toLowerCase();
        List<Products> filteredProducts = new ArrayList<>();
        for (Products product : products) {
            if (product.getTitle().toLowerCase().contains(keyword)
                    || product.getDescription().toLowerCase().contains(keyword)) {
                filteredProducts.add(product);
            }
        }
        return filteredProducts;
    }

    public List<ProductCS> getProductSize(int id) {
        List<ProductCS> sizes = new ArrayList<>();
        try {
            String sql = "SELECT pcs.Size FROM Products p JOIN Product_CS pcs ON p.ProductID = pcs.ProductID WHERE p.ProductID = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductCS pcs = new ProductCS();
                pcs.setSize(rs.getInt(1));
                sizes.add(pcs);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return sizes;
    }

    public List<Products> getLastestProducts() {
        List<Products> list = new ArrayList<>();
        try {
            String sql = "SELECT TOP 4 p.*, i.Link AS ThumbnailLink FROM Products p JOIN Images i ON p.Thumbnail = i.ImageID ORDER BY p.ProductID DESC";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setProductID(rs.getInt("ProductID"));
                p.setTitle(rs.getString("Title"));
                p.setSalePrice(rs.getFloat("SalePrice"));
                p.setListPrice(rs.getFloat("ListPrice"));
                p.setDescription(rs.getString("Description"));
                p.setBriefInformation(rs.getString("BriefInformation"));
                p.setThumbnail(rs.getInt("Thumbnail"));
                p.setLastDateUpdate(rs.getDate("LastDateUpdate"));
                p.setThumbnailLink(rs.getString("ThumbnailLink"));
                list.add(p);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public ProductCategoryList getProductCategory(int id) {
        ProductCategoryList pc = new ProductCategoryList();
        try {
            String sql = "SELECT pcl.Name AS CategoryName, pcl.Description AS CategoryDescription FROM Products p JOIN Product_Categories pc ON p.ProductID = pc.ProductID JOIN Product_Category_List pcl ON pc.ProductCL = pcl.ProductCL WHERE p.ProductID = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                pc.setName(rs.getString(1));
                pc.setDescription(rs.getString(2));
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return pc;
    }

    public List<Products> getProductByCategoryID(int id) {
        List<Products> list = new ArrayList<>();
        try {
            String sql = "SELECT p.*, i.Link AS ThumbnailLink \n"
                    + "FROM Products p\n"
                    + "INNER JOIN Product_Categories pc ON p.ProductID = pc.ProductID\n"
                    + "INNER JOIN Product_Category_List pcl ON pc.ProductCL = pcl.ProductCL\n"
                    + "INNER JOIN Images i ON p.Thumbnail = i.ImageID\n"
                    + "WHERE pcl.ProductCL = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setProductID(rs.getInt("ProductID"));
                p.setTitle(rs.getString("Title"));
                p.setSalePrice(rs.getFloat("SalePrice"));
                p.setListPrice(rs.getFloat("ListPrice"));
                p.setDescription(rs.getString("Description"));
                p.setBriefInformation(rs.getString("BriefInformation"));
                p.setThumbnail(rs.getInt("Thumbnail"));
                p.setThumbnailLink(rs.getString("ThumbnailLink"));
                p.setLastDateUpdate(rs.getDate("LastDateUpdate"));
                list.add(p);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }
 public List<Products> getProductsManager() {
        List<Products> products = new ArrayList<>();
        String query = "SELECT p.ProductID, p.Title, p.SalePrice, p.ListPrice, p.Description, p.BriefInformation, i.Link AS Thumbnail, "
                     + "c.Name as Category, pcs.Size "
                     + "FROM Products p "
                     + "JOIN Product_Categories pc ON p.ProductID = pc.ProductID "
                     + "JOIN Product_Category_List c ON pc.ProductCL = c.ProductCL "
                     + "JOIN Product_CS pcs ON p.ProductID = pcs.ProductID "
                     + "JOIN Images i ON p.Thumbnail = i.ImageID";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Products product = new Products();
                    product.setProductID(rs.getInt("ProductID"));
                    product.setTitle(rs.getString("Title"));
                    product.setSalePrice(rs.getFloat("SalePrice"));
                    product.setListPrice(rs.getFloat("ListPrice"));
                    product.setDescription(rs.getString("Description"));
                    product.setBriefInformation(rs.getString("BriefInformation"));
                    product.setThumbnailLink(rs.getString("Thumbnail"));
                    product.setCategory(rs.getString("Category"));
                    product.setSize(rs.getInt("Size")); 
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
     

    public static void main(String[] args) {
        ProductDAO d = new ProductDAO();
//        System.out.print(d.getProductByID(1));
//        ProductCategoryList pc = d.getProductCategory(1);
//        System.out.println(pc);
//        
//        List<Products> listProduct = d.getProductByCategoryID(1);
//        for(Products p : listProduct){
//            System.out.println(p);
//        }
System.out.println(d.getProductsManager());
    }
}
