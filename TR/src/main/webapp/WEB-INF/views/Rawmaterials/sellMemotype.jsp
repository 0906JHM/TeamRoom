<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<!-- head -->
<head>
<title>Insert title here</title>
</head>

<!-- body -->
<body>

<!-- 비고등록 -->
<c:when test="${memotype==add}">
<h1>비고등록</h1>
<form class="popup" method="post" action="${pageContext.request.contextPath}/Rawmaterials/sellMemotypePro">
<textarea id="rawMemo" style="width: 350px; height: 250px;" name="rawMemo"></textarea><br>
<input type="hidden" name="rawCode" value="${rawmaterialsDTO.rawCode}" />
<button type="submit" >등록</button>		
<button type="reset">취소</button>
</form>
</c:when>

<!-- 비고수정 -->
<c:otherwise>
<h1>비고수정</h1>
<form class="popup" method="post" action="${pageContext.request.contextPath}/Rawmaterials/sellMemotypePro">
<textarea id="rawMemo" style="width: 350px; height: 250px;" name="rawMemo" >${rawmaterialsDTO.rawMemo}</textarea><br>
<input type="hidden" name="rawCode" value="${rawmaterialsDTO.rawCode}" />
<button type="submit" >수정</button>		
<button type="reset">취소</button>
<button type="button" onclick="window.close();">닫기</button>
</form>
</c:otherwise>
  
</body>
</html>