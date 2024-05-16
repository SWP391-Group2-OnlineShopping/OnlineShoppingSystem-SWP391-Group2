/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.Customers;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

/**
 *
 * @author dumspicy
 */
public class CustomerDAO extends DBContext {

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

    public static void main(String[] args) {
        CustomerDAO cDAO = new CustomerDAO();
        Customers c = cDAO.GetCustomerByID(1);
        ArrayList < Customers > list = cDAO.GetAllCustomer();
        System.out.println(c);
    }
}
