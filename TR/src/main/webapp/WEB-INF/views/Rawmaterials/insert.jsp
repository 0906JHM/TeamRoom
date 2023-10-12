<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!-- head -->
<head>
<meta charset="UTF-8">  
<title>Insert title here</title>
</head>

<!-- body -->
<body>
<h1>품목추가</h1>

<!-- form -->
<form action="${pageContext.request.contextPath}/Rawmaterials/insertPro" method="post">
원자재코드 : 	<input type="text" name="rawCode"><br>
원자재명 : 		<input type="text" name="rawName"><br>
종류 :		<select name="rawType">
			<option value="">전체</option>
			<option value="향기">향기</option>
			<option value="용기">용기</option>
			<option value="스틱">스틱</option>
			<option value="라벨">라벨</option>
			<option value="포장재">포장재</option>
			</select><br>
단위 : 		<input type="text" name="rawUnit" value="EA"><br>
매입단가 : 		<input type="text" name="rawPrice"><br>
거래처 :		<input type="text" name="clientCode" id="pInput"> <input type="button" value="거래처목록" onclick="openPopup1()"><br>
창고명 : 		<input type="text" name="whseCode"> <input type="button" value="창고목록" onclick="openPopup2()"><br>
비고 : 		<input type="text" name="rawMemo"><br>
<input type="submit" value="품목추가">
</form>

<!-- javascript -->
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<script type="text/javascript">

// 참고사이트
// https://inpa.tistory.com/entry/JS-%F0%9F%93%9A-%EB%B6%80%EB%AA%A8%EC%B0%BD-%E2%9E%9C-%EC%9E%90%EC%8B%9D%EC%B0%BD%EC%9D%
// 98-%EA%B0%92-%EC%A0%84%EB%8B%AC#%EC%9E%90%EC%8B%9D%EC%B0%BD%EC%97%90%EC%84%9C_%EB%B6%80%EB%AA%A8%EC%B0%BD%EC%9C%BC%EB%A1
// %9C_%EA%B0%92_%EC%A0%84%EB%8B%AC%ED%95%98%EA%B8%B0

// openPopup1 페이지 팝업창
let openWin;
function openPopup1() {
	// window.name = "부모창 이름";
	window.name = "insert";
	// openWin = window.open("open할 window", "자식창 이름", "팝업창 옵션");
	openWin = window.open("selectclient2.html", "selectclient2", "height=600,width=1300");    
}
</script>
</body>
</html>