<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
		<title>addReview</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(document).ready(function(){
				$('#reviewBtn').click(function(){
					if($('#reviewMemo').val() == ''){
						alert('내용을 입력하세요.');
						return;
					}
					
					$('#reviewForm').submit();
				});
			});
		</script>
	</head>
	<body>
		<!-- 세션 정보별로 메뉴 분기 -->
		<c:if test="${loginMember.level == 0}"> <!-- 로그인(회원) -->
			<jsp:include page="/inc/menuForCustomer.jsp"></jsp:include>	
		</c:if>
		<c:if test="${loginMember.level == 1}"> <!-- 로그인(사원) -->
			<jsp:include page="/inc/menuForEmp.jsp"></jsp:include>	
		</c:if>
		
		<!-- 본문 -->
		<h1>ADD REVIEW</h1>
		<form action="${pageContext.request.contextPath}/AddReview" method="post" id="reviewForm">
			<input type="hidden" name="orderCode" value="${order.orderCode}">
			<input type="hidden" name="goodsPrice" value="${order.goodsPrice}">
			<table>
				<tr>
					<th>주문번호</th>
					<td>${order.orderCode}</td>
					<th>주문일자</th>
					<td>${order.createdate}</td>
				</tr>
				<tr>
					<th>주문상품</th>
					<td>${order.goodsName}</td>
					<th>주문금액</th>
					<td>${order.orderPrice}</td>
				</tr>
				<tr>
					<th>리뷰내용</th>
					<td colspan="3">
						<textarea name="reviewMemo" id="reviewMemo"></textarea>
					</td>
				</tr>
			</table>
			<button type="button" id="reviewBtn">리뷰작성</button>
		</form>
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