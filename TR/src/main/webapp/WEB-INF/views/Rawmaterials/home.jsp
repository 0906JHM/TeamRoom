<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!-- head -->
<head>
<meta charset="UTF-8"> 
<title>Insert title here</title>

<!-- css -->
<link href="${pageContext.request.contextPath}/resources/css/side.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/Rawmaterials.css" rel="stylesheet" type="text/css">

<!-- javascript --> 
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<script type="text/javascript">

// 체크박스로 삭제
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
		alert("선택된 원자재가 없습니다.");
	}
	else{
		var chk = confirm("정말 삭제하시겠습니까?");
        if(chk) {				 
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
	            	    location.replace("home")
	        	    }
	                else{
	            	    alert("삭제 실패");
	                }
	   		    }
		    });
        } else {
            alert("삭제 실패");
        }
	}
}

// insert 페이지 팝업창
function openPopup1() {
    window.open('${pageContext.request.contextPath}/Rawmaterials/insert', '_blank', 'height=400,width=600');
}

// detail 페이지 팝업창
function openPopup2(url) {
	const myWindow = window.open(url, "DetailPopup", "location=0,status=1,scrollbars=1,resizable=1,menubar=0,toolbar=no,width=400,height=700");
	myWindow.moveTo(0, 0);
	myWindow.focus();
}

// memo 페이지 팝업창
function openPopup4(rawCode) {
	// 팝업창 속성
	var popupWidth = 450;
	var popupHeight = 500;
	var left = (window.innerWidth - popupWidth) / 2;
	var top = (window.innerHeight - popupHeight) / 2;
	var popupFeatures = 'width=' + popupWidth + ',height=' + popupHeight + ',left=' + left + ',top=' + top + ',resizable=yes,scrollbars=yes';
	// 새창을 열기 위한 URL 설정
	var url = '${pageContext.request.contextPath}/Rawmaterials/memo?rawCode=' + rawCode;
	// 팝업창 열고 속성 설정
	var newWindow = window.open(url, '_blank', popupFeatures);       
}

// 팝업창에서 작업 완료후 닫고 새로고침
$(document).ready(function() {
	var refreshAndClose = true; // refreshAndClose 값을 변수로 설정
    if (refreshAndClose) {
        window.opener.location.reload(); // 부모창 새로고침
        window.close(); // 현재창 닫기
    }
});
</script>
</head>

<!-- body -->
<body>
<jsp:include page="../inc/side.jsp"></jsp:include>

<div id="content">
<h2>원자재 관리</h2>
<hr>

<!-- form(검색) -->
<div id="searchForm">
<form action="${pageContext.request.contextPath}/Rawmaterials/home" method="get">
<label>원자재코드</label>	<input type="text" name="search1" placeholder="원자재코드">
<label>원자재명</label>		<input type="text" name="search2" placeholder="원자재명">
<label>종류</label>		<select name="search3">
						<option value="">전체</option>
						<option value="향기">향기</option>
						<option value="용기">용기</option>
						<option value="스틱">스틱</option>
						<option value="라벨">라벨</option>
						<option value="포장재">포장재</option>
						</select>
<input type="submit" value="조회">
</form>
</div>
<hr>

<!-- button -->
<div id="buttons">
<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자')}">
<input type="button" value="추가" onclick="openPopup1()">
<input type="button" value="삭제" onclick="deleteValue();">
</c:if>
</div>

<!-- table -->
<table id="rawmaterialsList">
<thead>
<tr>
<td>번호</td>
<td>원자재코드</td>
<td>원자재명</td>
<td>종류</td>
<td>단위</td>
<td>매입단가</td>
<td>창고명</td>
<td>창고수량</td>
<td>비고</td>
<td></td>
</tr>
</thead>

<tbody>
<c:forEach var="rawmaterialsDTO" items="${rawmaterialsList}">
<tr>
<td>${rawmaterialsDTO.rawNum}</td>
<td><a href="#" onclick="openPopup2('${pageContext.request.contextPath}/Rawmaterials/detail?rawCode=${rawmaterialsDTO.rawCode}')">${rawmaterialsDTO.rawCode}</a></td>
<td>${rawmaterialsDTO.rawName}</td>
<td>${rawmaterialsDTO.rawType}</td>
<td>${rawmaterialsDTO.rawUnit}</td>
<td>${rawmaterialsDTO.rawPrice}</td>
<td>${rawmaterialsDTO.whseCode}</td>
<td>${rawmaterialsDTO.whseCount}</td>

<!-- 비고기능 -->
<td><c:choose>
<c:when test="${not empty rawmaterialsDTO.rawMemo}">
<a href="#" onclick="openPopup4('${rawmaterialsDTO.rawCode}');" style="color:black;">[보기]</a>
</c:when>
<c:otherwise>
<c:set var="rawMemo" value="" />
</c:otherwise>
</c:choose></td>

<!-- 체크박스로 삭제 -->
<td><input type="checkbox" name="RowCheck" value="${rawmaterialsDTO.rawCode}"></td>
</tr>
</c:forEach>
</tbody>
</table>
</div>

<!-- 페이징처리 -->
<c:forEach var="i" begin="${pageDTO.startPage}" end="${pageDTO.endPage}" step="1">
<a href="${pageContext.request.contextPath}/Rawmaterials/home?pageNum=${i}&search1=${pageDTO.search1}">${i}</a> 
</c:forEach>

</body>
</html>