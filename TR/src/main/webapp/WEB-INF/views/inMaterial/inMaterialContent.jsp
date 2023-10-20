<%@page import="com.itwillbs.domain.InMaterialDTO"%>
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

<%
// 관리자 또는 자재팀 출고 상세 페이지 열람 가능 게시판 접근 가능
String department = "";
if (session.getAttribute("empDepartment") != null) {
    department = (String) session.getAttribute("empDepartment");
}

// 상수 정의
final String ADMIN_DEPARTMENT = "자재팀";
%>

<title>입고 상세 페이지</title>
</head>
<body>
<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '자재팀')}">

<%
	InMaterialDTO inMaterialDTO;
%>
	<h2>입고 상세정보</h2>
	<form action="${pageContext.request.contextPath}/inMaterial/inMaterialUpdate" id="updateForm" method="POST">
		<table>
			<tbody>
				<tr>
					<th>입고 코드</th>
					<td><input type="text" name="inNum" value="${inMaterialDTO.inNum }" readonly="readonly"></td>
				</tr>
				<tr>
					<th>발주 코드</th>
					<td><input type="text" name="buyNum" value="${inMaterialDTO.buyNum}" readonly="readonly"></td>
				</tr>
				<tr>
					<th>거래처 코드</th>
					<td><input type="text" name="clientCode" value="${inMaterialDTO.clientCode }" readonly="readonly"></td>
				</tr>
				<tr>
					<th>거래처명</th>
					<td><input type="text" name="clientCompany" value="${inMaterialDTO.clientCompany }" readonly="readonly"></td>
				</tr>
				<tr>
					<th>원자재 코드</th>
					<td><input type="text" name="rawCode" value="${inMaterialDTO.rawCode }" readonly="readonly"></td>
				</tr>
				<tr>
					<th>원자재명</th>
					<td><input type="text" name="rawName" value="${inMaterialDTO.rawName }" readonly="readonly"></td>
				</tr>
				<tr>
					<th>담당자</th>
					<td><input type="text" name="inEmpId" value="${sessionScope.empId }" readonly="readonly"></td>
				</tr>
				<tr>
					<th>입고 상태</th>
					<td><input type="text" name="inState" value="${inMaterialDTO.inState }" readonly="readonly"></td>
				</tr>
			</tbody>
		</table>
		<br>
		<table class="outProductTable">
			<tr>
<!-- 				<th colspan="2">납품 예정일</th> -->
				<th colspan="2">입고일</th>
				<th colspan="2">재입고일</th>
				<th colspan="2">입고 부족</th>
			</tr>
			<tr>
<%-- 				<td colspan="2"><input type="text" name="sellDuedate" value="${inMaterialDTO.sellDuedate }" readonly="readonly"></td> --%>
				<td colspan="2"><input type="text" name="inDate" value="${inMaterialDTO.inDate }" readonly></td>
				<td colspan="2"><input type="text" name="inRedate" value="${inMaterialDTO.inRedate }" readonly></td>
				<td colspan="2"><input type="number" name="remainder" value="${inMaterialDTO.remainder }" readonly onchange="updateRemainder()"></td>
			</tr>
			<tr>
				<th colspan="2">발주 개수</th>
				<th colspan="2">입고 개수</th>
				<th colspan="2">재고 개수</th>
			</tr>
			<tr> 
				<td colspan="2"><input type="number" name="buyCount" value="${inMaterialDTO.buyCount }" readonly="readonly"></td>
				<td colspan="2">
					<input type="hidden" id="initialInCount" value="${inMaterialDTO.inCount}">
					<c:if test="${inMaterialDTO.stockCount == null || inMaterialDTO.stockCount == 0}">
   						<input type="number" name="inCount" value="0" readonly="readonly">
					</c:if>
					<c:if test="${inMaterialDTO.stockCount != null && inMaterialDTO.stockCount > 0}">
    					<input type="number" name="inCount" value="${inMaterialDTO.inCount }" step="1" id="inputNum" autofocus="autofocus" max="${inMaterialDTO.buyCount }" min=0 onchange="updateInventory()">
					</c:if>

				</td>
				<td colspan="2">
					<input type="hidden" id="initialstockCount" value="${inMaterialDTO.stockCount}">
					<input type="number" name="stockCount" value="${inMaterialDTO.stockCount }" min="0" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th colspan="3">원자재 입고 단가</th>
				<th colspan="3">입고 가격</th>
			</tr>
			<tr>
				<td colspan="3">
				<fmt:formatNumber var="rawPrice" value="${inMaterialDTO.rawPrice }" pattern="###,###.##"></fmt:formatNumber>
					<input type="hidden" name="rawPrice" value="${inMaterialDTO.rawPrice }">
					<input type="text" name="rawPriceFormat" value="${rawPrice }원" readonly="readonly">
				</td>
				<td colspan="3">
				<fmt:formatNumber var="inPrice" value="${inMaterialDTO.inPrice }" pattern="###,###"></fmt:formatNumber>
					<input type="hidden" name="inPrice" value="${inMaterialDTO.inPrice }">
					<input type="text" name="inPriceFormat" value="${inPrice }원" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th colspan="6">비고</th>
			</tr>
			<tr>
				<td colspan="6"><input type="text" name="inMemo" value="${inMaterialDTO.inMemo }" id="inputMemo" placeholder="비고 입력"></td>
			</tr>
		</table>
		<div id="buttons">
		
		
<%-- 		<c:if test="${inMaterialDTO.sellState != '입고완료' && inMaterialDTO.stockCount != 0 }"> --%>
<!-- buyState가 필요한가? -->

<c:if test="${inMaterialDTO.inState != '입고완료' && inMaterialDTO.stockCount != 0 }">
				<input type="button" id="updateButton" value="입고">
		</c:if>
			<input type="button" value="닫기" onclick="window.close()">
		</div>
	</form>
</c:if>
	
	<script type="text/javascript">
		var department = "<%= department %>";
		var ADMIN_DEPARTMENT = "<%= ADMIN_DEPARTMENT %>";
		console.log("직책 : "+department);
		if (department !== ADMIN_DEPARTMENT && department !== "관리자") {
		    // 세션 값이 허용되지 않는 경우 리다이렉트
		    window.opener.location.href = "<%= request.getContextPath() %>/main/calendar";
		    window.close();
		}
	</script>
	
	<script type="text/javascript">
		function updateInventory() {
		    // 입고 개수와 재고 개수 입력란의 DOM 요소를 가져옵니다
		    var inCountInput = document.querySelector('input[name="inCount"]');
		    var stockCountInput = document.querySelector('input[name="stockCount"]');
		    
		    // 현재 출력해야되는 재고값 계산
		    var initialstockCount = parseInt(document.getElementById('initialstockCount').value, 10);
		    var initialInCount = parseInt(document.getElementById('initialInCount').value, 10);
		    var inCount = parseInt(inCountInput.value, 10);
		    
		    // 재고 입력란 업데이트
		    stockCountInput.value = initialstockCount + initialInCount - inCount;
		}
		
		
		$(document).ready(function() {
			// "입고" 버튼 클릭 시 Ajax 요청을 보냅니다.
			$("#updateButton").click(function() {
				// 폼 데이터를 수집
				var formData = $("#updateForm").serialize();

				$.ajax({
					type: "POST",
					url: "${pageContext.request.contextPath}/inMaterial/inMaterialUpdate",
					data: formData,
					success: function(response) {
						console.log(response);
						if(response === 'success'){
		                    Swal.fire({
		                        text: '입고 완료',
		                        icon: 'success',
		                        confirmButtonText: '확인',
		                        onClose: reloadParentAndCurrentPage // 확인 버튼을 누르면 새로고침 함수 호출
		                    });
		                } else {
		                    Swal.fire({
		                        text: '재고가 충분하지 않습니다.',
		                        icon: 'warning',
		                        confirmButtonText: '확인',
		                        onClose: reloadParentAndCurrentPage // 확인 버튼을 누르면 새로고침 함수 호출
		                    });
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
		
		function reloadParentAndCurrentPage() {
		    window.opener.location.reload(); // 부모 창 새로고침
		    window.location.reload(); // 현재 창 새로고침
		}
		

var buyCount = parseInt(document.getElementsByName('buyCount')[0].value);

    function updateRemainder() {
        var inCount = parseInt(document.getElementById('inputNum').value, 10);
        var updatedValue = buyCount - inCount;
        document.getElementsByName('remainder')[0].value = updatedValue;
    }
	</script>
</body>
</html>