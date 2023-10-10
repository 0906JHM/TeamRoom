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
			
			<div class="input-group">
				<input type="checkbox" ${empty cookie.id.value ? "":"checked" }
					class="custom-control-input" id="customCheck"> <label
					class="custom-control-label" for="customCheck">아이디 기억하기</label>
			</div>
			
			<button type="submit">로그인</button>
		</form>
	</div>
</body>
</html>

<script type="text/javascript">
// 아이디기억하기
$(document).ready(function(){
  
     
    var key = getCookie("key");
    $("#InputempNum").val(key); 
      
    if($("#InputempNum").val() != ""){
        $("#customCheck").attr("checked", true); 
    }
      
    $("#customCheck").change(function(){ 
        if($("#customCheck").is(":checked")){ 
            setCookie("key", $("#InputempNum").val(), 7); 
        }else{ 
            deleteCookie("key");
        }
    });
      
    
    $("#InputempNum").keyup(function(){ 
        if($("#customCheck").is(":checked")){ 
            setCookie("key", $("#InputempNum").val(), 7); 
        }
    });
});
  
function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}
  
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}
  
function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}

</script>