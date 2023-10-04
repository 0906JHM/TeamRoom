<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>list.jsp</title>
</head>
<body>
	<table border="1">
		<tr>
			<td>제품코드</td>
			<td>재고개수</td>
			<td>원자재코드</td>
			<td>창고코드</td>
		</tr>

		<c:forEach var="stockDTO" items="${boardList}">
			<tr>
				<td>${stockDTO.prodCode }</td>
				<td>${stockDTO.whseCount }</td>
				<td>${stockDTO.rawCode }</td>
				<td>${stockDTO.whseCode }</td>
			</tr>
		</c:forEach>

	</table>

	<c:if test="${pageDTO.startPage > pageDTO.pageBlock }">
		<a
			href="${pageContext.request.contextPath}/board/list?pageNum=${pageDTO.startPage - pageDTO.pageBlock}">[이전]</a>
	</c:if>

	<c:forEach var="i" begin="${pageDTO.startPage }"
		end="${pageDTO.endPage }" step="1">
		<a href="${pageContext.request.contextPath}/stock/list?pageNum=${i}">${i}</a>
	</c:forEach>

	<c:if test="${pageDTO.endPage < pageDTO.pageCount }">
		<a
			href="${pageContext.request.contextPath}/stock/list?pageNum=${pageDTO.startPage + pageDTO.pageBlock}">[다음]</a>
	</c:if>


</body>
</html>