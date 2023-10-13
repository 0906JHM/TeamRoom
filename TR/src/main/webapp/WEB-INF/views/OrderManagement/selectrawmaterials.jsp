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
<h1>원자재</h1>

<input id="rawCode" type="hidden"><input id="rawName" type="hidden"><input id="rawType" type="hidden"><input id="whseCount" type="hidden">
<input id="rawPrice" type="hidden">

<!-- javascript -->
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<script type="text/javascript">
function setParentText(){
	opener.document.getElementById("rawCode").value = document.getElementById("rawCode").value;
	opener.document.getElementById("rawName").value = document.getElementById("rawName").value;
	opener.document.getElementById("rawType").value = document.getElementById("rawType").value;
	opener.document.getElementById("whseCount").value = document.getElementById("whseCount").value;
	opener.document.getElementById("rawPrice").value = document.getElementById("rawPrice").value;
	window.close();
}
console.log
</script>

<!-- form(검색) -->
<form action="${pageContext.request.contextPath}/OrderManagement/selectrawmaterials" method="get">
원자재코드	<input type="text" name="search1" placeholder="원자재코드">
원자재명	<input type="text" name="search2" placeholder="원자재명">
종류		<select name="search3">
		<option value="">전체</option>
		<option value="향기">향기</option>
		<option value="용기">용기</option>
		<option value="스틱">스틱</option>
		<option value="라벨">라벨</option>
		<option value="포장재">포장재</option>
		</select>
거래처		<input type="text" name="search4" placeholder="거래처" onclick="openPopup3()">
<input type="submit" value="검색">
</form>

<!-- table -->
<table border="1">
<tr>
<td>번호</td>
<td>원자재코드</td>
<td>원자재명</td>
<td>종류</td>
<td>단위</td>
<td>매입단가</td>
<td>거래처</td>
<td>창고명</td>
<td>재고</td>
<td>비고</td>
</tr>

<c:forEach var="rawmaterialsDTO" items="${rawmaterialsList}">
<tr onclick="document.getElementById('rawCode').value = '${rawmaterialsDTO.rawCode}'; document.getElementById('rawName').value = '${rawmaterialsDTO.rawName}'; document.getElementById('rawType').value = '${rawmaterialsDTO.rawType}'; document.getElementById('rawPrice').value = '${rawmaterialsDTO.rawPrice}'; document.getElementById('whseCount').value = '${rawmaterialsDTO.whseCount}'; setParentText();">
<td>${rawmaterialsDTO.rawNum}</td>
<td>${rawmaterialsDTO.rawCode}</td>
<td>${rawmaterialsDTO.rawName}</td>
<td>${rawmaterialsDTO.rawType}</td>
<td>${rawmaterialsDTO.rawUnit}</td>
<td>${rawmaterialsDTO.rawPrice}</td>
<td>${rawmaterialsDTO.clientCode}</td>
<td>${rawmaterialsDTO.whseCode}</td>
<td>${rawmaterialsDTO.whseCount}</td>
<td>${rawmaterialsDTO.rawMemo}</td>
</tr>
</c:forEach>
</table>

<!-- 페이징처리 -->
<c:forEach var="i" begin="${pageDTO.startPage}" end="${pageDTO.endPage}" step="1">
<a href="${pageContext.request.contextPath}/OrderManagement/selectrawmaterials?pageNum=${i}&search1=${pageDTO.search1}">${i}</a> 
</c:forEach>

</body>
</html>