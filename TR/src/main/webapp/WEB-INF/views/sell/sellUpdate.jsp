<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
<%--     <jsp:include page="test4.jsp"></jsp:include> --%>
    <title>sellUpdate</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- 		추가안되면 사이드바에 있는 이거^때문임 -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-zrve{background-color:#0949f7;border-color:#3531ff;text-align:center;vertical-align:top}
.tg .tg-llyw{background-color:#c0c0c0;border-color:inherit;text-align:left;vertical-align:top}
.tg .tg-0pky{border-color:inherit;text-align:left;vertical-align:top}

</style>

</head>
<body>

<div class="container"> 
    <h2>수주 정보</h2>
    
    <form action="${pageContext.request.contextPath}/sell/sellUpdatePro" method="post">

			
			<label>수주 코드</label>
			<input type="text" name="prodCode" value="${sellDTO.sellCode}" readonly>
			<br>
			<label>처리 상태</label>
			<input type="text" name="prodCode" value="${sellDTO.sellState}" readonly>
			<br>
			<label>거래처</label>
			<input type="text" id="clientCode9999" name="clientCode" onclick=searchItem('client','clientCode9999'); placeholder="${sellDTO.clientCode}" readonly >
        	<input type="text" id="clientCompany9999" placeholder="${sellDTO.clientCompany}" onclick=searchItem('client','clientCode9999'); readonly >
			<br>
			<label>제품</label>
			<input type="text" name="prodCode" id="prodCode9999" onclick=searchItem('prod','prodCode9999'); placeholder="${sellDTO.prodCode}" readonly>
	      	<input type="text" name="prodName" id="prodName9999" placeholder="${sellDTO.prodName}" readonly onclick="searchItem('prod','prodCode9999')">
			<br>
			<label>제품 단가</label>
			<input type="text" name="prodPrice" id="prodPrice9999" onclick=searchItem('prod','prodPrice9999'); value="${sellDTO.prodPrice}"readonly>원
			<br>
			<label>수주 수량</label>
			<input type="number" id="sellCount" name="sellCount" min="0" max="10000" step="5" value="${sellDTO.sellCount}" onchange="calculateSellPrice()">개<br>
			<br>
			<label>수주 단가</label>
			<input type="number" step="0.01" name="prodPrice" value="${sellDTO.sellPrice}" pattern="###,###원" />
			<br>
			<label>수주 일자</label>
			<input type="text" id="sellDate" name="sellDate" value="${sellDTO.sellDate}"readonly><br> 
			<br>
			<label>납기 일자</label>
			<input type="text" id="sellDate" name="sellDate" value="${sellDTO.sellDuedate}"readonly><br> 
			<br>
			<label>담당자</label>
			<input type="text" name="prodMemo" value="${sellDTO.sellEmpId}" readonly>
			<br>
			<label>비고</label>
			<input type="text" name="prodMemo" value="${sellDTO.sellMemo}">
			<br>
			
			<c:if test="${sessionScope.id == sellDTO.sellEmpId}">
			<input type="submit" value="수정">
			</c:if>
			<button type="button" onclick="window.close()">닫기</button>
 
    </form>
</div>


</body>
</html>
