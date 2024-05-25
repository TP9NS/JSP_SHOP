<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // MySQL 연결 정보
    String url = "jdbc:mysql://localhost:3306/shop2";
    String username = "root";
    String password = "psh0811";

    // 클라이언트로부터 전달받은 아이디
    String id = request.getParameter("id");
	System.out.println(id+"aew");
    // 결과를 담을 JSON 형식의 문자열 생성
    String jsonResponse = "";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // MySQL 연결
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);

        // 아이디 중복 확인 쿼리
        String sql = "SELECT COUNT(*) AS count FROM customer WHERE id=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            int count = rs.getInt("count");
            System.out.println("asdasd"+count);
            if (count > 0) {
                // 아이디가 이미 존재하는 경우
                jsonResponse = "{\"message\": \"exist\"}";
            } else {
                // 아이디가 존재하지 않는 경우
                jsonResponse = "{\"message\": \"not_exist\"}";
            }
        }
    } catch (Exception e) {
        // 오류 처리
        jsonResponse = "{\"message\": \"error\"}";
        e.printStackTrace();
    } finally {
        // 연결 해제
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }

    // JSON 응답 전송
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().print(jsonResponse);
%>