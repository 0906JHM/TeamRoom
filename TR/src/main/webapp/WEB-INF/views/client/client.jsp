<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.tg {
	border-collapse: collapse;
	border-spacing: 0;
}

.tg td {
	border-color: black;
	border-style: solid;
	border-width: 1px;
	font-family: Arial, sans-serif;
	font-size: 14px;
	overflow: hidden;
	padding: 10px 5px;
	word-break: normal;
}

.tg th {
	border-color: black;
	border-style: solid;
	border-width: 1px;
	font-family: Arial, sans-serif;
	font-size: 14px;
	font-weight: normal;
	overflow: hidden;
	padding: 10px 5px;
	word-break: normal;
}

.tg .tg-0pky {
	border-color: inherit;
	text-align: left;
	vertical-align: top
}

.tg .tg-0lax {
	text-align: left;
	vertical-align: top
}
</style>
</head>
<body>


	<table class="tg">
		<thead>
			<tr>
				<th class="tg-0pky">구분</th>
				<th class="tg-0pky">거래처코드</th>
				<th class="tg-0pky">거래처명</th>
				<th class="tg-0pky">사업자번호</th>
				<th class="tg-0pky">업태</th>
				<th class="tg-0pky">대표자</th>
				<th class="tg-0pky">담당자</th>
				<th class="tg-0pky" >거래처주소</th>
				<th class="tg-0pky" colspan="2">상세주소</th>
				<th class="tg-0pky">거래처번호</th>
				<th class="tg-0pky">휴대폰번호</th>
				<th class="tg-0pky">팩스번호</th>
				<th class="tg-0pky">이메일</th>
				<th class="tg-0lax">비고</th>
			</tr>
		</thead>
		
		<tbody>
		<c:forEach var="clientDTO" items="${clientList}">
			<tr>
				<td class="tg-0pky">${clientDTO.clientType}</td>
				<td class="tg-0pky">${clientDTO.clientCode}</td>
				<td class="tg-0pky" onclick="location.href='${pageContext.request.contextPath}/client/clientdetail?clientCompany=${clientDTO.clientCompany}&clientCode=${clientDTO.clientCode}'">${clientDTO.clientCompany}</td>
				
				<td class="tg-0pky">${clientDTO.clientNumber}</td>
				<td class="tg-0pky">${clientDTO.clientDetail}</td>
				<td class="tg-0pky">${clientDTO.clientCeo}</td>
				<td class="tg-0pky">${clientDTO.clientName}</td>
				<td class="tg-0pky">${clientDTO.clientAddr1}</td>
				<td class="tg-0pky" colspan="2">${clientDTO.clientAddr2}</td>
				<td class="tg-0pky">${clientDTO.clientTel}</td>
				<td class="tg-0pky">${clientDTO.clientPhone}</td>
				<td class="tg-0pky">${clientDTO.clientFax}</td>
				<td class="tg-0lax">${clientDTO.clientEmail}</td>
				<td class="tg-0lax">${clientDTO.clientMemo}</td>
			</tr>
			</c:forEach>
		</tbody>

		<div style="float: right;">
			<input type="button" value="추가" id="addButton" onclick="clientInsert()">
			<input type="button" value="수정" id="updateButton" >
			<input type="button" value="삭제" id="deleteButton"> 
			<input type="button" value="취소" id="cancelButton"> 
			<input type="button"value="저장" id="saveButton">
		</div>

	</table>
	
	<form action="${pageContext.request.contextPath}/client/insertPro" method="post">
	
	<input type="text" id="clientType" name="clientType" value="거래처구분"><br>
	<input type="text" id="clientCode" name ="clientCode" value="거래처코드"><br>
	<input type="text" id="clientCompany" name="clientCompany" value="거래처명"><br>
	<input type="text" id="clientNumber" name="clientNumber" value="사업자번호"><br>
	<input type="text" id="clientDetail" name="clientDetail" value="업태"><br>
	<input type="text" id="clientCeo" name="clientCeo" value="대표자"><br>
	<input type="text" id="clientName" name="clientName" value="담당자"><br>
	<input type="text" id="clientAddr1" name="clientAddr1" value="거래처주소"> <br>
	<input type="text" id="clientAddr2" name="clientAddr2" value="상세주소"><br>
	<input type="text" id="clientTel" name="clientTel" value="거래처번호"><br>
	<input type="text" id="clientPhone" name="clientPhone" value="담당자번호"><br>
	<input type="text" id="clientFax" name="clientFax" value="거래처코드"><br>
	<input type="text" id="clientEmail" name="clientEmail" value="거래처메일"><br>
	<input type="text" id="clientMemo" name="clientMemo" value="비고">
	 
	 <input type="submit" value="제출">
	</form>
	
	<script>
function clientInsert(){
    window.open('${pageContext.request.contextPath}/client/clientinsert', '_blank', 'width=600px, height=1000px, left=600px, top=300px');
    }
</script>


</body>
</html>