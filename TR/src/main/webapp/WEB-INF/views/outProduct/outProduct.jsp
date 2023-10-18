<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath }/resources/css/side.css"
	rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/outProduct.css"
	rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- SheetJS CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
<!-- FileSaver.js CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.5/FileSaver.min.js"></script>

<title>출고 페이지</title>
</head>
<body>
	<!-- 사이드바 -->
	<jsp:include page="../inc/side.jsp"></jsp:include>
	<!-- 사이드바 -->
	<div id="con">
		<h2>출고 현황</h2>
		<hr>
		<div id="searchForm">
				<label>출고 번호</label><input type="text" name="outCode" id="outCode" placeholder="출고 번호를 입력하세요">
				<label>제품명</label><input type="text" name="prodName" id="prodName9999" placeholder="제품명을 입력하세요" onclick="searchItem('prod','prodCode9999')">
				<label>거래처명</label><input type="text" name="clientCompany" id="sellclientCompany9999" placeholder="거래처명을 입력하세요" onclick="searchItem('sellclient','sellclientCode9999')">
				<input type="button" value="검색" id="searchButton">
				<input type="button" value="초기화" id="resetButton">
		</div>
		<hr>
		<div id="buttons">
			<input type="button" class="buttons highlighted" value="전체" id="allButton">
    		<input type="button" class="buttons " value="미출고" id="non_deliveryButton">
    		<input type="button" class="buttons " value="중간납품" id="interim_deliveryButton">
    		<input type="button" class="buttons " value="출고완료" id="deliveryButton">
    		<input type="button" value="엑셀" id="exportButton">
		</div>
		<h3 style="padding-left:1%;">목록 <small id="listCount">총 3건</small></h3>
		<div id="outProductList">
			<table>
				<thead>
					<tr>
						<th>출고번호</th>
						<th>수주번호</th>
						<th>거래처코드</th>
						<th>거래처명</th>
						<th>제품코드</th>
						<th>제품이름</th>
						<th>주문수량</th>
						<th>출고수량</th>
						<th>재고수량</th>
						<th>납품가</th>
						<th>납품예정일</th>
						<th>출고날짜</th>
						<th>담당자</th>
						<th>출고여부</th>
						<th>상세정보</th>
					</tr>
				</thead>
				<tbody>
					
				</tbody>
			</table>
		</div>
		<div id="paging">
   			<ul id="paging_ul">
    		</ul>
		</div>
	</div>
		<script type="text/javascript">
		    var sellStateButton1 = "전체";
		    
		    $(document).ready(function () {
		        var sellStateButton2 = "전체"
		    	// 페이지 로드 시 초기 게시판 데이터를 가져오기 위한 함수 호출
		        firstLoadOutProductList();
				
		        
		    	
		        // 검색 버튼 클릭 시 게시판 데이터를 검색하여 업데이트
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
			            sellState: sellStateButton2,
			        };
					console.log(searchParams);
		            loadOutProductList(searchParams);
		        });
		        
		        // 취소 리셋 버튼을 누르면 검색창들의 값을 다 지운다
		        $("#resetButton").click(function () {
		        	$(".buttons").removeClass("highlighted");

			        // 클릭한 버튼에 "highlighted" 클래스 추가
			        $("#allButton").addClass("highlighted");
		        	
			        sellStateButton2 = "전체";
		        	sellStateButton1 = sellStateButton2;
			        
		        	$("#outCode").val('');
	                $("#prodName9999").val('');
	                $("#clientCompany9999").val('');
	                
	                firstLoadOutProductList();
		        });
		        
		        
				
		    	// Enter 키 이벤트를 감지할 input 요소에 이벤트 리스너 등록
		        $("#outCode, #prodName9999, #clientCompany9999").on('keydown', function (e) {
		            if (e.key === 'Enter') {
		                e.preventDefault(); // 엔터 키 기본 동작을 막음 (폼 제출 방지)
		                $("#searchButton").click(); // 검색 버튼 클릭
		            }
		        });
		        
		    	
		     // 버튼 클릭 시 클래스를 관리
		        $(".buttons").click(function () {
		          // 모든 버튼의 "highlighted" 클래스 제거
		          $(".buttons").removeClass("highlighted");

		          // 클릭한 버튼에 "highlighted" 클래스 추가
		          $(this).addClass("highlighted");
		        });
		        
		     	// 전체 버튼 클릭 시
		        $("#allButton").click(function () {
		            // 전체 버튼에 대한 동작을 추가하고,
		        	sellStateButton2 = "총검색";
		        	sellStateButton1 = sellStateButton2;
		        	
		            // 검색 조건을 설정하고 전체 목록을 가져오도록 수정
		            var searchParams = {
		            	outCode: $("#outCode").val(),
					    prodName: $("#prodName9999").val(),
					    clientCompany: $("#clientCompany9999").val(),
		                sellState: sellStateButton2 // 전체 조건 추가
		            };
		            loadOutProductList(searchParams);
		        });
		     	// 미출고 버튼 클릭 시
		        $("#non_deliveryButton").click(function () {
		            // 미출고 버튼에 대한 동작을 추가하고,
		        	sellStateButton2 = "미출고";
		        	sellStateButton1 = sellStateButton2;
		            // 검색 조건을 설정하고 미출고 목록을 가져오도록 수정
		            var searchParams = {
		                outCode: $("#outCode").val(),
		                prodName: $("#prodName9999").val(),
		                clientCompany: $("#clientCompany9999").val(),
		                sellState: sellStateButton2 // 미출고 조건 추가
		            };
		            loadOutProductList(searchParams);
		        });
		     	// 중간납품 버튼 클릭 시
		        $("#interim_deliveryButton").click(function () {
		            // 중간납품 버튼에 대한 동작을 추가하고,
		        	sellStateButton2 = "중간납품";
		        	sellStateButton1 = sellStateButton2;
		            // 검색 조건을 설정하고 중간납품 목록을 가져오도록 수정
		            var searchParams = {
		                outCode: $("#outCode").val(),
		                prodName: $("#prodName9999").val(),
		                clientCompany: $("#clientCompany9999").val(),
		                sellState: sellStateButton2 // 중간납품 조건 추가
		            };
		            loadOutProductList(searchParams);
		        });
		     	// 출고완료 버튼 클릭 시
		        $("#deliveryButton").click(function () {
		            // 출고완료 버튼에 대한 동작을 추가하고,
		        	sellStateButton2 = "출고완료";
		        	sellStateButton1 = sellStateButton2;
		            // 검색 조건을 설정하고 출고완료 목록을 가져오도록 수정
		            var searchParams = {
		                outCode: $("#outCode").val(),
		                prodName: $("#prodName9999").val(),
		                clientCompany: $("#clientCompany9999").val(),
		                sellState: sellStateButton2 // 출고완료 조건 추가
		            };
		            loadOutProductList(searchParams);
		        });
		    });
		
	// 	    처음 게시판 데이터를 서버에서 비동기적으로 가져오는 함수
		    function firstLoadOutProductList() {
		    	 var searchParams = {
	                outCode: $("#outCode").val(),
	                prodName: $("#prodName9999").val(),
	                clientCompany: $("#clientCompany9999").val(),
	                sellState: "전체"
	            };
				
		        $.ajax({
		            type: "POST", // GET 또는 POST 등 HTTP 요청 메서드 선택
		            url: "${pageContext.request.contextPath}/outProduct/listSearch", // 데이터를 가져올 URL 설정
		            data: searchParams, // 검색 조건 데이터 전달
		            dataType: "json", // 가져올 데이터 유형 (JSON으로 설정)
		            success: function (data) {
		                // 서버로부터 데이터를 성공적으로 가져왔을 때 실행되는 콜백 함수
		                // 데이터를 사용하여 게시판 업데이트
		                updateOutProductList(data);
		            },
		            error: function (error) {
		                // 데이터 가져오기 실패 시 실행되는 콜백 함수
		                console.error("Error fetching data: " + error);
		            }
		        });
		    }
		    
	// 	    게시판 데이터를 서버에서 비동기적으로 가져오는 함수
		    function loadOutProductList(searchParams) {
		    	
		        $.ajax({
		            type: "POST", // GET 또는 POST 등 HTTP 요청 메서드 선택
		            url: "${pageContext.request.contextPath}/outProduct/listSearch", // 데이터를 가져올 URL 설정
		            data: searchParams, // 검색 조건 데이터 전달
		            dataType: "json", // 가져올 데이터 유형 (JSON으로 설정)
		            success: function (data) {
		                // 서버로부터 데이터를 성공적으로 가져왔을 때 실행되는 콜백 함수
		                // 데이터를 사용하여 게시판 업데이트
		                updateOutProductList(data);
		            },
		            error: function (error) {
		                // 데이터 가져오기 실패 시 실행되는 콜백 함수
		                console.error("Error fetching data: " + error);
		            }
		        });
		    }
		
		    // 게시판을 업데이트하는 함수
		    function updateOutProductList(data) {
		        // 서버에서 받은 데이터를 사용하여 게시판 업데이트 (이 부분을 필요에 따라 구현)
		
		        // 예제: 테이블의 tbody를 비우고 새로운 데이터로 채우기
		        var tbody = $("#outProductList tbody");
		        tbody.empty(); // 기존 데이터를 비웁니다.
		
		        // 데이터를 반복하여 새로운 행을 생성합니다.
		        for (var i = 0; i < data.length; i++) {
		        	// 리스트를 출력하는 조건부분
	        		if(i < data.length-1){
	        			
			            var row = $("<tr>");
			            row.append("<td>" + (data[i].outCode ? data[i].outCode : '-') + "</td>");
			            row.append("<td>" + (data[i].sellCode ? data[i].sellCode : '-') + "</td>");
			            row.append("<td>" + (data[i].clientCode ? data[i].clientCode : '-') + "</td>");
			            row.append("<td>" + (data[i].clientCompany ? data[i].clientCompany : '-') + "</td>");
			            row.append("<td>" + (data[i].prodCode ? data[i].prodCode : '-') + "</td>");
			            row.append("<td>" + (data[i].prodName ? data[i].prodName : '-') + "</td>");
			            row.append("<td>" + (data[i].sellCount ? data[i].sellCount : '-') + "</td>");
			            row.append("<td>" + (data[i].outCount ? data[i].outCount : '-') + "</td>");
			            row.append("<td>" + (data[i].whseCount ? data[i].whseCount : '-') + "</td>");
			            row.append("<td>" + (data[i].outPrice ? formatCurrency(data[i].outPrice) : '-') + "</td>");
			            row.append("<td>" + (data[i].sellDuedate ? data[i].sellDuedate : '-') + "</td>");
			            row.append("<td>" + (data[i].outDate ? data[i].outDate : '-') + "</td>");
			            row.append("<td>" + (data[i].outEmpId ? data[i].outEmpId : '-') + "</td>");
			            row.append("<td>" + (data[i].sellState ? data[i].sellState : '-') + "</td>");
		
			            
			            
			            // 상세정보 버튼 추가 
			            var contextPath = "${pageContext.request.contextPath}";
		  				var outCode = data[i].outCode;
		               
		  				(function(outCode) {
		  			        var button = $("<input type='button' value='상세정보'>");
		  			        button.click(function () {
		  			            // 버튼 클릭 시 처리할 동작을 여기에 추가
		  			            window.open(contextPath + "/outProduct/outProductContent?outCode=" + outCode, "출고 상세정보", "width=500,height=800,toolbar=no,location=no,resizable=yes");
		  			        });
		
		  			        // 버튼을 새로운 <td> 요소 내에 추가하고, 그 <td>를 행에 추가
		  			        var buttonCell = $("<td>").append(button);
		  			        row.append(buttonCell);
		  			    })(data[i].outCode);
		            //	tbody에 행을 추가합니다.
		            	tbody.append(row);
	        		}else if(i == data.length-1){// 마지막에 페이징 처리데이터가 들어가있다
		        		// 마지막 행은 페이징 정보를 추가합니다.
		        		var outCode = data[i].outCode;			//검색한 출고번호
			            var prodName = data[i].prodName;			//검색한 상품이름
			            var clientCompany = data[i].clientCompany; //검색한 거래처이름
			            var sellState = data[i].sellState;		  //검색한 출고 상태
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
		        		        loadPage(outCode, prodName, clientCompany, prev);
		        		    });
		        		    pagingUL.append(prevListItem); // 'Prev' 링크를 페이지 목록에 추가하고 li 클릭 시에도 loadPage를 호출합니다.
		        		}

		        		for (let page = data[i].startPage; page <= data[i].endPage; page++) {
		        		    let pageLink = $("<a href='javascript:void(0);'>" + page + "</a>");
		        		    var pageListItem = $("<li>").append(pageLink);
		        		    pageListItem.click(function() {
		        		        loadPage(outCode, prodName, clientCompany, page);
		        		    });
		        		    pagingUL.append(pageListItem); // 각 페이지 번호를 페이지 목록에 추가하고 li 클릭 시에도 loadPage를 호출합니다.
		        		}

		        		if (data[i].endPage < data[i].pageCount) {
		        		    var nextLink = $("<a href='javascript:void(0);'>Next</a>");
		        		    var nextListItem = $("<li>").append(nextLink);
		        		    nextListItem.click(function() {
		        		        loadPage(outCode, prodName, clientCompany, next);
		        		    });
		        		    pagingUL.append(nextListItem); // 'Next' 링크를 페이지 목록에 추가하고 li 클릭 시에도 loadPage를 호출합니다.
		        		}


		               
		        	}
		        	
		        }
	
		    }
		    function loadPage(outCode, prodName, clientCompany, page) {
		    	console.log(outCode);
		    	console.log(sellStateButton1);
		    	console.log(prodName);
		    	console.log(clientCompany);
		    	console.log(page);
		    	
		        var searchParams = {
		            outCode: outCode,
		            prodName: prodName,
		            clientCompany: clientCompany,
		            pageNum: page,
		            sellState: sellStateButton1,
		        };
		        loadOutProductList(searchParams);
		    }
		    
		 	// 숫자를 ###,### 원 형식으로 포맷하는 함수
		    function formatCurrency(number) {
		        return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '원';
		    }
		 	
		 // 팝업 옵션
		    const popupOpt = "top=60,left=140,width=720,height=600";

		    //검색 팝업
		    	function searchItem(type, inputId) {
		    	 	var url = "${pageContext.request.contextPath}/search/search?type=" + type + "&input=" + inputId;
		    	var popup = window.open(url, "", popupOpt);
		    } //openWindow()
		 	
		    // 		   	엑셀


    // 버튼 클릭 시 실행
   // 클라이언트에서 서버로 데이터 요청
		document.getElementById('exportButton').addEventListener('click', function () {
		    // 엑셀로 내보낼 데이터
		    var searchParams = {
		        outCode: $("#outCode").val(),
		        prodName: $("#prodName9999").val(),
		        clientCompany: $("#clientCompany9999").val(),
		        sellState: sellStateButton1 // 전체 조건 추가
		    };
		
		    $.ajax({
		        type: "POST", // GET 또는 POST 등 HTTP 요청 메서드 선택
		        url: "${pageContext.request.contextPath}/outProduct/excel", // 데이터를 가져올 URL 설정
		        data: searchParams, // 검색 조건 데이터 전달
		        dataType: "json", // 가져올 데이터 유형 (JSON으로 설정)
		        success: function (data) {
		            // 데이터 가공
					var modifiedData = data.map(function (item) {
					    return {
					        '출고코드': item.outCode,
					        '수주코드': item.sellCode,
					        '거래처코드': item.clientCode,
					        '거래처명': item.clientCompany,
					        '제품코드': item.prodCode,
					        '제품이름': item.prodName,
					        '담당자': item.outEmpId,
					        '출고상태': item.sellState,
					        '납품예정일': item.sellDuedate,
					        '출고일': item.outDate,
					        '재출고일': item.outRedate,
					        '납품개수': item.sellCount,
					        '출고개수': item.outCount,
					        '재고개수': item.whseCount,
					        '납품단가': item.prodPrice,
					        '출고가': item.outPrice,
					        '비고': item.outMemo
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
		            var fileName = "OutProduct.xlsx";
		            // Blob 파일을 다운로드
		            saveAs(new Blob([s2ab(wbout)], { type: "application/octet-stream" }), fileName);
		        }
		    });
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