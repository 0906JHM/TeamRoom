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
	
<form name ="update"  action="${pageContext.request.contextPath}/stock/updatePro" method="post">
  <table border="1">
      <tbody>
		<tr>
		    <td>제품 코드</td>
			<td>원자재 코드</td>
			<td>창고 코드</td>
			<td>재고 개수</td>
		</tr>
		 <tr>
		        <td>${stockDTO.prodCode }</td>
				<td>${stockDTO.rawCode }</td>
				<td>${stockDTO.whseCode }</td>
				<td ><input type="number"  id="newCount" name="newCount" min="0" value="${stockDTO.stockCount }"></td> 
	     </tr> 
</table>

<input type="submit" value="수정" class="btn">

</form>



</body>
</html>