<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/perf.css">

	
	<link href="${pageContext.request.contextPath }/resources/css/side.css"
	rel="stylesheet" type="text/css">

	<script src="https://kit.fontawesome.com/25ef23e806.js"
	crossorigin="anonymous"></script>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	 <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/datepicker.css"> 
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	
</head>
<body>
<jsp:include page="../inc/side.jsp"></jsp:include>

<!--  여기서부터 시작  -->
<div class="clientBody">
		<h1 class="toptitle">생산실적 관리</h1>

<hr>
<div class="perfcd">
<div class="perfcd1">
라인코드: <input type="text" id="lineCode" name="lineCode" onclick="" class="cdbox" readonly>
</div>

<div class="perfcd1">
제품코드: <input type="text" id="prodCode" name="prodCode" onclick="" placeholder="제품코드" class="cdbox" onclick="" readonly>
</div>


<!-- <div class="perfcd1">
 실적일: <input type="text" id="workdate1" name="perfDate1" class="form-control" placeholder="날짜 선택" readonly> ~ <input type="text" id="workdate2" name="perfDate2	" class="form-control" placeholder="날짜 선택" readonly>
</div> -->



</div> <!--  perfcd -->
<hr> <!--  경계선 -->
	

	
<!--  본문 내용  -->
	<div class="clientbody1">
	<div class="tableform"> 
			<div class="clienttotal">
			 <h2> 생산실적: 총 x 건 </h2>
			
			<div style="float: right;">
				<input type="button" value="추가" id="addButton" class="addbutton"
					onclick="perfInsert()">
			</div>	 <!-- 검색칸 -->	
			</div>   <!--  생산실적 총:x건 라인-->

		 <table class="ct" id="ct">	
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
						<td class="cttg">${perfDTO.workCode}</td>
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
		
		
		<div class="exceldown">
		 <input type="button" id="entrytable" class="entrytable" value="전체테이블">
		  <input type="button" id="exceldown" class="exceldown" value="액셀다운">
		 </div>
		 
		 	<div class="page"> <!--  페이징 영역 -->
				<c:if test="${pageDTO.startPage > pageDTO.pageBlock}">
					<a href="${pageContext.request.contextPath}/perf/perf?pageNum=${pageDTO.startPage - pageDTO.pageBlock}&lineCode=${perfDTO.lineCode}&prodCode=${clientDTO.prodCode}">Prev</a>
				</c:if>
				

				<c:forEach var="i" begin="${pageDTO.startPage}" end="${pageDTO.endPage}" step="1">
					<a href="${pageContext.request.contextPath}/perf/perf?pageNum=${i}&lineCode=${perfDTO.perfCode}&prodCode=${perfDTO.prodCode}">${i}</a>
				</c:forEach>


				<c:if test="${pageDTO.endPage < pageDTO.pageCount}">
					<a href="${pageContext.request.contextPath}/perf/perf?pageNum=${pageDTO.startPage + pageDTO.pageBlock}&lineCode=${perfDTO.lineCode}&prodCode=${perfDTO.prodCode}">Next</a>
				</c:if>
				
			</div> <!--  페이징영역 -->
		
		
		
		
		</div> <!--  TABLE FORM -->
		 
		 <div class="chart">
		 <h2> 생산실적 현황 </h2>
		 <div class="chartbody">
		 <canvas id="donutChart" width="400px" height="400px"></canvas>
		 
		 
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
            'width=1200px, height=800px, left=500px, top=100px'
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
              // 파이차트 그리는 함수 호출 등으로 처리 가능
           // 도넛 차트 생성 및 표시
              createDonutChart(data);
          },
          error: function(error) {
              console.log("Error fetching data: " + error);
          }
      });
      
      function createDonutChart(data) {
    	    // 도넛 차트를 그릴 때 사용할 데이터 배열과 라벨 배열을 초기화합니다.
    	    var chartData = [];
    	    var labels = [];

    	    // data 객체에서 필요한 데이터를 추출하여 배열에 추가합니다.
    	    data.forEach(function(item) {
    	        // 각 라인 코드에 대한 데이터를 추출하여 배열에 추가합니다.
    	        chartData.push(item.totalAmount);  // 실적 수량 데이터를 사용하려면 item.totalAmount를 수정하세요.
    	        labels.push(item.lineCode);
    	    });

    	    // Chart.js를 사용하여 도넛 차트를 생성합니다.
    	    var ctx = document.getElementById('donutChart').getContext('2d');
    	    var donutChart = new Chart(ctx, {
    	        type: 'doughnut', // 도넛 차트 유형을 설정합니다.
    	        data: {
    	            labels: labels, // 라벨 배열을 설정합니다.
    	            datasets: [{
    	                data: chartData, // 차트 데이터 배열을 설정합니다.
    	                backgroundColor: ['red', 'green', 'blue'], // 차트 데이터에 대한 배경색을 설정합니다.
    	                borderWidth: 1 // 차트 데이터에 대한 테두리 두께를 설정합니다.
    	            }]
    	        },
    	        options: {
    	            responsive: true,
    	            maintainAspectRatio: false
    	        }
    	    });
    	}
});
</script>			
			
</html>