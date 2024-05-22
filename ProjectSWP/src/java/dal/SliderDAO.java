package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Sliders;

public class SliderDAO extends DBContext {

    public List<Sliders> getAllSliders() {
        List<Sliders> sliders = new ArrayList<>();
        String sql = "SELECT s.SliderID, s.Status, s.BackLink, s.Title, s.StaffID, i.Link AS ImageLink " +
                     "FROM Sliders s " +
                     "JOIN ImageMappings im ON s.SliderID = im.EntityID AND im.EntityName = 4 " +
                     "JOIN Images i ON im.ImageID = i.ImageID";
        try (PreparedStatement pstmt = connection.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Sliders slider = new Sliders();
                slider.setSliderID(rs.getInt("SliderID"));
                slider.setStatus(rs.getBoolean("Status"));
                slider.setBackLink(rs.getString("BackLink"));
                slider.setTitle(rs.getString("Title"));
                slider.setStaffID(rs.getInt("StaffID"));
                slider.setImageLink(rs.getString("ImageLink"));
                sliders.add(slider);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sliders;
    }

    public Sliders getSliderById(int sliderID) {
        Sliders slider = null;
        String sql = "SELECT s.SliderID, s.Status, s.BackLink, s.Title, s.StaffID, i.Link AS ImageLink " +
                     "FROM Sliders s " +
                     "JOIN ImageMappings im ON s.SliderID = im.EntityID AND im.EntityName = 4 " +
                     "JOIN Images i ON im.ImageID = i.ImageID " +
                     "WHERE s.SliderID = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, sliderID);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    slider = new Sliders();
                    slider.setSliderID(rs.getInt("SliderID"));
                    slider.setStatus(rs.getBoolean("Status"));
                    slider.setBackLink(rs.getString("BackLink"));
                    slider.setTitle(rs.getString("Title"));
                    slider.setStaffID(rs.getInt("StaffID"));
                    slider.setImageLink(rs.getString("ImageLink"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slider;
    }

    public boolean insertSlider(Sliders slider) {
        String sql = "INSERT INTO Sliders (Status, BackLink, Title, StaffID) VALUES (?, ?, ?, ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setBoolean(1, slider.isStatus());
            pstmt.setString(2, slider.getBackLink());
            pstmt.setString(3, slider.getTitle());
            pstmt.setInt(4, slider.getStaffID());
            int rowsInserted = pstmt.executeUpdate();
            if (rowsInserted > 0) {
                // Assuming the SliderID is auto-generated and retrieved here if needed
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateSlider(Sliders slider) {
        String sql = "UPDATE Sliders SET Status = ?, BackLink = ?, Title = ?, StaffID = ? WHERE SliderID = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setBoolean(1, slider.isStatus());
            pstmt.setString(2, slider.getBackLink());
            pstmt.setString(3, slider.getTitle());
            pstmt.setInt(4, slider.getStaffID());
            pstmt.setInt(5, slider.getSliderID());
            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteSlider(int sliderID) {
        String sql = "DELETE FROM Sliders WHERE SliderID = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, sliderID);
            int rowsDeleted = pstmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}