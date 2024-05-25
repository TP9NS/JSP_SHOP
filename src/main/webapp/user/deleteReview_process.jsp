<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String reviewId = request.getParameter("reviewId");
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop", "root", "psh0811");

        String sql = "DELETE FROM review WHERE review_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, reviewId);
        int result = pstmt.executeUpdate();

        if (result > 0) {
            response.getWriter().write("delete_done");
        } else {
            response.getWriter().write("delete_fail");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.getWriter().write("delete_error");
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>
