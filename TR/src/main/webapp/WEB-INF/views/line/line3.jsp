<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>라인수정</title>
</head>
<body>
<h1>라인수정</h1>
<form action="${pageContext.request.contextPath}/line/updatePro" id="join" method="post">

라인코드:<input type="text" name="lineCode" class="lineCode" value="${lineDTO.lineCode}"><br>
라인명:<input type="text" name="lineName" class="lineName" value="${lineDTO.lineName}"><br>
사용여부:<input type="text" name="lineUse" class="lineUse" value="${lineDTO.lineUse}"><br>
등록자:<input type="text" name="lineEmpId" class="lineEmpId" value="${lineDTO.lineEmpId}"><br>
등록일:<input type="date" name="lineInsertDate" class="lineInsertDate" value="${lineDTO.lineInsertDate}"><br>
공정:<input type="text" name="lineProcess" class="lineProcess" value="${lineDTO.lineProcess}"><br>
<button onclick="save">수정하기</button>

</form>

</body>
</html>