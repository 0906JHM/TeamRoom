<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재고관리</title>
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/side.css" 
    rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath }/resources/css/stock.css" 
    rel="stylesheet" type="text/css">
    
<script type="text/javascript">

	 function newTabUpdate(stockNum) {
     window.open("${pageContext.request.contextPath}/stock/update?stockNum=" + stockNum, "수정",  "top=60,left=140,width=977,height=377, location=no");
 }
	 
	 $(document).ready(function(stockNum) {
			var refreshAndClose = true; // refreshAndClose 값을 변수로 설정
		    if (refreshAndClose) {
		        window.opener.location.reload(); // 부모창 새로고침
		        window.close(); // 현재창 닫기
		    }
	 });
</script>
	
<jsp:include page = "../inc/side.jsp"></jsp:include>
</head>
<body>
<div class="container">
      <h2>재고 관리</h2>
      <hr>
      <div id="searchform">
      <form action="${pageContext.request.contextPath}/stock/list" method="get"  id="selected">
      <label>제품코드</label> <input type="text" name="search1" placeholder="제품코드">
      <label>원자재코드</label> <input type="text" name="search2" placeholder="원자재코드">
      <label>창고코드</label> <input type="text" name="search3" placeholder="창고코드">
      <button type="submit">조회</button>
      </form>
      </div>
      <hr>
      <br>
      <h3 style="padding-left:1%;">목록 <small>총 ${pageDTO.count}건</small></h3>
<div id="list">    
      <table id="stockTable">
      <thead>
		<tr>
			<th>제품 코드</th>
			<th>원자재 코드</th>
			<th>창고 코드</th>
			<th>재고 개수</th>
			<th> </th>
		</tr>
        </thead>
        <tbody>
		<c:forEach var="stockDTO" items="${boardList}">
			<tr>
				<td>${stockDTO.prodCode }</td>
				<td>${stockDTO.rawCode }</td>
				<td>${stockDTO.whseCode }</td>
				<td>${stockDTO.stockCount }</td>
				<td>
				<input type="button" onclick="newTabUpdate(${stockDTO.stockNum})" value="수정">
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>  	

	<div class="page">
<c:if test="${pageDTO.startPage > pageDTO.pageBlock}">
	<a href="${pageContext.request.contextPath}/stock/list?pageNum=${pageDTO.startPage - pageDTO.pageBlock}">Prev</a>
</c:if>

<c:forEach var="i" begin="${pageDTO.startPage}" 
                   end="${pageDTO.endPage}" step="1">
<a href="${pageContext.request.contextPath}/stock/list?pageNum=${i}">${i}</a> 
</c:forEach>

<c:if test="${pageDTO.endPage < pageDTO.pageCount}">
	<a href="${pageContext.request.contextPath}/stock/list?pageNum=${pageDTO.startPage + pageDTO.pageBlock}">Next</a>
</c:if>

</div>
</div>	
</body>
</html>