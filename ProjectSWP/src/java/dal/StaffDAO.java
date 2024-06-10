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
            stmt.setString(7, staff.isStatus());
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
            stmt.setString(7, staff.isStatus());
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
        staff.setStatus(rs.getString("Status"));
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

    public Staffs loginStaff(String username, String password) {
        String sql = "select * from Staffs where Username=? and Password=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Staffs(
                        rs.getInt("StaffID"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("Email"),
                        rs.getBoolean("Gender"),
                        rs.getString("Address"),
                        rs.getString("FullName"),
                        rs.getString("Status"),
                        rs.getString("Mobile"),
                        rs.getDate("DOB"),
                        rs.getInt("Role")
                );
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    //get all salers
    public List<Staffs> getAllStaffSales() {
        List<Staffs> staffList = new ArrayList<>();
        String sql = "select * from Staffs where Role = 3";
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

    public List<Staffs> getAllOrderCountFromSale() {
        List<Staffs> staffList = new ArrayList<>();
        String sql = "SELECT  s.StaffID, s.Username, s.Email, s.FullName, s.Role,\n"
                + "COUNT(o.OrderID) AS OrderCount\n"
                + "FROM Staffs s LEFT JOIN  Orders o \n"
                + "ON s.StaffID = o.StaffID\n"
                + "WHERE  s.Role = 3\n"
                + "GROUP BY  s.StaffID, s.Username, s.Email, s.FullName, s.Role\n"
                + "ORDER BY OrderCount ASC;";
        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Staffs staff = new Staffs();
                staff.setStaffID(rs.getInt("StaffID"));
                staff.setUsername(rs.getString("Username"));
                staff.setEmail(rs.getString("Email"));
                staff.setFullName(rs.getString("FullName"));
                staff.setRole(rs.getInt("Role"));
                staff.setOrderCount(rs.getInt("OrderCount"));
                staffList.add(staff);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staffList;
    }

    public List<Staffs> getAllLeastOrderCountFromSale() {
        List<Staffs> staffList = new ArrayList<>();
        String sql = "WITH OrderCounts AS (\n"
                + "    SELECT s.StaffID, s.Username, s.Email, s.FullName, s.Role,\n"
                + "        COUNT(o.OrderID) AS OrderCount\n"
                + "    FROM Staffs s LEFT JOIN Orders o \n"
                + "    ON s.StaffID = o.StaffID\n"
                + "    WHERE s.Role = 3\n"
                + "    GROUP BY s.StaffID, s.Username, s.Email, s.FullName, s.Role\n"
                + ")\n"
                + "SELECT StaffID, Username, Email,  FullName, Role, OrderCount\n"
                + "FROM OrderCounts\n"
                + "WHERE OrderCount = (SELECT MIN(OrderCount) \n"
                + "FROM OrderCounts);";
        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Staffs staff = new Staffs();
                staff.setStaffID(rs.getInt("StaffID"));
                staff.setUsername(rs.getString("Username"));
                staff.setEmail(rs.getString("Email"));
                staff.setFullName(rs.getString("FullName"));
                staff.setRole(rs.getInt("Role"));
                staff.setOrderCount(rs.getInt("OrderCount"));
                staffList.add(staff);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staffList;
    }

    public void removeOrderExpired(int orderID) {
        String sql3 = "DELETE od\n"
                + "FROM Order_Detail od\n"
                + "JOIN Orders o ON o.OrderID = od.OrderID\n"
                + "WHERE o.OrderID = ?\n"
                + "AND o.OrderStatusID = 1\n"
                + "AND DATEDIFF(HOUR, o.OrderDate, GETDATE()) > 24;";

        String sql = "DELETE FROM Orders WHERE OrderID = ? and OrderStatusID = 1 AND DATEDIFF(HOUR, OrderDate, GETDATE()) > 24";
        try {
            PreparedStatement st3 = connection.prepareStatement(sql3);
            st3.setInt(1, orderID);
            st3.executeQuery();

            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderID);
            st.executeQuery();

        } catch (Exception e) {
        }
    }

    public static void main(String[] args) {
        StaffDAO dao = new StaffDAO();
        List<Staffs> staffList = dao.getAllLeastOrderCountFromSale();
        for (Staffs s : staffList) {
            System.out.println(s);
        }
//        System.out.println(dao.loginStaff("Marketer", "maketer123"));
    }
}