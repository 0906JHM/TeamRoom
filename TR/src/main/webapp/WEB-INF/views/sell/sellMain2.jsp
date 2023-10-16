<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>Sell/sellMain.jsp</title>

<%-- <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> --%>
<link href="${pageContext.request.contextPath }/resources/css/side.css"	rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/sell.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/daterange.css" rel="stylesheet" type="text/css"><!-- 수주일자 기간선택 -->



</head>

<!------------------------------------------------------- 헤더 ---------------------------------------------------->

<!---------------------------------------------------- 상단 조회 및 버튼 ----------------------------------------------------->

<!-- <div class="outer-container"> -->
<body>
    <jsp:include page="../inc/side.jsp"></jsp:include>
	<div class="main-content" >
	    <h2>수주 관리</h2>
	    <div class="horizontal-line"></div>
	    <form>

	        <label>수주 코드</label>  <input type="text">
	        
	        <label>거래처</label> 
	        <input type="text" id="clientCode9999" name="clientCode" onclick=searchItem('client','clientCode9999'); placeholder="거래처 코드" readonly >
        	<input type="text" id="clientCompany9999" placeholder="거래처명" onclick=searchItem('client','clientCode9999'); readonly >
		
	        <label>제품</label>  
	        <input type="text" name="prodCode" id="prodCode9999" onclick=searchItem('prod','prodCode9999'); placeholder="제품 코드" readonly>
	      	<input type="text" name="prodName" id="prodName9999" placeholder="제품명" readonly onclick="searchItem('prod','prodCode9999')">
	      
	        <br> 
	        
	       	<label>처리 상태</label>  <input type="text" vale=""><!--outProduct에서 출고완료 체크하면 출고완료 표시되도록 -->
	       	<label for="startDate">수주 일자</label> 
	       		<input type="text" name="daterange" value="" >
			<label for="startDate">납기일자</label> 
				<input type="text" name="daterange" value="" >
	        
	        <button id="btnSell" type="submit" onclick="location.href='${pageContext.request.contextPath}/sell/sellSearch'">조회</button>
	
	    	
	    </form><br>
	<div class="horizontal-line"></div>
	<!---------------------------------------------------- 본문 테이블 ----------------------------------------------------->    
	   <div>
	    <button id="btnSell" onclick="openSellAdd()">추가</button>
	  	<button id="btnSell">수정</button>
	   	<button id="delete" >삭제</button>
	    <button type="reset" id="btnSell">취소</button>
	    <button id="btnSell" >Excel</button>
	   </div>
	    
	    <p>선택 총 0건</p>        
	   
	    <p> <input type="checkbox" id="select-list-all"name="select-list-all" data-group="select-list">전체 선택</p>
	    
	    <table class="tg" id="sellTable">
	        <tbody>
	            <tr>
	           	 	<td class="tg-llyw">선택</td>
	                <td class="tg-llyw">번호</td>
	                <td class="tg-llyw">처리 상태</td>
	                <td class="tg-llyw">수주 코드</td>
	                <td class="tg-llyw">거래처 코드</td>
	                <td class="tg-llyw">제품 코드</td>
	                <td class="tg-llyw">제품명</td>
	                <td class="tg-llyw">제품 단가</td>
	                <td class="tg-llyw">수주 수량</td>
	                <td class="tg-llyw">수주 단가</td>
	                <td class="tg-llyw">수주 일자</td>
	                <td class="tg-llyw">납기 일자</td>
	                <td class="tg-llyw">담당자</td>
	                <td class="tg-llyw">비고</td>
	         
	            </tr>
	            
	            <c:forEach var="sellDTO" items="${sellList}">
	            <tr>
	            	<td class="tg-llyw2"><input type="checkbox" class="item-checkbox" id="select-list"
									value="${sellDTO.sellCode}" name="selectedSellCode"
									data-group="select-list"></td>
	            
	        	    <td class="tg-llyw2">${sellDTO.sellNum}</td><!-- 목록번호 --> 
	                <td class="tg-llyw2">${sellDTO.sellState}</td><!-- 처리(출고)상태 -->
	                <td class="tg-llyw2">${sellDTO.sellCode}</td><!-- 수주코드 -->
	                <td class="tg-llyw2">${sellDTO.clientCode}</td><!-- 거래처코드 -->
	                <td class="tg-llyw2">${sellDTO.prodCode}</td><!-- 제품코드 -->
	                <td class="tg-llyw2">${sellDTO.prodName}</td><!-- 제품명 -->
	                <td class="tg-llyw2"><fmt:formatNumber value="${sellDTO.prodPrice}" pattern="###,###원" /></td><!-- 제품단가 --> 
	                <td class="tg-llyw2"><fmt:formatNumber value="${sellDTO.sellPrice}" pattern="###,###원" /></td><!-- 수주단가 -->
	                <td class="tg-llyw2">${sellDTO.sellCount}</td><!-- 수주수량-->
	                <td class="tg-llyw2">${sellDTO.sellDate}</td><!-- 수주일자 -->
	                <td class="tg-llyw2">${sellDTO.sellDuedate}</td><!-- 납기일자  --> 
	                <td class="tg-llyw2">${sellDTO.sellEmpId}</td><!-- 수주담당직원 -->
						
						<c:choose>
							<c:when test="${not empty sellDTO.sellMemo}">
								<td class="tg-llyw2"><a href="#"
									onclick="openSellMemo('${sellDTO.sellCode}'); return sellMemoClose();" style="color: red;">[보기]</a>
								</td>
							</c:when>
							<c:otherwise>
							
								<td class="tg-llyw2"><a href="#"
									onclick="addSellMemo('${sellDTO.sellCode}'); return sellMemoClose();" style="color:#384855;">[입력]</a></td>
							</c:otherwise>
						</c:choose>
						

	            </tr>
	             </c:forEach>
	        </tbody>
	    </table>
	
<!-- </div> -->
<div class="clear"></div>
<!------------------------------------------------- 페이징 ------------------------------------------>
<div id="page_control" >

<c:forEach var="i" begin="${sellPageDTO.startPage}" 
                   end="${sellPageDTO.endPage}" step="1">
<a href="${pageContext.request.contextPath}/sell/sellMain?pageNum=${i}"
	style="text-decoration: none; color: #5EC397;">${i}</a> 
</c:forEach>

<c:if test="${sellPageDTO.startPage > sellPageDTO.pageBlock}">
	<a href="${pageContext.request.contextPath}/sell/sellMain?pageNum=${sellPageDTO.startPage - sellPageDTO.pageBlock}"
	style="text-decoration: none; color: #5EC397;">◀</a>
</c:if>


<c:if test="${sellPageDTO.endPage < sellPageDTO.pageCount}">
	<a href="${pageContext.request.contextPath}/sell/sellMain?pageNum=${sellPageDTO.startPage + sellPageDTO.pageBlock}" 
	style="text-decoration: none; color: #5EC397;">▶</a>
</c:if>

</div>
</div>
</body>

<!---------------------------------------------- javascript ---------------------------------------------->
<script type="text/javascript">

//팝업 옵션
const popupOpt = "top=60,left=140,width=720,height=600";

//검색 팝업
	function searchItem(type, inputId) {
	 	var url = "${pageContext.request.contextPath}/search/search?type=" + type + "&input=" + inputId;
	var popup = window.open(url, "", popupOpt);
} //openWindow()


</script>

<!--------------------------------------------------- 목록 전체 선택 ----------------------------------------->
<script>
	// 전체선택
	document.getElementById("select-list-all").addEventListener(
			"click",
			function() {
				var itemCheckboxes = document
						.querySelectorAll(".item-checkbox");
				var selectAllButton = document
						.getElementById("select-list-all");

				// 모든 아이템을 선택 상태로 만들거나 해제
				var areAllSelected = true;
				for (var i = 0; i < itemCheckboxes.length; i++) {
					if (!itemCheckboxes[i].checked) {
						areAllSelected = false;
						break;
					}
				}
				for (var i = 0; i < itemCheckboxes.length; i++) {
					itemCheckboxes[i].checked = !areAllSelected;
				}
			});//select-list-all
			
			// 숫자를 ###,### 원 형식으로 포맷하는 함수
		    function formatCurrency(number) {
		        return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '원';
		    }
</script>

<!--------------------------------------------------- 수주, 납기일자 기간선택 ----------------------------------------->
<script>

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
</script>

<!--------------------------------------------------- 수주 추가 ----------------------------------------->
<script type="text/javascript">
// 팝업 창을 열기 위한 JavaScript 함수를 정의합니다.
function openSellAdd() {

    // 팝업 창의 속성을 설정합니다.
    var popupWidth = 500;
    var popupHeight = 700;
    var left = (window.innerWidth - popupWidth) / 2;
    var top = (window.innerHeight - popupHeight) / 2;
    var popupFeatures = 'width=' + popupWidth + ',height=' + popupHeight +
                        ',left=' + left + ',top=' + top +
                        ',resizable=yes,scrollbars=yes';

    // selladd.jsp 파일을 팝업 창으로 엽니다.
    window.open( '${pageContext.request.contextPath}/sell/sellAdd','popupUrl', popupFeatures);
    
    function submitClose() {
        // 여기에 수주 등록 폼을 서버에 제출하는 코드를 추가하세요.
        
        // 폼을 제출한 후 창을 닫기 위해 아래 코드를 사용합니다.
        window.close();
    }
} 
</script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>

<!-------------------------------------------------- 수주 삭제 ------------------------------------------->
<script>
//삭제 버튼 누를 시 실행되는 함수
$('#delete').click(function(event){	
	
		
		var checked = [];
		
		$('input[name=selectedSellCode]:checked').each(function(){
			checked.push($(this).val());
		});
		
//			alert(checked);
		
		if(checked.length > 0) {
			Swal.fire({
				  title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "총" +checked.length+"건\n정말 삭제하시겠습니까?"+ "</div>",
						  // “<div style=’color:#f00;font-size:15px’>” + msg + “</div>”,    //  HTML & CSS 로 직접수정
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
						url: "${pageContext.request.contextPath}/product/delete",
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
				
		}// 체크OOO
		else{
			Swal.fire({
				title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "선택된 항목이 없습니다",
				icon : 'warning',
				width: '300px',
				});
		}
		
		// endAJAX(물품 삭제)
	 // end 정규식검사

}); 
//
});// end function
</script>


<!--------------------------------------------------- 비고 보기 ----------------------------------------->
<script>
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
</script>

<!--------------------------------------------------- 비고 추가 ----------------------------------------->
<script>
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
    <!--------------------------------------------------- 엑셀 다운로드 ----------------------------------------->
  

</html>