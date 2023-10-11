<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인사수정</title>
</head>
<body>
<h1>인사수정</h1>
<form action="${pageContext.request.contextPath}/employees/updatePro" id="join" method="post">

사원번호:<input type="text" name="empId" class="empId" value="${employeesDTO.empId}"><br>
비밀번호:<input type="password" name="empPass" class="empPass" value="${employeesDTO.empPass}"><br>
사원명:<input type="text" name="empName" class="empName" value="${employeesDTO.empName}"><br>
부서:<input type="text" name="empDepartment" class="empDepartment" value="${employeesDTO.empDepartment}"><br>
직책:<input type="text" name="empPosition" class="empPosition" value="${employeesDTO.empPosition}"><br>
이메일:<input type="email" name="empEmail" class="empEmail" value="${employeesDTO.empEmail}"><br>
전화번호:<input type="number" name="empTel" class="empTel" value="${employeesDTO.empTel}"><br>
입사일자:<input type="date" name="empHiredate" class="empHiredate" value="${employeesDTO.empHiredate}"><br>
재직구분:<input type="text" name="empState" class="empState" value="${employeesDTO.empState}"><br>
<button onclick="save">수정하기</button>

</form>
</body>
</html>