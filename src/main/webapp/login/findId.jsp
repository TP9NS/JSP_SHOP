<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기</title>
    <style>
        /* 기존 스타일 추가 */
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
        .login-container input[type="password"],
        .login-container input[type='date'] {
            width: calc(100% - 22px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .login-container button {
            width: calc(100% - 22px);
            padding: 10px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
            cursor: pointer;
        }

        .login-container button:hover {
            background-color: #0056b3;
        }

        /* 추가된 부분: 아이디 찾기 및 비밀번호 찾기 버튼 스타일 */
        .login-container a {
            display: block;
            margin-top: 10px;
            text-decoration: none;
            color: #007bff;
        }

        .login-container a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>아이디 찾기</h2>
        <!-- 추가된 부분: 텍스트 필드 및 버튼 -->
        <input type="text" id="name" name="name" placeholder="이름"><br>
        <input type="date" id="birth" name="birth" placeholder="ex: 2010-10-10"><br>
        <input type="text" id="email" name="email" placeholder="ex: hongildong@naver.com"><br>
        <button onclick="findId()">아이디 찾기</button>
        <!-- 추가된 부분: 로그인 페이지로 돌아가는 버튼 -->
        <a href="/SHOP/login/login.jsp" style="text-decoration: none; color: #007bff;">로그인 페이지로 돌아가기</a>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
        function findId() {
            var name = $('#name').val();
            var birth = $('#birth').val();
            var email = $('#email').val();
            
            $.ajax({
                type: 'POST',
                url: 'findId_process.jsp',
                data: {
                    name: name,
                    birth: birth,
                    email: email
                },
                success: function(response) {
                    alert(response.trim());
                },
                error: function(error) {
                    console.log(error);
                    alert('오류가 발생했습니다.');
                }
            });
        }
    </script>
</body>
</html>
