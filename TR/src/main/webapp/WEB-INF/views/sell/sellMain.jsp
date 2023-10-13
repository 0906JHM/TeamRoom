<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<%--     <jsp:include page="test4.jsp"></jsp:include> --%>
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

	        <label>수주 코드</label>  <input type="text" >
	        
	        <label>거래처</label> 
	        <input type="text" id="clientCode9999" name="clientCode" onclick=searchItem('client','clientCode9999'); placeholder="거래처 코드" readonly >
        	<input type="text" id="clientCompany9999" placeholder="거래처명" onclick=searchItem('client','clientCode9999'); readonly >
		
	        <label>제품</label>  
	        <input type="text" name="prodCode" id="prodCode9999" onclick=searchItem('prod','prodCode9999'); placeholder="제품 코드" readonly>
		
		
	        <label>제품명</label> 
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
	   	<button id="btnSell">삭제</button>
	    <button type="reset" id="btnSell">취소</button>
	    <button id="btnSell">Excel</button>
	   </div>
	    
	    <p>선택 총 0건</p>        
	   
	    <p> <input type="checkbox" id="selectAllCheckbox">전체 선택</p>
	    
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
	            	<td class="tg-llyw2"><input type="checkbox" class="item-checkbox"></td>
	            
	        	    <td class="tg-llyw2">${sellDTO.sellNum}</td><!-- 목록번호 --> 
	                <td class="tg-llyw2">${sellDTO.sellState}</td><!-- 처리(출고)상태 -->
	                <td class="tg-llyw2">${sellDTO.sellCode}</td><!-- 수주코드 -->
	                <td class="tg-llyw2">${sellDTO.clientCode}</td><!-- 거래처코드 -->
	                <td class="tg-llyw2">${sellDTO.prodCode}</td><!-- 제품코드 -->
	                <td class="tg-llyw2">${sellDTO.prodName}</td><!-- 제품명 -->
	                <td class="tg-llyw2"></td>
	               <%--  <td class="tg-llyw2"><fmt:formatNumber value="${sellDTO.prodPrice}"pattern="###,### 원" /></td><!-- 제품단가 --> --%>
	                <td class="tg-llyw2"><fmt:formatNumber value="${sellDTO.sellPrice}" pattern="###,### 원" /></td><!-- 수주단가 -->
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


$(document).ready(function() {
    $('#add').click(function(event) {
        event.preventDefault();
        addRow();
    });
    
    $('#save').click(function(event) {
        event.preventDefault();
        saveData();
    })
});

var rowCount = 1; // 초기 행 번호 설정

function addRow() {
    var table = document.getElementById('productTable').getElementsByTagName('tbody')[0];
    
    var numRowsToAdd = 1; // 한 번에 추가할 행의 개수

    for (var i = 0; i < numRowsToAdd; i++) {
        var newRow = table.insertRow(table.rows.length);

        for (var j = 0; j < 10; j++) {
            var cell = newRow.insertCell(j);

            if (j === 0) {
                // 첫 번째 셀에는 일련번호 설정 (rowCount 사용)
                cell.innerHTML = rowCount++;
            } else {
                // 나머지 셀에는 입력 필드 추가
                cell.innerHTML = '<input type="text">';
            }
            
        }
    }
}

function saveData() {
    var table = document.getElementById('productTable').getElementsByTagName('tbody')[0];
    var newRow = table.rows[table.rows.length - 1]; // 마지막 행 가져오기

    var data = []; // 행의 데이터를 저장할 배열

    for (var j = 1; j < 10; j++) {
        var inputElement = newRow.cells[j].querySelector('input');
        var cellValue = inputElement.value;
        data.push(cellValue);
        
        // 값을 저장한 후 입력 필드를 비활성화(disabled) 상태로 변경
        inputElement.setAttribute('disabled', 'disabled');
    }

    // 여기서 data 배열에 저장된 데이터를 원하는 방식으로 처리하면 됩니다.
    // 예를 들어, 서버에 전송하거나 로컬 스토리지에 저장할 수 있습니다.

    // 데이터 처리 후, 필요한 작업을 수행하세요.
    alert('데이터가 저장되었습니다: ');
}
</script>

<!--------------------------------------------------- 목록 전체 선택 ----------------------------------------->
<script>
	// 전체선택
	document.getElementById("selectAllCheckbox").addEventListener(
			"click",
			function() {
				var itemCheckboxes = document
						.querySelectorAll(".item-checkbox");
				var selectAllButton = document
						.getElementById("selectAllCheckbox");

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
			});//selectAllCheckbox
			
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
        var url = '${pageContext.request.contextPath}/sell/sellMemotype?sellCode=' + sellCode+'?memotype=add';
        // 팝업 창을 열고 속성 설정
        var newWindow = window.open(url, '_blank', popupFeatures); 
    }
    
 // 팝업창에서 작업 완료후 닫고 새로고침
    $(document).ready(function() {
    	var refreshAndClose = true; // refreshAndClose 값을 변수로 설정
        if (refreshAndClose) {
            window.opener.location.reload(); // 부모창 새로고침
            window.close(); // 현재창 닫기
        }
    });
   
</script>

</html>