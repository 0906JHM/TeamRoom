<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- sweetalert -->

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<!-- SheetJS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
<!--FileSaver [savaAs 함수 이용] -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>

<link href="${pageContext.request.contextPath }/resources/css/requirement.css"
	rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/side.css" rel="stylesheet" type="text/css">


<!-- /page content -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- 모달창 script -->
	<script>
      //modal창에 열기 위한 이벤트 헨들러
        function openModal(e) {
        	//modal창의 id 값 할당
            const myModal = document.getElementById("myModal");
           const elements = [];
            for (let i = 1; i <= 10; i++) {
                elements[i] ='element' + i;
            }
        	//클릭한 요소의 name의 속성 값을 가져와서 clickedElementName변수에 저장한다
        	//즉 이 부분은 클릭한 요소의 name속성을 추출하는 역할
        	// "getBoundingClientRect()" 메서드를 사용하여 클릭한 요소의 화면 좌표 정보를 가져옵니다.
        	// 이 정보는 모달 창의 위치를 설정하는 데 사용됩니다.           
            /* const clickedElementValue = e.getAttribute("name"); */
        	
        	//클릭한 요소의 좌표정보 
            const rect = e.getBoundingClientRect();
           
            
        	// 클릭한 요소의 오른쪽 아래 모서리의 화면 좌표를 "x"와 "y" 변수에 저장합니다.
        	// 이것은 모달 창을 클릭한 요소의 위치에 배치하는 데 사용됩니다.
            var xr = rect.right;
            var xl = rect.left;
            var yt = rect.top;
            var yb = rect.bottom; 
            var xg = (xr-xl)/2;
            var yg = (yt-yb)/2;
            var x =  xl+xg;
            var y = yb+yg;
           
            //클릭후에 모달창을 생성하는 위치를 조정
            myModal.style.left = x + "px";
            myModal.style.top = y + "px";
            myModal.style.display = "block";
            
            // modalContent를 초기화 (이전 내용 지우기)
            myModal.innerHTML = "";
           
            //닫기
            myModal.innerHTML = `<span id="closeModalButton" style="cursor: pointer;">닫기</span><br>`;
            const clickedElementId = e.getAttribute("id");
            if(clickedElementId.startsWith("PR")){
            	//modal_ajax 
            	$.ajax({
            	  url : '${pageContext.request.contextPath}/KDMajax/modalprod',
            	  data: {prodCode:clickedElementId},
            	  type : 'GET',
            	  dataType:'json',
            	  success: function (json) {
                      if (json && typeof json === 'object') {
                    	  
                    	// 값 할당
                    	addInput("제품 코드:", elements[0],json.prodCode);
            	addInput("제품 단위:", elements[1],json.prodUnit);
            	addInput("용량:", elements[2],json.prodSize);
            	addInput("향기 종류:", elements[3],json.prodPerfume);
            	addInput("거래처 코드:", elements[4],json.clientCode);
                addInput("창고 코드:", elements[5],json.whseCode);
                addInput("매출 단가:", elements[6],json.prodPrice);
                addInput("제품 비고:", elements[7],json.prodMemo);
                    	} else {
                    	    // JSON 데이터가 없거나 빈 경우에 대한 처리를 추가
                    	    console.error("JSON 데이터가 비어 있거나 유효하지 않습니다. json: " + JSON.stringify(json));
                    	}

                  }
              });	
            	

      	  } else if(clickedElementId.startsWith("SL")){
              	//modal_ajax 
              	$.ajax({
              	  url : '${pageContext.request.contextPath}/KDMajax/modalsell',
              	  data: {sellCode:clickedElementId},
              	  type : 'GET',
              	  dataType:'json',
              	  success: function (json) {
                        if (json && typeof json === 'object') {
                        	// 값 할당
                        	

                      	addInput("수주 일자:", elements[0],json.sellDate);
              	addInput("납기 일자:", elements[1],json.sellDuedate);
              	addInput("관리 사원:", elements[2],json.sellEmpId);
              	addInput("수주 수량:", elements[3],json.sellCount);
                  addInput("수주 단가:", elements[4],json.sellPrice);
                  addInput("제품 코드:", elements[5],json.prodCode);
                  addInput("제품 이름:", elements[6],json.prodName);
                  addInput("수주 비고:", elements[7],json.sellMemo);
                  addInput("출고 상태:", elements[8],json.sellState);
                  addInput("거래처 이름:", elements[9],json.clientCompany);
                  addInput("거래처 코드:", elements[10],json.clientCode);
                      	} else {
                      	    // JSON 데이터가 없거나 빈 경우에 대한 처리를 추가
                      	    console.error("JSON 데이터가 비어 있거나 유효하지 않습니다. json: " + JSON.stringify(json));
                      	}
                        }
                });	//기존 닫기 창 함수
               
        } //ajax
            closeModalButton.addEventListener("click", function (e) {
          	    if (e.target === closeModalButton) {
          	        myModal.style.display = "none";
          	    }
          	});
      }    
            //input시 동적으로 생성하기 위한 함수
            function addInput(label, id, value) {
                const div = document.createElement("div");
                const input = document.createElement("input");
                div.style.display = "flex";
                div.style.justifyContent = "flex-end";
                input.type = "text";
                input.id = id;
                input.value = value; // 값을 설정
                input.size = 8;
                input.readOnly = true;
                div.appendChild(document.createTextNode(label));
                div.appendChild(input);
                myModal.appendChild(div);
            }
          	
        
               
    </script>
<!-- 폰트 -->

<script type="text/javascript">
	//========================= 함수, 상수 ==================================//
	// 팝업 옵션
const popupOpt = "top=60,left=140,width=720,height=600";

//검색 팝업
	function searchItem(type, inputId) {
	 	var url = "${pageContext.request.contextPath}/search/search?type=" + type + "&input=" + inputId;
	var popup = window.open(url, "", popupOpt);
} //openWindow()

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
		var inputBox = "<input type='"+type+"' name='"+name+"' id='"+name+"8888' value='"+value+"' class='input-row'>";
		obj.html(inputBox);
	} //inputCng

	
	
	

	
	//========================= 함수, 상수 ==================================//
	
	//jQuery
	$(function() {
		
		

		/////////////// 추가 /////////////////////////////////////
		$('#add').click(function() {

			/* $('#modify').attr("disabled", true); */
			$('#modify').hide();
			$('#add').hide();
			$('#delete').hide();
			$('#cancle').show();
			$('#save').show();

			let today = getToday();

			
				
				var tbl = "<tr>";
				// 번호
				tbl += " <td style>";
				tbl += " </td>";
				// 작업지시코드
				tbl += " <td>";
				tbl += "  <input type='text' style='background-color:rgba(0, 0, 0, 0);' class='input-row' name='workCode' id='workCode' readonly value='";
				tbl += "WO" + codeCreation();
				tbl += "' >";
				tbl += " </td>";
				// 라인코드
				tbl += " <td>";
				tbl += "  <input type='text' style='background-color:rgba(0, 0, 0, 0);' class='input-row' name='lineCode' id='lineCode8888' readonly >";
				tbl += " </td>";
				// 수주코드
				tbl += " <td>";
				tbl += "  <input type='text' class='input-row' name='sellCode' id='sellCode8888' required readonly >";
				tbl += " </td>";
				// 제품코드
				tbl += " <td style='display: none;'>";
				tbl += "  <input type='hidden' name='prodCode' id='prodCode8888'>";
				tbl += " </td>";
				// 제품명
				tbl += " <td>";
				tbl += "  <input type='text' style='background-color:rgba(0, 0, 0, 0);' class='input-row' name='prodName' id='prodName8888' readonly>";
				tbl += " </td>";
				// 지시일
				tbl += " <td>";
				tbl += "  <input type='text' style='background-color:rgba(0, 0, 0, 0);' class='input-row' name='workDate' id='workDate' readonly value='";
				tbl += today;
				tbl += "' >";
				tbl += " </td>";
				// 지시수량
				tbl += " <td>";
				tbl += "  <input type='number' class='input-row' value='1' min='1' name='workAmount' id='workAmount8888' required >";
				tbl += " </td>";
				//공정
				tbl += " <td>";
				tbl += "  <input type='text' style='background-color:rgba(0, 0, 0, 0);' class='input-row' value='1차공정' readonly >";
				tbl += " </td>";
				$('table').append(tbl);
				var lineCode
				//1차공정공정 라인 중 사용 가능한 라인 입력
				$.ajax({
					url: "${pageContext.request.contextPath}/workorder/getLine",
					type: "post",
					dataType: "text",
					success: function(data) {
						$('#lineCode8888').val(data);
						lineCode = $('#lineCode8888').val();
						if (lineCode == ""){
							Swal.fire({
								title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "사용가능한 라인이 없습니다"+ "</div>",
								icon: 'info',
								confirmButtonColor: '#9AC5F4',
								width: '400px',
							}).then((result) => {
							    if (result.isConfirmed) {
							        // 확인 버튼을 눌렀을 때 특정 주소로 이동
							    	window.location.href = window.location.href;
							    }
							});
						}
					}
				});
				
				
				
			
				$('#sellCode8888').click(function() {
					searchItem("sell", "sellCode8888");
				});
				
		

			// 저장 -> form 제출하고 저장함
			$('#save').click(function() {

				var prodName = $('#prodName').val();
				
				var sellCode = $('#sellCode8888').val();
				var workAmount = $('#workAmount8888').val();
			
					 if (sellCode == "" || workAmount == "") {
							Swal.fire({
								title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "항목을 모두 입력하세요"+ "</div>",
								icon: 'info',
								confirmButtonColor: '#9AC5F4',
								width: '400px',
							})
						} else { 
							$('#fr').attr("action", "${pageContext.request.contextPath}/workorder/add");
							$('#fr').attr("method", "post");
							$('#fr').submit();
						 } 
				});
				//save
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
				  width : '400px',
				
				}).then((result) => {
					
					// confirm => 예를 눌렀을 때
					if(result.isConfirmed){
						location.href = "${pageContext.request.contextPath}/OrderManagement/home";
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
			Swal.fire({
				 title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "수정할 행을 선택해주세요"+ "</div>",
				  // “<div style=’color:#f00;font-size:15px’>” + msg + “</div>”,    //  HTML & CSS 로 직접수정
		  icon: 'info', // 아이콘! 느낌표 색? 표시?
	            confirmButtonColor: '#9AC5F4',
	         });		  
			$('#delete').hide();
			$('#modify').hide();
			$('#add').hide();
			$('#cancle').show();
			$('#save').show();

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
									data.prodName,
									data.workDate,
									data.workAmount,
									data.workProcess,
									""
								];
	
							var names = [
									"workCode",
									"lineCode",
									"sellCode",
									"prodCode",
									"prodName",
									"workDate",
									"workAmount",
									"workProcess",
									"magam"
								];
	
							//tr안의 td 요소들 input으로 바꾸고 기존 값 띄우기
							self.find('td').each(function(idx,item) {
	
								if (idx > 0) {
									inputCng($(this),"text",names[idx - 1],preVOs[idx - 1]);
									
									//지시수량 제외하고 readonly 속성 부여
									$(this).find("input").each(function(){
										if($(this).attr("name") != "workAmount") {
											$(this).attr("readonly", true);
											$(this).attr("style","background-color:rgba(0, 0, 0, 0);");
										}
										else if($(this).attr("name") == "workAmount") {
											$(this).attr("type", "number");
											$(this).attr("min", "1");
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
						var workAmount = $('#workAmount8888').val();
						if(workAmount <= 0){
							Swal.fire({
								title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "1이상의 값을 입력해주세요"+ "</div>",
								icon: 'info',
								confirmButtonColor: '#9AC5F4',
								width: '400px',
							})
							}
						else{
							$('#fr').attr("action","${pageContext.request.contextPath}/workorder/modify");
						$('#fr').attr("method","post");
						$('#fr').submit();
						}
	 
						
	
					}); //save

				} //하나씩만 선택 가능
			

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
				  width : '400px',
				
				}).then((result) => {
					
					// confirm => 예를 눌렀을 때
					if(result.isConfirmed){
						location.href = "${pageContext.request.contextPath}/OrderManagement/home";
					}
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
			$('#delete').hide();
			$('#modify').hide();
			$('#add').hide();
			$('#cancle').show();
			$('#save').show();
	
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
							   confirmButtonColor: '#9AC5F4', // confrim 버튼 색깔 지정
  cancelButtonColor: '#73879C', // cancel 버튼 색깔 지정
							  confirmButtonText: 'Yes', // confirm 버튼 텍스트 지정
	 						  cancelButtonText: 'No', // cancel 버튼 텍스트 지정
							  width : '400px', // alert창 크기 조절
							  
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
										  confirmButtonColor: '#9AC5F4', // confrim 버튼 색깔 지정

										  width : '400px',
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
										confirmButtonColor: '#9AC5F4', // confrim 버튼 색깔 지정

										width: '400px',
										});
									
								}
							});//ajax
							  } else if (result.isDenied) {
									Swal.fire({
									title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "삭제가 취소되었습니다",
									confirmButtonColor: '#9AC5F4', // confrim 버튼 색깔 지정
									  
									icon : 'error',
									width: '400px',
									});
						}// if(confirm)
					});		
							
					}// 체크OOO
					else{
						Swal.fire({
							title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "선택된 항목이 없습니다",
							icon : 'warning',
							confirmButtonColor: '#9AC5F4',
							width: '400px',
							});
					}// 체크 XXX
		
				}); // save
				

			
		}); //delete click

		//============================ 버튼 구현 ====================================//

		//============================ 검색 =========================================//


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
		
		
		
	}); //jQuery
	
</script>


</head>

<body>
<!-- 모달창 -->
	<div id="myModal" class="modaldetail">
	</div>
	<!-- 모달창 -->
<jsp:include page="../inc/side.jsp"></jsp:include>
<!-- page content -->
<div class="right_col">

	<h2 style="cursor: pointer; " onclick="location.href='${pageContext.request.contextPath}/workorder/workOrderList'">작업지시 관리</h2>

		
		<form method="get">
			<div class="searchform">
				<input type="hidden" name="input" id="input" value="${input }">
				<label>라인</label> <input type="text" name="search_line" id="search_line" class="input_box" placeholder="라인을 입력하세요." style="cursor: pointer;">
				<label>제품</label> <input type="text" name="search_prod" id="search_prod" class="input_box" placeholder="제품을 선택하세요" onclick="searchItem('prod','search_prod')" style="cursor: pointer;">
				<label>지시일자</label> 
						<input type="text" name="search_fromDate" id="search_fromDate" class="input_box" autocomplete="off" placeholder="기간을 선택하세요." style="cursor: pointer;">
						<label style="margin:0px"> ~ </label> 
						<input style="margin-left:" type="text" name="search_toDate" id="search_toDate" class="input_box" autocomplete="off" placeholder="기간을 선택하세요." style="cursor: pointer;"><br><br>
				<label><input style="width:70px" type="submit"  class="button" name="search_place" id="allButton" value="전체">
    		<input style="width:70px" type="submit"  name="search_place" class="button" id="oneButton" value="1차공정">
    		<input style="width:70px" type="submit"  name="search_place" class="button" id="twoButton" value="2차공정">
    		<input style="width:70px" type="submit"  name="search_place" class="button" id="threeButton" value="3차공정">
    		<input style="width:70px" type="submit"  name="search_place" class="button" id="finishButton" value="마감" ></label> 
				<div id="button">
			
				
			
		</div>
		</div>	
		</form>



	<div class="col-md-12">	
	<div style ="margin: 2% 0 0 0;"	>
	<div style="float:right;">
				    <!-- 버튼 제어 -->
						<button style="display: none;" id="add" class="button">추가</button>
						<button style="display: none;" id="modify" class="button">수정</button>
						<button style="display: none;" id="delete" class="button">삭제</button>
						<button style="display: none;" id="cancle" onclick="location.href='${pageContext.request.contextPath}/workorder/workOrderList'" id="cancle" class="button">취소</button>
						<button style="display: none;" type="submit" id="save" class="button">저장</button>
						</div>
						</div>
		<div class="x_panel">
		
				<div class="x_title">
				
					<label style="margin:0px">총 ${paging.total } 건</label>
					<div>
					<label for="perPageSelect" >항목 수:</label>
<select id="perPageSelect" class="input_box" style ="top:1.8px; width:100px; height:22px;" onchange="applyFilters()" value="${paging.cntPerPage}">
    <option value="10" ${paging.cntPerPage == 10 ? 'selected' : ''}>10개</option>
    <option value="50" ${paging.cntPerPage == 50 ? 'selected' : ''}>50개</option>
    <option value="100" ${paging.cntPerPage == 100 ? 'selected' : ''}>100개</option>
    <option value="9999" ${paging.cntPerPage == 9999 ? 'selected' : ''}>전체 보기</option>
</select>
					</div>
					
					
						</div>
					
				
					<script>
					
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
						<th>제품</th>
						<th>지시일</th>
						<th>지시수량</th>
						<th>공정</th>
						<%-- <c:if test="${id.emp_department eq '생산팀' || id.emp_department eq '관리자'}"> --%>
							<th>마감</th>
						<%-- </c:if> --%>
					</tr>
				</thead>
				<tr style='display: none;'></tr>
				<c:forEach var="w" items="${workList }">
					<tr class="contents">
						<td></td>
						<td id="workCode">${w.workCode }</td>
						<td id="lineCode">${w.lineCode }</td>
						<td style='cursor: pointer;' onclick="openModal(this)" id="${w.sellCode }" name="sellCode" value="${w.sellCode}">${w.sellCode}</td>
						<td style='display: none;' id="prodCode">${w.prodCode }</td>
						<td style='cursor: pointer;' onclick="openModal(this)" id="${w.prodCode }" name="prodName" value="${w.prodName }">${w.prodName }</td>
								
						<c:choose>
    <c:when test="${not empty w.workDatechange}">
        <td style="color: red;">${w.workDatechange}</td>
    </c:when>
    <c:otherwise>
        <td>${w.workDate}</td>
    </c:otherwise>
</c:choose>
						
						<td id="workAmount">${w.workAmount }</td>
						<td id="workProcess">${w.workProcess }</td>
						<%-- <c:if test="${id.emp_department eq '생산팀' || id.emp_department eq '관리자'}"> --%>
							<td>
								<c:if test="${w.workProcess != '마감'}">
									<a name="magamBtn" class="magambutton" href="${pageContext.request.contextPath}/workorder/updateStatus?workCode=${w.workCode }&lineCode=${w.lineCode }&workProcess=${w.workProcess}">공정마감</a>
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
 
	<button id="excelDownload" class="button">엑셀</button>
	</div>	
	<script type="text/javascript">
	function applyFilters() {
        var perPageValue = document.getElementById("perPageSelect").value;
        var searchLine = "${search.search_line}";
        var fromDate = "${search.search_fromDate}";
        var toDate = "${search.search_toDate}";
        var place = "${search.search_place}";
        var prod = "${search.search_prod}";

        var url = '${pageContext.request.contextPath}/workorder/workOrderList?nowPage=1&cntPerPage=' + perPageValue +
            '&search_line=' + searchLine + '&search_fromDate=' + fromDate +
            '&search_toDate=' + toDate + '&search_place=' + place + '&search_prod=' + prod;

        // Redirect to the generated URL
        window.location.href = url;
    }
    

    // 페이지 로드 시 실행되는 함수
    
    $.noConflict();
jQuery(document).ready(function($){
    	
    	 var team = "${sessionScope.empDepartment }"; // 팀 조건에 따라 변수 설정
 		
		  if (team === "자재팀" || team === "관리자") {
			  $('#add').show();
				$('#modify').show();
				$('#delete').show();
		   }
		  else if (team ===""){
			  window.location.href = "${pageContext.request.contextPath}/login/logout";
		  }
    	 
		 
        
    	 $("[name='magamBtn']").on("click", function(event) {
    	        event.preventDefault(); // 기존 링크 동작을 막음

    	        // 링크의 href 속성값을 가져옴
    	        var url = $(this).attr("href");

    	        // AJAX 요청
    	        $.ajax({
    	            type: "GET", // 또는 "POST" - HTTP 요청 방식 선택
    	            url: url,
    	            dataType: "text",
    	            success: function(response) {
    	            	 if(response === "")
    	            		 {
    	            			Swal.fire({
    								title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "사용가능한 라인이 없습니다"+ "</div>",
    								icon: 'info',
    								confirmButtonColor: '#9AC5F4',
    								width: '400px',
    							}).then((result) => {
    							    if (result.isConfirmed) {
    							        // 확인 버튼을 눌렀을 때 특정 주소로 이동
    							    	window.location.href = window.location.href;
    							    }
    							});
    	            		 
    	            		 }
    	            	 else{
    	            	 window.location.href = window.location.href;
    	            	 }
    	             },
    	             error: function(error) {
    	                 console.error("AJAX 요청 실패:", error);
    	                 // 실패에 대한 처리를 추가하세요.
    	             }
    	        });
    	    });
    	 
    	$('table tr').each(function(index){
    		var num = "<c:out value='${paging.nowPage}'/>";
    		var num2 = "<c:out value='${paging.cntPerPage}'/>";
    		$(this).find('td:first').text(((num-1)*num2) + index-1);
    		num3 = ((num-1)*num2) + index;
    	});
    	
		
    	var button = document.getElementById("allButton");
    	    <c:if test="${search.search_place == '1차공정'}">
    var button = document.getElementById("oneButton");
</c:if>
<c:if test="${search.search_place == '2차공정'}">
var button = document.getElementById("twoButton");
</c:if>
<c:if test="${search.search_place == '3차공정'}">
var button = document.getElementById("threeButton");
</c:if>
<c:if test="${search.search_place == '마감'}">
var button = document.getElementById("finishButton");
</c:if>
button.style.backgroundColor = "#4D4D4D";
});
    
  

		
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
	
	
	<div id="pagination" class="page_wrap">
			<div class="page_nation">
						<c:if test="${paging.startPage != 1 }">
							<a class="arrow prev" href="${pageContext.request.contextPath}/workorder/workOrderList?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage }&search_line=${search.search_line}&search_fromDate=${search.search_fromDate}&search_toDate=${search.search_toDate}&search_place=${search.search_place}&search_prod=${search.search_prod}">◀️</a>
						</c:if>
						
						
						<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
    <c:choose>
        <c:when test="${p eq paging.nowPage}">
            <a class="a active" href="${pageContext.request.contextPath}/workorder/workOrderList?nowPage=${p}&cntPerPage=${paging.cntPerPage}&search_line=${search.search_line}&search_fromDate=${search.search_fromDate}&search_toDate=${search.search_toDate}&search_place=${search.search_place}&search_prod=${search.search_prod}">${p}</a>
        </c:when>
        <c:otherwise>
            <a class="a" href="${pageContext.request.contextPath}/workorder/workOrderList?nowPage=${p}&cntPerPage=${paging.cntPerPage}&search_line=${search.search_line}&search_fromDate=${search.search_fromDate}&search_toDate=${search.search_toDate}&search_place=${search.search_place}&search_prod=${search.search_prod}">${p}</a>
        </c:otherwise>
    </c:choose>
</c:forEach>
						<c:if test="${paging.endPage != paging.lastPage}">
							<a class="arrow next" href="${pageContext.request.contextPath}/workorder/workOrderList?nowPage=${paging.endPage + 1 }&cntPerPage=${paging.cntPerPage }&search_line=${search.search_line}&search_fromDate=${search.search_fromDate}&search_toDate=${search.search_toDate}&search_place=${search.search_place}&search_prod=${search.search_prod}">▶️</a>
						</c:if>
					</div>
			</div>
	
	
	
</div>

</div>

	
	
</div>
</body>
</html>


