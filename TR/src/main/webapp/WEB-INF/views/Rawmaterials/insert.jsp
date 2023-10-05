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
원자재코드 : 	<input type="text" name="a1"><br>
원자재명 : 		<input type="text" name="a2"><br>
종류 : 		<input type="text" name="a3"><br>
단위 : 		<input type="text" name="a4"><br>
매입단가 : 		<input type="text" name="a5"><br>
거래처 : 		<input type="text" name="a6"><br>
창고명 : 		<input type="text" name="a7"><br>
비고 : 		<input type="text" name="a8"><br>

<input type="submit" value="품목추가">
</form>

</body>
</html>