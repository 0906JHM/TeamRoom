<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!-- head -->
<head>
<meta charset="UTF-8"> 
<title>Insert title here</title>
<link href="${pageContext.request.contextPath }/resources/css/Rawmaterialspop.css" rel="stylesheet" type="text/css">
</head>

<!-- body -->
<body>
<div class="content">
<h2>상세보기</h2>

<!-- table -->
<table>
<tr><td id="td1">원자재코드</td>	<td id="td21">${rawmaterialsDTO.rawCode}</td></tr>
<tr><td id="td1">원자재명</td>		<td id="td22">${rawmaterialsDTO.rawName}</td></tr>
<tr><td id="td1">종류</td>		<td id="td21">${rawmaterialsDTO.rawType}</td></tr>
<tr><td id="td1">단위</td>		<td id="td22">${rawmaterialsDTO.rawUnit}</td></tr>
<tr><td id="td1">매입단가</td>		<td id="td21">${rawmaterialsDTO.rawPrice}</td></tr>
<tr><td id="td1">창고명</td>		<td id="td22">${rawmaterialsDTO.whseCode}</td></tr>
<tr><td id="td1">비고</td>		<td id="td21">${rawmaterialsDTO.rawMemo}</td></tr>
</table>

<!-- button -->
<div id="buttons">
<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자')}">
<input type="button" value="수정" onclick="location.href='${pageContext.request.contextPath}/Rawmaterials/update?rawCode=${rawmaterialsDTO.rawCode}'">
</c:if>
<input type="button" value="목록" onclick="location.href='${pageContext.request.contextPath}/Rawmaterials/home'">
</div>
</div>

</body>
</html>