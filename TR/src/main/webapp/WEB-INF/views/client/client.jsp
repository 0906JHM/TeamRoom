<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/client.css">
</head>
<body>
<div class="clientBody">
	<jsp:include page="../inc/sidebar.jsp"></jsp:include>

	<div class="clienthead">
		<h1 class="toptitle">거래처 관리</h1>
	</div>

	<div class="search">
		<label for="search-box"> <strong>검색</strong>
		</label> <input type="search" id="search-box">
	</div>

	<div class="clientbody1">
	<p class="notificlient">거래처명을 클릭하면 상세하게 볼 수 있습니다.</p>
		<table class="tg" id="tg">
			<thead>
				<tr>
					<th class="tg-0pky">구분</th>
					<th class="tg-0pky">거래처코드</th>
					<th class="tg-0pky">거래처명</th>
					<th class="tg-0pky">사업자번호</th>
					<th class="tg-0pky">업태</th>
					<th class="tg-0pky">대표자</th>
					<th class="tg-0pky">담당자</th>
					<th class="tg-0pky">거래처주소</th>
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
						<td class="tg-0pky"
							onclick="location.href='${pageContext.request.contextPath}/client/clientdetail?clientCompany=${clientDTO.clientCompany}&clientCode=${clientDTO.clientCode}'">${clientDTO.clientCompany}</td>
						<td class="tg-0pky">${clientDTO.clientNumber}</td>
						<td class="tg-0pky">${clientDTO.clientDetail}</td>
						<td class="tg-0pky">${clientDTO.clientCeo}</td>
						<td class="tg-0pky">${clientDTO.clientName}</td>
						<td class="tg-0pky">${clientDTO.clientAddr1}</td>
						<td class="tg-0pky">${clientDTO.clientTel}</td>
						<td class="tg-0pky">${clientDTO.clientPhone}</td>
						<td class="tg-0pky">${clientDTO.clientFax}</td>
						<td class="tg-0lax">${clientDTO.clientEmail}</td>
						<td class="tg-0lax">${clientDTO.clientMemo}</td>
					</tr>
				</c:forEach>
			</tbody>

		</table>
		
		<div style="float: right;">
				<input type="button" value="추가" id="addButton" class="addbutton"
					onclick="clientInsert()">
			</div>
			</div>
			</div>

		<script>
			document.addEventListener('DOMContentLoaded', function() {
				// 검색창 element를 id값으로 가져오기
				const payrollSearch = document.querySelector('#search-box');
				// 테이블의 tbody element를 id값으로 가져오기
				const payrollTable = document.querySelector('#tg tbody');

				//검색창 element에 keyup 이벤트 세팅. 글자 입력 시 마다 발생.
				payrollSearch.addEventListener('keyup', function() {
					// 사용자가 입력한 검색어의 value값을 가져와 소문자로 변경하여 filterValue에 저장
					const filterValue = payrollSearch.value.toLowerCase();
					console.log('검색어:', filterValue); // 검색어를 콘솔에 출력

					// 현재 tbody안에 있는 모든 tr element를 가져와 rows에 저장
					const rows = payrollTable.querySelectorAll('tr');

					//tr들 for문으로 순회
					for (var i = 0; i < rows.length; i++) {
						// 현재 순회중인 tr의 textContent를 소문자로 변경하여 rowText에 저장
						var rowText = rows[i].textContent.toLowerCase();
						// rowText가 filterValue를 포함하면, 해당 tr은 보여지게 하고, 그렇지 않으면 숨긴다.
						if (rowText.includes(filterValue)) {
							rows[i].style.display = '';
						} else {
							rows[i].style.display = 'none';
						}
					}
				});
			});

			function clientInsert() {
				window
						.open(
								'${pageContext.request.contextPath}/client/clientinsert',
								'_blank',
								'width=600px, height=1000px, left=600px, top=300px');
			}
		</script>
</body>
</html>