/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Statement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Product;

/**
 *
 * @author dumspicy
 */
public class ProductDAO extends DBContext{
    public ArrayList<Product> GetAllProduct(){
        ArrayList<Product> list = new ArrayList<>();
        try{
            String sql = "select * from Product";
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while(rs.next()){
                Product p = new Product();
                p.setProductId(rs.getInt(1));
                p.setTitle(rs.getString(2));
                p.setSalePrice(rs.getFloat(3));
                p.setListPrice(rs.getFloat(4));
                p.setDescription(rs.getString(5));
                p.setBriefInformation(rs.getString(6));
                p.setQuantities(rs.getInt(7));
                p.setThumbnail(rs.getInt(8));
                p.setLastDateUpdate(rs.getDate(9));
                list.add(p);
            }
            rs.close();
            st.close();
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return list;
    }
}
