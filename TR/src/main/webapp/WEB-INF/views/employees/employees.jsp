<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>

<style>
    table, th, td {
        border: 1px solid black;
    }
</style>


<!-- javascript -->
<script type="text/javascript">
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
}
</script>



</head>
<body>
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
<tr><td>${employeesDTO.empId}</td>
<td>${employeesDTO.empPass}</td>
<td>${employeesDTO.empName}</td>
<td>${employeesDTO.empDepartment}</td>
<td>${employeesDTO.empPosition}</td>
<td>${employeesDTO.empEmail}</td>
<td>${employeesDTO.empTel}</td>
<td>${employeesDTO.empHiredate}</td>
<td>${employeesDTO.empState}</td>
<td><input type="checkbox" name="RowCheck" value="${employeesDTO.empId}"></td></tr>
</c:forEach>  
    </table>
    <input type="button" value="삭제" onclick="deleteValue();">
    <button onclick="window.location.href='employees2';">추가하기</button>
    <button onclick="saveRow()">저장</button>
    <button onclick="cancelRow()">취소하기</button>
    <button onclick="deleteRow()">삭제하기</button>
</body>
</html>
