package com.vnpay.common;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Customers;
import model.Email;
import model.Products;

/**
 *
 * @author CTT VNPAY
 */
public class Config  {

//    private int expirationTimeMinutes;
//
//    @Override
//    public void init(ServletConfig config) throws ServletException {
//        super.init(config);
//        // Lấy giá trị thời gian hết hạn từ tham số ngữ cảnh trong web.xml
//        String expirationTimeParam = config.getServletContext().getInitParameter("verifyLinkExpirationConfirmTime");
//        expirationTimeMinutes = Integer.parseInt(expirationTimeParam);
//    }
//
//    public void sendEmail(HttpSession session, HttpServletResponse response)
//            throws ServletException, IOException {
//        Customers customers = (Customers) session.getAttribute("acc");
//        Email e = new Email();
//        long expirationTimeMillis = System.currentTimeMillis() + (expirationTimeMinutes * 60 * 1000);
//
//        String verifyLink = "" + expirationTimeMillis; // Thay đổi URL theo link xác nhận của bạn
//
//        String emailContent = "<!DOCTYPE html>\n"
//                + "<html>\n"
//                + "<head>\n"
//                + "    <style>\n"
//                + "        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }\n"
//                + "        .email-container { max-width: 800px; margin: 40px auto; background-color: #ffffff; padding: 20px; border: 1px solid #dddddd; border-radius: 10px; }\n"
//                + "        .header { text-align: center; padding: 10px 0; background-color: #ce4b40; border-radius: 10px 10px 0 0; color: #ffffff; font-size: 24px; font-weight: bold; }\n"
//                + "        .header img { height: 50px; }\n"
//                + "        .header-icon { margin: 20px 0; }\n"
//                + "        .header-icon img { height: 50px; }\n"
//                + "        .content { padding: 20px; text-align: center; }\n"
//                + "        .content h1 { color: #333333; }\n"
//                + "        .content p { font-size: 16px; line-height: 1.5; color: #555555; }\n"
//                + "        .verify-button { display: inline-block; margin: 20px 0; padding: 15px 30px; font-size: 16px; color: #ffffff; background-color: #ce4b40; border-radius: 5px; text-decoration: none; }\n"
//                + "        .footer { text-align: center; padding: 20px; font-size: 14px; color: #aaaaaa; }\n"
//                + "        .footer p { margin: 5px 0; }\n"
//                + "        .footer a { color: #ce4b40; text-decoration: none; }\n"
//                + "        .product-list { width: 100%; border-collapse: collapse; }\n"
//                + "        .product-list th, .product-list td { border: 1px solid #ddd; padding: 8px; text-align: left; }\n"
//                + "        .product-list th { background-color: #f2f2f2; }\n"
//                + "        .product-list img { max-width: 100px; height: auto; display: block; margin: auto; }\n"
//                + "        .product-item { background-color: #f9f9f9; }\n"
//                + "    </style>\n"
//                + "</head>\n"
//                + "<body>\n"
//                + "    <div class=\"email-container\">\n"
//                + "        <div class=\"header\">\n"
//                + "            DiLuri<span>.</span>\n"
//                + "            <div class=\"header-icon\"><img src=\" alt=\"Email Icon\"></div>\n"
//                + "        </div>\n"
//                + "        <div class=\"content\">\n"
//                + "            <h1>Confirmation Order</h1>\n"
//                + "            <p>Please check your product and confirm by clicking the button below to complete your order. The link expires in " + expirationTimeMinutes + " minutes.</p>\n"
//                + "            <h1 class=\"h3 mb-3\">Order Confirmation</h1>\n"
//                + "            <a style=\"color: white\" href=\"" + verifyLink + "\" class=\"verify-button\">Confirm Order</a>\n"
//                + "        </div>\n"
//                + "        <div class=\"footer\">\n"
//                + "            <p>FPT University, Hoa Lac, Ha Noi</p>\n"
//                + "            <p><a href=\"#\">Privacy Policy</a> | <a href=\"#\">Contact Details</a></p>\n"
//                + "        </div>\n"
//                + "    </div>\n"
//                + "</body>\n"
//                + "</html>";
//
//        e.sendEmail(customers.getEmail(), "Verify your email", emailContent);
//    }

    public static String vnp_PayUrl = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    public static String vnp_ReturnUrl = "http://localhost:9999/ProjectSWP/confirmordersuccess.jsp";
    public static String vnp_TmnCode = "GC2VXZPD";
    public static String secretKey = "3HJXFZWRU9K651BILH9KGR3U38Q5RZ16";
    public static String vnp_ApiUrl = "https://sandbox.vnpayment.vn/merchant_webapi/api/transaction";

    public static String md5(String message) {
        String digest = null;
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hash = md.digest(message.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder(2 * hash.length);
            for (byte b : hash) {
                sb.append(String.format("%02x", b & 0xff));
            }
            digest = sb.toString();
        } catch (UnsupportedEncodingException ex) {
            digest = "";
        } catch (NoSuchAlgorithmException ex) {
            digest = "";
        }
        return digest;
    }

    public static String Sha256(String message) {
        String digest = null;
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(message.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder(2 * hash.length);
            for (byte b : hash) {
                sb.append(String.format("%02x", b & 0xff));
            }
            digest = sb.toString();
        } catch (UnsupportedEncodingException ex) {
            digest = "";
        } catch (NoSuchAlgorithmException ex) {
            digest = "";
        }
        return digest;
    }

    //Util for VNPAY
    public static String hashAllFields(Map fields) {
        List fieldNames = new ArrayList(fields.keySet());
        Collections.sort(fieldNames);
        StringBuilder sb = new StringBuilder();
        Iterator itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = (String) itr.next();
            String fieldValue = (String) fields.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                sb.append(fieldName);
                sb.append("=");
                sb.append(fieldValue);
            }
            if (itr.hasNext()) {
                sb.append("&");
            }
        }
        return hmacSHA512(secretKey, sb.toString());
    }

    public static String hmacSHA512(final String key, final String data) {
        try {

            if (key == null || data == null) {
                throw new NullPointerException();
            }
            final Mac hmac512 = Mac.getInstance("HmacSHA512");
            byte[] hmacKeyBytes = key.getBytes();
            final SecretKeySpec secretKey = new SecretKeySpec(hmacKeyBytes, "HmacSHA512");
            hmac512.init(secretKey);
            byte[] dataBytes = data.getBytes(StandardCharsets.UTF_8);
            byte[] result = hmac512.doFinal(dataBytes);
            StringBuilder sb = new StringBuilder(2 * result.length);
            for (byte b : result) {
                sb.append(String.format("%02x", b & 0xff));
            }
            return sb.toString();

        } catch (Exception ex) {
            return "";
        }
    }

    public static String getIpAddress(HttpServletRequest request) {
        String ipAdress;
        try {
            ipAdress = request.getHeader("X-FORWARDED-FOR");
            if (ipAdress == null) {
                ipAdress = request.getRemoteAddr();
            }
        } catch (Exception e) {
            ipAdress = "Invalid IP:" + e.getMessage();
        }
        return ipAdress;
    }

    public static String getRandomNumber(int len) {
        Random rnd = new Random();
        String chars = "0123456789";
        StringBuilder sb = new StringBuilder(len);
        for (int i = 0; i < len; i++) {
            sb.append(chars.charAt(rnd.nextInt(chars.length())));
        }
        return sb.toString();
    }
}
