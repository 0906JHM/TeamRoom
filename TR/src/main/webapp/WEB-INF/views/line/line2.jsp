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

$.ajax({
    url: '${pageContext.request.contextPath}/employees/empdropdown', // 서버로 요청을 보낼 URL을 수정해주세요.
    type: 'GET',
    success: function(data) {
        var dropdown = $('select[name="lineEmpId"]');
        dropdown.empty();
        $.each(data, function(key, entry) {
            var optionText = 'empId=' + entry.empId + ', empName=' + entry.empName;
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
사용여부:<input type="text" name="lineUse" class="lineUse"><br>
등록자:<select name="lineEmpId" class="lineEmpId"></select><br>
등록일:<input type="date" name="lineInsertDate" class="lineInsertDate"><br>
공정:<input type="text" name="lineProcess" class="lineProcess"><br>
<button onclick="save">저장하기</button>

</form>

</body>
</html>