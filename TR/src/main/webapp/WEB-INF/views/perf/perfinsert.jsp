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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/perfinsert.css"> 
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
</head>
<body>
<div class="perfdetail">
<h1 class="perfinserthaed"> 생산실적 추가</h1>
<hr>
<div class="perfcd">

<div class="perfcd1">
라인코드: <input type="text" id="lineCode2" name="lineCode2"  class="cdbox">
</div>

<div class="perfcd1">
제품코드: <input type="text" id="prodCode2" name="prodCode2"  placeholder="제품코드" class="cdbox" onclick="">
</div>

<div class="perfcd1">
 지시일자: <input type="text" id="workdate1" name="workdate1" class="form-control" placeholder="날짜 선택" readonly> ~ <input type="text" id="workdate2" name="workdate2	" class="form-control" placeholder="날짜 선택" readonly>
</div>

</div> <!--  perfcd -->
<hr> <!--  경계선 -->
<form action="${pageContext.request.contextPath}/perf/perfinsertPro" id="perfinsert" method="POST">
 	<table class="ct" id="ct">	
			<thead>
				<tr class="cthead">
				    <th>생산실적코드</th>
					<th>작업지시코드</th><!-- worklist에서 받아옴 -->
					<th>제품코드</th><!-- worklist에서 받아옴 -->
					<th>라인코드</th><!-- worklist에서 받아옴 -->
					<th >실적일</th>
					<th> 담당자 </th> <!--  세션으로 넘겨받음 -->
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
						<td ><input type="text" id="lineCode" name="lineCode"></td> <!--  제품코드 -->
						<td ><input type="text" id="perfDate" name="perfDate"></td> <!-- 실적일자(자동생성) -->
						<td ><input type="text" id="perfEmpId" name="perfEmpId"></td> <!--  담당자아이디(세션으로처리) -->
				        <td ><input type="number" id="perfAmount" name="perfAmount" required></td> <!-- 실적수량 -->
						<td ><input type="number" id="perfFair" name="perfFair" required></td> <!-- 양품수-->
						<td ><input type="number" id="perfDefect" name="perfDefect"></td> <!-- 불량수 -->
						
						<td ><select id="perfDefectreason" name="perfDefectreason">
	                    	    <option value="무결함">무결함</option>
		                      	<option value="파손">파손</option> <!-- 병깨짐 , 포장박스 꾸겨진거 등 -->
								<option value="누락">누락</option> <!--  포장 박스에 물건이 없다던가 포장이 안된다던가 -->
								<option value="기타">기타</option>
						       </select>                                                          </td>  <!-- 불량사유 -->
						       
						<td ><input type="text" id="perfDefectmemo" name="perfDefectmemo"></td>  <!--기타 불량사유 -->
						<td ><input type="text" id="perfMemo" name="perfMemo"></td> <!-- 비고 -->
						<td ><input type="text" id="lineProcess" name="perfStatus"></td> <!-- 라인상테 -->
					</tr>
			</tbody> 
			</table>
			
			<div class="footerbtn">
			<input type="submit" id="btn" class="btn" value="등록">
			<input type="button" id="closebtn" class="btn" value="닫기">
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
            document.getElementById('lineCode').value = parsedData.lineCode; //지시코드
            document.getElementById('prodCode').value = parsedData.prodCode; //제품코드
            document.getElementById('perfAmount').value = parsedData.workAmount;//지시수량
            document.getElementById('lineProcess').value = parsedData.lineProcess; //라인상태

             
        } // 라인코드 , 라인코드  값 받아오기 제어 끝**********************************
        
        // 실적코드 자동생성 제어 ******************************
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
        } // 실적코드 자동생산 제어 끝 *************************************
        
      // 지시수량 양품수 불량수 제어 ********************************
        var perfDefectInput = document.getElementById("perfDefect");
        var perfFairInput = document.getElementById("perfFair");
        var perfAmountInput = document.getElementById("perfAmount");
        
        perfDefectInput.addEventListener('input', updateTotal);
        perfFairInput.addEventListener('input', updateTotal);
        perfAmountInput.addEventListener('input', updateTotal);
        
        function updateTotal() {
            var perfAmount = parseInt(perfAmountInput.value, 10); // 지시수량(실적수량)을 가져옴
            var defectCount = parseInt(perfDefectInput.value, 10) || 0; // 불량품 수를 가져오고, 값이 없으면 0으로 간주
            var fairCount = parseInt(perfFairInput.value, 10) || 0; // 양품 수를 가져오고, 값이 없으면 0으로 간주

            var total = defectCount + fairCount; // 양품수와 불량품수를 더함

            if (total > perfAmount) {
                if (fairCount > perfAmount && defectCount > perfAmount) {
                    Swal.fire({
                        title: '입력 오류',
                        text: '양품수와 불량품수의 합은 ' + perfAmount + ' 이하여야 합니다.',
                        icon: 'error'
                    });
                    perfDefectInput.value = ''; // 불량수 초기화
                    perfFairInput.value = ''; // 양품수 초기화
                } else if (fairCount > perfAmount) {
                    Swal.fire({
                        title: '입력 오류',
                        text: '양품수는 ' + perfAmount + ' 이하여야 합니다.',
                        icon: 'error'
                    });
                    perfFairInput.value = ''; // 양품수 초기화
                } else if (defectCount > perfAmount) {
                    Swal.fire({
                        title: '입력 오류',
                        text: '불량품수는 ' + perfAmount + ' 이하여야 합니다.',
                        icon: 'error'
                    });
                    perfDefectInput.value = ''; // 불량수 초기화
                } else if(defectCount + fairCount > perfAmount) {
                    Swal.fire({
                        title: '입력 오류',
                        text: '양품수와 불량품수의 합은 ' + perfAmount + ' 이하여야 합니다.',
                        icon: 'error'
                    });
                    perfDefectInput.value = ''; // 불량수 초기화
                    perfFairInput.value = ''; // 양품수 초기화
                }
            }  
        }// 지시수량 양품수 불량수 제어 끝 ********************************
        
        
        
        
        // 불량사유 제어**************************************************
        // 불량사유 선택 상자
        var defectReasonSelect = document.getElementById("perfDefectreason");
        
        // 기타 불량사유 입력란
        var defectMemoInput = document.getElementById("perfDefectmemo");

        // 불량사유가 변경될 때 호출되는 함수
        function handleDefectReasonChange() {
        	
            // 선택된 불량사유 값 가져오기
            var selectedValue = defectReasonSelect.value;

            // 만약 불량사유가 "파손" 또는 "누락"인 경우 기타 불량사유 입력란 활성화, 그렇지 않으면 비활성화
            if (selectedValue === "파손" || selectedValue === "누락" || selectedValue === "무결함" ) {
                defectMemoInput.disabled = true; // 활성화
            } else {
                defectMemoInput.disabled = false; // 비활성화
            }
        }

        // 불량사유 선택 상자의 변경 이벤트에 handleDefectReasonChange 함수 연결
        defectReasonSelect.addEventListener("change", handleDefectReasonChange);

        // 페이지 로드 시 초기 상태 설정을 위해 한 번 호출
        handleDefectReasonChange();
        
        //불량사유 제어 끝 ***********************************************
        
    document.getElementById("perfinsert").addEventListener("submit", function(event) {
    // 이벤트 기본 동작(폼 제출)을 중단하여 자바스크립트 코드를 실행
    event.preventDefault();
    
    // 불량수가 비어있을 경우 0으로 설정
    setDefaultDefectValue();

    // 여기에 폼 데이터를 서버로 전송하는 코드를 추가할 수 있습니다.
    $.post("${pageContext.request.contextPath}/perf/perfinsertPro", $("#perfinsert").serialize(), function(response) {
        // 서버 응답에 대한 처리 코드
        if (response.success) {
        	console.log("등록 성공"); // 디버깅 메시지
            // 서버 요청이 성공적으로 처리되었을 때 Swal.fire 코드를 실행
            Swal.fire({
                title: '등록이 완료되었습니다.',
                text: '성공적으로 등록되었습니다.',
                icon: 'success'
            });
        } else {
        	   console.log("등록 실패"); // 디버깅 메시지
            // 서버 요청이 실패했을 때의 처리 코드
            // 실패 메시지를 표시하거나 사용자에게 알림을 주는 등의 작업을 수행할 수 있습니다.
            Swal.fire({
                title: '등록 실패',
                text: '등록에 실패하였습니다.',
                icon: 'error'
            });
        }
    });
});

// "닫기" 버튼 클릭 이벤트 처리
document.getElementById("closebtn").addEventListener("click", function() {
	console.log("닫기");
    // 창을 닫는 동작을 수행할 수 있습니다.
    window.close();
});
    
    // 불량수 값이 비어있을 경우 0으로 설정하는 함수 실적수량 35 양품수가 35일경우 굳이 0을 입력할 필요가 없을 때 쓰기 위해서 사용
    function setDefaultDefectValue() {
        var perfDefectInput = document.getElementById("perfDefect");
        if (perfDefectInput.value === "") {
            perfDefectInput.value = "0"; // 또는 perfDefectInput.value = 0; (문자열이 아닌 정수로 설정)
        }
    }
        
    </script>
</body>
</html>