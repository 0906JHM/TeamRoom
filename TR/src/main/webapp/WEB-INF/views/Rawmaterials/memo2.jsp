<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!-- head -->
<head>
<title>Insert title here</title>
</head>

<!-- body -->
<body>
<h1>비고</h1>

<!-- form -->
<form>
<textarea id="clientMemo" readonly="readonly" style="width:350px; height:250px;">${clientDTO.clientMemo}</textarea><br>
<input type="hidden" name="clientCode" value="${clientDTO.clientCode}"/>
<button type="button" onclick="window.close()">닫기</button>
</form>

</body>
</html>