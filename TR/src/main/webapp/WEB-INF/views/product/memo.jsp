<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/popup.css" rel="stylesheet" type="text/css">


</head>

<body>

<div class="popupContainer">
    <h1>비고</h1>
    <div class="horizontal-line"></div>
    <form class="popup">
		<textarea id="prodMemo" style="width: 350px; height: 250px;" readonly="readonly">${prodDTO.prodMemo}</textarea><br>
		<input type="hidden" name="ProdCode" value="${prodDTO.prodCode}" />
		
		<button type="button" onclick="location.href='${pageContext.request.contextPath}/product/memotype?prodCode=${prodDTO.prodCode}&memotype=modify'">수정</button>
        <button type="button" onclick="window.close()">닫기</button>
    </form>
</div>



</body>
</html>