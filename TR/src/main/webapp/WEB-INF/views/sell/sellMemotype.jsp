<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<%--     <jsp:include page="test4.jsp"></jsp:include> --%>
    <title>Sell/SellMemoAdd.jsp</title>
    <%-- <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> --%>
<%--     <link href="${pageContext.request.contextPath}/resources/css/daterange.css" rel="stylesheet" type="text/css"> --%>
<%--  <link href="${pageContext.request.contextPath}/resources/css/sell.css" rel="stylesheet" type="text/css"> --%>
<link href="${pageContext.request.contextPath}/resources/css/popup.css" rel="stylesheet" type="text/css">


</head>
<%
String memotype = request.getParameter("memotype");

%>
<!---------------------------------------------------- 상단 조회 및 버튼 ----------------------------------------------------->
<body>

<div class="popupContainer">

 <c:choose>
         <c:when test="${memotype == 'add'}">
            <h1>수주 비고 등록</h1>
    <div class="horizontal-line"></div>
     <form class="popup" method="post" action="${pageContext.request.contextPath}/sell/sellMemotypePro">
		<textarea id="sellMemo" style="width: 350px; height: 250px;" name="sellMemo"></textarea><br>
		<input type="hidden" name="sellCode" value="${sellDTO.sellCode}" />
		<button type="submit" >등록</button>		
		<!-- <button type="reset">취소</button> -->
		<button type="button" onclick="window.close();">닫기</button>
</form>
        </c:when>
        <c:otherwise>
            <h1>수주 비고 수정</h1>
    <div class="horizontal-line"></div>
        <form class="popup" method="post" action="${pageContext.request.contextPath}/sell/sellMemoUpdatePro">
		<textarea id="sellMemo" style="width: 350px; height: 250px;" name="sellMemo" >${sellDTO.sellMemo}</textarea><br>
		<input type="hidden" name="sellCode" value="${sellDTO.sellCode}" />
		<button type="submit" >저장</button>		
		<button type="reset">취소</button>
        <button type="button" onclick="window.close();">닫기</button>
        </form>
            
        </c:otherwise>
    </c:choose>
    
   
</div>
<!---------------------------------------------- javascript ---------------------------------------------->
<script type="text/javascript">

</script>



	


</body>
</html>