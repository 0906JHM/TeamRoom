<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>거래처 정보</h1>
<table id="clientDetail">
<tr><td>구분</td><td>${clientDTO.clientType}</td></tr>
<tr><td>거래처코드</td><td>${clientDTO.clientCode}</td></tr>
<tr><td>거래처명</td><td>${clientDTO.clientCompany}</td></tr>
<tr><td>사업자번호</td><td>${clientDTO.clientNumber}</td></tr>
<tr><td>업태</td><td>${clientDTO.clientDetail}</td></tr>
<tr><td>대표자</td><td>${clientDTO.clientCeo}</td></tr>
<tr><td>담당자</td><td>${clientDTO.clientName}</td></tr>  
<tr><td>거래처주소</td><td>${clientDTO.clientAddr1}</td></tr>  
<tr><td>상세주소</td><td>${clientDTO.clientAddr2}</td></tr>  
<tr><td>거래처번호</td><td>${clientDTO.clientTel}</td></tr>  
<tr><td>휴대폰번호</td><td>${clientDTO.clientPhone}</td></tr>  
<tr><td>팩스번호</td><td>${clientDTO.clientFax}</td></tr>  
<tr><td>이메일</td><td>${clientDTO.clientEmail}</td></tr>  
<tr><td>비고</td><td>${clientDTO.clientMemo}</td></tr>  
</table>

<div class="btngroup">
        <input type="button" value="수정" id="updateButton" >
 <button type="button" class="deletebtn" onclick="clientdelete('${clientDTO.clientCompany}')">삭제</button>
</div>

<c:choose>
    <c:when test="${clientDTO.clientType eq '발주처'}">
        <!-- 발주처인 경우 rawDetail 테이블 출력 -->
        <h1>거래 정보</h1>
        <table id="rawDetail">
            <tr><td>원자재코드</td><td>${rawmaterialsDTO.rawCode}</td></tr>
            <tr><td>원자재명</td><td>${rawmaterialsDTO.rawName}</td></tr>
            <tr><td>종류</td><td>${rawmaterialsDTO.rawType}</td></tr>
            <tr><td>단위</td><td>${rawmaterialsDTO.rawUnit}</td></tr>
            <tr><td>가격</td><td>${rawmaterialsDTO.rawPrice}</td></tr>
        </table>
    </c:when>
    <c:when test="${clientDTO.clientType eq '수주처'}">
        <!-- 수주처인 경우 sellDetail 테이블 출력 -->
        <h1>거래 정보</h1>
        <table id="sellDetail">
            <tr><td>제품코드</td><td>${prodDTO.prodCode}</td></tr>
            <tr><td>제품명</td><td>${prodDTO.prodName}</td></tr>
        </table>
    </c:when>
    <c:otherwise>
        <!-- 그 외의 경우 아무 내용도 출력하지 않음 또는 처리할 내용 추가 -->
    </c:otherwise>
</c:choose>

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


</script>



</body>
</html>