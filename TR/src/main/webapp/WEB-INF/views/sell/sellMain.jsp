
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
<link href="${pageContext.request.contextPath }/resources/css/side.css"	rel="stylesheet" type="text/css">
<!-- 본문 css -->
<%-- <link href="${pageContext.request.contextPath }/resources/css/outProduct.css">
 --%><link href="${pageContext.request.contextPath }/resources/css/sell.css" rel="stylesheet" type="text/css">

<script	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<!-- J쿼리 호출 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- 엑셀 다운로드 -->
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
<!-- 수주일자 기간선택 -->
<link href="${pageContext.request.contextPath}/resources/css/daterange.css" rel="stylesheet" type="text/css"><!-- 수주일자 기간선택 -->

<!-- 모달창 script -->
	<script>
      //modal창에 열기 위한 이벤트 헨들러
        function openModal(e) {
        	//modal창의 id 값 할당
            const myModal = document.getElementById("myModal");
           const elements = [];
            for (let i = 1; i <= 10; i++) {
                elements[i] ='element' + i;
            }
        	//클릭한 요소의 name의 속성 값을 가져와서 clickedElementName변수에 저장한다
        	//즉 이 부분은 클릭한 요소의 name속성을 추출하는 역할
        	// "getBoundingClientRect()" 메서드를 사용하여 클릭한 요소의 화면 좌표 정보를 가져옵니다.
        	// 이 정보는 모달 창의 위치를 설정하는 데 사용됩니다.           
            /* const clickedElementValue = e.getAttribute("name"); */
        	
        	//클릭한 요소의 좌표정보 
            const rect = e.getBoundingClientRect();
           
            
        	// 클릭한 요소의 오른쪽 아래 모서리의 화면 좌표를 "x"와 "y" 변수에 저장합니다.
        	// 이것은 모달 창을 클릭한 요소의 위치에 배치하는 데 사용됩니다.
            var xr = rect.right;
            var xl = rect.left;
            var yt = rect.top;
            var yb = rect.bottom; 
            var xg = (xr-xl)/2;
            var yg = (yt-yb)/2;
            var x =  xl+xg;
            var y = yb+yg;
           
            //클릭후에 모달창을 생성하는 위치를 조정
            myModal.style.left = x + "px";
            myModal.style.top = y + "px";
            myModal.style.display = "block";
            
            // modalContent를 초기화 (이전 내용 지우기)
            myModal.innerHTML = "";
           
            //닫기
            myModal.innerHTML = `<span id="closeModalButton" style="cursor: pointer;">닫기</span><br>`;
            const clickedElementId = e.getAttribute("id");
            if(clickedElementId.startsWith("PR")){
            	//modal_ajax 
            	$.ajax({
            	  url : '${pageContext.request.contextPath}/KDMajax/modalprod',
            	  data: {prodCode:clickedElementId},
            	  type : 'GET',
            	  dataType:'json',
            	  success: function (json) {
                      if (json && typeof json === 'object') {
                    	  
                    	// 값 할당
                    	addInput("제품 이름:", elements[0],json.prodName);
            	addInput("제품 단위:", elements[1],json.prodUnit);
            	addInput("용량:", elements[2],json.prodSize);
            	addInput("향기 종류:", elements[3],json.prodPerfume);
            	addInput("거래처 코드:", elements[4],json.clientCode);
                addInput("창고 코드:", elements[5],json.whseCode);
                addInput("매출 단가:", elements[6],json.prodPrice);
                addInput("제품 비고:", elements[7],json.prodMemo);
                    	} else {
                    	    // JSON 데이터가 없거나 빈 경우에 대한 처리를 추가
                    	    console.error("JSON 데이터가 비어 있거나 유효하지 않습니다. json: " + JSON.stringify(json));
                    	}

                  }
              });	
            	

      	  }  else if(clickedElementId.startsWith("SL")){
              	//modal_ajax 
              	$.ajax({
              	  url : '${pageContext.request.contextPath}/KDMajax/modalsell',
              	  data: {sellCode:clickedElementId},
              	  type : 'GET',
              	  dataType:'json',
              	  success: function (json) {
                        if (json && typeof json === 'object') {
                        	// 값 할당
                        	

                      	addInput("수주 일자:", elements[0],json.sellDate);
              	addInput("납기 일자:", elements[1],json.sellDuedate);
              	addInput("관리 사원:", elements[2],json.sellEmpId);
              	addInput("수주 수량:", elements[3],json.sellCount);
                  addInput("수주 단가:", elements[4],json.sellPrice);
                  addInput("제품 코드:", elements[5],json.prodCode);
                  addInput("제품 이름:", elements[6],json.prodName);
                  addInput("수주 비고:", elements[7],json.sellMemo);
                  addInput("출고 상태:", elements[8],json.sellState);
                  addInput("거래처 이름:", elements[9],json.clientCompany);
                  addInput("거래처 코드:", elements[10],json.clientCode);
                      	} else {
                      	    // JSON 데이터가 없거나 빈 경우에 대한 처리를 추가
                      	    console.error("JSON 데이터가 비어 있거나 유효하지 않습니다. json: " + JSON.stringify(json));
                      	}
                        }
                });	//기존 닫기 창 함수
               
        }  else if(clickedElementId.startsWith("WI")){
        	
        	var result = clickedElementId.substring(clickedElementId.indexOf("WI") + 2);
          	 	
          	
          	var elementsStartingWithL = [];

          	// 문자열을 "L"로 분할하여 배열로 만들기
          	var elementss = result.split("L");

          	// 배열을 순회하며 "L"로 시작하는 부분을 찾아내어 새로운 배열에 저장
          	for (var i = 1; i < elementss.length; i++) {
          	    elementsStartingWithL.push("L" + elementss[i]);
          	}
          
          	for (var i = 0; i < elementsStartingWithL.length; i++) {
          	    var label = (i + 1) + "차";
          	    addInput(label, elements[i], elementsStartingWithL[i]);
          	}
                  
            
           
    }
        else if(clickedElementId.startsWith("GL")||clickedElementId.startsWith("LB")||clickedElementId.startsWith("PC")||clickedElementId.startsWith("PE")||clickedElementId.startsWith("ST")){
          	//modal_ajax 
          	$.ajax({
          	  url : '${pageContext.request.contextPath}/KDMajax/modalraw',
          	  data: {rawCode:clickedElementId},
          	  type : 'GET',
          	  dataType:'json',
          	  success: function (json) {
                    if (json && typeof json === 'object') {
                    	// 값 할당
                  	addInput("원자재 이름:", elements[0],json.rawName);
          	addInput("원자재 종류:", elements[1],json.rawType);
          	addInput("원자재 단위:", elements[2],json.rawUnit);
          	addInput("원자재 가격:", elements[3],json.rawPrice);
              addInput("거래처 코드:", elements[4],json.clientCode);
              addInput("창고 코드:", elements[5],json.whseCode);
              addInput("원자재 비고:", elements[6],json.rawMemo);
                  	} else {
                  	    // JSON 데이터가 없거나 빈 경우에 대한 처리를 추가
                  	    console.error("JSON 데이터가 비어 있거나 유효하지 않습니다. json: " + JSON.stringify(json));
                  	}
                    }
            });	//기존 닫기 창 함수
           
    }
        else if(clickedElementId.startsWith("CL")||clickedElementId.startsWith("OR")){
          	//modal_ajax 
          	$.ajax({
          	  url : '${pageContext.request.contextPath}/KDMajax/modalclient',
          	  data: {clientCode:clickedElementId},
          	  type : 'GET',
          	  dataType:'json',
          	  success: function (json) {
                    if (json && typeof json === 'object') {
                    	// 값 할당
                    	

                  	addInput("이름:", elements[0],json.clientCompany);
          	addInput("분류:", elements[1],json.clientType);
          	addInput("사업자번호:", elements[2],json.clientNumber);
          	addInput("상세분류:", elements[3],json.clientDetail);
              addInput("대표이름:", elements[4],json.clientCeo);
              addInput("담당자:", elements[5],json.clientName);
              addInput("주소:", elements[6],json.clientAddr1);
              addInput("상세주소:", elements[7],json.clientAddr2);
              addInput("대표 번호:", elements[8],json.clientTel);
              addInput("담당자 번호:", elements[9],json.clientPhone);
              addInput("팩스:", elements[10],json.clientFax);
              addInput("이메일:", elements[11],json.clientEmail);
              addInput("비고:", elements[12],json.clientMemo);
                  	} else {
                  	    // JSON 데이터가 없거나 빈 경우에 대한 처리를 추가
                  	    console.error("JSON 데이터가 비어 있거나 유효하지 않습니다. json: " + JSON.stringify(json));
                  	}
                    }
            });	//기존 닫기 창 함수
           
    }
            
        else if(clickedElementId.startsWith("WH")){
          	//modal_ajax 
          	$.ajax({
          	  url : '${pageContext.request.contextPath}/KDMajax/modalwhse',
          	  data: {whseCode:clickedElementId},
          	  type : 'GET',
          	  dataType:'json',
          	  success: function (json) {
                    if (json && typeof json === 'object') {
                    	// 값 할당
                    	

                  	addInput("이름:", elements[0],json.whseName);
          	addInput("타입:", elements[1],json.whseType);
          	addInput("사용 상태", elements[2],json.whseState);
          	addInput("주소:", elements[3],json.whseAddr);
              addInput("연락처:", elements[4],json.whseTel);
              addInput("비고:", elements[5],json.whseMemo);
              addInput("제품 코드:", elements[6],json.prodCode);
              addInput("원자재 코드:", elements[7],json.rawCode);
              addInput("담당자:", elements[8],json.whseEmpId);
                  	} else {
                  	    // JSON 데이터가 없거나 빈 경우에 대한 처리를 추가
                  	    console.error("JSON 데이터가 비어 있거나 유효하지 않습니다. json: " + JSON.stringify(json));
                  	}
                    }
            });	//기존 닫기 창 함수
           
    }
        else if(!isNaN(clickedElementId.charAt(0))){
          	//modal_ajax 
          	$.ajax({
          	  url : '${pageContext.request.contextPath}/KDMajax/modalemp',
          	  data: {empId:clickedElementId},
          	  type : 'GET',
          	  dataType:'json',
          	  success: function (json) {
                    if (json && typeof json === 'object') {
                    	// 값 할당
                    	

                  	addInput("이름:", elements[0],json.empName);
          	addInput("부서:", elements[1],json.empDepartment);
          	addInput("직급:", elements[2],json.empPosition);
          	addInput("이메일:", elements[3],json.empEmail);
              addInput("연락처:", elements[4],json.empTel);
              addInput("재직상태:", elements[5],json.empState);
              addInput("입사일:", elements[6],json.empHiredate);
                  	} else {
                  	    // JSON 데이터가 없거나 빈 경우에 대한 처리를 추가
                  	    console.error("JSON 데이터가 비어 있거나 유효하지 않습니다. json: " + JSON.stringify(json));
                  	}
                    }
            });	//기존 닫기 창 함수
           
    } else if(clickedElementId.startsWith("WO")){
      	//modal_ajax 
      	$.ajax({
      	  url : '${pageContext.request.contextPath}/KDMajax/modalworkorder',
      	  data: {workCode:clickedElementId},
      	  type : 'GET',
      	  dataType:'json',
      	  success: function (json) {
                if (json && typeof json === 'object') {
                	// 값 할당
                	

              	addInput("제품코드:", elements[0],json.prodCode);
      	addInput("수주코드:", elements[1],json.sellCode);
      	addInput("지시일", elements[2],json.workDate);
      	addInput("라인코드:", elements[3],json.lineCode);
          addInput("지시수량:", elements[4],json.workAmount);
          addInput("작업지시자:", elements[5],json.workEmpId);
          addInput("추가지시일:", elements[6],json.workDatechange);
          addInput("라인내역:", elements[7],json.workInfo);
              	} else {
              	    // JSON 데이터가 없거나 빈 경우에 대한 처리를 추가
              	    console.error("JSON 데이터가 비어 있거나 유효하지 않습니다. json: " + JSON.stringify(json));
              	}
                }
        });	//기존 닫기 창 함수
       
}
            
            
            
            //ajax
            closeModalButton.addEventListener("click", function (e) {
          	    if (e.target === closeModalButton) {
          	        myModal.style.display = "none";
          	    }
          	});
      }    
            //input시 동적으로 생성하기 위한 함수
            function addInput(label, id, value) {
                const div = document.createElement("div");
                const input = document.createElement("input");
                div.style.display = "flex";
                div.style.justifyContent = "flex-end";
                input.type = "text";
                input.id = id;
                input.value = value; // 값을 설정
                input.size = 9;
                input.readOnly = true;
                div.appendChild(document.createTextNode(label));
                div.appendChild(input);
                myModal.appendChild(div);
            }
          	</script>

</head>

<body>

	<!------------------------------------------------------- 사이드바 ---------------------------------------------------->
	<jsp:include page="../inc/side.jsp"></jsp:include>

	<!------------------------------------------------------- 본문 타이틀 ---------------------------------------------------->
	<div class="container">
		<h2><a href="${pageContext.request.contextPath}/sell/sellMain" style=" text-decoration: none; color:black;">수주 관리</a></h2>

		<!------------------------------------------------------- 상단 검색란 ---------------------------------------------------->
		<form action="${pageContext.request.contextPath}/sell/sellMain"	method="get" id="searchBox">
		<div id="searchform" style="border-radius: 5px;">
			
				<label>수주 코드</label> <input type="text" id="sellCode" name="sellCode" value="${sellDTO.sellCode}"> 
				
				<label>거래처</label> 
	        <input type="text" id="sellclientCode9999" name="clientCode" value="${sellDTO.clientCode}" onclick=searchItem('sellclient','sellclientCode9999'); placeholder="거래처 코드" readonly >
        	<input type="text" id="sellclientCompany9999" name="clientCompany" placeholder="거래처명" value="${sellDTO.clientCompany}" onclick=searchItem('sellclient','sellclientCode9999'); readonly >
		
				
				
				<label>제품</label>  
	        <input type="text" name="prodCode" id="prodCode9999" value="${sellDTO.prodCode}"  onclick=searchItem('prod','prodCode9999'); placeholder="제품 코드" readonly>
	      	<input type="text" name="prodName" id="prodName9999" value="${sellDTO.prodName}"  placeholder="제품명" readonly onclick="searchItem('prod','prodCode9999')">
	      
				
				
				<label for="startDate">수주 일자</label> 
	       		<input type="text" id="sellDate" name="daterange1" value="${sellDTO.sellDate}" class="daterange" style="width:180px;">
				
				<label for="startDate">납기일자</label> 
				<input type="text" id="sellDuedate" name="daterange2" value="${sellDTO.sellDuedate}" class="daterange" style="width:180px;">
				
				<input type="hidden" id="sellState" name="sellState" value="${sellDTO.sellState}">
			
				<input type="submit" value="조회" id="searchButton" class="btn">
				<input type="button" value="취소" id="resetButton" class="btn">
			
		</div>
		<br>
		<!------------------------------------------------------- 추가, 수정, 삭제 버튼 ---------------------------------------------------->
		<div id="sample">
			<div id="buttons">
			<input type="submit" class="buttons highlighted" value="전체" id="allButton">
    		<input type="submit" class="buttons " value="미출고" id="non_deliveryButton">
    		<input type="submit" class="buttons " value="중간납품" id="interim_deliveryButton">
    		<input type="submit" class="buttons " value="출고완료" id="deliveryButton">
			</div>
			
			<div class="buttons">
			
			<button  style="display: none;" id="add" onclick="openSellAdd()" class="btn">추가</button>
			<button  style="display: none;" id="delete" class="btn">삭제</button>
			</div>
		<!------------------------------------------------------- 수주 상태---------------------------------------------------->
		</div>
		</form>
	<div class="total-items">
		 <div>
			 <label>총 ${sellDTO.count}건</label>
		 </div>
		 <div class="PageSelect">
 			<label for="perPageSelect" style ="bottom:2px;">항목 수 </label>
			<select id="perPageSelect" class="input_box" style ="width:100px; bottom:2px;" onchange="applyFilters()" value="${sellDTO.pageSize}">
			    <option value="10" ${sellDTO.pageSize == 10 ? 'selected' : ''}>10개씩</option>
			    <option value="50" ${sellDTO.pageSize == 50 ? 'selected' : ''}>50개씩</option>
			    <option value="100" ${sellDTO.pageSize == 100 ? 'selected' : ''}>100개씩</option>
			    <option value="9999" ${sellDTO.pageSize == 9999 ? 'selected' : ''}>전체</option>
			</select>
		</div>
	</div>

		<!------------------------------------------------------- 수주 목록 ---------------------------------------------------->
		

		<form id="selltList">
			<div id="sellList">
				<table class="tg" id="sellTable"  style="border-radius: 5px;">
					<thead>
						<tr>
							<td><input type="checkbox" id="select-list-all"	name="select-list-all" data-group="select-list"></td>
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
								<td><input type="checkbox"
									value="${sellDTO.sellCode}" name="selectedSellCode"
									data-group="select-list"></td>

								
								<td>${sellDTO.sellState}</td><!-- 처리(출고)상태 -->
								
								<td	onclick="openSellDetail('${sellDTO.sellCode}')" class="sellDetailLink">${sellDTO.sellCode}</td><!-- 수주코드 -->
								
								<td>${sellDTO.clientCode}</td><!-- 거래처코드 -->
								<td style='cursor: pointer;' onclick="openModal(this)" id="${w.sellCode }" name="sellCode" value="${w.sellCode}">${w.sellCode}</td>
						
								
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
        <td class="tg-llyw2">
            <a href="#" onclick="openSellMemo('${sellDTO.sellCode}'); return sellMemoClose();" 
            style="color:#C63D2F; text-decoration: none;">보기</a>
        </td>
    </c:when>
    <c:otherwise>
    <td class="tg-llyw2">
                    <a href="#" onclick="addSellMemo('${sellDTO.sellCode}'); return sellMemoClose();" 
                     style="display: none; color: #384855; text-decoration: none;"  class="memoAdd">입력</a>
                     
                </td>
       
    </c:otherwise>
</c:choose>
							</tr>
						</c:forEach>
					</tbody>

				</table>
				</div>
				
		</form>
	
			
			
			<!------------------------------------------------- 페이징 ------------------------------------------>
			<div id="pagination" class="page_wrap">
			<input type="submit" id="exportButton" value="엑셀">
			<div class="page_nation">
			<c:if test="${sellDTO.startPage > sellDTO.pageBlock}">
				<a class="arrow prev"
					href="${pageContext.request.contextPath}/sell/sellMain?pageNum=${sellDTO.startPage - sellDTO.pageBlock}&sellCode=${sellDTO.sellCode}&prodCode=${sellDTO.prodCode}&clientCode=${sellDTO.clientCode}&sellDate=${sellDTO.sellDate}&sellDuedate=${sellDTO.sellDuedate}&sellState=${sellDTO.sellState}"
					style="text-decoration: none; color: #5EC397;">◀</a>
			</c:if>
			
			
<c:forEach var="i" begin="${sellDTO.startPage}"	end="${sellDTO.endPage}" step="1">
  <c:choose>
        <c:when test="${i eq sellDTO.currentPage}">
            <a class="a active"
					href="${pageContext.request.contextPath}/sell/sellMain?pageNum=${i}&sellCode=${sellDTO.sellCode}&prodCode=${sellDTO.prodCode}&clientCode=${sellDTO.clientCode}&sellDate=${sellDTO.sellDate}&sellDuedate=${sellDTO.sellDuedate}&sellState=${sellDTO.sellState}"
					>${i}</a>
			 		 </c:when>
					 <c:otherwise>
			
				<a class="a"
					href="${pageContext.request.contextPath}/sell/sellMain?pageNum=${i}&sellCode=${sellDTO.sellCode}&prodCode=${sellDTO.prodCode}&clientCode=${sellDTO.clientCode}&sellDate=${sellDTO.sellDate}&sellDuedate=${sellDTO.sellDuedate}&sellState=${sellDTO.sellState}"
					>${i}</a>
			 </c:otherwise>
</c:choose>
</c:forEach>

			<c:if test="${sellDTO.endPage < sellDTO.pageCount}">
				<a class="arrow next"
					href="${pageContext.request.contextPath}/sell/sellMain?pageNum=${sellDTO.startPage + sellDTO.pageBlock}&sellCode=${sellDTO.sellCode}&prodCode=${sellDTO.prodCode}&clientCode=${sellDTO.clientCode}&sellDate=${sellDTO.sellDate}&sellDuedate=${sellDTO.sellDuedate}&sellState=${sellDTO.sellState}"
					style="text-decoration: none; color: #5EC397;">▶</a>
			</c:if>
			</div>
			</div>
			</div>
			






	<!--################################################################ script ###################################################################-->
	

	
	<script type="text/javascript">

	 
	$(function() {
	    // 클래스로 daterangepicker 초기화
	    $('.daterange').daterangepicker({
	        autoUpdateInput: false,
	        locale: {
	            cancelLabel: 'Clear'
	        }
	    });

	    $('.daterange').on('apply.daterangepicker', function(ev, picker) {
	        $(this).val(picker.startDate.format('YYYY/MM/DD') + ' - ' + picker.endDate.format('YYYY/MM/DD'));
	    });

	    $('.daterange').on('cancel.daterangepicker', function(ev, picker) {
	        $(this).val('');
	    });

	    $('.cancelBtn').text('취소');
	    $('.applyBtn').text('적용');
	});

</script>

<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>

<script>
<!------------------------------------------------- 팝업창 옵션 ------------------------------------------>
//팝업 옵션
const popupOpt = "top=60,left=140,width=720,height=600";

//검색 팝업
	function searchItem(type, inputId) {
	 	var url = "${pageContext.request.contextPath}/search/search?type=" + type + "&input=" + inputId;
	var popup = window.open(url, "", popupOpt);
} //openWindow()

//팝업창에서 작업 완료후 닫고 새로고침
$(document).ready(function() {
	/* var refreshAndClose = true; // refreshAndClose 값을 변수로 설정
    if (refreshAndClose) {
        window.opener.location.reload(); // 부모창 새로고침
        window.close(); // 현재창 닫기
    } */

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
		
		console.log(checked);
		
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
					    data: JSON.stringify(checked), // 데이터를 JSON 문자열로 변환
					    contentType: "application/json", // Content-Type 설정
					    dataType: "text",
					    success: function (response) {
					    	console.log(response); // 서버에서 반환한 응답을 콘솔에 출력
					        // 서버에서의 응답을 처리합니다.
					        // response 변수에 서버에서 반환한 문자열이 들어있습니다.
					        Swal.fire({
					            title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + response + "</div>",
					            icon: 'success',
					            width: '300px',
					        }).then((result) => {
					            if (result.isConfirmed) {
					                location.reload();
					            }
					        });
					    },
					    error: function (response) {
					    	console.log(response); // 서버에서 반환한 응답을 콘솔에 출력
	                        Swal.fire({
	                            title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "삭제 중 오류가 발생했습니다",
	                            icon: 'question',
	                            width: '300px',
	                        });
	                    }
					});
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
 
<!--------------------------------------------------- 수주 추가 ----------------------------------------->

function openSellAdd() {

    // 팝업 창 
    var popupWidth = 400;
    var popupHeight = 670;
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

<!--------------------------------------------------- 수주 상세정보 ----------------------------------------->
function openSellDetail(sellCode) {
	// 팝업 창 
    var popupWidth = 500;
    var popupHeight = 700;
    var left = (window.innerWidth - popupWidth) / 2;
    var top = (window.innerHeight - popupHeight) / 2;
    var popupFeatures = 'width=' + popupWidth + ',height=' + popupHeight +
                        ',left=' + left + ',top=' + top +
                        ',resizable=yes,scrollbars=yes';
	
    window.open( '${pageContext.request.contextPath}/sell/sellDetail?sellCode='+sellCode,'popupUrl', popupFeatures);
	
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
    

    
    $(document).ready(function () {
    	<!--------------------------------------------------- 페이지 권한 ----------------------------------------->
    	var team = "${sessionScope.empDepartment }"; // 팀 조건에 따라 변수 설정
			
		  if (team === "영업팀" || team === "관리자") {
			  $('#add').show();
				
				$('#delete').show();
				$('.memoAdd').show();
				
		   }
		  else if (team ===""){
			  window.location.href = "${pageContext.request.contextPath}/login/logout";
		  }
		  <!--------------------------------------------------- 엑셀 다운로드 ----------------------------------------->
// 		document.addEventListener('DOMContentLoaded', ()=> {
//            	exportButton.addEventListener('click', exportExcel);
//           	});
		
// 			 const exportButton = document.querySelector('#exportButton');
// 			 exportButton.addEventListener('click', exportExcel);
// 					function exportExcel() {
// 					    // 1. 워크북 생성
// 					    var wb = XLSX.utils.book_new();
// 					    // 2. 워크시트 생성
// 					    var newWorksheet = excelHandler.getWorksheet();
// 					    // 3. 워크시트를 워크북에 추가
// 					    XLSX.utils.book_append_sheet(wb, newWorksheet, excelHandler.getSheetName());
// 					    // 4. 엑셀 파일 생성
// 					    var wbout = XLSX.write(wb, { bookType: 'xlsx', type: 'binary' });
// 					    // 5. 엑셀 파일 내보내기
// 					    saveAs(new Blob([s2ab(wbout)], { type: 'application/octet-stream' }), excelHandler.getExcelFileName());
// 					}

// 					// 현재 날짜를 가져오는 함수
// 					function getToday() {
// 					    var date = new Date();
// 					    var year = date.getFullYear();
// 					    var month = (date.getMonth() + 1).toString().padStart(2, '0'); // 월은 0부터 시작하므로 1을 더하고 두 자리로 맞춥니다.
// 					    var day = date.getDate().toString().padStart(2, '0'); // 일을 두 자리로 맞춥니다.
// 					    return year + month + day;
// 					}

// 			var excelHandler = {
// 			getExcelFileName : function() {
// 				return '수주 리스트 '+getToday()+'.xlsx'; //파일명
// 			},
// 			getSheetName : function() {
// 				return 'Sell Sheet'; //시트명
// 			},
// 			getExcelData : function() {
// 				return document.getElementById('sellTable'); //table id
// 			},
// 			getWorksheet : function() {
// 				return XLSX.utils.table_to_sheet(this.getExcelData());
// 			}
// 		} //excelHandler
			
// 			function s2ab(s) {
				
// 				var buf = new ArrayBuffer(s.length);  // s -> arrayBuffer
// 				var view = new Uint8Array(buf);  
// 				for(var i=0; i<s.length; i++) {
// 					view[i] = s.charCodeAt(i) & 0xFF;
// 				}
// 				/* alert("이까지 옴"); */
// 				return buf;
// 			}
	  });
    
   <!--------------------------------------------------- 상단 조건 검색 ----------------------------------------->
 document.addEventListener('DOMContentLoaded', function () {
	    var allButton = document.getElementById('allButton');
	    var nonDeliveryButton = document.getElementById('non_deliveryButton');
	    var interimDeliveryButton = document.getElementById('interim_deliveryButton');
	    var deliveryButton = document.getElementById('deliveryButton');
	    var sellStateInput = document.querySelector('input[name="sellState"]');
	  
	    allButton.addEventListener('click', function () {
	        // 전체 버튼을 클릭할 때, input 태그의 값을 변경
	        sellStateInput.value = "";
// 	        $('#selectedProId').submit();
	    });

	    nonDeliveryButton.addEventListener('click', function () {
	        // 미출고 버튼을 클릭할 때, input 태그의 값을 변경
	        sellStateInput.value = "미출고";
// 	        $('#selectedProId').submit();
	    });

	    interimDeliveryButton.addEventListener('click', function () {
	        // 중간납품 버튼을 클릭할 때, input 태그의 값을 변경
	        sellStateInput.value = "중간납품";
// 	        $('#selectedProId').submit();
	    });

	    deliveryButton.addEventListener('click', function () {
	        // 출고완료 버튼을 클릭할 때, input 태그의 값을 변경
	        sellStateInput.value = "출고완료";
// 	        $('#selectedProId').submit();
	    });
	});
 
//-------------------------------------------------- 검색 초기화 -----------------------------------
 $("#resetButton").click(function () {
 	$(".buttons").removeClass("highlighted");

     // 클릭한 버튼에 "highlighted" 클래스 추가
     $("#allButton").addClass("highlighted");
 	
     sellStateButton2 = "전체";
 	sellStateButton1 = sellStateButton2;
     
 	$("#sellCode").val('');
 	$("#sellclientCode9999").val('');
 	$("#sellclientCompany9999").val('');
 	$("#prodCode9999").val('');
 	$("#prodName9999").val('');
 	$("#sellDate").val('');
 	$("#sellDuedate").val('');
    $("#sellState").val('');
     firstLoadSellList();
 });
//----------------------------------- 페이지 항목 수 설정 -----------------------------------
 function applyFilters() {
        var perPageValue = document.getElementById("perPageSelect").value;
        var sellCode = "${sellDTO.sellCode}";
        var prodCode = "${sellDTO.prodCode}";
        var clientCode = "${sellDTO.clientCode}";
        var sellDate = "${sellDTO.sellDate}";
        var sellDuedate = "${sellDTO.sellDuedate}";
        var sellState = "${sellDTO.sellState}";

        var url = '${pageContext.request.contextPath}/sell/sellMain?pageNum=1&cntPerPage=' + perPageValue +
            '&sellCode=' + sellCode + '&prodCode=' + prodCode +
            '&clientCode=' + clientCode + '&sellDate=' + sellDate + '&sellDuedate=' + sellDuedate + '&sellState' + sellState;

        // Redirect to the generated URL
        window.location.href = url;
    }

	//엑셀
	// 버튼 클릭 시 실행
	// 클라이언트에서 서버로 데이터 요청
	document.getElementById('exportButton').addEventListener('click', function () {
		
			// 엑셀로 내보낼 데이터
		   var searchParams = {
				 sellCode: $("#sellCode").val(),
				 prodCode: $("#prodCode9999").val(),
				 clientCode: $("#sellclientCode9999").val(),
				 daterange1: $("#sellDate").val(),
				 daterange2: $("#sellDuedate").val(),
				 sellState: $("#sellState").val()			   
			};
		
		    $.ajax({
		        type: "POST", // GET 또는 POST 등 HTTP 요청 메서드 선택
		        url: "${pageContext.request.contextPath}/sell/excel", // 데이터를 가져올 URL 설정
		        data: searchParams, // 검색 조건 데이터 전달
		        dataType: "json", // 가져올 데이터 유형 (JSON으로 설정)
		        success: function (data) {
		            // 데이터 가공
					var modifiedData = data.map(function (item) {
					    return {
					        '처리 상태': item.sellState,
					        '수주 코드': item.sellCode,
					        '거래처 코드': item.clientCode,
					        '거래처명': item.clientCompany,
					        '제품 코드': item.prodCode,
					        '제품명': item.prodName,
					        '제품 단가': item.prodPrice,
					        '수주 수량': item.sellCount,
					        '수주 단가':item.sellPrice,
					        '수주 일자': item.sellDate,
					        '납기 일자': item.sellDuedate,
					        '담당자': item.sellEmpId,
					        '비고': item.sellMemo
					    };
					});
		            
					// 열의 너비 설정
		            var colWidths = [
					    { wch: 10 }, // 처리 상태
					    { wch: 15 }, // 수주 코드
					    { wch: 15 }, // 거래처 코드
					    { wch: 15 }, // 거래처명
					    { wch: 15 }, // 제품 코드
					    { wch: 15 }, // 제품명
					    { wch: 15 }, // 제품 단가
					    { wch: 10 }, // 수주 수량
					    { wch: 10 }, // 수주 단가
					    { wch: 15 }, // 수주 일자
					    { wch: 15 }, // 납기 일자
					    { wch: 10 }, // 담당자
					    { wch: 20 }  // 비고
					];
					
		            // 새 워크북을 생성
		            var wb = XLSX.utils.book_new();
		            // JSON 데이터를 워크시트로 변환
		            var ws = XLSX.utils.json_to_sheet(modifiedData);
		            // 열 너비 지정
		            ws['!cols'] = colWidths;
		            // 워크북에 워크시트 추가
		            XLSX.utils.book_append_sheet(wb, ws, "데이터 시트");
		            // Blob 형태로 워크북 생성
		            var wbout = XLSX.write(wb, { bookType: 'xlsx', type: 'binary' });
		            // 파일 이름 설정 (원하는 파일 이름으로 변경)
		            var fileName = "sell.xlsx";
		            // Blob 파일을 다운로드
		            saveAs(new Blob([s2ab(wbout)], { type: "application/octet-stream" }), fileName);
		        }
		    });
		
	});
	
	// ArrayBuffer 만들어주는 함수
	function s2ab(s) {
	    var buf = new ArrayBuffer(s.length); // convert s to arrayBuffer
	    var view = new Uint8Array(buf); // create uint8array as viewer
	    for (var i = 0; i < s.length; i++) view[i] = s.charCodeAt(i) & 0xFF; // convert to octet
	    return buf;
	}
	
</script>


</body>
</html>