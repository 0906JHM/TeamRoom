<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!-- head -->
<head>
<meta charset="UTF-8"> 
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>

<!-- javascript -->
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
<h1>품목관리</h1>

<!-- form(검색) -->
<form action="${pageContext.request.contextPath}/Rawmaterials/list" method="get">
원자재코드	<input type="text" name="a1" placeholder="원자재코드">
원자재명	<input type="text" name="a2" placeholder="원자재명">
종류		<select name="a3">
		<option value="">선택</option>
		<option value="향기">향기</option>
		<option value="용기">용기</option>
		<option value="스틱">스틱</option>
		<option value="라벨">라벨</option>
		<option value="포장재">포장재</option>
		</select>
거래처		<input type="text" name="a6" placeholder="거래처">
<input type="submit" value="검색">
</form>

<!-- table -->
<table border="1">
<tr>
<td>번호</td>
<td>원자재코드</td>
<td>원자재명</td>
<td>종류</td>
<td>단위</td>
<td>매입단가</td>
<td>거래처</td>
<td>창고명</td>
<td>비고</td>
<td></td>
</tr>

<c:forEach var="rawmaterialsDTO" items="${rawmaterialsList}">
<tr>
<td></td>
<td><a href="#" onclick="openPopup2('${pageContext.request.contextPath}/Rawmaterials/detail?a1=${rawmaterialsDTO.a1}')">${rawmaterialsDTO.a1}</a></td>
<%-- <td><a href="${pageContext.request.contextPath}/Rawmaterials/detail?a1=${rawmaterialsDTO.a1}">${rawmaterialsDTO.a1}</a></td> --%>
<td>${rawmaterialsDTO.a2}</td>
<td>${rawmaterialsDTO.a3}</td>
<td>${rawmaterialsDTO.a4}</td>
<td>${rawmaterialsDTO.a5}</td>
<td>${rawmaterialsDTO.a6}</td>
<td>${rawmaterialsDTO.a7}</td>
<td>${rawmaterialsDTO.a8}</td>
<td><input type="checkbox" name="RowCheck" value="${rawmaterialsDTO.a1}"></td>
</tr>
</c:forEach>
</table>

<!-- button -->
<%-- <input type="button" value="추가" onclick="location.href='${pageContext.request.contextPath}/Rawmaterials/insert'"> --%>
<input type="button" value="추가" onclick="openPopup1()">
<input type="button" value="삭제" onclick="deleteValue();">

</body>
</html>
