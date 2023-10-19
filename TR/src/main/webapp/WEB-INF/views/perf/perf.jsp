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
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-labels"></script>
	<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/perf.css">

	
	<link href="${pageContext.request.contextPath }/resources/css/side.css"
	rel="stylesheet" type="text/css">

	<script src="https://kit.fontawesome.com/25ef23e806.js"
	crossorigin="anonymous"></script>
	
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	 <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/datepicker.css"> 
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

	
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
 실적일: <input type="text" id="workdate1" name="perfDate1" class="form-control" placeholder="날짜 선택" readonly> ~ <input type="text" id="workdate2" name="perfDate2" class="form-control" placeholder="날짜 선택" readonly>
</div> -->



</div> <!--  perfcd -->
<hr> <!--  경계선 -->
	

	
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
    
    Chart.plugins.register({
        afterDatasetsDraw: function(chart) {
            var ctx = chart.ctx;
            var totalValue = chart.data.datasets[0].data.reduce((total, value) => total + value, 0); // 데이터 총합 계산

            chart.data.datasets.forEach(function(dataset, datasetIndex) {
                var meta = chart.getDatasetMeta(datasetIndex);
                if (!meta.hidden) {
                    meta.data.forEach(function(element, index) {
                        // 데이터 레이블의 텍스트 가져오기
                        var dataLabel = dataset.data[index].toString();

                        // 데이터 레이블의 좌표 가져오기
                        var model = element._model;
                        var x = model.x;
                        var y = model.y;

                        // 데이터 레이블의 스타일 설정
                        ctx.fillStyle = 'black'; // 텍스트 색상
                        ctx.font = 'bold 15px Arial'; // 폰트 스타일 및 크기
                        ctx.textAlign = 'center';
                        ctx.textBaseline = 'middle';

                        // 데이터 레이블 그리기
                        ctx.fillText(dataLabel, x, y);

                        // 테두리 그리기 (borderWidth 설정)
                        ctx.lineWidth = 10;
                        ctx.strokeStyle = 'black';
                        ctx.strokeRect(x - model.innerRadius, y, model.innerRadius * 2, model.innerRadius * 2);
                    });
                }
            });

            // 차트 중앙 좌표 가져오기
            var centerX = (chart.chartArea.left + chart.chartArea.right) / 2;
            var centerY = (chart.chartArea.top + chart.chartArea.bottom) / 2;

            // 데이터 레이블의 스타일 설정 (total 밸류값 출력)
            ctx.fillStyle = 'black'; // 텍스트 색상
            ctx.font = 'bold 15px Arial'; // 폰트 스타일 및 크기
            ctx.textAlign = 'center';
            ctx.textBaseline = 'middle';

            // 데이터 레이블 그리기 (total 밸류값 출력)
            ctx.fillText(totalValue.toFixed(2), centerX, centerY);
        }
    });
    
});
</script>	
			
</html>