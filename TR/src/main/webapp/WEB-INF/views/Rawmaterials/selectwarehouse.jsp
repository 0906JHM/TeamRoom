<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<h1>창고</h1>

<input id="cInput" type="hidden">

<!-- javascript -->
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<script type="text/javascript">

//자식에서 부모페이지로 값 넣기
function setParentText(){
	opener.document.getElementById("pInput2").value = document.getElementById("cInput").value
	window.close();
}
</script>

<!-- form(검색) -->
<form action="${pageContext.request.contextPath}/Rawmaterials/selectwarehouse" method="get">
창고코드	<input type="text" name="search1" placeholder="창고코드">
창고이름	<input type="text" name="search2" placeholder="창고이름">
창고주소	<input type="text" name="search3" placeholder="창고주소">
원자재코드	<input type="text" name="search4" placeholder="창고주소">
<input type="submit" value="검색">
</form>

<!-- table -->
<table border="1">
<tr>
<td>창고코드</td>
<td>창고이름</td>
<td>창고타입</td>
<td>창고상태</td>
<td>창고주소</td>
<td>창고비고</td>
<td>재고개수</td>
<td>원자재코드</td>
<td>창고연락처</td>
<td>창고관리사원</td>
</tr>

<c:forEach var="warehouseDTO" items="${warehouseList}">
<tr onclick="document.getElementById('cInput').value='${warehouseDTO.whseCode}'; setParentText();">
<td>${warehouseDTO.whseCode}</td>
<td>${warehouseDTO.whseName}</td>
<td>${warehouseDTO.whseType}</td>
<td>${warehouseDTO.whseState}</td>
<td>${warehouseDTO.whseAddr}</td>
<td>${warehouseDTO.whseMemo}</td>
<td>${warehouseDTO.whseCount}</td>
<td>${warehouseDTO.rawCode}</td>
<td>${warehouseDTO.whseTel}</td>
<td>${warehouseDTO.whseEmpId}</td>
</tr>
</c:forEach>
</table>

<!-- 페이징처리 -->
<c:forEach var="i" begin="${pageDTO.startPage}" end="${pageDTO.endPage}" step="1">
<a href="${pageContext.request.contextPath}/Rawmaterials/selectwarehouse?pageNum=${i}&search1=${pageDTO.search1}">${i}</a> 
</c:forEach>

</body>
</html>