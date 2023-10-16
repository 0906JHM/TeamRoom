<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>

<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
<title>sell/sellMain.jsp</title>

<!-- side.jsp css-->
<link href="${pageContext.request.contextPath }/resources/css/side.css"
	rel="stylesheet" type="text/css">
<!-- 본문 css -->
<link
	href="${pageContext.request.contextPath }/resources/css/product.css"
	rel="stylesheet" type="text/css">
<!-- 수주일자 기간선택 -->
<link
	href="${pageContext.request.contextPath}/resources/css/daterange.css"
	rel="stylesheet" type="text/css">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<!-- J쿼리 호출 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="../resources/js/scripts.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
</head>

<body>

	<!------------------------------------------------------- 사이드바 ---------------------------------------------------->
	<jsp:include page="../inc/side.jsp"></jsp:include>

	<!------------------------------------------------------- 본문 타이틀 ---------------------------------------------------->
	<div class="container">
		<h2>수주 관리</h2>
	
		<!------------------------------------------------------- 상단 검색란 ---------------------------------------------------->
		<div id="searchform">
			<form action="${pageContext.request.contextPath}/sell/sellMain"
				method="get" id="selectedProId">

				<label>수주 코드</label> <input type="text"> 
				
				<label>거래처</label> 
	        <input type="text" id="clientCode9999" name="clientCode" onclick=searchItem('client','clientCode9999'); placeholder="거래처 코드" readonly >
        	<input type="text" id="clientCompany9999" placeholder="거래처명" onclick=searchItem('client','clientCode9999'); readonly >
		
					
				<br>
				
			<label>처리 상태</label> <select name="sellState">
					<option value="notYet">미출고</option>
					<option value="ing">중간납품</option>
					<option value="complete">출고완료</option>
				</select> 
				
				<label>제품</label>  
	        <input type="text" name="prodCode" id="prodCode9999" onclick=searchItem('prod','prodCode9999'); placeholder="제품 코드" readonly>
	      	<input type="text" name="prodName" id="prodName9999" placeholder="제품명" readonly onclick="searchItem('prod','prodCode9999')">
	      
				<br>
				
				<label for="startDate">수주 일자</label> 
				<input type="text" name="daterange" value=""> 
				
				<label for="startDate">납기일자</label>
				<input type="text" name="daterange" value="">

				<button type="submit">조회</button>
			</form>
		</div>
		<br>
		<!------------------------------------------------------- 추가, 수정, 삭제, 엑셀 버튼 ---------------------------------------------------->
		<div class="buttons">
			<button id="add" onclick="openSellAdd()">추가</button>
			<button id="delete">삭제</button>
			<button id="Excel">Excel</button>
		</div>

		<!------------------------------------------------------- 수주 목록 ---------------------------------------------------->
		<small>총 ${sellPageDTO.count}건</small>

		<form id="selltList">
			<div id="sellList">
				<table class="tg" id="sellTable">
					<thead>
						<tr>
							<th><input type="checkbox" id="select-list-all"
								name="select-list-all" data-group="select-list"></th>
							
							
							<td>처리 상태</td>
							<td>수주 코드</td>
							<td>거래처 코드</td>
							<td>제품 코드</td>
							<td>제품명</td>
							<td>제품 단가</td>
							<td>수주 수량</td>
							<td>수주 단가</td>
							<td>수주 일자</td>
							<td>납기 일자</td>
							<td>담당자</td>
							<td>비고</td>
						</tr>
					</thead>
					
					
					
					<tbody>
						<c:forEach var="sellDTO" items="${sellList}">
							<tr>
								<td><input type="checkbox" id="select-list"
									value="${sellDTO.sellCode}" name="selectedSellCode"
									data-group="select-list"></td>

								
								<td>${sellDTO.sellState}</td><!-- 처리(출고)상태 -->
								
								<td	onclick="openSellDetail()">${sellDTO.sellCode}</td><!-- 수주코드 -->
								
								<td>${sellDTO.clientCode}</td><!-- 거래처코드 -->
								
								<td>${sellDTO.prodCode}</td><!-- 제품코드 -->
								
								<td>${sellDTO.prodName}</td><!-- 제품명 -->
								
								<td><fmt:formatNumber value="${sellDTO.prodPrice}"
										pattern="###,###원" /></td><!-- 제품단가 -->
								
								<td>${sellDTO.sellCount}개</td><!-- 수주수량-->
								
								<td><fmt:formatNumber value="${sellDTO.sellPrice}"
										pattern="###,###원" /></td><!-- 수주단가 -->
								
								<td>${sellDTO.sellDate}</td><!-- 수주일자 -->
								
								<td>${sellDTO.sellDuedate}</td><!-- 납기일자  -->
								
								<td>${sellDTO.sellEmpId}</td><!-- 수주담당직원 -->
								

								<c:choose>
									<c:when test="${not empty sellDTO.sellMemo}">
										<td class="tg-llyw2"><a href="#"
											onclick="openSellMemo('${sellDTO.sellCode}'); return sellMemoClose();"
											style="color: red;">[보기]</a></td>
									</c:when>
									<c:otherwise>

										<td class="tg-llyw2"><a href="#"
											onclick="addSellMemo('${sellDTO.sellCode}'); return sellMemoClose();"
											style="color: #384855;">[입력]</a></td>
									</c:otherwise>
								</c:choose>


							</tr>
						</c:forEach>
					</tbody>

				</table>
			</div>
			<!------------------------------------------------- 페이징 ------------------------------------------>
			<c:forEach var="i" begin="${sellPageDTO.startPage}"
				end="${sellPageDTO.endPage}" step="1">
				<a
					href="${pageContext.request.contextPath}/sell/sellMain?pageNum=${i}"
					style="text-decoration: none; color: #5EC397;">${i}</a>
			</c:forEach>

			<c:if test="${sellPageDTO.startPage > sellPageDTO.pageBlock}">
				<a
					href="${pageContext.request.contextPath}/sell/sellMain?pageNum=${sellPageDTO.startPage - sellPageDTO.pageBlock}"
					style="text-decoration: none; color: #5EC397;">◀</a>
			</c:if>


			<c:if test="${sellPageDTO.endPage < sellPageDTO.pageCount}">
				<a
					href="${pageContext.request.contextPath}/sell/sellMain?pageNum=${sellPageDTO.startPage + sellPageDTO.pageBlock}"
					style="text-decoration: none; color: #5EC397;">▶</a>
			</c:if>


		</form>
	</div>


	<!--################################################################ script ###################################################################-->
	<script>

var contextPath = "${pageContext.request.contextPath}";

<!------------------------------------------------- 팝업창 옵션 ------------------------------------------>
//팝업 옵션
const popupOpt = "top=60,left=140,width=720,height=600";

//검색 팝업
	function searchItem(type, inputId) {
	 	var url = "${pageContext.request.contextPath}/search/search?type=" + type + "&input=" + inputId;
	var popup = window.open(url, "", popupOpt);
} //openWindow()

<!--------------------------------------------------- 목록 전체 선택 ----------------------------------------->
$(document).ready(function() {
$('#select-list-all').click(function() {
			var checkAll = $(this).is(":checked");
			
			if(checkAll) {
				$('input:checkbox').prop('checked', true);
			} else {
				$('input:checkbox').prop('checked', false);
			}
		});

<!--------------------------------------------------- 수주 삭제 ----------------------------------------->
$('#delete').click(function(event){	

		var checked = [];
		
		$('input[name=selectedSellCode]:checked').each(function(){
			checked.push($(this).val());
		});

		if(checked.length > 0) {
			Swal.fire({
				  title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "총" +checked.length+"건\n정말 삭제하시겠습니까?"+ "</div>",
				  icon: 'info', // 아이콘! 느낌표 색? 표시?
				  showDenyButton: true,
				  confirmButtonColor: '#17A2B8', // confrim 버튼 색깔 지정
				  cancelButtonColor: '#73879C', // cancel 버튼 색깔 지정
				  confirmButtonText: 'Yes', // confirm 버튼 텍스트 지정
//					  cancelButtonText: '아니오', // cancel 버튼 텍스트 지정
				  width : '300px', // alert창 크기 조절
				  
				}).then((result) => {
			
			 /* confirm => 예 눌렀을 때  */
			  if (result.isConfirmed) {
				$.ajax({
						url: "${pageContext.request.contextPath}/sell/delete",
						type: "POST",
						data: {checked : checked},
						dataType: "text",	
						success: function () {
							Swal.fire({
							  title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "총" +checked.length+"건 삭제 완료",
							  icon: 'success',
							  width : '300px',
							}).then((result) => {
							  if (result.isConfirmed) {
							    location.reload();
							  }
							});
					},
					error: function () {
						Swal.fire({
							title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "삭제 중 오류가 발생했습니다",
							icon : 'question',
							width: '300px',
							});	
					}
				});//ajax
				  } else if (result.isDenied) {
						Swal.fire({
						title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "삭제가 취소되었습니다",
						icon : 'error',
						width: '300px',
						});
			}// if(confirm)
		});		
			
		}// 체크 null
		else{
			Swal.fire({
				title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "선택된 항목이 없습니다",
				icon : 'warning',
				width: '300px',
				});
		}
}); 
});// end function

<!--------------------------------------------------- 수주, 납기일자 기간선택 ----------------------------------------->
	$(function() {
		$('input[name="daterange"]').daterangepicker({
			autoUpdateInput : false,
			locale : {
				cancelLabel : 'Clear'
			}
		});
		$('input[name="daterange"]').on(
				'apply.daterangepicker',
				function(ev, picker) {
					$(this).val(
							picker.startDate.format('YYYY/MM/DD') + ' - '
									+ picker.endDate.format('YYYY/MM/DD'));
				});
		$('input[name="daterange"]').on('cancel.daterangepicker',
				function(ev, picker) {
					$(this).val('');
				});
		$('.cancelBtn').text('취소');
		$('.applyBtn').text('적용');
	});

<!--------------------------------------------------- 수주 추가 ----------------------------------------->
function openSellAdd() {

    // 팝업 창 
    var popupWidth = 500;
    var popupHeight = 700;
    var left = (window.innerWidth - popupWidth) / 2;
    var top = (window.innerHeight - popupHeight) / 2;
    var popupFeatures = 'width=' + popupWidth + ',height=' + popupHeight +
                        ',left=' + left + ',top=' + top +
                        ',resizable=yes,scrollbars=yes';

    // selladd.jsp 파일을 팝업 창 오픈
    window.open( '${pageContext.request.contextPath}/sell/sellAdd','popupUrl', popupFeatures);
    
    function submitClose() {
        // 여기에 수주 등록 폼을 서버에 제출하는 코드를 추가하세요.
        
        // 폼을 제출한 후 창을 닫기 위해 아래 코드를 사용합니다.
        window.close();
    }
} 

<!--------------------------------------------------- 수주 수정, 수주 정보 보기 ----------------------------------------->
function openSellDetail() {
	// 팝업 창 
    var popupWidth = 500;
    var popupHeight = 700;
    var left = (window.innerWidth - popupWidth) / 2;
    var top = (window.innerHeight - popupHeight) / 2;
    var popupFeatures = 'width=' + popupWidth + ',height=' + popupHeight +
                        ',left=' + left + ',top=' + top +
                        ',resizable=yes,scrollbars=yes';
	
    window.open( '${pageContext.request.contextPath}/sell/sellUpdate?sellCode=${sellDTO.sellCode}','popupUrl', popupFeatures);
	
    function submitClose() {
    	 window.close();
	
	}
}
<!--------------------------------------------------- 비고 보기 ----------------------------------------->

    function openSellMemo(sellCode) {
        // 팝업 창의 속성을 설정합니다.
        var popupWidth = 450;
        var popupHeight = 500;
        var left = (window.innerWidth - popupWidth) / 2;
        var top = (window.innerHeight - popupHeight) / 2;
        var popupFeatures = 'width=' + popupWidth + ',height=' + popupHeight +
                            ',left=' + left + ',top=' + top +
                            ',resizable=yes,scrollbars=yes';

        // 새 창을 열기 위한 URL 설정
        var url = '${pageContext.request.contextPath}/sell/sellMemo?sellCode=' + sellCode;

        // 팝업 창을 열고 속성 설정
        var newWindow = window.open(url, '_blank', popupFeatures);       
    }


<!--------------------------------------------------- 비고 추가 ----------------------------------------->

    function addSellMemo(sellCode) {
        // 팝업 창의 속성을 설정합니다.
        var popupWidth = 450;
        var popupHeight = 500;
        var left = (window.innerWidth - popupWidth) / 2;
        var top = (window.innerHeight - popupHeight) / 2;
        var popupFeatures = 'width=' + popupWidth + ',height=' + popupHeight +
                            ',left=' + left + ',top=' + top +
                            ',resizable=yes,scrollbars=yes';

        // 새 창을 열기 위한 URL 설정
        var url = '${pageContext.request.contextPath}/sell/sellMemotype?sellCode=' + sellCode+'&memotype=add';
        // 팝업 창을 열고 속성 설정
        var newWindow = window.open(url, '_blank', popupFeatures); 
    }
    
 // 팝업창에서 작업 완료후 닫고 새로고침
    $(document).ready(function() {
//     	var refreshAndClose = true; // refreshAndClose 값을 변수로 설정
//         if (refreshAndClose) {
//             window.opener.location.reload(); // 부모창 새로고침
//             window.close(); // 현재창 닫기
//         }
           
        document.addEventListener('DOMContentLoaded', ()=> {
    		excelDownload.addEventListener('click', exportExcel);
       	});
    });
 </script>
</body>
</html>
