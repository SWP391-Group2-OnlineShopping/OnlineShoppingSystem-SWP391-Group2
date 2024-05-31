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

    public int isVerified(String email) {
        String query = "SELECT [Status] FROM Customers WHERE email = ?";

        try (PreparedStatement st = connection.prepareStatement(query)) {

            // Set parameters
            st.setString(1, email);

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("Status");
            }

        } catch (SQLException e) {
            System.err.println(e);
            // Có thể thêm code để xử lý lỗi cụ thể hoặc ghi log
        }
        return 0;
    }

    public void signup(String user, String pass, String phone, String email, String address, String fullname,
            String gender, String dob) {
        LocalDate curDate = java.time.LocalDate.now();
        String date = curDate.toString();

        String sql = "INSERT INTO Customers (Username, Password, Email, Gender, Address, FullName, Status, Mobile, DOB, Avatar, CreatedDate) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

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
            st.setString(7, "1");
            st.setString(8, phone);
            st.setString(9, dob);
            st.setString(10, "https://static-00.iconduck.com/assets.00/avatar-default-symbolic-icon-479x512-n8sg74wg.png");
            st.setString(11, date);

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
                        rs.getString("Status"),
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
                        rs.getString("Status"),
                        rs.getString("Mobile"),
                        rs.getDate("DOB")
                );
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public ArrayList<Customers> GetAllCustomersMKTByStatus(String status) {
        ArrayList<Customers> list = new ArrayList<>();
        try {
            String sql = "select * from Customers where Status = ?";

            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, Integer.parseInt(status)); // Chuyển đổi `status` từ `String` sang `int`
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Customers c = new Customers();
                c.setCustomer_id(rs.getInt("CustomerID"));
                c.setUser_name(rs.getString("Username"));
                c.setPass_word(rs.getString("Password"));
                c.setEmail(rs.getString("Email"));
                c.setGender(rs.getBoolean("Gender"));
                c.setAddress(rs.getString("Address"));
                c.setFull_name(rs.getString("FullName"));
                c.setStatus(rs.getString("Status"));
                c.setPhone_number(rs.getString("Mobile"));
                c.setDob(rs.getDate("DOB"));
                c.setAvatar(rs.getString("Avatar"));
                c.setCreated_date(rs.getString("CreatedDate"));
                list.add(c);
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            System.out.println("Error retrieving data: " + e.getMessage());
        }
        return list;
    }

    public ArrayList<Customers> GetAllCustomersMKTByStatusAndInformation(String status, String fullname, String email, String mobile, String address) {
        ArrayList<Customers> list = new ArrayList<>();
        try {
            // Câu truy vấn SQL
            String sql = "SELECT * FROM Customers WHERE Status = ? AND (FullName LIKE ? OR Email LIKE ? OR Mobile LIKE ? OR Address LIKE ?)";

            // Chuẩn bị câu lệnh
            PreparedStatement st = connection.prepareStatement(sql);
            // Thiết lập tham số cho câu truy vấn
            st.setString(1, status);
            st.setString(2, "%" + fullname + "%");
            st.setString(3, "%" + email + "%");
            st.setString(4, "%" + mobile + "%");
            st.setString(5, "%" + address + "%");

            // Thực thi câu truy vấn
            ResultSet rs = st.executeQuery();
            // Xử lý kết quả truy vấn
            while (rs.next()) {
                Customers c = new Customers();
                c.setCustomer_id(rs.getInt("CustomerID"));
                c.setUser_name(rs.getString("Username"));
                c.setPass_word(rs.getString("Password"));
                c.setEmail(rs.getString("Email"));
                c.setGender(rs.getBoolean("Gender"));
                c.setAddress(rs.getString("Address"));
                c.setFull_name(rs.getString("FullName"));
                c.setStatus(rs.getString("Status"));
                c.setPhone_number(rs.getString("Mobile"));
                c.setDob(rs.getDate("DOB"));
                c.setAvatar(rs.getString("Avatar"));
                c.setCreated_date(rs.getString("CreatedDate"));
                list.add(c);
            }
            // Đóng kết nối
            rs.close();
            st.close();
        } catch (SQLException e) {
            System.out.println("Error retrieving data: " + e.getMessage());
        }
        return list;
    }

    public ArrayList<Customers> GetAllCustomersMKTByInformation(String fullname, String email, String mobile, String address) {
        ArrayList<Customers> list = new ArrayList<>();
        try {
            // Câu truy vấn SQL
            String sql = "SELECT * FROM Customers WHERE FullName LIKE ? OR Email LIKE ? OR Mobile LIKE ? OR Address LIKE ?";

            // Chuẩn bị câu lệnh
            PreparedStatement st = connection.prepareStatement(sql);
            // Thiết lập tham số cho câu truy vấn
            st.setString(1, "%" + fullname + "%");
            st.setString(2, "%" + email + "%");
            st.setString(3, "%" + mobile + "%");
            st.setString(4, "%" + address + "%");
            // Thực thi câu truy vấn
            ResultSet rs = st.executeQuery();
            // Xử lý kết quả truy vấn
            while (rs.next()) {
                Customers c = new Customers();
                c.setCustomer_id(rs.getInt("CustomerID"));
                c.setUser_name(rs.getString("Username"));
                c.setPass_word(rs.getString("Password"));
                c.setEmail(rs.getString("Email"));
                c.setGender(rs.getBoolean("Gender"));
                c.setAddress(rs.getString("Address"));
                c.setFull_name(rs.getString("FullName"));
                c.setStatus(rs.getString("Status"));
                c.setPhone_number(rs.getString("Mobile"));
                c.setDob(rs.getDate("DOB"));
                c.setAvatar(rs.getString("Avatar"));
                c.setCreated_date(rs.getString("CreatedDate"));
                list.add(c);
            }
            // Đóng kết nối
            rs.close();
            st.close();
        } catch (SQLException e) {
            System.out.println("Error retrieving data: " + e.getMessage());
        }
        return list;
    }

    public ArrayList<Customers> GetAllCustomersMKT() {
        ArrayList<Customers> list = new ArrayList<>();
        try {
            String sql = "select * from Customers";
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Customers c = new Customers();
                c.setCustomer_id(rs.getInt("CustomerID"));
                c.setUser_name(rs.getString("Username"));
                c.setPass_word(rs.getString("Password"));
                c.setEmail(rs.getString("Email"));
                c.setGender(rs.getBoolean("Gender"));
                c.setAddress(rs.getString("Address"));
                c.setFull_name(rs.getString("FullName"));
                c.setStatus(rs.getString("Status"));
                c.setPhone_number(rs.getString("Mobile"));
                c.setDob(rs.getDate("DOB"));
                c.setAvatar(rs.getString("Avatar"));
                c.setCreated_date(rs.getString("CreatedDate"));
                list.add(c);
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            System.out.println("Error retrieving data: " + e.getMessage());
        }
        return list;
    }

    public ArrayList<Customers> SortAllCustomersMKTByFieldGenderAndInformation(String field, String order, boolean gender, String status, String name, String email, String phone, String address) {
        ArrayList<Customers> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Customers WHERE Gender = ? AND Status = ? AND (FullName LIKE ? OR Email LIKE ? OR Mobile LIKE ? OR Address LIKE ?) ORDER BY " + field + " " + order;
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setBoolean(1, gender);
            ps.setString(2, status);
            ps.setString(3, "%" + name + "%");
            ps.setString(4, "%" + email + "%");
            ps.setString(5, "%" + phone + "%");
            ps.setString(6, "%" + address + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customers c = new Customers();
                c.setCustomer_id(rs.getInt("CustomerID"));
                c.setUser_name(rs.getString("Username"));
                c.setPass_word(rs.getString("Password"));
                c.setEmail(rs.getString("Email"));
                c.setGender(rs.getBoolean("Gender"));
                c.setAddress(rs.getString("Address"));
                c.setFull_name(rs.getString("FullName"));
                c.setStatus(rs.getString("Status"));
                c.setPhone_number(rs.getString("Mobile"));
                c.setDob(rs.getDate("DOB"));
                c.setAvatar(rs.getString("Avatar"));
                c.setCreated_date(rs.getString("CreatedDate"));
                list.add(c);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            System.out.println("Error retrieving data: " + e.getMessage());
        }
        return list;
    }

    public ArrayList<Customers> SortAllCustomersMKTByFieldGenderAndInformation(String field, String order, boolean gender, String name, String email, String phone, String address) {
        ArrayList<Customers> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Customers WHERE Gender = ? AND (FullName LIKE ? OR Email LIKE ? OR Mobile LIKE ? OR Address LIKE ?) ORDER BY " + field + " " + order;
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setBoolean(1, gender);
            ps.setString(2, "%" + name + "%");
            ps.setString(3, "%" + email + "%");
            ps.setString(4, "%" + phone + "%");
            ps.setString(5, "%" + address + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customers c = new Customers();
                c.setCustomer_id(rs.getInt("CustomerID"));
                c.setUser_name(rs.getString("Username"));
                c.setPass_word(rs.getString("Password"));
                c.setEmail(rs.getString("Email"));
                c.setGender(rs.getBoolean("Gender"));
                c.setAddress(rs.getString("Address"));
                c.setFull_name(rs.getString("FullName"));
                c.setStatus(rs.getString("Status"));
                c.setPhone_number(rs.getString("Mobile"));
                c.setDob(rs.getDate("DOB"));
                c.setAvatar(rs.getString("Avatar"));
                c.setCreated_date(rs.getString("CreatedDate"));
                list.add(c);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            System.out.println("Error retrieving data: " + e.getMessage());
        }
        return list;
    }

    public ArrayList<Customers> SortAllCustomersMKTByFieldStatusGenderAndInformation(String field, String order, String status, boolean gender, String name, String email, String phone, String address) {
        ArrayList<Customers> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Customers WHERE Status = ? AND Gender = ? AND (FullName LIKE ? OR Email LIKE ? OR Mobile LIKE ? OR Address LIKE ?) ORDER BY " + field + " " + order;
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, status);
            ps.setBoolean(2, gender);
            ps.setString(3, "%" + name + "%");
            ps.setString(4, "%" + email + "%");
            ps.setString(5, "%" + phone + "%");
            ps.setString(6, "%" + address + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customers c = new Customers();
                c.setCustomer_id(rs.getInt("CustomerID"));
                c.setUser_name(rs.getString("Username"));
                c.setPass_word(rs.getString("Password"));
                c.setEmail(rs.getString("Email"));
                c.setGender(rs.getBoolean("Gender"));
                c.setAddress(rs.getString("Address"));
                c.setFull_name(rs.getString("FullName"));
                c.setStatus(rs.getString("Status"));
                c.setPhone_number(rs.getString("Mobile"));
                c.setDob(rs.getDate("DOB"));
                c.setAvatar(rs.getString("Avatar"));
                c.setCreated_date(rs.getString("CreatedDate"));
                list.add(c);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            System.out.println("Error retrieving data: " + e.getMessage());
        }
        return list;
    }

    public ArrayList<Customers> SortAllCustomersMKTByField(String field, String order) {
        ArrayList<Customers> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Customers ORDER BY " + field + " " + order;
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Customers c = new Customers();
                c.setCustomer_id(rs.getInt("CustomerID"));
                c.setUser_name(rs.getString("Username"));
                c.setPass_word(rs.getString("Password"));
                c.setEmail(rs.getString("Email"));
                c.setGender(rs.getBoolean("Gender"));
                c.setAddress(rs.getString("Address"));
                c.setFull_name(rs.getString("FullName"));
                c.setStatus(rs.getString("Status"));
                c.setPhone_number(rs.getString("Mobile"));
                c.setDob(rs.getDate("DOB"));
                c.setAvatar(rs.getString("Avatar"));
                c.setCreated_date(rs.getString("CreatedDate"));
                list.add(c);
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            System.out.println("Error retrieving data: " + e.getMessage());
        }
        return list;
    }

    public ArrayList<Customers> SortAllCustomersMKTByFieldAndInformation(String field, String order, String name, String email, String phone, String address) {
        ArrayList<Customers> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Customers WHERE FullName LIKE ? OR Email LIKE ? OR Mobile LIKE ? OR Address LIKE ? ORDER BY " + field + " " + order;
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + name + "%");
            ps.setString(2, "%" + email + "%");
            ps.setString(3, "%" + phone + "%");
            ps.setString(4, "%" + address + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customers c = new Customers();
                c.setCustomer_id(rs.getInt("CustomerID"));
                c.setUser_name(rs.getString("Username"));
                c.setPass_word(rs.getString("Password"));
                c.setEmail(rs.getString("Email"));
                c.setGender(rs.getBoolean("Gender"));
                c.setAddress(rs.getString("Address"));
                c.setFull_name(rs.getString("FullName"));
                c.setStatus(rs.getString("Status"));
                c.setPhone_number(rs.getString("Mobile"));
                c.setDob(rs.getDate("DOB"));
                c.setAvatar(rs.getString("Avatar"));
                c.setCreated_date(rs.getString("CreatedDate"));
                list.add(c);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            System.out.println("Error retrieving data: " + e.getMessage());
        }
        return list;
    }

    public ArrayList<Customers> SortAllCustomersMKTByFieldStatusAndInformation(String field, String order, String status, String name, String email, String phone, String address) {
        ArrayList<Customers> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Customers WHERE Status = ? AND (FullName LIKE ? OR Email LIKE ? OR Mobile LIKE ? OR Address LIKE ?) ORDER BY " + field + " " + order;
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, status);
            ps.setString(2, "%" + name + "%");
            ps.setString(3, "%" + email + "%");
            ps.setString(4, "%" + phone + "%");
            ps.setString(5, "%" + address + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customers c = new Customers();
                c.setCustomer_id(rs.getInt("CustomerID"));
                c.setUser_name(rs.getString("Username"));
                c.setPass_word(rs.getString("Password"));
                c.setEmail(rs.getString("Email"));
                c.setGender(rs.getBoolean("Gender"));
                c.setAddress(rs.getString("Address"));
                c.setFull_name(rs.getString("FullName"));
                c.setStatus(rs.getString("Status"));
                c.setPhone_number(rs.getString("Mobile"));
                c.setDob(rs.getDate("DOB"));
                c.setAvatar(rs.getString("Avatar"));
                c.setCreated_date(rs.getString("CreatedDate"));
                list.add(c);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            System.out.println("Error retrieving data: " + e.getMessage());
        }
        return list;
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
                c.setStatus(rs.getString(8));
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

    public boolean UpdateCustomer(int customerId, String fullName, String address, String mobile, boolean gender, String avatarPath) {
        String sql = "UPDATE Customers SET Fullname = ?, [Address] = ?, Mobile = ?, Gender = ?";
        if (avatarPath != null && !avatarPath.isEmpty()) {
            sql += ", Avatar = ?";
        }
        sql += " WHERE CustomerID = ?";
        boolean rowUpdated = false;

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, fullName);
            ps.setString(2, address);
            ps.setString(3, mobile);
            ps.setBoolean(4, gender);
            if (avatarPath != null && !avatarPath.isEmpty()) {
                ps.setString(5, avatarPath);
                ps.setInt(6, customerId);
            } else {
                ps.setInt(5, customerId);
            }
            rowUpdated = ps.executeUpdate() > 0;

            ps.close();

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return rowUpdated;
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
                c.setStatus(rs.getString(8));
                c.setPhone_number(rs.getString(9));
                c.setDob(rs.getDate(10));
                c.setAvatar(rs.getString(11));
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

    public String getPasswordByCustomerName(String CustomerName) {
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

    public void changePassByCustomerName(String newpass, String CustomerID) {
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

//    public static void main(String[] args) {
//        CustomersDAO d = new CustomersDAO();
//        ArrayList<Customers> list = d.SortAllCustomersMKTByMobile("Z-A");
//        for (Customers c : list) {
//            System.out.println(c);
//        }
//////        System.out.println( d.isVerified("namanhnguyen2605@gmail.com"));
//
//    }
}
