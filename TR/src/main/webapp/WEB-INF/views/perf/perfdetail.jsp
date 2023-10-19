<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10/dist/sweetalert2.min.css">


<style>

table{
border: 1px solid rgba(221, 221, 221, 0.78);
    border-collapse: collapse;
    margin: 0 auto;
    color: #000000;
    width: 450px;
    max-width: 450px;
    font: 300 16px/16px "Inter", sans-serif;
    text-align: center;
    border-radius: 10px;

}

table th, table td {
	min-width: 100px;
	white-space: nowrap; /* 텍스트 줄 바꿈 방지 */
	padding: 0 15px;
	border: none;
}


table th{
    background-color: rgba(94, 195, 151, 0.6);
    height: 30px;
    border: 1px solid rgba(221, 221, 221, 0.78);

}

table td{
min-width: 100px;
    white-space: nowrap;
    padding: 0 15px;
    height: 30px;
    border: 1px solid rgba(221, 221, 221, 0.78);
}

input[type="text"] {
    /* border: 1px solid #adb5bb; */
    /* border-radius: 5px; */
    border: none;
    width: 90%;
    height: 25px;
    font: 300 15px/15px "Inter", sans-serif;
    text-align: center;
    background-color: inherit;
    }
    
 #inputnum {
        border: 1px solid rgba(94, 195, 151, 1);
    border-radius: 5px;
    text-align: center;
    }
    
    input[type="number"]{
	border:none;
	width: 90%;
	height: 20px;
	font: 300 15px/15px "Inter", sans-serif;
	text-align: center;
	background-color: inherit;
}

.footerbtn{

    display: flex;
    justify-content: center;
    margin-top: 30px;
    
}
.h2head {
 text-align: center;

}

input[type="button"], input[type="submit"] {
    background-color: rgba(94.0000019967556, 195.0000035762787, 151.00000619888306, 1);
    width: 100px;
    height: 30px;
    border-radius: 5px;
    color: #FFFFFF;
    border: 0;
    text-align: center;
    font: 300 18px/18px "Inter", sans-serif;
}

</style>

</head>
<body>
<h2 class="h2head"> 생산실적 내역 </h2>
<form id="detailform">
<table>
<tbody>
  <tr>
    <th> 실적코드 </th> 
    <td class="tg-0lax" id="perfCodeDisplay" ><input type="text" name="perfCode" value="${perfDTO.perfCode}" readonly> </td>
    </tr>
    
    <tr>
    <th> 지시코드 </th> 
    <td><input type="text" name="workCode" value="${perfDTO.workCode}" readonly></td>
    </tr>
    <tr>
    <th> 라인코드 </th>
    <td><input type="text" name="lineCode" value="${perfDTO.lineCode}"> </td>
    </tr>
    <tr>
    <th> 제품코드</th>
    <td><input type="text" name="prodCode" value="${perfDTO.prodCode}"></td>
    </tr>
    
    <tr>
    <th> 지시일자 </th>
    <td> <input type="text" name="perfDate" value="${perfDTO.perfDate}"> </td> 
    </tr>
    
    <tr>
    <th> 담당자 </th>
    <td><input type="text" name="perfEmpId" value="${perfDTO.perfEmpId}"></td>
    </tr>
    </tbody>
    </table>
    <br>
    
   <table id="tg">
  <tr>
    <th colspan=2>실적수</th>
    <th colspan=2>양품수</th>
    <th colspan=2 >불량수</th>

  </tr>
  <tr>
    <td colspan=2> <input type="number" id="inputnum" name="perfAmount" value="${perfDTO.perfAmount}"> </td>
    <td  colspan=2> <input type="number" id="inputnum"  name="perfFair" value="${perfDTO.perfFair}"> </td>
   <td  colspan=2> <input type="number" id="inputnum"   name="perfDefect" value="${perfDTO.perfDefect}"></td>
  </tr>
  
  <tr>
  <th colspan=2> 불량사유 </th>
  <th colspan=2> 불량내역 </th>
    <th colspan=2> 비고 </th>
  
  </tr>
  
  <tr>
    <td  colspan=2><select id="perfDefectreason" name="perfDefectreason" >
	                    	    <option value="무결함">무결함</option>
		                      	<option value="파손">파손</option> <!-- 병깨짐 , 포장박스 꾸겨진거 등 -->
								<option value="누락">누락</option> <!--  포장 박스에 물건이 없다던가 포장이 안된다던가 -->
								<option value="기타">기타</option>
						       </select>        </td>
  <td colspan=2>   <input type="text" name="perfDefectreasonmemo" value="${perfDTO.perfDefectmemo}"></td>
  <td colspan=2><input type="text" name="perfmemo" value="${perfDTO.perfMemo}"></td>
  </tr>
</table>


<div class="footerbtn">
<div class="ftbtn">
<input type="button" class="okbtn" id="okbtn" value="확인">
<input type="button" class="update2" id="update2" value="수정">
<input type="button" class="deletebtn" id="deletebtn" value="삭제">
</div>
</div>






</form>
<script>
$('#deletebtn').click(function() {
    var perfCode = $('#perfCodeDisplay').text();
    // 서버로 perfCode 값을 전송하여 해당 행을 삭제
    $.post("${pageContext.request.contextPath}/perfajax/delete", {
        perfCode: perfCode
    })
    .done(function(response) {
        // 성공 응답을 받은 경우
        Swal.fire({
            title: '삭제 성공',
            text: '성공적으로 삭제되었습니다.',
            icon: 'success'
        }).then(function() {
            location.reload(); // 페이지 새로고침
            window.opener.location.reload(); // 부모 창 새로고침
        });
    })
    .fail(function(response) {
        // 실패 응답을 받은 경우
        Swal.fire({
            title: '삭제 실패',
            text: '삭제에 실패하였습니다.',
            icon: 'error'
        });
    });
});

var selectedValue = document.getElementById("perfDefectreason").value;




</script>

</body>
</html>