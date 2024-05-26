<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String cartIds = request.getParameter("cartIds");
    if (cartIds != null && !cartIds.isEmpty()) {
        String[] idsArray = cartIds.split(",");
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop2", "root", "psh0811");
            
            // 예: 모든 선택된 항목 삭제
            String sql = "DELETE FROM cart WHERE cart_id IN (";
            for (int i = 0; i < idsArray.length; i++) {
                sql += "?";
                if (i < idsArray.length - 1) {
                    sql += ", ";
                }
            }
            sql += ")";
            
            pstmt = conn.prepareStatement(sql);
            for (int i = 0; i < idsArray.length; i++) {
                pstmt.setString(i + 1, idsArray[i]);
            }

            int result = pstmt.executeUpdate();
            if (result > 0) {
                response.getWriter().write("delete_success");
            } else {
                response.getWriter().write("delete_fail");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("delete_error");
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    } else {
        response.getWriter().write("No IDs provided");
    }
%>
