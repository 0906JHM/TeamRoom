<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>창고 관리</title>
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/side.css" 
    rel="stylesheet" type="text/css">
 <jsp:include page = "../inc/side.jsp"></jsp:include>   
 
 <!-- javascript -->
<script type="text/javascript">

// 추가
function newTabInsert() {
    window.open("${pageContext.request.contextPath}/Warehouse/write", "추가",  "top=80,left=140,width=977,height=450, location=no");
}

// 수정
function newTabUpdate() {
	var list = $("input[name='RowCheck']");
	var ch = '';
	for(var i = 0; i < list.length; i++){
		if(list[i].checked) { 
		ch = list[i].value;
		}
	}
	window.open("${pageContext.request.contextPath}/Warehouse/update?whseCode="+ch, "수정",  "top=80,left=140,width=977,height=450, location=no");
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

// 체크박스로 삭제
function deleteValue(){
	var url = "delete"; // Controller로 보내고자 하는 URL
	var valueArr = new Array();
	var list = $("input[name='RowCheck']");
	
	for(var i = 0; i < list.length; i++){
		if(list[i].checked){ // 선택되어 있으면 배열에 값을 저장함
			valueArr.push(list[i].value);
		}
	}
	
	if (valueArr.length == 0){
		alert("선택된 창고가 없습니다.");
	}
	else{
		var chk = confirm("정말 삭제하시겠습니까?");				 
		$.ajax({
			url : url,             // 전송 URL
			type : 'POST',         // GET or POST 방식
			traditional : true,
			data : {
			valueArr : valueArr    // 보내고자 하는 data 변수설정
			},
	    	success: function(jdata){
	        	if(jdata = 1) {
	        		alert("삭제 성공");
	            	location.replace("list")
	        	}
	            else{
	            	alert("삭제 실패");
	            }
	   		}
		});
	}
}
</script> 
</head>
<body>

<h1>창고 관리</h1>
    <form action="${pageContext.request.contextPath}/Warehouse/list" method="get">
    창고코드 <input type="text" name="search1" placeholder="창고코드">
    제품코드 <input type="text" name="search2" placeholder="제품코드">
    창고이름 <input type="text" name="search3" placeholder="창고이름">
    창고타입 <select name="search4">
                    <option value="">전체</option>
                    <option value="원자재">원자재</option>
		            <option value="완제품">완제품</option>
                </select>
    <input type="submit" value="검색">           
    </form>
    <input type="button" value="추가" onclick="newTabInsert()">
    <input type="button" value="수정" onclick="newTabUpdate()">
    <input type="button" value="삭제" onclick="deleteValue();">
    <br>
    <h3 style="padding-left:1%;">목록 <small>총 ${pageDTO.count}건</small></h3>
    
    <table border="1">
    <tr>
    <td></td>
    <td>창고코드</td>
    <td>창고이름</td>
    <td>창고타입</td>
    <td>창고사용상태</td>
    <td>창고주소</td>
    <td>창고연락처</td>
    <td>제품코드</td>
    <td>원자재코드</td>
    <td>창고관리사원아이디</td>
    <td>재고개수</td>
    <td>창고비고</td>
    </tr>
    
    <c:forEach var="warehouseDTO" items="${warehouseList}">
    <tr>
    <td><input type="checkbox" name="RowCheck" value="${warehouseDTO.whseCode}"></td>
    <td>${warehouseDTO.whseCode}</td>
    <td>${warehouseDTO.whseName}</td>
    <td>${warehouseDTO.whseType}</td>
    <td>${warehouseDTO.whseState}</td>
    <td>${warehouseDTO.whseAddr}</td>
    <td>${warehouseDTO.whseTel}</td>
    <td>${warehouseDTO.prodCode}</td>
    <td>${warehouseDTO.rawCode}</td>
    <td>${warehouseDTO.whseEmpId}</td>
    <td>${warehouseDTO.whseCount}</td>
    <td>${warehouseDTO.whseMemo}</td>
    </tr>
    </c:forEach>
    </table>

<div id="page_control">
<c:if test="${pageDTO.startPage > pageDTO.pageBlock}">
	<a href="${pageContext.request.contextPath}/Warehouse/list?pageNum=${pageDTO.startPage - pageDTO.pageBlock}">Prev</a>
</c:if>

<c:forEach var="i" begin="${pageDTO.startPage}" 
                   end="${pageDTO.endPage}" step="1">
<a href="${pageContext.request.contextPath}/Warehouse/list?pageNum=${i}">${i}</a> 
</c:forEach>

<c:if test="${pageDTO.endPage < pageDTO.pageCount}">
	<a href="${pageContext.request.contextPath}/Warehouse/list?pageNum=${pageDTO.startPage + pageDTO.pageBlock}">Next</a>
</c:if>

</div>
</body>
</html>