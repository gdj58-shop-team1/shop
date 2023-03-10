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
		<style>
			.font-th{
			    font-family: Poppins-Bold;
			    font-size: 13px;
			    color: #555;
			    text-transform: uppercase;
			    line-height: 1.6;
			    padding-top: 15px;
			    padding-bottom: 15px;
			    text-align: center;
			}
			
			.font-td{
				font-family: Poppins-Regular;
			    color: #555;
			    line-height: 1.6;
			}
		</style>
	</head>
	<body>
		<!-- 
			???????????? ?????????
			????????? ??????(?????? ?????? ??????)
			???????????? ??????(????????????, ????????????, ?????? ??????, ?????? ??????)
			?????? ?????? ?????? ??????(????????? ??????)
		-->
		 
		<!-- ?????????(??????) -->
		<jsp:include page="/inc/menuForCustomer.jsp"></jsp:include>
		
		<!-- ?????? -->
		<div class="container p-t-50">
			<div class="wrap-table-shopping-cart" style="border-color: white;">			
				<table class="table-shopping-cart" style="text-align:center;">
					<tr style="border-color: white;">
						<td colspan="5" class="font-td p-t-20">
							????????? ?????????????????????.<br>
							?????? 000000-00-000000 (?????????: ??????)<br>
							??? ????????? ???????????? ??? ???????????? ???????????????.<br>
						</td>
					</tr>
		 		</table>
		 	</div>
		</div>
		
		<br>
		
		<div class="container">
			<div class="wrap-table-shopping-cart">			
				<table class="table-shopping-cart" style=" text-align:center">
		 			<tr>
		 				<th colspan="5" class="mtext-109 cl2 text-center p-t-15 p-b-15">CUSTOMER INFO</th>
		 			</tr>
		 			<tr> <!-- ????????? ?????? -->
		 				<th class="font-th">CUSTOMER ID</th>
			 			<td>${customer.customerId}</td>
			 		</tr>
			 		<tr>
			 			<th class="font-th">PHONE</th>
						<td class="font-td">${customer.customerPhone}</td>
					</tr>
			 		<tr>
			 			<th class="font-th">SHIPPING ADDRESS</th>
			 			<td colspan="2">${address}</td>
		 			</tr>
		 		</table>
		 	</div>
		</div>
		
		<br><br>
		
		<div class="container">
			<div class="wrap-table-shopping-cart">			
				<table class="table-shopping-cart" style=" text-align:center">
					<tr>
		 				<th colspan="5" class="mtext-109 cl2 text-center p-t-15 p-b-15">ORDER INFO</th>
		 			</tr>
		 			<tr> <!-- ?????????????????? -->
		 				<th class="font-th">IMAGE</th>
			 			<th class="font-th">PRODUCT</th>
			 			<th class="font-th">OPTION</th>
			 			<th class="font-th">QUANTITY</th>
			 			<th class="font-th">PRICE</th>
		 			</tr>
		 			<tr>
		 				<td>
		 					<img src="${pageContext.request.contextPath}/upload/${fileName}" width="100" height="100">
		 				</td>
			 			<td class="font-td">${goodsName}</td>
			 			<td class="font-td">${order.goodsOption}</td>
			 			<td class="font-td">${order.orderQuantity}</td>
			 			<td class="font-td">${order.orderPrice}</td>
			 		</tr>
			 		
			 		<tr>
		 				<th colspan="5" id="totalPrice" class="mtext-109 cl2 text-center p-t-15 p-b-15">??? ????????????: ${order.orderPrice}???</th>
		 			</tr>
			 	</table>
			</div>
		</div>
		
		<!-- footer -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	 	
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