<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");
    String nickname = request.getParameter("nickname");
    String email = request.getParameter("email");

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop2", "root", "psh0811");

    // 사용자 정보 확인 및 신규 사용자 등록 로직
    PreparedStatement pst = con.prepareStatement("SELECT * FROM customer WHERE id = ?");
    pst.setString(1, id);
    ResultSet rs = pst.executeQuery();

    if (rs.next()) {
        // 기존 사용자 로그인 처리
        session.setAttribute("customer_id", rs.getString("customer_id"));
        session.setAttribute("userId",rs.getString("id"));
        session.setAttribute("permission", "3");
        out.print("login_success");
    } else {
    	response.getWriter().print("signup_required");
    }

    rs.close();
    pst.close();
    con.close();
%>
