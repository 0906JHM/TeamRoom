<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <style type="text/css">
.sidebar{
  margin: 0;
  padding: 0;
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
}

.sidebody {
    background: white;
    font-family: 'Open Sans', Arial, Helvetica, Sans-serif, Verdana, Tahoma;
    float: left;
    height: 1000px;
    background-color: white;
    /* width: 15%; */
    border-right: 1px solid;
}

ul { list-style-type: none; }

.sidea {
  color: #5EC397;
  text-decoration: none;
  font-weight: normal;
}

/** =======================
 * Contenedor Principal
 ===========================*/




h1 .sidea {
  color: #c12c42;
  font-size: 16px;
}

.sideaccordion {
    width: 90%;
    max-width: 100%;
    margin: 30px auto 20px;
    background: #FFF;
    float: left;
    padding-inline-start: 20px;
}

.sideaccordion .sidelink {
  cursor: pointer;
  display: block;
  padding: 15px 15px 15px;
  color: #4D4D4D;
  font-size: 20px;
  font-weight: bold;
  border-bottom: 1px solid #CCC;
  position: relative;
  -webkit-transition: all 0.4s ease;
  -o-transition: all 0.4s ease;
  transition: all 0.4s ease;
}

.sideaccordion li:last-child .sidelink { border-bottom: 0; }

.sideaccordion li i {
  top: 16px;
  left: 12px;
  font-size: 20px;
  color: #595959;
  -webkit-transition: all 0.4s ease;
  -o-transition: all 0.4s ease;
  transition: all 0.4s ease;
  margin-right: 10px;
}

.sideaccordion li i.fa-chevron-down {
  right: 12px;
  left: auto;
  font-size: 16px;
}

.sideaccordion li.open .sidelink { color: white; background-color: #5EC397;}

.sideaccordion li.open i { color: white; background-color: #5EC397; }

.sideaccordion li.open i.fa-chevron-down {
  -webkit-transform: rotate(180deg);
  -ms-transform: rotate(180deg);
  -o-transform: rotate(180deg);
  transform: rotate(180deg);
}

/**
 * Submenu
 -----------------------------*/


.submenu {
  display: none;
  font-size: 19px;
}

.submenu li { border-bottom: 1px solid #4b4a5e; }

.submenu .sidea {
  display: block;
  text-decoration: none;
  color: #929FA8;
  padding: 12px;
  -webkit-transition: all 0.25s ease;
  -o-transition: all 0.25s ease;
  transition: all 0.25s ease;
  padding-left: 22px;
}

.submenu .sidea:hover {
  color: #5EC397;
}

.loginhi{
text-align: center;
color: #384855;

}
.logout{
  text-align: center;
    color: #929FA8;
    text-decoration: none;
    display: block; /* 가운데 정렬을 위해 블록 레벨 요소로 설정 */
    margin-top: 600px;
     

}

.container{

  
}



.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-zrve{background-color:#0949f7;border-color:#3531ff;text-align:center;vertical-align:top}
.tg .tg-llyw{background-color:#c0c0c0;border-color:inherit;text-align:left;vertical-align:top}
.tg .tg-0pky{border-color:inherit;text-align:left;vertical-align:top}


    </style>
    <script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://kit.fontawesome.com/25ef23e806.js" crossorigin="anonymous"></script>

</head>
<body>

  <div class="sidebar">
    <div class="sidebody">
        <div class="logininfo">
        	<p class="loginhi">${sessionScope.empId}님 안녕하세요</p>
        </div>

        <div class="sidebar">
    <ul id="sideaccordion" class="sideaccordion">
       <li>
          <div class="sidelink"><i class="fa-solid fa-warehouse"></i>자재관리<i class="fa-solid fa-angle-down"></i></div>
          <ul class="submenu">
            <li><a href="#"class="sidea">재고관리</a></li>
            <li><a href="#"class="sidea">입고관리</a></li>
            <li><a href="#"class="sidea">출고관리</a></li>
            <li><a href="#"class="sidea">창고관리</a></li>
          </ul>
        </li>
        
        
        
        <li>
           <div class="sidelink"> <i class="fa-solid fa-bars"></i>생산 관리</div>
          <ul class="submenu">
            <li><a href="#"class="sidea">라인 관리</a></li>
            <li><a href="#"class="sidea">작업지시 관리</a></li>
            <li><a href="#"class="sidea">생산실적 관리</a></li>
          </ul>
        </li>
        
        
        
        <li>
          <div class="sidelink"><i class="fa-solid fa-pen"></i>영업관리</div>
          <ul class="submenu">
            <li><a href="#"class="sidea">수주관리</a></li>
            <li><a href="#"class="sidea">발주관리</a></li>
            <li><a href="#"class="sidea">거래처관리</a></li>
          </ul>
        </li>
        
        
        
        <li>  
          <div class="sidelink"><i class="fa-solid fa-pen"></i>인사관리</div>
          <ul class="submenu">
            <li><a href="#"class="sidea">사원관리</a></li>
          </ul>
        </li>
        
      </ul>
      
      </div>
      <div class="logininfo">
           <a href="${pageContext.request.contextPath}/login/logout" class="logout">로그아웃</a>
        </div>
    
    </div>
      
   
   
    </div>


      <script>
$(function() {
	var Accordion = function(el, multiple) {
		this.el = el || {};
		this.multiple = multiple || false;

		// Variables privadas
		var links = this.el.find('.sidelink');
		// Evento
		links.on('click', {el: this.el, multiple: this.multiple}, this.dropdown)
	}

	Accordion.prototype.dropdown = function(e) {
		var $el = e.data.el;
			$this = $(this),
			$next = $this.next();

		$next.slideToggle();
		$this.parent().toggleClass('open');

		if (!e.data.multiple) {
			$el.find('.submenu').not($next).slideUp().parent().removeClass('open');
		};
	}	

	var accordion = new Accordion($('#sideaccordion'), false);
});

      </script>
</body>
</html>