<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="${pageContext.request.contextPath}/perf/updatePro" method="post">
 	<table class="ct" id="ct">	
			<thead>
				<tr class="cthead">
				    <th>생산실적코드</th>
					<th>작업지시코드</th><!-- worklist에서 받아옴 -->
					<th>제품코드</th><!-- worklist에서 받아옴 -->
					<th>라인코드</th><!-- worklist에서 받아옴 -->
					<th >실적일</th>
					<th> 담당자 </th>
					<th >실적수량</th><!-- worklist에서 받아옴 -->
					<th >양품수</th><!-- worklist에서 받아옴 -->
					<th >불량수</th>
					<th >불량사유</th>
					<th>불량사유(기타)</th>
					<th >비고</th>
					<th >현황</th> <!-- worklist에서 받아옴 -->
				</tr>
			</thead> 
			<tbody>
					<tr class="ctcontents">
					    <td ><input type="text" id="perfCode" name="perfCode" value="${perfDTO.perfCode} "></td> <!--  생산실적코드 -->
						<td ><input type="text" id="workCode" name="workCode" value="${perfDTO.workCode}"> </td> <!--  작업지시코드 -->
						<td ><input type="text" id="prodCode" name="prodCode" value="${perfDTO.prodCode}"> </td> <!--  제품코드 -->
						<td ><input type="text" id="lineCode" name="lineCode" value="${perfDTO.lineCode}"> </td> <!--  제품코드 -->
						<td ><input type="text" id="perfDate" name="perfDate" value="${perfDTO.perfDate}"> </td> <!-- 실적일자(자동생성) -->
						<td ><input type="text" id="perfEmpId" name="perfEmpId" value="${perfDTO.perfEmpId}"></td> <!--  담당자아이디 -->
				        <td ><input type="number" id="perfAmount" name="perfAmount" value= "${perfDTO.perfAmount}" required></td> <!-- 실적수량 -->
						<td ><input type="number" id="perfFair" name="perfFair" required value="${perfDTO.perfFair}"></td> <!-- 양품수-->
						<td ><input type="number" id="perfDefect" name="perfDefect" value="${perfDTO.perfDefect}"></td> <!-- 불량수 -->
						
						<td ><select id="perfDefectreason" name="perfDefectreason" value="${perfDTO.perfDefectreason}">
	                    	    <option value="무결함">무결함</option>
		                      	<option value="파손">파손</option> <!-- 병깨짐 , 포장박스 꾸겨진거 등 -->
								<option value="누락">누락</option> <!--  포장 박스에 물건이 없다던가 포장이 안된다던가 -->
								<option value="기타">기타</option>
						       </select>                                                          </td>  <!-- 불량사유 -->
						       
						<td ><input type="text" id="perfDefectmemo" name="perfDefectmemo"value="${perfDTO.perfDefectmemo}"></td>  <!--기타 불량사유 -->
						<td ><input type="text" id="perfMemo" name="perfMemo" value="${perfDTO.perfMemo}"></td> <!-- 비고 -->
						<td ><input type="text" id="lineProcess" name="perfStatus" value="${perfDTO.perfStatus}"></td> <!-- 라인상테 -->
					</tr>
			</tbody> 
			</table>
	<div class="fbtn">
<input type="submit" value="수정">
</div>		
</form>



<script>

</script>

</body>
</html>