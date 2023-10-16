<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>추가</title>
</head>
<body>
<h2>창고 등록</h2>

<form action="${pageContext.request.contextPath}/Warehouse/writePro " method="post">
창고코드 :   <input type="text" name="whseCode" > <br>
창고이름 :   <input type="text" name="whseName" > <br>
창고타입 :   <select name="whseType">
                    <option value="원자재">원자재</option>
		            <option value="완제품">완제품</option>
                </select> <br>
창고 사용 상태 :   <select name="whseState">
                    <option value="Y">Y</option>
		            <option value="N">N</option>
                </select> <br>
창고주소 :   <input type="text" name="whseAddr" > <br>
창고연락처 :   <input type="text" name="whseTel" > <br>
창고 비고 :   <input type="text" name="whseMemo" > <br>
제품 코드 :   <input type="text" name="prodCode" > <br>
원자재 코드 :   <input type="text" name="rawCode" > <br>
창고 관리사원 아이디 :   <input type="text" name="whseEmpId" > <br>
재고 개수 :   <input type="text" name="whseCount" > <br><br>
<input type ="submit" value="창고등록">
</form>
</body>
</html>