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
				<div class="flex-container">
					<h3 class="chartTitleTab1 current" onclick="showTab1('stockList')">창고별 재고</h3>
					<h3 class="chartTitleTab1 " onclick="showTab2('prodRawList')">유형별 재고</h3>
				</div>
				<div>
					<canvas id="stockList" class="chartTab1 current"></canvas>
					<canvas id="prodRawList" class="chartTab1 "></canvas>
				</div>
			</div>
			<div id="chart_3">
			   <div class="flex-container">
			       <h3 class="chartTitleTab2 current" onclick="showTab3('perfList')">최근 생산실적</h3>
			       <h3 class="chartTitleTab2" onclick="showTab4('linePerfList')">라인별 생산실적</h3>
			   </div>
			   <div>
			       <canvas id="perfList" class="chartTab2 current"></canvas>
			       <canvas id="linePerfList" class="chartTab2"></canvas>
			   </div>
			</div>
		</div>


	</div>

	<script type="text/javascript">
		$(document).ready(function() {
			
			var stockChartInterval; // (창고별 재고) 변수를 선언하여 setInterval 핸들러를 저장할 준비를 합니다.
			var prodRawChartInterval; // (유형별 재고) 변수를 선언하여 setInterval 핸들러를 저장할 준비를 합니다. 이거 필요가없음 수정
			var perfChartInterval;	// (최근 생산실적) 변수를 선언하여 setInterval 핸들러를 저장할 준비를 합니다.
			var linePerfChartInterval;	// (라인별 생산실적) 변수를 선언하여 setInterval 핸들러를 저장할 준비를 합니다.
			
			
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
	        stockChartInterval = loadStockChart();

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
	        perfChartInterval = setInterval(loadPerfChart, 4000);
	        
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
		});
		
		
		
		var stockChartInterval; // (창고별 재고) 변수를 선언하여 setInterval 핸들러를 저장할 준비를 합니다.
		var prodRawChartInterval; // (유형별 재고) 변수를 선언하여 setInterval 핸들러를 저장할 준비를 합니다.
		var perfChartInterval;	// (최근 생산실적) 변수를 선언하여 setInterval 핸들러를 저장할 준비를 합니다.
		var linePerfChartInterval;	// (라인별 생산실적) 변수를 선언하여 setInterval 핸들러를 저장할 준비를 합니다.
		// 창고별 재고 
		function startStockChartInterval() {
		    stockChartInterval = setInterval(loadStockChart, 4000);
		}

		function stopStockChartInterval() {
		    clearInterval(stockChartInterval);
		}
		
		function showTab1(tabName) {
			stopStockChartInterval();
			
		    // 숨길 모든 탭을 숨깁니다.
		    var tabs = document.getElementsByClassName('chartTab1');
		    for (var i = 0; i < tabs.length; i++) {
		        tabs[i].style.display = 'none';
		    }

		    // 모든 탭의 associated h3 요소에서 'current' 클래스를 제거합니다.
		    var h3Elements = document.getElementsByClassName('chartTitleTab1');
		    for (var j = 0; j < h3Elements.length; j++) {
		        h3Elements[j].classList.remove('current');
		    }

		    // 선택한 탭을 표시합니다.
		    var selectedTab = document.getElementById(tabName);
		    selectedTab.style.display = 'block';

		    // 선택한 탭에 해당하는 associated h3 요소에 'current' 클래스를 추가합니다.
		    var associatedH3 = document.querySelector('[onclick="showTab1(\'' + tabName + '\')"]');
		    associatedH3.classList.add('current');
		    
		    startStockChartInterval();
		    
		    
		}
		
		// 유형별 재고
// 		function startProdRawChartInterval() {
// 			prodRawChartInterval = setInterval(loadStockChart, 4000);
// 		}

// 		function stopProdRawChartInterval() {
// 		    clearInterval(prodRawChartInterval);
// 		}
		
// 		function showTab2(tabName) {
// 			startProdRawChartInterval();
			
// 		    // 숨길 모든 탭을 숨깁니다.
// 		    var tabs = document.getElementsByClassName('chartTab1');
// 		    for (var i = 0; i < tabs.length; i++) {
// 		        tabs[i].style.display = 'none';
// 		    }

// 		    // 모든 탭의 associated h3 요소에서 'current' 클래스를 제거합니다.
// 		    var h3Elements = document.getElementsByClassName('chartTitleTab1');
// 		    for (var j = 0; j < h3Elements.length; j++) {
// 		        h3Elements[j].classList.remove('current');
// 		    }

// 		    // 선택한 탭을 표시합니다.
// 		    var selectedTab = document.getElementById(tabName);
// 		    selectedTab.style.display = 'block';

// 		    // 선택한 탭에 해당하는 associated h3 요소에 'current' 클래스를 추가합니다.
// 		    var associatedH3 = document.querySelector('[onclick="showTab2(\'' + tabName + '\')"]');
// 		    associatedH3.classList.add('current');
		    
// 		    stopProdRawChartInterval();
// 		}
	
		// 최근 생산실적 
		function startPerfChartInterval() {
			perfChartInterval = setInterval(loadPerfChart, 4000);
		}

		function stopPerfChartInterval() {
		    clearInterval(perfChartInterval);
		}
		
		function showTab3(tabName) {
			startPerfChartInterval();
			
		    // 숨길 모든 탭을 숨깁니다.
		    var tabs = document.getElementsByClassName('chartTab2');
		    for (var i = 0; i < tabs.length; i++) {
		        tabs[i].style.display = 'none';
		    }

		    // 모든 탭의 associated h3 요소에서 'current' 클래스를 제거합니다.
		    var h3Elements = document.getElementsByClassName('chartTitleTab2');
		    for (var j = 0; j < h3Elements.length; j++) {
		        h3Elements[j].classList.remove('current');
		    }

		    // 선택한 탭을 표시합니다.
		    var selectedTab = document.getElementById(tabName);
		    selectedTab.style.display = 'block';

		    // 선택한 탭에 해당하는 associated h3 요소에 'current' 클래스를 추가합니다.
		    var associatedH3 = document.querySelector('[onclick="showTab3(\'' + tabName + '\')"]');
		    associatedH3.classList.add('current');
		    
		    startPerfChartInterval();
		}
		
		// 라인별 생산실적
// 		function startLinePerfChartInterval() {
// 			linePerfChartInterval = setInterval(loadStockChart, 4000);
// 		}

// 		function stopLinePerfChartInterval() {
// 		    clearInterval(linePerfChartInterval);
// 		}
// 		function showTab4(tabName) {
// 			startLinePerfChartInterval();
			
// 		    // 숨길 모든 탭을 숨깁니다.
// 		    var tabs = document.getElementsByClassName('chartTab2');
// 		    for (var i = 0; i < tabs.length; i++) {
// 		        tabs[i].style.display = 'none';
// 		    }

// 		    // 모든 탭의 associated h3 요소에서 'current' 클래스를 제거합니다.
// 		    var h3Elements = document.getElementsByClassName('chartTitleTab2');
// 		    for (var j = 0; j < h3Elements.length; j++) {
// 		        h3Elements[j].classList.remove('current');
// 		    }

// 		    // 선택한 탭을 표시합니다.
// 		    var selectedTab = document.getElementById(tabName);
// 		    selectedTab.style.display = 'block';

// 		    // 선택한 탭에 해당하는 associated h3 요소에 'current' 클래스를 추가합니다.
// 		    var associatedH3 = document.querySelector('[onclick="showTab4(\'' + tabName + '\')"]');
// 		    associatedH3.classList.add('current');
		    
// 		    stopLinePerfChartInterval();
// 		}
	</script>

</body>
</html>
