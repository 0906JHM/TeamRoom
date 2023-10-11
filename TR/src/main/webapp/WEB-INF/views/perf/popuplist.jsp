<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<c:if test="${not empty lineDTO}">
        <h1>라인 정보</h1>
        <p>라인 코드: ${lineDTO.lineCode}</p>
        <p>라인 이름: ${lineDTO.lineName}</p>
        <%-- 라인DTO의 필드에 따라 필요한 정보 출력 --%>
    </c:if>

    <%-- 제품 코드에 대한 정보 출력 --%>
    <c:if test="${not empty prodDTO}">
        <h1>제품 정보</h1>
        <p>제품 코드: ${prodDTO.prodCode}</p>
        <p>제품 이름: ${prodDTO.prodName}</p>
        <%-- ProdDTO의 필드에 따라 필요한 정보 출력 --%>
    </c:if>



</body>
</html>