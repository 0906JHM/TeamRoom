<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<%--     <jsp:include page="test4.jsp"></jsp:include> --%>
    <title>Sell/sellMemo.jsp</title>
    <%-- <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> --%>
<%--     <link href="${pageContext.request.contextPath}/resources/css/daterange.css" rel="stylesheet" type="text/css"> --%>
<%--  <link href="${pageContext.request.contextPath}/resources/css/sell.css" rel="stylesheet" type="text/css"> --%>
<link href="${pageContext.request.contextPath}/resources/css/popup.css" rel="stylesheet" type="text/css">


</head>

<!---------------------------------------------------- 상단 조회 및 버튼 ----------------------------------------------------->
<body>

<div class="popupContainer">
    <h1>수주 비고</h1>
    <div class="horizontal-line"></div>
    <form class="popup">
		<textarea id="sellMemo" readonly="readonly" style="width: 350px; height: 250px;">${sellDTO.sellMemo}</textarea><br>
		<input type="hidden" name="sellCode" value="${sellDTO.sellCode}" />
		
		<c:if test="${sessionScope.id == sellDTO.sellEmpId}">
		<button type="button" onclick="location.href='${pageContext.request.contextPath}/sell/sellMemotype?sellCode=${sellDTO.sellCode}&memotype=modify'">수정</button>
        </c:if>
        <button type="button" onclick="window.close()">닫기</button>
    </form>
</div>
<!---------------------------------------------- javascript ---------------------------------------------->

<!----------------------------------------------- 확인 버튼 ---------------------------------------------->

	


</body>
</html>