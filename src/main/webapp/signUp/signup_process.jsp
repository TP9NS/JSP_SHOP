<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // MySQL 연결 정보
    String url = "jdbc:mysql://localhost:3306/shop2";
    String username = "root";
    String password = "psh0811";

    // 회원가입 폼으로부터 전달받은 데이터
    String id = request.getParameter("username");
    String passwd = request.getParameter("password");
    String name = request.getParameter("name");
    String birthdate = request.getParameter("birthdate");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String postcode = request.getParameter("postcode");
    String address = request.getParameter("address");
    String address_1 = request.getParameter("address_1");
    String extraAddress = request.getParameter("extraAddress");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // MySQL 연결
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);

        // 회원가입 데이터 삽입 쿼리
        String sql = "INSERT INTO customer (id, password, name, birthdate, email, phone, postcode, address, address_1) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.setString(2, passwd);
        pstmt.setString(3, name);
        pstmt.setString(4, birthdate);
        pstmt.setString(5, email);
        pstmt.setString(6, phone);
        pstmt.setString(7, postcode);
        pstmt.setString(8, address);
        pstmt.setString(9, address_1);
        
        
        int rowsAffected = pstmt.executeUpdate();
        
        if(rowsAffected > 0) {
        	response.sendRedirect("/SHOP/main/main.jsp");
        } else {
            // 회원가입 실패
        	request.setAttribute("message", "회원가입에 실패하였습니다.");
        	 request.getRequestDispatcher("signup.jsp").forward(request, response);
        }
    } catch (Exception e) {
        // 오류 처리
        request.setAttribute("message", "회원가입에 실패하였습니다.");
        request.getRequestDispatcher("signup.jsp").forward(request, response);
        e.printStackTrace();
    } finally {
        // 연결 해제
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
   
%>
