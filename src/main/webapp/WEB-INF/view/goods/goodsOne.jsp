<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>goodsOne</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="images/icons/favicon.png"/>
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
			
			// orderQuantity, cartQuantity, orderPrice ????????? ??????
			var goodsPrice = Number('<c:out value="${goodsMap.get('goodsPrice')}"/>');
			$('#orderQuantity').attr('value', 1);
			$('#orderPrice').attr('value', goodsPrice);
			$('#orderPriceText').text(goodsPrice);
			
			// totalPrice ?????? ??????
			var orderPriceText = $('#orderPriceText').text();
			var orderPriceText2 = orderPriceText.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$('#orderPriceText').text(orderPriceText2);
			
			// ????????? ???????????? ?????? ????????????
			var soldout = '<c:out value="${goodsMap.get('soldout')}"/>';
			if(soldout == 'Y'){
				$('#plusBtn').attr("disabled", true);
				$('#minusBtn').attr("disabled", true);
				$('#orderBtn').attr("disabled", true);
				$('#cartBtn').attr("disabled", true);
				$('#goodsOrderOption').attr("disabled", true);
			}

			// plusBtn ?????????
			$('#plusBtn').click(function(){
				$('#orderQuantity').attr('value', Number($('#orderQuantity').val()));
				$('#orderPrice').attr('value', goodsPrice*Number($('#orderQuantity').val()));
				$('#orderPriceText').text(goodsPrice*Number($('#orderQuantity').val()));
				
				var orderPriceText = $('#orderPriceText').text();
				var orderPriceText2 = orderPriceText.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				$('#orderPriceText').text(orderPriceText2);
			});
			
			// minusBtn ?????????
			$('#minusBtn').click(function(){
				if(Number($('#orderQuantity').val()) == 1 || Number($('#orderQuantity').val()) == -1){ // minusBtn ????????? orderQuantity 1?????? '-' ?????????
					return;
				} else {
					$('#orderQuantity').attr('value', Number($('#orderQuantity').val()));
					$('#orderPrice').attr('value', goodsPrice*Number($('#orderQuantity').val()));
					$('#orderPriceText').text(goodsPrice*Number($('#orderQuantity').val()));
					
					var orderPriceText = $('#orderPriceText').text();
					var orderPriceText2 = orderPriceText.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
					$('#orderPriceText').text(orderPriceText2);
				}
			});
			
			// ?????? ?????????
			$('#goodsOrderOption').change(function(){
				goodsPrice = Number('<c:out value="${goodsMap.get('goodsPrice')}"/>');
				// ?????? ??????
				if($('#goodsOrderOption').val() == '????????????'){
					goodsPrice = goodsPrice+2500;
					$('#orderPrice').attr('value', goodsPrice*Number($('#orderQuantity').val()));
					$('#orderPriceText').text(goodsPrice*Number($('#orderQuantity').val()));
					
					var orderPriceText = $('#orderPriceText').text();
					var orderPriceText2 = orderPriceText.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
					$('#orderPriceText').text(orderPriceText2);
				} else if ($('#goodsOrderOption').val() == '?????????'){
					goodsPrice = goodsPrice+5900;
					$('#orderPrice').attr('value', goodsPrice*Number($('#orderQuantity').val()));
					$('#orderPriceText').text(goodsPrice*Number($('#orderQuantity').val()));
					
					var orderPriceText = $('#orderPriceText').text();
					var orderPriceText2 = orderPriceText.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
					$('#orderPriceText').text(orderPriceText2);
				} else if($('#goodsOrderOption').val() == '????????????'){
					goodsPrice = goodsPrice;
					$('#orderPrice').attr('value', goodsPrice*Number($('#orderQuantity').val()));
					$('#orderPriceText').text(goodsPrice*Number($('#orderQuantity').val()));
					
					var orderPriceText = $('#orderPriceText').text();
					var orderPriceText2 = orderPriceText.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
					$('#orderPriceText').text(orderPriceText2);
				}
			});
			
			

			$('#orderBtn').click(function(){
				$("#orderForm").attr("action", "${pageContext.request.contextPath}/GetOrderInfoDirect");
				$('#orderForm').submit();
			});
			
			$('#cartBtn').click(function(){
				$("#orderForm").attr("action", "${pageContext.request.contextPath}/AddCart");
				$('#orderForm').submit();
			});
		});
	</script>
</head>
<body>
	<!-- ?????? ???????????? ?????? ?????? -->
	<c:if test="${loginMember == null}"> <!-- ???????????? -->
		<jsp:include page="/inc/menu.jsp"></jsp:include>	
	</c:if>
	<c:if test="${loginMember.level == 0}"> <!-- ?????????(??????) -->
		<jsp:include page="/inc/menuForCustomer.jsp"></jsp:include>	
	</c:if>
	<c:if test="${loginMember.level == 1}"> <!-- ?????????(??????) -->
		<jsp:include page="/inc/menuForEmp.jsp"></jsp:include>	
	</c:if>

	<!-- Product Detail -->
	<section class="sec-product-detail bg0 p-t-65 p-b-60">
		<div class="container">
			<div class="row">
			
				<div class="col-md-6 col-lg-7 p-b-30">
					<div class="p-l-25 p-r-30 p-lr-0-lg">
						<div class="wrap-slick3 flex-sb flex-w">
							<!-- ?????? ????????? ?????? -->
							<div class="slick3 gallery-lb">
								<div class="item-slick3" data-thumb="images/product-detail-01.jpg">
									<div class="wrap-pic-w pos-relative">
										<!-- ?????? ????????? ?????? -->
										<img src="${pageContext.request.contextPath}/upload/${goodsMap.get('fileName')}">
									</div>
								</div>
							</div>
							
						</div>
					</div>
				</div>
					
				<div class="col-md-6 col-lg-5 p-b-30">
					<div class="p-r-50 p-t-5 p-lr-0-lg">
						<!-- ?????? ?????? -->
						<h4 class="mtext-105 cl2 js-name-detail p-b-14">
							${goodsMap.get('goodsName')}
						</h4>
						<!-- ?????? ?????? -->
						<c:if test="${goodsMap.get('soldout') == 'Y'}">
							<span class="mtext-106 cl7">
								<del><fmt:formatNumber value="${goodsMap.get('goodsPrice')}" pattern="#,###"/>???</del> <span>????????????</span>
							</span>
						</c:if>
						<c:if test="${goodsMap.get('soldout') == 'N'}">
							<span class="mtext-106 cl2">
								<fmt:formatNumber value="${goodsMap.get('goodsPrice')}" pattern="#,###"/>???
							</span>
						</c:if>
						
						<!-- ?????? ?????? -->
						<p class="stext-102 cl3 p-t-23 p-b-100">
							Nulla eget sem vitae eros pharetra viverra. Nam vitae luctus ligula. Mauris consequat ornare feugiat.
						</p>
						
						<!-- ?????? ??????, ?????? ??? -->
						<form method="post" id="orderForm">
							<input type="hidden" name="goodsCode" value="${goodsMap.get('goodsCode')}">
							<input type="hidden" name="goodsName" value="${goodsMap.get('goodsName')}">
							<input type="hidden" name="goodsPrice" value="${goodsMap.get('goodsPrice')}">
							<input type="hidden" name="fileName" value="${goodsMap.get('fileName')}">
							<input type="hidden" name="customerId" value="${customerId}">
							<input type="hidden" name="orderPrice" id="orderPrice">
							
							<div class="p-t-33">
								<!-- ?????? ?????? -->
								<div class="flex-w flex-r-m p-b-10">
									<div class="stext-101 size-203 flex-c-m respon6">
										Option
									</div>
									
									<div class="size-204 respon6-next">
										<div class="rs1-select2 bg0">
											<select name="goodsOption" id="goodsOrderOption" class="form-control stext-101 w-50">
												<option value="????????????">1) ????????????(+0???)</option>
												<option value="????????????">2) ????????????(+2,500???)</option>
												<option value="?????????">3) ?????????(+5,900???)</option>
											</select>
										</div>
									</div>
								</div>
								
								<!-- ?????? ?????? -->
								<div class="flex-w flex-r-m p-b-10">
									<div class="stext-101 size-203 flex-c-m respon6">
										Quantity
									</div>
									
									<div class="size-204 flex-w flex-m respon6-next">
										<div class="wrap-num-product flex-w m-r-20 m-tb-10">
											<div class="btn-num-product-down cl8 hov-btn1 trans-04 flex-c-m" id="minusBtn">
												<i class="fs-16 zmdi zmdi-minus"></i>
											</div>
											<input class="mtext-104 cl3 txt-center num-product" type="number" name="orderQuantity" id="orderQuantity" readonly="readonly" >
											<div class="btn-num-product-up cl8 hov-btn1 trans-04 flex-c-m" id="plusBtn">
												<i class="fs-16 zmdi zmdi-plus"></i>
											</div>
										</div>
									</div>
								</div>
							</div>
								
							<!-- ?????? ?????? -->
							<div class="flex-w flex-r-m p-b-10">
								<div class="stext-101 size-203 flex-c-m respon6">
									Total Price
								</div>
								<div class="stext-101 size-204 respon6-next" id="orderPriceText">
									<!-- ??? ?????? ?????? -->
								</div>
							</div>
							
							<!-- ?????? ?????? -->
							<div class="flex-c-m flex-w w-full p-tb-40">
								<c:if test="${loginMember.level == 1}">
									<button type="button" id="orderBtn" class="flex-c-m stext-101 cl6 size-101 bg2 bor1 hov-btn1 p-lr-15 trans-04" disabled>
										?????? ??????
									</button>
									<span class="flex-c-m stext-70 size-70 p-lr-15"></span><!-- ??? ????????? -->
									<button type="button" id="cartBtn" class="flex-c-m stext-101 cl6 size-101 bg2 bor1 hov-btn1 p-lr-15 trans-04" disabled>
										???????????? ??????
									</button>
								</c:if>
								<c:if test="${loginMember.level == 0 || loginMember == null}">
									<button type="button" id="orderBtn" class="flex-c-m stext-101 cl6 size-101 bg2 bor1 hov-btn1 p-lr-15 trans-04">
										?????? ??????
									</button>
									<span class="flex-c-m stext-70 size-70 p-lr-15"></span><!-- ??? ????????? -->
									<button type="button" id="cartBtn" class="flex-c-m stext-101 cl6 size-101 bg2 bor1 hov-btn1 p-lr-15 trans-04">
										???????????? ??????
									</button>
								</c:if>
							</div>
						</div>
					</form>
				</div>
			</div>


			<!-- Review -->
			<div class="bor10 m-t-50 p-t-43 p-b-40">
				<div class="mtext-106 cl5 txt-center">Reviews(${fn:length(reviewList)})</div>
					<div class="p-t-43">
						<div class="row">
							<div class="col-sm-10 col-md-8 col-lg-6 m-lr-auto">
								<div class="p-b-30 m-lr-15-sm">
									<c:if test="${fn:length(reviewList) > 0}"> <!-- ????????? ????????? ?????? ??? -->
										<div class="flex-w flex-t p-b-30">
											<c:forEach var="r" items="${reviewList}">
												<div class="size-207 p-b-40">
													<div class="flex-w flex-sb-m p-b-17">
														<!-- ????????? -->
														<span class="mtext-107 cl2 p-r-20">${r.customerId}</span>
														<!-- ????????? -->
														<span class="cl11 stext-101">${r.createdate}</span>
													</div>
													<!-- ???????????? -->
													<p class="stext-102 cl6">${r.reviewMemo}</p>
												</div>
											</c:forEach>
										</div>
									</c:if>
									<c:if test="${fn:length(reviewList) == 0}"> <!-- ????????? ????????? ?????? ??? -->
										<div class="p-b-5 mtext-110 cl2 txt-center">????????? ????????? ????????????.</div>
									</c:if>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
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
		$('.js-addwish-b2, .js-addwish-detail').on('click', function(e){
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