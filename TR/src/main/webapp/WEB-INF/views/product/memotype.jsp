<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
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
            <h1>제품 비고 등록</h1>
    <div class="horizontal-line"></div>
     <form class="popup" method="post" action="${pageContext.request.contextPath}/product/memotypePro">
		<textarea id="prodMemo" style="width: 350px; height: 250px;" name="prodMemo"></textarea><br>
		<input type="hidden" name="prodCode" value="${prodDTO.prodCode}" />
		<button type="submit" >등록</button>		
		<button type="button" onclick="window.close();">닫기</button>
</form>
        </c:when>
        <c:otherwise>
            <h1>제품 비고 수정</h1>
    <div class="horizontal-line"></div>
        <form class="popup" method="post" action="${pageContext.request.contextPath}/product/memoUpdatePro">
		<textarea id="prodMemo" style="width: 350px; height: 250px;" name="prodMemo" >${prodDTO.prodMemo}</textarea><br>
		<input type="hidden" name="prodCode" value="${prodDTO.prodCode}" />
		<button type="submit" >수정</button>		
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