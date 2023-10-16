<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재고 수정</title>
</head>
	
<body>
	<h1>재고 수정</h1>
	
<form  action="${pageContext.request.contextPath}/stock/updatePro" method="post">
  <table border="1">
      <tbody>
		<tr>
		    <td>제품 코드</td>
			<td>원자재 코드</td>
			<td>창고 코드</td>
			<td>재고 개수</td>
		</tr>
		 <tr>
		        <td><input type="text" name="prodCode" value="${stockDTO.prodCode }" readonly></td>
				<td><input type="text" name="rawCode" value="${stockDTO.rawCode }" readonly></td>
				<td><input type="text" name="whseCode" value="${stockDTO.whseCode }" readonly></td>
				<td ><input type="number"   name="stockCount" min="0" value="${stockDTO.stockCount }"></td> 
	     </tr> 
</table>

<input type="submit" value="수정" >

</form>



</body>
</html>