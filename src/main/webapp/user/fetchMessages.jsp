<%@ page import="java.sql.*, java.util.List, java.util.ArrayList" %>
<%@ page import="com.google.gson.*" %>
<%@ page import="chatpackage.ChatMessage" %>
<%
    String productId = request.getParameter("productId");
	String customerId1 = request.getParameter("customerId");
	String classify = customerId1+"/"+productId;
    List<ChatMessage> messages = new ArrayList<>();
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String url = "jdbc:mysql://localhost:3306/shop2";
    String username = "root";
    String password = "psh0811";
    String sql = "SELECT * FROM chat WHERE classify = ? ORDER BY chat_time ASC";
	Gson gson =new Gson();
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, classify);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            String message = rs.getString("message");
            String customerId = rs.getString("customer_id");
            Timestamp time = rs.getTimestamp("chat_time");

            // Assuming ChatMessage is a class that holds these attributes
            messages.add(new ChatMessage(customerId, message, time));

        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ex) { }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) { }
        if (conn != null) try { conn.close(); } catch (SQLException ex) { }
    }

    // Convert messages to JSON or a similar format to send back to the client
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(gson.toJson(messages)); // Using Gson to convert List to JSON
%>
