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
라인코드: <input type="text" id="lineCode" name="lineCode" onclick="" class="cdbox">
</div>
<div class="perfcd1">
 지시일자: <input type="text" id="workdate1" name="workdate1" class="form-control" placeholder="날짜 선택" readonly> ~ <input type="text" id="workdate2" name="workdate2	" class="form-control" placeholder="날짜 선택" readonly>
</div>

<div class="perfcd1">
제품코드: <input type="text" id="prodCode" name="prodCode" onclick="" placeholder="제품코드" class="cdbox" onclick="">
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
					<th class="ctth">현황</th> 
					<th class="ctth">비고</th>
				</tr>
			</thead> 
		 <tbody>
				
					<tr class="ctcontents">
					    <td class="cttg">번호</td>
						<td class="cttg">생산실적코드</td>
						<td class="cttg">작업지시코드</td>
						<td class="cttg">라인코드</td>
						<td class="cttg">제품코드</td>
						<td class="cttg">실적일</td>
						<td class="cttg">실적수량</td>
						<td class="cttg">양품수</td>
						<td class="cttg">불량수</td>
						<td class="cttg">불량사유</td>
						<td class="cttg">현황</td>
						<td class="cttg">비고</td>
					</tr>
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
    
    $('#performCode a').click(function() {
    	var obj = { perform_code:$('#performCode').text().substring(0,16).trim() };
    		
    	$.ajax({
    		url: "/performance/detail",
    		type: "post",
    		data: JSON.stringify(obj),
    		contentType : "application/json; charset=UTF-8",
    		dataType : "json",
    		success: function(data) {
    			console.log(data);
    			
    			var tmp = "<table border='1' class='table table-striped jambo_table bulk_action' style='text-align:center;'>";
    			tmp += "<tr class='headings'>";
    			tmp += " <th>생산실적코드</th>";
    			tmp += "  <td>" + data.perform_code + "</td>";
    			tmp += " <th>작업지시코드</th>";
    			tmp += "  <td>" + data.work_code + "</td>";
    			tmp += " <th>라인코드</th>";
    			tmp += "  <td>" + data.workOrder.line_code + "</td>";
    			tmp += " <th>품번</th>";
    			tmp += ((data.prod_code===""||data.prod_code==null) ? "<td>없음</td>" : "<td>" + data.prod_code + "</td>");
    			tmp += "</tr>";
    			tmp += "<tr class='headings'>";
    			tmp += " <th>실적일</th>";
    			tmp += "  <td>" + getDate(data.perform_date) + "</td>";
    			tmp += " <th>실적수량</th>";
    			tmp += "  <td>" + data.perform_qt + "</td>";
    			tmp += " <th>양품수</th>";
    			tmp += "  <td>" + data.perform_fair + "</td>";
    			tmp += " <th>불량수</th>";
    			tmp += "  <td>" + data.perform_defect + "</td>";
    			tmp += "</tr>";
    			tmp += "<tr class='headings'>";
    			tmp += " <th>불량사유</th>";
    			tmp += ((data.defect_note===""||data.defect_note==null) ? "<td>없음</td>" : "<td>" + data.defect_note + "</td>");
    			tmp += " <th>현황</th>";
    			tmp += "  <td>" + data.perform_status + "</td>";
    			tmp += " <th>등록자</th>";
    			tmp += ((data.emp_id===""||data.emp_id==null) ? "<td>없음</td>" : "<td>" + data.emp_id + "</td>");
    			tmp += " <th>변경자</th>";
    			tmp += ((data.change_id===""||data.change_id==null) ? "<td>없음</td>" : "<td>" + data.change_id + "</td>");
    			tmp += "</tr>";
    			tmp += "<tr class='headings'>";
    			tmp += " <th>변경일</th>";
    			tmp += ((data.change_date===""||data.change_date==null) ? "<td>없음</td>" : "<td>" + getDate(data.change_date) + "</td>");
    			tmp += " <th>비고</th>";
    			tmp += ((data.perform_note===""||data.perform_note==null) ? "<td>없음</td>" : "<td>" + data.perform_note + "</td>");
    			tmp += "</tr>";
    			tmp += "</table>";
    			
    			$('.modal-body').html(tmp);
    			$('.modal').modal("show");
    		},
    		error: function() {
    			alert("아작스 실패");
    		}
    	}); //ajax
    		
    }); //생산실적코드 클릭   
    
});

</script>			
			
</html>