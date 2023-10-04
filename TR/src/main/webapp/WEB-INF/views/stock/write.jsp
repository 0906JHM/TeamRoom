<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="${pageContext.request.contextPath}/stock/writePro" method="post">
<table border="1">
<tr><td>제품코드</td>
<td><input type="text" name="prodCode" value="${stockDTO.prodCode}" ></td></tr>
<tr><td>원자재코드</td>
    <td><input type="text" name="rawCode" value="${stockDTO.rawCode}"></td></tr>
<tr><td>창고코드</td>
<td><input type="text"  name="whseCode" value ="${stockDTO.whseCode}" ></td></tr>
<tr><td>재고개수</td>
<td><input type="text"  name = "whseCount" value ="${stockDTO.whseCount}" ></td></tr> 
<tr><td colspan="2"><input type="submit" value="추가"></td></tr>    
</table>
</form>

</body>
</html>