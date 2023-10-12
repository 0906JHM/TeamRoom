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
					<th>출고코드</th>
					<td><input type="text" name="outCode" value="${outProductDTO.outCode }" readonly="readonly"></td>
				</tr>
				<tr>
					<th>수주코드</th>
					<td><input type="text" name="sellCode" value="${outProductDTO.sellCode }" readonly="readonly"></td>
				</tr>
				<tr>
					<th>거래처코드</th>
					<td><input type="text" name="clientCode" value="${outProductDTO.clientCode }" readonly="readonly"></td>
				</tr>
				<tr>
					<th>거래처명</th>
					<td><input type="text" name="clientCompany" value="${outProductDTO.clientCompany }" readonly="readonly"></td>
				</tr>
				<tr>
					<th>상품코드</th>
					<td><input type="text" name="prodCode" value="${outProductDTO.prodCode }" readonly="readonly"></td>
				</tr>
				<tr>
					<th>상품이름</th>
					<td><input type="text" name="prodName" value="${outProductDTO.prodName }" readonly="readonly"></td>
				</tr>
				<tr>
					<th>담당자</th>
					<td><input type="text" name="outEmpId" value="${outProductDTO.outEmpId }" readonly="readonly"></td>
				</tr>
				<tr>
					<th>출고상태</th>
					<td><input type="text" name="sellState" value="${outProductDTO.sellState }" readonly="readonly"></td>
				</tr>
			</tbody>
		</table>
		<br>
		<table class="outProductTable">
			<tr>
				<th colspan="2">납품예정일</th>
				<th colspan="2">출고일</th>
				<th colspan="2">재출고일</th>
			</tr>
			<tr>
				<td colspan="2"><input type="text" name="sellDuedate" value="${outProductDTO.sellDuedate }" readonly="readonly"></td>
				<td colspan="2"><input type="text" name="outDate" value="${outProductDTO.outDate }" readonly="readonly"></td>
				<td colspan="2"><input type="text" name="outRedate" value="${outProductDTO.outRedate }" readonly="readonly"></td>
			</tr>
			<tr>
				<th colspan="2">수주개수</th>
				<th colspan="2">출고개수</th>
				<th colspan="2">재고개수</th>
			</tr>
			<tr> 
				<td colspan="2"><input type="number" name="sellCount" value="${outProductDTO.sellCount }" readonly="readonly"></td>
				<td colspan="2"><input type="number" name="outCount" value="${outProductDTO.outCount }" id="inputNum" autofocus="autofocus" min="${outProductDTO.outCount }" max="${outProductDTO.sellCount }"></td>
				<td colspan="2"><input type="number" name="whseCount" value="${outProductDTO.whseCount }" readonly="readonly"></td>
			</tr>
			<tr>
				<th colspan="3">납품가</th>
				<th colspan="3">출고가격</th>
			</tr>
			<tr>
				<td colspan="3">
				<fmt:formatNumber var="prodPrice" value="${outProductDTO.prodPrice }" pattern="###,###.##"></fmt:formatNumber>
					<input type="hidden" name="prodPrice" value="${outProductDTO.prodPrice }">
					<input type="text" name="prodPriceFormat" value="${prodPrice }원" readonly="readonly">
				</td>
				<td colspan="3">
				<fmt:formatNumber var="outPrice" value="${outProductDTO.outPrice }" pattern="###,###"></fmt:formatNumber>
					<input type="hidden" name="outPrice" value="${outProductDTO.outPrice }">
					<input type="text" name="outPriceFormat" value="${outPrice }원" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th colspan="6">출고비고</th>
			</tr>
			<tr>
				<td colspan="6"><input type="text" name="outMemo" value="${outProductDTO.outMemo }" id="inputMemo" placeholder="비고 입력"></td>
			</tr>
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