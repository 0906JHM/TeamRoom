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
				<th class="tg-0pky" colspan="2">상세주소</th>
				<th class="tg-0pky">전화번호</th>
				<th class="tg-0pky">휴대폰번호</th>
				<th class="tg-0pky">팩스번호</th>
				<th class="tg-0pky">이메일</th>
				<th class="tg-0lax">비고</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="tg-0pky">1</td>
				<td class="tg-0pky">a</td>
				<td class="tg-0pky">b</td>
				<td class="tg-0pky">c</td>
				<td class="tg-0pky">d</td>
				<td class="tg-0pky">e</td>
				<td class="tg-0pky">f</td>
				<td class="tg-0pky" colspan="2">g</td>
				<td class="tg-0pky">h</td>
				<td class="tg-0pky">i</td>
				<td class="tg-0pky">j</td>
				<td class="tg-0pky">k</td>
				<td class="tg-0lax">l</td>
			</tr>
		</tbody>

		<div style="float: right;">
			<input type="button" value="추가" id="addButton" >
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




</body>
</html>