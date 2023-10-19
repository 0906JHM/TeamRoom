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
<h1>수정하기</h1>

<!-- from -->
<form action="${pageContext.request.contextPath}/OrderManagement/updatePro" method="post">

<!-- table -->
<table border="1">
<tr><td>발주번호</td>
	<td><input type="text" name="buyNum" value="${ordermanagementDTO.buyNum}" readonly></td></tr>
<tr><td>품번</td>
    <td><input type="text" name="rawCode" value="${ordermanagementDTO.rawCode}"></td></tr>
<tr><td>품명</td>
    <td><input type="text" name="rawName" value="${ordermanagementDTO.rawName}"></td></tr>
<tr><td>종류</td>
    <td><input type="text" name="rawType" value="${ordermanagementDTO.rawType}"></td></tr>
<tr><td>거래처명</td>
    <td><input type="text" name="clientCode" value="${ordermanagementDTO.clientCode}"></td></tr>
<tr><td>창고수량</td>
    <td><input type="text" name="whseCount" value="${ordermanagementDTO.whseCount}"></td></tr>
<tr><td>발주수량</td>
    <td><input type="text" name="buyCount" value="${ordermanagementDTO.buyCount}"></td></tr>
<tr><td>매입단가</td>
    <td><input type="text" name="rawPrice" value="${ordermanagementDTO.rawPrice}"></td></tr>
<tr><td>발주신청일</td>
    <td><input type="date" name="buyDate" value="${ordermanagementDTO.buyDate}"></td></tr>
<tr><td>담당자</td>
    <td><input type="text" name="buyEmpId" value="${ordermanagementDTO.buyEmpId}"></td></tr>
<tr><td>발주상태</td>
    <td><input type="radio" name="buyInstate" value="신청완료" checked>신청완료
		<input type="radio" name="buyInstate" value="발주완료">발주완료</td></tr>
</table>

<input type="submit" value="수정">

</form>
</body>
</html>