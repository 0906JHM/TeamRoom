<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/datepicker.css"> 
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>
.perfcd{
display : block;

}

.perfcd1{
margin-bottom: 10px;
font-size:16px;


}

.ct{
border-collapse: collapse;
	border-spacing: 0;
}

.cdbox{
width:200px;
height:15px;
font-size:15px;
}

.cthead{
	
	background-color:rgba(217.0000022649765, 217.0000022649765, 217.0000022649765, 1);
	width:800px;
	height:45px;
}

.cthead th{
	border-color: black;
	border-style: solid;
	border-width: 1px;
	font-family: Arial, sans-serif;
	font-size: 14px;
	overflow: hidden;
	padding: 10px 5px;
	word-break: normal;
	width:800px;

}

.ctcontents{
background-color:#ffffff;
	width:800px;
	height:45px;
	
}

.ctcontents td{
border-color: black;
	border-style: solid;
	border-width: 1px;
	font-family: Arial, sans-serif;
	font-size: 14px;
	font-weight: normal;
	overflow: hidden;
	padding: 10px 5px;
	word-break: normal;
	border-color: inherit;	
	text-align: left;
	vertical-align: top;
	text-align: center;

}

.footerbtn{

text-align: center;
margin: 20px;

}

.btn{

background-color: rgba(94.0000019967556, 195.0000035762787, 151.00000619888306, 1);
    width: 100px;
    height: 40px;
    border-radius: 5px;
    color: #FFFFFF;
    border: 0;
    text-align: center;
    font: 100 24px/24px "Inter", sans-serif;
    margin: 0 auto;

}

.workCode{

width: 10px;

}


</style>
</head>
<body>
<div class="perfdetail">
<h1 class="perfinserthaed"> 생산실적 추가</h1>
<hr>
<div class="perfcd">

<div class="perfcd1">
라인코드: <input type="text" id="lineCode2" name="lineCode2" onclick="" class="cdbox">
</div>

<div class="perfcd1">
제품코드: <input type="text" id="prodCode2" name="prodCode2" onclick="" placeholder="제품코드" class="cdbox" onclick="">
</div>

<div class="perfcd1">
 지시일자: <input type="text" id="workdate1" name="workdate1" class="form-control" placeholder="날짜 선택" readonly> ~ <input type="text" id="workdate2" name="workdate2	" class="form-control" placeholder="날짜 선택" readonly>
</div>

</div> <!--  perfcd -->
<hr> <!--  경계선 -->
<form action="${pageContext.request.contextPath}/perf/perfinsertPro">
 	<table class="ct" id="ct">	
			<thead>
				<tr class="cthead">
				    <th>생산실적코드</th>
					<th>작업지시코드</th><!-- worklist에서 받아옴 -->
					<th>제품코드</th><!-- worklist에서 받아옴 -->
					<th >실적일</th>
					<th> 담당자 </th>
					<th >실적수량</th><!-- worklist에서 받아옴 -->
					<th >양품수</th><!-- worklist에서 받아옴 -->
					<th >불량수</th>
					<th >불량사유</th>
					<th>불량사유(기타)</th>
					<th >비고</th>
					<th >현황</th> <!-- worklist에서 받아옴 -->
				</tr>
			</thead> 
			<tbody>
					<tr class="ctcontents">
					    <td ><input type="text" id="perfCode" name="perfCode"></td> <!--  생산실적코드 -->
						<td ><input type="text" id="workCode" name="workCode"></td> <!--  작업지시코드 -->
						<td ><input type="text" id="prodCode" name="prodCode"></td> <!--  제품코드 -->
						<td ><input type="text" id="perfDate" name="perfDate"></td> <!-- 실적일자(자동생성) -->
						<td ><input type="text" id="perfEmpId" name="perfEmpId"></td> <!--  담당자아이디 -->
				        <td ><input type="text" id="perfAmount" name="perfAmount"></td> <!-- 실적수량 -->
						<td ><input type="text" id="perfFair" name="perfFair"></td> <!-- 양품수-->
						<td ><input type="text" id="perfDefect" name="perfDefect"></td> <!-- 불량수 -->
						<td ><input type="text" id="perfDefectreason" name="perfDefectreason"></td>  <!-- 불량사유 -->
						<td ><input type="text" id="perfDefectmemo" name="perfDefectmemo"></td>  <!-- 불량사유 -->
						<td ><input type="text" id="perfMemo" name="perfMemo"></td> <!-- 비고 -->
						<td ><input type="text" id="lineProcess" name="lineProcess"></td> <!-- 라인상테 -->
					</tr>
			</tbody> 
			</table>
			
			<div class="footerbtn">
			<input type="submit" id="btn" class="btn" value="등록">
			<input type="button" id="btn" class="btn" value="닫기">
			</div>
</form>
</div>

  <script>
  var currentDate = new Date();
  var currentYear = currentDate.getFullYear();
  var currentMonth = currentDate.getMonth();
  var currentDateVal = currentDate.getDate();

  $(function() {
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
          minDate: new Date(currentYear, currentMonth, currentDateVal), // 현재 날짜부터 선택 가능
          // 여기에 데이트피커에서 날짜를 선택했을 때 실행할 코드 작성
          onSelect: function(selectedDate) {
              console.log("선택한 날짜: " + selectedDate);
          }
      });
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
                minDate: new Date(currentYear, currentMonth, currentDateVal), // 현재 날짜부터 선택 가능
                // 데이트피커의 onSelect 이벤트 핸들러 설정
                onSelect: function(selectedDate) {
                    // 여기에 데이트피커에서 날짜를 선택했을 때 실행할 코드 작성
                    console.log("선택한 날짜: " + selectedDate);
                }
            });
        }); // datepicker2 끝 
        
        $(document).ready(function() {
        	 // lineCode input box 클릭 이벤트 처리
            $('#lineCode2').click(function() {
            	console.log("라인코드 클릭");
                openLinePopup(); // 라인 팝업 열기
            });

            // prodCode input box 클릭 이벤트 처리
            $('#prodCode2').click(function() {
            	console.log("제품코드 클릭");
                openProductPopup(); // 제품 팝업 열기
            });
            
            // workCode input box 클릭 이벤트 처리
            $('#workCode').click(function() {	
            	console.log("워크코드  클릭");
                openWorkOrderPopup(); // 제품 팝업 열기
            });
            
        });
        
        
       

        function openLinePopup() {
            var popupUrl = '${pageContext.request.contextPath}/perf/linelist';
            window.open(
                popupUrl,
                '_blank',
                'width=800px, height=800px, left=900px, top=100px'
            );
        }

        function openProductPopup() {
            var popupUrl = '${pageContext.request.contextPath}/perf/prodlist';
            window.open(
                popupUrl,
                '_blank',
                'width=800px, height=800px, left=900px, top=100px'
            );
        }
        
        function openWorkOrderPopup() {
            var popupUrl = '${pageContext.request.contextPath}/perf/worklist';
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
        
        function selectWorkCode(workCode) {
            window.opener.setWorkCodeAndClosePopup(workCode);
        }
        
        function receiveSelectedLineData(data) {
            var parsedData = JSON.parse(data); // JSON 문자열 파싱
            document.getElementById('workCode').value = parsedData.workCode; //지시코드
            document.getElementById('prodCode').value = parsedData.prodCode; //제품코드
            document.getElementById('perfAmount').value = parsedData.workAmount;//지시수량
            document.getElementById('lineProcess').value = parsedData.lineProcess; //라인상태

             
        }
        
        $(document).ready(function() {
            // perfinsert 창이 열릴 때 PF년도월일시분초 값을 자동으로 생성
            var currentDate = new Date();
            var pfCode = 'PF' +
                currentDate.getFullYear() +
                padNumber(currentDate.getMonth() + 1) +
                padNumber(currentDate.getDate()) +
                padNumber(currentDate.getHours()) +
                padNumber(currentDate.getMinutes()) +
                padNumber(currentDate.getSeconds());

            // 생성된 PF 코드를 perfCode input box에 설정
            $('#perfCode').val(pfCode);
            
         // 현재 날짜를 yyyy-mm-dd 형식으로 생성
            var formattedDate = currentDate.getFullYear() + '-' + padNumber(currentDate.getMonth() + 1) + '-' + padNumber(currentDate.getDate());

            // 생성된 날짜를 perfDate input box에 설정
            $('#perfDate').val(formattedDate);
            
        });

        // 숫자를 두 자리로 만들어주는 함수
        function padNumber(number) {
            if (number < 10) {
                return '0' + number;
            }
            return number;
        }
        
        var perfDefectInput = document.getElementById('perfDefect');
        

        perfDefectInput.addEventListener('input', function() {
        	var perfAmount = parseInt(document.getElementById('perfAmount').value, 10); // 지시수량을 가져옴
            var enteredValue = parseInt(perfDefectInput.value, 10); // 입력된 값을 정수로 변환

            // 만약 불량수가 자식창(작업지시창)에서 받아온 값보다 크다면
            if (enteredValue > perfAmount) {
                console.log(perfAmount);
                console.log(enteredValue);
                alert('불량수는 ' + perfAmount + ' 이하로 입력해야 합니다.'); // 사용자에게 경고 메시지 표시
                perfDefectInput.value = ''; // 입력 값을 비워서 유효하지 않은 입력을 만듦
            }
        });
        
        
    </script>
</body>
</html>