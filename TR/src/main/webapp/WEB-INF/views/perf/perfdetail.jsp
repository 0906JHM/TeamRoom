<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10/dist/sweetalert2.min.css">

</head>
<body>
<form id="detailform">
<table class="tg">
<thead>
  <tr>
    <th class="tg-0lax">생산실적코드</th>
    <th class="tg-0lax">작업지시코드</th>
    <th class="tg-0lax">라인코드</th>
    <th class="tg-0lax">제품코드</th>
    <th class="tg-0lax">실적일</th>
    <th class="tg-0lax">담당자</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-0lax" id="perfCodeDisplay">${perfDTO.perfCode}</td>
    <td class="tg-0lax">${perfDTO.workCode}</td>
    <td class="tg-0lax">${perfDTO.lineCode}</td>
    <td class="tg-0lax">${perfDTO.prodCode}</td>
    <td class="tg-0lax">${perfDTO.perfDate}</td>
    <td class="tg-0lax">${perfDTO.perfEmpId}</td>
  </tr>
  <tr>
    <td class="tg-0lax">실적수</td>
    <td class="tg-0lax">양품수</td>
    <td class="tg-0lax">불량수</td>
    <td class="tg-0lax">불량사유</td>
    <td class="tg-0lax">기타</td>
    <td class="tg-0lax">비고</td>
  </tr>
  <tr>
    <td class="tg-0lax">${perfDTO.perfAmount}</td>
    <td class="tg-0lax" id="perfFairDisplay">${perfDTO.perfFair} </td>
   <td class="tg-0lax" id="perfDefectInput">${perfDTO.perfDefect}</td>
  <td class="tg-0lax" id="perfDefectReasonDisplay">${perfDTO.perfDefectreason}</td>
  <td class="tg-0lax" id="perfDefectMemoDisplay">${perfDTO.perfDefectmemo}</td>
   <td class="tg-0lax" id="perfMemoDisplay">${perfDTO.perfMemo}</td>
  </tr>
</tbody>
</table>

<div class="footerbtn">
<div>
<input type="button" class="okbtn" id="okbtn" value="확인">
<input type="button" class="updatebtn" id="updatebtn" value="수정(버그있음)">
<input type="button" class="update2" id="update2" value="수정">
<input type="button" class="deletebtn" id="deletebtn" value="삭제">
<input type="button" class="cancelbtn" id="cancelbtn" value="취소">
</div>

</div>
</form>
<script>
/* 

document.addEventListener("DOMContentLoaded", function() {
    var modifyButton = document.querySelector(".updatebtn");
    var confirmButton = document.querySelector(".okbtn");
    var cancelButton = document.querySelector(".cancelbtn");
    var perfDefectInput = document.getElementById("perfDefectInput");
    var perfDefectDisplay = document.getElementById("perfDefectDisplay");
    var perfDefectReasonDisplay = document.getElementById("perfDefectReasonDisplay");
    var perfDefectMemoDisplay = document.getElementById("perfDefectMemoDisplay");
    var perfMemoDisplay = document.getElementById("perfMemoDisplay");
    
    var perfFairInput, perfDefectReasonSelect, perfDefectMemoInput, perfMemoInput;

    
    
  
    
    
    //변수 초기화
    perfFairInput = createInputBox(perfFairDisplay.textContent.trim());
    perfDefectReasonSelect = createSelectBox(defectReasonSelectOptions, selectedDefectReason);
    var defectReasonSelectOptions = ['무결함', '파손', '누락', '기타']; // 불량사유 옵션
    perfDefectMemoInput = createInputBox(perfDefectMemoDisplay.textContent || perfDefectMemoDisplay.innerText);
    perfMemoInput = createInputBox(perfMemoDisplay.textContent || perfMemoDisplay.innerText);
    
    

    // 초기에는 취소 버튼을 숨깁니다.
    cancelButton.style.display = "none";
    
// 수정 버튼 클릭 이벤트 핸들러
modifyButton.addEventListener("click", function() {
    // 삭제 버튼 비활성화
    document.querySelector(".deletebtn").style.display = "none";

    // 양품수, 불량수, 불량사유, 기타, 비고 칸에 input 상자를 생성
    
    perfFairDisplay.innerHTML = "";
    perfFairDisplay.appendChild(perfFairInput);

    console.log("perfDefectDisplay.textContent: " + perfDefectInput.textContent);
    console.log("perfDefectDisplay.innerText: " + perfDefectInput.innerText);
	    var existingPerfDefectInput = document.getElementById("perfDefectInput"); // 기존의 perfDefectInput 요소 가져오기
	    var newPerfDefectInput = createInputBox(perfDefectInput.textContent || perfDefectDisplay.innerText);
    console.log(newPerfDefectInput); // perfDefectInput이 제대로 가져와지는지 확인해보기
    perfDefectInput.innerHTML = ""; // perfDefectDisplay의 내용을 비우기
    perfDefectInput.appendChild(newPerfDefectInput); // 새로운 perfDefectInput을 perfDefectDisplay에 추가

    
    var selectedDefectReason = perfDefectReasonDisplay.textContent || perfDefectReasonDisplay.innerText;
    
    perfDefectReasonDisplay.innerHTML = "";
    perfDefectReasonDisplay.appendChild(defectReasonSelect);

    
    perfDefectMemoDisplay.innerHTML = "";
    perfDefectMemoDisplay.appendChild(perfDefectMemoInput);


    perfMemoDisplay.innerHTML = "";
    perfMemoDisplay.appendChild(perfMemoInput);

    // 불량사유 제어
    defectReasonSelect.addEventListener("change", function() {
        // 선택된 불량사유 값 가져오기
        var selectedValue = defectReasonSelect.value;

        // 만약 불량사유가 "무결함", "파손", "누락"인 경우 기타 불량사유 입력란 비활성화, 그렇지 않으면 활성화
        if (selectedValue === "무결함" || selectedValue === "파손" || selectedValue === "누락") {
            perfDefectMemoInput.disabled = true; // 비활성화
        } else {
            perfDefectMemoInput.disabled = false; // 활성화
        }
    });

    // 확인 버튼, 취소 버튼 활성화
    confirmButton.style.display = "inline";
    cancelButton.style.display = "inline";

    // 수정 완료 후의 처리 (생략되어 있음)
});





confirmButton.addEventListener("click", function() {
	console.log("Confirm button clicked");
	
	

    
   // 수정된 값 가져오기
        var updatedPerfFair = parseInt(perfFairInput.value, 10);
        var updatedPerfDefect = parseInt(perfDefectInput.value, 10); // 수정된 부분
        
        console.log("perfFairInput value: ", perfFairInput.value);
        console.log("perfDefectInput textContent: ", perfDefectInput.textContent);
        
        var updatedPerfDefectreason = perfDefectReasonSelect.value;
        var updatedPerfDefectmemo = perfDefectMemoInput.value; // 수정된 부분
        var updatedPerfMemo = perfMemoInput.value;
    
 // 테스트를 위해 출력
    console.log("Updated Values:");
    console.log("perfFair: ", updatedPerfFair);
    console.log("perfDefect: ", updatedPerfDefect);
    console.log("perfDefectreason: ", updatedPerfDefectreason);
    console.log("perfDefectmemo: ", updatedPerfDefectmemo);
    console.log("perfMemo: ", updatedPerfMemo);
    console.log("perfCode: ", perfCode);
    

    // 서버로 데이터 전송
    $.post("/tr/perf/update", {
        perfCode: perfCode,
        perfFair: updatedPerfFair,
        perfDefect: updatedPerfDefect,
        perfDefectreason: updatedPerfDefectreason,
        perfDefectmemo: updatedPerfDefectmemo,
        perfMemo: updatedPerfMemo
    }, function(response) {
        // 서버 응답에 대한 처리 코드
        if (response.success) {
            console.log("등록 성공"); // 디버깅 메시지
            // 성공 메시지를 표시할 수 있는 코드
            Swal.fire({
                title: '등록 성공',
                text: '성공적으로 등록되었습니다.',
                icon: 'success'
            }).then(function() {
                location.reload(); // 페이지 새로고침
            });
        } else {
            console.log("등록 실패"); // 디버깅 메시지
            // 실패 메시지를 표시할 수 있는 코드
            Swal.fire({
                title: '등록 실패',
                text: '등록에 실패하였습니다.',
                icon: 'error'
            });
        }
    });
});




//input 상자 생성 함수
function createInputBox(value) {
    var input = document.createElement('input');
    input.type = 'text';
    input.value = value;
    return input;
}

// select 상자 생성 함수
function createSelectBox(options, selectedValue) {
    var select = document.createElement('select');
    options.forEach(function(option) {
        var optionElement = document.createElement('option');
        optionElement.value = option;
        optionElement.text = option;
        if (option === selectedValue) {
            optionElement.selected = true;
        }
        select.appendChild(optionElement);
    });
    return select;
}
}); */

// ↑↑↑↑↑↑↑↑↑↑↑수정해야함 ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑


//addButton 클릭 이벤트 처리
$('#update2').click(function() {
	
	var perfCode = $('#perfCodeDisplay').text();
	
    window.open(
        '${pageContext.request.contextPath}/perf/perfupdate?perfCode='+perfCode,
        '_blank',
        'width=1200px, height=800px, left=500px, top=100px'
    );
});




$('#deletebtn').click(function() {
    var perfCode = $('#perfCodeDisplay').text();
    // 서버로 perfCode 값을 전송하여 해당 행을 삭제
    $.post("${pageContext.request.contextPath}/perfajax/delete", {
        perfCode: perfCode
    })
    .done(function(response) {
        // 성공 응답을 받은 경우
        Swal.fire({
            title: '삭제 성공',
            text: '성공적으로 삭제되었습니다.',
            icon: 'success'
        }).then(function() {
            location.reload(); // 페이지 새로고침
            window.opener.location.reload(); // 부모 창 새로고침
        });
    })
    .fail(function(response) {
        // 실패 응답을 받은 경우
        Swal.fire({
            title: '삭제 실패',
            text: '삭제에 실패하였습니다.',
            icon: 'error'
        });
    });
});




</script>

</body>
</html>