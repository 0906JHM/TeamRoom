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
<h1>품목추가</h1>

<!-- form -->
<form action="${pageContext.request.contextPath}/Rawmaterials/insertPro" method="post">
원자재코드 : 	<input type="text" name="rawCode"><br>
원자재명 : 		<input type="text" name="rawName"><br>
종류 : 		<input type="text" name="rawType"><br>
단위 : 		<input type="text" name="rawUnit"><br>
매입단가 : 		<input type="text" name="rawPrice"><br>
거래처 : 		<input type="text" name="clientCode"><br>
창고명 : 		<input type="text" name="whseCode"><br>
비고 : 		<input type="text" name="rawMemo"><br>

<input type="submit" value="품목추가">
</form>

</body>
</html>