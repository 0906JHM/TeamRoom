<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인사관리</title>
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/side.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/employees.css" rel="stylesheet" type="text/css">

<script type="text/javascript">

//팝업창 중앙 생성 및 가로,세로 크기
function openCenteredWindow(url) {
    var width = 500;
    var height = 800;
    var left = (screen.width - width) / 2;
    var top = (screen.height - height) / 2 - 50;
    window.open(url, '_blank', 'width=' + width + ',height=' + height + ',left=' + left + ',top=' + top);
}

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

//체크박스로 삭제
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
        alert("선택된 사원이 없습니다.");
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
                        location.replace("employees")
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
	
// 자식 팝업 창 닫고 부모창 새로 고침
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
<div id="con">
<h2>인사 관리</h2>
<hr>
<div id="searchForm">
<form action="${pageContext.request.contextPath}/employees/employees" method="get">
<span class="styled-text">search</span><input type="text" name="search" placeholder="search">
<input type="submit" value="검색" id="btnSell">
</form>
</div>
<hr>
<small>총 ${pageDTO.count}명</small>
    <table id="employeeTable">
    <thead>
        <tr>
<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '인사팀')}">
            <th>사원번호</th>
            <th>비밀번호</th>
</c:if>
            <th>사원명</th>
            <th>부서</th>
            <th>직책</th>
            <th>이메일</th>
            <th>전화번호</th>
            <th>입사일자</th>
            <th>재직구분</th>
<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '인사팀')}">            
            <th></th>
</c:if>            
        </tr>
        </thead>
<c:forEach var="employeesDTO" items="${employeesList }">
<tr onclick="if('${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '인사팀')}' === 'true') { openCenteredWindow('update?empId=${employeesDTO.empId}'); } else { event.preventDefault(); }">
<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '인사팀')}">
    <td>${employeesDTO.empId}</td>
    <td>${employeesDTO.empPass}</td>
</c:if>
    <td>${employeesDTO.empName}</td>
    <td>${employeesDTO.empDepartment}</td>
    <td>${employeesDTO.empPosition}</td>
    <td>${employeesDTO.empEmail}</td>
    <td>${employeesDTO.empTel}</td>
    <td>${employeesDTO.empHiredate}</td>
    <td>${employeesDTO.empState}</td>
    <c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '인사팀')}">
    <td onclick="event.stopPropagation();"><input type="checkbox" name="RowCheck" value="${employeesDTO.empId}"></td>
	</c:if>
</tr>
</c:forEach>    
    </table>
    </div>
    
<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '인사팀')}">    
    <input type="button" value="삭제" onclick="deleteValue();" id="btnSell">
<button onclick="openCenteredWindow('employees2')" id="btnSell">등록</button>
</c:if>

<!-- 페이징 처리 -->
<c:forEach var="i" begin="${pageDTO.startPage}" 
                   end="${pageDTO.endPage}" step="1">
<a href="${pageContext.request.contextPath}/employees/employees?pageNum=${i}&search=${pageDTO.search}">${i}</a> 
</c:forEach>


</body>

</html>
