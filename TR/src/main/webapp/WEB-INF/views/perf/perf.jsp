<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-labels"></script>
	<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
    <script src="https://kit.fontawesome.com/25ef23e806.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

	
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/perf.css">
	<link href="${pageContext.request.contextPath }/resources/css/side.css" rel="stylesheet" type="text/css">
	
	 
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/datepicker.css"> 

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
<!-- 모달창 -->
	<div id="myModal" style="display: none;
	position: absolute;
	background-color: #fff;
	border: 1px solid #000;
	padding: 10px;
	z-index: 1;">
	</div>
	<!-- 모달창 -->
<jsp:include page="../inc/side.jsp"></jsp:include>

<!--  여기서부터 시작  -->
<div class="clientBody">
		<h1 class="toptitle">생산실적 관리</h1>


<div class="perfcd">
<form method ="get">
<div class="perfcd1">
<label> 라인코드:</label>  <input type="text" id="lineCode2" name="lineCode" onclick="" class="cdbox" readonly> <label>제품코드:</label> <input type="text" id="prodCode2" name="prodCode" onclick="" placeholder="제품코드" class="cdbox" onclick="" readonly> <input type="submit" value="조회" class="subbtn">



</div>
<!-- <div class="perfcd1">
 실적일: <input type="text" id="workdate1" name="perfDate1" class="form-control" placeholder="날짜 선택" readonly> ~ <input type="text" id="workdate2" name="perfDate2" class="form-control" placeholder="날짜 선택" readonly>
</div>  -->

</form>
</div> <!--  perfcd -->

	

	
<!--  본문 내용  -->
	<div class="clientbody1">
	<div class="tableform"> 
			<div class="clienttotal">
			 <h2> 총 ${pageDTO.count} 건 </h2>
			
			<div style="float: right;">
				<input type="button" value="추가" id="addButton" class="addbutton"
					onclick="perfInsert()">
			</div>	 <!-- 검색칸 -->	
			</div>   <!--  생산실적 총:x건 라인-->

		 <table class="ct" id="ct" class="ctcl">	
			<thead>
				<tr class="cthead">
				    <th class="ctth">생산실적코드</th>
					<th class="ctth">작업지시코드</th>
					<th class="ctth">라인코드</th>
					<th class="ctth">제품코드</th>
					<th class="ctth">실적일</th>
					<th class="ctth">실적수량</th>
					<th class="ctth">양품수</th>
					<th class="ctth">불량수</th>
					<th class="ctth">불량사유</th>
			        <th class="ctth">비고</th>
					<th class="ctth">현황</th> 
					
				</tr>
			</thead> 
		 <tbody>
				<c:forEach var="perfDTO" items="${perflist}">
					<tr class="ctcontents">	    
						<td class="cttg">${perfDTO.perfCode} <i class="fa-solid fa-magnifying-glass magnifier" data-perfcode="${perfDTO.perfCode}"></i></td>
						<%-- <td class="cttg">${perfDTO.workCode}</td> --%>
						<td> <label style='cursor: pointer;' onclick="openModal(this)" id="${perfDTO.workCode }" name="sellCode" value="${perfDTO.workCode}">${perfDTO.workCode}</label></td>
						<td class="cttg">${perfDTO.lineCode}</td>
						<td class="cttg">${perfDTO.prodCode}</td>
						<td class="cttg">${perfDTO.perfDate}</td>
						<td class="cttg">${perfDTO.perfAmount}</td>
						<td class="cttg">${perfDTO.perfFair}</td>
						<td class="cttg">${perfDTO.perfDefect}</td>
						<td class="cttg">${perfDTO.perfDefectreason}</td>
						<td class="cttg">${perfDTO.perfMemo}</td>
						<td class="cttg">${perfDTO.perfStatus}</td>				
					</tr>
					</c:forEach>
			</tbody> 

		</table>
		
		<div class="footlo">
		<div class="excel">

		 <button type="button" id="entrytable" class="entrytable" onclick="window.location.href='${pageContext.request.contextPath}/perf/perf?pageNum=1&endPage=100&lineCode=${perfDTO.lineCode}&prodCode=${clientDTO.prodCode}'">전체 보기</button>
		  <button type="button" id="exceldownload" class="exceldown" >액셀 다운 </button>
		  </div>
		  <div class="page"> <!--  페이징 영역 -->
				<c:if test="${pageDTO.startPage > pageDTO.pageBlock}">
					<a class="a" href="${pageContext.request.contextPath}/perf/perf?pageNum=${pageDTO.startPage - pageDTO.pageBlock}&lineCode=${perfDTO.lineCode}&prodCode=${clientDTO.prodCode}">Prev</a>
				</c:if>
				

				<c:forEach var="i" begin="${pageDTO.startPage}" end="${pageDTO.endPage}" step="1">
					<a  class="a" href="${pageContext.request.contextPath}/perf/perf?pageNum=${i}&lineCode=${perfDTO.perfCode}&prodCode=${perfDTO.prodCode}">${i}</a>
				</c:forEach>


				<c:if test="${pageDTO.endPage < pageDTO.pageCount}">
					<a class="a" href="${pageContext.request.contextPath}/perf/perf?pageNum=${pageDTO.startPage + pageDTO.pageBlock}&lineCode=${perfDTO.lineCode}&prodCode=${perfDTO.prodCode}">Next</a>
				</c:if>
				
			</div> <!--  페이징영역 -->
		 </div>
		 </div>
		 
		 	
		
		
		
		
		</div> <!--  TABLE FORM -->
		 
		 <div class="chart">
		 <h2> 생산실적 현황 </h2>
		 <div class="chartbody">
		 
		 <div class="chart1head">
		 <h2 class="labelhead"> 실적수</h2>
		 <div class="chart1">
		 <canvas id="donutChart" width="400px" height="400px"></canvas><!-- totalamount --> 
		 </div> <!--  chart1 -->
		 </div> <!-- chart1head -->
		 <div class="chart2">
		 <h2 class="labelhead"> 양품수 </h2>
		 <div class="chart2head">
		 <canvas id="donutChart2" width="600px" height="400px"></canvas> <!-- - totalfair -->
		 </div>
		 </div>
		 
		 <div class="chart3">
		 <h2 class="labelhaed"> 불량수</h2>
		 <div class="chart3haed">
		  <canvas id="donutChart3" width="400px" height="400px"></canvas> <!--  totaldefect -->
		 </div>
		</div>
		 


	
		 </div> <!--  chartbody -->
		 </div> <!--  chart -->

			
			</div> <!--  CLIENTBODY -->
			


</body>
<script> 
$(document).ready(function() {
    // addButton 클릭 이벤트 처리
    $('#addButton').click(function() {
        window.open(
            '${pageContext.request.contextPath}/perf/perfinsert',
            '_blank',
            'width=600px, height=800px, left=200px, top=100px'
        );
    });

    // 돋보기 아이콘에 대한 클릭 이벤트 리스너 추가
    document.querySelectorAll('.magnifier').forEach(function(magnifier) {
        magnifier.addEventListener('click', function() {
            console.log("에러 발생!");
            // 선택한 실적 코드 가져오기
            var perfCode = this.getAttribute('data-perfcode');
        
            // 새 창을 열고 선택한 실적 코드를 URL 파라미터로 전달
            window.open('${pageContext.request.contextPath}/perf/detail?perfCode=' + perfCode, '_blank', 'width=600px,height=400px');
        });
    });
    
    $(document).ready(function() {
   	 // lineCode2 input box 클릭 이벤트 처리
       $('#lineCode2').click(function() {
       	console.log("라인코드 클릭");
           openLinePopup(); // 라인 팝업 열기
       });

       // prodCode2 input box 클릭 이벤트 처리
       $('#prodCode2').click(function() {
       	console.log("제품코드 클릭");
           openProductPopup(); // 제품 팝업 열기
       });
       
    // prodCode2 input box 클릭 이벤트 처리
       $('#workCode2').click(function() {
       	console.log("제품코드 클릭");
           openProductPopup(); // 제품 팝업 열기
       });
       
       function openLinePopup() {
           var popupUrl = '${pageContext.request.contextPath}/search/line?input=lineCode2';
           window.open(
               popupUrl,
               '_blank',
               'width=800px, height=800px, left=900px, top=100px'
           );
       }
       
    function openProductPopup() {
    	
        var popupUrl = '${pageContext.request.contextPath}/search/product?input=prodCode2';
        window.open(
            popupUrl,
            '_blank',
            'width=800px, height=800px, left=900px, top=100px'
        );
    }
    
    function openWorkOrderPopup() {
        var popupUrl = '${pageContext.request.contextPath}/search/openworklisti?input=workCode2';
        window.open(
            popupUrl,
            '_blank',
            'width=800px, height=800px, left=900px, top=100px'
        );
    }
    
    function selectLineCode(lineCode) {
        window.opener.setLineCodeAndClosePopup(lineCode2);
    }

    function selectProdCode(prodCode) {
        window.opener.setProdCodeAndClosePopup(prodCode2);
    }
    
    });
    

    // 라인 코드 리스트
    var lineCode = ["L101", "L102", "L103"];
    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/perfajax/perfdonut",
        dataType: "json",
        contentType: "application/json", // 데이터 형식을 JSON으로 지정
        data: JSON.stringify(lineCode), // 라인 코드 리스트를 JSON 문자열로 변환하여 전송
        success: function(data) {
            console.log(data);
            console.log("데이터 받음: ", data); // 데이터를 로그에 출력

            // 파이차트 그리는 함수 호출 등으로 처리 가능
            // 도넛 차트 생성 및 표시
            var donutChartLabels = data.map(function(item) {
                return item.lineCode;
            });

            // 각 차트에 대한 라벨과 데이터 분리
            var donutChartLabels = data.map(function(item) {
                return item.lineCode;
            });

            var totalAmountData = data.map(function(item) {
                return item.totalAmount;
            });

            var totalFairData = data.map(function(item) {
                return item.totalFair;
            });

            var totalDefectData = data.map(function(item) {
                return item.totalDefect;
            });

            // 각 차트에 대한 도넛 차트 생성
            createDonutChart(totalAmountData, donutChartLabels, 'donutChart');
            createDonutChart(totalFairData, donutChartLabels, 'donutChart2');
            createDonutChart(totalDefectData, donutChartLabels, 'donutChart3');
        },
        error: function(error) {
            console.log("Error fetching data: " + error);
        }
    });
    


    // Chart.js를 사용하여 도넛 차트를 생성합니다.
    function createDonutChart(data, labels, chartId) {
        console.log("도넛 차트 데이터: ", data);
        console.log("도넛 차트 라벨: ", labels);
        console.log("도넛 차트 ID: ", chartId); // 이 줄을 추가하여 chartId 출력
          
        Chart.register(ChartDataLabels);
        var ctx = document.getElementById(chartId).getContext('2d');
        var totalValue = data.reduce((total, value) => total + value, 0);
        console.log("총합: ", totalValue.toFixed(2)); // totalValue를 로그로 출력합니다.

        var donutChart = new Chart(ctx, {
            type: 'doughnut', // 도넛 차트 유형을 설정합니다.
            data: {
                labels: labels, // 라벨 배열을 설정합니다.
                datasets: [{
                    data: data, // 차트 데이터 배열을 설정합니다.
                    backgroundColor: ['#36a2eb', '#ff6384', '#ffcd56'], // 차트 데이터에 대한 배경색을 설정합니다.
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: 120,
                chartArea: {
                    // 차트 영역 크기 조절
                    left: 50,
                    right: 50,
                    top: 50,
                    bottom: 50
                },
                animation: {
                    animateRotate: false,
                    animateScale: true
                },
                plugins: {
                    datalabels: {
                        color: 'white', // 데이터 레이블 텍스트 색상
                        font: {
                            size: 18, // 데이터 레이블 폰트 크기
                            weight: 'bold' // 데이터 레이블 폰트 굵기
                        }
                    }
                },
                tooltips: {
                    callbacks: {
                        label: function(context) {
                            var label = context.label || '';
                            if (label) {
                                label += ': ';
                            }
                            label += context.formattedValue;
                            return label;
                        }
                    },
                    position: 'top'
                },
                legend: {
                    display: true,
                    position: 'top'
                }
            }
        });
    }
      
		//엑셀
			 const excelDownload = document.querySelector('#exceldownload');
					excelDownload.addEventListener('click', exportExcel);
					function exportExcel() {
					    // 1. 워크북 생성
					    var wb = XLSX.utils.book_new();
					    // 2. 워크시트 생성
					    var newWorksheet = excelHandler.getWorksheet();
					    // 3. 워크시트를 워크북에 추가
					    XLSX.utils.book_append_sheet(wb, newWorksheet, excelHandler.getSheetName());
					    // 4. 엑셀 파일 생성
					    var wbout = XLSX.write(wb, { bookType: 'xlsx', type: 'binary' });
					    // 5. 엑셀 파일 내보내기
					    saveAs(new Blob([s2ab(wbout)], { type: 'application/octet-stream' }), excelHandler.getExcelFileName());
					}

					// 현재 날짜를 가져오는 함수
					function getToday() {
						
					    var date = new Date();
					    var year = date.getFullYear();
					    var month = (date.getMonth() + 1).toString().padStart(2, '0'); // 월은 0부터 시작하므로 1을 더하고 두 자리로 맞춥니다.
					    var day = date.getDate().toString().padStart(2, '0'); // 일을 두 자리로 맞춥니다.
					    return year + month + day;
					}

			var excelHandler = {
			getExcelFileName : function() {
				return 'PerformanceList'+getToday()+'.xlsx'; //파일명
			},
			getSheetName : function() {
				return 'Performance Sheet'; //시트명
			},
			getExcelData : function() {
				return document.getElementById('ct'); //table id
			},
			getWorksheet : function() {
				return XLSX.utils.table_to_sheet(this.getExcelData());
			}
		} //excelHandler
			
			function s2ab(s) {
				
				var buf = new ArrayBuffer(s.length);  // s -> arrayBuffer
				var view = new Uint8Array(buf);  
				for(var i=0; i<s.length; i++) {
					view[i] = s.charCodeAt(i) & 0xFF;
				}
				alert("이까지 옴");
				return buf;
			}
	
    
    
   /*  $(function() {
        $("#workdate1").datepicker({
            dateFormat: 'yy-mm-dd',
            prevText: '이전 달',
            nextText: '다음 달',
            monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
            monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
            dayNames: ['일','월','화','수','목','금','토'],
            dayNamesShort: ['일','월','화','수','목','금','토'],
            dayNamesMin: ['일','월','화','수','목','금','토'],
            showMonthAfterYear: true,
            yearSuffix: '년',

            // 여기에 데이트피커에서 날짜를 선택했을 때 실행할 코드 작성
            onSelect: function(selectedDate) {
                console.log("선택한 날짜: " + selectedDate);
            }
     
    }); // datekpicker1 끝
          
          
          $(function() {
              $("#workdate2").datepicker({
                  dateFormat: 'yy-mm-dd',
                  prevText: '이전 달',
                  nextText: '다음 달',
                  monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                  monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                  dayNames: ['일','월','화','수','목','금','토'],
                  dayNamesShort: ['일','월','화','수','목','금','토'],
                  dayNamesMin: ['일','월','화','수','목','금','토'],
                  showMonthAfterYear: true,
                  yearSuffix: '년',

                  // 데이트피커의 onSelect 이벤트 핸들러 설정
                  onSelect: function(selectedDate) {
                      // 여기에 데이트피커에서 날짜를 선택했을 때 실행할 코드 작성
                      console.log("선택한 날짜: " + selectedDate);
                  }
              });
          }); // datepicker2 끝  */
   
   
});
</script>	
			
</html>