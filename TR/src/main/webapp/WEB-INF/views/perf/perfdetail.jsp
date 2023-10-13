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

<table class="tg">
<thead>
  <tr>
    <th class="tg-0lax">생산실적코드</th>
    <th class="tg-0lax">작업지시코드</th>
    <th class="tg-0lax">라인코드</th>
    <th class="tg-0lax">제품코드</th>
    <th class="tg-0lax">실적일</th>
    <th class="tg-0lax">담당자</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-0lax">${perfDTO.perfCode}</td>
    <td class="tg-0lax">${perfDTO.workCode}</td>
    <td class="tg-0lax">${perfDTO.lineCode}</td>
    <td class="tg-0lax">${perfDTO.prodCode}</td>
    <td class="tg-0lax">${perfDTO.perfDate}</td>
    <td class="tg-0lax">${perfDTO.perfEmpId}</td>
  </tr>
  <tr>
    <td class="tg-0lax">실적수</td>
    <td class="tg-0lax">양품수</td>
    <td class="tg-0lax">불량수</td>
    <td class="tg-0lax">불량사유</td>
    <td class="tg-0lax">기타</td>
    <td class="tg-0lax">비고</td>
  </tr>
  <tr>
    <td class="tg-0lax">${perfDTO.perfAmount}</td>
    <td class="tg-0lax">${perfDTO.perfFair}</td>
    <td class="tg-0lax">${perfDTO.perfDefect}</td>
    <td class="tg-0lax">${perfDTO.perfDefectreason}</td>
    <td class="tg-0lax">${perfDTO.perfDefectmemo}</td>
    <td class="tg-0lax">${perfDTO.perfMemo}</td>
  </tr>
</tbody>
</table>

<script>
document.getElementById("updateButton").addEventListener("click", function() {
    var clientCompany = '${perfDTO.perfCode}'; // 서버에서 받은 clientCompany 값
    var updateUrl = '${pageContext.request.contextPath}/perf/perfupdate?perfCode=' + perfCode;
    window.open(updateUrl, '_blank', 'width=1000px, height=1000px, left=600px, top=300px');
});

function clientdelete(clientCompany) {
    if (confirm("정말로 삭제하시겠습니까?")) {
        // 확인을 선택한 경우 삭제 요청을 보냅니다.
        location.href = '${pageContext.request.contextPath}/perf/delete?=' + perfCode;
         console.log(perfCode);
    }
}


</script>

</body>
</html>