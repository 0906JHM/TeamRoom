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
	href="${pageContext.request.contextPath}/resources/css/perf.css">
	
	
	<link href="${pageContext.request.contextPath }/resources/css/side.css"
	rel="stylesheet" type="text/css">
	
</head>
<body>
<jsp:include page="../inc/side.jsp"></jsp:include>

<!--  여기서부터 시작  -->
<div class="clientBody">
		<h1 class="toptitle">생산실적 관리</h1>

<hr>
<div class="perfcd">
<div class="perfcd1">
라인코드: <input type="text" id="lineCode" name="lineCode" onclick="" class="cdbox" readonly>
</div>

<div class="perfcd1">
제품코드: <input type="text" id="prodCode" name="prodCode" onclick="" placeholder="제품코드" class="cdbox" onclick="" readonly>
</div>


<div class="perfcd1">
 실적일: <input type="text" id="workdate1" name="workdate1" class="form-control" placeholder="날짜 선택" readonly> ~ <input type="text" id="workdate2" name="workdate2	" class="form-control" placeholder="날짜 선택" readonly>
</div>

<div class="perfcd1">
 작업지시코드: <input type="text" id="workCode" name="workCode" class="cdbox" placeholder="작업지시코드" readonly>
</div>


</div> <!--  perfcd -->
<hr> <!--  경계선 -->
	

	
<!--  본문 내용  -->
	<div class="clientbody1">
	<div class="tableform"> 
			<div class="clienttotal">
			 <h2> 생산실적: 총 x 건 </h2>
			
			<div style="float: right;">
				<input type="button" value="추가" id="addButton" class="addbutton"
					onclick="perfInsert()">
			</div>	 <!-- 검색칸 -->	
			</div>   <!--  생산실적 총:x건 라인-->

		 <table class="ct" id="ct">	
			<thead>
				<tr class="cthead">
				<th class="ctth">번호</th>
				    <th class="ctth">생산실적코드</th>
					<th class="ctth">작업지시코드</th>
					<th class="ctth">라인코드</th>
					<th class="ctth">제품코드</th>
					<th class="ctth">실적일</th>
					<th class="ctth">실적수량</th>
					<th class="ctth">양품수</th>
					<th class="ctth">불량수</th>
					<th class="ctth">불량사유</th>
			        <th class="ctth">비고</th>
					<th class="ctth">현황</th> 
					
				</tr>
			</thead> 
		 <tbody>
				<c:forEach var="perfDTO" items="${worklist}">
					<tr class="ctcontents">
					    <td class="cttg">1</td>
						<td class="cttg">${perfDTO.perfCode}</td>
						<td class="cttg">${perfDTO.workCode}</td>
						<td class="cttg">${perfDTO.lineCode}</td>
						<td class="cttg">${perfDTO.prodCode}</td>
						<td class="cttg">${perfDTO.perfDate}</td>
						<td class="cttg">${perfDTO.perfAmount}</td>
						<td class="cttg">${perfDTO.perfFair}</td>
						<td class="cttg">${perfDTO.perfDefect}</td>
						<td class="cttg">${perfDTO.perfDefectreason}</td>
						<td class="cttg">${perfDTO.perfMemo}</td>
						<td class="cttg">${perfDTO.perfStatus}</td>
						
					</tr>
					</c:forEach>
			</tbody> 

		</table>
		</div> <!--  TABLE FORM -->
		

			
			</div> <!--  CLIENTBODY -->

</body>
<script> 
$(document).ready(function() {
    // addButton 클릭 이벤트 처리
    $('#addButton').click(function() {
        window.open(
            '${pageContext.request.contextPath}/perf/perfinsert',
            '_blank',
            'width=1200px, height=800px, left=500px, top=100px'
        );
    });
       
});

</script>			
			
</html>