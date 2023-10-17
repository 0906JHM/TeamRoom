<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>창고 수정</title>

<link href="${pageContext.request.contextPath }/resources/css/warehousewrite.css"
	rel="stylesheet" type="text/css">
	
</head>
<body>

<div class="container">
	<h2>창고 수정</h2>
	<form action="${pageContext.request.contextPath}/Warehouse/updatePro"
		method="post">

                 <div class="form-group">
				<p>창고코드</p>
				<input type="text" name="whseCode"
				value="${warehouseDTO.whseCode}" readonly>
				</div>
				
                <div class="form-group">
				<p>창고이름</p>
				<input type="text" name="whseName"
				value="${warehouseDTO.whseName}" readonly>
				</div>

                <div class="form-group">
				<p>창고 타입</p>
				<input type="text" name="whseType"
				value=" ${warehouseDTO.whseType}">
				</div>

                <div class="form-group">
				<p>창고 사용 상태</p>
				<input type="text" name="whseState"
				value="${warehouseDTO.whseState}">
				</div>
				
				<div class="form-group">
				<p>창고 주소</p>
				<input type="text" name="whseAddr"
				value=" ${warehouseDTO.whseAddr}">
				</div>
				
				<div class="form-group">
				<p>창고 연락처</p>
				<input type="text" name="whseTel"
				value=" ${warehouseDTO.whseTel}">
				</div>
				
				<div class="form-group">
				<p>창고 관리사원 아이디</p>
				<input type="text" name="whseEmpId"
				value=" ${warehouseDTO.whseEmpId}">
				</div>
				
				<div class="form-group">
				<p>창고비고</p>
				<input type="text" name="whseMemo"
				value=" ${warehouseDTO.whseMemo}">
				</div>
				
				<div id="button">
				<input type="submit" value="수정">
				</div>

	</form>
</body>
</div>
</html>