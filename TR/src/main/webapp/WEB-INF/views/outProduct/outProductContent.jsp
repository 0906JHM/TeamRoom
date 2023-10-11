<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath }/resources/css/outProductContent.css"
	rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<title>Insert title here</title>
</head>
<body>

	<h2>출고 상세정보</h2>
	<form action="${pageContext.request.contextPath}/outProduct/outProductUpdate" method="POST">
		<table>
			<tbody>
				<tr>
					<td>출고코드</td>
					<td><input type="text" name="outCode" value="${outProductDTO.outCode }" readonly="readonly"></td>
				</tr>
				<tr>
					<td>수주코드</td>
					<td><input type="text" name="sellCode" value="${outProductDTO.sellCode }" readonly="readonly"></td>
				</tr>
				<tr>
					<td>거래처코드</td>
					<td><input type="text" name="clientCode" value="${outProductDTO.clientCode }" readonly="readonly"></td>
				</tr>
				<tr>
					<td>거래처명</td>
					<td><input type="text" name="clientCompany" value="${outProductDTO.clientCompany }" readonly="readonly"></td>
				</tr>
				<tr>
					<td>상품코드</td>
					<td><input type="text" name="prodCode" value="${outProductDTO.prodCode }" readonly="readonly"></td>
				</tr>
				<tr>
					<td>상품이름</td>
					<td><input type="text" name="prodName" value="${outProductDTO.prodName }" readonly="readonly"></td>
				</tr>
				<tr>
					<td>수주개수</td>
					<td><input type="number" name="sellCount" value="${outProductDTO.sellCount }" readonly="readonly"></td>
				</tr>
				<tr>
					<td>출고개수</td>
					<td><input type="number" name="outCount" value="${outProductDTO.outCount }" min="${outProductDTO.outCount }" max="${outProductDTO.sellCount }"></td>
				</tr>
				<tr>
					<td>재고개수</td>
					<td><input type="number" name="whseCount" value="${outProductDTO.whseCount }" readonly="readonly"></td>
				</tr>
				<tr>
					<fmt:formatNumber var="prodPrice" value="${outProductDTO.prodPrice }" pattern="###,###.##"></fmt:formatNumber>
					<td>납품가</td>
					<td>
						<input type="hidden" name="prodPrice" value="${outProductDTO.prodPrice }">
						<input type="text" name="prodPriceFormat" value="${prodPrice }원" readonly="readonly">
					</td>
				</tr>
				<tr>
					<fmt:formatNumber var="outPrice" value="${outProductDTO.outPrice }" pattern="###,###"></fmt:formatNumber>
					<td>출고가격</td>
					<td>
						<input type="hidden" name="outPrice" value="${outProductDTO.outPrice }">
						<input type="text" name="outPriceFormat" value="${outPrice }원" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>납품예정일</td>
					<td><input type="text" name="sellDuedate" value="${outProductDTO.sellDuedate }" readonly="readonly"></td>
				</tr>
				<tr>
					<td>출고일</td>
					<td><input type="text" name="outDate" value="${outProductDTO.outDate }" readonly="readonly"></td>
				</tr>
				<tr>
					<td>재출고일</td>
					<td><input type="text" name="outRedate" value="${outProductDTO.outRedate }" readonly="readonly"></td>
				</tr>
				<tr>
					<td>담당자</td>
					<td><input type="text" name="outEmpId" value="${outProductDTO.outEmpId }" readonly="readonly"></td>
				</tr>
				<tr>
					<td>출고상태</td>
					<td><input type="text" name="sellState" value="${outProductDTO.sellState }" readonly="readonly"></td>
				</tr>
				<tr>
					<td>출고비고</td>
					<td><input type="text" name="outMemo" value="${outProductDTO.outMemo }"></td>
				</tr>
			</tbody>
		</table>
		<div id="buttons">
		<c:if test="${outProductDTO.sellState != '출고완료' }">
			<c:if test="${outProductDTO.sellCount <= outProductDTO.whseCount && outProductDTO.outCount <= outProductDTO.whseCount}">
				<input type="submit" value="출고">
			</c:if>
		</c:if>
			<input type="button" value="닫기" onclick="window.close()">
		</div>
	</form>
</body>
</html>