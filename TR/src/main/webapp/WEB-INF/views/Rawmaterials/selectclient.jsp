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

<input id="cInput" type="hidden">

<!-- javascript -->
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<script type="text/javascript">

// 자식에서 부모페이지로 값 넣기
function setParentText(){
	opener.document.getElementById("pInput").value = document.getElementById("cInput").value
	window.close();
}

//memo 페이지 팝업창
function openPopup4(clientCode) {
	// 팝업창 속성
	var popupWidth = 450;
	var popupHeight = 500;
	var left = (window.innerWidth - popupWidth) / 2;
	var top = (window.innerHeight - popupHeight) / 2;
	var popupFeatures = 'width=' + popupWidth + ',height=' + popupHeight + ',left=' + left + ',top=' + top + ',resizable=yes,scrollbars=yes';
	// 새창을 열기 위한 URL 설정
	var url = '${pageContext.request.contextPath}/Rawmaterials/memo2?clientCode=' + clientCode;
	// 팝업창 열고 속성 설정
	var newWindow = window.open(url, '_blank', popupFeatures);       
}
</script>

<!-- form(검색) -->
<form action="${pageContext.request.contextPath}/Rawmaterials/selectclient" method="get">
거래처코드	<input type="text" name="search1" placeholder="거래처코드">
거래처명	<input type="text" name="search2" placeholder="거래처명">
담당자 	<input type="text" name="search3" placeholder="담당자">
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
<tr onclick="if(event.target.tagName!='A'){document.getElementById('cInput').value = '${clientDTO.clientCode}'; setParentText();}">
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

<!-- 비고기능 -->
<td><c:choose>
<c:when test="${not empty clientDTO.clientMemo}">
<a href="#" onclick="openPopup4('${clientDTO.clientCode}');" style="color:black;">[보기]</a>
</c:when>
<c:otherwise>
<c:set var="clientMemo" value="" />
</c:otherwise>
</c:choose></td>

</tr>
</c:forEach>
</table>

<!-- 페이징처리 -->
<c:forEach var="i" begin="${pageDTO.startPage}" end="${pageDTO.endPage}" step="1">
<a href="${pageContext.request.contextPath}/Rawmaterials/selectclient?pageNum=${i}&search1=${pageDTO.search1}">${i}</a> 
</c:forEach>

</body>
</html>