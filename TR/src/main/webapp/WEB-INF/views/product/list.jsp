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
    <script
		src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<!-- J쿼리 호출 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="../resources/js/scripts.js"></script>
	
	<script src="../resources/js/productList_im.js"></script>
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
    
    <form id="productList">
    <table class="tg" id="productTable">
    <thead>
        <tr>
            <!-- 체크박스 열 추가 -->
            <th><input type="checkbox" id="select-list-all" name="select-list-all" data-group="select-list"></th>
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
             <td><input type="checkbox" id="select-list" value ="${prodDTO.prodCode}" name="selectedProId" data-group="select-list"></td>
                <!-- 체크박스 열 -->
                <td id="prodCode">
                <a href="#" onclick="openPopup2('${pageContext.request.contextPath}/product/update?prodCode=${prodDTO.prodCode}')">${prodDTO.prodCode}</a>
<%--                 ${prodDTO.prodCode} --%>
                </td>
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
</form>
</div>

<script>

var contextPath = "${pageContext.request.contextPath}";
  function openAdd() {
    var url = "${pageContext.request.contextPath}/product/write";
    var newWindow = window.open(url, "_blank");
    newWindow.focus();
  }

<!-------------------------- 목록 전체선택 -------------------------->


// thead의 체크박스를 클릭했을때 전체체크가되게끔 이벤트를 발생시킨다

$(document).ready(function() {
$('#select-list-all').click(function() {
			var checkAll = $(this).is(":checked");
			
			if(checkAll) {
				$('input:checkbox').prop('checked', true);
			} else {
				$('input:checkbox').prop('checked', false);
			}
		});
		
//삭제 버튼 누를 시 실행되는 함수
$('#delete').click(function(event){	
	
		
		var checked = [];
		
		$('input[name=selectedProId]:checked').each(function(){
			checked.push($(this).val());
		});
		
//			alert(checked);
		
		if(checked.length > 0) {
			Swal.fire({
				  title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "총" +checked.length+"건\n정말 삭제하시겠습니까?"+ "</div>",
						  // “<div style=’color:#f00;font-size:15px’>” + msg + “</div>”,    //  HTML & CSS 로 직접수정
				  icon: 'info', // 아이콘! 느낌표 색? 표시?
				  showDenyButton: true,
				  confirmButtonColor: '#17A2B8', // confrim 버튼 색깔 지정
				  cancelButtonColor: '#73879C', // cancel 버튼 색깔 지정
				  confirmButtonText: 'Yes', // confirm 버튼 텍스트 지정
//					  cancelButtonText: '아니오', // cancel 버튼 텍스트 지정
				  width : '300px', // alert창 크기 조절
				  
				}).then((result) => {
			
			 /* confirm => 예 눌렀을 때  */
			  if (result.isConfirmed) {
				  
			  
				$.ajax({
						url: "${pageContext.request.contextPath}/product/delete",
						type: "POST",
						data: {checked : checked},
						dataType: "text",	
						success: function () {
							Swal.fire({
							  title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "총" +checked.length+"건 삭제 완료",
							  icon: 'success',
							  width : '300px',
							}).then((result) => {
							  if (result.isConfirmed) {
							    location.reload();
							  }
							});
					},
					error: function () {
						Swal.fire({
							title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "삭제 중 오류가 발생했습니다",
							icon : 'question',
							width: '300px',
							});
						
					}
				});//ajax
				  } else if (result.isDenied) {
						Swal.fire({
						title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "삭제가 취소되었습니다",
						icon : 'error',
						width: '300px',
						});
			}// if(confirm)
		});		
				
		}// 체크OOO
		else{
			Swal.fire({
				title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "선택된 항목이 없습니다",
				icon : 'warning',
				width: '300px',
				});
		}
		
		// endAJAX(물품 삭제)
	 // end 정규식검사

}); 
//
});// end function


//update 페이지 팝업창
function openPopup2(url) {
	const myWindow = window.open(url, "DetailPopup", "location=0,status=1,scrollbars=1,resizable=1,menubar=0,toolbar=no,width=400,height=700");
	myWindow.moveTo(0, 0);
	myWindow.focus();
	}


//팝업창에서 작업 완료후 닫고 새로고침
$(document).ready(function() {
	var refreshAndClose = true; // refreshAndClose 값을 변수로 설정
    if (refreshAndClose) {
        window.opener.location.reload(); // 부모창 새로고침
        window.close(); // 현재창 닫기
    }
});

</script>

</body>
</html>
