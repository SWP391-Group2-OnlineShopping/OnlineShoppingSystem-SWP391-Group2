package dal;

import model.Images;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ImageDAO extends DBContext{


    public ImageDAO() {
    }

    public int insertImage(Images image) throws SQLException {
        String sql = "INSERT INTO Images (Link) VALUES (?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, image.getLink());
            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating image failed, no rows affected.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating image failed, no ID obtained.");
                }
            }
        }
    }

    public void insertImageMapping(int entityName, int entityID, int imageID) throws SQLException {
        String sql = "INSERT INTO ImageMappings (EntityName, EntityID, ImageID) VALUES (?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, entityName);
            stmt.setInt(2, entityID);
            stmt.setInt(3, imageID);
            stmt.executeUpdate();
        }
    }
    public static void main(String[] args) {
        try {
            // Establishing the database connection

            // Creating an instance of ImageDAO
            ImageDAO imageDAO = new ImageDAO();

            // Creating a new Images object
            Images image = new Images();
            image.setLink("http://example.com/image.jpg");

            // Inserting the image into the database and retrieving the generated ID
            int imageID = imageDAO.insertImage(image);
            System.out.println("Inserted image ID: " + imageID);

            // Inserting an image mapping (assuming entityName is 1 for feedback and entityID is 123)
            imageDAO.insertImageMapping(1, 123, imageID);
            System.out.println("Inserted image mapping for image ID: " + imageID);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
