<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- sweetalert -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/requirement.js"></script>

<%-- <c:if test="${empty sessionScope.id}">
    <c:redirect url="/smmain/smMain" />
</c:if> --%>
<link href="${pageContext.request.contextPath }/resources/css/requirement.css"
	rel="stylesheet" type="text/css">
<%-- <%@ include file="../include/header.jsp"%> --%>
<link href="${pageContext.request.contextPath }/resources/css/side.css"
	rel="stylesheet" type="text/css">
	
<!-- 사이드바 -->
<title>requirement</title>
</head>
<body>
<jsp:include page="../inc/side.jsp"></jsp:include>
<!-- 사이드바 -->
<!-- page content -->
<div class="right_col">

	<h2 style="margin-left: 1%;">소요량 관리</h2>
	<hr>
	<div class="input_value" style="margin: 1% 1%;">	
		<form method="get">
			<fieldset>
				<label>소요코드&nbsp;</label> 
				<input class="input_box" type="text" name="reqCode" id="searchCode" placeholder="소요량코드를 입력하세요."> &nbsp;&nbsp;
				<label>제품명&nbsp;</label> 
				<input type="hidden"name="prodCode" id="prodCode9999"> 
				<input class="input_box" type="text"name="prodName" id="prodName9999" placeholder="제품명을 선택하세요." readonly onclick="serchProd('prodCode9999')" class="input-fieldc"> &nbsp;&nbsp;
				<label>원자재&nbsp;</label>
				<input type="hidden" name="rawCode" id="rawCode9999"> 
				<input class="input_box" type="text" name="rawName" id="rawName9999" placeholder="원자재를 선택하세요." readonly onclick="serchRaw('rawCode9999')" class="input-fieldc"> &nbsp;&nbsp;
				<input class="button" type="submit" class="B B-info" value="조회">
			</fieldset>
		</form>
	</div>
	<hr>
	<div class="col-md-12 col-sm-12">
		<div class="x_panel">
			
				<div class="x_title">
					
					<div class="x_total">
					<h2><small>총 ${paging.total} 건</small></h2>
						<c:if test="${empty param.input }">
							<button onclick="location.href='${pageContext.request.contextPath}/requirement/reqDetail'" class="button" style="width:40px;">↻</button>
						</c:if>
						<c:if test="${!empty param.input }">
							<button onclick="location.href='${pageContext.request.contextPath}/requirement/reqDetail?input=${param.input }'" class="button" style="width:40px;">↻</button>
						</c:if>
					</div>
					<div>
						<button class="button" id="addButton" >추가</button>
						<button class="button" id="modify" >수정</button>
						<button class="button" id="delete" >삭제</button>
						<button class="button" type="reset" id="cancle" >취소</button>
						<input class="button" type="submit" value="저장" id="save">
					</div>						
				</div>
				
				<!-- 버튼 제어 -->
			<form id="fr" method="post">
				<script>
					var team = "${sessionScope.id.emp_department }"; // 팀 조건에 따라 변수 설정

					/* if (team === "물류팀" || team === "관리자") { */
						document.getElementById("addButton").disabled = false;
						document.getElementById("modify").disabled = false;
						document.getElementById("delete").disabled = false;
						document.getElementById("cancle").disabled = false;
						document.getElementById("save").disabled = false;
						document
								.querySelector("[onclick^='location.href']").disabled = false;
					/* } */ /* else {
						document.getElementById("addButton").hidden = true;
						document.getElementById("modify").hidden = true;
						document.getElementById("delete").hidden = true;
						document.getElementById("cancle").hidden = true;
						document.getElementById("save").hidden = true;
						document
								.querySelector("[onclick^='location.href']").hidden = true;
					} */
				</script>
				<!-- 버튼 제어 -->
		<div class="x_content">
			<div class="table-responsive">
				<div class="table-wrapper" >
					<table id="reqTable" style="text-align-last: center;">
						<thead>
							<tr class="headings">
								<th>번호</th>
								<th>소요코드</th>
								<th type='hidden' style='display: none;'>품번</th>
								<th>제품명</th>
								<th>원자재</th>
								<th>소요량</th>
								<th>비고</th>
							</tr>
						</thead>
							<tr type='hidden' style='display: none;'></tr>
						<c:forEach var="dto" items="${reqList}">
							<tr class="contents">
								<td></td>
								<td id="reqCode">${dto.reqCode }</td>
								<td type='hidden' style='display: none;'>${dto.prodCode }</td>
								<%-- <td id="prodName">${dto.prod.prodName }</td> --%>
								<%-- <td>${dto.raw.rawName }</td> --%>
								<td>${dto.reqAmount }</td>
								<td>${dto.reqMemo }</td>
							</tr>
						</c:forEach>
					</table>
					</div>
					</div>
				</div>
			</form>
			
			<div id="pagination" class="page_wrap">
			<div class="page_nation">
						<c:if test="${paging.startPage != 1 }">
							<a class="arrow prev" href="${pageContext.request.contextPath}/requirement/reqDetail?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}&reqCode=${dto.reqCode }&prodCode=${dto.prodCode }&rawCode=${dto.rawCode }">◀️</a>
						</c:if>
					
						<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
							<a class="active" href="${pageContext.request.contextPath}/requirement/reqDetail?nowPage=${p }&cntPerPage=${paging.cntPerPage}&reqCode=${dto.reqCode }&prodCode=${dto.prodCode }&rawCode=${dto.rawCode }">${p }</a>
						</c:forEach>
					
						<c:if test="${paging.endPage != paging.lastPage}">
							<a class="arrow next" href="${pageContext.request.contextPath}/requirement/reqDetail?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}&reqCode=${dto.reqCode }&prodCode=${dto.prodCode }&rawCode=${dto.rawCode }">▶️</a>
						</c:if>
					</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>

<!-- /page content -->
<%-- <%@ include file="../include/footer.jsp"%> --%>