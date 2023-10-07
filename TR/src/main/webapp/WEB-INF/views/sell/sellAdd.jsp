<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<%--     <jsp:include page="test4.jsp"></jsp:include> --%>
    <title>Sell/sellAdd</title>
    <%-- <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> --%>
<%--     <link href="${pageContext.request.contextPath}/resources/css/daterange.css" rel="stylesheet" type="text/css"> --%>
<%--  <link href="${pageContext.request.contextPath}/resources/css/sell.css" rel="stylesheet" type="text/css"> --%>
<link href="${pageContext.request.contextPath}/resources/css/popup.css" rel="stylesheet" type="text/css">


</head>

<!------------------------------------------------------- 헤더 ---------------------------------------------------->

<!---------------------------------------------------- 상단 조회 및 버튼 ----------------------------------------------------->
<body>
<div class="popupContainer">
<h1>수주 등록</h1>
<div class="horizontal-line"></div>
    <form action="${pageContext.request.contextPath}/sell/sellAddPro" id="popup" class="popup"  method="post" onsubmit="checkForm()">
        <label class="popupLabel">수주 코드 : </label>
      		<input type="text" id="sellCode" required="required" name="selCode"><br>

        <label class="popupLabel">거래처 코드 : </label>
        	<select class="popupSelect" required="required" name="clientCode">
        		<option value="선택">선택</option> 
        		<option value="선택">kyobo042</option> 
        		<option value="선택">kyobo054</option> 
        		<option value="선택">	olive051</option> 
        		<option value="선택">olive042</option> 
        		
         <%-- <c:forEach items="${clientCodes}" var="clientCode">
            <option value="${clientCode}">${clientCode}</option>
        </c:forEach> --%>
    		</select><br>
        

        <label class="popupLabel">제품 코드 : </label>
      		<select class="popupSelect" required="required" name="prodCode">
      			<option value="선택">선택</option>
        		<option value="선택">rose250</option> 
        		<option value="선택">woody250</option> 
        		<option value="선택">woody500</option> 
        		<option value="선택">	orange500</option>
        	</select><br>

        <label class="popupLabel">제품명 : </label>
       		<select class="popupSelect" required="required" name="prodName">
       			<option value="선택">선택</option>
        		<option value="선택">rose250ml</option> 
        		<option value="선택">woody250ml</option> 
        		<option value="선택">woody500ml</option> 
        		<option value="선택">	orange500ml</option>
        	</select><br>

       <!--  <label class="popupLabel">수주 단가 : </label>
        <input type="number" id="sellPrice" min="1" required="required" >원<br> -->

        <label class="popupLabel">수주 수량 : </label>
        <input type="number" id="sellCount" min="1" max="1000" required="required" name="sellCount"><br>

        <label class="popupLabel">수주 일자 : </label>
        <input type="date" id="sellDate" required="required" name="sellDate"><br>

        <label class="popupLabel">납기 일자 : </label>
        <input type="date" id="sellDuedate" required="required" onselect="dateCheck()" name="sellDuedate"><br>

        <label class="popupLabel">담당자 : </label>
        <input type="search" id="sellEmpId" readonly="readonly" value="${sessionScope.sellEmpId}" name="sellEmpId"><br>
    			
        <label class="popupLabel">비고 : </label>
        <textarea id="sellMemo" style="width: 350px; height: 250px;" name="sellMemo"></textarea><br>

        <label class="popupLabel">첨부파일 : </label>
        <input type="file" id="sellFile" name="sellFile"><br>

        <button type="submit" >등록</button>
        <button type="reset">취소</button>
        <button type="button" onclick="dbclose()">닫기</button>
    
				</form>

</div>
<!--  ************************************************ javaScript *************************************************************-->

<!----------------------------------------------- 등록버튼 ---------------------------------------------->
<!-- <script type="text/javascript">
function dateCheck() {
    var sellDateInput = document.getElementById("sellDate");
    var sellDuedateInput = document.getElementById("sellDuedate");
    
    var sellDate = new Date(sellDateInput.value);
    var sellDuedate = new Date(sellDuedateInput.value);
    
    // 납기 일자가 수주 일자보다 이른 경우
	if (sellDuedate < sellDate) {
			alert("납기 일자는 수주 일자보다 이른 날짜일 수 없습니다.");
			sellDuedateInput.value = ""; // 값을 초기화
			return;
		} else {
			window.close();
		}
	}
</script> -->
 <script>
        function checkForm() {
        	alert("메시지");
            var form = document.getElementById("popup");
            var isValid = form.checkValidity();

            if (!isValid) {
                alert("필수 항목을 모두 입력하세요.");
            }

           
        }
    </script>
<!----------------------------------------------- 닫기 버튼 ---------------------------------------------->
<script type="text/javascript">
		function dbclose() {
			// 수주 등록 로직을 추가하세요.
			// 이 함수에서 입력된 데이터를 서버에 전송하거나 처리할 수 있습니다.
			/*  alert('수주가 등록되었습니다.'); */
			window.close();
		}
	</script>


</body>
</html>