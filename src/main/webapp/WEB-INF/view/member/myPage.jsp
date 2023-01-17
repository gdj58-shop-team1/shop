<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/icons/favicon.png"/>
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/fonts/linearicons-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/animate/animate.css">
<!--===============================================================================================-->	
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/slick/slick.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/MagnificPopup/magnific-popup.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/perfect-scrollbar/perfect-scrollbar.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/util.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
<!--===============================================================================================-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<!-- bootStrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<title>My Page</title>
</head>

<body>
	<!-- 세션 정보별로 메뉴 분기 -->
	<c:if test="${loginMember == null}"> <!-- 비로그인 -->
		<jsp:include page="/inc/menu.jsp"></jsp:include>	
	</c:if>
	<c:if test="${loginMember.level == 0}"> <!-- 로그인(회원) -->
		<jsp:include page="/inc/menuForCustomer.jsp"></jsp:include>	
	</c:if>
	<c:if test="${loginMember.level == 1}"> <!-- 로그인(사원) -->
		<jsp:include page="/inc/menuForEmp.jsp"></jsp:include>	
	</c:if>
	
	<br><br>
	

	<div class="container" style="height: 80%;">
		<div class="row">
			<div class="col-md-3 col-lg-3 p-b-80">
				<div class="side-menu">
					<div class="p-t-55">
						<h4 class="mtext-112 cl2 p-b-33">
							Categories
						</h4>
	
						<ul>
							<li class="bor18">									
								<a href="${pageContext.request.contextPath}/OrderList" class="dis-block stext-115 cl6 hov-cl1 trans-04 p-tb-8 p-lr-4" style="font-size:20pt">
									주문목록
								</a>
							</li>
	
							<li class="bor18">
								<a href="${pageContext.request.contextPath}/ReviewList" class="dis-block stext-115 cl6 hov-cl1 trans-04 p-tb-8 p-lr-4" style="font-size:20pt">
									리뷰목록
								</a>
							</li>
	
							<li class="bor18">
								<a href="${pageContext.request.contextPath}/QuestionList" class="dis-block stext-115 cl6 hov-cl1 trans-04 p-tb-8 p-lr-4" style="font-size:20pt">
									문의사항
								</a>
							</li>
	
							<li class="bor18">
								<a href="${pageContext.request.contextPath}/ConfirmMember" class="dis-block stext-115 cl6 hov-cl1 trans-04 p-tb-8 p-lr-4" style="font-size:20pt">
									정보변경
								</a>
							</li>
	
							<li class="bor18">
								<a href="${pageContext.request.contextPath}/AddressList" class="dis-block stext-115 cl6 hov-cl1 trans-04 p-tb-8 p-lr-4" style="font-size:20pt">
									배송지변경
								</a>
							</li>
							
							<li class="bor18">
								<a href="${pageContext.request.contextPath}/RemoveMember" class="dis-block stext-115 cl6 hov-cl1 trans-04 p-tb-8 p-lr-4" style="font-size:20pt"	>
									회원탈퇴
								</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			
			<div class="col-md-9 col-lg-3 p-b-80">
				<c:if test="${loginMember.level == 0}"> <!-- 로그인(회원) -->
					<h1>회원</h1>
					<table>
						<tr>
							<th>ID</th>
							<td>${loginMember.customerId}</td>
						</tr>
						
						<tr>
							<th>NAME</th>
							<td>${loginMember.customerName}</td>
						</tr>	
					</table>
					
					<div style="text-align:center">
						<i class="zmdi zmdi-account-circle" style="font-size:100pt"></i>
					</div>
				</c:if>
				
				<c:if test="${loginMember.level == 1}"> <!-- 로그인(사원) -->
					<h1>사원 (레벨 : ${loginMember.authCode})</h1>
					<table>
						<tr>
							<th>ID</th>
							<td>${loginMember.empId}</td>
						</tr>
						
						<tr>
							<th>NAME</th>
							<td>${loginMember.empName}</td>
						</tr>	
					</table>
					
					<div style="text-align:center">
						<i class="zmdi zmdi-account-circle" style="font-size:100pt"></i>
					</div>
				</c:if>
			</div>
		</div>	
	</div>
<!--===============================================================================================-->	
	<script src="${pageContext.request.contextPath}/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/vendor/bootstrap/js/popper.js"></script>
	<script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/vendor/select2/select2.min.js"></script>
	<script>
		$(".js-select2").each(function(){
			$(this).select2({
				minimumResultsForSearch: 20,
				dropdownParent: $(this).next('.dropDownSelect2')
			});
		})
	</script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/vendor/daterangepicker/moment.min.js"></script>
	<script src="${pageContext.request.contextPath}/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/vendor/slick/slick.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/slick-custom.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/vendor/parallax100/parallax100.js"></script>
	<script>
        $('.parallax100').parallax100();
	</script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/vendor/MagnificPopup/jquery.magnific-popup.min.js"></script>
	<script>
		$('.gallery-lb').each(function() { // the containers for all your galleries
			$(this).magnificPopup({
		        delegate: 'a', // the selector for gallery item
		        type: 'image',
		        gallery: {
		        	enabled:true
		        },
		        mainClass: 'mfp-fade'
		    });
		});
	</script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/vendor/isotope/isotope.pkgd.min.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/vendor/sweetalert/sweetalert.min.js"></script>
	<script>
		$('.js-addwish-b2').on('click', function(e){
			e.preventDefault();
		});

		$('.js-addwish-b2').each(function(){
			var nameProduct = $(this).parent().parent().find('.js-name-b2').html();
			$(this).on('click', function(){
				swal(nameProduct, "is added to wishlist !", "success");

				$(this).addClass('js-addedwish-b2');
				$(this).off('click');
			});
		});

		$('.js-addwish-detail').each(function(){
			var nameProduct = $(this).parent().parent().parent().find('.js-name-detail').html();

			$(this).on('click', function(){
				swal(nameProduct, "is added to wishlist !", "success");

				$(this).addClass('js-addedwish-detail');
				$(this).off('click');
			});
		});

		/*---------------------------------------------*/

		$('.js-addcart-detail').each(function(){
			var nameProduct = $(this).parent().parent().parent().parent().find('.js-name-detail').html();
			$(this).on('click', function(){
				swal(nameProduct, "is added to cart !", "success");
			});
		});
	
	</script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/vendor/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	<script>
		$('.js-pscroll').each(function(){
			$(this).css('position','relative');
			$(this).css('overflow','hidden');
			var ps = new PerfectScrollbar(this, {
				wheelSpeed: 1,
				scrollingThreshold: 1000,
				wheelPropagation: false,
			});

			$(window).on('resize', function(){
				ps.update();
			})
		});
	</script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>