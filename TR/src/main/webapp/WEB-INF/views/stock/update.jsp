<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>글수정(로그인 : ${sessionScope.id })</h1>
<form action="${pageContext.request.contextPath}/stock/updatePro" method="post">
<table border="1">
<tr><td>제품코드</td>
<td><input type="text" name="name" value="${stockDTO.prodCode}" readonly></td></tr>
<tr><td>원자재코드</td>
    <td><input type="text" name="subject" value="${stockDTO.rawCode}"></td></tr>
<tr><td>창고코드</td>
<td><input type="text" value ="${stockDTO.whseCode}" readonly></td></tr>
<tr><td>재고개수</td>
<td><input type="text" value ="${stockDTO.whseCount}" ></td></tr>
<tr><td colspan="2"><input type="submit" value="글수정"></td></tr>    
</table>
</form>

</body>
</html>