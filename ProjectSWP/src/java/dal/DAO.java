/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Customers;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.sql.SQLException;

/**
 *
 * @author LENOVO
 */
public class DAO extends DBContext {

    public Customers checkAccount(String email) {
        String sql = "select * from Customers where Email=? ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return new Customers(email);
            }
        } catch (Exception e) {
        }
        return null;
    }

    public Customers checkAccountName(String name) {
        String sql = "select * from Customers where Username=? ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, name);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return new Customers(name, rs.getString(3));
            }
        } catch (Exception e) {
        }
        return null;
    }

    public void signup(String user, String pass, String phone, String email, String address, String fullname,
            String gender, String dob) {
        String sql = "INSERT INTO Customers (Username, Password, Email, Gender, Address, FullName, Status, Mobile, DOB) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            // Parse the incoming dob assuming it's in yyyy-mm-dd format
            LocalDate dateOfBirth = LocalDate.parse(dob);

            // Optional: Format the LocalDate to a different string format if necessary
            // For example, if you need it in dd-MM-yyyy format, you can do:
            String formattedDob = dateOfBirth.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            // Set parameters
            st.setString(1, user);
            st.setString(2, pass);
            st.setString(3, email);
            st.setString(4, gender);
            st.setString(5, address);
            st.setString(6, fullname);
            st.setString(7, "0"); // Assuming status is hard-coded as "offline"
            st.setString(8, phone);
            st.setString(9, formattedDob); // Use formattedDob if you changed the format

            st.executeUpdate();

        } catch (SQLException e) {
            System.err.println("Error executing insert: " + e.getMessage());
            // Có thể thêm code để xử lý lỗi cụ thể hoặc ghi log
        } catch (DateTimeParseException e) {
            System.err.println("Invalid date format: " + e.getMessage());
            // Xử lý lỗi khi định dạng ngày tháng nhập vào không hợp lệ
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Customers getUserInfor(String email) {
        String sql = "select * from Customers where Email=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Customers(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(7), rs.getString(6), rs.getString(8), rs.getString(9), rs.getString(10));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;

    }
    
    public Customers login(String username, String password) {
        String sql = "select * from Customers where Username=? and Password=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                String email = rs.getString("Email");
                return new Customers(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(7), rs.getString(6), rs.getString(8), rs.getString(9), rs.getString(10));
            }

        } catch (Exception e) {
        }
        return null;
    }

    
    public static void main(String[] args) {
        DAO d = new DAO();
        System.out.println(d.login("quangtnv", "123"));
        
    }

}
