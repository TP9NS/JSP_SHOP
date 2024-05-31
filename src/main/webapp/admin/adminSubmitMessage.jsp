<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.Date" %>
<%
    String customerId = request.getParameter("customerId");
    String productId = request.getParameter("productId");
    String message = request.getParameter("message");
    Timestamp chatTime = new Timestamp(new Date().getTime());
    String classify = customerId + "/" + productId;
	String customer_id= (String)session.getAttribute("customer_id");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String url = "jdbc:mysql://localhost:3306/shop2";
    String username = "root";
    String password = "psh0811";
    String sqlInsertChat = "INSERT INTO chat (customer_id, product_id, message, chat_time, classify) VALUES (?, ?, ?, ?, ?)";
    String sqlCheckStatus = "SELECT * FROM chatstatus WHERE classify = ?";
    String sqlInsertStatus = "INSERT INTO chatstatus (chatstatus,classify,chatdate) VALUES (?, ? , now())";
    String sqlUpdateStatus = "UPDATE chatstatus SET chatstatus="+"'답변을 하였습니다.',chatdate= now()"+"WHERE classify = ?";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);

        // Check if classify exists in the status table
        pstmt = conn.prepareStatement(sqlCheckStatus);
        pstmt.setString(1, classify);
        rs = pstmt.executeQuery();
        
        if (!rs.next()) {
            // If classify does not exist, insert a new status row
            pstmt = conn.prepareStatement(sqlInsertStatus);
            pstmt.setString(1, "새로운 메시지가 도착하였습니다.");
            pstmt.setString(2, classify);
            pstmt.executeUpdate();
        }else{
            pstmt = conn.prepareStatement(sqlUpdateStatus);
            pstmt.setString(1, classify);
            pstmt.executeUpdate();
        	
        }

        // Insert chat message
        pstmt = conn.prepareStatement(sqlInsertChat);
        pstmt.setString(1, customer_id);
        pstmt.setString(2, productId);
        pstmt.setString(3, message);
        pstmt.setTimestamp(4, chatTime);
        pstmt.setString(5, classify);
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
