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
	<td><input type="text" name="rawCode" value="${rawmaterialsDTO.rawCode}" readonly></td></tr>
<tr><td>원자재명</td>
    <td><input type="text" name="rawName" value="${rawmaterialsDTO.rawName}"></td></tr>
<tr><td>종류</td>
    <td><input type="text" name="rawType" value="${rawmaterialsDTO.rawType}"></td></tr>
<tr><td>단위</td>
    <td><input type="text" name="rawUnit" value="${rawmaterialsDTO.rawUnit}"></td></tr>
<tr><td>매입단가</td>
    <td><input type="text" name="rawPrice" value="${rawmaterialsDTO.rawPrice}"></td></tr>
<tr><td>거래처</td>
    <td><input type="text" name="clientCode" value="${rawmaterialsDTO.clientCode}"></td></tr>
<tr><td>창고명</td>
    <td><input type="text" name="whseCode" value="${rawmaterialsDTO.whseCode}"></td></tr>
<tr><td>비고</td>
	<td><textarea name="rawMemo" rows="10" cols="15">${rawmaterialsDTO.rawMemo}</textarea></td></tr>
</table>

<input type="submit" value="수정">

</form>
</body>
</html>