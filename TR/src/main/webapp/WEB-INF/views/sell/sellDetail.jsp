<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<%--     <jsp:include page="test4.jsp"></jsp:include> --%>
    <title>Sell/updateSellMemo.jsp</title>
    <%-- <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> --%>
<%--     <link href="${pageContext.request.contextPath}/resources/css/daterange.css" rel="stylesheet" type="text/css"> --%>
<%--  <link href="${pageContext.request.contextPath}/resources/css/sell.css" rel="stylesheet" type="text/css"> --%>
<link href="${pageContext.request.contextPath}/resources/css/popup.css" rel="stylesheet" type="text/css">

</head>

<!------------------------------------------------------ 본문 ---------------------------------------------------->

<body>
<div class="popupContainer">
<h1>수주 상세정보</h1>
<div class="horizontal-line"></div>
    <form action="${pageContext.request.contextPath}/sell/sellUpdatePro" id="popup" class="popup"  method="post" onsubmit="checkForm()" >
<label>수주 코드</label>
			<label>수주 코드</label>
			<input type="text" name="prodCode" value="${sellDTO.sellCode}" readonly>
			<br>
			<label>처리 상태</label>
			<input type="text" name="prodCode" value="${sellDTO.sellState}" readonly>
			<br>
			<label>거래처</label>
			<input type="text" name="clientCode" value="${sellDTO.clientCode}" readonly >
        	<input type="text" value="${sellDTO.clientCompany}" readonly >
			<br>
			<label>제품</label>
			<input type="text" name="prodCode" value="${sellDTO.prodCode}" readonly>
	      	<input type="text" name="prodName" value="${sellDTO.prodName}" readonly>
			<br>
			<label>제품 단가</label>
			<input type="text" name="prodPrice" value="${sellDTO.prodPrice}" readonly>원
			<br>
			<label>수주 수량</label>
			<input type="number" id="sellCount" name="sellCount" value="${sellDTO.sellCount}" readonly>개
			<br>
			<label>수주 단가</label>
			<input type="text" step="0.01" name="prodPrice" value="${sellDTO.sellPrice}" pattern="###,###원" readonly/>
			<br>
			<label>수주 일자</label>
			<input type="text" id="sellDate" name="sellDate" value="${sellDTO.sellDate}"readonly>
			<br>
			<label>납기 일자</label>
			<input type="text" id="sellDate" name="sellDate" value="${sellDTO.sellDuedate}"readonly>
			<br>
			<label>담당자</label>
			<input type="text" name="sellEmpId" value="${sellDTO.sellEmpId}" readonly>
			<br>
			<label>비고</label>
			<br>
			<textarea id="sellMemo" readonly="readonly" style="width: 350px; height: 250px;">${sellDTO.sellMemo}</textarea>
			<br>
			
			<c:if test="${sessionScope.id == sellDTO.sellEmpId}">
				<button type="button" onclick="location.href='${pageContext.request.contextPath}/sell/sellUpdate?sellCode=${sellDTO.sellCode}'">수정</button>
			</c:if>
			<button type="button" onclick="window.close()">닫기</button>
	</form>

</div>
<!--  ************************************************ javaScript *************************************************************-->

<!----------------------------------------------- 등록버튼 ---------------------------------------------->
 
<script type="text/javascript">

//팝업 옵션
const popupOpt = "top=60,left=140,width=720,height=600";

//검색 팝업
	function searchItem(type, inputId) {
	 	var url = "${pageContext.request.contextPath}/search/search?type=" + type + "&input=" + inputId;
	var popup = window.open(url, "", popupOpt);
} //openWindow()


//팝업 창을 열어주는 함수
function openPopup(url) {
    var width = 500;
    var height = 500;
    var left = (screen.width - width) / 2;
    var top = (screen.height - height) / 2;
    var popupWindow = window.open(url, '_blank', "width=" + width + ", height=" + height + ", left=" + left + ", top=" + top);
    popupWindow.focus();
}
$(document).ready(function() {
});

function calculateSellPrice() {
  	var prodPriceInput = document.getElementById('prodPrice9999').value;
    var sellCountInput = document.getElementById('sellCount').value;

 	// 입력 값을 정리하여 정수로 변환
    var prodPrice = parseInt(prodPriceInput.replace(/[^\d.]/g, ''), 10);
    var sellCount = parseInt(sellCountInput, 10);
	
    var sellPrice = prodPrice * sellCount;
    
    console.log(sellPrice);
    if (!isNaN(sellPrice)) {
        document.getElementById('sellPrice').value = formatCurrency(sellPrice);
    } else {
        document.getElementById('sellPrice').value = '';
    }
}
//숫자를 ###,### 원 형식으로 포맷하는 함수
function formatCurrency(number) {
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

// 이벤트 리스너 등록
document.getElementById('sellCount').addEventListener('input', calculateSellPrice);
document.getElementById('prodPrice9999').addEventListener('input', calculateSellPrice);

// 초기화 함수
calculateSellPrice();
$(function() {
    // 현재 날짜를 가져오기
    var currentDate = new Date();
    
    // 날짜 형식 지정 (yy-mm-dd)
    var formattedDate = currentDate.getFullYear() + "-" +
                        ("0" + (currentDate.getMonth() + 1)).slice(-2) + "-" +
                        ("0" + currentDate.getDate()).slice(-2);

    // #sellDate 필드에 현재 날짜 설정
    $("#sellDate").val(formattedDate);
});
var today = new Date();
var dd = String(today.getDate() + 1).padStart(2, '0');
var mm = String(today.getMonth() + 1).padStart(2, '0'); // January is 0!
var yyyy = today.getFullYear();
var currentDateString = yyyy + '-' + mm + '-' + dd;
// 납품예정일 입력란
// var shipSdateInput = document.getElementById("shipSdate");
// 수주일자(오늘) 이후의 날짜만 선택할 수 있도록 Datepicker 설정
$(function() {
    $("#sellDuedate").datepicker({
        minDate: currentDateString, // 현재 날짜 이후로 설정
        dateFormat: "yy-mm-dd", // MySQL DATE 형식으로 출력
    });
});

</script>


</body>
</html>