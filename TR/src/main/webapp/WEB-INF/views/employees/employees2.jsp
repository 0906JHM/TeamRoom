<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인사등록</title>
</head>
<body>
<h1>인사등록</h1>
<form action="${pageContext.request.contextPath}/employees/insertPro" id="join" method="post">

사원번호:<input type="number" name="empId" class="empId"><br>
비밀번호:<input type="password" name="empPass" class="empPass"><br>
사원명:<input type="text" name="empName" class="empName"><br>
부서:<input type="text" name="empDepartment" class="empDepartment"><br>
직책:<input type="text" name="empPosition" class="empPosition"><br>
이메일:<input type="email" name="empEmail" class="empEmail"><br>
전화번호:<input type="number" name="empTel" class="empTel"><br>
입사일자:<input type="date" name="empHiredate" class="empHiredate"><br>
재직구분:<input type="text" name="empState" class="empState"><br>
<button onclick="save">저장하기</button>

</form>
</body>
</html>