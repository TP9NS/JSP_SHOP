<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String customerId = request.getParameter("customerId");
    String size = request.getParameter("size");
    String productId = request.getParameter("productId");
    String count = request.getParameter("count");
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop2", "root", "psh0811");

        String sql = "INSERT INTO cart (product_id,customer_id, size, count ) VALUES (?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, productId);
        pstmt.setString(2, customerId);
        pstmt.setString(3, size);
        pstmt.setString(4, count);
        int result = pstmt.executeUpdate();

        if (result > 0) {
            response.getWriter().write("addCart_done");
        } else {
            response.getWriter().write("addCart_fail");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.getWriter().write("addCart_error");
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>
