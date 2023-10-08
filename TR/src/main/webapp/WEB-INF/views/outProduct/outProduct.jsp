<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath }/resources/css/side.css"
	rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<title>Insert title here</title>

<style type="text/css">
body {
	background-color: #F5F6FA;
}

hr {
	background: #adb5bb;
	width: 1570px;
	height: 2px;
	border: 0;
	position: relative;
	transform-origin: 0 0;
	transform: rotate(0deg) scale(1, -1);
}

h2 {
	font-size: 30px;
	font-weight: bold;
	padding-left: 1%;
}

label {
	font: 500 18px/18px "Inter", sans-serif;
}

input[type="text"] {
	border: 1px solid #adb5bb;
	border-radius: 5px;
	width: 300px;
	height: 40px;
	font: 500 18px/18px "Inter", sans-serif;
	padding-left: 10px;
}
input[type="button"]{
background-color:rgba(94.0000019967556, 195.0000035762787, 151.00000619888306, 1);
	width:100px;
	height:40px;
	border-radius:5px;
	color: #FFFFFF;
	border: 0;
	text-align: center;
	font: 500 20px/20px "Inter", sans-serif;
}

#outProductList {
	overflow-x: auto; /* 가로 스크롤바를 활성화 */ 
	width:98%;
	margin : 0 auto;
}
table {
 	border: 1px solid rgba(221, 221, 221, 0.78); 
	margin : 0 auto;
  	color: #000000; 
  	max-width:1570px;
  	font: 500 18px/18px "Inter", sans-serif;
  	text-align: center;
  	
}
table th, table td {
	min-width: 100px;
    white-space: nowrap; /* 텍스트 줄 바꿈 방지 */
    padding: 0 15px;
}

table thead tr {
  	background-color:rgba(217.0000022649765, 217.0000022649765, 217.0000022649765, 1);
	width:1570px;
	height:45px;
	font: 500 20px/20px "Inter", sans-serif;
}
table td {
	height: 45px;
}

#con {
	display: flex;
	flex-direction: column;
}

#searchForm {
	display: flex;
	align-items: center;
	padding-left: 1%;
	gap: 1%;
	height: 40px;
	margin: 25px 0;
}

#buttons {
	margin-top: 15px;
	margin-bottom: 5px;
	padding-left: 1%;
	gap: 1%;
}

table tbody tr:nth-child(even) {
    background-color: #f2f2f2; /* 짝수 행의 백그라운드 색상 설정 */
}

table tbody tr:nth-child(odd) {
    background-color: #ffffff; /* 홀수 행의 백그라운드 색상 설정 */
}


</style>
</head>
<body>
	<!-- 사이드바 -->
	<jsp:include page="../inc/side.jsp"></jsp:include>
	<!-- 사이드바 -->
	<div id="con">
		<h2>출고 현황</h2>
		<hr>
		<form
			action="${pageContext.request.contextPath }/outProduct/listSearch"
			method="post">
			<div id="searchForm">
				<label>출고 번호</label><input type="text" name="" placeholder="출고 번호를 입력하세요">
				<label>제품명</label><input type="text" name="" placeholder="제품명을 입력하세요">
				<label>거래처명</label><input type="text" name="" placeholder="거래처명을 입력하세요"> 
				<input type="button" value="검색">
			</div>
		</form>
		<hr>
		<div id="buttons">
			<button id="allButton">전체</button>
    		<button id="미출고Button">미출고</button>
    		<button id="출고완료Button">출고완료</button>
		</div>
		<h3 style="padding-left:1%;">출고 목록 <small>총 3건</small></h3>
		<div id="outProductList">
			<table>
				<thead>
					<tr>
						<th>출고번호</th>
						<th>수주번호</th>
						<th>거래처명</th>
						<th>거래처코드</th>
						<th>제품코드</th>
						<th>제품이름</th>
						<th>주문수량</th>
						<th>재고수량</th>
						<th>납품가</th>
						<th>납품예정일</th>
						<th>출고날짜</th>
						<th>담당자</th>
						<th>출고여부</th>
						<th>출고처리</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
	</div>
	<script type="text/javascript">
// 		let currentStatus = '전체'; // 기본값은 전체
	
// 		// 미출고 버튼 클릭 시
// 		$('#미출고Button').click(function() {
// 		    // 현재 선택된 출고 상태 업데이트
// 		    currentStatus = '미출고';
	
// 		    // AJAX 요청 시작
// 		    makeAjaxRequest(currentStatus);
// 		});
	
// 		// 출고완료 버튼 클릭 시
// 		$('#출고완료Button').click(function() {
// 		    // 현재 선택된 출고 상태 업데이트
// 		    currentStatus = '출고완료';
	
// 		    // AJAX 요청 시작
// 		    makeAjaxRequest(currentStatus);
// 		});
	
// 		// 전체 버튼 클릭 시
// 		$('#allButton').click(function() {
// 		    // 현재 선택된 출고 상태 업데이트
// 		    currentStatus = '전체';
	
// 		    // AJAX 요청 시작
// 		    makeAjaxRequest(currentStatus);
// 		});
	
// 		// AJAX 요청을 만드는 함수
// 		function makeAjaxRequest(status) {
// 		    // 현재 실행 중인 AJAX 요청 취소
// 		    if (currentAjaxRequest) {
// 		        currentAjaxRequest.abort();
// 		    }
	
// 		    // AJAX 요청 시작
// 		    currentAjaxRequest = $.ajax({
// 		        url: '/출고_요청_URL', // 적절한 URL로 변경
// 		        method: 'GET',
// 		        data: { status: status }, // 출고 상태 전달
// 		        success: function(data) {
// 		            // 성공적으로 데이터를 받아왔을 때 처리
// 		            $('#출고리스트').html(data);
// 		        },
// 		        error: function(xhr, status, error) {
// 		            // 오류 처리
// 		            console.error(error);
// 		        }
// 		    });
// 		}
		
// 		// 초기 AJAX 요청 시작 (4초마다 반복)
// 		function initialRequest() {
// 		    makeAjaxRequest(currentStatus); // 현재 상태에 따른 AJAX 요청

// 		    // 4초 후에 다시 요청
// 		    setTimeout(initialRequest, 4000);
// 		}

// 		// 페이지 로드 후 초기 AJAX 요청 시작
// 		initialRequest();
	</script>
</body>
</html>