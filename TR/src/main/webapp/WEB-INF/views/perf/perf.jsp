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
	
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
	
	<style>
	
#pie_chart1, #pie_chart2, #pie_chart3 {
 width: 500px;

}

.chartbody {
display:flex;
}
	
	
	</style>
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


<div class="perfcd1">
 실적일: <input type="text" id="workdate1" name="workdate1" class="form-control" placeholder="날짜 선택" readonly> ~ <input type="text" id="workdate2" name="workdate2	" class="form-control" placeholder="날짜 선택" readonly>
</div>

<div class="perfcd1">
 작업지시코드: <input type="text" id="workCode" name="workCode" class="cdbox" placeholder="작업지시코드" readonly>
</div>


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
		 
		 <div class="paging">
		       <input type="button" value="1" style="float:right">
		 
		 </div>
		
		
		
		</div> <!--  TABLE FORM -->
		 
		 <div class="chart">
		 <h2> 생산실적 현황 </h2>
		 <div class="chartbody">
		 <div id="pie_chart1">
		 <canvas id="pie-chart" width="500" height="450"></canvas>
		 </div>
		 <div id="pie_chart2">
		 <canvas id="pie-chart2" width="500" height="450"></canvas>
		 </div>
		 <div id="pie_chart3">
		 <canvas id="pie-chart3" width="500" height="450"></canvas>
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
            'width=1200px, height=800px, left=500px, top=100px'
        );
    });
    
    
       
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
}); // 돋보기 자세히 보기 끝 @@@@@@@@@@@@@@@@@@@@@@@@@@



new Chart(document.getElementById("pie-chart"), {
    type: 'pie',
    data: {
        labels: ["실적수", "양품수", "불량수" ],
        datasets: [{
          label: "Population (millions)",
          backgroundColor: ["#3e95cd","#3cba9f","#e8c3b9" ],
          data: [5267,2478,734,]
      }]
    },
    options: {
      title: {
        display: true,
        text: '1-1 라인 생산량'
      }
    }
});

new Chart(document.getElementById("pie-chart2"), {
    type: 'pie',
    data: {
      labels: ["실적수", "양품수", "불량수" ],
      datasets: [{
        label: "Population (millions)",
        backgroundColor: ["#3e95cd","#3cba9f","#e8c3b9" ],
        data: [5267,2478,734,]
      }]
    },
    options: {
      title: {
        display: true,
        text: '1-2라인 생산량'
      }
    }
});

new Chart(document.getElementById("pie-chart3"), {
    type: 'pie',
    data: {
      labels: ["실적수", "양품수", "불량수" ],
      datasets: [{
        label: "Population (millions)",
        backgroundColor: ["#3e95cd","#3cba9f","#e8c3b9" ],
        data: [5267,2478,734,]
      }]
    },
    options: {
      title: {
        display: true,
        text: '1-3라인 생산량'
      }
    }
});


//페이지가 처음 로드된 후, 4초마다 업데이트를 요청하는 함수를 호출
setInterval(loadSalesChart, 4000);

loadSalesChartForLineCode(101);

function loadSalesChart() {
    $.ajax({
        url: '${pageContext.request.contextPath}/main/perflist',
        type: 'POST',
        data: { lineCode: lineCode },
        dataType: 'json',
        success: function(result) {
            if (!jsonObjectsAreEqual(result, sales_compare)) {
                // 데이터가 변경된 경우에만 차트를 그립니다.
                // 이전 데이터 업데이트
                sales_compare = result; // 데이터 배열을 복사하여 참조 문제 해결
                createPieChart(result, "pie_chart");
            }
        }
    });
}




</script>			
			
</html>