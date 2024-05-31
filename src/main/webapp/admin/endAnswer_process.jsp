<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.Date" %>
<%
    String customerId = request.getParameter("customerId");
    String productId = request.getParameter("productId");
    String classify = customerId + "/" + productId;

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String url = "jdbc:mysql://localhost:3306/shop2";
    String username = "root";
    String password = "psh0811";
    String sqlInsertChat = "INSERT INTO chat (customer_id, product_id, message, chat_time, classify) VALUES (?, ?, ?, ?, ?)";
    String sqlCheckStatus = "SELECT * FROM chatstatus WHERE classify = ?";
    String sqlInsertStatus = "INSERT INTO chatstatus (chatstatus,classify,chatdate) VALUES (?, ? ,now())";
    String sqlUpdateStatus = "UPDATE chatstatus SET chatstatus="+"'문의가 종료되었습니다.',chatdate=now()"+"WHERE classify = ?";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);

       
       pstmt = conn.prepareStatement(sqlUpdateStatus);
       pstmt.setString(1, classify);
       pstmt.executeUpdate();

        int result = pstmt.executeUpdate();

        if (result > 0) {
            response.getWriter().print("success");
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
