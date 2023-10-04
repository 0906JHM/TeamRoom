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
    <form action="${pageContext.request.contextPath}/product/writePro" method="post">
    <button id="add">추가</button>
    <button id="modify">수정</button>
    <button id="delete">삭제</button>
    <button id="cancel">취소</button>
    <button id="save">저장</button>
    </form>
    <p>총 1건</p>
    <table class="tg" id="productTable">
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
						<td></td>
         			    <td id="prodCode">${prodDTO.prodCode }</td>
						<td id="prodName">${prodDTO.prodName }</td>
						<td id="prodUnit">${prodDTO.prodUnit }</td>
						<td id="prodSize">${prodDTO.prodSize }</td>
						<td id="prodPerfume">${prodDTO.prodPerfume }</td>
<%-- 						<td type='hidden' style='display: none;'>${prodDTO.clientCode }</td> --%>
<%-- 						<td>${vo.clients.client_actname }</td> --%>
						<td id="clientCode">${prodDTO.clientCode }</td>
<%-- 						<td type='hidden' style='display: none;'>${prodDTO.whseCode }</td> --%>
<%-- 						<td>${vo.wh.wh_name }</td> --%>
						<td id="whseCode">${prodDTO.whseCode }</td>
						<td id="prodPrice"><fmt:formatNumber>${prodDTO.prodPrice }</fmt:formatNumber></td>
						<td id="prodMemo">${prodDTO.prodMemo }</td>
					</tr>
			</c:forEach>
        </tbody>
    </table>
</div>

<!-- ----------------------------------------------------------------------- -->
<script type="text/javascript">
$(document).ready(function() {

	
	
	//추가버튼 누르면 행추가
    $('#add').click(function(event) {
        event.preventDefault();
        addRow();
    });
    //저장버튼 누르면 데이터 저장
    $('#save').click(function(event) {
        event.preventDefault();
        saveData();
    });
    
    //취소버튼 누르면 행 새로고침
    $('#cancel').click(function(event) {
     event.preventDefault();
     location.reload();
 	});
    
 // 삭제 기능
    $('#delete').click(function(){
    	event.preventDefault();
    	$('#add').attr("disabled", true);
    	$('#modify').attr("disabled", true);
    				
    	// td 요소 중 첫번째 열 체크박스로 바꾸고 해당 행의 작업 지시 코드 저장
    	$('table tr').each(function(){
    	var code = $(this).find('td:nth-child(2)').text();
    					
    	var tbl = "<input type='checkbox' name='selected' value='";
    	tbl += code;
    	tbl += "'>";
    					
    	$(this).find('th:first').html("<input type='checkbox' id='selectAll'>");
    	$(this).find('td:first').html(tbl);
    	});
    				
    	$('#selectAll').click(function() {
    	var checkAll = $(this).is(":checked");
    					
	    	if(checkAll) {
	    		$('input:checkbox').prop('checked', true);
	    	} else {
	    		$('input:checkbox').prop('checked', false);
	    	}
   		 });
    });
  
});

var rowCount = 1; // 초기 행 번호 설정

// function addRow() {
//     var table = document.getElementById('productTable').getElementsByTagName('tbody')[0];
    
//     var numRowsToAdd = 1; // 한 번에 추가할 행의 개수

//     for (var i = 0; i < numRowsToAdd; i++) {
//         var newRow = table.insertRow(table.rows.length);

//         for (var j = 0; j < 10; j++) {
//             var cell = newRow.insertCell(j);

//             if (j === 0) {
//                 // 첫 번째 셀에는 일련번호 설정 (rowCount 사용)
//                 cell.innerHTML = rowCount++;
//             } else {
//                 // 나머지 셀에는 입력 필드 추가
//                 cell.innerHTML = '<input type="text">';
//             }
            
//         }
//     }
// }

function addRow() {
    var table = document.getElementById('productTable').getElementsByTagName('tbody')[0];
    
    var numRowsToAdd = 1; // 한 번에 추가할 행의 개수

    for (var i = 0; i < numRowsToAdd; i++) {
        var newRow = table.insertRow(table.rows.length);

        for (var j = 0; j < 10; j++) {
            var cell = newRow.insertCell(j);

            if (j === 0) {
                // 첫 번째 셀에는 일련번호 설정 (rowCount 사용)
                cell.innerHTML = rowCount++;
            } else {
                // 나머지 셀에는 입력 필드 추가
                if (j === 1) {
                    // prodCode 입력 필드
                    cell.innerHTML = '<input type="text" name="prodCode" class="input-fieldb">';
                } else if (j === 2) {
                    // prodName 입력 필드
                    cell.innerHTML = '<input type="text" name="prodName" class="input-fieldb">';
                } else if (j === 3) {
                    // prodUnit 입력 필드
                    cell.innerHTML = '<input type="text" name="prodUnit" class="input-fieldb">';
                } else if (j === 4) {
                    // prodSize 입력 필드
                    cell.innerHTML = '<input type="text" name="prodSize" class="input-fieldb">';
                } else if (j === 5) {
                    // prodPerfume 입력 필드
                    cell.innerHTML = '<input type="text" name="prodPerfume" class="input-fieldb">';
                } else if (j === 6) {
                    // clientCode 입력 필드
                    cell.innerHTML = '<input type="text" name="clientCode" class="input-fieldb">';
                } else if (j === 7) {
                    // whseCode 입력 필드
                    cell.innerHTML = '<input type="text" name="whseCode" class="input-fieldb">';
                } else if (j === 8) {
                    // prodPrice 입력 필드
                    cell.innerHTML = '<input type="text" name="prodPrice" class="input-fieldb">';
                } else if (j === 9) {
                    // prodMemo 입력 필드
                    cell.innerHTML = '<input type="text" name="prodMemo" class="input-fieldb">';
                }
            }
        }
    }
}


function saveData() {
    var table = document.getElementById('productTable').getElementsByTagName('tbody')[0];
    var newRow = table.rows[table.rows.length - 1]; // 마지막 행 가져오기

    var data = []; // 행의 데이터를 저장할 배열

    for (var j = 1; j < 10; j++) {
        var inputElement = newRow.cells[j].querySelector('input');
        var cellValue = inputElement.value;
        data.push(cellValue);
        
        // 값을 저장한 후 입력 필드를 비활성화(disabled) 상태로 변경
        inputElement.setAttribute('disabled', 'disabled');
    }

    // 여기서 data 배열에 저장된 데이터를 원하는 방식으로 처리하면 됩니다.
    // 예를 들어, 서버에 전송하거나 로컬 스토리지에 저장할 수 있습니다.

    // 데이터 처리 후, 필요한 작업을 수행하세요.
    alert('데이터가 저장되었습니다: ');
}





</script>


</body>
</html>
