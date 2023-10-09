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
<title>Insert title here</title>


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
				<label>제품명</label><input type="text" name="prodName" id="prodName" placeholder="제품명을 입력하세요">
				<label>거래처명</label><input type="text" name="clientCompany" id="clientCompany" placeholder="거래처명을 입력하세요">
				<input type="button" value="검색" id="searchButton">
		</div>
		<hr>
		<div id="buttons">
			<input type="button" value="전체" id="allButton">
    		<input type="button" value="미출고" id="non_deliveryButton">
    		<input type="button" value="중간납품" id="interim_deliveryButton">
    		<input type="button" value="출고완료" id="deliveryButton">
		</div>
		<h3 style="padding-left:1%;">출고 목록 <small>총 3건</small></h3>
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
						<th>재고수량</th>
						<th>납품가</th>
						<th>납품예정일</th>
						<th>출고날짜</th>
						<th>담당자</th>
						<th>출고여부</th>
						<th>출고처리</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
	</div>
	<script type="text/javascript">
	    $(document).ready(function () {
	        var sellStateButton = "전체";
	    	
	    	// 페이지 로드 시 초기 게시판 데이터를 가져오기 위한 함수 호출
	        firstLoadOutProductList();
			
	    	
	        // 검색 버튼 클릭 시 게시판 데이터를 검색하여 업데이트
	        $("#searchButton").click(function () {
	        	// 검색 조건을 가져오기 (이 부분을 필요에 따라 구현)
		        var searchParams = {
		            outCode: $("#outCode").val(),
		            prodName: $("#prodName").val(),
		            clientCompany: $("#clientCompany").val(),
		        };
				console.log(searchParams);
	            loadOutProductList(searchParams);
	        });
			
	    	// Enter 키 이벤트를 감지할 input 요소에 이벤트 리스너 등록
	        $("#outCode, #prodName, #clientCompany").on('keydown', function (e) {
	            if (e.key === 'Enter') {
	                e.preventDefault(); // 엔터 키 기본 동작을 막음 (폼 제출 방지)
	                $("#searchButton").click(); // 검색 버튼 클릭
	            }
	        });
	        
	        
	     	// 전체 버튼 클릭 시
	        $("#allButton").click(function () {
	            // 전체 버튼에 대한 동작을 추가하고,
	        	sellStateButton = "전체";
	            // 검색 조건을 설정하고 전체 목록을 가져오도록 수정
	            var searchParams = {
	                outCode: $("#outCode").val(),
	                prodName: $("#prodName").val(),
	                clientCompany: $("#clientCompany").val(),
	                sellState: sellStateButton // 전체 조건 추가
	            };
	            loadOutProductList(searchParams);
	        });
	     	// 미출고 버튼 클릭 시
	        $("#non_deliveryButton").click(function () {
	            // 미출고 버튼에 대한 동작을 추가하고,
	        	sellStateButton = "미출고";
	            // 검색 조건을 설정하고 미출고 목록을 가져오도록 수정
	            var searchParams = {
	                outCode: $("#outCode").val(),
	                prodName: $("#prodName").val(),
	                clientCompany: $("#clientCompany").val(),
	                sellState: sellStateButton // 미출고 조건 추가
	            };
	            loadOutProductList(searchParams);
	        });
	     	// 중간납품 버튼 클릭 시
	        $("#interim_deliveryButton").click(function () {
	            // 중간납품 버튼에 대한 동작을 추가하고,
	        	sellStateButton = "중간납품";
	            // 검색 조건을 설정하고 중간납품 목록을 가져오도록 수정
	            var searchParams = {
	                outCode: $("#outCode").val(),
	                prodName: $("#prodName").val(),
	                clientCompany: $("#clientCompany").val(),
	                sellState: sellStateButton // 중간납품 조건 추가
	            };
	            loadOutProductList(searchParams);
	        });
	     	// 출고완료 버튼 클릭 시
	        $("#deliveryButton").click(function () {
	            // 출고완료 버튼에 대한 동작을 추가하고,
	        	sellStateButton = "출고완료";
	            // 검색 조건을 설정하고 출고완료 목록을 가져오도록 수정
	            var searchParams = {
	                outCode: $("#outCode").val(),
	                prodName: $("#prodName").val(),
	                clientCompany: $("#clientCompany").val(),
	                sellState: sellStateButton // 출고완료 조건 추가
	            };
	            loadOutProductList(searchParams);
	        });
	    });
	
// 	    처음 게시판 데이터를 서버에서 비동기적으로 가져오는 함수
	    function firstLoadOutProductList() {
	      	
	    	 var searchParams = {
                outCode: $("#outCode").val(),
                prodName: $("#prodName").val(),
                clientCompany: $("#clientCompany").val(),
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
	            var row = $("<tr>");
	            row.append("<td>" + (data[i].outCode ? data[i].outCode : '') + "</td>");
	            row.append("<td>" + (data[i].sellCode ? data[i].sellCode : '') + "</td>");
	            row.append("<td>" + (data[i].clientCode ? data[i].clientCode : '') + "</td>");
	            row.append("<td>" + (data[i].clientCompany ? data[i].clientCompany : '') + "</td>");
	            row.append("<td>" + (data[i].prodCode ? data[i].prodCode : '') + "</td>");
	            row.append("<td>" + (data[i].prodName ? data[i].prodName : '') + "</td>");
	            row.append("<td>" + (data[i].sellCount ? data[i].sellCount : '') + "</td>");
	            row.append("<td>" + (data[i].whseCount ? data[i].whseCount : '') + "</td>");
	            row.append("<td>" + (data[i].outPrice ? data[i].outPrice : '') + "</td>");
	            row.append("<td>" + (data[i].sellDuedate ? data[i].sellDuedate : '') + "</td>");
	            row.append("<td>" + (data[i].outDate ? data[i].outDate : '') + "</td>");
	            row.append("<td>" + (data[i].outEmpId ? data[i].outEmpId : '') + "</td>");
	            row.append("<td>" + (data[i].sellState ? data[i].sellState : '') + "</td>");

	            // 출고처리 버튼 추가 (미출고 또는 중간납품인 경우에만 버튼 생성)
	            if (data[i].sellState == '미출고' || data[i].sellState == '중간납품') {
	                var button = $("<input type='button' value='출고처리'>");
	                button.click(function () {
	                    // 버튼 클릭 시 처리할 동작을 여기에 추가
	                });

	                // 버튼을 새로운 <td> 요소 내에 추가하고, 그 <td>를 행에 추가
	                var buttonCell = $("<td>").append(button);
	                row.append(buttonCell);
	            } else {
	                row.append("<td></td>"); // 출고처리 버튼을 추가하지 않음
	            }

	            // tbody에 행을 추가합니다.
	            tbody.append(row);
	        }

	    }
	</script>

</body>
</html>