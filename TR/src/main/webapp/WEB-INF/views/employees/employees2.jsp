<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인사등록</title>
<link href="${pageContext.request.contextPath }/resources/css/employees2.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="container"> 
<h2>인사등록</h2>
<form action="${pageContext.request.contextPath}/employees/insertPro" id="join" method="post" enctype="multipart/form-data">

<div class="form-group">
<p>사원번호</p>
<input type="number" name="empId" class="empId">
</div>
<div class="form-group"><p>비밀번호</p><input type="password" name="empPass" class="empPass"></div>
<div class="form-group"><p>사원명</p><input type="text" name="empName" class="empName"></div>
<div class="form-group"><p>부서</p>
<select name="empDepartment" class="empDepartment select">
<option value="인사팀">인사팀</option>
<option value="영업팀">영업팀</option>
<option value="자재팀">자재팀</option>
<option value="생산팀">생산팀</option>
</select></div>
<div class="form-group"><p>직책</p>
<select name="empPosition" class="empPosition select">
<option value="사원">사원</option>
<option value="팀장">팀장</option>
<option value="부장">부장</option>
</select></div>
<div class="form-group"><p>이메일</p><input type="email" name="empEmail" class="empEmail"></div>
<div class="form-group"><p>전화번호</p><input type="number" name="empTel" class="empTel"></div>
<div class="form-group"><p>입사일자</p><input type="date" name="empHiredate" class="empHiredate"></div>
<div class="form-group"><p>재직구분</p>
<select name="empState" class="empState select">
<option value="재직">재직</option>
<option value="휴직">휴직</option>
<option value="퇴사">퇴사</option>
</select></div>
<div class="form-group">
    <p>프로필사진</p>
    <button id="upload-button" type="button">사진 변경</button>
    <button id="delete-button" type="button">사진 삭제</button> <!-- 사진 삭제 버튼 추가 -->
    <input type="file" id="file" name="file" accept="image/*" onchange="previewImage()" style="display: none;" />
</div>
<div class="form-group">
    <p></p>
    <img id="preview" />
</div>
<button id="save-button" onclick="save">저장하기</button>

</form>
</div>
<script>
document.getElementById('delete-button').addEventListener('click', function() {
    // 이미지 미리보기를 초기화합니다.
    document.getElementById('preview').src = '';
    
    // 파일 입력 필드를 초기화합니다.
    document.getElementById('file').value = '';
});
// 파일 업로드 버튼 누르면 input file 클릭됨
document.getElementById('upload-button').addEventListener('click', function() {
    document.getElementById('file').click();
});
// 업로드된 파일 미리보기+버튼 숨기기
function previewImage() {
    var file = document.getElementById("file").files[0];
    var reader = new FileReader();

    reader.onloadend = function () {
        document.getElementById("preview").src = reader.result;
    }

    if (file) {
        reader.readAsDataURL(file);
    } else {
        document.getElementById("preview").src = "";
    }
}
</script>
</body>
</html>