<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String reviewTitle = request.getParameter("reviewTitle");
    String reviewContent = request.getParameter("reviewContent");
    String productId = request.getParameter("productId");
    String customerId = (String) session.getAttribute("customer_id");
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop", "root", "psh0811");

        String sql = "INSERT INTO review (title, content, product_id, customer_id, created_at) VALUES (?, ?, ?, ?, NOW())";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, reviewTitle);
        pstmt.setString(2, reviewContent);
        pstmt.setString(3, productId);
        pstmt.setString(4, customerId);
        int result = pstmt.executeUpdate();

        if (result > 0) {
            response.getWriter().write("submit_done");
        } else {
            response.getWriter().write("submit_fail");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.getWriter().write("submit_error");
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>
