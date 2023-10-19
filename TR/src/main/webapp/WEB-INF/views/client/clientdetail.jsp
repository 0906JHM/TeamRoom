<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script> <!-- SweetAlert2 라이브러리 추가 -->

<style>

body{
background-color: #F5F6FA;

}

.headh{
text-align: center;
}

td {
margin-left : 50px;
margin-right : 15px;
font-size : 18px;
width: 150px;
}


.upform{

height : 20px;
width: 200px;
}
.addres{
    background-color: white;
    width: 100px;
    height: 25px;
    border-radius: 5px;
    text-align: center;
    border: 1px solid black;
    margin-top: 5px;
}

.btngroup{
    align-items: center;
    justify-content: center;
    display: flex;
    margin-top: 15px;

}

.footbtn{
background-color: rgba(94.0000019967556, 195.0000035762787, 151.00000619888306, 1);
    width: 100px;
    height: 40px;
    border-radius: 5px;
    color: #FFFFFF;
    border: 0;
    text-align: center;
    font: 500 24px/24px "Inter", sans-serif;
    margin-right: 15px;

}
.deletebtn{
background-color: rgba(94.0000019967556, 195.0000035762787, 151.00000619888306, 1);
    width: 100px;
    height: 40px;
    border-radius: 5px;
    color: #FFFFFF;
    border: 0;
    text-align: center;
    font: 500 24px/24px "Inter", sans-serif;
}

</style>
</head>
<body>

<h2 class="headh">거래처 정보</h2>
<form id="clientsub" action="${pageContext.request.contextPath}/client/clientupdatePro" method="post">
<table id="clientDetail">
<tr><td>구분</td><td><input type="text" name="clientType" class="upform" ${clientDTO.clientType}"></td></tr>
<tr><td>거래처코드</td><td><input type="text" name="clientCode" value="${clientDTO.clientCode}" class="upform"></td></tr>
<tr><td>거래처명</td><td><input type="text" name="clientCompany" value="${clientDTO.clientCompany}" class="upform"></td></tr>
<tr><td>사업자번호</td><td><input type="text" name="clientNumber" value="${clientDTO.clientNumber}" class="upform"></td></tr>
<tr><td>업태</td><td><input type="text" name="clientDetail" value="${clientDTO.clientDetail}" class="upform"></td></tr>
<tr><td>대표자</td><td><input type="text" name="clientCeo" value="${clientDTO.clientCeo}" class="upform"></td></tr>
<tr><td>담당자</td><td><input type="text" name="clientName" value="${clientDTO.clientName}" class="upform"></td></tr>  
<tr><td>거래처주소</td><td><input  type="text" id="sample4_roadAddress" placeholder="도로명주소"
			name="clientAddr1" value="${clientDTO.clientAddr1}" class="upform" readonly required>  
			<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"  class="addres" required>
			
			
          </td></tr>  
<tr><td>상세주소</td><td><input type="text" id="sample4_extraAddress" placeholder="상세주소"
			name="clientAddr2" size="60" value="${clientDTO.clientAddr2}" class="upform" required></td></tr>  
<tr><td>거래처번호</td><td><input type="text" name="clientTel" value="${clientDTO.clientTel}" class="upform"></td></tr>  
<tr><td>휴대폰번호</td><td><input type="tel" name="clientPhone" value="${clientDTO.clientPhone}" class="upform"> </td></tr>  
<tr><td>팩스번호</td><td><input type="tel" name="clientFax" value="${clientDTO.clientFax}" class="upform"> </td></tr>  
<tr><td>이메일</td><td><input type="email" name="clientEmail" value="${clientDTO.clientEmail}" class="upform"></td></tr>  
<tr><td>비고</td><td><input type="text" name="clientMemo" value="${clientDTO.clientMemo}" class="upform"> </td></tr>  
<c:if test="${clientDTO.clientType eq '수주처'}">
    <tr>
        <td>매출액</td>
        <td>
            <c:choose>
                <c:when test="${clientDTO.clientSale eq 0}">
                    0
                </c:when>
                <c:otherwise>
                    ${clientDTO.clientSale}
                </c:otherwise>
            </c:choose>
        </td>
    </tr>  
</c:if>
</table>

<div class="btngroup">
        <input type="submit" value="수정" class="footbtn" id="updatesubmit">
 <button type="button" class="deletebtn" onclick="clientdelete('${clientDTO.clientCompany}')">삭제</button>
</div>

</form>

			



<script>
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


document.addEventListener('DOMContentLoaded', function() {
    // 수정 버튼 클릭 이벤트 처리
    document.getElementById('clientsub').addEventListener('submit', function(event) {
        event.preventDefault(); // 폼 기본 동작 막기
        
        // SweetAlert2로 확인 메시지 띄우기
        Swal.fire({
            title: '수정하시겠습니까?',
            icon: 'question',
            showCancelButton: true,
            confirmButtonText: '예',
            cancelButtonText: '아니오'
        }).then((result) => {
            if (result.isConfirmed) {
            	 // 폼 제출
                document.getElementById('clientsub').submit(); // 폼 제출
                Swal.fire('수정 되었습니다!', '', 'success').then(() => {
                    // SweetAlert2에서 확인 버튼을 누른 후 페이지를 새로고침합니다.
                    window.location.reload();
                });
            }
        });
    });
});


</script>



</body>
</html>