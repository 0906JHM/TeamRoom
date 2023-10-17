<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://kit.fontawesome.com/25ef23e806.js"
	crossorigin="anonymous"></script>
</head>
<body>
	<aside class="sidebar">
		<div class="sidebody">
			<div class="logininfo">
				<!-- 			로고자리 -->
				<%-- 				<a href="${pageContext.request.contextPath }/main/calendar" style="font-size: 40px; padding: 30px;" >ROOMAIR</a> --%>
				<div id="logo">
				<a href="${pageContext.request.contextPath }/main/calendar"> 
				<img
					src="${pageContext.request.contextPath }/resources/img/logo.png">
				</a>
				</div>
				<!-- 			로고자리 -->
				<p class="loginhi">${sessionScope.empId}님 안녕하세요</p>
			</div>

			<div class="sidebar">
				<ul id="sideaccordion" class="sideaccordion">
					<li>
						<div class="sidelink">
							<i class="fa-solid fa-chart-simple"></i> 기준정보관리
						</div>
						<ul class="submenu">
							<li><a
								href="${pageContext.request.contextPath }/requirement/reqDetail"
								class="sidea">소요량관리</a></li>
							<li><a
								href="${pageContext.request.contextPath }/product/list"
								class="sidea">제품관리</a></li>
							<li><a
								href="${pageContext.request.contextPath }/Rawmaterials/home"
								class="sidea">원자재관리</a></li>
						</ul>
					</li>
					<li>
						<div class="sidelink">
							<i class="fa-solid fa-bars"></i>생산관리
						</div>
						<ul class="submenu">

							<li><a
								href="${pageContext.request.contextPath }/workorder/workOrderList"
								class="sidea">작업지시관리</a></li>
							<li><a href="${pageContext.request.contextPath }/line/line"
								class="sidea">라인관리</a></li>
							<li><a href="${pageContext.request.contextPath }/perf/perf"
								class="sidea">생산실적관리</a></li>
						</ul>
					</li>
					<li>
						<div class="sidelink">
							<i class="fa-solid fa-warehouse"></i>자재관리<i
								class="fa-solid fa-angle-down"></i>
						</div>
						<ul class="submenu">
							<li><a href="${pageContext.request.contextPath }/stock/list"
								class="sidea">재고관리</a></li>
							<li><a
								href="${pageContext.request.contextPath }/inMaterial/list"
								class="sidea">입고관리</a></li>
							<li><a
								href="${pageContext.request.contextPath }/outProduct/list"
								class="sidea">출고관리</a></li>
							<li><a
								href="${pageContext.request.contextPath }/Warehouse/list"
								class="sidea">창고관리</a></li>
						</ul>
					</li>
					<li>
						<div class="sidelink">
							<i class="fa-solid fa-pen"></i>영업관리
						</div>
						<ul class="submenu">
							<li><a
								href="${pageContext.request.contextPath}/sell/sellMain"
								class="sidea">수주관리</a></li>
							<li><a
								href="${pageContext.request.contextPath}/OrderManagement/home"
								class="sidea">발주관리</a></li>
							<li><a
								href="${pageContext.request.contextPath}/client/client"
								class="sidea">거래처관리</a></li>
						</ul>
						<div class="sidelink">
							<i class="fa-solid fa-pen"></i>인사관리
						</div>
						<ul class="submenu">
							<li><a
								href="${pageContext.request.contextPath }/employees/employees"
								class="sidea">사원관리</a></li>
						</ul>
					</li>
				</ul>
			</div>

			<div class="logininfo" style="text-align: center; margin-top: 600px;">
				<p>
					<a a href="${pageContext.request.contextPath}/login/login"
						style="color: #929FA8; text-decoration: none;">로그아웃</a>
				<p>
			</div>
		</div>




	</aside>

	<script>
		$(function() {
			var Accordion = function(el, multiple) {
				this.el = el || {};
				this.multiple = multiple || false;

				// Variables privadas
				var links = this.el.find('.sidelink');
				// Evento
				links.on('click', {
					el : this.el,
					multiple : this.multiple
				}, this.dropdown)
			}

			Accordion.prototype.dropdown = function(e) {
				var $el = e.data.el;
				$this = $(this), $next = $this.next();

				$next.slideToggle();
				$this.parent().toggleClass('open');

				if (!e.data.multiple) {
					$el.find('.submenu').not($next).slideUp().parent()
							.removeClass('open');
				}
				;
			}

			var accordion = new Accordion($('#sideaccordion'), false);
		});
	</script>
</body>
</html>