<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String birth = request.getParameter("birth");
    String email = request.getParameter("email");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String url = "jdbc:mysql://localhost:3306/shop2";
    String username = "root";
    String password = "psh0811";
    String sql = "SELECT password FROM customer WHERE id = ? AND name = ? AND birthdate = ? AND email = ?";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.setString(2, name);
        pstmt.setString(3, birth);
        pstmt.setString(4, email);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String foundPassword = rs.getString("password");
            response.getWriter().print("비밀번호: " + foundPassword);
        } else {
            response.getWriter().print("일치하는 비밀번호가 없습니다.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.getWriter().print("오류가 발생했습니다.");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ex) { }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) { }
        if (conn != null) try { conn.close(); } catch (SQLException ex) { }
    }
%>
