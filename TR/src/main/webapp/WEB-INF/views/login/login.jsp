<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login</title>
<%-- <link href="${pageContext.request.contextPath}/resources/css/sell.css" rel="stylesheet" type="text/css">
 --%>
<style type="text/css">
body {
	font-family: Arial, sans-serif;
	background-color: #F5F6FA;
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.login-container {
	background-color: #fff;
	border-radius: 5px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	text-align: center;
	padding: 20px;
	width: 300px;
}

h2 {
	color: #384855;
}

.input-group {
	margin-bottom: 20px;
}

input[type="text"], input[type="password"] {
	width: 80%;
	padding: 10px;
	border-radius: 3px;
	outline: none;
	border: 1px solid #A6A6A6; /* 테두리 색 설정 */
	background-color: #FFFFFF; /* 배경색 설정 */
}

button {
	width: 55px;
	height: 25px;
	background-color: #5EC397;
	color: #FFFFFF;
	border: none;
	border-radius: 3px;
	margin-bottom: 10px;
}

button:hover {
	background-color: #31433B;
	color: white;
}


</style>
</head>
<body>
	<div class="login-container">
		<h2>로그인</h2>
		<form action="${pageContext.request.contextPath}/login/loginPro" id="login" method="post">
			
			<div class="input-group">
				<input type="text" id="empId" name="empId" placeholder="아이디" required>
			</div>
	
			<div class="input-group">
				<input type="password" id="empPass" name="empPass" placeholder="비밀번호" required> 
				<%-- <input type="hidden" name="empName" value="${loginDTO.empName}" /> --%>
			</div>
		
			<button type="submit">로그인</button>
		</form>
	</div>
</body>
<script>
document.getElementById("login").addEventListener("submit", function (event) {
    var empId = document.getElementById("empId").value;
    var empPass = document.getElementById("empPass").value;

    // 여기에서 실제 아이디와 비밀번호를 확인하는 로직을 구현해야 합니다.
    // 이 예제에서는 간단하게 아이디와 비밀번호가 "올바른아이디"와 "올바른비밀번호"인 경우를 가정하겠습니다.
    if (empId !== ${loginDTO.getEmpId()} || empPass !== ${loginDTO.getEmpPass()}) {
        event.preventDefault(); // 폼 제출을 막습니다.

        // 아이디와 비밀번호가 틀렸을 때 알림을 표시합니다.
        alert("계정 정보를 다시 확인해주세요");
    }
});
</script>

</html>
