<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>라인수정</title>
<link href="${pageContext.request.contextPath }/resources/css/employees2.css" rel="stylesheet" type="text/css">
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
</script>

<body>
<div class="container">
<h2>라인수정</h2>
<form action="${pageContext.request.contextPath}/line/updatePro" id="join" method="post">

<div class="form-group"><p>라인코드:</p><input type="text" name="lineCode" class="lineCode" value="${lineDTO.lineCode}"></div>
<div class="form-group"><p>라인명:</p><input type="text" name="lineName" class="lineName" value="${lineDTO.lineName}"></div>
<div class="form-group"><p>사용여부:</p><input type="text" name="lineUse" class="lineUse" value="${lineDTO.lineUse}"></div>
<div class="form-group"><p>등록자:</p><input type="text" name="lineEmpId" class="lineEmpId" value="${lineDTO.lineEmpId}"></div>
<div class="form-group"><p>등록일:</p><input type="date" name="lineInsertDate" class="lineInsertDate" value="${lineDTO.lineInsertDate}"></div>
<div class="form-group"><p>공정:</p><input type="text" name="lineProcess" class="lineProcess" value="${lineDTO.lineProcess}"></div>
<button onclick="save">수정하기</button>

</form>
</div>
</body>
</html>