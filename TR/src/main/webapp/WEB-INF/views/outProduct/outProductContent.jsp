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

<!-- SweetAlert  -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<title>출고 상세 페이지</title>
</head>
<body>

	<h2>출고 상세정보</h2>
	<form action="${pageContext.request.contextPath}/outProduct/outProductUpdate" id="updateForm" method="POST">
		<table>
			<tbody>
				<tr>
					<th>출고 코드</th>
					<td><input type="text" name="outCode" value="${outProductDTO.outCode }" readonly="readonly"></td>
				</tr>
				<tr>
					<th>수주 코드</th>
					<td><input type="text" name="sellCode" value="${outProductDTO.sellCode }" readonly="readonly"></td>
				</tr>
				<tr>
					<th>거래처 코드</th>
					<td><input type="text" name="clientCode" value="${outProductDTO.clientCode }" readonly="readonly"></td>
				</tr>
				<tr>
					<th>거래처명</th>
					<td><input type="text" name="clientCompany" value="${outProductDTO.clientCompany }" readonly="readonly"></td>
				</tr>
				<tr>
					<th>제품 코드</th>
					<td><input type="text" name="prodCode" value="${outProductDTO.prodCode }" readonly="readonly"></td>
				</tr>
				<tr>
					<th>제품명</th>
					<td><input type="text" name="prodName" value="${outProductDTO.prodName }" readonly="readonly"></td>
				</tr>
				<tr>
					<th>담당자</th>
					<td><input type="text" name="outEmpId" value="${outProductDTO.outEmpId }" readonly="readonly"></td>
				</tr>
				<tr>
					<th>출고 상태</th>
					<td><input type="text" name="sellState" value="${outProductDTO.sellState }" readonly="readonly"></td>
				</tr>
			</tbody>
		</table>
		<br>
		<table class="outProductTable">
			<tr>
				<th colspan="2">납품 예정일</th>
				<th colspan="2">출고일</th>
				<th colspan="2">재출고일</th>
			</tr>
			<tr>
				<td colspan="2"><input type="text" name="sellDuedate" value="${outProductDTO.sellDuedate }" readonly="readonly"></td>
				<td colspan="2"><input type="text" name="outDate" value="${outProductDTO.outDate }" readonly="readonly"></td>
				<td colspan="2"><input type="text" name="outRedate" value="${outProductDTO.outRedate }" readonly="readonly"></td>
			</tr>
			<tr>
				<th colspan="2">수주 개수</th>
				<th colspan="2">출고 개수</th>
				<th colspan="2">재고 개수</th>
			</tr>
			<tr> 
				<td colspan="2"><input type="number" name="sellCount" value="${outProductDTO.sellCount }" readonly="readonly"></td>
				<td colspan="2">
					<input type="hidden" id="initialOutCount" value="${outProductDTO.outCount}">
					<c:if test="${outProductDTO.whseCount == null || outProductDTO.whseCount == 0}">
   						<input type="number" name="outCount" value="0" readonly="readonly">
    					<script type="text/javascript">
        					console.log("재고가 0개");
    					</script>
					</c:if>
					<c:if test="${outProductDTO.whseCount != null && outProductDTO.whseCount > 0}">
    					<input type="number" name="outCount" value="${outProductDTO.outCount }" step="5" id="inputNum" autofocus="autofocus" min="${outProductDTO.outCount }" max="${outProductDTO.sellCount }" onchange="updateInventory()">
					</c:if>

				</td>
				<td colspan="2">
					<input type="hidden" id="initialWhseCount" value="${outProductDTO.whseCount}">
					<input type="number" name="whseCount" value="${outProductDTO.whseCount }" min="0" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th colspan="3">납품가</th>
				<th colspan="3">출고 가격</th>
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
				<th colspan="6">비고</th>
			</tr>
			<tr>
				<td colspan="6"><input type="text" name="outMemo" value="${outProductDTO.outMemo }" id="inputMemo" placeholder="비고 입력"></td>
			</tr>
		</table>
		<div id="buttons">
		<c:if test="${outProductDTO.sellState != '출고완료' && outProductDTO.whseCount != 0 }">
				<input type="button" id="updateButton" value="출고">
		</c:if>
			<input type="button" value="닫기" onclick="window.close()">
		</div>
	</form>
	
	<script type="text/javascript">
		function updateInventory() {
		    // 출고 개수와 재고 개수 입력란의 DOM 요소를 가져옵니다
		    var outCountInput = document.querySelector('input[name="outCount"]');
		    var whseCountInput = document.querySelector('input[name="whseCount"]');
		    
		    // 현재 출력해야되는 재고값 계산
		    var initialWhseCount = parseInt(document.getElementById('initialWhseCount').value, 10);
		    var initialOutCount = parseInt(document.getElementById('initialOutCount').value, 10);
		    var outCount = parseInt(outCountInput.value, 10);
		    
		    // 재고 입력란 업데이트
		    whseCountInput.value = initialWhseCount + initialOutCount - outCount;
		}
		
		
		$(document).ready(function() {
			// "출고" 버튼 클릭 시 Ajax 요청을 보냅니다.
			$("#updateButton").click(function() {
				// 폼 데이터를 수집
				var formData = $("#updateForm").serialize();

				$.ajax({
					type: "POST",
					url: "${pageContext.request.contextPath}/outProduct/outProductUpdate",
					data: formData,
					success: function(response) {
						console.log(response);
						if(response === 'success'){
							Swal.fire({
							    text: '출고 완료',
							    icon: 'success',
							    confirmButtonText: '확인',
							});
							window.opener.location.reload();
// 							window.close();
						}else{
							Swal.fire({
							    text: '재고가 충분하지 않습니다.',
							    icon: 'warning',
							    confirmButtonText: '확인',
							});
							window.opener.location.reload();
// 							window.close();
						}
					},
					error: function(xhr, status, error) {
						// 에러 처리
						console.log("에러: " + error);
					}
				});
			});

			// "닫기" 버튼 클릭 시 창을 닫습니다.
			$("#closeButton").click(function() {
				window.close();
			});
		});
	</script>
</body>
</html>