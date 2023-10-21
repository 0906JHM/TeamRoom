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
<tr><td id="td1">발주코드</td>	<td id="td21">${ordermanagementDTO.buyNum}</td></tr>
<tr><td id="td1">품번</td>		<td id="td22">${ordermanagementDTO.rawCode}</td></tr>
<tr><td id="td1">품명</td>		<td id="td21">${ordermanagementDTO.rawName}</td></tr>
<tr><td id="td1">종류</td>		<td id="td22">${ordermanagementDTO.rawType}</td></tr>
<tr><td id="td1">거래처코드</td>	<td id="td21">${ordermanagementDTO.clientCode}</td></tr>
<tr><td id="td1">창고코드</td>	<td id="td22">${ordermanagementDTO.whseCode}</td></tr>
<tr><td id="td1">창고명</td>	<td id="td21">${ordermanagementDTO.whseName}</td></tr>
<tr><td id="td1">재고수량</td>	<td id="td22">${ordermanagementDTO.stockCount}</td></tr>
<tr><td id="td1">발주수량</td>	<td id="td21">${ordermanagementDTO.buyCount}</td></tr>
<tr><td id="td1">매입단가</td>	<td id="td22">${ordermanagementDTO.rawPrice}</td></tr>
<tr><td id="td1">단가총계</td>	<td id="td21">${ordermanagementDTO.rawPrice * ordermanagementDTO.buyCount}</td></tr>
<tr><td id="td1">발주신청일</td>	<td id="td22">${ordermanagementDTO.buyDate}</td></tr>
<tr><td id="td1">발주상태</td>	<td id="td21">${ordermanagementDTO.buyInstate}</td></tr>
<tr><td id="td1">담당자</td>	<td id="td22">${ordermanagementDTO.buyEmpId}</td></tr>
</table>

<!-- button -->
<div id="buttons">
<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '영업팀')}">
<input type="button" value="수정" onclick="location.href='${pageContext.request.contextPath}/OrderManagement/update?buyNum=${ordermanagementDTO.buyNum}'" id=btn1>
</c:if>
<input type="button" value="목록" onclick="location.href='${pageContext.request.contextPath}/OrderManagement/home'" id=btn2>
</div>
</div>

</body>
</html>