<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String postcode = request.getParameter("postcode");
    String address = request.getParameter("address");
    String detailAddress = request.getParameter("detailAddress");
    String extraAddress = request.getParameter("extraAddress");
    String customerId = (String) session.getAttribute("customer_id"); // 세션에서 사용자 ID 가져오기

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop2", "root", "psh0811");
        
        String sql = "UPDATE customer SET postcode = ?, address = ?, address_1 = ? WHERE customer_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, postcode);
        pstmt.setString(2, address + ' ' + extraAddress); // 기본 주소와 참고항목을 함께 저장
        pstmt.setString(3, detailAddress);
        pstmt.setString(4, customerId);
        
        int result = pstmt.executeUpdate();
        
        if (result > 0) {
            out.print("Address updated successfully");
        } else {
            out.print("Error updating address");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.print("Error: " + e.getMessage());
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>