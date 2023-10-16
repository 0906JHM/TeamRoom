<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>라인관리</title>
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/side.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/employees.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
//체크박스 선택/해제
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

//삭제기능  
function deleteValue(){
   var url = "delete";    // Controller로 보내고자 하는 URL (.dh부분은 자신이 설정한 값으로 변경해야됨)
   var valueArr = new Array();
   var list = $("input[name='RowCheck']");
   
      for(var i = 0; i < list.length; i++){
         
         if(list[i].checked){ //선택되어 있으면 배열에 값을 저장함
         valueArr.push(list[i].value);
         }
      }
          if (valueArr.length == 0){
             alert("선택된 글이 없습니다.");
          }
          else{
            var chk = confirm("정말 삭제하시겠습니까?");             
            $.ajax({
                url : url,
                type : 'POST',
                traditional : true,
                data : {
                    valueArr : valueArr
                },
                success: function(){
                    location.replace("line");
                }
            });

         }   
}//deleteValue
	
	// 페이지 로드 후 스크립트 실행
	$(document).ready(function() {
	    var refreshAndClose = true; // refreshAndClose 값을 변수로 설정

	    if (refreshAndClose) {
	        window.opener.location.reload(); // 부모창 새로 고침
	        window.close(); // 현재 창 닫기
	    }
	});
</script>

</head>

<body>
<jsp:include page="../inc/side.jsp"></jsp:include>
<form action="${pageContext.request.contextPath}/line/line" method="get">
search    <input type="text" name="search" placeholder="search">
<input type="submit" value="검색" id="btnSell">
</form>
<table id="lineTable">
<tr>
<th>라인코드</th>
<th>라인명</th>
<th>사용여부</th>
<th>등록자</th>
<th>등록일</th>
<th>공정</th>
</tr>
<c:forEach var="lineDTO" items="${lineList }">
<tr onclick="if('${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '생산팀')}' === 'true') { window.open('update?lineCode=${lineDTO.lineCode}', '_blank', 'width=800,height=600'); } else { event.preventDefault(); }">
    <td>${lineDTO.lineCode}</td>
    <td>${lineDTO.lineName}</td>
    <td>${lineDTO.lineUse}</td>
    <td>${lineDTO.lineEmpId}</td>
    <td>${lineDTO.lineInsertDate}</td>
    <td>${lineDTO.lineProcess}</td>
    <c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '생산팀')}">
    <td onclick="event.stopPropagation();"><input type="checkbox" name="RowCheck" value="${lineDTO.lineCode}"></td>
    </c:if>
</tr>
</c:forEach>

</table>
<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '생산팀')}">
<input type="button" value="삭제" onclick="deleteValue();" id="btnSell">
<button onclick="window.open('line2', '_blank', 'width=800,height=600')" id="btnSell">등록</button>
</c:if>

<c:forEach var="i" begin="${pageDTO.startPage}" 
                   end="${pageDTO.endPage}" step="1">
<a href="${pageContext.request.contextPath}/line/line?pageNum=${i}&search=${pageDTO.search}">${i}</a> 
</c:forEach>

</body>
</html>