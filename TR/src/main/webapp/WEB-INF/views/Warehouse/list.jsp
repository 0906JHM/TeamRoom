<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>창고 관리</title>
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/side.css" 
    rel="stylesheet" type="text/css">
 <jsp:include page = "../inc/side.jsp"></jsp:include>   
</head>
<body>

    <h2>창고 관리</h2>
    <form action="${pageContext.request.contextPath}/Warehouse/list" method="get">
    창고코드 <input type="text" name="search1" placeholder="창고코드">
    제품코드 <input type="text" name="search2" placeholder="제품코드">
    창고이름 <input type="text" name="search3" placeholder="창고이름">
    창고타입 <select name="search4">
                    <option value="">전체</option>
                    <option value="원자재">원자재</option>
		            <option value="완제품">완제품</option>
                </select>
    <input type="submit" value="검색">           
    </form>
    <br>
    <table border="1">
    
    </table>

</body>
</html>