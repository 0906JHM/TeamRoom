<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인사수정</title>
<link href="${pageContext.request.contextPath }/resources/css/employees2.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="container">
<h2>인사수정</h2>
<form action="${pageContext.request.contextPath}/employees/updatePro" id="join" method="post">

<div class="form-group"><p>사원번호:</p><input type="text" name="empId" class="empId" value="${employeesDTO.empId}"></div>
<div class="form-group"><p>비밀번호:</p><input type="password" name="empPass" class="empPass" value="${employeesDTO.empPass}"></div>
<div class="form-group"><p>사원명:</p><input type="text" name="empName" class="empName" value="${employeesDTO.empName}"></div>
<div class="form-group">
  <p>부서:</p>
  <select name="empDepartment" class="empDepartment select">
    <option value="인사팀" ${employeesDTO.empDepartment == '인사팀' ? 'selected' : ''}>인사팀</option>
    <option value="영업팀" ${employeesDTO.empDepartment == '영업팀' ? 'selected' : ''}>영업팀</option>
    <option value="자재팀" ${employeesDTO.empDepartment == '자재팀' ? 'selected' : ''}>자재팀</option>
    <option value="생산팀" ${employeesDTO.empDepartment == '생산팀' ? 'selected' : ''}>생산팀</option>
  </select>
</div>
<div class="form-group">
  <p>직책:</p>
  <select name="empPosition" class="empPosition select">
    <option value="사원" ${employeesDTO.empPosition == '사원' ? 'selected' : ''}>사원</option>
    <option value="팀장" ${employeesDTO.empPosition == '팀장' ? 'selected' : ''}>팀장</option>
    <option value="부장" ${employeesDTO.empPosition == '부장' ? 'selected' : ''}>부장</option>
  </select>
</div>
<div class="form-group"><p>이메일:</p><input type="email" name="empEmail" class="empEmail" value="${employeesDTO.empEmail}"></div>
<div class="form-group"><p>전화번호:</p><input type="number" name="empTel" class="empTel" value="${employeesDTO.empTel}"></div>
<div class="form-group"><p>입사일자:</p><input type="date" name="empHiredate" class="empHiredate" value="${employeesDTO.empHiredate}"></div>
<div class="form-group">
  <p>재직구분:</p>
  <select name="empState" class="empState select">
    <option value="재직" ${employeesDTO.empState == '재직' ? 'selected' : ''}>재직</option>
    <option value="휴직" ${employeesDTO.empState == '휴직' ? 'selected' : ''}>휴직</option>
    <option value="퇴사" ${employeesDTO.empState == '퇴사' ? 'selected' : ''}>퇴사</option>
  </select>
</div>
<button onclick="save">수정하기</button>

</form>
</div>
</body>
</html>