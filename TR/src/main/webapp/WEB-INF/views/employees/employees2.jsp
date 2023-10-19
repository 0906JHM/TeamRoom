<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인사등록</title>
<link href="${pageContext.request.contextPath }/resources/css/employees2.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="container"> 
<h2>인사등록</h2>
<form action="${pageContext.request.contextPath}/employees/insertPro" id="join" method="post">

<div class="form-group">
<p>사원번호:</p>
<input type="number" name="empId" class="empId">
</div>
<div class="form-group"><p>비밀번호:</p><input type="password" name="empPass" class="empPass"></div>
<div class="form-group"><p>사원명:</p><input type="text" name="empName" class="empName"></div>
<div class="form-group"><p>부서:</p><input type="text" name="empDepartment" class="empDepartment"></div>
<div class="form-group"><p>직책:</p><input type="text" name="empPosition" class="empPosition"></div>
<div class="form-group"><p>이메일:</p><input type="email" name="empEmail" class="empEmail"></div>
<div class="form-group"><p>전화번호:</p><input type="number" name="empTel" class="empTel"></div>
<div class="form-group"><p>입사일자:</p><input type="date" name="empHiredate" class="empHiredate"></div>
<div class="form-group"><p>재직구분:</p><input type="text" name="empState" class="empState"></div>
<button onclick="save">저장하기</button>

</form>
</div>
</body>
</html>