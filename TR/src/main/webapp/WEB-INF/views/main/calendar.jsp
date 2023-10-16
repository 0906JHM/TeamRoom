<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- fullcalendar css -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<!-- fullcalendar 언어 설정관련 script -->
<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>
<!-- Chart.js Core -->
<script
	src="https://cdn.jsdelivr.net/npm/chart.js@3.8.0/dist/chart.min.js"></script>
<!-- Chart.js Datalabels 플러그인 -->
<script
	src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>

<!-- 캘린더, 차트 자바스크립트 -->
<script src="${pageContext.request.contextPath }/resources/js/calendar.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/side.css"
	rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/calendar.css"
	rel="stylesheet" type="text/css">

<!-- SweetAlert  -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<title>Roomair</title>

</head>
<body>
	<!-- 사이드바 -->
	<jsp:include page="../inc/side.jsp"></jsp:include>
	<!-- 사이드바 -->

	<div id="con">
		<div id="con_1">
			<div id='calendar'></div>

			<div id="chart_1">
				<h3>거래처별 매출 비율</h3>
				<div id="pie_chart_size">
					<canvas id="pie_chart" width="70%"></canvas>
				</div>
			</div>
		</div>
		<div id="con_2">
			<div id="chart_2">
				<h3>창고별 재고</h3>
				<canvas id="stockList"></canvas>
			</div>
			<div id="chart_2">
				<h3>라인별 생산량</h3>
			       <canvas id="linePerfList"></canvas>
			</div>
			<div  id="chart_2">
				<h3>최근 생산량</h3>
		    	<canvas id="perfList"></canvas>
			</div>
		</div>


	</div>

	<script type="text/javascript">
		$(document).ready(function() {
			
			
			
			var calendar_compare = null; // 달력 비교 함수 
			var sales_compare = null; // 매출 차트와 비교할 변수
			var stock_compare = null; // 재고 차트와 비교할 변수
			var perf_compare = null; // 실적 차트와 비교할 변수
			var line_compare = null; // 라인 실적 차트와 비교할 변수
			
			var currentDate = new Date(); // 초기 currentDate 설정
			
			document.addEventListener('click', function(event) {
			    // 이벤트가 발생한 요소가 .fc-prev-button 클래스를 가지고 있는지 확인합니다.
			    if (event.target.classList.contains('fc-prev-button') || event.target.classList.contains('fc-icon-chevron-left')) {
			        currentDate.setMonth(currentDate.getMonth() - 1); // 이전 달로 이동
			        console.log(currentDate);
			    }
			    if (event.target.classList.contains('fc-next-button') || event.target.classList.contains('fc-icon-chevron-right')) {
			    	currentDate.setMonth(currentDate.getMonth() + 1); // 다음 달로 이동
			        console.log(currentDate);
			    }
			    if (event.target.classList.contains('fc-today-button')) {
			    	currentDate = new Date(); // 현재 날짜로 설정
			        console.log(currentDate);
			    }
			});
			
			
			// 캘린더정보 처음 로드될 때 데이터를 가져옴
			loadCalendar();
			
			// 4초마다 실행될 데이터를 가져오는 함수
			setInterval(loadCalendar, 4000);
			
			function loadCalendar() {
				$.ajax({
					url : '${pageContext.request.contextPath}/main/calendarList',
					type : 'POST',
					dataType : 'json',
					success : function(result) {
						if(!jsonObjectsAreEqual(result, calendar_compare)){
							
							calendar_compare = result;
							
							initializeCalendar(result, currentDate);
						}
					}
				});
			}
			
			
			// 매출 차트 초기 로드
	        loadSalesChart();

	        // 페이지가 처음 로드된 후, 4초마다 업데이트를 요청하는 함수를 호출
	        setInterval(loadSalesChart, 4000);

	        function loadSalesChart() {
	            $.ajax({
	                url: '${pageContext.request.contextPath}/main/salesList',
	                type: 'POST',
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
	        
	        // 재고 차트 초기 로드
	        loadStockChart();

	        // 페이지가 처음 로드된 후, 4초마다 업데이트를 요청하는 함수를 호출
	        setInterval(loadStockChart, 4000);
	        
	        function loadStockChart() {
	            $.ajax({
	                url: '${pageContext.request.contextPath}/main/stockList',
	                type: 'POST',
	                dataType: 'json',
	                success: function(result) {
	                    if (!jsonObjectsAreEqual(result, stock_compare)) {
	                        // 데이터가 변경된 경우에만 차트를 그립니다.
	                        // 이전 데이터 업데이트
	                        stock_compare = result; // 데이터 배열을 복사하여 참조 문제 해결
	                        createBarChart(result, "stockList");
	                    }
	                }
	            });
	        }
	        
	        // 실적 차트 초기 로드
	        loadPerfChart();

	        // 페이지가 처음 로드된 후, 4초마다 업데이트를 요청하는 함수를 호출
	        setInterval(loadPerfChart, 4000);
	        
	        function loadPerfChart() {
	            $.ajax({
	                url: '${pageContext.request.contextPath}/main/perfList',
	                type: 'POST',
	                dataType: 'json',
	                success: function(result) {
	                    if (!jsonObjectsAreEqual(result, perf_compare)) {
	                        // 데이터가 변경된 경우에만 차트를 그립니다.
	                        // 이전 데이터 업데이트
	                        perf_compare = result; // 데이터 배열을 복사하여 참조 문제 해결
	                        createBarChart(result, "perfList");
	                    }
	                }
	            });
	        }
	        
	        // 라인별 실적 차트 초기 로드
	        loadLinePerfChart();

	        // 페이지가 처음 로드된 후, 4초마다 업데이트를 요청하는 함수를 호출
	        setInterval(loadLinePerfChart, 4000);
	        
	        function loadLinePerfChart() {
	            $.ajax({
	                url: '${pageContext.request.contextPath}/main/linePerfList',
	                type: 'POST',
	                dataType: 'json',
	                success: function(result) {
	                    if (!jsonObjectsAreEqual(result, line_compare)) {
	                        // 데이터가 변경된 경우에만 차트를 그립니다.
	                        // 이전 데이터 업데이트
	                        line_compare = result; // 데이터 배열을 복사하여 참조 문제 해결
	                        createBarChart(result, "linePerfList");
	                    }
	                }
	            });
	        }
	        
		});
		
		
	</script>

</body>
</html>
