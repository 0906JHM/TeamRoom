<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- sweetalert -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>


<script type="text/javascript">
//
//input으로 바꾸기 
function inputCng(obj, type, name, value) {
	var inputBox = "<input type='"+type+"' name='"+name+"' id='"+name+"8888' value='"+value+"' class='input-row'>";
	obj.html(inputBox);
} //inputCng	

// 팝업 옵션
const popupOpt = "top=60,left=140,width=720,height=600";

//검색 팝업
	function searchItem(type, inputId) {
	 	var url = "${pageContext.request.contextPath}/search/search?type=" + type + "&input=" + inputId;
	var popup = window.open(url, "", popupOpt);
} //openWindow()




function submitForm() {
	  var isValid = true;

	  /* // 유효성 검사
	  $('#reqTable input[required]').each(function() {
	    if ($(this).val().trim() === '') {
	      isValid = false;
	      return false; // 유효성 검사 실패 시 반복문 종료
	    }
	  }); */

	  if (isValid) {
	    $('#fr').submit();
	  } else {
		 	 Swal.fire({
			title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "항목을 모두 입력하세요"+ "</div>",
			icon: 'info',
			width: '300px',
		 });
	  }
	}
var counter = 0;
var addcounter = 0;
var num3 = 0;

function deleteRow() {
	var table = document.getElementById('reqTable');
    var lastRowIndex = table.rows.length - 1; // 마지막 행의 인덱스
    
    if (counter > 0) {
        table.deleteRow(lastRowIndex); // 마지막 행 삭제
    } else {
        console.log("더 이상 삭제할 행이 없습니다.");
    }
	  counter--;
	}	
	
	
$(document).ready(function() {
	    	$('#add').show();
			$('#modify').show();
			$('#delete').show();
		
	
	
	//테이블 항목들 인덱스 부여
	$('table tr').each(function(index){
		var num = "<c:out value='${paging.nowPage}'/>";
		var num2 = "<c:out value='${paging.cntPerPage}'/>";
		$(this).find('td:first').text(((num-1)*num2) + index-1);
		num3 = ((num-1)*num2) + index;
	});
	
	// 추가 시 필요한 변수들

   
    var codeNum = 0;
	var reqCode = 0;
    
    // 추가 버튼 클릭 시 row 생성
   
    

    // 버튼 클릭시 addRow() 기능 불러오기
    $('#add').click(function() {
    	 
    	event.preventDefault();
    	$('#modify').hide();
		$('#delete').hide();
		$('#cancle').show();
		$('#save').show();
		
		$.ajax({
			  url: "${pageContext.request.contextPath}/requirement/reqCode",
			  method: "GET",
			  dataType: "text",
			  success: function(data) {
			    // Ajax 요청 안에서 데이터를 받아와서 변수에 할당 및 후속 작업 수행
			    codeNum = data;
			    console.log("Ajax 내부에서의 codeNum:", codeNum); // Ajax 내부에서의 codeNum: [받아온 데이터]
			    
			    // 변수에 할당된 데이터를 기반으로 추가 작업 수행
			    someFunction(codeNum);
			  }
			}); // ajax 끝

			function someFunction(data) {
				 codeNum = data; // 외부에서의 codeNum: [받아온 데이터]
					 var num = parseInt(codeNum.substring(2)) + counter+1; // 문자열을 숫자로 변환하여 1 증가
					 var paddedNum = padNumber(num, codeNum.length - 2); // 숫자를 패딩하여 길이 유지
					 reqCode = codeNum.charAt(0) + codeNum.charAt(1) + paddedNum.toString(); // 패딩된 숫자를 다시 문자열로 변환
		             addRow();
		             counter++;
			} // someFunction(data)
			
			$('#save').click(function() {
				submitForm();
		}); //save
		
    });
    
    function addRow() {
    	addcounter = num3 + counter;
    	
        var row = '<tr>' +
        	'<td style="color: red;" onclick="deleteRow()">'+addcounter+'</td>' + 
        	'<input type="hidden"  name="reqs[' + counter + '].rawCode" id = "rawCode'+counter+'" required>' + 
            '<td><input type="text" style="background-color:rgba(0, 0, 0, 0);" name="reqs[' + counter + '].reqCode" " value="'+ reqCode +'" readonly required class="input-row"></td>' +
   
            '<input type="hidden" name="reqs[' + counter + '].prodCode" id= "prodCode'+counter+'">' +
            '<td><input type="text" name="reqs[' + counter + '].prod.prodName" id = "prodName'+counter+'" readonly onclick=searchItem("prod","prodCode'+counter+'"); placeholder="제품명을 선택하세요." class="input-row"></td>' +
            '<td><input type="text" name="reqs[' + counter + '].raw.rawName" id="rawName'+counter+'" readonly onclick=searchItem("raw","rawCode'+counter+'"); placeholder="원자재를 선택하세요." class="input-row"></td>' + 
            
            '<td><input type="number" name="reqs[' + counter + '].reqAmount" required class="input-row" value="1" min="1" placeholder="소요량을 선택하세요."></td>' +
            '<td><input type="text" name="reqs[' + counter + '].reqMemo" class="input-row" placeholder="비고를 입력하세요."></td>' +
            
            '</tr>';
            
        $('#reqTable').append(row);
        
    	 // 테이블이 많이 생성되면 스크롤바 생성
        var table = document.getElementById('reqTable');
        table.scrollTop = table.scrollHeight;
		
    }
    
    
    
    function padNumber(number, length) {
        var paddedNumber = number.toString();
        while (paddedNumber.length < length) {
            paddedNumber = "0" + paddedNumber;
        }
        return paddedNumber;
		 } // padNumber(number, length)
    
    // =============================================================================================================


/* 	//취소버튼 -> 리셋
	$('#cancle').click(function(){
		$('#fr').each(function(){
			this.reset();
			//removeRow();
			
		});
	}); //cacle click */
	
	
	
	
	
	
	// 삭제 기능
	$('#delete').click(function(event){
		event.preventDefault();
		$('#delete').hide();
		$('#modify').hide();
		$('#add').hide();
		$('#cancle').show();
		$('#save').show();
		
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
		
		
		//저장 -> 삭제
		$('#save').click(function() {
			
			var checked = [];
			
			$('input[name=selected]:checked').each(function(){
				checked.push($(this).val());
			});
			
//				alert(checked);
			
			if(checked.length > 0) {
				Swal.fire({
					  title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "총" +checked.length+"건\n정말 삭제하시겠습니까?"+ "</div>",
							  // “<div style=’color:#f00;font-size:15px’>” + msg + “</div>”,    //  HTML & CSS 로 직접수정
					  icon: 'info', // 아이콘! 느낌표 색? 표시?
					  showDenyButton: true,
					  confirmButtonColor: 'rgba(94.0000019967556, 195.0000035762787, 151.00000619888306, 1)', // confrim 버튼 색깔 지정
					  cancelButtonColor: '#73879C', // cancel 버튼 색깔 지정
					  confirmButtonText: 'Yes', // confirm 버튼 텍스트 지정
//						  cancelButtonText: '아니오', // cancel 버튼 텍스트 지정
					  width : '300px', // alert창 크기 조절
					  
					}).then((result) => {
						
				
				 /* confirm => 예 눌렀을 때  */
				  if (result.isConfirmed) {
					  
				  
					$.ajax({
 						url: "${pageContext.request.contextPath}/requirement/requirementDelete",
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
								confirmButtonColor: 'rgba(94.0000019967556, 195.0000035762787, 151.00000619888306, 1)', // confrim 버튼 색깔 지정
								  
								width: '300px',
								});
							
						}
					});//ajax
					  } else if (result.isDenied) {
							Swal.fire({
							title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "삭제가 취소되었습니다",
							icon : 'error',
							confirmButtonColor: 'rgba(94.0000019967556, 195.0000035762787, 151.00000619888306, 1)', // confrim 버튼 색깔 지정
							  
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
			}// 체크 XXX

		}); // save
	
		//취소 -> 리셋
		$('#cancle').click(function(){
			$('input:checkbox').prop('checked', false);
		});
		
	}); //delete click
	
	/////////////// 수정 //////////////////////////////
	var isExecuted = false;
	
	//수정버튼 클릭
	
	$('#modify').click(function() {
		
		event.preventDefault();
		$('#delete').hide();
		$('#modify').hide();
		$('#add').hide();
		$('#cancle').show();
		$('#save').show();
		
		Swal.fire({
            text: '수정할 행을 선택해주세요',
            confirmButtonColor: 'rgba(94.0000019967556, 195.0000035762787, 151.00000619888306, 1)',
            
        });

		//행 하나 클릭했을 때	
		$('table tr:not(:first-child)').click(function() {
			
			//하나씩만 선택 가능
			if(!isExecuted) {
				isExecuted = true;
						
				$(this).addClass('selected');
				//품목코드 저장
				let updateCode = $(this).find('#reqCode').text().trim();
				console.log(updateCode);

				var jsonData = {
					reqCode : updateCode
				};

				var self = $(this);

				$.ajax({
					url : "${pageContext.request.contextPath}/requirement/reqOne",
					type : "post",
					contentType : "application/json; charset=UTF-8",
					dataType : "json",
					data : JSON.stringify(jsonData),
					success : function(data) {
						var sum = 0;
						
						var preVOs = [
								data.reqCode,
								data.prodCode,
								data.prod.prodName,
								data.raw.rawName,
								data.reqAmount,
								data.reqMemo,
								data.raw.rawCode
								];
						
					

						var names = [
								"reqCode",
								"prodCode",
								"prodName",
								"rawName",
								"reqAmount",
								"reqMemo",
								"rawCode" 
								];

						//tr안의 td 요소들 input으로 바꾸고 기존 값 띄우기
						
						self.find('td').each(function(idx,item) {
							if (idx > 0) {
								inputCng($(this),"text",names[idx - 1],preVOs[idx - 1] );
							
								$(this).find("input").each(function(){
										if($(this).attr("name") == "reqCode") {
											$(this).attr("readonly", true);
											$(this).attr("style","background-color:rgba(0, 0, 0, 0);");
										}
										else if($(this).attr("name") == "reqAmount") {
											$(this).attr("type", "number");
											$(this).attr("min", "1");
											
										}
								});
								/* 	
								if(idx==7){
									var row = '<input type="hidden" name="rawCode" value="'+preVOs[7]+'" id="rawCode" >'
									$(".selected").append(row);
								} */


							} //라인코드부터 다 수정 가능하게

						}); // self.find(~~)
						  //품번 검색 
						$('#prodName8888').click(function(){
			                searchItem("prod", "prodCode8888");
			            });
						//품번 검색 팝업(raw)
						$('#rawName8888').click(function(){
			                searchItem("raw", "rawCode8888");
			            });
	},
					error : function(data) {
						alert("아작스 실패 ~~");
					}
				}); //ajax

				//저장버튼 -> form 제출
				$('#save').click(function() {

					$('#fr').attr("action","${pageContext.request.contextPath}/requirement/reqModify");
					$('#fr').attr("method","post");
					$('#fr').submit();

				}); //save

			} //하나씩만 선택 가능
				

		}); //tr click

	}); //modify click

    
});

</script>
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

	<h2 style="margin-left: 1%;" onclick="location.href='${pageContext.request.contextPath}/requirement/reqDetail'">소요량 관리</h2>
	<hr>
	<div class="input_value" style="margin: 1% 1%;">	
		<form method="get">
			<fieldset>
				<label>소요코드&nbsp;</label> 
				<input class="input_box" type="text" name="reqCode" onfocus="this.value='RQ'" placeholder="소요량코드를 입력하세요."> &nbsp;&nbsp;
				<label>제품&nbsp;</label> 
				<input type="hidden"name="prodCode" id="prodCode9999">
				<input class="input_box" type="text" name="prodName" id="prodName9999" placeholder="제품명을 선택하세요." readonly onclick="searchItem('prod','prodCode9999')"> &nbsp;&nbsp;
				<label>원자재&nbsp;</label>
				<input type="hidden" name="rawCode" id="rawCode9999">
				<input class="input_box" type="text" name="rawName" id="rawName9999"  placeholder="원자재를 선택하세요." readonly onclick="searchItem('raw','rawCode9999')"> &nbsp;&nbsp;
				<input class="button" type="submit" value="조회">
			</fieldset>
		</form>
	</div>
	<hr>
	<div class="col-md-12 col-sm-12">
		<div class="x_panel">
			
				<div class="x_title">
					
					<div class="x_total">
					<h2><small>총 ${paging.total} 건</small></h2>
						
					</div>
					<div>
						<button style="display: none;"class="button" id="add" >추가</button>
						<button style="display: none;"class="button" id="modify" >수정</button>
						<button style="display: none;"class="button" id="delete" >삭제</button>
						<button style="display: none;" id ="cancle" onclick="location.href='${pageContext.request.contextPath}/requirement/reqDetail'" class="button">취소</button>
						<input style="display: none;" class="button" type="submit" value="저장" id="save">
					</div>						
				</div>
				
				<!-- 버튼 제어 -->
			<form id="fr" method="post">
				<script>
					var team = "${sessionScope.id.emp_department }"; // 팀 조건에 따라 변수 설정

					/* if (team === "물류팀" || team === "관리자") { */
						document.getElementById("add").disabled = false;
						document.getElementById("modify").disabled = false;
						document.getElementById("delete").disabled = false;
						document.getElementById("cancle").disabled = false;
						document.getElementById("save").disabled = false;
						document
								.querySelector("[onclick^='location.href']").disabled = false;
					/* } */ /* else {
						document.getElementById("add").hidden = true;
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
					<table id="reqTable" class="table table-striped jambo_table bulk_action" style="text-align-last:center;">
						<thead>
							<tr class="headings">
								<th>번호</th>
								<th>소요코드</th>
								<th type='hidden' style='display: none;'>품번</th>
								<th>제품</th>
								<th>원자재</th>
								<th>소요량</th>
								<th>비고</th>
							</tr>
						</thead>
							<tr type='hidden' style='display: none;'></tr>
						<c:forEach var="dto" items="${reqList}">
							<tr>
								<td></td>
								<td id="reqCode">${dto.reqCode }</td>
								<td type='hidden' style='display: none;'>${dto.prodCode }</td>
								<td id="prodName"> ${dto.prod.prodName }</td>
								<td id="rawName"> ${dto.raw.rawName }</td>
								<td>${dto.reqAmount }</td>
								<td>${dto.reqMemo }</td>
								<td id="rawCode" type='hidden' style='display: none;'>${dto.raw.rawCode }</td>
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
 <script>
        $(document).ready(function(){
            
        });
    </script>
</body>
</html>

<!-- /page content -->
<%-- <%@ include file="../include/footer.jsp"%> --%>