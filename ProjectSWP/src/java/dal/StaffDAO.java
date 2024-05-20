package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Staffs;

public class StaffDAO extends DBContext {

    // Method to retrieve a staff member by their ID
    public Staffs getStaffById(int id) {
        Staffs staff = null;
        String sql = "SELECT * FROM Staffs WHERE StaffID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    staff = mapRowToStaff(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staff;
    }

    // Method to retrieve all staff members
    public List<Staffs> getAllStaff() {
        List<Staffs> staffList = new ArrayList<>();
        String sql = "SELECT * FROM Staffs";
        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Staffs staff = mapRowToStaff(rs);
                staffList.add(staff);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staffList;
    }

    // Method to add a new staff member
    public void addStaff(Staffs staff) {
        String sql = "INSERT INTO Staffs (Username, Password, Email, Gender, Address, FullName, Status, Mobile, DOB, Role) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, staff.getUsername());
            stmt.setString(2, staff.getPassword());
            stmt.setString(3, staff.getEmail());
            stmt.setBoolean(4, staff.isGender());
            stmt.setString(5, staff.getAddress());
            stmt.setString(6, staff.getFullName());
            stmt.setBoolean(7, staff.isStatus());
            stmt.setString(8, staff.getMobile());
            stmt.setDate(9, new java.sql.Date(staff.getDob().getTime()));
            stmt.setInt(10, staff.getRole());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to update an existing staff member
    public void updateStaff(Staffs staff) {
        String sql = "UPDATE Staffs SET Username = ?, Password = ?, Email = ?, Gender = ?, Address = ?, FullName = ?, Status = ?, Mobile = ?, DOB = ?, Role = ? WHERE StaffID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, staff.getUsername());
            stmt.setString(2, staff.getPassword());
            stmt.setString(3, staff.getEmail());
            stmt.setBoolean(4, staff.isGender());
            stmt.setString(5, staff.getAddress());
            stmt.setString(6, staff.getFullName());
            stmt.setBoolean(7, staff.isStatus());
            stmt.setString(8, staff.getMobile());
            stmt.setDate(9, new java.sql.Date(staff.getDob().getTime()));
            stmt.setInt(10, staff.getRole());
            stmt.setInt(11, staff.getStaffID());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to delete a staff member
    public void deleteStaff(int id) {
        String sql = "DELETE FROM Staffs WHERE StaffID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Helper method to map ResultSet row to Staff object
    private Staffs mapRowToStaff(ResultSet rs) throws SQLException {
        Staffs staff = new Staffs();
        staff.setStaffID(rs.getInt("StaffID"));
        staff.setUsername(rs.getString("Username"));
        staff.setPassword(rs.getString("Password"));
        staff.setEmail(rs.getString("Email"));
        staff.setGender(rs.getBoolean("Gender"));
        staff.setAddress(rs.getString("Address"));
        staff.setFullName(rs.getString("FullName"));
        staff.setStatus(rs.getBoolean("Status"));
        staff.setMobile(rs.getString("Mobile"));
        staff.setDob(rs.getDate("DOB"));
        staff.setRole(rs.getInt("Role"));
        return staff;
    }

    public Staffs getStaffByUsername(String username) throws SQLException {
        Staffs staff = null;
        String sql = "SELECT * FROM Staffs WHERE Username = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    staff = mapRowToStaff(rs);
                }
            }
        }
        return staff;
    }
}
