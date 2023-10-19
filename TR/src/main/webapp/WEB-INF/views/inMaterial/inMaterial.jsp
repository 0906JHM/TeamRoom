<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 사이드바 css-->
<link href="${pageContext.request.contextPath }/resources/css/side.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/resources/css/outProduct.css"
	rel="stylesheet" type="text/css">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- sweetalert -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<!-- SheetJS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
<!--FileSaver [savaAs 함수 이용] -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
<script type="text/javascript">


<%
//관리자 또는 자재팀 출고 상세 페이지 열람 가능 게시판 접근 가능
String department = "";
if (session.getAttribute("empDepartment") != null) {
department = (String) session.getAttribute("empDepartment");
}

//상수 정의
final String ADMIN_DEPARTMENT = "자재팀";
%>

<title>inMaterial</title>
</head>
<body>

	<!-- 사이드바 -->
	<jsp:include page="../inc/side.jsp"></jsp:include>
	<!-- 사이드바 -->


	<div id="con">
		<h2>입고 관리</h2>
		<hr>
		<div id="searchForm">
			<label>입고 코드</label> <input type="text" name="inNum" id="inNum"
				placeholder="입고 번호를 입력하세요."> <label>원자재명</label> <input
				type="text" name="rawName" id="rawName9999" placeholder="원자재명을 입력하세요."
				onclick="searchItem('raw','rawCode9999')"> <label>거래처명</label>
			<input type="text" name="clientCompany" id="clientCompany9999"
				placeholder="거래처를 선택하세요."
				onclick="searchItem('client','clientCode9999')"> <input
				type="button" value="조회" id="searchButton">
				<input type="button" value="초기화" id="resetButton">
		</div>
		<hr>
		<div id="buttons">
			<input type="button" value="전체" id="allButton" class="buttons highlighted"> 
			<input type="button" value="입고" id="inButton" class="buttons"> 
			<input type="button" value="미입고" id="non_inButton" class="buttons">
			
		</div>
		<h3 style="padding-left: 1%;">
			목록 <small id="listCount">총 3건</small>
		</h3>
		<div id="inMaterialList">
			<table id="inMaterialTable">
				<thead>
					<tr>
						<th>입고 번호</th>
						<th>발주 번호</th>
						<th>입고 창고</th>
						<th>거래처명</th>
						<th>품번</th>
						<th>품명</th>
						<th>발주 수량</th>
						<th>재고 수량</th>
						<th>단가</th>
						<th>총액</th>
						<th>입고일</th>
						<th>담당자</th>
						<th>상태</th>
						<c:if test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '자재팀')}">
							<th>처리</th>
						</c:if>
					</tr>
				</thead>
				<tbody>

				</tbody>
			</table>
		</div>
		<div id="paging">
		<input type="button" value="엑셀" id="exportButton">
			<ul id="paging_ul">
			</ul>
		</div>
	</div>
	<script type="text/javascript">
	var department = "<%= department %>";
	var ADMIN_DEPARTMENT = "<%= ADMIN_DEPARTMENT %>";
	var inStateButton1 = "전체";

		$(document).ready(
				function() {
					var inStateButton2 = "전체"
					// 페이지 로드 시 초기 게시판 데이터를 가져오기 위한 함수 호출
					firstloadinMaterialList();
					// 검색 버튼 클릭 시 게시판 데이터를 검색하여 업데이트
					$("#searchButton").click(function() {
						// 검색 조건을 가져오기 (이 부분을 필요에 따라 구현)
						
						$(".buttons").removeClass("highlighted");

						// 클릭한 버튼에 "highlighted" 클래스 추가
						$("#allButton").addClass("highlighted");
						
						inStateButton2 = "검색";
						inStateButton1 = inStateButton2;
						
						var searchParams = {
							inNum : $("#inNum").val(),
							rawName : $("#rawName9999").val(),
							clientCompany : $("#clientCompany9999").val(),
							inState : inStateButton2
						};
						console.log(searchParams);
						loadinMaterialList(searchParams);
					});
					
					// 취소 리셋 버튼을 누르면 검색창들의 값을 다 지운다
			        $("#resetButton").click(function () {
			        	$(".buttons").removeClass("highlighted");

						// 클릭한 버튼에 "highlighted" 클래스 추가
						$("#allButton").addClass("highlighted");
						
						inStateButton2 = "전체";
						inStateButton1 = inStateButton2;
						
			        	$("#inNum").val('');
		                $("#rawName9999").val('');
		                $("#clientCompany9999").val('');
		                firstloadinMaterialList();
			        });

					// Enter 키 이벤트를 감지할 input 요소에 이벤트 리스너 등록
					$("#inNum, #rawName9999, #clientCompany9999").on('keydown',
							function(e) {
								if (e.key === 'Enter') {
									e.preventDefault(); // 엔터 키 기본 동작을 막음 (폼 제출 방지)
									$("#searchButton").click(); // 검색 버튼 클릭
								}
							});

					// 버튼 클릭 시 클래스를 관리
					$(".buttons").click(function() {
						// 모든 버튼의 "highlighted" 클래스 제거
						$(".buttons").removeClass("highlighted");

						// 클릭한 버튼에 "highlighted" 클래스 추가
						$(this).addClass("highlighted");
					});

					// 전체 버튼 클릭 시
					$("#allButton").click(function() {
						// 전체 버튼에 대한 동작을 추가하고,
						inStateButton2 = "총검색";
						inStateButton1 = inStateButton2;

						// 검색 조건을 설정하고 전체 목록을 가져오도록 수정
						var searchParams = {
							inNum : $("#inNum").val(),
							rawName : $("#rawName9999").val(),
							clientCompany : $("#clientCompany9999").val(),
							inState : inStateButton2
						// 전체 조건 추가
						};
						loadinMaterialList(searchParams);
					});

					// 미출고 버튼 클릭 시
					$("#non_inButton").click(function() {
						// 미출고 버튼에 대한 동작을 추가하고,
						inStateButton2 = "미입고";
						inStateButton1 = inStateButton2;
						// 검색 조건을 설정하고 미출고 목록을 가져오도록 수정
						var searchParams = {
							inNum : $("#inNum").val(),
							rawName : $("#rawName9999").val(),
							clientCompany : $("#clientCompany9999").val(),
							inState : inStateButton2
						// 미출고 조건 추가
						};
						loadinMaterialList(searchParams);
					});

					// 출고완료 버튼 클릭 시
					$("#inButton").click(function() {
						// 출고완료 버튼에 대한 동작을 추가하고,
						inStateButton2 = "입고완료";
						inStateButton1 = inStateButton2;
						// 검색 조건을 설정하고 출고완료 목록을 가져오도록 수정
						var searchParams = {
							inNum : $("#inNum").val(),
							rawName : $("#rawName9999").val(),
							clientCompany : $("#clientCompany9999").val(),
							inState : inStateButton2
						// 미출고 조건 추가
						};
						loadinMaterialList(searchParams);
					});

				});//document

		//----------------------------------------------------------------------------

		// 	    처음 게시판 데이터를 서버에서 비동기적으로 가져오는 함수
		function firstloadinMaterialList() {
			var searchParams = {
				inNum : $("#inNum").val(),
				rawName : $("#rawName9999").val(),
				clientCompany : $("#clientCompany9999").val(),
				inState : "전체"
			};

			$
					.ajax({
						type : "GET", // GET 또는 POST 등 HTTP 요청 메서드 선택
						url : "${pageContext.request.contextPath}/inMaterial/listSearch", // 데이터를 가져올 URL 설정
						data : searchParams, // 검색 조건 데이터 전달
						dataType : "json", // 가져올 데이터 유형 (JSON으로 설정)
						success : function(data) {
							// 서버로부터 데이터를 성공적으로 가져왔을 때 실행되는 콜백 함수
							// 데이터를 사용하여 게시판 업데이트
							updateinMaterialList(data);
						},
						error : function(error) {
							// 데이터 가져오기 실패 시 실행되는 콜백 함수
							console.error("Error fetching data: " + error);
						}
					});
		}

		// 	    게시판 데이터를 서버에서 비동기적으로 가져오는 함수
		function loadinMaterialList(searchParams) {

			$
					.ajax({
						type : "GET", // GET 또는 POST 등 HTTP 요청 메서드 선택
						url : "${pageContext.request.contextPath}/inMaterial/listSearch", // 데이터를 가져올 URL 설정
						data : searchParams, // 검색 조건 데이터 전달
						dataType : "json", // 가져올 데이터 유형 (JSON으로 설정)
						success : function(data) {
							// 서버로부터 데이터를 성공적으로 가져왔을 때 실행되는 콜백 함수
							// 데이터를 사용하여 게시판 업데이트
							updateinMaterialList(data);
						},
						error : function(error) {
							// 데이터 가져오기 실패 시 실행되는 콜백 함수
							console.error("Error fetching data: " + error);
						}
					});
		}

		// 게시판을 업데이트하는 함수
		function updateinMaterialList(data) {
			// 서버에서 받은 데이터를 사용하여 게시판 업데이트 (이 부분을 필요에 따라 구현)

			// 예제: 테이블의 tbody를 비우고 새로운 데이터로 채우기
			var tbody = $("#inMaterialList tbody");
			tbody.empty(); // 기존 데이터를 비웁니다.

			// 데이터를 반복하여 새로운 행을 생성합니다.
			for (var i = 0; i < data.length; i++) {
				// 리스트를 출력하는 조건부분
				if (i < data.length - 1) {

					var row = $("<tr>");
					row.append("<td>" + (data[i].inNum ? data[i].inNum : '-')
							+ "</td>");
					row.append("<td>" + (data[i].buyNum ? data[i].buyNum : '-')
							+ "</td>");
					row.append("<td>"
							+ (data[i].whseCode ? data[i].whseCode : '-')
							+ "</td>");
					row.append("<td>"
							+ (data[i].clientCompany ? data[i].clientCompany
									: '-') + "</td>");
					row.append("<td>"
							+ (data[i].rawCode ? data[i].rawCode : '-')
							+ "</td>");
					row.append("<td>"
							+ (data[i].rawName ? data[i].rawName : '-')
							+ "</td>");
					row.append("<td>"
							+ (data[i].inCount ? data[i].inCount : '-')
							+ "</td>");
					row.append("<td>"
							+ (data[i].stockCount ? data[i].stockCount : '-')
							+ "</td>");
					row.append("<td>"
							+ (data[i].rawPrice ? formatCurrency(data[i].rawPrice) : '-')
							+ "</td>");
					row
							.append("<td>"
									+ (data[i].inPrice ? formatCurrency(data[i].inPrice)
											: '-') + "</td>");
					row.append("<td>" + (data[i].inDate ? data[i].inDate : '-')
							+ "</td>");
					row.append("<td>"
							+ (data[i].inEmpId ? data[i].inEmpId : '-')
							+ "</td>");
					row.append("<td>"
							+ (data[i].inState ? data[i].inState : '-')
							+ "</td>");


					if (!(department !== ADMIN_DEPARTMENT && department !== "관리자")) {				
						// 입고 버튼 추가 
						var contextPath = "${pageContext.request.contextPath}";
						var inNum = data[i].inNum;
						
						(function(dataItem) {
						    var button = $("<input type='button' value='입고'>");
						    button.click(function() {
						        // 버튼 클릭 시 처리할 동작을 여기에 추가
						        console.log("입고 버튼이 클릭되었습니다."); // 버튼 클릭 시 콘솔에 메시지 출력
						
						        // confirm 창을 띄워 입고 처리 여부를 확인
						        var confirmation = confirm("입고 처리하시겠습니까?");
						
						        // 확인 버튼이 눌렸을 경우에만 작업 수행
						        if (confirmation) {
						            if (dataItem.hasOwnProperty('inState')) {
						                dataItem.inState = "입고완료";
						                // 변경된 inState 값을 출력하여 확인
						                console.log("변경된 inState 값: " + dataItem.inState);
						
						                // 서버에 변경된 값을 저장하기 위한 Ajax 요청
						                $.ajax({
						                    type: 'POST',
						                    url: '${pageContext.request.contextPath}/inMaterial/inMaterialUpdate',
						                    data: JSON.stringify(dataItem),
						                    contentType: 'application/json',
						                    success: function(response) {
						                        console.log('데이터가 성공적으로 업데이트되었습니다.', response);
						                        
						                        
						                     // 데이터 업데이트 후 페이지 새로고침
						                        location.reload();
						                     
						                     // 버튼을 비활성화하고 색상을 회색으로 변경
						//                         button.attr('disabled', 'disabled');
						//                         button.css('background-color', 'grey');
						                        
						                    },
						                    error: function(error) {
						                        console.error('데이터 업데이트 중 오류가 발생했습니다.', error);
						                    }
						                });
						            } else {
						                console.error("inState 속성이 데이터 객체에 존재하지 않습니다.");
						            }
						        }
						    });
						    // inState 값이 '입고완료'인 경우 버튼을 비활성화하고 색상을 회색으로 변경
						    if (dataItem.inState === '입고완료') {
						        button.prop('disabled', true);
						        button.css('background-color', 'grey');
						    }
						
						
						 // 버튼을 새로운 <td> 요소 내에 추가하고, 그 <td>를 행에 추가
						 var buttonCell = $("<td>").append(button);
						 row.append(buttonCell);
						})(data[i]);
					}		
					
					
					
					
					//--------------------------------------------------------------------------------------------
					//	tbody에 행을 추가합니다.
					tbody.append(row);
				} else if (i == data.length - 1) {// 마지막에 페이징 처리데이터가 들어가있다
					// 마지막 행은 페이징 정보를 추가합니다.
					var inNum = data[i].inNum; //검색한 출고번호
					var rawName = data[i].rawName; //검색한 상품이름
					var clientCompany = data[i].clientCompany; //검색한 거래처이름
					var inState = data[i].inState; //검색한 출고 상태
					var prev = data[i].startPage - data[i].pageBlock;
					var next = data[i].startPage + data[i].pageBlock;

					var listCountElement = document.getElementById("listCount");
					listCountElement.textContent = "총 " + data[i].count + "건"; // 내용을 원하는 형식으로 변경

					var pagingUL = $("#paging_ul");
					pagingUL.empty(); // 기존 페이징 데이터를 비웁니다.

					if (data[i].startPage > data[i].pageBlock) {
						var prevLink = $("<a href='javascript:void(0);'>Prev</a>");
						var prevListItem = $("<li>").append(prevLink);
						prevListItem.click(function() {
							loadPage(inNum, rawName, clientCompany, prev);
						});
						pagingUL.append(prevListItem); // 'Prev' 링크를 페이지 목록에 추가하고 li 클릭 시에도 loadPage를 호출합니다.
					}

					for (let page = data[i].startPage; page <= data[i].endPage; page++) {
						let pageLink = $("<a href='javascript:void(0);'>"
								+ page + "</a>");
						var pageListItem = $("<li>").append(pageLink);
						pageListItem.click(function() {
							loadPage(inNum, rawName, clientCompany, page);
						});
						pagingUL.append(pageListItem); // 각 페이지 번호를 페이지 목록에 추가하고 li 클릭 시에도 loadPage를 호출합니다.
					}

					if (data[i].endPage < data[i].pageCount) {
						var nextLink = $("<a href='javascript:void(0);'>Next</a>");
						var nextListItem = $("<li>").append(nextLink);
						nextListItem.click(function() {
							loadPage(inNum, rawName, clientCompany, next);
						});
						pagingUL.append(nextListItem); // 'Next' 링크를 페이지 목록에 추가하고 li 클릭 시에도 loadPage를 호출합니다.
					}
				}
			}
		}

		function loadPage(inNum, rawName, clientCompany, page) {
			console.log(inNum);
			console.log(inStateButton1);
			console.log(rawName);
			console.log(clientCompany);
			console.log(page);

			var searchParams = {
				outCode : inNum,
				prodName : rawName,
				clientCompany : clientCompany,
				pageNum : page,
				inState : inStateButton1,
			};
			loadinMaterialList(searchParams);
		}

		// 숫자를 ###,### 원 형식으로 포맷하는 함수
		function formatCurrency(number) {
			return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
					+ '원';
		}

		// 팝업 옵션
		const popupOpt = "top=60,left=140,width=720,height=600";

		//검색 팝업
		function searchItem(type, inputId) {
			var url = "${pageContext.request.contextPath}/search/search?type="
					+ type + "&input=" + inputId;
			var popup = window.open(url, "", popupOpt);
		} //openWindow()
		

		
		   // 버튼 클릭 시 실행
		   // 클라이언트에서 서버로 데이터 요청
				document.getElementById('exportButton').addEventListener('click', function () {
					if (!(department !== ADMIN_DEPARTMENT && department !== "관리자")) {	
					// 엑셀로 내보낼 데이터
				    var searchParams = {
				    		inNum : $("#inNum").val(),
							rawName : $("#rawName9999").val(),
							clientCompany : $("#clientCompany9999").val(),
							inState : inStateButton1
				    };
				
				    $.ajax({
				        type: "POST", // GET 또는 POST 등 HTTP 요청 메서드 선택
				        url: "${pageContext.request.contextPath}/inMaterial/excel", // 데이터를 가져올 URL 설정
				        data: searchParams, // 검색 조건 데이터 전달
				        dataType: "json", // 가져올 데이터 유형 (JSON으로 설정)
				        success: function (data) {
				            // 데이터 가공
							var modifiedData = data.map(function (item) {
							    return {
							        '입고번호': item.inNum,
							        '발주번호': item.buyNum,
							        '입고창고': item.whseCode,
							        '거래처명': item.clientCompany,
							        '품번': item.rawCode,
							        '품명': item.rawName,
							        '발주수량': item.inCount,
							        '재고수량': item.stock,
							        '단가': item.rawPrice,
							        '총액': item.inPrice,
							        '입고일': item.inDate,
							        '담당자': item.inEmpId,
							        '상태': item.inState,
							    };
							});
				            // 새 워크북을 생성
				            var wb = XLSX.utils.book_new();
				            // JSON 데이터를 워크시트로 변환
				            var ws = XLSX.utils.json_to_sheet(modifiedData);
				            // 워크북에 워크시트 추가
				            XLSX.utils.book_append_sheet(wb, ws, "데이터 시트");
				            // Blob 형태로 워크북 생성
				            var wbout = XLSX.write(wb, { bookType: 'xlsx', type: 'binary' });
				            // 파일 이름 설정 (원하는 파일 이름으로 변경)
				            var fileName = "InMaterial.xlsx";
				            // Blob 파일을 다운로드
				            saveAs(new Blob([s2ab(wbout)], { type: "application/octet-stream" }), fileName);
				        }
				    });
					}else {
						 Swal.fire({
		                        text: '자재팀만 가능',
		                        icon: 'warning',
		                        confirmButtonText: '확인',
		                    });
					}
				});
				
				// ArrayBuffer 만들어주는 함수
				function s2ab(s) {
				    var buf = new ArrayBuffer(s.length); // convert s to arrayBuffer
				    var view = new Uint8Array(buf); // create uint8array as viewer
				    for (var i = 0; i < s.length; i++) view[i] = s.charCodeAt(i) & 0xFF; // convert to octet
				    return buf;
				}		
		
	</script>
</body>
</html>