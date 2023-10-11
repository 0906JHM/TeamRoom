<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 사이드바 -->
<link href="${pageContext.request.contextPath }/resources/css/side.css"
	rel="stylesheet" type="text/css">

<title>inMaterial</title>
</head>
<body>
<div id="con">
	<h2>입고관리</h2>
	<div>
		<form method="get">
			<label>입고번호</label> <label>품명</label> <label>거래처명</label> <input
				type="submit" value="조회">

			<button type="submit" value="">
				<span>전체</span>
			</button>
			<input type="submit" value="미입고"></input> <input type="submit"
				value="입고완료"></input>
		</form>
	</div>

	<div>
		<h2>입고목록</h2>
	</div>

	<div>
		<form action="" method="post">
			<table>
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
						<th>처리</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>${inMaterialDTO.inNum }</td>
						<td>${inMaterialDTO.byNum }</td>
						<td>${inMaterialDTO.whseCode }</td>
<!-- 						거래처 코드 -->
						<td>${inMaterialDTO.clientCompany }</td>
<!-- 						품번 = 원자재 코드 -->
						<td>${inMaterialDTO.rawCode }</td>
<!-- 						원자재명 -->
						<td>${inMaterialDTO.rawName }</td>
						<td>${inMaterialDTO.rawCode }</td>
						<td>${inMaterialDTO.inCount }</td>
<!-- 						재고수량 -->
						<td></td>
<!-- 						단가 = 원자재 가격 -->
						<td>${inMaterialDTO.rawPrice }</td>
<!-- 						총액 -->
						<td></td>
						<td>${inMaterialDTO.inDate }</td>
						<td>${inMaterialDTO.inEmpId }</td>
						<td></td>
						<td>
							<button type="button">입고</button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</div>
</body>
</html>