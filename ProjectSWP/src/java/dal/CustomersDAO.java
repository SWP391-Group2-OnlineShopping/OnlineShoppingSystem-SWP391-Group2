/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import model.Customers;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author LENOVO
 */
public class CustomersDAO extends DBContext {

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

    private String hashMd5(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(input.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : messageDigest) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    public void signup(String user, String pass, String phone, String email, String address, String fullname,
            String gender, String dob) {
        String sql = "INSERT INTO Customers (Username, Password, Email, Gender, Address, FullName, Status, Mobile, DOB) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            String password = hashMd5(pass);

            // Convert gender to integer
            int genderInt = "Female".equalsIgnoreCase(gender) ? 0 : "Male".equalsIgnoreCase(gender) ? 1 : -1;

            if (genderInt == -1) {
                throw new IllegalArgumentException("Invalid gender value: " + gender);
            }

            // Set parameters
            st.setString(1, user);
            st.setString(2, password);
            st.setString(3, email);
            st.setInt(4, genderInt);
            st.setString(5, address);
            st.setString(6, fullname);
            st.setString(7, "0"); // Assuming status is hard-coded as "offline"
            st.setString(8, phone);
            st.setString(9, dob); // Use formattedDob for the date

            st.executeUpdate();
            System.out.println("Insert thành công");

        } catch (SQLException e) {
            System.err.println("Error executing insert: " + e.getMessage());
            // Có thể thêm code để xử lý lỗi cụ thể hoặc ghi log
        } catch (DateTimeParseException e) {
            System.err.println("Invalid date format: " + e.getMessage());
            // Xử lý lỗi khi định dạng ngày tháng nhập vào không hợp lệ
        } catch (IllegalArgumentException e) {
            System.err.println(e.getMessage());
            // Xử lý lỗi khi giá trị gender không hợp lệ
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
            if (rs.next()) {
                return new Customers(
                        rs.getInt("CustomerID"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("Email"),
                        rs.getBoolean("Gender"),
                        rs.getString("Address"),
                        rs.getString("FullName"),
                        rs.getBoolean("Status"),
                        rs.getString("Mobile"),
                        rs.getDate("DOB")
                );
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
                return new Customers(
                        rs.getInt("CustomerID"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("Email"),
                        rs.getBoolean("Gender"),
                        rs.getString("Address"),
                        rs.getString("FullName"),
                        rs.getBoolean("Status"),
                        rs.getString("Mobile"),
                        rs.getDate("DOB")
                );
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public ArrayList<Customers> GetAllCustomer() {
        ArrayList<Customers> list = new ArrayList<>();
        try {
            String sql = "select * from Customers";
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Customers c = new Customers();
                c.setCustomer_id(rs.getInt(1));
                c.setUser_name(rs.getString(2));
                c.setPass_word(rs.getString(3));
                c.setEmail(rs.getString(4));
                c.setGender(rs.getBoolean(5));
                c.setAddress(rs.getString(6));
                c.setFull_name(rs.getString(7));
                c.setStatus(rs.getBoolean(8));
                c.setPhone_number(rs.getString(9));
                c.setDob(rs.getDate(10));
                list.add(c);
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public void UpdateCustomer(Customers customer) {
        try {
            String sql = "UPDATE Customers SET Fullname = ?, [Address] = ?, Mobile = ?, Gender = ? WHERE CustomerID = ?";
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, customer.getFull_name());
            ps.setString(2, customer.getAddress());
            ps.setString(3, customer.getPhone_number());
            ps.setBoolean(4, customer.getGender());
            ps.setInt(5, customer.getCustomer_id());
            ps.executeUpdate();

            ps.close();

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public Customers GetCustomerByID(int id) {
        Customers c = null;
        try {
            String sql = "SELECT * FROM Customers WHERE CustomerID = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                c = new Customers();
                c.setCustomer_id(rs.getInt(1));
                c.setUser_name(rs.getString(2));
                c.setPass_word(rs.getString(3));
                c.setEmail(rs.getString(4));
                c.setGender(rs.getBoolean(5));
                c.setAddress(rs.getString(6));
                c.setFull_name(rs.getString(7));
                c.setStatus(rs.getBoolean(8));
                c.setPhone_number(rs.getString(9));
                c.setDob(rs.getDate(10));
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return c;
    }

    

    public void changePass(String email, String newpass) {
        String passHash = hashMd5(newpass);
        
        String sql = "UPDATE Customers SET Password = ? WHERE Email = ? ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, passHash);
            st.setString(2, email);
            st.executeUpdate();

        } catch (Exception e) {
        }
    }
    public String getPasswordByCustomerName(String CustomerName){
        String sql = "	select Password FROM Customers WHERE Username=? ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, CustomerName);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
        }
        return null;
}
    
    
    
    public void changePassByCustomerName(String newpass,String CustomerID) {
        String passHash = hashMd5(newpass);
        
        String sql = "UPDATE Customers SET Password = ? WHERE Username = ? ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, newpass);
            st.setString(2, CustomerID);
            st.executeUpdate();

        } catch (Exception e) {
        }
    }
    
    
public static void main(String[] args) {
        CustomersDAO d = new CustomersDAO();
        String pass = d.getPasswordByCustomerName("quangtnv");
        System.out.println(pass);
    }
}
