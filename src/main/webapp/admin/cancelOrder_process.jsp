<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import ="java.time.LocalDate" %>
<%
    String orderId = request.getParameter("orderId");
	
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop2", "root", "psh0811");
	
        String sql = "DELETE FROM orders WHERE order_id= ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, orderId);
  
        int result = pstmt.executeUpdate();

        if (result > 0) {
            response.getWriter().write("update_done");
        } else {
            response.getWriter().write("update_fail");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.getWriter().write("update_error");
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>
