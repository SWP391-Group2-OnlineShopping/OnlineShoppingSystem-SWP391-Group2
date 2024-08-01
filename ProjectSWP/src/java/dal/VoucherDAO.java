/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Statement;
import model.Voucher;
import java.util.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

/**
 *
 * @author dumspicy
 */
//get all voucher
public class VoucherDAO extends DBContext {

    public List<Voucher> getAllVoucher() {
        List<Voucher> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Discount";
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Voucher voucher = new Voucher();
                voucher.setId(rs.getInt(1));
                voucher.setName(rs.getString(2));
                voucher.setPercent(rs.getInt(3));
                voucher.setRequirement(rs.getFloat((4)));
                voucher.setDescription(rs.getString(5));
                voucher.setStatus(rs.getBoolean(6));
                voucher.setCreatedDate(rs.getDate(7));
                voucher.setUsedDate(rs.getDate(8));
                voucher.setExpiredDate(rs.getDate(9));
                list.add(voucher);
            }
            rs.close();
            st.close();
        } catch (Exception e) {

        }
        return list;
    }

    public List<Voucher> getAvailableVoucher() {
        List<Voucher> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Discount WHERE UsedDate IS NULL AND [Status] = 1";
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Voucher voucher = new Voucher();
                voucher.setId(rs.getInt(1));
                voucher.setName(rs.getString(2));
                voucher.setPercent(rs.getInt(3));
                voucher.setRequirement(rs.getFloat((4)));
                voucher.setDescription(rs.getString(5));
                voucher.setStatus(rs.getBoolean(6));
                voucher.setCreatedDate(rs.getDate(7));
                voucher.setUsedDate(rs.getDate(8));
                voucher.setExpiredDate(rs.getDate(9));
                list.add(voucher);
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Voucher getVoucherByVoucherID(int voucherID) {
        String sql = "SELECT * FROM Discount WHERE DiscountID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, voucherID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Voucher voucher = new Voucher();
                voucher.setId(rs.getInt(1));
                voucher.setName(rs.getString(2));
                voucher.setPercent(rs.getInt(3));
                voucher.setRequirement(rs.getFloat(4));
                voucher.setDescription(rs.getString(5));
                voucher.setStatus(rs.getBoolean(6));
                voucher.setCreatedDate(rs.getDate(7));
                voucher.setUsedDate(rs.getDate(8));
                voucher.setExpiredDate(rs.getDate(9));
                return voucher;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public int totalNumberOfVoucher() {
        try {
            String sql = "SELECT COUNT(*) FROM Discount";
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {

        }
        return 0;
    }

    //update status
    public boolean updateVoucherStatus(int voucherID, boolean status) {
        try (PreparedStatement preparedStatement = connection.prepareStatement("Update Discount SET Status = ? WHERE DiscountID = ?")) {
            preparedStatement.setBoolean(1, status);
            preparedStatement.setInt(2, voucherID);

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //Update voucher 
    public boolean updateVoucher(Voucher voucher) {
        String sql = "UPDATE Discount SET DiscountName = ?, DiscountPercent = ?, DiscountRequirement = ?, DiscountDescription = ?, [Status] = ?, ExpiredDate = ? WHERE DiscountID = ?";
        boolean isUpdated = false;
        PreparedStatement ps = null;

        try {
            if (connection == null || connection.isClosed()) {
                System.out.println("Database connection is not established.");
                return false;
            }

            ps = connection.prepareStatement(sql);
            ps.setString(1, voucher.getName());
            ps.setInt(2, voucher.getPercent());
            ps.setFloat(3, voucher.getRequirement());
            ps.setString(4, voucher.getDescription());
            ps.setBoolean(5, voucher.isStatus());

            // Check if voucher.getExpiredDate() is null
            if (voucher.getExpiredDate() != null) {
                ps.setDate(6, new java.sql.Date(voucher.getExpiredDate().getTime()));
            } else {
                ps.setDate(6, null); // or handle appropriately if expired date can be null
            }

            ps.setInt(7, voucher.getId());

            int rowAffected = ps.executeUpdate();
            isUpdated = rowAffected > 0;
        } catch (SQLException e) {
            System.out.println("SQL Exception: " + e.getMessage());
        } catch (Exception e) {
            System.out.println("Exception: " + e.getMessage());
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                /* Handle exception */ }
        }

        return isUpdated;
    }

    //Delete Voucher
    public boolean deleteVoucher(int voucherID) {
        boolean isDeleted = false;
        try {
            String sql = "DELETE FROM Discount WHERE DiscountID = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, voucherID);

            int rowAffected = ps.executeUpdate();
            isDeleted = rowAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isDeleted;
    }

    //add new voucher
    public boolean Add(Voucher voucher) {
        String sql = "INSERT INTO Discount (DiscountName, DiscountPercent, DiscountRequirement, DiscountDescription, [Status], CreatedDate, ExpiredDate) VALUES(?, ?, ?, ?, ?, GETDATE(), ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, voucher.getName());
            ps.setInt(2, voucher.getPercent());
            ps.setFloat(3, voucher.getRequirement());
            ps.setString(4, voucher.getDescription());
            ps.setBoolean(5, voucher.isStatus());
            ps.setDate(6, new java.sql.Date(voucher.getExpiredDate().getTime()));
            int rowAffected = ps.executeUpdate();
            return rowAffected > 0;
        } catch (Exception e) {
            return false;
        }
    }

    //Update used date
    public boolean UpdateUsedDate(int voucherID) throws SQLException {
        String sql = "UPDATE Discount SET UsedDate = GETDATE() WHERE DiscountID = ?";
        boolean isUpdated = false;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, voucherID);
            int rowAffected = ps.executeUpdate();
            isUpdated = rowAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isUpdated;
    }

    public static void main(String[] args) {
        VoucherDAO vDAO = new VoucherDAO();
        List<Voucher> list = vDAO.getAvailableVoucher();
        for (Voucher v : list) {
            System.out.println(v);
        }
        Voucher v = new Voucher();
        boolean isUpdate = vDAO.updateVoucher(v);
        System.out.println(isUpdate);

        boolean update = vDAO.updateVoucherStatus(1, false);
        System.out.println(update);
    }
}
