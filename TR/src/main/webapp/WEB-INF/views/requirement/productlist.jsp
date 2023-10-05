<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<!-- SheetJS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
<!--FileSaver [savaAs 함수 이용] -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>


<link href="https://webfontworld.github.io/NexonLv2Gothic/NexonLv2Gothic.css" rel="stylesheet">


<style type="text/css">

body {
	font-family: 'NexonLv2Gothic';
}

div:where(.swal2-container) button:where(.swal2-styled).swal2-deny{
	background-color: #868e96;
}
</style>
<!-- 폰트 -->

<script>
    
  //input으로 바꾸기 
	// 팝업 옵션
	const popupOpt = "top=60,left=140,width=877,height=677";
	
	//검색 팝업(거래처)
  	function openWindow(search, inputId) {
   	 	var url = "/workorder/search?type=" + search + "&input=" + inputId;
    	var popup = window.open(url, "", popupOpt);
    } //openWindow()

       	
	function popUp() {
		var queryString = window.location.search;
		var urlParams = new URLSearchParams(queryString);
		
		var isPop = urlParams.get("input");
		
		if(isPop==="null") {
			isPop = null;
		}
		
		$('#pagination a').each(function(){
			
	   		var prHref = $(this).attr("href");
	   		
	   		var newHref = prHref + "&input=" + isPop;
	   			$(this).attr("href", newHref);
				
		}); //페이징 요소	
				
		$('#input').val(isPop);
   			
   		if(isPop) {
        		
       		$('table tr:not(:first-child)').click(function(){
       			$(this).css('background', '#ccc');
        			
       			var prodCode = $(this).find('#prodCode').text();
     			var prodName = $(this).find('#prodName').text();
     			var prodUnit = $(this).find('#prodUnit').text();
     			
     			var number = isPop.match(/\d+/);
     			/* $('#'+isPop, opener.document).val(prodCode);
     			$('#prodUnit', opener.document).val(prodUnit); */
     			if(number !=null){
     			$('#prodName'+number, opener.document).val(prodName);
     			$('#prodCode'+number, opener.document).val(prodCode);
     			$('#prodUnit'+number, opener.document).val(prodUnit);
     			} else {
     			$('#prodName', opener.document).val(prodName);
     			$('#prodCode', opener.document).val(prodCode);
     			$('#prodUnit', opener.document).val(prodUnit);
     			}
     			
         		window.close();
         	}); //테이블에서 누른 행 부모창에 자동입력하고 창 닫기
        		
    	} else {
    		console.log("팝업아님");
    	} //if(팝업으로 열었을 때)
    		
	} //popUp()
		//jQuery
        $(document).ready(function() {
        	
        	popUp();
        	
        	//테이블 항목들 인덱스 부여
    		$('table tr').each(function(index){
    			var num = "<c:out value='${paging.nowPage}'/>";
    			var num2 = "<c:out value='${paging.cntPerPage}'/>";
    			$(this).find('td:first').text(((num-1)*num2) + index-1);
    		});
             
        });
    </script>
   
<style>
.table-wrapper {
    overflow-x: auto; /* 테이블 직접 조절 */
    overflow-y: hidden;
}
.table-wrapper table {
    width: 100%; /* 테이블 직접 조절 */
    white-space: nowrap; 
    text-align: center;
}
.input-fielda {
    cursor: pointer;
    display: inline-block;
    text-align-last: center;
}
.input-fieldb {
    display: inline-block;
    text-align-last: center;
}
</style>
   
   
<!-- page content -->
<div class="right_col" role="main">

	<h1 style="margin-left: 1%;">품목 관리</h1>
	
	<div style="margin: 1% 1%;">
	<hr>
	<form action="" method="get">
		<fieldset>
       		
       		<input type="hidden" name="input" id="input" value="${input }">   		

       		<label>품번&nbsp;</label>
        	<input type="text" name="prodCode" id="searchCode" placeholder="품목코드를 입력하세요."> &nbsp;&nbsp;
        	<label>제품명&nbsp;</label>
        	<input type="text" name="prodName" id="searchName" placeholder="품명을 입력하세요."> &nbsp;&nbsp;
        	<label>카테고리&nbsp;</label>
        	<input type="text" name="prodPerfume" id="searchCategory" placeholder="카테고리를 입력하세요."> &nbsp;&nbsp;
        	<label>거래처명&nbsp;</label>
        	<input type="hidden" name="clientCode" id="clientCode9999">
        	<input type="text" name="clientCompany" id="clientCompany9999" placeholder="거래처를 선택하세요." onclick="serchClient('clientCode9999')" class="input-fieldc"> &nbsp;&nbsp;
        	<input type="submit" class="B B-info" value="조회">

		</fieldset>
	</form>
<hr>
</div>	


<div class="col-md-12 col-sm-12">
	<div class="x_panel">
	
			<div class="x_title">
				<h2>제품<small> 총 ${paging.total} 건</small></h2>
				
			</div>
			
		<form id="fr" method="post">
		<!-- 버튼 제어 -->
		
		<div class="x_content">
			<div class="table-responsive">
				<div class="table-wrapper" >
<%-- 		완제품 목록 총 ${paging.total}건 --%>
		<table id="productTable"
		class="table table-striped jambo_table bulk_action" style="text-align-last:center;">
			<thead>
				<tr class="headings">
					<th>번호</th>
					<th>품번</th>
					<th>제품명</th>
					<th>카테고리</th>
					<th>품목 단위</th>
					
					<th>사이즈</th>
					<!-- <th type='hidden' style='display: none;'>거래처코드</th> -->
					<!-- <th>거래처명</th> -->
					<!-- <th type='hidden' style='display: none;'>창고코드</th> -->
					<!-- <th>창고명</th> -->
					<th>매출단가</th>
					<th>비고</th>
				</tr>
			</thead>
			<tr type='hidden' style='display: none;'></tr>
			
			<c:forEach var="dto" items="${prodList}">
					<tr>
						<td></td>
         			    <td id="prodCode">${dto.prodCode }</td>
						<td id="prodName">${dto.prodName }</td>
						<td>${dto.prodPerfume }</td>
						<td id="prodUnit">${dto.prodUnit }</td>
						
						<td>${dto.prodSize }</td>
						<%-- <td type='hidden' style='display: none;'>${dto.clientCode }</td> --%>
						<%-- <td>${dto.clients.clientCompany }</td> --%>
						<%-- <td type='hidden' style='display: none;'>${dto.whseCode }</td>
						<td>${dto.wh.whseName }</td> --%>
						<td><fmt:formatNumber>${dto.prodPrice }</fmt:formatNumber></td>
						<td>${dto.prodMemo }</td>
					</tr>
			</c:forEach>
		</table>
		</div>
		</div>
		</div>
	</form>
	
	<!-- //////////////////////////////////////////////////////////////////////// -->	
	<div id="pagination" class="dataTables_paginate paging_simple_numbers">
		<ul class="pagination">
			<li class="paginate_button previous disabled">	
				<c:if test="${paging.startPage != 1 }">
					<a href="${pageContext.request.contextPath}/requirement/product?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}&prodCode=${dto.prodCode }&prodName=${dto.prodName }&prodPerfume=${dto.prodPerfume }&clientCode=${dto.clientCode }">Previous</a>
				</c:if>
			</li>
			<li class="paginate_button previous disabled">	
				<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
							<a href="${pageContext.request.contextPath}/requirement/product?nowPage=${p }&cntPerPage=${paging.cntPerPage}&prodCode=${dto.prodCode }&prodName=${dto.prodName }&prodPerfume=${dto.prodPerfume }&clientCode=${dto.clientCode }">${p }</a>
				</c:forEach>
			</li>
			<li class="paginate_button previous disabled">	
				<c:if test="${paging.endPage != paging.lastPage}">
					<a href="${pageContext.request.contextPath}/requirement/product?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}&prodCode=${dto.prodCode }&prodName=${dto.prodName }&prodPerfume=${dto.prodPerfume }&clientCode=${dto.clientCode }">Next</a>
				</c:if>
			</li>
		</ul>
	</div>	


</div>
</div>
</div>