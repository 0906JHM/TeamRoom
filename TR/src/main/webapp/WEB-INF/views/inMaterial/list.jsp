<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 사이드바 -->
<link href="${pageContext.request.contextPath }/resources/css/side.css"
	rel="stylesheet" type="text/css">

<title>inMaterial</title>
</head>
<body>
<h2>입고관리</h2>
<div>
	<form method="get">
		<label>입고번호</label>
		<label>품명</label>
		<label>거래처명</label>
		
		<input type="submit" value="조회">
		
		<button type="submit" value=""><span>전체</span></button>
		<input type="submit" value="미입고"></input> 
        <input type="submit" value="입고완료"></input> 
	</form>
</div>
</body>
</html>