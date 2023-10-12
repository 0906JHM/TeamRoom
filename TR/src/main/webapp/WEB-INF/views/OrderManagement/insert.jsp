<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!-- head -->
<head>
<meta charset="UTF-8">  
<title>Insert title here</title>
</head>

<!-- body -->
<body>
<h1>발주등록</h1>

<!-- form -->
<form action="${pageContext.request.contextPath}/OrderManagement/insertPro" method="post">
<!-- 발주번호 : 		<input type="text" name="buyNum"><br> -->
품번 : 		<input type="text" name="rawCode"><br>
품명 : 		<input type="text" name="rawName"><br>
종류 : 		<input type="text" name="rawType"><br>
거래처명 : 		<input type="text" name="clientCode"><br>
창고수량 : 		<input type="text" name="whseCount"><br>
발주수량 : 		<input type="text" name="buyCount"><br>
납입단가 : 		<input type="text" name="rawPrice"><br>
발주신청일 : 	<input type="date" name="buyDate"><br>
담당자 : 		<input type="text" name="buyEmpId"><br>
입고상태 : 		<input type="radio" name="buyInstate" value="발주완료" checked>발주완료<br>

<input type="submit" value="발주등록">
</form>
</body>
</html>