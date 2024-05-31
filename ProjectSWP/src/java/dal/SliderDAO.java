package dal;

import model.Sliders;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SliderDAO extends DBContext {

    // SQL queries
    private final String INSERT_SLIDER = "INSERT INTO Sliders (Status, BackLink, Title, StaffID) VALUES (?, ?, ?, ?)";
    private final String DELETE_SLIDER = "DELETE FROM Sliders WHERE SliderID = ?";
    private final String DELETE_IMAGE_MAPPING = "DELETE FROM ImageMappings WHERE EntityID = ? AND EntityName = 4";
    private final String DELETE_IMAGE = "DELETE FROM Images WHERE ImageID = ?";
    private final String SELECT_IMAGE_ID = "SELECT i.ImageID FROM Images i "
            + "INNER JOIN ImageMappings im ON i.ImageID = im.ImageID "
            + "WHERE im.EntityName = 4 AND im.EntityID = ?";
    private final String SELECT_ALL_SLIDERS = "SELECT s.SliderID, s.Status, s.BackLink, s.Title, s.StaffID, st.Username AS Staff, i.Link AS ImageLink "
            + "FROM Sliders s "
            + "JOIN Staffs st ON s.StaffID = st.StaffID "
            + "LEFT JOIN ImageMappings im ON im.EntityID = s.SliderID AND im.EntityName = 4 "
            + "JOIN Images i ON i.ImageID = im.ImageID";
    private final String INSERT_IMAGE = "INSERT INTO Images (Link) VALUES (?)";
    private final String INSERT_IMAGE_MAPPING = "INSERT INTO ImageMappings (ImageID, EntityName, EntityID) VALUES (?, ?, ?)";
    private final String UPDATE_SLIDER_STATUS = "UPDATE Sliders SET Status = ? WHERE SliderID = ?";
    private final String UPDATE_SLIDER = "UPDATE Sliders SET Status = ?, BackLink = ?, Title = ? WHERE SliderID = ?";
    private final String UPDATE_IMAGE = "UPDATE Images SET Link = ? WHERE ImageID = ?";
    private final String SELECT_IMAGE_ID_WITH_SLIDER_ID = "SELECT i.ImageID FROM Images i "
            + "INNER JOIN ImageMappings im ON i.ImageID = im.ImageID "
            + "WHERE im.EntityName = 4 AND im.EntityID = ?";

    // Method to insert a new slider along with image and image mapping into the database
    public boolean insertSlider(Sliders slider) {
        Connection conn = null;
        PreparedStatement psInsertSlider = null;
        PreparedStatement psInsertImage = null;
        PreparedStatement psInsertImageMapping = null;
        ResultSet rs = null;

        try {
            conn = this.connection;
            conn.setAutoCommit(false); // Start transaction

            // Step 1: Insert the slider details into the Sliders table
            psInsertSlider = conn.prepareStatement(INSERT_SLIDER, Statement.RETURN_GENERATED_KEYS);
            psInsertSlider.setBoolean(1, slider.isStatus());
            psInsertSlider.setString(2, slider.getBackLink());
            psInsertSlider.setString(3, slider.getTitle());
            psInsertSlider.setInt(4, slider.getStaffID());
            psInsertSlider.executeUpdate();

            rs = psInsertSlider.getGeneratedKeys();
            int sliderID = 0;
            if (rs.next()) {
                sliderID = rs.getInt(1);
            }

            // Step 2: Insert the image details into the Images table
            psInsertImage = conn.prepareStatement(INSERT_IMAGE, Statement.RETURN_GENERATED_KEYS);
            psInsertImage.setString(1, slider.getImageLink());
            psInsertImage.executeUpdate();

            rs = psInsertImage.getGeneratedKeys();
            int imageID = 0;
            if (rs.next()) {
                imageID = rs.getInt(1);
            }

            // Step 3: Insert the image mapping into the ImageMappings table
            psInsertImageMapping = conn.prepareStatement(INSERT_IMAGE_MAPPING);
            psInsertImageMapping.setInt(1, imageID);
            psInsertImageMapping.setInt(2, 4); // Assuming EntityName for slider is 4
            psInsertImageMapping.setInt(3, sliderID);
            psInsertImageMapping.executeUpdate();

            conn.commit(); // Commit transaction
            return true;
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback transaction on error
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (psInsertSlider != null) {
                    psInsertSlider.close();
                }
                if (psInsertImage != null) {
                    psInsertImage.close();
                }
                if (psInsertImageMapping != null) {
                    psInsertImageMapping.close();
                }
                if (conn != null) {
                    conn.setAutoCommit(true); // Reset to default state
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Method to delete a slider along with its image and image mapping from the database
    public boolean deleteSlider(int sliderID) {
        Connection conn = null;
        PreparedStatement psDeleteSlider = null;
        PreparedStatement psDeleteImageMapping = null;
        PreparedStatement psDeleteImage = null;
        PreparedStatement psSelectImageID = null;
        ResultSet rs = null;

        try {
            conn = this.connection;
            conn.setAutoCommit(false); // Start transaction
            System.out.println("Transaction started for deleting slider with ID: " + sliderID);

            // Step 1: Get the ImageID associated with the slider
            psSelectImageID = conn.prepareStatement(SELECT_IMAGE_ID);
            psSelectImageID.setInt(1, sliderID);
            rs = psSelectImageID.executeQuery();

            int imageID = 0;
            if (rs.next()) {
                imageID = rs.getInt("ImageID");
                System.out.println("ImageID found: " + imageID);
            } else {
                System.out.println("No ImageID found for sliderID: " + sliderID);
            }

            // Step 2: Delete the image mapping
            psDeleteImageMapping = conn.prepareStatement(DELETE_IMAGE_MAPPING);
            psDeleteImageMapping.setInt(1, sliderID);
            int imageMappingDeleted = psDeleteImageMapping.executeUpdate();
            System.out.println("Image mappings deleted: " + imageMappingDeleted);

            // Step 3: Delete the image
            psDeleteImage = conn.prepareStatement(DELETE_IMAGE);
            psDeleteImage.setInt(1, imageID);
            int imagesDeleted = psDeleteImage.executeUpdate();
            System.out.println("Images deleted: " + imagesDeleted);

            // Step 4: Delete the slider
            psDeleteSlider = conn.prepareStatement(DELETE_SLIDER);
            psDeleteSlider.setInt(1, sliderID);
            int rowsAffected = psDeleteSlider.executeUpdate();
            System.out.println("Sliders deleted: " + rowsAffected);

            conn.commit(); // Commit transaction
            System.out.println("Transaction committed for deleting slider with ID: " + sliderID);
            return rowsAffected > 0;
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback transaction on error
                    System.out.println("Transaction rolled back for sliderID: " + sliderID);
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (psDeleteSlider != null) {
                    psDeleteSlider.close();
                }
                if (psDeleteImageMapping != null) {
                    psDeleteImageMapping.close();
                }
                if (psDeleteImage != null) {
                    psDeleteImage.close();
                }
                if (psSelectImageID != null) {
                    psSelectImageID.close();
                }
                if (conn != null) {
                    conn.setAutoCommit(true); // Reset to default state
                }
                System.out.println("Resources closed and auto-commit reset.");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public boolean updateSlider(Sliders slider) {
        Connection conn = null;
        PreparedStatement psUpdateSlider = null;
        PreparedStatement psUpdateImage = null;
        PreparedStatement psSelectImageID = null;
        ResultSet rs = null;

        try {
            conn = this.connection;
            conn.setAutoCommit(false); // Start transaction

            // Step 1: Update the slider details in the Sliders table
            psUpdateSlider = conn.prepareStatement(UPDATE_SLIDER);
            psUpdateSlider.setBoolean(1, slider.isStatus());
            psUpdateSlider.setString(2, slider.getBackLink());
            psUpdateSlider.setString(3, slider.getTitle());
            psUpdateSlider.setInt(4, slider.getSliderID());
            psUpdateSlider.executeUpdate();

            // Step 2: Get the ImageID associated with the slider
            psSelectImageID = conn.prepareStatement(SELECT_IMAGE_ID_WITH_SLIDER_ID);
            psSelectImageID.setInt(1, slider.getSliderID());
            rs = psSelectImageID.executeQuery();

            int imageID = 0;
            if (rs.next()) {
                imageID = rs.getInt("ImageID");
            }

            // Step 3: Update the image details in the Images table
            psUpdateImage = conn.prepareStatement(UPDATE_IMAGE);
            psUpdateImage.setString(1, slider.getImageLink());
            psUpdateImage.setInt(2, imageID);
            psUpdateImage.executeUpdate();

            conn.commit(); // Commit transaction
            return true;
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback transaction on error
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (psUpdateSlider != null) {
                    psUpdateSlider.close();
                }
                if (psUpdateImage != null) {
                    psUpdateImage.close();
                }
                if (psSelectImageID != null) {
                    psSelectImageID.close();
                }
                if (conn != null) {
                    conn.setAutoCommit(true); // Reset to default state
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public List<Sliders> getAllSliders() {
        List<Sliders> slidersList = new ArrayList<>();
        try (Statement statement = connection.createStatement(); ResultSet resultSet = statement.executeQuery(SELECT_ALL_SLIDERS)) {
            while (resultSet.next()) {
                int sliderID = resultSet.getInt("SliderID");
                boolean status = resultSet.getBoolean("Status");
                String backLink = resultSet.getString("BackLink");
                String title = resultSet.getString("Title");
                int staffID = resultSet.getInt("StaffID");
                String staff = resultSet.getString("Staff");
                String imageLink = resultSet.getString("ImageLink");

                Sliders slider = new Sliders(sliderID, status, backLink, title, staffID, staff, imageLink);
                slidersList.add(slider);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slidersList;
    }

    // Method to get image link for a slider from ImageMappings table
        public String getImageLinkForSlider(int sliderID) {
            String query = "SELECT i.Link FROM Images i "
                    + "INNER JOIN ImageMappings im ON i.ImageID = im.ImageID "
                    + "WHERE im.EntityName = 4 AND im.EntityID = ? ";

            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, sliderID);
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        return resultSet.getString("Link");
                    } else {
                        System.out.println("No matching records found for sliderID: " + sliderID);
                    }
                }
            } catch (SQLException e) {
                System.err.println("SQL exception occurred while fetching image link for sliderID: " + sliderID);
                e.printStackTrace();
            } catch (Exception e) {
                System.err.println("Unexpected exception occurred while fetching image link for sliderID: " + sliderID);
                e.printStackTrace();
            }
            return null;
        }

    public boolean updateSliderStatus(int sliderID, boolean status) {
        try (PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_SLIDER_STATUS)) {
            preparedStatement.setBoolean(1, status);
            preparedStatement.setInt(2, sliderID);

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Sliders getSliderByID(int sliderID) {
        String query = "SELECT s.SliderID, s.Status, s.BackLink, s.Title, s.StaffID, st.Username AS Staff, i.Link AS ImageLink "
                + "FROM Sliders s "
                + "JOIN Staffs st ON s.StaffID = st.StaffID "
                + "LEFT JOIN ImageMappings im ON im.EntityID = s.SliderID AND im.EntityName = 4 "
                + "JOIN Images i ON i.ImageID = im.ImageID "
                + "WHERE s.SliderID = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, sliderID);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    boolean status = resultSet.getBoolean("Status");
                    String backLink = resultSet.getString("BackLink");
                    String title = resultSet.getString("Title");
                    int staffID = resultSet.getInt("StaffID");
                    String staff = resultSet.getString("Staff");
                    String imageLink = resultSet.getString("ImageLink");

                    return new Sliders(sliderID, status, backLink, title, staffID, staff, imageLink);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if no slider is found with the given ID
    }

    public static void main(String[] args) {
        SliderDAO sliderDAO = new SliderDAO();

        // Test for getImageLinkForSlider
        System.out.println(sliderDAO.getImageLinkForSlider(1));

        // Test for updateSliderStatus
        System.out.println(sliderDAO.updateSliderStatus(1, true));

//        // Test for insertSlider
//        StaffDAO staffDAO = new StaffDAO();
//
        Sliders testSlider = new Sliders(0, true, "https://example.com", "Test Slider", 1, "Test Staff", "https://example.com/image.jpg");
        boolean insertResult = sliderDAO.insertSlider(testSlider);

//        // Fetch the inserted slider ID
//        List<Sliders> slidersList = sliderDAO.getAllSliders();
//        Sliders insertedSlider = slidersList.get(slidersList.size() - 1);
//        int sliderID = insertedSlider.getSliderID();
////        // Delete the slider
//        boolean deleteResult = sliderDAO.deleteSlider(sliderID);
//        System.out.println(deleteResult);
//        assertTrue(deleteResult, "Failed to delete slider");
//
//        // Verify the slider is deleted
//        slidersList = sliderDAO.getAllSliders();
//        boolean isSliderDeleted = slidersList.stream().noneMatch(s -> s.getSliderID() == sliderID);
//        assertTrue(isSliderDeleted, "Slider was not deleted");
//
//        // Verify the image and image mapping are also deleted
//        String imageLink = sliderDAO.getImageLinkForSlider(sliderID);
//        assertNull(imageLink, "Image was not deleted");
    }
}
