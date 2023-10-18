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

<input id="rCInput" type="hidden">
<input id="rNInput" type="hidden">
<input id="rTInput" type="hidden">
<input id="rPInput" type="hidden">
<input id="wCInput" type="hidden">
<input id="wNInput" type="hidden">

<!-- javascript -->
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<script type="text/javascript">

// 자식에서 부모페이지로 값 넣기
function setParentText(){
	opener.document.getElementById("rCInput").value = document.getElementById("rCInput").value;
	opener.document.getElementById("rNInput").value = document.getElementById("rNInput").value;
	opener.document.getElementById("rTInput").value = document.getElementById("rTInput").value;
	opener.document.getElementById("rPInput").value = document.getElementById("rPInput").value;
	opener.document.getElementById("wCInput").value = document.getElementById("wCInput").value;
	opener.document.getElementById("wNInput").value = document.getElementById("wNInput").value;
	window.close();
}

// selectclient 페이지 팝업창
function openPopup3() {
    var popupWindow = window.open("${pageContext.request.contextPath}/Rawmaterials/selectclient", "_blank", "height=600,width=1300");
    // 팝업 창닫기 버튼 클릭시 창닫기
    popupWindow.onbeforeunload = function() {
        popupWindow.close();
    };
}

// memo 페이지 팝업창
function openPopup4(rawCode) {
	// 팝업창 속성
	var popupWidth = 450;
	var popupHeight = 500;
	var left = (window.innerWidth - popupWidth) / 2;
	var top = (window.innerHeight - popupHeight) / 2;
	var popupFeatures = 'width=' + popupWidth + ',height=' + popupHeight + ',left=' + left + ',top=' + top + ',resizable=yes,scrollbars=yes';
	// 새창을 열기 위한 URL 설정
	var url = '${pageContext.request.contextPath}/Rawmaterials/memo?rawCode=' + rawCode;
	// 팝업창 열고 속성 설정
	var newWindow = window.open(url, '_blank', popupFeatures);       
}
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
<!-- 거래처	<input type="text" name="search4" placeholder="거래처" onclick="openPopup3()"> -->
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
<!-- <td>거래처</td> -->
<td>창고코드</td>
<td>창고수량</td>
<td>비고</td>
</tr>

<c:forEach var="rawmaterialsDTO" items="${rawmaterialsList}">
<tr onclick="if(event.target.tagName!='A'){document.getElementById('rCInput').value = '${rawmaterialsDTO.rawCode}'; document.getElementById('rNInput').value = '${rawmaterialsDTO.rawName}'; document.getElementById('rTInput').value = '${rawmaterialsDTO.rawType}'; document.getElementById('rPInput').value = '${rawmaterialsDTO.rawPrice}'; document.getElementById('wCInput').value = '${rawmaterialsDTO.whseCount}'; document.getElementById('wNInput').value = '${rawmaterialsDTO.whseCode}'; setParentText();}">
<td>${rawmaterialsDTO.rawNum}</td>
<td>${rawmaterialsDTO.rawCode}</td>
<td>${rawmaterialsDTO.rawName}</td>
<td>${rawmaterialsDTO.rawType}</td>
<td>${rawmaterialsDTO.rawUnit}</td>
<td>${rawmaterialsDTO.rawPrice}</td>
<%-- <td>${rawmaterialsDTO.clientCode}</td> --%>
<td>${rawmaterialsDTO.whseCode}</td>
<td>${rawmaterialsDTO.whseCount}</td>

<!-- 비고기능 -->
<td><c:choose>
<c:when test="${not empty rawmaterialsDTO.rawMemo}">
<a href="#" onclick="openPopup4('${rawmaterialsDTO.rawCode}');" style="color:black;">[보기]</a>
</c:when>
<c:otherwise>
<c:set var="rawMemo" value="" />
</c:otherwise>
</c:choose></td>

</tr>
</c:forEach>
</table>

<!-- 페이징처리 -->
<c:forEach var="i" begin="${pageDTO.startPage}" end="${pageDTO.endPage}" step="1">
<a href="${pageContext.request.contextPath}/OrderManagement/selectrawmaterials?pageNum=${i}&search1=${pageDTO.search1}">${i}</a> 
</c:forEach>

</body>
</html>