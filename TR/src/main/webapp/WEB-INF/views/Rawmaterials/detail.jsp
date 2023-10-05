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
<h1>상세보기</h1>

<!-- table -->
<table border="1">
<tr><td>원자재코드</td>	<td>${rawmaterialsDTO.rawCode}</td></tr>
<tr><td>원자재명</td>	<td>${rawmaterialsDTO.rawName}</td></tr>
<tr><td>종류</td>		<td>${rawmaterialsDTO.rawType}</td></tr>
<tr><td>단위</td>		<td>${rawmaterialsDTO.rawUnit}</td></tr>
<tr><td>매입단가</td>	<td>${rawmaterialsDTO.rawPrice}</td></tr>
<tr><td>거래처</td>	<td>${rawmaterialsDTO.clientCode}</td></tr>
<tr><td>창고명</td>	<td>${rawmaterialsDTO.whseCode}</td></tr>
<tr><td>비고</td>		<td>${rawmaterialsDTO.rawMemo}</td></tr>
<tr><td>작성자</td>	<td>작성자</td></tr>
<tr><td>작성일자</td>	<td>작성일자</td></tr>
</table>

<!-- button -->
<input type="button" value="수정" onclick="location.href='${pageContext.request.contextPath}/Rawmaterials/update?a1=${rawmaterialsDTO.a1}'">
<input type="button" value="목록" onclick="location.href='${pageContext.request.contextPath}/Rawmaterials/home'">

</body>
</html>
