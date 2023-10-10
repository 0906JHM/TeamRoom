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

<style>
    /* 테이블 스타일 */
    #employeeTable {
        border-collapse: collapse;
        width: 50%;
    }

    #employeeTable th,
    #employeeTable td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
    }

    #employeeTable th {
        background-color: #f2f2f2;
    }

    /* 행 선택 스타일 */
    #employeeTable tr:hover {
        background-color: #f5f5f5;
    }

    /* 체크박스 스타일 */
    input[type="checkbox"] {
        transform: scale(1.5); /* 체크박스 크기 조정 */
    }

    /* 테이블 바깥 여백 조정 */
    .table-container {
        margin: 20px;
    }
</style>

<!-- javascript -->
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
                    location.replace("employees");
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
<form action="${pageContext.request.contextPath}/employees/employees" method="get">
search    <input type="text" name="search" placeholder="search">
<input type="submit" value="검색">
</form>
    <table id="employeeTable">
        <tr>
            <th>사원번호</th>
            <th>비밀번호</th>
            <th>사원명</th>
            <th>부서</th>
            <th>직책</th>
            <th>이메일</th>
            <th>전화번호</th>
            <th>입사일자</th>
            <th>재직구분</th>
        </tr>
<c:forEach var="employeesDTO" items="${employeesList }">
<tr onclick="window.open('update?empId=${employeesDTO.empId}', '_blank', 'width=800,height=600')">
    <td>${employeesDTO.empId}</td>
    <td>${employeesDTO.empPass}</td>
    <td>${employeesDTO.empName}</td>
    <td>${employeesDTO.empDepartment}</td>
    <td>${employeesDTO.empPosition}</td>
    <td>${employeesDTO.empEmail}</td>
    <td>${employeesDTO.empTel}</td>
    <td>${employeesDTO.empHiredate}</td>
    <td>${employeesDTO.empState}</td>
    <td onclick="event.stopPropagation();"><input type="checkbox" name="RowCheck" value="${employeesDTO.empId}"></td>
</tr>
</c:forEach>    
    </table>
    
    <input type="button" value="삭제" onclick="deleteValue();">
    <button onclick="window.open('employees2', '_blank', 'width=800,height=600')">등록</button>

<c:forEach var="i" begin="${pageDTO.startPage}" 
                   end="${pageDTO.endPage}" step="1">
<a href="${pageContext.request.contextPath}/employees/employees?pageNum=${i}&search=${pageDTO.search}">${i}</a> 
</c:forEach>


</body>

</html>
