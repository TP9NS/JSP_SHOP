<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String password = request.getParameter("password");
    String customerId = (String) session.getAttribute("customer_id");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String url = "jdbc:mysql://localhost:3306/shop2";
    String username = "root";
    String dbPassword = "psh0811";
    String sql = "SELECT password FROM customer WHERE customer_id = ?";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, dbPassword);

        // 비밀번호 확인
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, customerId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String storedPassword = rs.getString("password");
            if (storedPassword.equals(password)) {
                // 비밀번호가 일치하면 회원탈퇴 처리
                pstmt.close();

                sql = "DELETE FROM customer WHERE customer_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, customerId);
                pstmt.executeUpdate();

                session.invalidate(); // 세션 무효화
                response.getWriter().print("success");
            } else {
                response.getWriter().print("fail");
            }
        } else {
            response.getWriter().print("fail");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.getWriter().print("error");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ex) { }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) { }
        if (conn != null) try { conn.close(); } catch (SQLException ex) { }
    }
%>
