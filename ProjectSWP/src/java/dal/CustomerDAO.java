/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.TimeZone;
import model.Customers;

/**
 *
 * @author PV
 */
public class CustomerDAO extends DBContext {

    public void createCart(int acid) {
        String sql = "INSERT INTO Carts VALUES (?, ?) ";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            // Set parameters
            st.setInt(1, acid);
            st.setDouble(2, 0);
            st.executeUpdate();
        } catch (Exception e) {
        }
    }

}
