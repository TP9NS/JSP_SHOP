<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // MySQL 연결 정보
    String url = "jdbc:mysql://localhost:3306/shop2";
    String username = "root";
    String password = "psh0811";

    // 로그인 폼으로부터 전달받은 데이터
    String id = request.getParameter("Username");
    String passwd = request.getParameter("Password");
 
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // MySQL 연결
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);

        // 로그인 쿼리 실행
        String sql = "SELECT permission,customer_id FROM customer WHERE id = ? AND password = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.setString(2, passwd);
        
        rs = pstmt.executeQuery();

        if(rs.next()) {
            // 로그인 성공
            String permission = rs.getString("permission");
			String customer_id = rs.getString("customer_id");
            // 세션에 사용자 정보 저장
            session.setAttribute("customer_id",customer_id);
            session.setAttribute("userId", id);
            session.setAttribute("permission", permission);

            // 메인 페이지로 리다이렉트
            response.sendRedirect("/SHOP/main/main.jsp");
        } else {
            // 로그인 실패
            request.setAttribute("message", "로그인에 실패하였습니다.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    } catch (Exception e) {
        // 오류 처리
        request.setAttribute("message", "로그인에 실패하였습니다.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
        e.printStackTrace();
    } finally {
        // 연결 해제
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>
