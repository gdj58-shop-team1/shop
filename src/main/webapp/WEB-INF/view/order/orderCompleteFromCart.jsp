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
		<title>orderComplete</title>
	</head>
	<body>
		<!-- 
			주문완료 페이지
			주문자 정보(이름 주소 번호)
			주문상품 정보(주문번호, 상품이름, 상품 갯수, 결제 금액)
			결제 완료 안내 문구(무통장 입금)
		-->
		 
		<!-- 로그인(회원) -->
		<jsp:include page="/inc/menuForCustomer.jsp"></jsp:include>
		
		<br><br>
		
		<!-- 본문 -->
		<div class="container p-l-40 p-r-57" style="text-align:center">
			<div class="wrap-table-shopping-cart">			
				<table class="table-shopping-cart" style=" text-align:center">
					
					<tr>
						<th colspan="5" class="p-t-10 p-b-10" style="text-align : center; font-size:15pt;">
							주문이 완료되었습니다.<br>
							국민 000000-00-000000(예금주: 구디)<br>
							위 계좌로 입금완료 시 주문발송 처리됩니다.<br>
						</th>
					</tr>
					<tr>
		 				<th colspan="5" class="p-t-10 p-b-10" style="text-align : center; font-size:15pt;">주문정보</th>
		 			</tr>
		 			<tr> <!-- 주문자 정보 -->
		 				<th class="p-t-10 p-b-10" style="text-align : center; font-size:15pt;">주문자 이름</th>
			 			<th class="p-t-10 p-b-10" style="text-align : center; font-size:15pt;">${orderCustomer.customerName}</th>
		 			</tr>
		 			
		 			<tr>
						<th class="p-t-10 p-b-10" style="text-align : center; font-size:15pt;">PHONE</th>
						<th class="p-t-10 p-b-10" style="text-align : center; font-size:15pt;">${orderCustomer.customerPhone}</th>
					</tr>
					
		 			<tr> <!-- 주문상품정보 -->
		 				<th class="p-t-10 p-b-10" style="text-align : center; font-size:15pt;">배송지</th>
			 			<th class="p-t-10 p-b-10" style="text-align : center; font-size:15pt;">${address}</th>
		 			</tr>				
				</table>	
			</div>
		</div>
		
		<br><br>
		
		<div class="container">
			<div class="wrap-table-shopping-cart">
				<table class="table-shopping-cart" style="text-align : center; width:100%">
		 			<tr> <!-- 주문상품정보 -->
		 				<th class="p-t-10 p-b-10" style="text-align : center; font-size:15pt;">Image</th>
			 			<th class="p-t-10 p-b-10" style="text-align : center; font-size:15pt;">GoodsName</th>
			 			<th class="p-t-10 p-b-10" style="text-align : center; font-size:15pt;">Option</th>
			 			<th class="p-t-10 p-b-10" style="text-align : center; font-size:15pt;">Quantity</th>
			 			<th class="p-t-10 p-b-10" style="text-align : center; font-size:15pt;">Price</th>
		 			</tr>
		 			
		 			<c:forEach var="o" items="${orderList}">
		 				<tr>
			 				<td>
			 					<img src="${pageContext.request.contextPath}/upload/${o.fileName}" width="100" height="100">
			 				</td>
				 			<td>${o.goodsName}</td>
				 			<td>${o.goodsOption}</td>
				 			<td>${o.orderQuantity}</td>
				 			<td>${o.orderPrice}</td>
				 		</tr>
		 			</c:forEach>
		 			
			 		<tr>
		 				<td colspan="5" id="totalPrice">총 주문금액: ${totalPrice}원</td>
		 			</tr>
			 	</table>
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