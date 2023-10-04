<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%--     <jsp:include page="test4.jsp"></jsp:include> --%>
    <title>Sell/sellMain.jsp</title>
    <%-- <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> --%>
<%--     <link href="${pageContext.request.contextPath}/resources/css/daterange.css" rel="stylesheet" type="text/css"> --%>
<%--  <link href="${pageContext.request.contextPath}/resources/css/sell.css" rel="stylesheet" type="text/css"> --%>


<!----------------------------------------------------- daterange.css-------------------------------------------------->
<style type="text/css">

.daterangepicker {
  position: absolute;
  color: inherit;
  background-color: #fff;
  border-radius: 4px;
  border: 1px solid #ddd;
  width: 278px;
  max-width: none;
  padding: 0;
  margin-top: 7px;
  top: 100px;
  left: 20px;
  z-index: 3001;
  display: none;
  font-family: arial;
  font-size: 15px;
  line-height: 1em;
}

.daterangepicker:before, .daterangepicker:after {
  position: absolute;
  display: inline-block;
  border-bottom-color: rgba(0, 0, 0, 0.2);
  content: '';
}

.daterangepicker:before {
  top: -7px;
  border-right: 7px solid transparent;
  border-left: 7px solid transparent;
  border-bottom: 7px solid #ccc;
}

.daterangepicker:after {
  top: -6px;
  border-right: 6px solid transparent;
  border-bottom: 6px solid #fff;
  border-left: 6px solid transparent;
}

.daterangepicker.opensleft:before {
  right: 9px;
}

.daterangepicker.opensleft:after {
  right: 10px;
}

.daterangepicker.openscenter:before {
  left: 0;
  right: 0;
  width: 0;
  margin-left: auto;
  margin-right: auto;
}

.daterangepicker.openscenter:after {
  left: 0;
  right: 0;
  width: 0;
  margin-left: auto;
  margin-right: auto;
}

.daterangepicker.opensright:before {
  left: 9px;
}

.daterangepicker.opensright:after {
  left: 10px;
}

.daterangepicker.drop-up {
  margin-top: -7px;
}

.daterangepicker.drop-up:before {
  top: initial;
  bottom: -7px;
  border-bottom: initial;
  border-top: 7px solid #ccc;
}

.daterangepicker.drop-up:after {
  top: initial;
  bottom: -6px;
  border-bottom: initial;
  border-top: 6px solid #fff;
}

.daterangepicker.single .daterangepicker .ranges, .daterangepicker.single .drp-calendar {
  float: none;
}

.daterangepicker.single .drp-selected {
  display: none;
}

.daterangepicker.show-calendar .drp-calendar {
  display: block;
}

.daterangepicker.show-calendar .drp-buttons {
  display: block;
}

.daterangepicker.auto-apply .drp-buttons {
  display: none;
}

.daterangepicker .drp-calendar {
  display: none;
  max-width: 270px;
}

.daterangepicker .drp-calendar.left {
  padding: 8px 0 8px 8px;
}

.daterangepicker .drp-calendar.right {
  padding: 8px;
}

.daterangepicker .drp-calendar.single .calendar-table {
  border: none;
}

.daterangepicker .calendar-table .next span, .daterangepicker .calendar-table .prev span {
  color: #fff;
  border: solid black;
  border-width: 0 2px 2px 0;
  border-radius: 0;
  display: inline-block;
  padding: 3px;
}

.daterangepicker .calendar-table .next span {
  transform: rotate(-45deg);
  -webkit-transform: rotate(-45deg);
}

.daterangepicker .calendar-table .prev span {
  transform: rotate(135deg);
  -webkit-transform: rotate(135deg);
}

.daterangepicker .calendar-table th, .daterangepicker .calendar-table td {
  white-space: nowrap;
  text-align: center;
  vertical-align: middle;
  min-width: 32px;
  width: 32px;
  height: 24px;
  line-height: 24px;
  font-size: 12px;
  border-radius: 4px;
  border: 1px solid transparent;
  white-space: nowrap;
  cursor: pointer;
}

.daterangepicker .calendar-table {
  border: 1px solid #fff;
  border-radius: 4px;
  background-color: #fff;
}

.daterangepicker .calendar-table table {
  width: 100%;
  margin: 0;
  border-spacing: 0;
  border-collapse: collapse;
}

.daterangepicker td.available:hover, .daterangepicker th.available:hover {
  background-color: #eee;
  border-color: transparent;
  color: inherit;
}

.daterangepicker td.week, .daterangepicker th.week {
  font-size: 80%;
  color: #ccc;
}

.daterangepicker td.off, .daterangepicker td.off.in-range, .daterangepicker td.off.start-date, .daterangepicker td.off.end-date {
  background-color: #fff;
  border-color: transparent;
  color: #999;
}

.daterangepicker td.in-range {
  background-color: #ebf4f8;
  border-color: transparent;
  color: #000;
  border-radius: 0;
}

.daterangepicker td.start-date {
  border-radius: 4px 0 0 4px;
}

.daterangepicker td.end-date {
  border-radius: 0 4px 4px 0;
}

.daterangepicker td.start-date.end-date {
  border-radius: 4px;
}

.daterangepicker td.active, .daterangepicker td.active:hover {
  background-color: #5EC397;
  border-color: transparent;
  color: #fff;
}

.daterangepicker th.month {
  width: auto;
}

.daterangepicker td.disabled, .daterangepicker option.disabled {
  color: #999;
  cursor: not-allowed;
  text-decoration: line-through;
}

.daterangepicker select.monthselect, .daterangepicker select.yearselect {
  font-size: 12px;
  padding: 1px;
  height: auto;
  margin: 0;
  cursor: default;
}

.daterangepicker select.monthselect {
  margin-right: 2%;
  width: 56%;
}

.daterangepicker select.yearselect {
  width: 40%;
}

.daterangepicker select.hourselect, .daterangepicker select.minuteselect, .daterangepicker select.secondselect, .daterangepicker select.ampmselect {
  width: 50px;
  margin: 0 auto;
  background: #eee;
  border: 1px solid #eee;
  padding: 2px;
  outline: 0;
  font-size: 12px;
}

.daterangepicker .calendar-time {
  text-align: center;
  margin: 4px auto 0 auto;
  line-height: 30px;
  position: relative;
}

.daterangepicker .calendar-time select.disabled {
  color: #ccc;
  cursor: not-allowed;
}

.daterangepicker .drp-buttons {
  clear: both;
  text-align: right;
  padding: 8px;
  border-top: 1px solid #ddd;
  display: none;
  line-height: 12px;
  vertical-align: middle;
}

.daterangepicker .drp-selected {
  display: inline-block;
  font-size: 12px;
  padding-right: 8px;
}

.daterangepicker .drp-buttons .btn {
  margin-left: 8px;
  font-size: 12px;
  font-weight: bold;
  padding: 4px 8px;
}

.daterangepicker.show-ranges.single.rtl .drp-calendar.left {
  border-right: 1px solid #ddd;
}

.daterangepicker.show-ranges.single.ltr .drp-calendar.left {
  border-left: 1px solid #ddd;
}

.daterangepicker.show-ranges.rtl .drp-calendar.right {
  border-right: 1px solid #ddd;
}

.daterangepicker.show-ranges.ltr .drp-calendar.left {
  border-left: 1px solid #ddd;
}

.daterangepicker .ranges {
  float: none;
  text-align: left;
  margin: 0;
}

.daterangepicker.show-calendar .ranges {
  margin-top: 8px;
}

.daterangepicker .ranges ul {
  list-style: none;
  margin: 0 auto;
  padding: 0;
  width: 100%;
}

.daterangepicker .ranges li {
  font-size: 12px;
  padding: 8px 12px;
  cursor: pointer;
}

.daterangepicker .ranges li:hover {
  background-color: #eee;
}

.daterangepicker .ranges li.active {
  background-color: #08c;
  color: #fff;
}

/*  Larger Screen Styling */
@media (min-width: 564px) {
  .daterangepicker {
    width: auto;
  }

  .daterangepicker .ranges ul {
    width: 140px;
  }

  .daterangepicker.single .ranges ul {
    width: 100%;
  }

  .daterangepicker.single .drp-calendar.left {
    clear: none;
  }

  .daterangepicker.single .ranges, .daterangepicker.single .drp-calendar {
    float: left;
  }

  .daterangepicker {
    direction: ltr;
    text-align: left;
  }

  .daterangepicker .drp-calendar.left {
    clear: left;
    margin-right: 0;
  }

  .daterangepicker .drp-calendar.left .calendar-table {
    border-right: none;
    border-top-right-radius: 0;
    border-bottom-right-radius: 0;
  }

  .daterangepicker .drp-calendar.right {
    margin-left: 0;
  }

  .daterangepicker .drp-calendar.right .calendar-table {
    border-left: none;
    border-top-left-radius: 0;
    border-bottom-left-radius: 0;
  }

  .daterangepicker .drp-calendar.left .calendar-table {
    padding-right: 8px;
  }

  .daterangepicker .ranges, .daterangepicker .drp-calendar {
    float: left;
  }
}

@media (min-width: 730px) {
  .daterangepicker .ranges {
    width: auto;
  }

  .daterangepicker .ranges {
    float: left;
  }

  .daterangepicker.rtl .ranges {
    float: right;
  }

  .daterangepicker .drp-calendar.left {
    clear: none !important;
  }
}
<!----------------------------------------------------- sell.css -------------------------------------------------->


/* .container {
    margin-left: 260px;
} */

body{
	background-color: #F5F6FA;
	}
.horizontal-line {
    width: 1000px;
    height: 1px;
    background-color: #B8B8B8;
     margin-bottom: 20px;
}

h2 {
    font-size: 30px;
    font-weight: bold;
}
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-zrve{background-color:#0949f7;border-color:#3531ff;text-align:center;vertical-align:top}
.tg .tg-llyw{background-color:#D9D9D9;border-color:inherit;text-align:left;vertical-align:top}
.tg .tg-llyw2{background-color:#ffffff;border-color:inherit;text-align:left;vertical-align:top}
.tg .tg-0pky{border-color:inherit;text-align:left;vertical-align:top}

/* 버튼 */

#search {
	width : 40px;
	height : 25px;
	background-color: #5EC397;
	color: #FFFFFF;
	border: none;
	border-radius: 3px;
	 margin-bottom: 10px;
}

#add {
	width : 40px;
	height : 25px;
	background-color: #5EC397;
	color: #FFFFFF;
	border: none;
	border-radius: 3px;
	 margin-bottom: 10px;
}

#update {
	width : 40px;
	height : 25px;
	background-color: #5EC397;
	color: #FFFFFF;
	border: none;
	border-radius: 3px;
	 margin-bottom: 10px;
}

#delete {
	width : 40px;
	height : 25px;
	background-color: #5EC397;
	color: #FFFFFF;
	border: none;
	border-radius: 3px;
	 margin-bottom: 10px;
}

#cancel {
	width : 40px;
	height : 25px;
	background-color: #5EC397;
	color: #FFFFFF;
	border: none;
	border-radius: 3px;
	 margin-bottom: 10px;
}

#memo {
	width : 40px;
	height : 25px;
	background-color: #5EC397;
	color: #FFFFFF;
	border: none;
	border-radius: 3px;
	 margin-bottom: 10px;
}

#save {
	width : 40px;
	height : 25px;
	background-color: #5EC397;
	color: #FFFFFF;
	border: none;
	border-radius: 3px;
	 margin-bottom: 10px;
}

#exel {
	width : 40px;
	height : 25px;
	background-color: #5EC397;
	color: #FFFFFF;
	border: none;
	border-radius: 3px;
	 margin-bottom: 10px;
}

#file {
	width : 40px;
	height : 25px;
	background-color: #5EC397;
	color: #FFFFFF;
	border: none;
	border-radius: 3px;
	 margin-bottom: 10px;
}



/* 테이블 */
#sellTable {
    border-collapse: collapse;
    width : 1220px;
}

#sellTable tr {
    border-bottom: 1px solid #EAEBEA;
}

#sellTable th, #sellTable td {
    border: none;
}

input[type="text"] {
	border: 1px solid #A6A6A6; /* 테두리 색 설정 */
	background-color: #FFFFFF; /* 배경색 설정 */
	border-radius: 3px;
	 margin-bottom: 10px;
}


.outer-container {
	display: flex;
}

.main-content {
	flex: 1;
	padding: 20px;
}


</style>

</head>

<!------------------------------------------------------- 헤더 ---------------------------------------------------->

<!---------------------------------------------------- 상단 조회 및 버튼 ----------------------------------------------------->

<div class="outer-container">
     <jsp:include page="../inc/side.jsp"></jsp:include> 
    
	<div class="main-content">
	    <h2>수주 관리</h2>
	    <div class="horizontal-line"></div>
	    <form>

	        <label>수주 코드</label>  <input type="text" >
	        <label>거래처 코드</label>  <input type="text" >
	        <label>제품 코드</label>  <input type="text" >
	        <label>제품명</label>  <input type="text" >
	      
	        <br> 
	        
	       	<label>처리 상태</label>  <input type="text" vale=""><!--outProduct에서 출고완료 체크하면 출고완료 표시되도록 -->
	       	<label for="startDate">수주 일자</label> 
	       		<input type="text" name="daterange" value="" >
			<label for="startDate">납기일자</label> 
				<input type="text" name="daterange" value="" >
	        
	        <button id="search" type="submit" onclick="location.href='${pageContext.request.contextPath}/sell/sellSearch'">조회</button>
	        <button id="add">추가</button>
	  		<button id="update">수정</button>
	   		<button id="delete">삭제</button>
	    	<button id="cancel">취소</button>
	    	<button id="memo">비고</button>
	    	<button id="save">저장</button>
	    	<button id="exel">Excel</button>
	    	<button id="file">File</button>
	    	
	    </form>
	
	<!---------------------------------------------------- 본문 테이블 ----------------------------------------------------->    
	    <p>선택 총 0건</p>
	    <p> <input type="checkbox" id="selectAllCheckbox">전체 선택</p>
	    
	    <table class="tg" id="sellTable">
	        <tbody>
	            <tr>
	           	 	<td class="tg-llyw">선택</td>
	                <td class="tg-llyw">번호</td>
	                <td class="tg-llyw">처리 상태</td>
	                <td class="tg-llyw">수주 코드</td>
	                <td class="tg-llyw">거래처 코드</td>
	                <td class="tg-llyw">제품 코드</td>
	                <td class="tg-llyw">제품명</td>
	                <td class="tg-llyw">수주 단가</td>
	                <td class="tg-llyw">수주 수량</td>
	                <td class="tg-llyw">수주 일자</td>
	                <td class="tg-llyw">납기 일자</td>
	                <td class="tg-llyw">담당자</td>
	                <td class="tg-llyw">비고</td>
	                <td class="tg-llyw">파일</td>
	            </tr>
	            
	            <c:forEach var="sellDTO" items="${sellList}">
	            <tr>
	            <td class="tg-llyw2"><input type="checkbox" class="item-checkbox"></td>
	            
	                <td class="tg-llyw2">${sellDTO.num}</td><!-- 목록번호 -->
	                <td class="tg-llyw2">${sellDTO.sellState}</td><!-- 처리(출고)상태 -->
	                <td class="tg-llyw2">${sellDTO.sellCode}</td><!-- 수주코드 -->
	                <td class="tg-llyw2">${sellDTO.clientCode}</td><!-- 거래처코드 -->
	                <td class="tg-llyw2">${sellDTO.prodCode}</td><!-- 제품코드 -->
	                <td class="tg-llyw2">${sellDTO.prodName}</td><!-- 제품명 -->
	                <td class="tg-llyw2">${sellDTO.clientCode}</td><!-- 수주단가 -->
	                <td class="tg-llyw2">${sellDTO.sellCount}</td><!-- 수주수량-->
	                <td class="tg-llyw2"><fmt:formatDate value="${sellDTO.sellDate}" pattern="yyyy.MM.dd"/></td><!-- 수주일자 -->
	                <td class="tg-llyw2"><fmt:formatDate value="${sellDTO.sellDuedate}" pattern="yyyy.MM.dd"/></td><!-- 납기일자  -->
	                <td class="tg-llyw2">${sellDTO.clientCode}</td><!-- 비고 -->
	                <td class="tg-llyw2">${sellDTO.clientCode}</td><!-- 비고 -->
	                <td class="tg-llyw2">${sellDTO.sellFile}</td><!-- 파일 -->
	            </tr>
	             </c:forEach>
	        </tbody>
	    </table>
	</div>
</div>

<!---------------------------------------------- javascript ---------------------------------------------->
<script type="text/javascript">
$(document).ready(function() {
    $('#add').click(function(event) {
        event.preventDefault();
        addRow();
    });
    
    $('#save').click(function(event) {
        event.preventDefault();
        saveData();
    })
});

var rowCount = 1; // 초기 행 번호 설정

function addRow() {
    var table = document.getElementById('productTable').getElementsByTagName('tbody')[0];
    
    var numRowsToAdd = 1; // 한 번에 추가할 행의 개수

    for (var i = 0; i < numRowsToAdd; i++) {
        var newRow = table.insertRow(table.rows.length);

        for (var j = 0; j < 10; j++) {
            var cell = newRow.insertCell(j);

            if (j === 0) {
                // 첫 번째 셀에는 일련번호 설정 (rowCount 사용)
                cell.innerHTML = rowCount++;
            } else {
                // 나머지 셀에는 입력 필드 추가
                cell.innerHTML = '<input type="text">';
            }
            
        }
    }
}

function saveData() {
    var table = document.getElementById('productTable').getElementsByTagName('tbody')[0];
    var newRow = table.rows[table.rows.length - 1]; // 마지막 행 가져오기

    var data = []; // 행의 데이터를 저장할 배열

    for (var j = 1; j < 10; j++) {
        var inputElement = newRow.cells[j].querySelector('input');
        var cellValue = inputElement.value;
        data.push(cellValue);
        
        // 값을 저장한 후 입력 필드를 비활성화(disabled) 상태로 변경
        inputElement.setAttribute('disabled', 'disabled');
    }

    // 여기서 data 배열에 저장된 데이터를 원하는 방식으로 처리하면 됩니다.
    // 예를 들어, 서버에 전송하거나 로컬 스토리지에 저장할 수 있습니다.

    // 데이터 처리 후, 필요한 작업을 수행하세요.
    alert('데이터가 저장되었습니다: ');
}
</script>

<!-------------------------- 목록 전체선택 -------------------------->
<script>
	// 전체선택
	document.getElementById("selectAllCheckbox").addEventListener(
			"click",
			function() {
				var itemCheckboxes = document
						.querySelectorAll(".item-checkbox");
				var selectAllButton = document
						.getElementById("selectAllCheckbox");

				// 모든 아이템을 선택 상태로 만들거나 해제
				var areAllSelected = true;
				for (var i = 0; i < itemCheckboxes.length; i++) {
					if (!itemCheckboxes[i].checked) {
						areAllSelected = false;
						break;
					}
				}
				for (var i = 0; i < itemCheckboxes.length; i++) {
					itemCheckboxes[i].checked = !areAllSelected;
				}
			});//selectAllCheckbox
</script>

<!-------------------------- 수주일자, 납기일자 기간선택 ----------------->
<script>

	$(function() {
		$('input[name="daterange"]').daterangepicker({
			autoUpdateInput : false,
			locale : {
				cancelLabel : 'Clear'
			}
		});
		$('input[name="daterange"]').on(
				'apply.daterangepicker',
				function(ev, picker) {
					$(this).val(
							picker.startDate.format('YYYY/MM/DD') + ' - '
									+ picker.endDate.format('YYYY/MM/DD'));
				});
		$('input[name="daterange"]').on('cancel.daterangepicker',
				function(ev, picker) {
					$(this).val('');
				});
		$('.cancelBtn').text('취소');
		$('.applyBtn').text('적용');
	});
</script>

<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>

</body>
</html>