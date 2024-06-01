/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import model.CustomerInformation;
import model.Customers;

/**
 *
 * @author LENOVO
 */
public class CustomerInforDAO extends DBContext {

    public ArrayList<CustomerInformation> GetAllHistoryInforCustomer() {
        ArrayList<CustomerInformation> list = new ArrayList<>();
        try {
            String sql = "select * from CustomerInformation";
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                CustomerInformation c = new CustomerInformation();
                c.setCustomerInforID(rs.getInt(1));
                c.setCustomerID(rs.getInt(2));
                c.setFullName(rs.getString(3));
                c.setAddress(rs.getString(4));
                c.setMobile(rs.getString(5));
                c.setEmail(rs.getString(6));
                c.setGender(rs.getBoolean(7));
                c.setAvatar(rs.getString(8));
                c.setChangeDate(rs.getString(9));
                list.add(c);
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public boolean SaveOldCustomerInformation(Customers customer) {
        LocalDate curDate = java.time.LocalDate.now();
        String date = curDate.toString();
        String sql = "INSERT INTO CustomerInformation (CustomerID, FullName, Address, Mobile, Email, Gender, Avatar, ChangeDate) \n"
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement st = connection.prepareStatement(sql)) {

            st.setInt(1, customer.getCustomer_id());
            st.setString(2, customer.getFull_name());
            st.setString(3, customer.getAddress());
            st.setString(4, customer.getPhone_number());
            st.setString(5, customer.getEmail());
            st.setBoolean(6, customer.getGender());
            st.setString(7, customer.getAvatar());
            st.setString(8, date);

            int result = st.executeUpdate();
            return result > 0;

        } catch (SQLException e) {
            System.err.println("Error executing insert: " + e.getMessage());
            // Có thể thêm code để xử lý lỗi cụ thể hoặc ghi log
        }
        return false;
    }

    public ArrayList<CustomerInformation> GetCustomerHistoryByID(int id) {
        ArrayList<CustomerInformation> list = new ArrayList<>();
        try {
            String sql = "select * from CustomerInformation where CustomerID = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                CustomerInformation c = new CustomerInformation();
                c.setCustomerInforID(rs.getInt(1));
                c.setCustomerID(rs.getInt(2));
                c.setFullName(rs.getString(3));
                c.setAddress(rs.getString(4));
                c.setMobile(rs.getString(5));
                c.setEmail(rs.getString(6));
                c.setGender(rs.getBoolean(7));
                c.setAvatar(rs.getString(8));
                c.setChangeDate(rs.getString(9));
                list.add(c);
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public static void main(String[] args) {
        CustomerInforDAO d = new CustomerInforDAO();
        ArrayList<CustomerInformation> list = d.GetCustomerHistoryByID(21);
        for (CustomerInformation c : list) {
            System.out.println(c);
        }
//        System.out.println(d.GetCustomerHistoryByID(21));

    }
}
