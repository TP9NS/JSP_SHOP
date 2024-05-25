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

        /* 아이디, 이메일 입력 칸 */
        .signup-container input[type="text"] {
            width: calc(56% - 1px);
            padding: 10px;
            margin: 10px 2px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        /* 변경된 입력 칸 */
        .signup-container input[type="email"],
        .signup-container input[type="password"],
        .signup-container input[type="address"],
        .signup-container input[type="num"],
        .signup-container input[type="name"][placeholder="이름"],
        .signup-container input[type="date"] {
            width: calc(100% - 22px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        /* 중복 확인 버튼 스타일 */
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

        /* 도메인 선택 스타일 */
        .signup-container select {
            width: calc(100% - 8px);
            padding: 10px;
            margin: 10px 2px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
/* 주소 입력 칸 스타일 */
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
		.signup-container #sample6_postcode{
			width: calc(56% - 1px);
            padding: 10px;
            margin: 10px 2px;
            border: 1px solid #ccc;
            border-radius: 5px;
		}
        /* 우편번호 찾기 버튼 스타일 */
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
                <input id='id' type="text" placeholder="아이디" name="username">
                <input type="button" onclick="checkDuplicate()" value="중복 확인">
            </div>
            <!-- 변경된 크기 -->
            <input type="password" placeholder="비밀번호" name="password"><br>
            <input type="name" placeholder="이름" name="name"><br>
            <input type="date" name="birthdate"><br>
            <input type="email" placeholder="이메일" name="email">
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
        
    </script>

</body>
</html>
