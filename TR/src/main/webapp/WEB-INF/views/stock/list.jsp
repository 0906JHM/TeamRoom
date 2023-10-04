<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>list.jsp</title>
<link href="${pageContext.request.contextPath }/resources/css/stock.css"
	rel="stylesheet" type="text/css">
</head>
<body>
<div class="container">
     <jsp:include page = "../inc/side.jsp"></jsp:include>
<div class="content">
      <h2>재고 관리</h2>
      <div class="horizontal-line"></div>
      <form>
      <label>제품 코드</label> <input type="text">
      <label>원자재 코드</label> <input type="text">
      <label>창고 코드</label> <input type="text">
      <br>
      
      <button id="search" type="submit" onclick="">조회</button>
      <button id="add"  onclick="newTabAdd()">추가</button>
	  <button id="update" type="submit" onclick="">수정</button>
	  <button id="delete" >삭제</button>
	  <button id="cancel">취소</button>
      <button id="save">저장</button>
      
      </form>
      
      <table class="tg" id="stockTable">
      <tbody>
		<tr>
			<td class="tg-llyw">제품 코드</td>
			<td class="tg-llyw">재고 개수</td>
			<td class="tg-llyw">원자재 코드</td>
			<td class="tg-llyw">창고 코드</td>
		</tr>

		<c:forEach var="stockDTO" items="${boardList}">
			<tr>
				<td class="tg-llyw2">${stockDTO.prodCode }</td>
				<td class="tg-llyw2">${stockDTO.whseCount }</td>
				<td class="tg-llyw2">${stockDTO.rawCode }</td>
				<td class="tg-llyw2">${stockDTO.whseCode }</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
</div>

	<script>
	 function newTabAdd() {
          window.open('http://localhost:8080/tr/stock/write', '추가', 'width=700px,height=800px,scrollbars=yes');
     }
	</script>
	
	


</body>
</html>