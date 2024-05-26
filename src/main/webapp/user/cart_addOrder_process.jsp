<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.ArrayList" %>

<%
    String cartIds = request.getParameter("cartIds");
    String[] idsArray = cartIds.split(",");

    Connection conn = null;
    PreparedStatement pstmtCart = null, pstmtCustomer = null, pstmtOrder = null, pstmtProduct = null, pstmtDeleteCart = null;
    ResultSet rsCart = null, rsCustomer = null, rsProduct = null;
    ArrayList<String> successfulOrders = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop2", "root", "psh0811");
        conn.setAutoCommit(false); // 시작 시 트랜잭션 커밋 비활성화

        for (String cartId : idsArray) {
            // 카트 정보 조회
            String sqlCart = "SELECT * FROM cart WHERE cart_id = ?";
            pstmtCart = conn.prepareStatement(sqlCart);
            pstmtCart.setInt(1, Integer.parseInt(cartId));
            rsCart = pstmtCart.executeQuery();

            if (rsCart.next()) {
                String productId = rsCart.getString("product_id");
                String customerId = rsCart.getString("customer_id");
                String size = rsCart.getString("size");
                int count = rsCart.getInt("count");

                // 상품 가격 정보 조회
                String sqlProduct = "SELECT price FROM product WHERE product_id = ?";
                pstmtProduct = conn.prepareStatement(sqlProduct);
                pstmtProduct.setString(1, productId);
                rsProduct = pstmtProduct.executeQuery();

                double price = 0;
                if (rsProduct.next()){
                    price = rsProduct.getDouble("price") * count;
                }

                // 고객 주소 정보 조회
                String sqlCustomer = "SELECT postcode, address, address_1 FROM customer WHERE customer_id = ?";
                pstmtCustomer = conn.prepareStatement(sqlCustomer);
                pstmtCustomer.setString(1, customerId);
                rsCustomer = pstmtCustomer.executeQuery();

                if (rsCustomer.next()) {
                    String postcode = rsCustomer.getString("postcode");
                    String address = rsCustomer.getString("address");
                    String address_1 = rsCustomer.getString("address_1");

                    // 주문 정보 삽입
                    String sqlOrder = "INSERT INTO orders (product_id, customer_id, size, count, total_price, postcode, address, address_1, status, order_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, '주문 완료', now())";
                    pstmtOrder = conn.prepareStatement(sqlOrder);
                    pstmtOrder.setString(1, productId);
                    pstmtOrder.setString(2, customerId);
                    pstmtOrder.setString(3, size);
                    pstmtOrder.setInt(4, count);
                    pstmtOrder.setDouble(5, price);
                    pstmtOrder.setString(6, postcode);
                    pstmtOrder.setString(7, address);
                    pstmtOrder.setString(8, address_1);
                    int result = pstmtOrder.executeUpdate();

                    if (result > 0) {
                        // 주문 성공시 카트 삭제
                        String sqlDeleteCart = "DELETE FROM cart WHERE cart_id = ?";
                        pstmtDeleteCart = conn.prepareStatement(sqlDeleteCart);
                        pstmtDeleteCart.setInt(1, Integer.parseInt(cartId));
                        pstmtDeleteCart.executeUpdate();

                        successfulOrders.add(cartId);
                    }
                }
            }
            // 리소스 정리
            if (rsCart != null) rsCart.close();
            if (pstmtCart != null) pstmtCart.close();
            if (rsProduct != null) rsProduct.close();
            if (pstmtProduct != null) pstmtProduct.close();
            if (rsCustomer != null) rsCustomer.close();
            if (pstmtCustomer != null) pstmtCustomer.close();
            if (pstmtOrder != null) pstmtOrder.close();
            if (pstmtDeleteCart != null) pstmtDeleteCart.close();
        }

        conn.commit(); // 모든 처리가 성공적이면 커밋

        if (!successfulOrders.isEmpty()) {
            response.getWriter().write("주문 완료: " + successfulOrders.size() + " 개");
        } else {
            response.getWriter().write("주문 실패");
        }
    } catch (Exception e) {
        if (conn != null) conn.rollback(); // 오류 발생 시 롤백
        e.printStackTrace();
        response.getWriter().write("주문 처리 오류");
    } finally {
        if (conn != null) conn.close(); // 커넥션 닫기
    }
%>
