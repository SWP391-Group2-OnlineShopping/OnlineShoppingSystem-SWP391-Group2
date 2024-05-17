/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Format;

import java.text.DecimalFormat;

/**
 *
 * @author admin
 */
public class CurrencyFormatter {
    
    public static String formatCurrency(float amount) {
        DecimalFormat formatter = new DecimalFormat("#,###");
        return formatter.format(amount) + "₫";
    }
}
