<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<%--     <jsp:include page="test4.jsp"></jsp:include> --%>
    <title>Sell/sellAdd</title>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/popup.css" rel="stylesheet" type="text/css">
    <%-- <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> --%>
<%--     <link href="${pageContext.request.contextPath}/resources/css/daterange.css" rel="stylesheet" type="text/css"> --%>
<%--  <link href="${pageContext.request.contextPath}/resources/css/sell.css" rel="stylesheet" type="text/css"> --%>
 
</head>

<!------------------------------------------------------- 헤더 ---------------------------------------------------->

<!---------------------------------------------------- 상단 조회 및 버튼 ----------------------------------------------------->
<body>
<div class="popupContainer">
<h1>수주 등록</h1>
<div class="horizontal-line"></div>
    <form action="${pageContext.request.contextPath}/sell/sellAddPro" id="popup" class="popup"  method="post" onsubmit="checkForm()" >

       <!--  <label class="popupLabel">수주 코드 : </label>
      	<input type="text" id="sellCode" name="selCode" required="required" ><br> -->
      	
      	<div class="popupSerch">
        <label class="popupLabel">거래처 : </label>
        <input type="text" id="clientCode9999" name="clientCode" onclick=searchItem('client','clientCode9999'); placeholder="거래처 코드" readonly >
        <input type="text" id="clientCompany9999" placeholder="거래처명" onclick=searchItem('client','clientCode9999'); readonly ><br>
		</div>
		
		<div class="popupSerch">
 		<label class="popupLabel">제품 : </label>
 		<input type="text" name="prodCode" id="prodCode9999" onclick=searchItem('prod','prodCode9999'); placeholder="제품코드" readonly>
		<input type="text" name="prodName" id="prodName9999" placeholder="제품명" readonly onclick="searchItem('prod','prodCode9999')"><br>
		</div>
		
        <label class="popupLabel">수주 수량 : </label>
        <input type="number" id="sellCount" name="sellCount" min="0" max="10000" step="5">개<br>
	
 	    <label class="popupLabel">수주 단가 : </label>
        <input type="number" id="sellPrice"  min="0" >원<br> 
        
     <label class="popupLabel">수주 일자 : </label>
        <input type="text" id="sellDate" name="sellDate" readonly><br> 

        <label class="popupLabel">납기 일자 : </label>
        <input type="text" id="sellDuedate" name="sellDuedate" readonly><br>

        <label class="popupLabel">담당자 : </label>
        <input type="search" id="sellEmpId" name="sellEmpId" value="${sessionScope.sellEmpId}" readonly="readonly" ><br>

        <label class="popupLabel">비고 : </label><br>
        <textarea id="sellMemo" name="sellMemo" style="width: 400px; height: 150px;"></textarea><br>

        <label class="popupLabel">첨부파일 : </label>
        <input type="file" id="sellFile" name="sellFile"><br>
		
		<br>
        <button type="submit" >등록</button>
        <button type="reset">취소</button>
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

// 유효성 검사
function checkForm() {
    // 각 입력 필드 값
    var clientCode = document.getElementById("clientCode").value;
    var prodCode = document.getElementById("prodCode").value;
    var sellCount = document.getElementById("sellCount").value;
   /*  var sellDate = document.getElementById("sellDate").value; */
    var sellDuedate = document.getElementById("sellDuedate").value;
    var sellEmpId = document.getElementById("sellEmpId").value;
    // 빈 필드 검사
    if (clientCode === "" || prodCode === "" || sellCount === "" ||
    		/* sellDate === "" || */ sellDuedate === "" || sellEmpId === "") {
        alert("모든 내용을 입력해주세요");
        return false; // 제출 방지
    } // 추가 유효성 검사
    if (sellCount == 0 || sellPrice ==0) {
        alert("모든 내용을 입력해주세요");
        return false; // 제출 방지
    }
    return true;
}
</script>


</body>
</html>