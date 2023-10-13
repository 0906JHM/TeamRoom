<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>라인등록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<script type="text/javascript">

window.onload = function(){
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
    var yyyy = today.getFullYear();
    today = yyyy + '-' + mm + '-' + dd;
    document.querySelector(".lineInsertDate").value = today;
}

$.ajax({
    url: '${pageContext.request.contextPath}/employees/empdropdown', // 서버로 요청을 보낼 URL을 수정해주세요.
    type: 'GET',
    success: function(data) {
        var dropdown = $('select[name="lineEmpId"]');
        dropdown.empty();
        $.each(data, function(key, entry) {
            var optionText = '사원번호=' + entry.empId + ', 사원이름=' + entry.empName;
            dropdown.append($('<option></option>').attr('value', entry.empId).text(optionText));
        });
    }
});

// $(document).ready(function() {
//     $(".lineEmpId").change(function() {
//         var empId = $(this).val();

//         $.ajax({
//             url: '${pageContext.request.contextPath}/employees/empIdCheck',
//             data:{'empId': empId},
//             success: function(data) {
//                 if (data == false) {
//                     alert('유효하지 않은 empId입니다.');
//                 }
//             }
//         });
//     });
    
// });

</script>
<body>
<h1>라인등록</h1>
<form action="${pageContext.request.contextPath}/line/insertPro" id="join" method="post">

라인코드:<input type="text" name="lineCode" class="lineCode"><br>
라인명:<input type="text" name="lineName" class="lineName"><br>
사용여부:
<select name="lineUse" class="lineUse">
    <option value="사용">사용</option>
    <option value="미사용">미사용</option>
    <option value="점검">점검</option>
    <option value="고장">고장</option>
</select><br>
등록자:<select name="lineEmpId" class="lineEmpId"></select><br>
등록일:<input type="date" name="lineInsertDate" class="lineInsertDate"><br>
공정:<input type="text" name="lineProcess" class="lineProcess"><br>
<button onclick="save">저장하기</button>

</form>

</body>
</html>