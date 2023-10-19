<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>

<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath }/resources/css/side.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/resources/css/product.css"
	rel="stylesheet" type="text/css">

<%
//관리자 또는 자재팀 출고 상세 페이지 열람 가능 게시판 접근 가능 (권한)
String department = "";
if (session.getAttribute("empDepartment") != null) {
department = (String) session.getAttribute("empDepartment");
}

//상수 정의
final String ADMIN_DEPARTMENT = "자재팀";
%>

<head>



<%--     <jsp:include page="test4.jsp"></jsp:include> --%>
<title>roomair</title>
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<!-- J쿼리 호출 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="../resources/js/scripts.js"></script>

<!-- <script src="../resources/js/productList_im.js"></script> -->
<!-- 		추가안되면 사이드바에 있는 이거^때문임 -->

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<!-- SheetJS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
<!--FileSaver [savaAs 함수 이용] -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>

</head>


<body>

	<!-- 사이드바 -->
	<jsp:include page="../inc/side.jsp"></jsp:include>
	<!-- 사이드바 -->

	<div class="container">
		<h2>품목 관리</h2>
		<hr>
		<div id="searchform">
			<form action="${pageContext.request.contextPath}/product/list"
				method="get" id="selectedProId">
				<label>품번</label> <input type="text" placeholder="제품코드를 입력하세요."
					name="prodCode"> <label>품명</label> <input type="text"
					placeholder="제품명을 입력하세요." name="prodName"> <label>거래처명</label>
				<input type="text" name="clientCompany" id="sellclientCompany9999"
					readonly placeholder="거래처를 선택하세요."
					onclick="searchItem('sellclient','sellclientCode9999')"
					style="cursor: pointer !important;">
				<!--         <input type="text" placeholder="거래처를 선택하세요." name="a3"> -->
				<button type="submit">조회</button>
			</form>
		</div>
		<hr>
		<%--     <form action="${pageContext.request.contextPath}/product/write" method="post"> --%>
		<c:if
			test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '자재팀')}">
			<div class="buttons">
				<button id="add"
					onclick="openPopup1('${pageContext.request.contextPath}/product/write')">추가</button>
				<!-- 			<button id="modify">수정</button> -->
				<!--     <button id="delete" onclick="deleteSelectedProducts()">삭제</button> -->
				<button id="delete">삭제</button>
				<!-- 			<button id="cancel">취소</button> -->
				<!-- 			<button id="save">저장</button> -->
				<!-- 				<button id="excelDownload" class="buttons">엑셀⬇</button> -->
			</div>
		</c:if>
		<h3 style="padding-left: 1%;">
			목록 <small>총 ${pageDTO.count}건</small>
		</h3>

		<form id="productList">
			<div id="productList">
				<table class="tab" id="productTable">
					<thead>
						<tr>
							<!-- 체크박스 열 추가 -->
							<th><input type="checkbox" id="select-list-all"
								name="select-list-all" data-group="select-list"></th>
							<th>제품 코드</th>
							<th>제품명</th>
							<th>제품 단위</th>
							<th>용량</th>
							<th>향기 종류</th>
							<th>거래처명</th>
							<th>창고명</th>
							<th>매출 단가</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="prodDTO" items="${prodList}">
							<tr>
								<td><input type="checkbox" id="select-list"
									value="${prodDTO.prodCode}" name="selectedProId"
									data-group="select-list"></td>
								<!-- 체크박스 열 -->

								<td id="prodCode">
									<!-- 								<a href="#" --> <%-- 									onclick="openPopup2('${pageContext.request.contextPath}/product/update?prodCode=${prodDTO.prodCode}')"> --%>
									<%-- 									${prodDTO.prodCode}</a> --%> <c:choose>
										<c:when
											test="${!(empty sessionScope.empDepartment) && (sessionScope.empDepartment eq '관리자' || sessionScope.empDepartment eq '자재팀')}">
											<a href="#"
												onclick="openPopup2('${pageContext.request.contextPath}/product/update?prodCode=${prodDTO.prodCode}')">
												${prodDTO.prodCode} </a>
										</c:when>
										<c:otherwise>
        ${prodDTO.prodCode}
    </c:otherwise>
									</c:choose> <%--                 ${prodDTO.prodCode} --%>
								</td>
								<td id="prodName">${prodDTO.prodName}</td>
								<td id="prodUnit">${prodDTO.prodUnit}</td>
								<td id="prodSize">${prodDTO.prodSize}ml</td>
								<td id="prodPerfume">${prodDTO.prodPerfume}</td>
								<td id="clientCompany">${prodDTO.clientCompany}</td>
								<td id="whseName">${prodDTO.whseName}</td>
								<td id="prodPrice"><fmt:formatNumber>${prodDTO.prodPrice}</fmt:formatNumber>원</td>
								<c:choose>
									<c:when test="${not empty prodDTO.prodMemo}">
										<td class="tg-llyw2"><a href="#"
											onclick="openProdMemo('${prodDTO.prodCode}'); return prodMemoClose();"
											style="color: red;">[보기]</a></td>
									</c:when>
									<c:otherwise>

										<td class="tg-llyw2"><a href="#"
											onclick="addProdMemo('${prodDTO.prodCode}'); return prodMemoClose();"
											style="color: #384855;">[입력]</a></td>
									</c:otherwise>
								</c:choose>
							</tr>
						</c:forEach>
					</tbody>

				</table>
			</div>
			<div class="page">
				<button id="excelDownload" class="buttons">엑셀⬇</button>
				<c:if test="${pageDTO.startPage > pageDTO.pageBlock}">
					<a
						href="${pageContext.request.contextPath}/product/list?pageNum=${pageDTO.startPage - pageDTO.pageBlock}&prodCode=${prodDTO.prodCode}&prodName=${prodDTO.prodName}&clientCompany=${prodDTO.clientCompany}">Prev</a>
				</c:if>

				<c:forEach var="i" begin="${pageDTO.startPage}"
					end="${pageDTO.endPage}" step="1">
					<a
						href="${pageContext.request.contextPath}/product/list?pageNum=${i}&prodCode=${prodDTO.prodCode}&prodName=${prodDTO.prodName}&clientCompany=${prodDTO.clientCompany}">${i}</a>
				</c:forEach>


				<c:if test="${pageDTO.endPage < pageDTO.pageCount}">
					<a
						href="${pageContext.request.contextPath}/product/list?pageNum=${pageDTO.startPage + pageDTO.pageBlock}&prodCode=${prodDTO.prodCode}&prodName=${prodDTO.prodName}&clientCompany=${prodDTO.clientCompany}">Next</a>
				</c:if>
			</div>

		</form>
	</div>

	<script>

var contextPath = "${pageContext.request.contextPath}";
// 권한
var department = "<%= department %>";
var ADMIN_DEPARTMENT = "<%= ADMIN_DEPARTMENT %>";

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



// function openAdd() {
//     var url = "${pageContext.request.contextPath}/product/write";
//     var newWindow = window.open(url, "_blank");
//     newWindow.focus();
//   }
//update 페이지 팝업창
function openPopup2(url) {
	const myWindow = window.open(url, "DetailPopup", "location=0,status=1,scrollbars=1,resizable=1,menubar=0,toolbar=no,width=400,height=700");
	myWindow.moveTo(0, 0);
	myWindow.focus();
	}
//추가 페이지 팝업창
function openPopup1(url) {
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



//--------------------------------------------------------------------------
//팝업 옵션
const popupOpt = "top=60,left=140,width=720,height=600";

//검색 팝업
	function searchItem(type, inputId) {
	 	var url = "${pageContext.request.contextPath}/search/search?type=" + type + "&input=" + inputId;
	var popup = window.open(url, "", popupOpt);
} //openWindow()
//--------------------------------------------------------------------------
  $(document).ready(function () {
		//엑셀
		
			 const excelDownload = document.querySelector('#excelDownload');
					excelDownload.addEventListener('click', exportExcel);
					
					function exportExcel() {
						if (!(department !== ADMIN_DEPARTMENT && department !== "관리자")) {
					    // 1. 워크북 생성
					    var wb = XLSX.utils.book_new();
					    // 2. 워크시트 생성
					    var newWorksheet = excelHandler.getWorksheet();
					    // 3. 워크시트를 워크북에 추가
					    XLSX.utils.book_append_sheet(wb, newWorksheet, excelHandler.getSheetName());
					    // 4. 엑셀 파일 생성
					    var wbout = XLSX.write(wb, { bookType: 'xlsx', type: 'binary' });
					    // 5. 엑셀 파일 내보내기
					    saveAs(new Blob([s2ab(wbout)], { type: 'application/octet-stream' }), excelHandler.getExcelFileName());
						}else {
							 Swal.fire({
			                        text: '자재팀만 가능',
			                        icon: 'warning',
			                        confirmButtonText: '확인',
			                    });
						}
					}
					// 현재 날짜를 가져오는 함수
					function getToday() {
						
					    var date = new Date();
					    var year = date.getFullYear();
					    var month = (date.getMonth() + 1).toString().padStart(2, '0'); // 월은 0부터 시작하므로 1을 더하고 두 자리로 맞춥니다.
					    var day = date.getDate().toString().padStart(2, '0'); // 일을 두 자리로 맞춥니다.
					    return year + month + day;
					}

			var excelHandler = {
			getExcelFileName : function() {
				return 'productList'+getToday()+'.xlsx'; //파일명
			},
			getSheetName : function() {
				return 'product Sheet'; //시트명
			},
			getExcelData : function() {
				return document.getElementById('productTable'); //table id
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
				alert("이까지 옴");
				return buf;
			}
	  });
	  
//   <!--------------------------------------------------- 비고 보기 ----------------------------------------->

  function openProdMemo(prodCode) {
      // 팝업 창의 속성을 설정합니다.
      var popupWidth = 450;
      var popupHeight = 500;
      var left = (window.innerWidth - popupWidth) / 2;
      var top = (window.innerHeight - popupHeight) / 2;
      var popupFeatures = 'width=' + popupWidth + ',height=' + popupHeight +
                          ',left=' + left + ',top=' + top +
                          ',resizable=yes,scrollbars=yes';

      // 새 창을 열기 위한 URL 설정
      var url = '${pageContext.request.contextPath}/product/memo?prodCode=' + prodCode;

      // 팝업 창을 열고 속성 설정
      var newWindow = window.open(url, '_blank', popupFeatures);       
  }
  
  <!--------------------------------------------------- 비고 추가 ----------------------------------------->

  function addProdMemo(prodCode) {
      // 팝업 창의 속성을 설정합니다.
      var popupWidth = 450;
      var popupHeight = 500;
      var left = (window.innerWidth - popupWidth) / 2;
      var top = (window.innerHeight - popupHeight) / 2;
      var popupFeatures = 'width=' + popupWidth + ',height=' + popupHeight +
                          ',left=' + left + ',top=' + top +
                          ',resizable=yes,scrollbars=yes';

      // 새 창을 열기 위한 URL 설정
      var url = '${pageContext.request.contextPath}/product/memotype?prodCode=' + prodCode+'&memotype=add';
      // 팝업 창을 열고 속성 설정
      var newWindow = window.open(url, '_blank', popupFeatures); 
  }
  
// 숫자를 ###,### 원 형식으로 포맷하는 함수
// 	function formatCurrency(number) {
// 		return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
// 				+ '원';
// 	}
// function formatCurrency(number) {
//     return parseFloat(number).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,') + '원';
// }

</script>

</body>
</html>
