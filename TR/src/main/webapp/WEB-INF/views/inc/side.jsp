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
				<p class="loginhi">________님 안녕하세요</p>
			</div>

			<div class="sidebar">
				<ul id="sideaccordion" class="sideaccordion">
					<li>
						<div class="sidelink">
							<i class="fa-solid fa-chart-simple"></i> 기준정보관리
						</div>
						<ul class="submenu">
							<li><a href="#" class="sidea">소요량관리</a></li>
							<li><a href="#" class="sidea">품목관리</a></li>
							<li><a href="#" class="sidea">원자재관리</a></li>
						</ul>
					</li>
					<li>
						<div class="sidelink">
							<i class="fa-solid fa-bars"></i>생산관리
						</div>
						<ul class="submenu">
							<li><a href="#" class="sidea">라인관리</a></li>
							<li><a href="#" class="sidea">작업지시관리</a></li>
							<li><a href="#" class="sidea">생산실적관리</a></li>
						</ul>
					</li>
					<li>
						<div class="sidelink">
							<i class="fa-solid fa-warehouse"></i>자재관리<i
								class="fa-solid fa-angle-down"></i>
						</div>
						<ul class="submenu">
							<li><a href="#" class="sidea">재고관리</a></li>
							<li><a href="#" class="sidea">입고관리</a></li>
							<li><a href="#" class="sidea">출고관리</a></li>
							<li><a href="#" class="sidea">창고관리</a></li>
						</ul>
					</li>
					<li>
						<div class="sidelink">
							<i class="fa-solid fa-pen"></i>영업관리
						</div>
						<ul class="submenu">
							<li><a href="#" class="sidea">수주관리</a></li>
							<li><a href="#" class="sidea">발주관리</a></li>
							<li><a href="#" class="sidea">거래처관리</a></li>
						</ul>
						<div class="sidelink">
							<i class="fa-solid fa-pen"></i>인사관리
						</div>
						<ul class="submenu">
							<li><a href="#" class="sidea">사원관리</a></li>
						</ul>
					</li>
				</ul>
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