<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- sweetalert -->

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<!-- SheetJS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
<!--FileSaver [savaAs 함수 이용] -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>

<link href="${pageContext.request.contextPath }/resources/css/requirement.css"
	rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/side.css" rel="stylesheet" type="text/css">

<%-- <c:if test="${empty sessionScope.id}">
    <c:redirect url="/smmain/smMain" />
</c:if> --%>


<!-- 폰트 -->

<script type="text/javascript">
	//========================= 함수, 상수 ==================================//

	//오늘 날짜 yyyy-mm-dd
	function getToday() {
		var date = new Date();
		var year = date.getFullYear();
		var month = ("0" + (1 + date.getMonth())).slice(-2);
		var day = ("0" + date.getDate()).slice(-2);

		return year + "-" + month + "-" + day;
	} //getToday()
	
	//날짜 + 시간 + 분 + 초 ==> 코드
	function codeCreation() {
		var date = new Date();
		var year = date.getFullYear();
		var month = ("0" + (1 + date.getMonth())).slice(-2);
		var day = ("0" + date.getDate()).slice(-2);
		var time = ("0" + date.getHours()).slice(-2);
		var minute = ("0" + date.getMinutes()).slice(-2);
		var second = ("0" + date.getSeconds()).slice(-2);
		
		return year + month + day + time + minute + second;
	}
	
	//input으로 바꾸기 
	function inputCng(obj, type, name, value) {
		var inputBox = "<input type='"+type+"' name='"+name+"' id='"+name+"' value='"+value+"'>";
		obj.html(inputBox);
	} //inputCng

	
	
	

	
	//========================= 함수, 상수 ==================================//
	
	//jQuery
	$(function() {
		
		

		/////////////// 추가 /////////////////////////////////////
		$('#add').click(function() {

			$('#modify').attr("disabled", true);
			$('#delete').attr("disabled", true);

			let today = getToday();

			
				
				var tbl = "<tr>";
				// 번호
				tbl += " <td style>";
				tbl += " </td>";
				// 작업지시코드
				tbl += " <td>";
				tbl += "  <input type='text' name='workCode' id='workCode' readonly value='";
				tbl += "WO" + codeCreation();
				tbl += "' >";
				tbl += " </td>";
				// 라인코드
				tbl += " <td>";
				tbl += "  <input type='text' name='lineCode' id='lineCode' required readonly >";
				tbl += " </td>";
				// 수주코드
				tbl += " <td>";
				tbl += "  <input type='text' name='sellCode' id='sellCode' required readonly >";
				tbl += " </td>";
				// 품번
				tbl += " <td>";
				tbl += "  <input type='text' name='prodCode' id='prodCode' required readonly >";
				tbl += " </td>";
				// 지시일
				tbl += " <td>";
				tbl += "  <input type='text' name='workDate' id='workDate' readonly value='";
				tbl += today;
				tbl += "' >";
				tbl += " </td>";
				// 지시수량
				tbl += " <td>";
				tbl += "  <input type='text' name='workAmount' id='workAmount' required >";
				tbl += " </td>";
				//공정
				tbl += " <td>";
				tbl += "  <input type='text' value='1차공정' readonly >";
				tbl += " </td>";
				$('table').append(tbl);
				
				//1차공정 라인 중 사용 가능한 라인 입력
				$.ajax({
					url: "${pageContext.request.contextPath}/workorder/getLine",
					type: "post",
					dataType: "text",
					success: function(data) {
						$('#lineCode').val(data);
					}
				});
				
		

			// 저장 -> form 제출하고 저장함
			$('#save').click(function() {

				var prodCode = $('#prodCode').val();
				var sellCode = $('#sellCode').val();
				var workAmount = $('#workAmount').val();

				/* if (prodCode == "" || sellCode == "" || workAmount == "") {
// 					alert("항목을 모두 입력하세요");
					Swal.fire({
						title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "항목을 모두 입력하세요"+ "</div>",
						icon: 'info',
						width: '300px',
					})
				} else { */
					$('#fr').attr("action", "${pageContext.request.contextPath}/workorder/add");
					$('#fr').attr("method", "post");
					$('#fr').submit();
				/* } */

			}); //save

			//취소버튼 -> 리셋
			$('#cancle').click(function() {
				$('#fr').each(function() {
					this.reset();
				});
			}); //cancle click

		}); //add click

		//재고 부족시 등록 방지, 발주페이지 이동 confirm창
		let queryString = window.location.search;
		let urlParams = new URLSearchParams(queryString);
		var fromController = urlParams.get("woInsert");
		
		if(fromController==0) {
			
			Swal.fire({
				  title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" +"재고가 부족합니다. 발주등록 페이지로 이동하시겠습니까?"+ "</div>",
				  icon: 'info', 
				  showDenyButton: true,
				  confirmButtonColor: '#17A2B8', 
				  cancelButtonColor: '#73879C', 
				  confirmButtonText: 'Yes', 
				  width : '300px',
				
				}).then((result) => {
					
					// confirm => 예를 눌렀을 때
					if(result.isConfirmed){
						location.href = "/stock/raw_order";
					}//if
					//취소 눌렀을 때
					else {
						var url = new URL(window.location.href);
						var searchParams = new URLSearchParams(url.search);
						searchParams.delete("woInsert");
						var newUrl = url.origin + url.pathname;
						
						window.location.href = newUrl;
					}
				});//then
		}
		//재고 부족시 등록 방지, 발주페이지 이동 confirm창
		
		
		var isExecuted = false;
		/////////////// 수정 //////////////////////////////
		//수정버튼 클릭
		$('#modify').click(function() {

			$('#add').attr("disabled", true);
			$('#delete').attr("disabled", true);

			//행 하나 클릭했을 때	
			//:not(:first-child)
			$('table tr').click(function() {

				//하나씩만 선택 가능
				if(!isExecuted) {
					isExecuted = true;
					
					$(this).addClass('selected');
					//작업지시 코드 저장
					let updateCode = $(this).find('#workCode').text().substring(0,16).trim();
					console.log(updateCode);
	
					var jsonData = {
						workCode : updateCode
					};
	
					var self = $(this);
	
					$.ajax({
						url : "${pageContext.request.contextPath}/workorder/detail",
						type : "post",
						contentType : "application/json; charset=UTF-8",
						dataType : "json",
						data : JSON.stringify(jsonData),
						success : function(data) {
							// alert("*** 아작스 성공 ***");
	
							var preVOs = [
									data.workCode,
									data.lineCode,
									data.sellCode,
									data.prodCode,
									data.workDate,
									data.workAmount,
									data.lineProcess
								];
	
							var names = [
									"workCode",
									"lineCode",
									"sellCode",
									"prodCode",
									"workDate",
									"workAmount",
									"lineProcess"
								];
	
							//tr안의 td 요소들 input으로 바꾸고 기존 값 띄우기
							self.find('td').each(function(idx,item) {
	
								if (idx > 0) {
									inputCng($(this),"text",names[idx - 1],preVOs[idx - 1]);
									
									//지시수량 제외하고 readonly 속성 부여
									$(this).find("input").each(function(){
										if($(this).attr("name") != "workAmount") {
											$(this).attr("readonly", true);
										}
									}); //readonly
									
								} //라인코드부터 다 수정 가능하게
							}); // self.find(~~)
	
						},
						error : function(data) {
							alert("아작스 실패 ~~");
						}
					}); //ajax
	
					//저장버튼 -> form 제출
					$('#save').click(function() {
	
						$('#fr').attr("action","${pageContext.request.contextPath}/workorder/modify");
						$('#fr').attr("method","post");
						$('#fr').submit();
	
					}); //save

				} //하나씩만 선택 가능
					
					
				//취소버튼 -> 리셋
				$('#cancle').click(function() {
					$('#fr').each(function() {
						this.reset();
					});
				}); //cancle click

			}); //tr click

		}); //modify click

		//재고 부족시 등록 방지, 발주페이지 이동 confirm창
		queryString = window.location.search;
		urlParams = new URLSearchParams(queryString);
		var fromController = urlParams.get("woModify");
		
// 		console.log(fromController);
		
		if(fromController==0) {
			
			Swal.fire({
				  title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" +"재고가 부족합니다. 발주등록 페이지로 이동하시겠습니까?"+ "</div>",
				  icon: 'info', 
				  showDenyButton: true,
				  confirmButtonColor: '#17A2B8', 
				  cancelButtonColor: '#73879C', 
				  confirmButtonText: 'Yes', 
				  width : '300px',
				
				}).then((result) => {
					
					// confirm => 예를 눌렀을 때
					if(result.isConfirmed){
						location.href = "/stock/raw_order";
					}//if
					//취소 눌렀을 때
					else {
						var url = new URL(window.location.href);
						var searchParams = new URLSearchParams(url.search);
						searchParams.delete("woInsert");
						var newUrl = url.origin + url.pathname;
						
						window.location.href = newUrl;
					}
				});//then
		}
		//재고 부족시 등록 방지, 발주페이지 이동 confirm창
		
		/////////////// 삭제 //////////////////////////////
		$('#delete').click(function() {

			$('#add').attr("disabled", true);
			$('#modify').attr("disabled", true);
	
				// td 요소 중 첫번째 열 체크박스로 바꾸고 해당 행의 작업 지시 코드 저장
				$('table tr').each(function() {
					var code = $(this).find('td:nth-child(2)').text().substring(0,16).trim();
	
					var tbl = "<input type='checkbox' name='selected' value='";
					tbl += code;
					tbl += "'>";
					
					$(this).find('th:first').html("<input type='checkbox' id='selectAll'>");
					$(this).find('td:first').html(tbl);
				});
				
				//전체선택
				$('#selectAll').click(function() {
					var checkAll = $(this).is(":checked");
					
					if (checkAll) {
						$('input:checkbox').prop('checked', true);
					} else {
						$('input:checkbox').prop('checked', false);
					}
				});
	
				//저장 -> 삭제
				$('#save').click(function() {
					
					var checked = [];
	
					$('input[name=selected]:checked').each(function() {
						console.log("check => " + $(this).val());
						checked.push($(this).val());
					});
					
// 					
					
	
					// alert창 꾸미기~
					if(checked.length > 0){
						
						Swal.fire({
							  title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "총" +checked.length+"건\n정말 삭제하시겠습니까?"+ "</div>",
									  // “<div style=’color:#f00;font-size:15px’>” + msg + “</div>”,    //  HTML & CSS 로 직접수정
							  icon: 'info', // 아이콘! 느낌표 색? 표시?
							  showDenyButton: true,
							  confirmButtonColor: '#17A2B8', // confrim 버튼 색깔 지정
							  cancelButtonColor: '#73879C', // cancel 버튼 색깔 지정
							  confirmButtonText: 'Yes', // confirm 버튼 텍스트 지정
//	 						  cancelButtonText: '아니오', // cancel 버튼 텍스트 지정
							  width : '300px', // alert창 크기 조절
							  
							}).then((result) => {
						
						 /* confirm => 예 눌렀을 때  */
						  if (result.isConfirmed) {
							  
						  
							$.ajax({
		 						url: "${pageContext.request.contextPath}/workorder/delete",
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
					}// 체크 XXX
		
				}); // save
				

			//취소 -> 리셋
			$('#cancle').click(function() {
				$('input:checkbox').prop('checked', false);
			});

		}); //delete click

		//============================ 버튼 구현 ====================================//

		//============================ 검색 =========================================//

		//라인코드 검색 팝업
		$('#search_line').click(function() {
			openWindow("line", "search_line");
		}); //lineCode click

		//품번 검색 팝업
		$('#search_prod').click(function() {
			openWindow("prod", "search_prod");
		}); //prodCode click

		//지시일자 이날부터
		$('#search_fromDate').datepicker({
			showOn: 'focus',
			changeMonth:false,
			changeYear:false,
			nextText:'다음달',
			prevText:'이전달',
			showButtonPanel:'true',
			currentText:'오늘',
			closeText:'닫기',
			dateFormat:'yy-mm-dd',
			yearSuffix: '년',
			dayNames:['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
			dayNamesMin:['월','화','수','목','금','토','일'],
			monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			onSelect: function(date, inst) {
				$('#search_toDate').datepicker('option', 'minDate', $(this).datepicker('getDate'));
			}
		});
		
		//이날까지
		$('#search_toDate').datepicker({
			showOn: 'focus',
			changeMonth:false,
			changeYear:false,
			nextText:'다음달',
			prevText:'이전달',
			showButtonPanel:'true',
			currentText:'오늘',
			closeText:'닫기',
			dateFormat:'yy-mm-dd',
			yearSuffix: '년',
			dayNames:['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
			dayNamesMin:['월','화','수','목','금','토','일'],
			monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
		});
		
		
		//검색 결과 없을 때
		if(Number($('#total').text())==0) {
			$('#searchCnt').html("검색 결과가 없습니다.");
		}
		
		//============================ 검색 =========================================//
		
		
		//작업지시코드 클릭시 상세조회
		$('#workCode a').click(function() {
			var obj = { workCode:$('#workCode').text().substring(0,16).trim() };
				
			$.ajax({
				url : "${pageContext.request.contextPath}/workorder/detail",
				type : "post",
				contentType : "application/json; charset=UTF-8",
				dataType : "json",
				data : JSON.stringify(obj),
				success : function(data) {
					
					var tmp = "<table border='1' class='table table-striped jambo_table bulk_action' style='text-align:center;'>";
					tmp += "<tr class='headings'>";
					tmp += " <th>작업지시코드 </th>";
					tmp += "  <td>" + data.workCode + "</td>";
					tmp += " <th> 라인코드 </th>";
					tmp += "  <td>" + data.lineCode + "</td>";
					tmp += " <th> 수주코드 </th>";
					tmp += "  <td>" + data.sellCode + "</td>";
					tmp += " <th> 품번 </th>";
					tmp += "  <td>" + data.prodCode + "</td>";
					tmp += "</tr>";
					tmp += "<tr class='headings'>"; 
					tmp += " <th> 지시일 </th>";
					tmp += "  <td>" + data.workDate + "</td>";
					tmp += " <th> 공정 </th>";
					tmp += "  <td>" + data.lineProcess + "</td>";
					tmp += " <th>지시수량 </th>";
					tmp += "  <td>" + data.workAmount + "</td>";
					tmp += "</tr>";
					tmp += "<tr class='headings'>";
					tmp += " <th> 등록자 </th>";
					tmp += ((data.empId===""||data.empId==null) ? "<td>없음</td>" : "<td>"+data.empId+"</td>");
					tmp += " <th> 변경자 </th>";
					tmp += ((data.changeId===""||data.changeId==null) ? "<td>없음</td>" : "<td>"+data.changeId+"</td>");
					tmp += " <th> 변경일 </th>";
					tmp += ((data.changeDate===""||data.changeDate==null) ? "<td>없음</td>" : "<td>"+data.changeDate+"</td>");
					tmp += "</tr>";
					tmp += "</table>";
					
					
					$('.modal-body').html(tmp);
					$('.modal').modal("show");
				},
				error: function() {
					console.log("아작스 실패");
				}  
			}); //ajax
				
		}); //작업지시코드 클릭
		
		
	}); //jQuery
	
</script>




<body>
<jsp:include page="../inc/side.jsp"></jsp:include>
<!-- page content -->
<div class="right_col">

	<h2 style="margin-left: 1%;" onclick="location.href='${pageContext.request.contextPath}/workorder/workOrderList'">작업지시 관리</h2>
	
	<div style="margin: 1% 1%;">
		<hr>
		<div class="input_value" style="margin: 1% 1%;">	
		<form method="get">
			<fieldset>
				<input type="hidden" name="input" id="input" value="${input }">
				<input type="hidden" name="pageSize" id="pageSize" value="${pdto.cntPerPage }">

				
					<label>라인코드&nbsp;</label> <input type="text" name="search_line" id="search_line" class="input_box" placeholder="라인코드를 선택하세요." style="cursor: pointer;">
				<label>&nbsp;제품명&nbsp;</label> <input type="text" name="search_prod" id="search_prod" class="input_box" placeholder="품목을 선택하세요" style="cursor: pointer;">
				<br>
				<label>지시일자&nbsp;</label> 
						<input type="text" name="search_fromDate" id="search_fromDate" class="input_box" autocomplete="off" placeholder="기간을 선택하세요." style="cursor: pointer;">
						<label style="font: 500 24px/24px 'Inter', sans-serif; left:28px;">&nbsp;~&nbsp;</label> 
						<input type="text" name="search_toDate" id="search_toDate" class="input_box" autocomplete="off" placeholder="기간을 선택하세요." style="cursor: pointer; left:55px;">

				<input type="submit" value="조회" class="button" style="cursor: pointer; left:55px; position: relative;"> 
				<br><br>
				<label>지시상태&nbsp;</label> 
					&nbsp;<input type="radio" name="search_place" id="search_place" class="searchRadio" value="전체" checked> 전체 
					&nbsp;<input type="radio" name="search_place" id="search_place" class="searchRadio" value="1차공정"> 1차공정 
					&nbsp;<input type="radio" name="search_place" id="search_place" class="searchRadio" value="2차공정"> 2차공정 
					&nbsp;<input type="radio" name="search_place" id="search_place" class="searchRadio" value="3차공정"> 3차공정 
					&nbsp;<input type="radio" name="search_place" id="search_place" class="searchRadio" value="마감"> 마감 
			</fieldset>
		</form>
		</div>
		<hr>
	</div>


	<div class="col-md-12 col-sm-12">	
		<div class="x_panel">
		
				<div class="x_title">
				<div class="x_total">
					<h2><small>총 ${pdto.total } 건</small></h2>
					</div>
					<div>
				    <!-- 버튼 제어 -->
						<button id="add" class="button">추가</button>
						<button id="modify" class="button">수정</button>
						<button id="delete" class="button">삭제</button>
						<button onclick="location.href='${pageContext.request.contextPath}/workorder/workOrderList'" id="cancle" class="button">취소</button>
						<button type="submit" id="save" class="button">저장</button>
						</div>
						</div>
					
				
					<script>
					    var team = "${sessionScope.id.emp_department }"; // 팀 조건에 따라 변수 설정
					
					   /*  if (team === "생산팀" || team === "관리자") { */
					        document.getElementById("add").disabled = false;
					        document.getElementById("modify").disabled = false;
					        document.getElementById("delete").disabled = false;
					        document.getElementById("cancle").disabled = false;
					        document.getElementById("save").disabled = false;
					        document.querySelector("[onclick^='location.href']").disabled = false;
					   /*  } else {
					        document.getElementById("add").hidden = true;
					        document.getElementById("modify").hidden = true;
					        document.getElementById("delete").hidden = true;
					        document.getElementById("cancle").hidden = true;
					        document.getElementById("save").hidden = true;
					        document.querySelector("[onclick^='location.href']").hidden = true;
					    } */
					</script>
					<!-- 버튼 제어 -->
					

				
				
<div class="x_content">
	<div class="table-responsive">
		<div class="table-wrapper" >

		<form id="fr">
			<input type="hidden" name="empId" value="${sessionScope.id.empId }">
			<table class="table table-striped jambo_table bulk_action" style="text-align-last:center;" id="data-table">
				<thead>
					<tr class="headings">
						<th>번호</th>
						<th>작업지시코드</th>
						<th>라인코드</th>
						<th>수주코드</th>
						<th>품번</th>
						<th>지시일</th>
						<th>지시수량</th>
						<th>공정</th>
						<%-- <c:if test="${id.emp_department eq '생산팀' || id.emp_department eq '관리자'}"> --%>
							<th>마감</th>
						<%-- </c:if> --%>
					</tr>
				</thead>
				
				<c:forEach var="w" items="${workList }">
					<tr class="contents">
						<td class="a-center"></td>
						<td id="workCode">${w.workCode }<a href="#" onclick="return false" style="text-decoration:none;">&#128269;</a></td>
						<td id="lineCode">${w.lineCode }</td>
						<td>${w.sellCode }</td>
						<td id="prodCode">${w.prodCode }</td>
						<td>${w.workDate }</td>
						<td id="workAmount">${w.workAmount }</td>
						<td id="linePlace">${w.lineProcess }</td>
						<%-- <c:if test="${id.emp_department eq '생산팀' || id.emp_department eq '관리자'}"> --%>
							<td>
								<c:if test="${w.lineProcess != '마감'}">
									<a id="magamBtn" class="button" href="${pageContext.request.contextPath}/workorder/updateStatus?workCode=${w.workCode }&lineCode=${w.lineCode }&lineProcess=${w.lineProcess}">공정마감</a>
								</c:if>
							</td>
						<%-- </c:if> --%>
					</tr>
				</c:forEach>
			</table>
		</form>
		</div>
	</div>
</div>

	<div style="float:left;">
	<button id="excelDownload" class="Button">엑셀⬇️</button>
		
	<script type="text/javascript">
		
		//엑셀
		const excelDownload = document.querySelector('#excelDownload');
		
		document.addEventListener('DOMContentLoaded', ()=> {
			excelDownload.addEventListener('click', exportExcel);
		});
		
		function exportExcel() {
			//1. workbook 생성
			var wb = XLSX.utils.book_new();
			
			//2. 시트 만들기
			var newWorksheet = excelHandler.getWorksheet();
			
			//3. workbook에 새로 만든 워크시트에 이름을 주고 붙이기
			XLSX.utils.book_append_sheet(wb, newWorksheet, excelHandler.getSheetName());
			
			//4. 엑셀 파일 만들기
			var wbout = XLSX.write(wb, {bookType:'xlsx', type:'binary'});
			
			//5. 엑셀 파일 내보내기
			saveAs(new Blob([s2ab(wbout)], {type:"application/octet-stream"}), excelHandler.getExcelFileName());
			
		} //exportExcel()
		
		var excelHandler = {
			getExcelFileName : function() {
				return 'workOrderList'+getToday()+'.xlsx'; //파일명
			},
			getSheetName : function() {
				return 'Work Order Sheet'; //시트명
			},
			getExcelData : function() {
				return document.getElementById('data-table'); //table id
			},
			getWorksheet : function() {
				return XLSX.utils.table_to_sheet(this.getExcelData());
			}
		} //excelHandler
		
		function s2ab(s) {
			var buf = new ArrayBuffer(s.length);  // s -> arrayBuffer
			var view = new Uint8Array(buf);  
			for(var i=0; i<s.length; i++) {
				view[i] = s.charCodeAt(i) & 0xFF;
			}
			return buf;
		} //s2ab(s)
	</script>
	</div>
	
	<div id="pagination" class="page_wrap">
			<div class="page_nation">
						<c:if test="${pdto.startPage != 1 }">
							<a class="arrow prev" href="${pageContext.request.contextPath}/workorder/workOrderList?page=${pdto.startPage - 1 }&pageSize=${pdto.cntPerPage }&search_line=${search.search_line}&search_fromDate=${search.search_fromDate}&search_toDate=${search.search_toDate}&search_place=${search.search_place}&search_prod=${search.search_prod}">◀️</a>
						</c:if>
					
						<c:forEach begin="${pdto.startPage }" end="${pdto.endPage }" var="p">
							<a class="active" href="${pageContext.request.contextPath}/workorder/workOrderList?page=${p }&pageSize=${pdto.cntPerPage }&search_line=${search.search_line}&search_fromDate=${search.search_fromDate}&search_toDate=${search.search_toDate}&search_place=${search.search_place}&search_prod=${search.search_prod}">${p }</a>
						</c:forEach>
					
						<c:if test="${pdto.endPage != pdto.lastPage}">
							<a class="arrow next" href="${pageContext.request.contextPath}/workorder/workOrderList?page=${pdto.endPage + 1 }&pageSize=${pdto.cntPerPage }&search_line=${search.search_line}&search_fromDate=${search.search_fromDate}&search_toDate=${search.search_toDate}&search_place=${search.search_place}&search_prod=${search.search_prod}">▶️</a>
						</c:if>
					</div>
			</div>
	
	
	
</div>

</div>

		
	<!-- 상세보기 모달창 -->
	<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">작업지시 상세</h4>
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 상세보기 모달창 -->
	
	
</div>
</body>

<!-- /page content -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
