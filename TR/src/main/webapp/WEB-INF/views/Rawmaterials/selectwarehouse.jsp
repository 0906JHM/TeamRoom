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

<!-- button -->
창고 <input type="text" placeholder="등록할 창고" id="cInput"> <input type="button" value="등록" onclick="setParentText()">

<!-- javascript -->
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<script type="text/javascript">
function setParentText(){
	opener.document.getElementById("pInput2").value = document.getElementById("cInput").value
	window.close();
}
</script>

<!-- form(검색) -->
<form action="${pageContext.request.contextPath}/Rawmaterials/selectwarehouse" method="get">
창고코드	<input type="text" name="search1" placeholder="창고코드">
창고이름	<input type="text" name="search2" placeholder="창고이름">
창고타입	<select name="search3">
		<option value="">전체</option>
		<option value="원자재">원자재</option>
		<option value="완제품">완제품</option>
		</select>
창고주소	<select name="search4">
		<option value="">전체</option>
		<option value="서울">서울</option>
		<option value="부산">부산</option>
		</select>
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