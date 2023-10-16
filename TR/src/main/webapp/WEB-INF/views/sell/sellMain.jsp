<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>

<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
<title>sell/sellMain.jsp</title>

<!-- side.jsp css-->
<link href="${pageContext.request.contextPath }/resources/css/side.css"	rel="stylesheet" type="text/css">
<!-- 본문 css -->
<link href="${pageContext.request.contextPath }/resources/css/product.css" rel="stylesheet" type="text/css">

<script	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<!-- J쿼리 호출 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="../resources/js/scripts.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<!-- 엑셀 다운로드 -->
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
<!-- 수주일자 기간선택 -->
<link href="${pageContext.request.contextPath}/resources/css/daterange.css"	rel="stylesheet" type="text/css">
</head>

<body>

	<!------------------------------------------------------- 사이드바 ---------------------------------------------------->
	<jsp:include page="../inc/side.jsp"></jsp:include>

	<!------------------------------------------------------- 본문 타이틀 ---------------------------------------------------->
	<div class="container">
		<h2 id="sellMain">수주 관리</h2>
	
		<!------------------------------------------------------- 상단 검색란 ---------------------------------------------------->
		<div id="searchform">
			<form action="${pageContext.request.contextPath}/sell/sellMain"
				method="get" id="selectedProId">

				<label>수주 코드</label> <input type="text" id="sellCode"> 
				
				<label>거래처</label> 
	        <input type="text" id="clientCode9999" name="clientCode" onclick=searchItem('client','clientCode9999'); placeholder="거래처 코드" readonly >
        	<input type="text" id="clientCompany9999" placeholder="거래처명" onclick=searchItem('client','clientCode9999'); readonly >
		
				<br>
				
				<label>제품</label>  
	        <input type="text" name="prodCode" id="prodCode9999" onclick=searchItem('prod','prodCode9999'); placeholder="제품 코드" readonly>
	      	<input type="text" name="prodName" id="prodName9999" placeholder="제품명" readonly onclick="searchItem('prod','prodCode9999')">
	      
				<br>
				
				<label for="startDate">수주 일자</label> 
				<input type="text" name="daterange" id="sellDate" value=""> 
				
				<label for="startDate">납기 일자</label>
				<input type="text" name="daterange" id="sellDuedate"  value="">

				<input type="button" value="조회" id="searchButton">
				<input type="button" value="취소" id="resetButton">
			</form>
		</div>
		<br>
		<!------------------------------------------------------- 추가, 수정, 삭제, 엑셀 버튼 ---------------------------------------------------->
		<div class="buttons">
			<button id="add" onclick="openSellAdd()">추가</button>
			<button id="delete">삭제</button>
			<button id="excelDownload">엑셀⬇️</button>
		</div>
		
		<!------------------------------------------------------- 수주 상태 검색---------------------------------------------------->
		<div id="buttons">
			<input type="button" class="buttons highlighted" value="전체" id="allButton">
    		<input type="button" class="buttons " value="미출고" id="non_deliveryButton">
    		<input type="button" class="buttons " value="중간납품" id="interim_deliveryButton">
    		<input type="button" class="buttons " value="출고완료" id="deliveryButton">
		</div>
		<!------------------------------------------------------- 수주 목록 ---------------------------------------------------->
		<small>총 ${sellPageDTO.count}건</small>

		<form id="selltList">
			<div id="sellList">
				<table class="tg" id="sellTable">
					<thead>
						<tr>
							<th><input type="checkbox" id="select-list-all"
								name="select-list-all" data-group="select-list"></th>
							
							
							<td>처리 상태</td>
							<td>수주 코드</td>
							<td>거래처 코드</td>
							<td>제품 코드</td>
							<td>제품명</td>
							<td>제품 단가</td>
							<td>수주 수량</td>
							<td>수주 단가</td>
							<td>수주 일자</td>
							<td>납기 일자</td>
							<td>담당자</td>
							<td>비고</td>
						</tr>
					</thead>
					
					
					
					<tbody>
						<c:forEach var="sellDTO" items="${sellList}">
							<tr>
								<td><input type="checkbox" id="select-list"
									value="${sellDTO.sellCode}" name="selectedSellCode"
									data-group="select-list"></td>

								
								<td>${sellDTO.sellState}</td><!-- 처리(출고)상태 -->
								
								<td	onclick="openSellDetail('${sellDTO.sellCode}')">${sellDTO.sellCode}</td><!-- 수주코드 -->
								
								<td>${sellDTO.clientCode}</td><!-- 거래처코드 -->
								
								<td>${sellDTO.prodCode}</td><!-- 제품코드 -->
								
								<td>${sellDTO.prodName}</td><!-- 제품명 -->
								
								<td><fmt:formatNumber value="${sellDTO.prodPrice}"
										pattern="###,###원" /></td><!-- 제품단가 -->
								
								<td>${sellDTO.sellCount}개</td><!-- 수주수량-->
								
								<td><fmt:formatNumber value="${sellDTO.sellPrice}"
										pattern="###,###원" /></td><!-- 수주단가 -->
								
								<td>${sellDTO.sellDate}</td><!-- 수주일자 -->
								
								<td>${sellDTO.sellDuedate}</td><!-- 납기일자  -->
								
								<td>${sellDTO.sellEmpId}</td><!-- 수주담당직원 -->
								

								<c:choose>
									<c:when test="${not empty sellDTO.sellMemo}">
										<td class="tg-llyw2"><a href="#"
											onclick="openSellMemo('${sellDTO.sellCode}'); return sellMemoClose();"
											style="color: red;">[보기]</a></td>
									</c:when>
									<c:otherwise>

										<td class="tg-llyw2"><a href="#"
											onclick="addSellMemo('${sellDTO.sellCode}'); return sellMemoClose();"
											style="color: #384855;">[입력]</a></td>
									</c:otherwise>
								</c:choose>


							</tr>
						</c:forEach>
					</tbody>

				</table>
			</div>
			<!------------------------------------------------- 페이징 ------------------------------------------>
			<c:forEach var="i" begin="${sellPageDTO.startPage}"
				end="${sellPageDTO.endPage}" step="1">
				<a
					href="${pageContext.request.contextPath}/sell/sellMain?pageNum=${i}"
					style="text-decoration: none; color: #5EC397;">${i}</a>
			</c:forEach>

			<c:if test="${sellPageDTO.startPage > sellPageDTO.pageBlock}">
				<a
					href="${pageContext.request.contextPath}/sell/sellMain?pageNum=${sellPageDTO.startPage - sellPageDTO.pageBlock}"
					style="text-decoration: none; color: #5EC397;">◀</a>
			</c:if>


			<c:if test="${sellPageDTO.endPage < sellPageDTO.pageCount}">
				<a
					href="${pageContext.request.contextPath}/sell/sellMain?pageNum=${sellPageDTO.startPage + sellPageDTO.pageBlock}"
					style="text-decoration: none; color: #5EC397;">▶</a>
			</c:if>


		</form>
	</div>


	<!--################################################################ script ###################################################################-->
	<script>

var contextPath = "${pageContext.request.contextPath}";

<!------------------------------------------------- 수주관리 페이지 새로고침 ------------------------------------------>
document.getElementById("sellMain").addEventListener("click", function() {
    location.reload(); //
});
<!------------------------------------------------- 팝업창 옵션 ------------------------------------------>
//팝업 옵션
const popupOpt = "top=60,left=140,width=720,height=600";

//검색 팝업
	function searchItem(type, inputId) {
	 	var url = "${pageContext.request.contextPath}/search/search?type=" + type + "&input=" + inputId;
	var popup = window.open(url, "", popupOpt);
} //openWindow()

<!--------------------------------------------------- 목록 전체 선택 ----------------------------------------->
$(document).ready(function() {
$('#select-list-all').click(function() {
			var checkAll = $(this).is(":checked");
			
			if(checkAll) {
				$('input:checkbox').prop('checked', true);
			} else {
				$('input:checkbox').prop('checked', false);
			}
		});

<!--------------------------------------------------- 수주, 납기일자 기간선택 ----------------------------------------->
$(function() {
	$('input[name="daterange"]').daterangepicker({
		autoUpdateInput : false,
		locale : {
			cancelLabel : 'Clear'
		}
	});
	$('input[name="daterange"]').on(
			'apply.daterangepicker',
			function(ev, picker) {
				$(this).val(
						picker.startDate.format('YYYY/MM/DD') + ' - '
								+ picker.endDate.format('YYYY/MM/DD'));
			});
	$('input[name="daterange"]').on('cancel.daterangepicker',
			function(ev, picker) {
				$(this).val('');
			});
	$('.cancelBtn').text('취소');
	$('.applyBtn').text('적용');
});
<!--------------------------------------------------- 수주 삭제 ----------------------------------------->
$('#delete').click(function(event){	

		var checked = [];
		
		$('input[name=selectedSellCode]:checked').each(function(){
			checked.push($(this).val());
		});
		
		console.log(checked);
		
		if(checked.length > 0) {
			Swal.fire({
				  title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "총" +checked.length+"건\n정말 삭제하시겠습니까?"+ "</div>",
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
					    url: "${pageContext.request.contextPath}/sell/delete",
					    type: "POST",
					    data: JSON.stringify(checked), // 데이터를 JSON 문자열로 변환
					    contentType: "application/json", // Content-Type 설정
					    dataType: "text",
					    success: function (response) {
					    	console.log(response); // 서버에서 반환한 응답을 콘솔에 출력
					        // 서버에서의 응답을 처리합니다.
					        // response 변수에 서버에서 반환한 문자열이 들어있습니다.
					        Swal.fire({
					            title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + response + "</div>",
					            icon: 'success',
					            width: '300px',
					        }).then((result) => {
					            if (result.isConfirmed) {
					                location.reload();
					            }
					        });
					    },
					    error: function (response) {
					    	console.log(response); // 서버에서 반환한 응답을 콘솔에 출력
	                        Swal.fire({
	                            title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "삭제 중 오류가 발생했습니다",
	                            icon: 'question',
	                            width: '300px',
	                        });
	                    }
					});
				  } else if (result.isDenied) {
						Swal.fire({
						title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "삭제가 취소되었습니다",
						icon : 'error',
						width: '300px',
						});
			}// if(confirm)
		});		
			
		}// 체크 null
		else{
			Swal.fire({
				title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "선택된 항목이 없습니다",
				icon : 'warning',
				width: '300px',
				});
		}
}); 
});// end function

/* <!--------------------------------------------------- 수주, 납기일자 기간선택 ----------------------------------------->
$(document).ready(function() {
    // Daterangepicker 초기화 및 설정
    $('input[name="daterange"]').daterangepicker({
        autoUpdateInput: false,
        locale: {
            cancelLabel: 'Clear'
        }
    });
	$(function() {
		$('input[name="daterange"]').daterangepicker({
			autoUpdateInput : false,
			locale : {
				cancelLabel : 'Clear'
			}
		});
		$('input[name="daterange"]').on(
				'apply.daterangepicker',
				function(ev, picker) {
					$(this).val(
							picker.startDate.format('YYYY/MM/DD') + ' - '
									+ picker.endDate.format('YYYY/MM/DD'));
				});
		$('input[name="daterange"]').on('cancel.daterangepicker',
				function(ev, picker) {
					$(this).val('');
				});
		$('.cancelBtn').text('취소');
		$('.applyBtn').text('적용');
	});
 */
<!--------------------------------------------------- 수주 추가 ----------------------------------------->
function openSellAdd() {

    // 팝업 창 
    var popupWidth = 500;
    var popupHeight = 700;
    var left = (window.innerWidth - popupWidth) / 2;
    var top = (window.innerHeight - popupHeight) / 2;
    var popupFeatures = 'width=' + popupWidth + ',height=' + popupHeight +
                        ',left=' + left + ',top=' + top +
                        ',resizable=yes,scrollbars=yes';

    // selladd.jsp 파일을 팝업 창 오픈
    window.open( '${pageContext.request.contextPath}/sell/sellAdd','popupUrl', popupFeatures);
    
    function submitClose() {
        // 여기에 수주 등록 폼을 서버에 제출하는 코드를 추가하세요.
        
        // 폼을 제출한 후 창을 닫기 위해 아래 코드를 사용합니다.
        window.close();
    }
} 

<!--------------------------------------------------- 수주 상세정보 ----------------------------------------->
function openSellDetail(sellCode) {
	// 팝업 창 
    var popupWidth = 500;
    var popupHeight = 700;
    var left = (window.innerWidth - popupWidth) / 2;
    var top = (window.innerHeight - popupHeight) / 2;
    var popupFeatures = 'width=' + popupWidth + ',height=' + popupHeight +
                        ',left=' + left + ',top=' + top +
                        ',resizable=yes,scrollbars=yes';
	
    window.open( '${pageContext.request.contextPath}/sell/sellDetail?sellCode='+sellCode,'popupUrl', popupFeatures);
	
    function submitClose() {
    	 window.close();
	
	}
}
<!--------------------------------------------------- 비고 보기 ----------------------------------------->

    function openSellMemo(sellCode) {
        // 팝업 창의 속성을 설정합니다.
        var popupWidth = 450;
        var popupHeight = 500;
        var left = (window.innerWidth - popupWidth) / 2;
        var top = (window.innerHeight - popupHeight) / 2;
        var popupFeatures = 'width=' + popupWidth + ',height=' + popupHeight +
                            ',left=' + left + ',top=' + top +
                            ',resizable=yes,scrollbars=yes';

        // 새 창을 열기 위한 URL 설정
        var url = '${pageContext.request.contextPath}/sell/sellMemo?sellCode=' + sellCode;

        // 팝업 창을 열고 속성 설정
        var newWindow = window.open(url, '_blank', popupFeatures);       
    }

<!--------------------------------------------------- 비고 추가 ----------------------------------------->

    function addSellMemo(sellCode) {
        // 팝업 창의 속성을 설정합니다.
        var popupWidth = 450;
        var popupHeight = 500;
        var left = (window.innerWidth - popupWidth) / 2;
        var top = (window.innerHeight - popupHeight) / 2;
        var popupFeatures = 'width=' + popupWidth + ',height=' + popupHeight +
                            ',left=' + left + ',top=' + top +
                            ',resizable=yes,scrollbars=yes';

        // 새 창을 열기 위한 URL 설정
        var url = '${pageContext.request.contextPath}/sell/sellMemotype?sellCode=' + sellCode+'&memotype=add';
        // 팝업 창을 열고 속성 설정
        var newWindow = window.open(url, '_blank', popupFeatures); 
    }
    
 // 팝업창에서 작업 완료후 닫고 새로고침
    $(document).ready(function() {
//     	var refreshAndClose = true; // refreshAndClose 값을 변수로 설정
//         if (refreshAndClose) {
//             window.opener.location.reload(); // 부모창 새로고침
//             window.close(); // 현재창 닫기
//         }
           
        document.addEventListener('DOMContentLoaded', ()=> {
    		excelDownload.addEventListener('click', exportExcel);
       	});
    });

    <!--------------------------------------------------- 엑셀 다운로드 ----------------------------------------->
    $(document).ready(function () {
		//엑셀
			 const excelDownload = document.querySelector('#excelDownload');
					excelDownload.addEventListener('click', exportExcel);
					function exportExcel() {
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
				return '수주 리스트 '+getToday()+'.xlsx'; //파일명
			},
			getSheetName : function() {
				return 'Sell Sheet'; //시트명
			},
			getExcelData : function() {
				return document.getElementById('sellTable'); //table id
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
				/* alert("이까지 옴"); */
				return buf;
			}
	  });
    
   <!--------------------------------------------------- 상단 조건 검색 ----------------------------------------->
 //라인, 품목, 수주 검색
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String popUpGET(Model model, @RequestParam("type") String type, 
			@RequestParam("input") String input) throws Exception {
		logger.debug("@@@@@ CONTROLLER: popUpGET() 호출");
		logger.debug("@@@@@ CONTROLLER: type = " + type);
		
		
		if(type.equals("line")) {
			return "redirect:/performance/line?input="+input;
		}
		
		else if(type.equals("prod")) {
			return "redirect:/performance/product?input="+input;
		}
		
		else if(type.equals("client")) {
			return "redirect:/person/Clients?input="+input;
		}
		
		else if(type.equals("client_p")) {
			String state = URLEncoder.encode("수주처", "UTF-8");
			return "redirect:/person/Clients?input="+input+"&search_client_type="+state;
		}
		else if(type.equals("client_r")) {
			String state = URLEncoder.encode("발주처", "UTF-8");
			return "redirect:/person/Clients?input="+input+"&search_client_type="+state;
		}
		
		else if(type.equals("wh")) {
			return "redirect:/performance/warehouse?input="+input;
		}
		
		else if(type.equals("wh_p")) {
			String state = URLEncoder.encode("완제품", "UTF-8");
			return "redirect:/performance/warehouse?input="+input+"&wh_dv="+state;
		}
		else if(type.equals("wh_r")) {
			String state = URLEncoder.encode("원자재", "UTF-8");
			return "redirect:/performance/warehouse?input="+input+"&wh_dv="+state;
		}
		
		else if(type.equals("emp")) {
			return "redirect:/person/empinfo?input="+input;
		}
		
		else /* if(type.equals("order"))*/ {
			return "redirect:/person/orderStatus?input="+input;
		}
		
		
	} 
   /*
    광민님 검색코드
    
    $("#searchButton").click(function () {
    	// 검색 조건을 가져오기 (이 부분을 필요에 따라 구현)
    	$(".buttons").removeClass("highlighted");

        // 클릭한 버튼에 "highlighted" 클래스 추가
        $("#allButton").addClass("highlighted");
        
    	sellStateButton2 = "검색";
    	sellStateButton1 = sellStateButton2;
    	
        var searchParams = {
            outCode: $("#outCode").val(),
            prodName: $("#prodName9999").val(),
            clientCompany: $("#clientCompany9999").val(),
            outCode: $("#outCode").val(),
            prodName: $("#prodName9999").val(),
            clientCompany: $("#clientCompany9999").val(),
              
            sellState: sellStateButton2,
        };
		console.log(searchParams);
        loadSellList(searchParams);
    });
    
    // 취소 버튼 클릭 시 검색입력값 초기화
    $("#resetButton").click(function () {
    	$(".buttons").removeClass("highlighted");

        // 클릭한 버튼에 "highlighted" 클래스 추가
        $("#allButton").addClass("highlighted");
    	
        sellStateButton2 = "전체";
    	sellStateButton1 = sellStateButton2;
        
    	$("#sellCode").val('');
        $("#clientCode").val('');
        $("#clientCompany9999").val('');
        $("#prodCode9999").val('');
        $("#prodName9999").val('');
        $("#sellDate").val('');
        $("#sellDuedate").val('');
        
        firstLoadSellList();
    });

	// 검색입력란에서 Enter키 눌러도 검색 폼 안넘어가게
    $("#sellCode, #clientCode, #clientCompany9999, #prodCode9999, #prodName9999, #sellDate, #sellDuedate").on('keydown', function (e) {
        if (e.key === 'Enter') {
            e.preventDefault(); // 엔터 키 기본 동작을 막음 (폼 제출 방지)
            $("#searchButton").click(); // 검색 버튼 클릭
        }
    }); */
 </script>
</body>
</html>
