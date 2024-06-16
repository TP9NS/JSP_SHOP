<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>로그인</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 20px;
            padding: 0;
            background-color: lightblue;
            overflow-y: scroll;
        }

        .login-container {
            width: 270px;
            margin: 100px auto;
            margin-top: 100px;
            border: 2px solid #ccc;
            padding: 20px;
            border-radius: 8px;
            background-color: white;
        }

        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: calc(100% - 22px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .login-button {
            width: calc(100% - 22px);
            padding: 10px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
            cursor: pointer;
        }

        .login-button:hover {
            background-color: #0056b3;
        }

        .search button {
            width: 48%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: initial;
            color: #007bff;
            cursor: pointer;
            border-bottom: 1px solid transparent;
            text-decoration: none; /* 밑줄 제거 */
        }

        .search button:hover {
            background-color: initial;
            text-decoration: underline; /* 마우스 오버시 밑줄 표시 */
        }

        .kakao-login-button {
            width: calc(100% - 22px);
            padding: 10px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
            background-color: #FEE500;
            color: #3C1E1E;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
        }

        .kakao-login-button:hover {
            background-color: #E5C900;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <!-- Kakao JavaScript SDK -->
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script>
        // Kakao 초기화
        Kakao.init('a5757e5b695a40a7882df49fae3531b3');

        function loginWithKakao() {
            Kakao.Auth.login({
                success: function(authObj) {
                    Kakao.API.request({
                        url: '/v2/user/me',
                        success: function(response) {
                            // 사용자 정보를 서버로 전송
                            $.ajax({
                                type: 'POST',
                                url: 'kakao_login_process.jsp',
                                data: {
                                	id: response.id,
                                    nickname: response.properties.nickname,
                                    email: response.kakao_account.email
                                },
                                
                                success: function(result) {
                                    if (result.trim() === "login_success") {
                                        alert('로그인 성공');
                                        location.href = '/SHOP/main/main.jsp';
                                    }else if (result.trim() === "signup_required") {
                                        alert('회원가입이 필요합니다.');
                                        location.href = '/SHOP/signUp/kakao_signup.jsp?id=' + response.id + '&email=' + response.kakao_account.email+'&name='+response.properties.nickname;
                                    } else {
                                        alert('로그인 실패');
                                    }
                                },
                                error: function(error) {
                                    console.log(error);
                                    alert('오류가 발생했습니다.');
                                }
                            });
                        },
                        fail: function(error) {
                            console.log(error);
                        }
                    });
                },
                fail: function(err) {
                    alert(JSON.stringify(err));
                }
            });
        }
    </script>
</head>
<body>
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
<form action="login_process.jsp" method="post">
    <div class="login-container">
        <h2>로그인</h2>
        <input type="text" name="Username" placeholder="아이디"><br>
        <input type="password" name="Password" placeholder="비밀번호"><br>
        
        <input type="submit" value="로그인" class="login-button">
        <button type="button" class="kakao-login-button" onclick="loginWithKakao()">카카오로 로그인</button>
        <div class="search">
              <a href="findId.jsp" class="btn btn-primary">아이디 찾기</a>
              <a href="findPasswd.jsp" class="btn btn-primary">비밀번호 찾기</a>
        </div>
    </div>
 </form>
</body>
</html>
