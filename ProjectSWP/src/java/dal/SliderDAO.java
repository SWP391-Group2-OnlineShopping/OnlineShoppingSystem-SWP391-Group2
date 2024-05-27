package dal;

import model.Sliders;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SliderDAO extends DBContext {

    // SQL queries
    private final String INSERT_SLIDER = "INSERT INTO Sliders (Status, BackLink, Title, StaffID, ImageLink) VALUES (?, ?, ?, ?, ?)";
    private final String DELETE_SLIDER = "DELETE FROM Sliders WHERE SliderID = ?";
    private final String SELECT_ALL_SLIDERS = "SELECT * FROM Sliders";
    // Add more queries as needed

    // Method to insert a new slider into the database
    public boolean insertSlider(Sliders slider) {
        try (PreparedStatement preparedStatement = connection.prepareStatement(INSERT_SLIDER)) {
            preparedStatement.setBoolean(1, slider.isStatus());
            preparedStatement.setString(2, slider.getBackLink());
            preparedStatement.setString(3, slider.getTitle());
            preparedStatement.setInt(4, slider.getStaffID());
            preparedStatement.setString(5, slider.getImageLink());

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to delete a slider from the database
    public boolean deleteSlider(int sliderID) {
        try (PreparedStatement preparedStatement = connection.prepareStatement(DELETE_SLIDER)) {
            preparedStatement.setInt(1, sliderID);

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
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

                // Get image link from ImageMappings table
                String imageLink = getImageLinkForSlider(sliderID);
                System.out.println(imageLink);

                Sliders slider = new Sliders(sliderID, status, backLink, title, staffID, imageLink);
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
  
  
  public static void main(String[] args) {
        SliderDAO sliderDAO = new SliderDAO();
        for (Sliders sliders : sliderDAO.getAllSliders()) {
        //System.out.println(sliders);
        }

        System.out.println(sliderDAO.getImageLinkForSlider(1));
    }
    // Add more methods as needed for update, select by ID, etc.
}
