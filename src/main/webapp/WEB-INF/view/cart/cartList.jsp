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
<script>
	$(document).ready(function(){
		let selectList = document.querySelectorAll('.goodsOption');
		let selectListLength = selectList.length;
		
		for(let i = 0; i<selectListLength; i++) {
			$(selectList[i]).change(function(){  
				console.log($(selectList[i]).val());
			    $("#cartListForm").attr("action", "${pageContext.request.contextPath}/CartList");
			    $('#cartListForm').submit();   
			});
		}
		

		let buttonMinusList = document.querySelectorAll('.btn-num-product-down');
		let buttonPlusList = document.querySelectorAll('.btn-num-product-up');
		let numProductList = document.querySelectorAll('.num-product');
		let orderQuantityList = document.querySelectorAll('.orderQuantity');
		let orderQuantityListLength = orderQuantityList.length;
		
		console.log(orderQuantityListLength);
		for(let i = 0; i<orderQuantityListLength; i++) {
			console.log($(numProductList[i]).val());
			$(buttonMinusList[i]).click(function(){
				let num = $(numProductList[i]).val();
				console.log(num);
				$(orderQuantityList[i]).val(num);
				$('#cartListForm').attr("action", "${pageContext.request.contextPath}/CartList");
			    $('#cartListForm').submit();
			});
			
			$(buttonPlusList[i]).click(function(){
				let num = $(numProductList[i]).val();
				console.log(num);
				$(orderQuantityList[i]).val(num);
				$('#cartListForm').attr("action", "${pageContext.request.contextPath}/CartList");
			  	$('#cartListForm').submit();   
			});
		}
		
		console.log(orderQuantityList);
		for(let i = 0; i<orderQuantityListLength; i++) {
			$(orderQuantityList[i]).change(function(){
			    $('#cartListForm').attr("action", "${pageContext.request.contextPath}/CartList");
			    $('#cartListForm').submit();   
			});
		}
		
		let flag = '<c:out value="${empty cartList}"/>'
		console.log(flag);
		if(flag == true) {
			$('#orderBtn').click(function(){		
				alert('장바구니가 비어있습니다.');
				return;
			});
			alert('장바구니가 비어있습니다.');
			return;
		}
		$('#orderBtn').click(function(){		
			$('#cartListForm').attr("action", "${pageContext.request.contextPath}/GetOrderInfoFromCart");
			$('#cartListForm').submit();   
		});
		
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
	});
</script>
<title>장바구니</title>
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
	
	<!-- Shoping Cart -->
	<form class="bg0 p-t-75 p-b-85" id="cartListForm" action="${pageContext.request.contextPath}/GetOrderInfoFromCart" method="post">
		<div class="container">
			<div class="bread-crumb flex-w p-l-0 p-r-15 p-t-30 p-lr-0-lg">
				<a href="${pageContext.request.contextPath}/Home" class="stext-109 cl8 hov-cl1 trans-04" style="font-size : 15pt;">
					Home
					<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
				</a>
	
				<span class="stext-109 cl4" style="font-size : 15pt;">
					Shoping Cart
				</span>
				
			</div>
			
			<div class="p-t-20 p-b-20 p-r-40" style="text-align:right">
				<a href="${pageContext.request.contextPath}/RemoveCartAll">
					<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-trash3" viewBox="0 0 16 16">
					<path d="M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5ZM11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H2.506a.58.58 0 0 0-.01 0H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1h-.995a.59.59 0 0 0-.01 0H11Zm1.958 1-.846 10.58a1 1 0 0 1-.997.92h-6.23a1 1 0 0 1-.997-.92L3.042 3.5h9.916Zm-7.487 1a.5.5 0 0 1 .528.47l.5 8.5a.5.5 0 0 1-.998.06L5 5.03a.5.5 0 0 1 .47-.53Zm5.058 0a.5.5 0 0 1 .47.53l-.5 8.5a.5.5 0 1 1-.998-.06l.5-8.5a.5.5 0 0 1 .528-.47ZM8 4.5a.5.5 0 0 1 .5.5v8.5a.5.5 0 0 1-1 0V5a.5.5 0 0 1 .5-.5Z"/>
					</svg>
				</a>
			</div>
			
			<br>
			
			<div class="wrap-table-shopping-cart">
				<c:if test="${empty cartList}">
					<table class="table-shopping-cart" style="text-align : center; width:100%">
						<tr class="table_head" style="text-align : center">
							<th style="text-align : center; width:30%">Image</th>
							<th style="text-align : center; width:15%">GoodsName</th>
							<th style="text-align : center; width:20%">Option</th>
							<th style="text-align : center; width:20%">Quantity</th>
							<th style="text-align : center; width:15%">Total</th>
						</tr>
						<tr>
							<td colspan="5" style="font-size:30pt">
								<div>&nbsp;</div>
								장바구니가 비어있습니다.
								<div>&nbsp;</div>
							</td>
						</tr>
					</table>
				</c:if>
					
				<c:if test="${!(empty cartList)}">
					<table class="table-shopping-cart" style="text-align : center; width:100%">
						<tr class="table_head" style="text-align : center">
							<th style="text-align : center; width:30%">Image</th>
							<th style="text-align : center; width:15%">GoodsName</th>
							<th style="text-align : center; width:20%">Option</th>
							<th style="text-align : center; width:15%">Quantity</th>
							<th style="text-align : center; width:10%">Total</th>
							<th style="text-align : center; width:10%">Delete</th>
						</tr>
						<c:forEach var="map" items="${cartList}">
							<input type="hidden" id="GoodsCode" name="goodsCode" value="${map.goodsCode}">
							<input type="hidden" id="goodsName" name="goodsName" value="${map.goodsName}">
							<input type="hidden" id="goodsOptionPrice" name="goodsOptionPrice" value="${map.goodsOptionPrice}">
							<input type="hidden" id="goodsPrice" name="goodsPrice" value="${map.goodsPrice}">
							<input type="hidden" id="fileName" name="fileName" value="${map.fileName}">
							<input class="orderQuantity" type="hidden" name="orderQuantity" value="${map.orderQuantity}" min="1">
							
							<tr class="table_row">
								<td>
									<img src="${pageContext.request.contextPath}/upload/${map.fileName}" id="fileName" name="fileName" style="width:200px; height:200px">
								</td>
								<td>${map.goodsName}</td>
								<td>
									<select name="goodsOption" id="goodsOption" class="goodsOption">
										<c:if test="${map.goodsOption eq '일반포장'}">
											<option value="일반포장" selected="selected">1) 일반포장(+0원)</option>
											<option value="고급포장">2) 고급포장(+2,500원)</option>
											<option value="보자기">3) 보자기(+5,900원)</option>
										</c:if>
										
										<c:if test="${map.goodsOption eq '고급포장'}">
											<option value="일반포장">1) 일반포장(+0원)</option>
											<option value="고급포장" selected="selected">2) 고급포장(+2,500원)</option>
											<option value="보자기">3) 보자기(+5,900원)</option>
										</c:if>
										
										<c:if test="${map.goodsOption eq '보자기'}">
											<option value="일반포장">1) 일반포장(+0원)</option>
											<option value="고급포장">2) 고급포장(+2,500원)</option>
											<option value="보자기" selected="selected">3) 보자기(+5,900원)</option>
										</c:if>
									</select>
								</td>
								
								<td>
									<div style="text-align:center;">
										<div class="wrap-num-product flex-w">
											<div class="btn-num-product-down cl8 hov-btn3 trans-04 flex-c-m">
												<i class="fs-16 zmdi zmdi-minus"></i>
											</div>
		
											<input class="mtext-104 cl3 txt-center num-product" type="number" name="" value="${map.orderQuantity}" min="1">
										
		
											<div class="btn-num-product-up cl8 hov-btn3 trans-04 flex-c-m">
												<i class="fs-16 zmdi zmdi-plus"></i>
											</div>
										</div>
									</div>
								</td>
								
								<td>${map.orderPrice}</td>
								<td><a href="${pageContext.request.contextPath}/RemoveCartOne?goodsCode=${map.goodsCode}&goodsOption=${map.goodsOption}">삭제</a></td>
							</tr>
							
						</c:forEach>
					</table>							
				</c:if>
			</div>
			
			<c:if test="${!(empty cartList)}">
				<div class="p-t-20 p-b-20 p-r-40" style="text-align:right">
					<button type="button" class="stext-101 cl6 size-101 bg2 bor1 hov-btn1" onclick="location.href='${pageContext.request.contextPath}/GetOrderInfoFromCart'">주문하기</button>
				</div>
			</c:if>
		</div>
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