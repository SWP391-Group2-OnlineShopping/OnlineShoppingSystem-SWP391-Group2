/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author dumspicy
 */
public class Cart {
    
    private List<CartItem> items;
    
    public Cart(){
        items = new ArrayList<>();
    }
    
    
    public Cart(ArrayList<CartItem> items){
        this.items = items;
    }

    public List<CartItem> getItems() {
        return items;
    }

    public void setItems(List<CartItem> items) {
        this.items = items;
    }
    
    
    public CartItem GetProductByIdAndSize(int productId, int size){
        for(CartItem item : items){
            if(item.getProduct().getProductID() == productId && item.getSize() == size){
                return item;
            }
        }
        return null;
    }
    
    public int GetQuantity(int productId, int size){
        return GetProductByIdAndSize(productId, size).getQuantity();
    }
    
    public void AddItem(CartItem item){
        if(GetProductByIdAndSize(item.getProduct().getProductID(), item.getSize()) != null){
            CartItem newItem = GetProductByIdAndSize(item.getProduct().getProductID(), item.getSize());
            newItem.setQuantity(item.getQuantity() + newItem.getQuantity());
        }
        else{
            items.add(item);
        }
    }
    
    public void DeleteItem(CartItem item){
       if(GetProductByIdAndSize(item.getProduct().getProductID(), item.getSize()) != null){
           items.remove(item);
       }
    }
    
    public double GetTotalPrice(CartItem item){
        double total = 0;
        for(CartItem items : items){
            total += (items.getQuantity() * item.getProduct().getSalePrice());
        }
        return total;
    }
}
