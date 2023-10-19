<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>

<h1>거래처 정보</h1>
<form id="clientsub" action="${pageContext.request.contextPath}/client/clientupdatePro" method="post">
<table id="clientDetail">
<tr><td>구분</td><td>${clientDTO.clientType}</td></tr>
<tr><td>거래처코드</td><td>${clientDTO.clientCode}</td></tr>
<tr><td>거래처명</td><td><input type="text" name="clientCompany" value="${clientDTO.clientCompany}"></td></tr>
<tr><td>사업자번호</td><td>${clientDTO.clientNumber}</td></tr>
<tr><td>업태</td><td>${clientDTO.clientDetail}</td></tr>
<tr><td>대표자</td><td><input type="text" name="clientCeo" value="${clientDTO.clientCeo}"></td></tr>
<tr><td>담당자</td><td><input type="text" name="clientName" value="${clientDTO.clientName}"></td></tr>  
<tr><td>거래처주소</td><td><input  type="text" id="sample4_roadAddress" placeholder="도로명주소"
			name="clientAddr1" value="${clientDTO.clientAddr1}" readonly required>  <input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" required>
          </td></tr>  
<tr><td>상세주소</td><td><input type="text" id="sample4_extraAddress" placeholder="상세주소"
			name="clientAddr2" size="60" value="${clientDTO.clientAddr2}"required></td></tr>  
<tr><td>거래처번호</td><td><input type="text" name="clientTel" value="${clientDTO.clientTel}"></td></tr>  
<tr><td>휴대폰번호</td><td><input type="tel" name="clientPhone" value="${clientDTO.clientPhone}"> </td></tr>  
<tr><td>팩스번호</td><td><input type="tel" name="clientFax" value="${clientDTO.clientFax}"> </td></tr>  
<tr><td>이메일</td><td><input type="email" name="clientEmail" value="${clientDTO.clientEmail}"></td></tr>  
<tr><td>비고</td><td><input type="text" name="clientMemo" value="${clientDTO.clientMemo}"> </td></tr>  
</table>
</form>

			
<div class="btngroup">
        <input type="submit" value="수정제출">
 <button type="button" class="deletebtn" onclick="clientdelete('${clientDTO.clientCompany}')">삭제</button>
</div>


<script>
document.getElementById("updateButton").addEventListener("click", function() {
    var clientCompany = '${clientDTO.clientCompany}'; // 서버에서 받은 clientCompany 값
    var updateUrl = '${pageContext.request.contextPath}/client/clientupdate?clientCompany=' + clientCompany;
    window.open(updateUrl, '_blank', 'width=600px, height=1000px, left=600px, top=300px');
});

function clientdelete(clientCompany) {
    if (confirm("정말로 삭제하시겠습니까?")) {
        // 확인을 선택한 경우 삭제 요청을 보냅니다.
        location.href = '${pageContext.request.contextPath}/client/delete?clientCompany=' + clientCompany;
         console.log(clientCompany);
    }
}

function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var roadAddr = data.roadAddress;
            var extraRoadAddr = '';

            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }

            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }

            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            document.getElementById("sample4_roadAddress").value = roadAddr;
            if(roadAddr !== ''){
                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
            } else {
                document.getElementById("clientAddr2").value = '';
            }
        }
    }).open();
}


</script>



</body>
</html>