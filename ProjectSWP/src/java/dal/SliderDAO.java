package dal;

import model.Sliders;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SliderDAO extends DBContext {

    public List<Sliders> getAllSliders() {
        List<Sliders> sliders = new ArrayList<>();
        String sql = "SELECT * FROM Sliders";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Sliders slider = new Sliders();
                slider.setSliderID(rs.getInt("SliderID"));
                slider.setStatus(rs.getBoolean("Status"));
                slider.setBackLink(rs.getString("BackLink"));
                slider.setTitle(rs.getString("Title"));
                slider.setStaffID(rs.getInt("StaffID"));
                sliders.add(slider);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sliders;
    }

    public Sliders getSliderById(int sliderId) {
        Sliders slider = null;
        String sql = "SELECT * FROM Sliders WHERE SliderID = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {

            pstmt.setInt(1, sliderId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    slider = new Sliders();
                    slider.setSliderID(rs.getInt("SliderID"));
                    slider.setStatus(rs.getBoolean("Status"));
                    slider.setBackLink(rs.getString("BackLink"));
                    slider.setTitle(rs.getString("Title"));
                    slider.setStaffID(rs.getInt("StaffID"));
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
            return rowsInserted > 0;
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

    public boolean deleteSlider(int sliderId) {
        String sql = "DELETE FROM Sliders WHERE SliderID = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {

            pstmt.setInt(1, sliderId);
            int rowsDeleted = pstmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}