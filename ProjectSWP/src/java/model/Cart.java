/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

/**
 *
 * @author dumspicy
 */
public class Cart {

    private List<CartItem> items;

    public Cart() {
        items = new ArrayList<>();
    }

    public Cart(ArrayList<CartItem> items) {
        this.items = items;
    }

    public List<CartItem> getItems() {
        return items;
    }

    public void setItems(List<CartItem> items) {
        this.items = items;
    }

    public CartItem GetProductByIdAndSize(int productId, int size) {
        for (CartItem item : items) {
            if (item.getProduct().getProductID() == productId && item.getSize() == size) {
                return item;
            }
        }
        return null;
    }

    public int GetQuantity(int productId, int size) {
        CartItem item = GetProductByIdAndSize(productId, size);
        return item != null ? item.getQuantity() : 0;
    }

    public void AddItem(CartItem item) {
        if (GetProductByIdAndSize(item.getProduct().getProductID(), item.getSize()) != null) {
            CartItem newItem = GetProductByIdAndSize(item.getProduct().getProductID(), item.getSize());
            newItem.setQuantity(item.getQuantity() + newItem.getQuantity());
        } else {
            items.add(item);
        }
    }

    public void DeleteItem(int productID, int size) {
        CartItem itemToRemove = GetProductByIdAndSize(productID, size);
        if(itemToRemove != null) {
            items.remove(itemToRemove);
        }
    }
    public double GetTotalPrice() {
        double total = 0;
        for (CartItem items : items) {
            total += (items.getQuantity() * items.getProduct().getSalePrice());
        }
        return total;
    }
    
    public static void main(String[] args) {
        Cart cart = new Cart();
    }
}
