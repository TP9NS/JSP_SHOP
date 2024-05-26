<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%

    // 데이터베이스 연결 정보
    String url = "jdbc:mysql://localhost:3306/shop2"; // MySQL 데이터베이스 URL
    String username = "root"; // MySQL 사용자 이름
    String password = "psh0811"; // MySQL 비밀번호

    String productid = (String) request.getParameter("productId");
    // 데이터베이스 연결 및 쿼리 실행
    try {
        Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL JDBC 드라이버 클래스 로드
        Connection conn = DriverManager.getConnection(url, username, password); // 데이터베이스 연결

        // SQL 쿼리 작성
        String sql = "DELETE FROM product where product_id = ?";
        PreparedStatement statement = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);


        int rowsInserted = statement.executeUpdate();
        if (rowsInserted > 0) {
        	response.sendRedirect("/SHOP/main/main.jsp");
            
        } else {
        	response.sendRedirect("/SHOP/main/main.jsp");      
        }

        // 리소스 해제
        statement.close();
        conn.close();
    } catch (Exception e) {
        request.setAttribute("message", "상품삭제에 실패하였습니다.");
        response.sendRedirect("/SHOP/main/main.jsp");
    }
%>
