<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import ="java.time.LocalDate" %>
<%
    String reviewId = request.getParameter("reviewId");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String modify_at = LocalDate.now().toString();
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop", "root", "psh0811");

        String sql = "UPDATE review SET title=? ,content=?,modify_at=? WHERE review_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, title);
        pstmt.setString(2, content);
        pstmt.setString(3, modify_at);
        pstmt.setString(4, reviewId);
        int result = pstmt.executeUpdate();

        if (result > 0) {
            response.getWriter().write("edit_done");
        } else {
            response.getWriter().write("edit_fail");
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
