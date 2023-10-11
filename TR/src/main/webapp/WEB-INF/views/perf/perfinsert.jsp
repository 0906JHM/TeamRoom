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
라인코드: <input type="text" id="lineCode" name="lineCode" onclick="" class="cdbox">
</div>

<div class="perfcd1">
제품코드: <input type="text" id="prodCode" name="prodCode" onclick="" placeholder="제품코드" class="cdbox" onclick="">
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
					<th>작업지시코드</th>
					<th>라인코드</th>
					<th>제품코드</th>
					<th >실적일</th>
					<th >실적수량</th>
					<th >양품수</th>
					<th >불량수</th>
					<th >불량사유</th>
					<th >현황</th>
					<th >비고</th>
				</tr>
			</thead> 
			<tbody>
					<tr class="ctcontents">
					    <td >WO2023101111095</td>
						<td ><input type="text" id="workCode" name="workCode" onclick=""></td>
						<td >1</td>
						<td >1</td>
						<td >1</td>
						<td >1</td>
						<td >1</td>
						<td >1</td>
						<td >1</td>
						<td >1</td>
						<td >1</td>
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
        
    </script>
</body>
</html>