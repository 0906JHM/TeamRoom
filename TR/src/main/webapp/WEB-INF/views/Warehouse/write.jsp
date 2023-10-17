<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>추가</title>

<link href="${pageContext.request.contextPath }/resources/css/warehousewrite.css"
	rel="stylesheet" type="text/css">
</head>
<body>

<div class="container">
	<h2>창고 등록</h2>

	<form action="${pageContext.request.contextPath}/Warehouse/writePro "
		method="post">
		
		<div class="form-group">
		<p>창고코드</p>
		<input type="text" name="whseCode"> 
		</div>
		
		<div class="form-group">
		<p> 창고이름</p>
		 <input	type="text" name="whseName">  
		 </div>
		 
		 <div class="form-group">
		 <p>창고 타입</p> 
		 <select	name="whseType">
			<option value="원자재">원자재</option>
			<option value="완제품">완제품</option>
		</select>  
		</div>
		
		<div class="form-group">
		<p>창고 사용 상태</p>
		 <select name="whseState">
			<option value="Y">Y</option>
			<option value="N">N</option>
		</select>
		</div>
		<div class="form-group">
		<p> 창고 주소</p>
		 <input type="text" name="whseAddr"> 
		 </div>
		 <div class="form-group">
		<p>창고 연락처</p>
		 <input type="text" name="whseTel"> 
		 </div>
		 <div class="form-group"> 
		 <p>창고 관리사원 아이디</p> 
		 <input type="text" name="whseEmpId"> 
		 </div>
		 <div class="form-group">
		 <p> 창고 비고</p>
		<input type="text" name="whseMemo">  
		</div>
		 <div id="button">
		 <input type="submit" value="창고등록">
		 </div>
	</form>
</body>
</div>
</html>