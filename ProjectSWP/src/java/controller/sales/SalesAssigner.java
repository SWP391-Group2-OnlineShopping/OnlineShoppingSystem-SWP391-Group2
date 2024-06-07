/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.sales;

/**
 *
 * @author LENOVO
 */
import model.Staffs;

import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

public class SalesAssigner {

    private static final ConcurrentHashMap<String, AtomicInteger> indices = new ConcurrentHashMap<>();

    public static Staffs getNextSales(List<Staffs> salesList, String method) {
        if (salesList.isEmpty()) {
            throw new IllegalArgumentException("Sales list cannot be empty");
        }

        indices.putIfAbsent(method, new AtomicInteger(0));
        int currentIndex = indices.get(method).getAndIncrement() % salesList.size();

        return salesList.get(currentIndex);
    }
}
