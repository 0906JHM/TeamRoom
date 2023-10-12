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
<h1>거래처</h1>

<!-- button -->
거래처 <input type="text" placeholder="등록할 거래처" id="cInput"> <input type="button" value="등록" onclick="setParentText()">

<!-- javascript -->
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<script type="text/javascript">
function setParentText(){
	opener.document.getElementById("pInput").value = document.getElementById("cInput").value
	window.close();
}
</script>

<!-- form(검색) -->
<form action="${pageContext.request.contextPath}/Rawmaterials/selectclient" method="get">
거래처코드	<input type="text" name="search1" placeholder="거래처코드">
거래처명	<input type="text" name="search2" placeholder="거래처명">
분류		<select name="search3">
		<option value="">전체</option>
		<option value="수주처">수주처</option>
		<option value="발주처">발주처</option>
		</select>
담당자 	<input type="text" name="search4" placeholder="담당자">
<input type="submit" value="검색">
</form>

<!-- table -->
<table border="1">
<tr>
<td>구분</td>
<td>거래처코드</td>
<td>거래처명</td>
<td>사업자번호</td>
<td>업태</td>
<td>대표자</td>
<td>담당자</td>
<td>거래처주소</td>
<td>상세주소</td>
<td>거래처번호</td>
<td>휴대폰번호</td>
<td>팩스번호</td>
<td>이메일</td>
<td>비고</td>
</tr>

<c:forEach var="clientDTO" items="${clientList}">
<tr onclick="document.getElementById('cInput').value='${clientDTO.clientCode}'; setParentText();">
<td>${clientDTO.clientType}</td>
<td>${clientDTO.clientCode}</td>
<td>${clientDTO.clientCompany}</td>
<td>${clientDTO.clientNumber}</td>
<td>${clientDTO.clientDetail}</td>
<td>${clientDTO.clientCeo}</td>
<td>${clientDTO.clientName}</td>
<td>${clientDTO.clientAddr1}</td>
<td>${clientDTO.clientAddr2}</td>
<td>${clientDTO.clientTel}</td>
<td>${clientDTO.clientPhone}</td>
<td>${clientDTO.clientFax}</td>
<td>${clientDTO.clientEmail}</td>
<td>${clientDTO.clientMemo}</td>
</tr>
</c:forEach>
</table>

<!-- 페이징처리 -->
<c:forEach var="i" begin="${pageDTO.startPage}" end="${pageDTO.endPage}" step="1">
<a href="${pageContext.request.contextPath}/Rawmaterials/selectclient?pageNum=${i}&search1=${pageDTO.search1}">${i}</a> 
</c:forEach>

</body>
</html>