<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>회원가입</title>
    <style>
        /* 회원가입 폼 스타일 */
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 20px;
            padding: 0;
            background-color: lightblue;
            overflow-y: scroll;
        }

        .signup-container {
            width: 270px;
            margin: 100px auto;
            margin-top: 100px;
            border: 2px solid #ccc;
            padding: 20px;
            border-radius: 8px;
            background-color: white;
        }

        .signup-container input[type="text"],
        .signup-container input[type="password"],
        .signup-container input[type="email"],
        .signup-container input[type="num"],
        .signup-container input[type="name"][placeholder="이름"],
        .signup-container input[type="date"],
        .signup-container input[type="address"] {
            width: calc(100% - 22px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .signup-container input[type="button"] {
            width: calc(30% - 2px);
            padding: 10px;
            margin: 10px 2px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
            cursor: pointer;
        }

        .signup-container select {
            width: calc(100% - 8px);
            padding: 10px;
            margin: 10px 2px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .signup-container #sample6_postcode,
        .signup-container #sample6_address,
        .signup-container #sample6_detailAddress,
        .signup-container #sample6_extraAddress {
            width: calc(100% - 22px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .signup-container #sample6_postcode {
            width: calc(56% - 1px);
            padding: 10px;
            margin: 10px 2px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .signup-container #sample6_postcode + input[type="button"] {
            width: calc(30% - 2px);
            margin-top: 10px;
            font-size: 10px;
        }

        .signup-button {
            width: calc(50% - 2px);
            padding: 10px;
            margin: 10px 2px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
            cursor: pointer;
        }

        .valid {
            border-color: green;
        }

        .invalid {
            border-color: red;
        }

        .hidden {
            display: none;
        }
    </style>
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
    <form action="signup_process.jsp" method="post">
        <div class="signup-container">
            <h2>회원가입</h2>
            <div class="button-and-domain">
                <input id='id' type="text" placeholder="아이디" name="username" oninput="validateUsername()">
                <input type="button" onclick="checkDuplicate()" value="중복 확인">
                <span id="usernameError" class="hidden" style="color: red;">아이디는 8~16자 영문자와 숫자의 조합이어야 합니다.</span>
            </div>
            <input type="password" placeholder="비밀번호" name="password" id="password" oninput="validatePassword()"><br>
            <span id="passwordError" class="hidden" style="color: red;">비밀번호는 8~16자에 특수문자가 포함되어야 합니다.</span>
            <input type="password" placeholder="비밀번호 확인" id="confirmPassword" oninput="validatePasswordMatch()"><br>
            <span id="passwordMatchError" class="hidden" style="color: red;">비밀번호가 일치하지 않습니다.</span>
            <input type="name" placeholder="이름" name="name"><br>
            <input type="date" name="birthdate"><br>
            <input type="email" placeholder="이메일" name="email"><br>
            <input type="num" placeholder="전화번호" name="phone"><br>
            <input type="text" id="sample6_postcode" placeholder="우편번호" name="postcode" >
            <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
            <input type="text" id="sample6_address" placeholder="주소" name="address"><br>
            <input type="text" id="sample6_detailAddress" placeholder="상세주소" name="address_1">
            <input type="text" id="sample6_extraAddress" placeholder="참고항목">
            <input type="submit" class="signup-button" value="회원가입">
        </div>
    </form>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        function sample6_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    var addr = '';
                    var extraAddr = '';

                    if (data.userSelectedType === 'R') {
                        addr = data.roadAddress;
                    } else {
                        addr = data.jibunAddress;
                    }

                    if (data.userSelectedType === 'R') {
                        if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                            extraAddr += data.bname;
                        }
                        if (data.buildingName !== '' && data.apartment === 'Y') {
                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        if (extraAddr !== '') {
                            extraAddr = ' (' + extraAddr + ')';
                        }
                        document.getElementById("sample6_extraAddress").value = extraAddr;
                    } else {
                        document.getElementById("sample6_extraAddress").value = '';
                    }

                    document.getElementById('sample6_postcode').value = data.zonecode;
                    document.getElementById("sample6_address").value = addr;
                    document.getElementById("sample6_detailAddress").focus();
                }
            }).open();
        }

        function checkDuplicate() {
            var id = document.getElementById('id').value;
            
            // 서버로 아이디 중복 확인 요청
            $.ajax({
                type: 'POST',
                url: 'checkDuplicate.jsp',
                data:{ id: id },
                success: function(response) {
                    // 결과를 확인하여 처리
                    if (response.message === "exist") {
                        alert('이미 사용 중인 아이디입니다.');
                    } else if (response.message === "not_exist") {
                        alert('사용 가능한 아이디입니다.');
                    } else {
                        alert('오류가 발생했습니다.');
                    }
                },
                error: function(error) {
                    console.log(error);
                    // 오류 처리
                    alert('오류가 발생했습니다.');
                }
            });
        }

        function validateUsername() {
            var username = document.getElementById('id').value;
            var regex = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{8,16}$/;
            if (regex.test(username)) {
                document.getElementById('id').classList.remove('invalid');
                document.getElementById('id').classList.add('valid');
                document.getElementById('usernameError').classList.add('hidden');
            } else {
                document.getElementById('id').classList.remove('valid');
                document.getElementById('id').classList.add('invalid');
                document.getElementById('usernameError').classList.remove('hidden');
            }
        }

        function validatePassword() {
            var password = document.getElementById('password').value;
            var regex = /^(?=.*[!@#$%^&*(),.?":{}|<>])[a-zA-Z\d!@#$%^&*(),.?":{}|<>]{8,16}$/;
            if (regex.test(password)) {
                document.getElementById('password').classList.remove('invalid');
                document.getElementById('password').classList.add('valid');
                document.getElementById('passwordError').classList.add('hidden');
            } else {
                document.getElementById('password').classList.remove('valid');
                document.getElementById('password').classList.add('invalid');
                document.getElementById('passwordError').classList.remove('hidden');
            }
            validatePasswordMatch();
        }

        function validatePasswordMatch() {
            var password = document.getElementById('password').value;
            var confirmPassword = document.getElementById('confirmPassword').value;
            if (password === confirmPassword && password !== "") {
                document.getElementById('confirmPassword').classList.remove('invalid');
                document.getElementById('confirmPassword').classList.add('valid');
                document.getElementById('passwordMatchError').classList.add('hidden');
            } else {
                document.getElementById('confirmPassword').classList.remove('valid');
                document.getElementById('confirmPassword').classList.add('invalid');
                document.getElementById('passwordMatchError').classList.remove('hidden');
            }
        }
    </script>
</body>
</html>
