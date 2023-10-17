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
    
    <form action="${pageContext.request.contextPath}/product/writePro" method="post">
    
    <div class="form-group">
    <p>제품코드</p>
    <input type="text" name="prodCode" value="${prodDTO.prodCode }" readonly="readonly">
    </div>
    <div class="form-group">
    <p>제품명</p>
    <input type="text" name="prodName" placeholder="제품명을 입력해 주세요">
    </div>
    <div class="form-group">
    <p>제품단위</p>
    <input type="text" name="prodUnit"  placeholder="제품 단위를 입력해 주세요.">
    </div>
    <div class="form-group">
    <p>용량</p>
    <input type="text" name="prodSize"  placeholder="용량을 입력해 주세요.">
    </div>
    <div class="form-group">
    <p>향기</p>
    <input type="text" name="prodPerfume"  placeholder="향기를 입력해 주세요.">
    </div>
    <div class="form-group">
    <p>거래처명</p>
    <input type="hidden" name="clientCode" id="clientCode9999" onclick="searchItem('client','clientCode9999')" >
    <input type="text" name="clientCompany" id="clientCompany9999"  readonly
    	onclick="searchItem('client','clientCode9999')"
    	 placeholder="거래처를 선텍해 주세요.">
    </div>
    <div class="form-group">
    <p>창고명</p>
    <input type="hidden" name="whseCode" id="whseCode" onclick="searchItem('whse','whseCode9999')">
    <input type="text" name="whseCode" id="whseName9999"  placeholder="창고를 선택해 주세요."
    onclick="searchItem('whse','whseCode9999')">
    </div>
    <div class="form-group">
    <p>매출단가</p>
    <input type="number" step="0.01" name="prodPrice" placeholder="매출 단가를 입력해 주세요.">
    </div>
    <p>비고</p>
     <textarea name="prodMemo" class="prodMemo" placeholder="비고를 입력해 주세요." rows="5" cols=""></textarea>
<!--     </div> -->
    <div id="button">
    <input type="submit" value="확인">
    </div>
    </form>
</div>

<script type="text/javascript">


$(document).ready(function() {
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

           function someFunction(data) {
                codeNum = data; // 외부에서의 codeNum: [받아온 데이터]
                    var num = parseInt(codeNum.substring(2)) + counter+1; // 문자열을 숫자로 변환하여 1 증가
                    var paddedNum = padNumber(num, codeNum.length - 2); // 숫자를 패딩하여 길이 유지
                    prodCode = codeNum.charAt(0) + codeNum.charAt(1) + paddedNum.toString(); // 패딩된 숫자를 다시 문자열로 변환
                    counter++;
           } // someFunction(data)

           document.getElementById("prodCode").textContent = prodCode;
	});
    
    
	
});//ready

//--------------------------------------------------------------------------
// 팝업 옵션
const popupOpt = "top=60,left=140,width=720,height=600";

//검색 팝업
	function searchItem(type, inputId) {
	 	var url = "${pageContext.request.contextPath}/search/search?type=" + type + "&input=" + inputId;
	var popup = window.open(url, "", popupOpt);
} //openWindow()
//--------------------------------------------------------------------------

document.addEventListener('DOMContentLoaded', function() {
        document.getElementsByName("prodName")[0].focus();
    });

</script>
</body>
</html>
