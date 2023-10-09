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
	<link href="${pageContext.request.contextPath }/resources/css/side.css"
	rel="stylesheet" type="text/css">
</head>
<body>
<jsp:include page="../inc/side.jsp"></jsp:include>

<!--  여기서부터 시작  -->
<div class="clientBody">

		<h1 class="toptitle">거래처 관리</h1>

<hr>
	<div class="search">
		<label for="search-box"> <strong>검색</strong>
		</label> <input type="search" id="search-box">
		</div>
<hr>		

	
<!--  본문 내용  -->
	<div class="clientbody1">
	
	<div class="tableform"> 
			
			<div class="clienttotal">
			 <h2> 거래처 목록: 총 x 건</h2><span class="notificlient">* 거래처명을 클릭하면 상세하게 볼 수 있습니다.</span>
			
			<div style="float: right;">
				<input type="button" value="추가" id="addButton" class="addbutton"
					onclick="clientInsert()">
			</div>
			
			
			</div>
			
			
			
			
			
		<table class="ct" id="ct">
			
			<thead>
				<tr class="cthead">
				    <th class="ctth">번호</th>
					<th class="ctth">구분</th>
					<th class="ctth">거래처코드</th>
					<th class="ctth">거래처명</th>
					<th class="ctth">사업자번호</th>
					<th class="ctth">업태</th>
					<th class="ctth">대표자</th>
					<th class="ctth">담당자</th>
					<th class="ctth">거래처주소</th>
					<th class="ctth">거래처번호</th>
					<th class="ctth">휴대폰번호</th>
					<th class="ctth">팩스번호</th>
					<th class="ctth">이메일</th>
					<th class="ctth">비고</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="clientDTO" items="${clientList}">
					<tr class="ctcontents">
					    <td class="cttg">아직없음.</td>
						<td class="cttg">${clientDTO.clientType}</td>
						<td class="cttg">${clientDTO.clientCode}</td>
						<td class="cttg"
							onclick="location.href='${pageContext.request.contextPath}/client/clientdetail?clientCompany=${clientDTO.clientCompany}&clientCode=${clientDTO.clientCode}'">${clientDTO.clientCompany}</td>
						<td class="cttg">${clientDTO.clientNumber}</td>
						<td class="cttg">${clientDTO.clientDetail}</td>
						<td class="cttg">${clientDTO.clientCeo}</td>
						<td class="cttg">${clientDTO.clientName}</td>
						<td class="cttg">${clientDTO.clientAddr1}</td>
						<td class="cttg">${clientDTO.clientTel}</td>
						<td class="cttg">${clientDTO.clientPhone}</td>
						<td class="cttg">${clientDTO.clientFax}</td>
						<td class="cttg">${clientDTO.clientEmail}</td>
						<td class="cttg">${clientDTO.clientMemo}</td>
					</tr>
				</c:forEach>
			</tbody>

		</table>
		</div>
		<!-- <div style="float: right;">
				<input type="button" value="추가" id="addButton" class="addbutton"
					onclick="clientInsert()">
			</div> -->
			</div>
			
			</div>
			

		<script>
			document.addEventListener('DOMContentLoaded', function() {
				// 검색창 element를 id값으로 가져오기
				const payrollSearch = document.querySelector('#search-box');
				// 테이블의 tbody element를 id값으로 가져오기
				const payrollTable = document.querySelector('#ct tbody');

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