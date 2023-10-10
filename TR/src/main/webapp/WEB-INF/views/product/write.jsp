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
    <h2>제품 추가</h2>
    
    <form action="${pageContext.request.contextPath}/product/writePro" method="post">
    
    <p>제품코드</p>
    <input type="text" name="prodCode">
    <p>제품명</p>
    <input type="text" name="prodName">
    <p>제품단위</p>
    <input type="text" name="prodUnit">
    <p>용량</p>
    <input type="text" name="prodSize">
    <p>향기</p>
    <input type="text" name="prodPerfume">
    <p>거래처명</p>
    <input type="text" name="clientCode">
    <p>창고명</p>
    <input type="text" name="whseCode">
    <p>매출단가</p>
    <input type="number" step="0.01" name="prodPrice">
    <p>비고</p>
    <input type="text" name="prodMemo">
    
    <input type="submit" value="확인">
    
    </form>
</div>

<script type="text/javascript">
//------------- 제품코드 인풋박스 클릭 시 에이젝스 실행 --------------------------

$('#prodCode9999').click(function(){
   $.ajax({
       url: "${pageContext.request.contextPath}/product/prodCode",
       method: "GET",
       dataType: "text",
       success: function(data) {
           // Ajax 요청에서 데이터를 받아와서 변수에 할당 및 후속 작업 수행
           codeNum = data;
           console.log("Ajax 내부에서의 codeNum:", codeNum); // Ajax 내부에서의 codeNum: [받아온 데이터]

           // 변수에 할당된 데이터를 기반으로 추가 작업 수행
           someFunction(codeNum);
       }
   }); // ajax 끝 */

   document.getElementById("prodCode").textContent = prodCode;



});
</script>
</body>
</html>
