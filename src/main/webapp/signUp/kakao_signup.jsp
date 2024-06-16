<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>카카오 계정 등록</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 0;
            padding: 0;
            background-color: #FEE500; /* 카카오 스타일 배경색 */
            overflow-y: scroll;
        }

        .signup-container {
            width: 300px;
            margin: 100px auto;
            padding: 20px;
            border-radius: 8px;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .signup-container input[type="text"],
        .signup-container input[type="password"],
        .signup-container input[type="email"],
        .signup-container input[type="num"],
        .signup-container input[type="name"][placeholder="이름"],
        .signup-container input[type="date"],
        .signup-container input[type="address"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .signup-container input[type="button"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #3C1E1E;
            border-radius: 5px;
            background-color: #3C1E1E;
            color: white;
            cursor: pointer;
        }

        .signup-container input[type="button"]:hover {
            background-color: #2D1B1B;
        }

        .signup-container select {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .signup-container #sample6_postcode,
        .signup-container #sample6_address,
        .signup-container #sample6_detailAddress,
        .signup-container #sample6_extraAddress {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .signup-container #sample6_postcode {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .signup-container #sample6_postcode + input[type="button"] {
            width: calc(100% - 20px);
            margin-top: 10px;
            font-size: 10px;
        }

        .signup-button {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
            background-color: #3C1E1E; /* 카카오 스타일 버튼색 */
            color: white;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
        }

        .signup-button:hover {
            background-color: #2D1B1B;
        }
         .hidden {
            display: none;
        }
    </style>
</head>
<body>
<%
    String id = request.getParameter("id");
    String email = request.getParameter("email");
    String name = request.getParameter("name");
%>
    <form action="kakao_signup_process.jsp" method="post">
        <div class="signup-container">
            <h2>카카오 계정 등록</h2>
            <input id='id' type="hidden" placeholder="아이디" name="username" value="<%=id%>" class="hidden">
            <input type="name" placeholder="이름" name="name" value="<%= name %>" readonly><br>
            <input type="date" name="birthdate"><br>
            <input type="email" placeholder="이메일" name="email" value="<%= email %>" readonly><br>
            <input type="num" placeholder="전화번호" name="phone"><br>
            <input type="text" id="sample6_postcode" placeholder="우편번호" name="postcode">
            <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
            <input type="text" id="sample6_address" placeholder="주소" name="address"><br>
            <input type="text" id="sample6_detailAddress" placeholder="상세주소" name="address_1">
            <input type="text" id="sample6_extraAddress" placeholder="참고항목">
            <input type="submit" class="signup-button" value="카카오 계정 등록">
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
</script>
</body>
</html>
