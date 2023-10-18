<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!-- head -->
<head> 
<meta charset="UTF-8">  
<title>Insert title here</title>
<script src="https://unpkg.com/xlsx/dist/xlsx.full.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/side.css" rel="stylesheet" type="text/css">

<!-- javascript -->
<script type="text/javascript">

// 체크박스로 삭제
$(function(){
	var chkObj = document.getElementsByName("RowCheck");
	var rowCnt = chkObj.length;
			
	$("input[name='allCheck']").click(function(){
		var chk_listArr = $("input[name='RowCheck']");
		for (var i=0; i<chk_listArr.length; i++){
			chk_listArr[i].checked = this.checked;
		}
	});
		
	$("input[name='RowCheck']").click(function(){
		if($("input[name='RowCheck']:checked").length == rowCnt){
			$("input[name='allCheck']")[0].checked = true;
		}
		else{
			$("input[name='allCheck']")[0].checked = false;
		}
	});
});

// 체크박스로 삭제
function deleteValue(){
	var url = "delete"; // Controller로 보내고자 하는 URL
	var valueArr = new Array();
	var list = $("input[name='RowCheck']");
	
	for(var i = 0; i < list.length; i++){
		if(list[i].checked){ // 선택되어 있으면 배열에 값을 저장함
			valueArr.push(list[i].value);
		}
	}
	
	if (valueArr.length == 0){
		alert("선택된 발주가 없습니다.");
	}
	else{
		var chk = confirm("정말 삭제하시겠습니까?");				 
		$.ajax({
			url : url,             // 전송 URL
			type : 'POST',         // GET or POST 방식
			traditional : true,
			data : {
			valueArr : valueArr    // 보내고자 하는 data 변수설정
			},
	    	success: function(jdata){
	        	if(jdata = 1) {
	        		alert("삭제 성공");
	            	location.replace("home")
	        	}
	            else{
	            	alert("삭제 실패");
	            }
	   		}
		});
	}
}

// insert 페이지 팝업창
function openPopup1() {
    window.open('${pageContext.request.contextPath}/OrderManagement/insert', '_blank', 'height=400,width=600');
}

// detail 페이지 팝업창
function openPopup2(url) {
	const myWindow = window.open(url, "DetailPopup", "location=0,status=1,scrollbars=1,resizable=1,menubar=0,toolbar=no,width=400,height=700");
	myWindow.moveTo(0, 0);
	myWindow.focus();
}

// selectclient 페이지 팝업창
function openPopup3() {
    var popupWindow = window.open("${pageContext.request.contextPath}/Rawmaterials/selectclient", "_blank", "height=600,width=1300");
    // 팝업 창닫기 버튼 클릭시 창닫기
    popupWindow.onbeforeunload = function() {
        popupWindow.close();
    };
}

// 팝업창에서 작업 완료후 닫고 새로고침
$(document).ready(function() {
	var refreshAndClose = true; // refreshAndClose 값을 변수로 설정
    if (refreshAndClose) {
        window.opener.location.reload(); // 부모창 새로고침
        window.close(); // 현재창 닫기
    }
});
</script>
</head>

<!-- body -->
<body>
<jsp:include page="../inc/side.jsp"></jsp:include>
<h1>발주관리</h1>

<!-- form(검색) -->
<form action="${pageContext.request.contextPath}/OrderManagement/home" method="get">
발주번호	<input type="text" name="search1" placeholder="발주번호">
품번		<input type="text" name="search2" placeholder="품번">
종류		<select name="search3">
		<option value="">전체</option>
		<option value="향기">향기</option>
		<option value="용기">용기</option>
		<option value="스틱">스틱</option>
		<option value="라벨">라벨</option>
		<option value="포장재">포장재</option>
		</select>
거래처		<input type="text" name="search4" placeholder="거래처" id="pInput" onclick="openPopup3()">
<input type="submit" value="검색">
</form>

<!-- table -->
<table border="1" id="data-table">
<tr>
<td>발주번호</td>
<td>품번</td>
<td>품명</td>
<td>종류</td>
<td>거래처명</td>
<td>창고코드</td>
<td>창고수량</td>
<td>발주수량</td>
<td>납입단가</td>
<td>단가총계</td>
<td>발주신청일</td>
<td>담당자</td>
<td>입고상태</td>
<td></td>
</tr>

<c:forEach var="ordermanagementDTO" items="${ordermanagementList}">
<tr>
<td><a href="#" onclick="openPopup2('${pageContext.request.contextPath}/OrderManagement/detail?buyNum=${ordermanagementDTO.buyNum}')">${ordermanagementDTO.buyNum}</a></td>
<td>${ordermanagementDTO.rawCode}</td>
<td>${ordermanagementDTO.rawName}</td>
<td>${ordermanagementDTO.rawType}</td>
<td>${ordermanagementDTO.clientCode}</td>
<td>${ordermanagementDTO.whseCode}</td>
<td>${ordermanagementDTO.whseCount}</td>
<td>${ordermanagementDTO.buyCount}</td>
<td>${ordermanagementDTO.rawPrice}</td>
<td>${ordermanagementDTO.rawPrice * ordermanagementDTO.buyCount}</td>
<td>${ordermanagementDTO.buyDate}</td>
<td>${ordermanagementDTO.buyEmpId}</td>
<td>${ordermanagementDTO.buyInstate}</td>
<td><input type="checkbox" name="RowCheck" value="${ordermanagementDTO.buyNum}"></td>
</tr>
</c:forEach>
</table>

<!-- button -->
<input type="button" value="추가" onclick="openPopup1()">
<input type="button" value="삭제" onclick="deleteValue();">

<!-- 페이징처리 -->
<c:forEach var="i" begin="${pageDTO.startPage}" end="${pageDTO.endPage}" step="1">
<a href="${pageContext.request.contextPath}/OrderManagement/home?pageNum=${i}&search1=${pageDTO.search1}">${i}</a> 
</c:forEach>

<!-- button -->
<button id="excelDownload">엑셀 ⬇️</button>
<button onclick="window.location.href='${pageContext.request.contextPath}/OrderManagement/download'">전체엑셀 ⬇️</button>
				
<!-- javascript -->
<script type="text/javascript">

// 엑셀
function getToday() {
	var date = new Date();
	var year = date.getFullYear();
	var month = ("0" + (1 + date.getMonth())).slice(-2);
	var day = ("0" + date.getDate()).slice(-2);
	return year + "-" + month + "-" + day;
}

const excelDownload = document.querySelector('#excelDownload');

document.addEventListener('DOMContentLoaded', ()=> {
	excelDownload.addEventListener('click', exportExcel);
});

function exportExcel() {
    // 1.workbook 생성
    var wb = XLSX.utils.book_new();
    // 2.시트 만들기
    var newWorksheet = excelHandler.getWorksheet();
    // 3.workbook에 새로 만든 워크시트에 이름을 주고 붙이기
    XLSX.utils.book_append_sheet(wb, newWorksheet, excelHandler.getSheetName());
    // 4.엑셀파일 만들기
    var wbout = XLSX.write(wb, {bookType:'xlsx', type:'binary'});
    // 5.엑셀파일 내보내기
    saveAs(new Blob([s2ab(wbout)], {type:"application/octet-stream"}), excelHandler.getExcelFileName());
}

var excelHandler = {
    getExcelFileName : function() {
        return 'performanceList'+getToday()+'.xlsx'; // 파일명
    },
    getSheetName : function() {
        return 'Performance Sheet'; // 시트명
    },
    getExcelData : function() {
        return document.getElementById('data-table'); // table id
    },
    getWorksheet : function() {
        return XLSX.utils.table_to_sheet(this.getExcelData());
    }
}

function s2ab(s) {
    var buf = new ArrayBuffer(s.length); // s -> arrayBuffer
    var view = new Uint8Array(buf);  
    for(var i=0; i<s.length; i++) {
        view[i] = s.charCodeAt(i) & 0xFF;
    }
    return buf;
}
</script>
</body>
</html>