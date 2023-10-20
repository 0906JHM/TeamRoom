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
<h1>상세보기</h1>

<!-- table -->
<table border="1">
<tr><td>발주코드</td>	<td>${ordermanagementDTO.buyNum}</td></tr>
<tr><td>품번</td>		<td>${ordermanagementDTO.rawCode}</td></tr>
<tr><td>품명</td>		<td>${ordermanagementDTO.rawName}</td></tr>
<tr><td>종류</td>		<td>${ordermanagementDTO.rawType}</td></tr>
<tr><td>거래처코드</td>	<td>${ordermanagementDTO.clientCode}</td></tr>
<tr><td>창고코드</td>	<td>${ordermanagementDTO.whseCode}</td></tr>
<tr><td>창고수량</td>	<td>${ordermanagementDTO.whseCount}</td></tr>
<tr><td>발주수량</td>	<td>${ordermanagementDTO.buyCount}</td></tr>
<tr><td>매입단가</td>	<td>${ordermanagementDTO.rawPrice}</td></tr>
<tr><td>단가총계</td>	<td>${ordermanagementDTO.rawPrice * ordermanagementDTO.buyCount}</td></tr>
<tr><td>발주신청일</td>	<td>${ordermanagementDTO.buyDate}</td></tr>
<tr><td>발주상태</td>	<td>${ordermanagementDTO.buyInstate}</td></tr>
<tr><td>담당자</td>	<td>${ordermanagementDTO.buyEmpId}</td></tr>
</table>

<!-- button -->
<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '영업팀')}">
<input type="button" value="수정" onclick="location.href='${pageContext.request.contextPath}/OrderManagement/update?buyNum=${ordermanagementDTO.buyNum}'">
</c:if>
<input type="button" value="목록" onclick="location.href='${pageContext.request.contextPath}/OrderManagement/home'">

</body>
</html>