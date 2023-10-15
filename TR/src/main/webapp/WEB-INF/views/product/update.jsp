<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
<%--     <jsp:include page="test4.jsp"></jsp:include> --%>
    <title>roomair</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- 		추가안되면 사이드바에 있는 이거^때문임 -->

<link
	href="${pageContext.request.contextPath }/resources/css/productWrite.css"
	rel="stylesheet" type="text/css">

</head>
<body>

<div class="container"> 
    <h2>제품 추가</h2>
    
    <form action="${pageContext.request.contextPath}/product/updatePro" method="post">
    <div class="form-group">
    <p>제품코드</p>
    <input type="text" name="prodCode" value="${prodDTO.prodCode}">
    </div>
    <div class="form-group">
    <p>제품명</p>
    <input type="text" name="prodName" value="${prodDTO.prodName}">
    </div>
    <div class="form-group">
    <p>제품단위</p>
    <input type="text" name="prodUnit" value="${prodDTO.prodUnit}">
    </div>
    <div class="form-group">
    <p>용량</p>
    <input type="text" name="prodSize" value="${prodDTO.prodSize}">
    </div>
    <div class="form-group">
    <p>향기</p>
    <input type="text" name="prodPerfume" value="${prodDTO.prodPerfume}">
    </div>
    <div class="form-group">
    <p>거래처명</p>
    <input type="text" name="clientCode" value="${prodDTO.clientCode}">
    </div>
    <div class="form-group">
    <p>창고명</p>
    <input type="text" name="whseCode" value="${prodDTO.whseCode}">
    </div>
    <div class="form-group">
    <p>매출단가</p>
    <input type="number" step="0.01" name="prodPrice" value="${prodDTO.prodPrice}">
    </div>
    <p>비고</p>
<%--     <input type="text" name="prodMemo" value="${prodDTO.prodMemo}"> --%>
    <textarea name="prodMemo" class="prodMemo"  rows="5" cols="">${prodDTO.prodMemo}</textarea>
    <div id="button">
    <input type="submit" value="수정">
    </div>
    </form>
</div>


</body>
</html>
