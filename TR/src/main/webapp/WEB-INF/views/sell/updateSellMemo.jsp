<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<%--     <jsp:include page="test4.jsp"></jsp:include> --%>
    <title>Sell/updateSellMemo.jsp</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<%--     <link href="${pageContext.request.contextPath}/resources/css/daterange.css" rel="stylesheet" type="text/css"> --%>
<%--  <link href="${pageContext.request.contextPath}/resources/css/sell.css" rel="stylesheet" type="text/css"> --%>
<link href="${pageContext.request.contextPath}/resources/css/popup.css" rel="stylesheet" type="text/css">


</head>

<!---------------------------------------------------- 상단 조회 및 버튼 ----------------------------------------------------->
<body>

<div class="popupContainer">
    <h1>수주 비고 수정</h1>
    <div class="horizontal-line"></div>
    <form class="popup" method="post" action="${pageContext.request.contextPath}/sell/sellMemoAddPro">
		<textarea id="sellMemo" style="width: 350px; height: 250px;" name="sellMemo" >${sellDTO.sellMemo}</textarea><br>
		<input type="hidden" name="sellCode" value="${sellDTO.sellCode}" />
		
		<button type="submit" >수정</button>		
		<!-- <button type="reset">취소</button> -->
        <button type="button" onclick="window.close();">닫기</button>
    </form>
</div>
<!---------------------------------------------- javascript ---------------------------------------------->
<script type="text/javascript">
$(document).ready(function () {
	//--------------------------------------------------- 페이지 권한 ----------------------
                
/*--------------------------------- 페이지 권한 ----------------------------------------  */
    var team = "${sessionScope.empDepartment }"; // 팀 조건에 따라 변수 설정
		
    if (team === "" || (team !== "관리자" && team !== "영업팀")) {
        // 창을 닫습니다.
        window.close(); // 이 코드는 창을 닫으려고 시도합니다.
        // 또는 에러 페이지로 리디렉션할 수 있습니다.
        // window.location.href = "${pageContext.request.contextPath}/error";
    }
}
</script>

	


</body>
</html>