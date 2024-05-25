<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%

    // 데이터베이스 연결 정보
    String url = "jdbc:mysql://localhost:3306/shop2"; // MySQL 데이터베이스 URL
    String username = "root"; // MySQL 사용자 이름
    String password = "psh0811"; // MySQL 비밀번호

    // 상품 등록 양식에서 전송된 데이터 가져오기
    String productName = request.getParameter("productName");
    String manufacturer = request.getParameter("manufacturer");
    Double price = Double.parseDouble(request.getParameter("price"));
    String[] sizes = request.getParameterValues("size");
    String productImage1 = request.getParameter("productImage1");
    String productImage2 = request.getParameter("productImage2");
    String productImage3 = request.getParameter("productImage3");
    String productImage4 = request.getParameter("productImage4");
    String description = request.getParameter("description");
    String category = request.getParameter("category");
	String productId= request.getParameter("productId");
    // 데이터베이스 연결 및 쿼리 실행
    try {
        Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL JDBC 드라이버 클래스 로드
        Connection conn = DriverManager.getConnection(url, username, password); // 데이터베이스 연결

        // SQL 쿼리 작성
        String sql = "UPDATE product SET product_name = ?, manufacturer = ?, price = ?, product_image1 = ?, product_image2 = ?, product_image3 = ?, product_image4 = ?, product_description = ?, category = ? WHERE product_id = ?";
        PreparedStatement statement = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

        // SQL 쿼리 매개변수 설정
        statement.setString(1, productName);
        statement.setString(2, manufacturer);
        statement.setDouble(3, price);
        statement.setString(4, productImage1);
        statement.setString(5, productImage2);
        statement.setString(6, productImage3);
        statement.setString(7, productImage4);
        statement.setString(8, description);
        statement.setString(9, category);
        statement.setString(10, productId);
        // SQL 쿼리 실행 및 생성된 상품의 ID 가져오기
        int rowsInserted = statement.executeUpdate();
        if (rowsInserted > 0) {
            	sql = "DELETE FROM size where product_id = ?";
            	statement = conn.prepareStatement(sql);
                statement.setString(1, productId);
                statement.executeUpdate();
                for (String size : sizes) {
                    sql = "INSERT INTO size (product_id, size) VALUES (?, ?)";
                    statement = conn.prepareStatement(sql);
                    statement.setString(1, productId);
                    statement.setString(2, size);
                    statement.executeUpdate();
                }
                request.setAttribute("message", "상품등록이 성공하였습니다.");
                request.getRequestDispatcher("editProduct.jsp?"+productId).forward(request, response);
            
        } else {
            request.setAttribute("message", "상품등록에 실패하였습니다.");
            request.getRequestDispatcher("editProduct.jsp"+productId).forward(request, response);
        }

        // 리소스 해제
        statement.close();
        conn.close();
    } catch (Exception e) {
        request.setAttribute("message", "상품등록에 실패하였습니다.");
        request.getRequestDispatcher("editProduct.jsp"+productId).forward(request, response);
    }
%>
