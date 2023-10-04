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
    <h2>완제품 관리</h2>
    
    <form action="${pageContext.request.contextPath}/product/list" method="get" id="fr">
        <label>제품코드</label>  <input type="text" placeholder="제품코드를 입력하세요." name="a1">
        <label>제품명</label> <input type="text" placeholder="제품명을 입력하세요." name="a2">
        <label>거래처명</label> <input type="text" placeholder="거래처를 선택하세요." name="a3">
        <button type="submit">조회</button>
    </form>
<%--     <form action="${pageContext.request.contextPath}/product/write" method="post"> --%>
    <a type="button" href="${pageContext.request.contextPath}/product/write" id="add">추가</a>
    <button id="modify">수정</button>
    <button id="delete">삭제</button>
    <button id="cancel">취소</button>
    <button id="save">저장</button>
   
    <p>총 1건</p>
    
    <table class="tg" id="productTable">
<!--         <thead> -->
<!--             <tr> -->
<!--                 <th class="tg-zrve" colspan="10">완제품관리</th> -->
<!--             </tr> -->
<!--         </thead> -->
        <tbody>
            <tr>
                <td class="tg-llyw">번호</td>
                <td class="tg-llyw">제품코드</td>
                <td class="tg-llyw">제품명</td>
                <td class="tg-llyw">제품단위</td>
                <td class="tg-llyw">용량</td>
                <td class="tg-llyw">향기종류</td>
                <td class="tg-llyw">거래처명</td>
                <td class="tg-llyw">창고명</td>
                <td class="tg-llyw">매출단가</td>
                <td class="tg-llyw">비고</td>
            </tr>

<!-- <tr type='hidden' style='display: none;'></tr> -->
			
			<c:forEach var="prodDTO" items="${prodList}">
					<tr>
						<td> </td>
         			    <td id="prodCode">${prodDTO.prodCode }</td>
						<td id="prodName">${prodDTO.prodName }</td>
						<td id="prodUnit">${prodDTO.prodUnit }</td>
						<td id="prodSize">${prodDTO.prodSize }</td>
						<td id="prodPerfume">${prodDTO.prodPerfume }</td>
<%-- 						<td type='hidden' style='display: none;'>${prodDTO.clientCode }</td> --%>
<%-- 						<td>${vo.clients.client_actname }</td> --%>
						<td id="clientCode">${prodDTO.clientCode }</td>
<%-- 						<td type='hidden' style='display: none;'>${prodDTO.whseCode }</td> --%>
<%-- 						<td>${prodDTO.whseName }</td> --%>
						<td id="whseCode">${prodDTO.whseCode }</td>
						<td id="prodPrice"><fmt:formatNumber>${prodDTO.prodPrice }</fmt:formatNumber></td>
						<td id="prodMemo">${prodDTO.prodMemo }</td>
					</tr>
			</c:forEach>
        </tbody>
    </table>
</div>



</body>
</html>
