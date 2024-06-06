<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.*" %>

   <%
        String url = "jdbc:mysql://localhost:3306/shop"; // MySQL 데이터베이스 URL
        String username = "root"; // MySQL 사용자 이름
        String password = "psh0811"; // MySQL 비밀번호
        String productid = (String) request.getParameter("id");
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String productName = "";
        String productDescription = "";
        String productImage1 = "";
        String productImage2 = "";
        String productImage3 = "";
        String productImage4 = "";
        String productManufacturer = "";
        String productPrice = "";
        String productCategory = "";

        try {
            // MySQL 연결
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);

            // 상품 정보 가져오기
            String sql = "SELECT * FROM product WHERE product_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, productid);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                productName = rs.getString("product_name");
                productDescription = rs.getString("product_description");
                productImage1 = rs.getString("product_image1");
                productImage2 = rs.getString("product_image2");
                productImage3 = rs.getString("product_image3");
                productImage4 = rs.getString("product_image4");
                productManufacturer = rs.getString("manufacturer");
                productPrice = rs.getString("price");
                productCategory = rs.getString("category");
            }
        } catch (Exception e) {
            // 오류 처리
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
        <%
    String message = (String)request.getAttribute("message");
    if(message != null && !message.isEmpty()) {
	%>
    <script>
        alert('<%= message %>');
    </script>
	<%
    	}
	%>
 
<!DOCTYPE html>
<html>
<head><script src="/docs/5.3/assets/js/color-modes.js"></script>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.118.2">
    <title>안양마켓</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/album/">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">

 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

    <!-- Favicons -->
<link rel="apple-touch-icon" href="/docs/5.3/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
<link rel="icon" href="/docs/5.3/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
<link rel="icon" href="/docs/5.3/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
<link rel="manifest" href="/docs/5.3/assets/img/favicons/manifest.json">
<link rel="mask-icon" href="/docs/5.3/assets/img/favicons/safari-pinned-tab.svg" color="#712cf9">
<link rel="icon" href="/docs/5.3/assets/img/favicons/favicon.ico">
<meta name="theme-color" content="#712cf9">


    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }

      .b-example-divider {
        width: 100%;
        height: 3rem;
        background-color: rgba(0, 0, 0, .1);
        border: solid rgba(0, 0, 0, .15);
        border-width: 1px 0;
        box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
      }

      .b-example-vr {
        flex-shrink: 0;
        width: 1.5rem;
        height: 100vh;
      }

      .bi {
        vertical-align: -.125em;
        fill: currentColor;
      }

      .nav-scroller {
        position: relative;
        z-index: 2;
        height: 2.75rem;
        overflow-y: hidden;
      }

      .nav-scroller .nav {
        display: flex;
        flex-wrap: nowrap;
        padding-bottom: 1rem;
        margin-top: -1px;
        overflow-x: auto;
        text-align: center;
        white-space: nowrap;
        -webkit-overflow-scrolling: touch;
      }

      .btn-bd-primary {
        --bd-violet-bg: #712cf9;
        --bd-violet-rgb: 112.520718, 44.062154, 249.437846;

        --bs-btn-font-weight: 600;
        --bs-btn-color: var(--bs-white);
        --bs-btn-bg: var(--bd-violet-bg);
        --bs-btn-border-color: var(--bd-violet-bg);
        --bs-btn-hover-color: var(--bs-white);
        --bs-btn-hover-bg: #6528e0;
        --bs-btn-hover-border-color: #6528e0;
        --bs-btn-focus-shadow-rgb: var(--bd-violet-rgb);
        --bs-btn-active-color: var(--bs-btn-hover-color);
        --bs-btn-active-bg: #5a23c8;
        --bs-btn-active-border-color: #5a23c8;
      }

      .bd-mode-toggle {
        z-index: 1500;
      }

      .bd-mode-toggle .dropdown-menu .active .bi {
        display: block !important;
      }
      .category-nav {
            margin-bottom: 20px;
        }

        .category-nav .navbar-nav {
            display: flex;
            align-items: center;
        }

        .category-nav .nav-item {
            margin-right: 10px;
        }
    .card-title {
    /* 제목의 높이를 직접 지정하여 일관된 크기로 유지함 */
    height: 60px; /* 예시로 60px로 설정 */
    overflow: hidden;
    text-overflow: ellipsis; /* 길이가 초과되는 경우 ...으로 표시 */
    white-space: nowrap; /* 한 줄에 모두 표시하도록 설정 */
}

.card-description {
    /* 설명의 높이를 직접 지정하여 일관된 크기로 유지함 */
    height: 70px; /* 예시로 80px로 설정 */
    overflow: hidden;
    text-overflow: ellipsis; /* 길이가 초과되는 경우 ...으로 표시 */
    
}
.btn-sm {
        font-size: 0.8rem; /* 원하는 폰트 크기로 조절하세요 */
    }
    </style>

    
  </head>
  <body>
    <svg xmlns="http://www.w3.org/2000/svg" class="d-none">
      <symbol id="check2" viewBox="0 0 16 16">
        <path d="M13.854 3.646a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L6.5 10.293l6.646-6.647a.5.5 0 0 1 .708 0z"/>
      </symbol>
      <symbol id="circle-half" viewBox="0 0 16 16">
        <path d="M8 15A7 7 0 1 0 8 1v14zm0 1A8 8 0 1 1 8 0a8 8 0 0 1 0 16z"/>
      </symbol>
      <symbol id="moon-stars-fill" viewBox="0 0 16 16">
        <path d="M6 .278a.768.768 0 0 1 .08.858 7.208 7.208 0 0 0-.878 3.46c0 4.021 3.278 7.277 7.318 7.277.527 0 1.04-.055 1.533-.16a.787.787 0 0 1 .81.316.733.733 0 0 1-.031.893A8.349 8.349 0 0 1 8.344 16C3.734 16 0 12.286 0 7.71 0 4.266 2.114 1.312 5.124.06A.752.752 0 0 1 6 .278z"/>
        <path d="M10.794 3.148a.217.217 0 0 1 .412 0l.387 1.162c.173.518.579.924 1.097 1.097l1.162.387a.217.217 0 0 1 0 .412l-1.162.387a1.734 1.734 0 0 0-1.097 1.097l-.387 1.162a.217.217 0 0 1-.412 0l-.387-1.162A1.734 1.734 0 0 0 9.31 6.593l-1.162-.387a.217.217 0 0 1 0-.412l1.162-.387a1.734 1.734 0 0 0 1.097-1.097l.387-1.162zM13.863.099a.145.145 0 0 1 .274 0l.258.774c.115.346.386.617.732.732l.774.258a.145.145 0 0 1 0 .274l-.774.258a1.156 1.156 0 0 0-.732.732l-.258.774a.145.145 0 0 1-.274 0l-.258-.774a1.156 1.156 0 0 0-.732-.732l-.774-.258a.145.145 0 0 1 0-.274l.774-.258c.346-.115.617-.386.732-.732L13.863.1z"/>
      </symbol>
      <symbol id="sun-fill" viewBox="0 0 16 16">
        <path d="M8 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8zM8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z"/>
      </symbol>
    </svg>

    <div class="dropdown position-fixed bottom-0 end-0 mb-3 me-3 bd-mode-toggle">
      <button class="btn btn-bd-primary py-2 dropdown-toggle d-flex align-items-center"
              id="bd-theme"
              type="button"
              aria-expanded="false"
              data-bs-toggle="dropdown"
              aria-label="Toggle theme (auto)">
        <svg class="bi my-1 theme-icon-active" width="1em" height="1em"><use href="#circle-half"></use></svg>
        <span class="visually-hidden" id="bd-theme-text">Toggle theme</span>
      </button>
      <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="bd-theme-text">
        <li>
          <button type="button" class="dropdown-item d-flex align-items-center" data-bs-theme-value="light" aria-pressed="false">
            <svg class="bi me-2 opacity-50 theme-icon" width="1em" height="1em"><use href="#sun-fill"></use></svg>
            Light
            <svg class="bi ms-auto d-none" width="1em" height="1em"><use href="#check2"></use></svg>
          </button>
        </li>
        <li>
          <button type="button" class="dropdown-item d-flex align-items-center" data-bs-theme-value="dark" aria-pressed="false">
            <svg class="bi me-2 opacity-50 theme-icon" width="1em" height="1em"><use href="#moon-stars-fill"></use></svg>
            Dark
            <svg class="bi ms-auto d-none" width="1em" height="1em"><use href="#check2"></use></svg>
          </button>
        </li>
        <li>
          <button type="button" class="dropdown-item d-flex align-items-center active" data-bs-theme-value="auto" aria-pressed="true">
            <svg class="bi me-2 opacity-50 theme-icon" width="1em" height="1em"><use href="#circle-half"></use></svg>
            Auto
            <svg class="bi ms-auto d-none" width="1em" height="1em"><use href="#check2"></use></svg>
          </button>
        </li>
      </ul>
    </div>

    
<header data-bs-theme="dark">
  <div class="collapse text-bg-dark" id="navbarHeader">
    <div class="container">
      <div class="row">
        <div class="col-sm-8 col-md-7 py-4">
          <h4>About</h4>
          <p class="text-body-secondary">안양마켓에 오신것을 환영합니다!!</p>
          <%
    // 세션에서 userId를 가져옴
    			String userId = (String) session.getAttribute("userId");
          		String permission = (String)session.getAttribute("permission");
          		String customer_id = (String)session.getAttribute("customer_id");
		  %>
			<% if (userId != null) { %>
    			<div>
    				<%= userId %>
        			<a class="nav-link" href="/SHOP/login/logout_process.jsp" >로그아웃</a>
    			</div>
		<% } %>
        </div>
        <div class="col-sm-4 offset-md-1 py-4">
          <h4>Contact</h4>
          <ul class="list-unstyled">
            <li><a href="#" class="text-white">Follow on Twitter</a></li>
            <li><a href="#" class="text-white">Like on Facebook</a></li>
            <li><a href="#" class="text-white">Email me</a></li>
          </ul>
        </div>
      </div>
    </div>
  </div>
  <div class="navbar navbar-dark bg-dark shadow-sm">
    <div class="container">
      <a href="/SHOP/main/main.jsp" class="navbar-brand d-flex align-items-center">
        <strong>안양 마켓</strong>
      </a>
      <ul class="navbar-nav ms-auto">
    <% if (userId == null) { %>
        <!-- userId가 null인 경우(로그인되지 않은 경우) -->
        <li class="nav-item">
            <a class="nav-link" href="/SHOP/signUp/signup.jsp">회원가입</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/SHOP/login/login.jsp">로그인</a>
        </li>
    <% } else { %>
        <!-- userId가 null이 아닌 경우(로그인된 경우) -->
        <% if (permission != null && permission.equals("1")) { %>
            <li class="nav-item">
                <a class="nav-link" href="/SHOP/admin/addProduct.jsp">상품등록하기</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/SHOP/admin/allOrders.jsp">전체주문보기</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/SHOP/admin/allQuestion.jsp">문의내역보기</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/SHOP/admin/management.jsp">회원관리</a>
            </li>
        <% } else if (permission != null && permission.equals("3")) { %>
            <!-- permission이 1인 경우(일반 사용자) -->
            <li class="nav-item">
                <a class="nav-link" href="/SHOP/user/myPage.jsp">마이페이지</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/SHOP/user/cart.jsp">장바구니</a>
            </li>
                        <li class="nav-item">
                <a class="nav-link" href="/SHOP/user/Question.jsp">문의내역보기</a>
            </li>
        <% } %>
      
    <% } %>
</ul>

      <div style="margin-left: 20px;"></div>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarHeader" aria-controls="navbarHeader" aria-expanded="true" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
    </div>
  </div>
  <nav class="navbar navbar-dark bg-dark category-nav">
            <div class="container">
                <ul class="navbar-nav flex-row">
                    <li class="nav-item">
                        <a class="nav-link" href="/SHOP/main/main.jsp">전체</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/SHOP/main/up.jsp">상의</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/SHOP/main/down.jsp">하의</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/SHOP/main/outer.jsp">아우터</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/SHOP/main/shoes.jsp">신발</a>
                    </li>
                </ul>
            </div>
        </nav>
</header>
<div style="margin-top: 20px;"></div>
<main>
    <body>

    <div class="container">
        <h1 class="text-center">상품 상세 정보</h1>
    <div class="row">
        <div class="col-md-7">
            <img src="<%= productImage1%>" class="img-fluid">
            <h2> <%= productName%></h2>
    </div>
        <div class="col-md-5" >
			<div style="margin-top: 30px;"></div>
			<p>상품설명: <%= productDescription%></p>
			
			<form>
  			<select name="size" id ="size_id">
  			<option value="none">=== 사이즈 ===</option>
<%
         try {
             // MySQL 연결
             Class.forName("com.mysql.jdbc.Driver");
             conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop2", username, password);

             // 상품 정보 가져오기
             String sql = "SELECT * FROM size WHERE product_id = ?";
             pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, productid);
      
             rs = pstmt.executeQuery();
             while (rs.next()) {
            	 String size = rs.getString("size");
         %>
				
    			<option value=<%=size%>> <%=size%></option>
            
    	<%
    }
    %>
   
    <%
    
         } catch (Exception e) {
             // 오류 처리
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
  			</select>
			</form>
			
            <p>상품가격: <%= productPrice%></p>
           
    <div class="input-group mb-3">
        <span class="input-group-text" id="quantity-label">수량</span>
        <input id="quantityInput" type="number" class="form-control" placeholder="수량 입력" aria-label="수량 입력" aria-describedby="quantity-label">
    </div>
    <button id="addToCartButton" class="btn btn-primary">장바구니</button>
    <button id="purchaseButton" class="btn btn-success">구매하기</button>
	<button id="questionButton" class="btn btn-info">문의하기</button>
    </div>
	
    <div style="margin-top: 20px;"></div>
     <h1 class="text-center" style="border-top: 1px solid black;">&nbsp;</h1>
        <h1 class="text-center">제품 사진</h1>
        <div class="text-center">
    		<div>
        		<img src="<%= productImage2%>" class="img-fluid" style="max-width: 120%; height: auto;">
    		</div>
    		<div>
        		<img src="<%= productImage3%>" class="img-fluid" style="max-width: 120%; height: auto;">
    		</div>
    		<div>
	       			 <img src="<%= productImage4%>" class="img-fluid" style="max-width: 120%; height: auto;">
    		</div>
		</div>
		    <div style="margin-top: 20px;"></div>
     <h1 class="text-center" style="border-top: 1px solid black;">&nbsp;</h1>
        <h1 class="text-center">후기</h1>
        <table class="table">
        <thead>
            <tr>
                <th>고객ID</th>
                <th>리뷰제목</th>
                <th>리뷰내용</th>
                <th>생성일</th>
                <th>수정일</th>
            </tr>
        </thead>
         <%
         try {
             // MySQL 연결
             Class.forName("com.mysql.jdbc.Driver");
             conn = DriverManager.getConnection(url, username, password);

             // 상품 정보 가져오기
             String sql = "SELECT * FROM review WHERE product_id = ?";
             pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, productid);
      
             rs = pstmt.executeQuery();
             while (rs.next()) {
            	 String review_id = rs.getString("review_id");
            	 String review_customer=rs.getString("customer_id");
            	 String review_title=rs.getString("title");
            	 String review_content=rs.getString("content");
            	 String review_createdAt=rs.getString("created_at");
            	 String review_modifyAt=rs.getString("modify_at");
            	 if(review_modifyAt == null){
            		 review_modifyAt="";
            	 }
             
         %>
            <tbody>
<tr>
    <td ><%=review_customer%></td>
    <td ><%=review_title%></td>
    <td ><%=review_content%></td>
    <td ><%=review_createdAt%></td>
    <td ><%=review_modifyAt%></td>
    <td data-reviewid=<%=review_id%>></td>
    <!-- 현재 세션의 고객이 작성한 리뷰인 경우에만 수정/삭제 버튼 표시 -->
    <% if(customer_id.equals(review_customer)){
    	%>
    	<td>
        <button class="btn btn-primary" onclick="editReview(<%=review_id %>)">수정</button>
        <button class="btn btn-danger" onclick="deleteReview(<%=review_id %>)">삭제</button>
    	</td>
    	<%
    }
    %>
   
    <%
    }
         } catch (Exception e) {
             // 오류 처리
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
</tr>
</tbody>
        </table>
    </div>
</div>
<div class="container">
    <h1 class="text-center">후기 작성</h1>
    <form id="reviewForm">
        <div class="mb-3">
            <label for="reviewTitle" class="form-label">리뷰 제목</label>
            <input type="text" class="form-control" id="reviewTitle" placeholder="리뷰 제목 입력">
        </div>
        <div class="mb-3">
            <label for="reviewContent" class="form-label">리뷰 내용</label>
            <textarea class="form-control" id="reviewContent" rows="3" placeholder="리뷰 내용 입력"></textarea>
        </div>
        <button id="submitReviewButton" class="btn btn-primary">등록하기</button>
    </form>
</div>


    <div style="margin-bottom: 250px;"></div>
    
</body>
</main>

<footer class="text-muted py-5">
  <div class="container">
    <p class="float-end mb-1">
      <a href="#">Back to top</a>
    </p>
    <p class="mb-1">Album example is © Bootstrap, but please download and customize it for yourself!</p>
    <p class="mb-0">New to Bootstrap? <a href="/">Visit the homepage</a> or read our <a href="/docs/5.3/getting-started/introduction/">getting started guide</a>.</p>
  </div>
</footer>


<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function() {
    $('#addToCartButton').click(function() {
        var count = $('#quantityInput').val();
        var size = $('#size_id').val();
        if (!count || !size) {
            alert('수량 또는 사이즈를 입력해주세요.');
            return; // 함수 종료
        }
        var productId = '<%= productid %>';
        var customerId = '<%= customer_id %>';

        $.ajax({
            type: 'POST',
            url: 'addCart_process.jsp',
            data: {
                customerId: customerId,
                productId: productId,
                size: size,
                count: count
            },
            success: function(response) {
                if (response.trim() === "addCart_done") {
                    alert('장바구니가 등록되었습니다.');
                    location.reload();
                } else {
                    alert('장바구니 등록이 실패했습니다.');
                }
            },
            error: function(error) {
                console.log(error);
                alert('오류가 발생했습니다.');
            }
        });
    });

    $('#submitReviewButton').click(function() {
        var reviewTitle = $('#reviewTitle').val();
        var reviewContent = $('#reviewContent').val();
        var productId = '<%= productid %>';

        $.ajax({
            type: 'POST',
            url: 'submitReview_process.jsp',
            data: {
                reviewTitle: reviewTitle,
                reviewContent: reviewContent,
                productId: productId
            },
            success: function(response) {
                if (response.trim() === "submit_done") {
                    alert('리뷰가 등록되었습니다.');
                    location.reload();
                } else {
                    alert('리뷰 등록에 실패했습니다.');
                }
            },
            error: function(error) {
                console.log(error);
                alert('오류가 발생했습니다.');
            }
        });
    });

    $('#purchaseButton').click(function() {
        
        var count = $('#quantityInput').val();
        var size = $('#size_id').val();
        if (!count || !size) {
            alert('수량 또는 사이즈를 입력해주세요.');
            return; // 함수 종료
        }
        var productId = '<%= productid %>';
        var customerId = '<%= customer_id %>';
		var price = count*<%= productPrice%>;
        $.ajax({
            type: 'POST',
            url: 'addOrder_process.jsp',
            data: {
                productId: productId,
                customerId: customerId,
                size: size,
                count: count,
                price: price
            },
            success: function(response) {
                if (response.trim() === "purchase_done") {
                    alert('구매가 완료되었습니다.');
                    location.reload();
                } else {
                    alert('로그인 시 이용 가능합니다.');
                }
            },
            error: function(error) {
                console.log(error);
                alert('오류가 발생했습니다.');
            }
        });
    });
});
document.getElementById('questionButton').addEventListener('click', function() {
    var customerId = '<%= customer_id %>';
    var productId = '<%= productid %>';
    var productImage = '<%= productImage1 %>';
    var productName = '<%= productName %>';

    var queryString = 'customerId=' + encodeURIComponent(customerId) +
                      '&productId=' + encodeURIComponent(productId) +
                      '&productImage=' + encodeURIComponent(productImage) +
                      '&productName=' + encodeURIComponent(productName);

    window.location.href = 'addQuestion.jsp?' + queryString;
});
function editReview(reviewId) {
    const newTitle = prompt('수정할 리뷰 제목을 입력하세요.');
    if (newTitle !== null) {
        const newContent = prompt('수정할 리뷰 내용을 입력하세요.');
        if (newContent !== null) {
            $.ajax({
                type: 'POST',
                url: 'editReview_process.jsp',
                data: {
                    reviewId: reviewId,
                    title: newTitle,
                    content: newContent
                },
                success: function(response) {
                    alert('리뷰가 수정되었습니다.');
                    location.reload();
                },
                error: function(error) {
                    console.log(error);
                    alert('오류가 발생했습니다.');
                }
            });
        }
    }
}

function deleteReview(reviewId) {
    if (confirm("정말로 삭제하시겠습니까?")) {
        $.ajax({
            type: 'POST',
            url: 'deleteReview_process.jsp',
            data: {
                reviewId: reviewId
            },
            success: function(response) {
                alert('리뷰가 삭제되었습니다.');
                location.reload();
            },
            error: function(error) {
                console.log(error);
                alert('오류가 발생했습니다.');
            }
        });
    }
}

</script>
</body>
</html>