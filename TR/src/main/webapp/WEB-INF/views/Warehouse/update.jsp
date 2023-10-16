<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>창고 수정</title>
</head>
<body>
	<h1>창고 수정</h1>
	<form action="${pageContext.request.contextPath}/Warehouse/updatePro"
		method="post">

		<table border="1">
			<tr>
				<td>창고코드</td>
				<td><input type="text" name="whseCode"
					value="${warehouseDTO.whseCode}" readonly></td>
			</tr>

			<tr>
				<td>창고이름</td>
				<td><input type="text" name="whseName"
					value="${warehouseDTO.whseName}" readonly></td>
			</tr>

			<tr>
				<td>창고타입</td>
				<td><input type="text" name="whseType"
					value=" ${warehouseDTO.whseType}"></td>
			</tr>

			<tr>
				<td>창고사용상태</td>
				<td><input type="text" name="whseState"
					value="${warehouseDTO.whseState}"></td>
			</tr>

			<tr>
				<td>창고주소</td>
				<td><input type="text" name="whseAddr"
					value=" ${warehouseDTO.whseAddr}"></td>
			</tr>

			<tr>
				<td>창고연락처</td>
				<td><input type="text" name="whseTel"
					value=" ${warehouseDTO.whseTel}"></td>
			</tr>

			<tr>
				<td>창고비고</td>
				<td><input type="text" name="whseMemo"
					value=" ${warehouseDTO.whseMemo}"></td>
			</tr>

			<tr>
				<td>제품코드</td>
				<td><input type="text" name="prodCode"
					value=" ${warehouseDTO.prodCode}"></td>
			</tr>

			<tr>
				<td>원자재코드</td>
				<td><input type="text" name="rawCode"
					value=" ${warehouseDTO.rawCode}"></td>
			</tr>

			<tr>
				<td>창고관리사원아이디</td>
				<td><input type="text" name="EmpId"
					value=" ${warehouseDTO.whseEmpId}"></td>
			</tr>

			<tr>
				<td>재고개수</td>
				<td><input type="text" name="whseCount"
					value=" ${warehouseDTO.whseCount}"></td>
			</tr>

		</table>
		<input type="submit" value="수정">
	</form>
</body>
</html>