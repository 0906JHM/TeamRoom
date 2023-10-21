<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!-- head -->
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<meta charset="UTF-8">  
<title>Insert title here</title>
<script type="text/javascript">
//팝업 옵션
const popupOpt = "top=60,left=140,width=720,height=600";

//검색 팝업
	function searchItem(type, inputId, type2) {
	 	var url = "${pageContext.request.contextPath}/search/emp?type=" + type + "&input=" + inputId + "&type2=" + type2;
	var popup = window.open(url, "", popupOpt);
} //openWindow()
</script>
</head>

<!-- body -->
<body>
<h1>수정하기</h1>

<!-- from -->
<form action="${pageContext.request.contextPath}/OrderManagement/updatePro" method="post">

<!-- table -->
<table border="1">
<tr><td>발주코드</td>
	<td><input type="text" name="buyNum" value="${ordermanagementDTO.buyNum}" readonly></td></tr>
<tr><td>품번</td>
    <td><input type="text" name="rawCode" value="${ordermanagementDTO.rawCode}" readonly></td></tr>
<tr><td>품명</td>
    <td><input type="text" name="rawName" value="${ordermanagementDTO.rawName}" readonly></td></tr>
<tr><td>종류</td>
    <td><input type="text" name="rawType" value="${ordermanagementDTO.rawType}" readonly></td></tr>
<tr><td>거래처코드</td>
    <td><input type="text" name="clientCode" value="${ordermanagementDTO.clientCode}" readonly></td></tr>
<tr><td>재고수량</td>
    <td><input type="text" name="whseCount" value="${ordermanagementDTO.stockCount}" readonly></td></tr>
<tr><td>발주수량</td>
    <td><input type="text" name="buyCount" value="${ordermanagementDTO.buyCount}"></td></tr>
<tr><td>매입단가</td>
    <td><input type="text" name="rawPrice" value="${ordermanagementDTO.rawPrice}" readonly></td></tr>
<tr><td>발주신청일</td>
    <td><input type="date" name="buyDate" value="${ordermanagementDTO.buyDate}"></td></tr>
<tr><td>담당자</td>
    <td><input id="empName9999" onclick="searchItem('emp','empId9999','영업팀')" type="text" name="buyEmpId" value="${ordermanagementDTO.buyEmpId}" readonly></td></tr>
<tr><td>발주상태</td>
    <td><input type="radio" name="buyInstate" value="신청완료" checked>신청완료
		<input type="radio" name="buyInstate" value="발주완료">발주완료</td></tr>
</table>

<input type="submit" value="수정">

</form>
</body>
</html>