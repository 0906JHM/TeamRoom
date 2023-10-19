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
<%
// 관리자 또는 영업팀 출고 상세 페이지 열람 가능 게시판 접근 가능
String department = "";
if (session.getAttribute("empDepartment") != null) {
    department = (String) session.getAttribute("empDepartment");
}

// 상수 정의
final String ADMIN_DEPARTMENT = "영업팀";
%>
</head>

<!---------------------------------------------------- 상단 조회 및 버튼 ----------------------------------------------------->
<body>
 <c:choose>
         <c:when test="${!(empty sessionScope.empDepartment)}">
<div class="popupContainer">
    <h1>수주 비고</h1>
    <div class="horizontal-line"></div>
    <form class="popup">
		<textarea id="sellMemo" readonly="readonly" style="width: 350px; height: 250px;">${sellDTO.sellMemo}</textarea><br>
		<input type="hidden" name="sellCode" value="${sellDTO.sellCode}" />
		
		<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '영업팀')}">
		<button type="button" onclick="location.href='${pageContext.request.contextPath}/sell/sellMemotype?sellCode=${sellDTO.sellCode}&memotype=modify'" id="modify" >수정</button>
        </c:if>
        <button type="button" onclick="window.close()">닫기</button>
    </form>
</div>
</c:when>
  <c:otherwise >

		  <input type="text" hidden=""> 
	 
        </c:otherwise>
        
</c:choose>
<!---------------------------------------------- javascript ---------------------------------------------->
<script type="text/javascript">
var department = "<%= department %>";
var ADMIN_DEPARTMENT = "<%= ADMIN_DEPARTMENT %>";
var sellStateButton1 = "전체";
if (department null ) {
		window.location.href = "<%= request.getContextPath() %>/login/login";
}
 </script>



</body>
</html>