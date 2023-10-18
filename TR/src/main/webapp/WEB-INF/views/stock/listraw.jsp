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

//수정
function newTabUpdate() {
	var list = $("input[name='RowCheck']");
	var ch = '';
	for(var i = 0; i < list.length; i++){
		if(list[i].checked) { 
		ch = list[i].value;
		}
	}
	window.open("${pageContext.request.contextPath}/stock/updateR?stockNum="+ch, "수정",  "location=0,status=1,scrollbars=1,resizable=1,menubar=0,toolbar=no,width=600,height=500");
}

$(document).ready(function() {
	var refreshAndClose = true; // refreshAndClose 값을 변수로 설정
    if (refreshAndClose) {
        window.opener.location.reload(); // 부모창 새로고침
        window.close(); // 현재창 닫기
    }
});


$(function(){
	var chkObj = document.getElementsByName("RowCheck");
	var rowCnt = chkObj.length;
			
	$("input[name='allCheck']").click(function(){
		var chk_listArr = $("input[name='RowCheck']");
		for (var i=0; i<chk_listArr.length; i++){
			chk_listArr[i].checked = this.checked;
		}
	});
		
	$("input[name='RowCheck']").click(function(){
		if($("input[name='RowCheck']:checked").length == rowCnt){
			$("input[name='allCheck']")[0].checked = true;
		}
		else{
			$("input[name='allCheck']")[0].checked = false;
		}
	});
});

</script>
	                                            
<jsp:include page = "../inc/side.jsp"></jsp:include>
</head>
<body>
<div class="container">
      <h2>재고 관리</h2>
      <hr>
      <div id="searchform">
      <form action="${pageContext.request.contextPath}/stock/listraw" method="get"  id="selected">
      <label>제품코드</label> <input type="text" name="search1" placeholder="제품코드">
      <label>원자재코드</label> <input type="text" name="search2" placeholder="원자재코드">
      <label>창고코드</label> <input type="text" name="search3" placeholder="창고코드">
      <button type="submit">조회</button>
      </form>
      </div>
      <hr>
      
<div class="buttons"> 
     <button onclick="newTabUpdate()">수정</button>   
     </div>  
     
     	<div style="margin-left: 1%; margin-bottom: 1%">
		<a href="${pageContext.request.contextPath}/stock/listraw"><input type="button" value="원자재" class="B B-info" style="background-color: #EFEFEF; color: #73879c; width: 8%; font-weight: 500; font-size: 15px"></input></a>
	    <a href="${pageContext.request.contextPath}/stock/listpro"><input type="button" value="완제품" class="B B-info" style="background-color: #EFEFEF; color: #73879c; width: 8%; font-weight: 500; font-size: 15px"></input></a>
	    </div>
     
      <h3 style="padding-left:1%;">목록 <small>총 ${pageDTO.count}건</small></h3>
      
<div id="list">    
      <table  class="tab" id="stockTable">
      <thead>
		<tr>
		    <th class="bt1"></th>
			<th>유형</th>
			<th>원자재 코드</th>
			<th>창고 코드</th>
			<th>재고 개수</th>
			<th>재고 비고</th>
		</tr>
        </thead>
        <tbody>
		<c:forEach var="stockDTO" items="${stockListR}">
			<tr>
			    <td><input type="checkbox" name="RowCheck" value="${stockDTO.stockNum}"  class="bt1"></td>
				<td>${stockDTO.stockType }</td>
				<td>${stockDTO.rawCode }</td>
				<td>${stockDTO.whseCode }</td>
				<td>${stockDTO.stockCount }</td>
				<td>${stockDTO.stockMemo }</td>
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