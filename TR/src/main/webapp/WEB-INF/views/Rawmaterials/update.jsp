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
<h1>수정하기</h1>

<!-- from -->
<form action="${pageContext.request.contextPath}/Rawmaterials/updatePro" method="post">

<!-- table -->
<table border="1">
<tr><td>원자재코드</td>
	<td><input type="text" name="a1" value="${rawmaterialsDTO.a1}" readonly></td></tr>
<tr><td>원자재명</td>
    <td><input type="text" name="a2" value="${rawmaterialsDTO.a2}"></td></tr>
<tr><td>종류</td>
    <td><input type="text" name="a3" value="${rawmaterialsDTO.a3}"></td></tr>
<tr><td>단위</td>
    <td><input type="text" name="a4" value="${rawmaterialsDTO.a4}"></td></tr>
<tr><td>매입단가</td>
    <td><input type="text" name="a5" value="${rawmaterialsDTO.a5}"></td></tr>
<tr><td>거래처</td>
    <td><input type="text" name="a6" value="${rawmaterialsDTO.a6}"></td></tr>
<tr><td>창고명</td>
    <td><input type="text" name="a7" value="${rawmaterialsDTO.a7}"></td></tr>
<tr><td>비고</td>
	<td><textarea name="a8" rows="10" cols="15">${rawmaterialsDTO.a8}</textarea></td></tr>
</table>

<input type="submit" value="수정">

</form>
</body>
</html>