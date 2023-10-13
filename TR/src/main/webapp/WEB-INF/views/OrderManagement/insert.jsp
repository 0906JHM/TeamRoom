<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!-- head -->
<head>
<meta charset="UTF-8">  
<title>Insert title here</title>
</head>

<!-- body -->
<body>
<h1>발주등록</h1>

<!-- form -->
<form action="${pageContext.request.contextPath}/OrderManagement/insertPro" method="post">
품번 : 		<input type="text" name="rawCode" id="rCInput"> <input type="button" value="원자재목록" onclick="openPopup1()"><br>
품명 : 		<input type="text" name="rawName" id="rNInput"><br>
종류 : 		<input type="text" name="rawType" id="rTInput"><br>
매입단가 : 		<input type="number" name="rawPrice" id="rPInput"><br>
거래처명 : 		<input type="text" name="clientCode" id="cInput"> <input type="button" value="거래처목록" onclick="openPopup2()"><br>
창고수량 : 		<input type="number" name="whseCount"><br>
발주수량 : 		<input type="number" name="buyCount"><br>
발주신청일 : 	<input type="date" name="buyDate"><br>
담당자 : 		<input type="text" name="buyEmpId"><br>
입고상태 : 		<input type="radio" name="buyInstate" value="발주완료" checked>발주완료<br>
<input type="submit" value="발주등록">
</form>

<!-- javascript -->
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<script type="text/javascript">

// 원자재목록 페이지 팝업창
let openWin;
function openPopup1() {
	// window.name = "부모창 이름";
	window.name = "insert";
	// openWin = window.open("open할 window", "자식창 이름", "팝업창 옵션");
	openWin = window.open("selectrawmaterials.html", "selectrawmaterials", "height=600,width=1300");    
}

// 거래처목록 페이지 팝업창
function openPopup2() {
	window.name = "insert";
	openWin = window.open("selectclient.html", "selectclient", "height=600,width=1300");    
}

// form 제출전 rawPrice 값을 float로 변환
$('form').on('submit', function(e) {
    e.preventDefault();
    var rawPrice = $('#rPInput').val();			// rawPrice 값을 가져옴
    var rawPriceFloat = parseFloat(rawPrice); 	// rawPrice 값을 float으로 변환
    // NaN 체크 : parseFloat가 실패하면 NaN 반환
    if (isNaN(rawPriceFloat)) {
        alert('매입단가는 숫자여야 합니다.');
        return;
    }
    $('#rPInput').val(rawPriceFloat); // 변환된 rawPrice 값을 form에 다시 설정
    this.submit();					  // form 제출
});
</script>
</body>
</html>