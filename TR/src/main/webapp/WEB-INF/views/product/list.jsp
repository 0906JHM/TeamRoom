<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>

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
    <h2>제품 관리</h2>
    
    <form action="${pageContext.request.contextPath}/product/search" method="get" id="selectedProId">
        <label>제품코드</label>  <input type="text" placeholder="제품코드를 입력하세요." name="prodCode">
        <label>제품명</label> <input type="text" placeholder="제품명을 입력하세요." name="prodName">
        <label>거래처명</label> 
        <select id="cusType" name="clientCode" class="form-control search-input">
        	<option value="거래처">거래처</option>
	        <option value="거래처1">거래처1</option>
	        <option value="거래처2">거래처2</option>
	        <option value="거래처3">거래처3</option>
		</select>
<!--         <input type="text" placeholder="거래처를 선택하세요." name="a3"> -->
        <button type="submit">조회</button>
    </form>
    
<%--     <form action="${pageContext.request.contextPath}/product/write" method="post"> --%>
    <button id="add"  onclick="openAdd()" >추가</button>
    <button id="modify">수정</button>
<!--     <button id="delete" onclick="deleteSelectedProducts()">삭제</button> -->
	<button id="delete">삭제</button>
    <button id="cancel">취소</button>
    <button id="save">저장</button>
   
    <p>총 ${prodList.size()}건</p>
    <table class="tg" id="productTable">
    <thead>
        <tr>
            <!-- 체크박스 열 추가 -->
            <th><input type="checkbox" id="select-list-all" name="select-list" data-group="select-list"></th>
            <th>제품코드</th>
            <th>제품명</th>
            <th>제품단위</th>
            <th>용량</th>
            <th>향기종류</th>
            <th>거래처명</th>
            <th>창고명</th>
            <th>매출단가</th>
            <th>비고</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="prodDTO" items="${prodList}">
            <tr>
             <td><input type="checkbox" id="select-list" name="selectedProId" data-group="select-list"></td>
                <!-- 체크박스 열 -->
                <td id="prodCode">${prodDTO.prodCode}</td>
                <td id="prodName">${prodDTO.prodName}</td>
                <td id="prodUnit">${prodDTO.prodUnit}</td>
                <td id="prodSize">${prodDTO.prodSize}</td>
                <td id="prodPerfume">${prodDTO.prodPerfume}</td>
                <td id="clientCode">${prodDTO.clientCode}</td>
                <td id="whseCode">${prodDTO.whseCode}</td>
                <td id="prodPrice"><fmt:formatNumber>${prodDTO.prodPrice}</fmt:formatNumber></td>
                <td id="prodMemo">${prodDTO.prodMemo}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
</div>

<script>

var contextPath = "${pageContext.request.contextPath}";
  function openAdd() {
    var url = "${pageContext.request.contextPath}/product/write";
    var newWindow = window.open(url, "_blank");
    newWindow.focus();
  }

<!-------------------------- 목록 전체선택 -------------------------->
//체크박스 전체선택
// var selectAllCheckbox = document.getElementById("select-list-all");
// var checkboxes = document.querySelectorAll('[data-group="select-list"]');
// selectAllCheckbox.addEventListener("change", function () {
//     checkboxes.forEach(function (checkbox) {
//         checkbox.checked = selectAllCheckbox.checked;
//     });
// });
// checkboxes.forEach(function (checkbox) {
//     checkbox.addEventListener("change", function () {
//         if (!this.checked) {
//             selectAllCheckbox.checked = false;
//         } else {
//             // 모든 체크박스가 선택되었는지 확인
//             var allChecked = true;
//             checkboxes.forEach(function (c) {
//                 if (!c.checked) {
//                     allChecked = false;
//                 }
//             });
//             selectAllCheckbox.checked = allChecked;
//         }
//     });
// });

// thead의 체크박스를 클릭했을때 전체체크가되게끔 이벤트를 발생시킨다
$('input[name="selectedAllProId"]').click(function() {
    // 모든 selectedProId 체크박스의 상태를 selectedAllProId와 동일하게 설정한다
    // $this로 AllProId의 상태를 가져온다
    $('input[name="selectedProId"]').prop('checked', $(this).prop('checked'));
});// end function


//----------------------------------------------------------------------------------------------

// function deleteSelectedProducts() {
//   // 체크된 체크박스 수집
//   var selectedCheckboxes = document.querySelectorAll('[data-group="select-list"]:checked');

//   // 체크된 체크박스들의 prodCode 값을 배열에 저장
//   var selectedProdCodes = [];
//   selectedCheckboxes.forEach(function (checkbox) {
//     var row = checkbox.closest("tr");
//     var prodCode = row.querySelector("#prodCode").textContent;
//     selectedProdCodes.push(prodCode);
//   });

//   // 배열을 JSON 형태로 변환
//   var jsonData = JSON.stringify(selectedProdCodes);

//   // AJAX 요청 보내기
// var xhr = new XMLHttpRequest();
// xhr.open('POST', contextPath + '/product/delete', true);

//   xhr.setRequestHeader('Content-Type', 'application/json');
//   xhr.onreadystatechange = function () {
//     if (xhr.readyState === 4 && xhr.status === 200) {
//       // 서버로부터 응답을 받았을 때 처리할 작업
//       // 예: 페이지 새로고침 또는 결과 메시지 표시
//       location.reload(); // 페이지 새로고침 예시
//     }
//   };
//   xhr.send(jsonData);
// }



// 삭제 버튼 누를 시 실행되는 함수
$("#delete").click(function() {
	
	// 체크박스가 체크된 여부를 확인하기위한 변수선언
	var selectedCheckbox = $("input[name='select-list']:checked");
	
// 체크박스가 선택되어 있지 않다면 에러 메시지를 표시하고 함수 종료
if (selectedCheckbox.length === 0) {
    Swal.fire('삭제할 행을 선택해 주십시오.', '실패', 'error');
    return;
}

// 선택된 체크박스의 값을 가져와서 사용할 수 있도록 처리
var selectedProductCodes = selectedCheckbox.map(function() {
    return $(this).closest('tr').find('#prodCode').text(); // 예제 코드에서는 각 행의 제품 코드를 가져옴
}).get();

// 필요한 데이터를 정리하여 AJAX를 실행
var formData = {
    selectedProId: selectedProductCodes
};

$.ajax({
    type: "POST",
    url: "${pageContext.request.contextPath}/product/delete",
    data: formData,
    // AJAX 통신 결과 처리
    success: function(response) {
        // 성공 또는 실패에 따른 처리를 진행하세요.
    },
    error: function() {
        Swal.fire('서버 통신에 문제가 발생했습니다.', '실패', 'error');
    }
});

});
//
</script>

</body>
</html>
