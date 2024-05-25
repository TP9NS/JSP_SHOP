<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String customerId = request.getParameter("customerId");
    String size = request.getParameter("size");
    String productId = request.getParameter("productId");
    String count = request.getParameter("count");
    String total_price = request.getParameter("price");
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop2", "root", "psh0811");

        // 고객 정보를 조회합니다.
        String sql = "SELECT postcode, address, address_1 FROM customer WHERE customer_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, customerId);
        rs = pstmt.executeQuery();

        String postcode = "";
        String address = "";
        String address_1 = "";
        if (rs.next()) {
            postcode = rs.getString("postcode");
            address = rs.getString("address");
            address_1 = rs.getString("address_1");
        }

        // 자원 해제
        rs.close();
        pstmt.close();

        // 주문 정보를 삽입합니다.
        sql = "INSERT INTO `orders` (product_id, customer_id, size, count, total_price, postcode, address, address_1, status , order_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?,now())";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, productId);
        pstmt.setString(2, customerId);
        pstmt.setString(3, size);
        pstmt.setString(4, count);
        pstmt.setString(5, total_price);
        pstmt.setString(6, postcode);
        pstmt.setString(7, address);
        pstmt.setString(8, address_1);
        pstmt.setString(9, "주문 완료");

        int result = pstmt.executeUpdate();
        if (result > 0) {
            response.getWriter().write("purchase_done");
        } else {
            response.getWriter().write("addOrder_fail");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.getWriter().write("addOrder_error");
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>
