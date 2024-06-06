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
import java.util.List;
import model.CartItem;
import model.Products;
import model.ReceiverInformation;

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

    public void createCart(int customerID) {
        String sql = "INSERT INTO Carts VALUES (?, ?) ";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            // Set parameters
            st.setInt(1, customerID);
            st.setDouble(2, 0);
            st.executeUpdate();
        } catch (Exception e) {
        }
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

    public List<CartItem> getCart(int customerID) {
        List<CartItem> list = new ArrayList<>();
        String sql = "select CartID from Carts where CustomerID =?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, customerID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int cart_id = rs.getInt(1);
                String sql1 = "select pcs.ProductCSID, cd.Quantities,cd.TotalPrice, pcs.Size,p.*,i.Link AS ThumbnailLink\n"
                        + "                        from Cart_Detail cd \n"
                        + "                        join Product_CS pcs on cd.ProductCSID=pcs.ProductCSID \n"
                        + "						join Products p on p.ProductID = pcs.ProductID\n"
                        + "                        JOIN Images i ON p.Thumbnail = i.ImageID\n"
                        + "                                               where cd.CartID=?";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setInt(1, cart_id);
                ResultSet rs1 = st1.executeQuery();
                while (rs1.next()) {
                    list.add(new CartItem(new Products(
                            rs1.getInt("ProductID"),
                            rs1.getString("Title"),
                            rs1.getFloat("SalePrice"),
                            rs1.getFloat("ListPrice"),
                            rs1.getString("Description"),
                            rs1.getString("BriefInformation"),
                            rs1.getInt("Thumbnail"),
                            rs1.getDate("LastDateUpdate"),
                            rs1.getString("ThumbnailLink"),
                            rs1.getBoolean("Status"),
                            rs1.getBoolean("Feature")),
                            rs1.getInt(1), rs1.getInt(2), (int) rs1.getFloat(3), rs1.getInt(4)));
                }

            }

        } catch (Exception e) {
        }
        return list;
    }

    public void addToCart(int customerID, CartItem item) {
        String sql = "select CartID from Carts where CustomerID =?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, customerID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int cart_id = rs.getInt(1);

                String sql1 = "select * from Cart_Detail where ProductCSID=? and CartID=?";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setInt(1, item.getProduct().getProductCSID());
                st1.setInt(2, cart_id);
                ResultSet rs1 = st1.executeQuery();
                if (rs1.next()) {
                    String sql4 = "update Cart_Detail set Quantities+=? where ProductCSID=? and CartID=?  ";
                    PreparedStatement st4 = connection.prepareStatement(sql4);
                    st4.setInt(1, 1);
                    st4.setInt(2, item.getProduct().getProductCSID());
                    st4.setInt(3, cart_id);
                    st4.executeUpdate();
                } else {

                    String sql2 = "INSERT INTO Cart_Detail VALUES (?,?,?,?) ";
                    PreparedStatement st2 = connection.prepareStatement(sql2);
                    st2.setInt(1, cart_id);
                    st2.setInt(2, item.getProduct().getProductCSID());
                    st2.setInt(3, item.getQuantity());
                    st2.setDouble(4, (float) item.getPrice() * item.getQuantity());
                    st2.executeUpdate();
                }
                String sql3 = "update Carts set TotalCost+=? where CustomerID=?";
                PreparedStatement st3 = connection.prepareStatement(sql3);
                st3.setDouble(1, (float) item.getPrice() * item.getQuantity());
                st3.setInt(2, cart_id);
                st3.executeUpdate();

            }
        } catch (Exception e) {
        }
    }

    public void removeItem(int productCSID, float price, int customerID) {
        String sql3 = "select CartID from Carts where CustomerID=?";
        try {
            PreparedStatement st3 = connection.prepareStatement(sql3);
            st3.setInt(1, customerID);
            ResultSet rs3 = st3.executeQuery();
            if (rs3.next()) {
                int cart_id = rs3.getInt(1);
                String sql = "select Quantities From Cart_Detail where ProductCSID=? and CartID=?";
                PreparedStatement st = connection.prepareStatement(sql);
                st.setInt(1, productCSID);
                st.setInt(2, cart_id);
                ResultSet rs = st.executeQuery();
                if (rs.next()) {
                    int quantity = rs.getInt(1);

                    String sql1 = "delete from Cart_Detail where ProductCSID=? and CartID=? ";
                    PreparedStatement st1 = connection.prepareStatement(sql1);
                    st1.setInt(1, productCSID);
                    st1.setInt(2, cart_id);
                    st1.executeUpdate();

                    String sql2 = "update Carts set TotalCost-=? where CustomerID=?";
                    PreparedStatement st2 = connection.prepareStatement(sql2);
                    st2.setDouble(1,(double) (price * quantity));
                    st2.setInt(2, customerID);
                    st2.executeUpdate();
                }
            }
        } catch (Exception e) {
        }
    }

    public void decreaseItem(int productCSID, float price, int customerID) {
        String sql2 = "select CartID from Carts where CustomerID=?";
        try {
            PreparedStatement st2 = connection.prepareStatement(sql2);
            st2.setInt(1, customerID);
            ResultSet rs = st2.executeQuery();
            if (rs.next()) {
                int cart_id = rs.getInt(1);
                String sql = "update Cart_Detail set Quantities-=? where ProductCSID=? and CartID=?";
                PreparedStatement st = connection.prepareStatement(sql);
                st.setInt(1, 1);
                st.setInt(2, productCSID);
                st.setInt(3, cart_id);
                st.executeUpdate();

                String sql1 = "update Carts set TotalCost-=? where CustomerID=?";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setDouble(1,  (double)price);
                st1.setInt(2, customerID);
                st1.executeUpdate();
            }
        } catch (Exception e) {
        }
    }

    public void increaseItem(int productCSID, float price, int customerID) {
        String sql2 = "select CartID from Carts where CustomerID=?";
        try {
            PreparedStatement st2 = connection.prepareStatement(sql2);
            st2.setInt(1, customerID);
            ResultSet rs = st2.executeQuery();
            if (rs.next()) {
                int cart_id = rs.getInt(1);
                String sql = "update Cart_Detail set Quantities+=? where ProductCSID=? and CartID=?";
                PreparedStatement st = connection.prepareStatement(sql);
                st.setInt(1, 1);
                st.setInt(2, productCSID);
                st.setInt(3, cart_id);
                st.executeUpdate();

                String sql1 = "update Carts set TotalCost+=? where CustomerID=?";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setDouble(1,  (double)price);
                st1.setInt(2, customerID);
                st1.executeUpdate();
            }
        } catch (Exception e) {
        }
    }

    public void removeCartAfterOrder(int productCSID, float price, int customerID) {
        String sql2 = "select CartID from Carts where CustomerID=?";
        try {
            PreparedStatement st2 = connection.prepareStatement(sql2);
            st2.setInt(1, customerID);
            ResultSet rs = st2.executeQuery();
            if (rs.next()) {
                int cart_id = rs.getInt(1);
                String sql = "UPDATE cd\n"
                        + "SET cd.CartID = NULL\n"
                        + "FROM Cart_Detail cd\n"
                        + "JOIN Product_CS pcs ON pcs.ProductCSID = cd.ProductCSID\n"
                        + "WHERE cd.ProductCSID = ? AND cd.CartID = ?;";
                PreparedStatement st = connection.prepareStatement(sql);
                st.setInt(1, productCSID);
                st.setInt(2, cart_id);
                st.executeUpdate();

                String sql1 = "update Carts set TotalCost-=? where CustomerID=?";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setDouble(1, (double) price);
                st1.setInt(2, customerID);
                st1.executeUpdate();
            }
        } catch (Exception e) {
        }
    }
    
 

    public int checkQuantity(int customerID, int productCSID) {
        String sql = "select CartID from Carts where CustomerID=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, customerID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int cart_id = rs.getInt(1);
                String sql1 = "select Quantities from Cart_Detail where ProductCSID=? and CartID=?";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setInt(1, productCSID);
                st1.setInt(2, cart_id);
                ResultSet rs1 = st1.executeQuery();
                if (rs1.next()) {
                    int quantity = rs1.getInt(1);
                    return quantity;
                }

            }

        } catch (Exception e) {
        }
        return 0;
    }

    public float totalAmount(int customerID) {
        String sql = "select TotalCost from Carts where CustomerID=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, customerID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                float total = rs.getFloat(1);
                return total;
            }
        } catch (Exception e) {
        }
        return 0;
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

    public Customers getCustomerstByIDMKT(int customerID) {
        Customers c = null;
        String query = "select * from Customers where CustomerID = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, customerID);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
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
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return c;
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

    public ArrayList<ReceiverInformation> GetReceiverInforByCustomerID(int customerID) {
        ArrayList<ReceiverInformation> list = new ArrayList<>();
        try {
            String sql = "select * from Receiver_Information where customerId = ? ";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, customerID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ReceiverInformation r = new ReceiverInformation();
                r.setReceiverInforID(rs.getInt(1));
                r.setCustomerID(rs.getInt(2));
                r.setReceiverFullName(rs.getString(3));
                r.setPhoneNumber(rs.getString(4));
                r.setAddress(rs.getString(5));
                r.setAddressType(rs.getBoolean(6));

                list.add(r);
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            System.out.println("Error retrieving data: " + e.getMessage());
        }
        return list;
    }

    public void AddNewAddress(int customerID, String fullName, String phonenumber, String address, boolean addressType) {
        String sql = "INSERT INTO Receiver_Information (CustomerID, ReceiverFullName, PhoneNumber, Address, AddressType) VALUES (?, ?, ?, ?, ?);";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            // Set parameters
            st.setInt(1, customerID);
            st.setString(2, fullName);
            st.setString(3, phonenumber);
            st.setString(4, address);
            st.setBoolean(5, addressType);

            st.executeUpdate();
            System.out.println("Insert thành công");

        } catch (SQLException e) {
            System.err.println("Error executing insert: " + e.getMessage());
            // Có thể thêm code để xử lý lỗi cụ thể hoặc ghi log
        }
    }

    public int GetReceiverIDByNameAddressPhone(String fullName, String phonenumber, String address) {
        String sql = "select ReceiverInformationId from Receiver_Information\n"
                + "where ReceiverFullName = ? and PhoneNumber = ? and Address = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            // Set parameters
            st.setString(1, fullName);
            st.setString(2, phonenumber);
            st.setString(3, address);

            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("ReceiverInformationId");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error executing query: " + e.getMessage());
            // You can add more specific error handling or logging here
        }
        return -1; // Return -1 or any appropriate value if not found
    }

//    public static void main(String[] args) {
//        CustomersDAO d = new CustomersDAO();
////        ArrayList<ReceiverInformation> list = d.GetReceiverInforByCustomerID(3);
////        for (ReceiverInformation c : list) {
////            System.out.println(c);
////        }
//            d.AddNewAddress(3,"Trương Nguyễn Việt Quang", "0123456789", "Lào Cai", false);
//
////     System.out.println( d.GetReceiverIDByNameAddressPhone("Viet Quang", "0123456789", "Some Address"));
//    }
}
