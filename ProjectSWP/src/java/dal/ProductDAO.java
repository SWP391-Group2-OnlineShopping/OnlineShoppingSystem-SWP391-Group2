/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
<<<<<<< HEAD
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package dal;

import Format.CurrencyFormatter;
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
                + "c.Name as Category, STRING_AGG(CONCAT(pcs.Quantities, ' (', pcs.Size, ')'), ', ') WITHIN GROUP (ORDER BY pcs.Size) as QuantitiesSizes, "
                + "STRING_AGG(CONVERT(varchar, pcs.Size), ', ') WITHIN GROUP (ORDER BY pcs.Size) as Size, "
                + "p.[Status], p.Feature "
                + "FROM Products p "
                + "JOIN Product_Categories pc ON p.ProductID = pc.ProductID "
                + "JOIN Product_Category_List c ON pc.ProductCL = c.ProductCL "
                + "JOIN Product_CS pcs ON p.ProductID = pcs.ProductID "
                + "JOIN Images i ON p.Thumbnail = i.ImageID "
                + "GROUP BY p.ProductID, p.Title, p.SalePrice, p.ListPrice, p.Description, p.BriefInformation, i.Link, c.Name, p.[Status], p.Feature";
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
                    product.setSize(rs.getString("Size")); // Set the concatenated sizes
                    product.setQuantitiesSizes(rs.getString("QuantitiesSizes")); // Set the concatenated quantities and sizes
                    product.setStatus(rs.getBoolean("Status"));
                    product.setFeature(rs.getBoolean("Feature"));
                    product.setFormattedPrice(CurrencyFormatter.formatCurrency(product.getSalePrice()));
                    product.setFormattedListPrice(CurrencyFormatter.formatCurrency(product.getListPrice()));
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

   public boolean updateProductStatus(int productId, boolean status) {
    String query = "UPDATE Products SET status = ? WHERE productID = ?";
    try (PreparedStatement stmt = connection.prepareStatement(query)) {
        stmt.setBoolean(1, status);
        stmt.setInt(2, productId);
        int rowsUpdated = stmt.executeUpdate();
        return rowsUpdated > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

    public int addImage(String link) {
        String query = "INSERT INTO Images (Link) VALUES (?)";
        int imageId = -1;

        try (PreparedStatement stmt = connection.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, link);
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        imageId = generatedKeys.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return imageId;
    }

    public boolean addProduct(Products product, ProductCS productCS, List<ProductCategories> productCategoriesList) {
        String productQuery = "INSERT INTO Products (Title, SalePrice, ListPrice, Description, BriefInformation, Thumbnail, LastDateUpdate, Status, Feature) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String productCSQuery = "INSERT INTO Product_CS (Size, Quantities, ProductID) VALUES (?, ?, ?)";
        String productCategoryQuery = "INSERT INTO Product_Categories (ProductCL, ProductID) VALUES (?, ?)";
        boolean success = false;

        try {
            connection.setAutoCommit(false);

            // Insert into Products
            try (PreparedStatement productStmt = connection.prepareStatement(productQuery, PreparedStatement.RETURN_GENERATED_KEYS)) {
                productStmt.setString(1, product.getTitle());
                productStmt.setFloat(2, product.getSalePrice());
                productStmt.setFloat(3, product.getListPrice());
                productStmt.setString(4, product.getDescription());
                productStmt.setString(5, product.getBriefInformation());
                productStmt.setInt(6, product.getThumbnail());
                productStmt.setDate(7, new java.sql.Date(System.currentTimeMillis()));
                productStmt.setBoolean(8, product.isStatus());
                productStmt.setBoolean(9, product.isFeature());
                int rowsAffected = productStmt.executeUpdate();

                if (rowsAffected > 0) {
                    try (ResultSet generatedKeys = productStmt.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            int productId = generatedKeys.getInt(1);
                            product.setProductID(productId);

                            // Insert into Product_CS
                            try (PreparedStatement productCSStmt = connection.prepareStatement(productCSQuery)) {
                                productCSStmt.setInt(1, productCS.getSize());
                                productCSStmt.setInt(2, productCS.getQuantities());
                                productCSStmt.setInt(3, productId);
                                productCSStmt.executeUpdate();
                            }

                            // Insert into Product_Categories
                            try (PreparedStatement productCategoryStmt = connection.prepareStatement(productCategoryQuery)) {
                                for (ProductCategories productCategory : productCategoriesList) {
                                    productCategoryStmt.setInt(1, productCategory.getProductCL().getProductCL());
                                    productCategoryStmt.setInt(2, productId);
                                    productCategoryStmt.addBatch();
                                }
                                productCategoryStmt.executeBatch();
                            }

                            success = true;
                        }
                    }
                }
            }

            connection.commit();
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return success;
    }
    public boolean deleteProduct(int productId) {
        String deleteProductCSQuery = "DELETE FROM Product_CS WHERE ProductID = ?";
        String deleteProductCategoriesQuery = "DELETE FROM Product_Categories WHERE ProductID = ?";
        String deleteProductQuery = "DELETE FROM Products WHERE ProductID = ?";
        
        try {
            connection.setAutoCommit(false);
            
            // Delete from Product_CS table
            try (PreparedStatement stmt = connection.prepareStatement(deleteProductCSQuery)) {
                stmt.setInt(1, productId);
                stmt.executeUpdate();
            }

            // Delete from Product_Categories table
            try (PreparedStatement stmt = connection.prepareStatement(deleteProductCategoriesQuery)) {
                stmt.setInt(1, productId);
                stmt.executeUpdate();
            }

            // Delete from Products table
            try (PreparedStatement stmt = connection.prepareStatement(deleteProductQuery)) {
                stmt.setInt(1, productId);
                stmt.executeUpdate();
            }
            
            connection.commit();
            return true;
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
   public Products getProductDetails(int productId) {
      Products product = null;
        String query = "SELECT p.ProductID, p.Title, p.SalePrice, p.ListPrice, p.Description, p.BriefInformation, i.Link AS Thumbnail, "
                + "c.Name as Category, "
                + "STRING_AGG(CONCAT(pcs.Quantities, ' (', pcs.Size, ')'), ', ') WITHIN GROUP (ORDER BY pcs.Size) as QuantitiesSizes, "
                + "STRING_AGG(CONVERT(varchar, pcs.Size), ', ') WITHIN GROUP (ORDER BY pcs.Size) as Size, "
                + "p.[Status], p.Feature, "
                + "(SELECT STRING_AGG(im.Link, ', ') FROM ImageMappings imap JOIN Images im ON imap.ImageID = im.ImageID WHERE imap.EntityName = 2 AND imap.EntityID = p.ProductID) as ImageDetails "
                + "FROM Products p "
                + "JOIN Product_Categories pc ON p.ProductID = pc.ProductID "
                + "JOIN Product_Category_List c ON pc.ProductCL = c.ProductCL "
                + "JOIN Product_CS pcs ON p.ProductID = pcs.ProductID "
                + "JOIN Images i ON p.Thumbnail = i.ImageID "
                + "WHERE p.ProductID = ? "
                + "GROUP BY p.ProductID, p.Title, p.SalePrice, p.ListPrice, p.Description, p.BriefInformation, i.Link, c.Name, p.[Status], p.Feature";
    try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
        preparedStatement.setInt(1, productId);
        try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    product = new Products();
                    product.setProductID(rs.getInt("ProductID"));
                    product.setTitle(rs.getString("Title"));
                    product.setSalePrice(rs.getFloat("SalePrice"));
                    product.setListPrice(rs.getFloat("ListPrice"));
                    product.setDescription(rs.getString("Description"));
                    product.setBriefInformation(rs.getString("BriefInformation"));
                    product.setThumbnailLink(rs.getString("Thumbnail"));
                    product.setCategory(rs.getString("Category"));
                    product.setSize(rs.getString("Size"));
                    product.setQuantitiesSizes(rs.getString("QuantitiesSizes"));
                    product.setStatus(rs.getBoolean("Status"));
                    product.setFeature(rs.getBoolean("Feature"));
                    product.setImageDetails(rs.getString("ImageDetails"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    public static void main(String[] args) {
//        ProductDAO productDAO = new ProductDAO();
//
//        Products product = new Products();
//        product.setTitle("Sample Product");
//        product.setSalePrice(99.99f);
//        product.setListPrice(129.99f);
//        product.setDescription("This is a sample product.");
//        product.setBriefInformation("Sample brief information.");
//        product.setStatus(true);
//        product.setFeature(false);
//
//        ProductCS productCS = new ProductCS();
//        productCS.setSize(42);
//        productCS.setQuantities(10);
//
//        List<ProductCategories> productCategoriesList = new ArrayList<>();
//        ProductCategoryList categoryList = new ProductCategoryList();
//        categoryList.setProductCL(1); // Assuming you have a category with ID 1
//
//        ProductCategories productCategory = new ProductCategories();
//        productCategory.setProductCL(categoryList);
//        productCategoriesList.add(productCategory);
//
//        int thumbnailId = productDAO.addImage("https://example.com/image.jpg"); // Thêm hình ảnh và lấy ID
//        if (thumbnailId != -1) {
//            product.setThumbnail(thumbnailId);
//            boolean success = productDAO.addProduct(product, productCS, productCategoriesList);
//            if (success) {
//                System.out.println("Product added successfully.");
//            } else {
//                System.out.println("Failed to add product.");
//            }
//        } else {
//            System.out.println("Failed to add thumbnail.");
//        }
          ProductDAO productDAO = new ProductDAO();
          System.out.println(productDAO.getProductByID(1));
       
    }
}
