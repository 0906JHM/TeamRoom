<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- sweetalert2 API 호출 -->
<link rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
		
</head>
<body>
<body class="sb-nav-fixed">
				<!-- 내용들어가는곳 -->
	<form action="${pageContext.request.contextPath}/client/insertPro" id="clientInsert" name="clientInsert" method="POST">
		<h1>
			<b>거래처 등록</b>
		</h1>

		<br>
<!-- 거래처구분 -->
		<label for="clientType_label"><b>구분</b> </label>
		<input type="text" name="clientType" id="clientType">
		<br>
		<span id="clientType_msg"></span>
		<br>
		<!-- 거래처 코드 -->
		<label for="clientCode_label"><b>거래처코드</b></label> 
		<input type="text" name="clientCode" id="clientCode">
		<br> 
		<span id="clientCode_msg"></span>
		<br>

		<!-- 거래처명 -->
		<label for="clientCompany_label"><b>거래처명</b> </label>
		<input type="text" name="clientCompany" id="clientCompany">
		<br>
		<span id="clientCompany_msg"></span>
		<br>
		
		<!-- 사업자번호 -->
		<label for="clientNumber_label"><b>사업자번호</b> </label>
		<input type="text" name="clientNumber" id="clientNumber">
		<br>
		<span id="clientNumber_msg"></span>
		<br>
		
		<!-- 업태 -->
		<label for="clientDetail_label"><b>업태</b> </label>
		<input type="text" name="clientDetail" id="clientDetail">
		<br>
		<span id="clientDetail_msg"></span>
		<br>
		

		<!-- 거래처 대표자명 -->
		<label for="clientCeo_label"><b>대표자</b></label>
		<input type="text" name="clientCeo" id="clientCeo">
		<br>
		<span id="clientCeo_msg"></span>
		<br>
		
		<!-- 거래처담당자이름-->
		<label for="clientName_label"><b>거래담당자</b></label> 
		<input type="text" name="clientName" id="clientName">
		<br> 
		<span id="clientName_msg"></span>
		<br>
		
		<!-- 주소 -->
		<label for="clientAddress_label"><b>도로명주소</b></label> <input type="text" id="sample4_roadAddress" placeholder="도로명주소" name="clientAddr1"  readonly required>
<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" required><br>
<input type="text" id="sample4_extraAddress" placeholder="상세주소" name="clientAddr2" size="60" required><br>
		
		
		
		<!-- 거래처 번호 -->
		<label for="clientTel"><b>거래처번호</b></label>
		<input type="text" name="clientTel" id="clientTel">
		<br>
		<span id="clientTel_msg"></span>
		<br>
		
		<!-- 거래담당자 번호 -->
		<label for="clientPhone"><b>담당자번호</b></label>
		<input type="text" name="clientPhone" id="clientPhone">
		<br>
		<span id="clientPhone_msg"></span>
		<br>
		
		<!--  팩스번호 -->
		<label for="clientFax"><b>팩스자번호</b></label>
		<input type="text" name="clientFax" id="clientFax">
		<br>
		<span id="clientFax_msg"></span>
		<br>
		
		
		<!-- 거래처 이메일 -->
		<label for="clientEmail"><b>이메일</b></label> 
		<input type="text" name="clientEmail" id="clientEmail">
		<br>
		<span id="clientEmail_msg"></span>
		<br>
		
		<label for="clientMemo_label"><b>비고</b> </label>
		<input type="text" name="clientMemo" id="clientMemo">
		<br>
		<span id="clientMemo_msg"></span>
		<br>

		<!-- 등록 버튼 -->
		<div id="btn">
			<input type="submit" id="btn" value="등록">
		</div>
		
	</form>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }                
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            /* document.getElementById('sample4_postcode').value = data.zonecode; */
            document.getElementById("sample4_roadAddress").value = roadAddr;
            /* document.getElementById("sample4_jibunAddress").value = data.jibunAddress; */
     
           /*  document.getElementById("sample4_engAddress").value = data.addressEnglish; */
           
            if(roadAddr !== ''){
                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                
            } else {
                document.getElementById("clientAddr2").value = '';
            }

         /*    var guideTextBox = document.getElementById("guide");
            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다. */
            if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
              /*   guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'block'; */

            } /* else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'block';
            }  */ /* else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
            } */
            
            document.getElementById("sample4_extraAddress").focus(); 
          
        }
    }).open();
}   
</script>
<!-- sweetalert2 API 호출 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
	
	
<!-- sweetalert2 API 호출 -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
$(document).ready(function() {
	
	alert("동작체크");
	
//전역변수 선언
var selectedDept = '';
var currentDate = new Date();

  	//서브밋 제어
    $('#clientInsert').submit(function(event) {
    	
        	if($('#clientType').val() == ""){
    		$('#clientType_msg').css('color','red');
    		$('#clientType_msg').html("거래처구분을 선택하십시오."); 
    		$('#clientType').focus();
    		return false;
    	}
    	
    	if($('#clientCode').val() == ""){
    		$('#clientCode').css('color','red');
    		$('#clientCode_msg').html("거래처코드를 입력하세요.");
    		$('#clientCode').focus();
    		return false;
    	}
    	
    	if($('#clientCompany').val() == ""){
    		$('#clientCompany_msg').css('color','red');
    		$('#clientCompany_msg').html("거래처명을 입력하세요.");  
    		$('#clientCompany').focus();
    		return false;
    	}
    	
    	if($('#clientNumber').val() == ""){
    		$('#clientNumber_msg').css('color','red');
    		$('#clientNumber_msg').html("사업자번호를 입력하십시오.");
    		$('#clientNumber').focus();
    		return false;
    	}
    	
    	if($('#clientDetail').val() == ""){
    		$('#clientDetail_msg').css('color','red');
    		$('#clientDetail_msg').html("업태를 입력하세요.");
    		$('#clientDetail').focus();
    		return false;
    	}
    	
    	if($('#clientCeo').val() == ""){
    		$('#clientCeo_msg').css('color','red');
    		$('#clientCeo_msg').html("대표자명을 입력하세요.");
    		$('#clientCeo').focus();
    		return false;
    	}
    	
    	if($('#clientName').val() == ""){
    		$('#clientName_msg').css('color','red');
    		$('#clientName_msg').html("전화번호를 입력하세요.");
    		$('#clientName').focus();
    		return false;
    	}
    	

    	
    	/* if($('#clientName').val() == "" || $('#clientAddr1').val() == ""){
    		$('#clientName_msg').css('color','red');
    		$('#clientName_msg').text("주소를 입력하십시오.");
    		return false;
    	} */
    	
    	if($('#clientTel').val() == ""){
    		$('#clientTel_msg').css('color','red');
    		$('#clientTel_msg').html("거래처 전화번호를 입력하세요."); 
    		$('#clientTel').focus();
    		return false;
    	}
    	
    	if($('#clientPhone').val() == ""){
    		$('#clientPhone_msg').css('color','red');
    		$('#clientPhone_msg').html("거래처 담당 직원 번호를 입력하세요."); 
    		$('#clientPhone').focus();
    		return false;
    	}
    	
    	if($('#clientFax').val() == ""){
    		$('#clientFax_msg').css('color','red');
    		$('#clientFax_msg').html("거래처 팩스번호를 입력하세요."); 
    		$('#clientFax').focus();
    		return false;
    	}
    	
    	
    	if($('#clientEmail').val() == ""){
    		$('#clientEmail_msg').css('color','red');
    		$('#clientEmail_msg').html("거래처 이메일을 입력하세요.");
    		return false;
    	}
    	
    	 // 다입력되었다면 AJAX 폼태그 데이터 제출시작
    	 event.preventDefault(); // 기본 폼 제출 동작을 막음 
    		
    	 // 폼 데이터 객체생성
    	 var formData = new FormData(this);
         
         $.ajax({
             type: "POST",
             url: "${pageContext.request.contextPath}/client/insertPro",
             data: formData,
             contentType: false, // 멀티파트를 처리하기위해 객체를 직렬화하지 않고 직접 AJAX 통신할 수 있도록 설정
             processData: false, 
             success: function (response) {
            	 
            	 const result = $.trim(response);
            	 
                 if (result == "true") {
                	 Swal.fire('정보 입력이 완료되었습니다.', '성공', 'success').then(result => {
					 	if(result.isConfirmed)
						// 완료 창을 닫으면 부모창 새로고침
						window.opener.location.reload();
						window.close(); // 성공 시 창 닫기
					 });
                 } else {
                	 Swal.fire('정보 입력에 실패했습니다.', '실패', 'error');
                 }
             },
             error: function () {
            	 Swal.fire('서버통신에 문제가 발생했습니다.', '실패', 'error');
             }
         });
    	
    });//submit기능 제어 끝
});

</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
</body>
</html>