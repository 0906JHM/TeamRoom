<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!-- head -->
<head>
<meta charset="UTF-8">  
<title>Insert title here</title>

<!-- javascript -->
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<script type="text/javascript">

// function openPopup1() {
// 	window.name = "update";
// 	openWin = window.open("selectclient.html", "selectclient", "height=600,width=1300");    
// }

function openPopup2() {
	window.name = "update";
	openWin = window.open("selectwarehouse.html", "selectwarehouse", "height=600,width=1300");    
}
</script>
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
<!-- <tr><td>거래처</td> -->
<%--     <td><input type="text" name="clientCode" id="pInput" value="${rawmaterialsDTO.clientCode}"> <input type="button" value="목록" onclick="openPopup1()"></td></tr> --%>
<tr><td>창고코드</td>
    <td><input type="text" name="whseCode" id="pInput2" value="${rawmaterialsDTO.whseCode}"> <input type="button" value="목록" onclick="openPopup2()"></td></tr>
<tr><td>비고</td>
	<td><textarea name="rawMemo" rows="10" cols="15">${rawmaterialsDTO.rawMemo}</textarea></td></tr>
</table>

<input type="submit" value="수정">
</form>
</body>
</html>