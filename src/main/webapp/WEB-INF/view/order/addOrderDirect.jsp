<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		<title>addOrderDirect</title>
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
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(document).ready(function(){
				
				var customerPoint = Number('<c:out value="${customer.point}"/>');
				var orderPrice = Number('<c:out value="${orderPrice}"/>');
				var optionCk = $('select option:selected').val(); // 선택된 옵션의 값
				console.log(optionCk);
				console.log(orderPrice);
				
				$('#addressCode').change(function(){ // 주소 선택 값이 바뀌면
					optionCk = $('select option:selected').val(); // 선택된 옵션의 값을 가져오기
					if(optionCk != 0){ // 주소 선택 값이 있으면
						$('#newAddress').val(''); // 새 주소 입력칸을 비우고
						$("#newAddress").attr("disabled",true); // 비활성화
					} else { // 선택 안하면
						$("#newAddress").attr("disabled",false); // 활성화
					}
				});
				
				// 포인트 적용 버튼이 눌리면
				$('#point').change(function(){
					if(Number($('#point').val()) > customerPoint){
						alert('보유 포인트가 모자랍니다.');
						$('#point').val('');
						return;
					}
					if(Number($('#point').val()) < 0){
						alert('0 이상 입력가능합니다.');
						$('#point').val('');
						return;
					}
					$('#currentPoint').text(customerPoint-Number($('#point').val())); // 현재 포인트 변경
					$('#goodsPriceWO').text(orderPrice-Number($('#point').val()));
					$('#totalPrice').text(orderPrice-Number($('#point').val())); // 총 금액 변경
					$('#orderPrice').attr('value', orderPrice-Number($('#point').val())); // 넘어갈 주문 금액 value 변경
					$('#changePriceMsg').text('(' + orderPrice+' - '+Number($('#point').val())+' = '+ $('#orderPrice').val() + ')');
					console.log('메시지');
					
				});
				
				$('#addOrderBtn').click(function(){
					if($('#newAddress').val() && optionCk != 0){ // 두 곳에 주소 작성이 되었을 경우
						console.log($('#newAddress').val());
						alert('주소는 한 곳에만 입력가능합니다.(주소 선택 또는 새 주소 입력)');
						return;
					} else if(!$('#newAddress').val() && optionCk == 0){ // 주소 작성이 되지 않았을 경우 
						console.log($('#newAddress').text());
						alert('기존 주소를 선택하거나 새 주소를 입력하세요.');
						return;
					}
					if(Number($('#point').val()) > customerPoint){
						alert('사용 가능한 포인트 보다 입력 포인트가 많습니다.');
						return;
					}
					$('#addOrderForm').submit();
				});
				
			});
		</script>
	</head>
	<body>
		<!-- 
			주문 페이지 ->(이 시점에 DB orders 테이블로 넘어감) 주문완료
			사용자 정보(사용자 포인트 readonly, 이름readonly, 번호readonly, 주소)
			주문 상품 정보(상품 코드, 상품 이름readonly, 상품 갯수readonly, 총 주문 금액readonly - 사용자 포인트 사용 여부에 따라 달라짐)
		 -->

		<!-- 로그인(회원) -->
		<jsp:include page="/inc/menuForCustomer.jsp"></jsp:include>

		<form action="${pageContext.request.contextPath}/AddOrderDirect" method="post" id="addOrderForm" class="bg0 p-t-50 p-b-85">
			<input type="hidden" name="goodsCode" value="${goodsCode}">
			<input type="hidden" name="orderPrice" id="orderPrice" value="${order.orderPrice}">
			<div class="container p-l-40 p-r-57" style="text-align:center">
				<!-- 상품코드, (상품가격), 아이디, 옵션, 주소코드, 주문수량, 총가격 -->
				<div class="wrap-table-shopping-cart">
				 	<table class="table-shopping-cart"> <!-- 주문고객정보 -->
			 			<tr>
			 				<th colspan="4" class="font-th">CUSTOMER INFO</th>
			 			</tr>
				 		<tr>
				 			<th class="font-th w-25">NAME</th>
				 			<td class="font-td w-25">${customer.customerName}</td>
				 			<th class="font-th w-25">PHONE</th>
				 			<td class="font-td w-25">${customer.customerPhone}</td>
				 		</tr>
				 		<tr>
				 			<th colspan="1" class="font-th">ADDRESS</th>
				 			<td colspan="3" class="font-td">
				 				<c:if test="${fn:length(addressList) == 0}"> <!-- 리스트에 데이터가 없으면 -->
					 				<select name="addressCode" class="form-control w-50">
					 					<option value="0">주소 선택</option>
					 				</select>
				 				</c:if>
				 				<c:if test="${fn:length(addressList) > 0}"> <!-- 리스트에 데이터가 있으면 -->
					 				<select name="addressCode" id="addressCode" class="form-control w-50">
					 					<option value="0">주소 선택</option>
					 					<c:forEach var="address" items="${addressList}">
					 						<option value="${address.addressCode}">${address.address}</option>
					 					</c:forEach>
					 				</select>
				 				</c:if>
				 			</td>
				 		</tr>
				 		<tr>
				 			<th colspan="1" class="font-th">NEW ADDRESS</th>
			 				<td colspan="3" class="font-td">
			 					<input type="text" name="newAddress" id="newAddress" class="font-td form-control w-50" placeholder="추가할 주소지 작성">
			 				</td>
				 		</tr>
				 	</table>
		 		</div>
		 	</div>
		 	
		 	<br><br>
		 	
		 	<div class="container"> <!-- 주문상품, 포인트 -->
				<div class="row">
				
					<div class="col-md-7"> <!-- 주문상품 -->
						<div class="m-l-25 m-r--38 m-lr-0-xl">
							<div class="wrap-table-shopping-cart">
								<table class="table-shopping-cart" style="text-align : center;">
									<tr class="table_head">
										<th style="text-align : center; width:15%">Image</th>
										<th style="text-align : center; width:25%">GoodsName</th>
										<th style="text-align : center; width:25%">Option</th>
										<th style="text-align : center; width:10%">Quantity</th>
										<th style="text-align : center; width:30%">Total</th>
									</tr>
						 			<tr>
						 				<td><img src="${pageContext.request.contextPath}/upload/${fileName}" width="100" height="100"></td>
							 			<td>${goodsName}</td>
							 			<td>${order.goodsOption}</td>
							 			<td>${order.orderQuantity}</td>
							 			<td>
							 				<div class="p-t-25"><span id="goodsPriceWO">${orderPrice}</span></div>
							 				<div><span id="changePriceMsg" style="color: #6c7ae0; font-size:14px;">(${orderPrice} - 0 = ${orderPrice})</span></div>
							 			</td>
							 		</tr>
							 	</table>
							</div>
						</div>
					</div> <!-- 주문상품 끝 -->

					<div class="col-md-5"> <!-- 포인트 적용 -->
						<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">
							<h4 class="mtext-109 cl2 p-b-30">
								Total Price
							</h4>
	
							<div class="flex-w flex-t bor12 p-b-13">
								<div class="size-450">
									<span class="stext-110 cl2">
										Before Total Price : 
									</span>
								</div>
	
								<div class="size-300">
									<span class="mtext-110 cl2">
										  &nbsp;&nbsp;&nbsp;&nbsp; ${order.orderPrice} ￦
									</span>
								</div>
							</div>
	
							<div class="flex-w flex-t bor12 p-t-45 p-b-30">
								<!-- 포인트 정보 -->
								<div class="size-208 w-full-ssm p-t-10">
									<!-- 사용가능 포인트 -->
									<span class="stext-110 cl2">
										Customer Point : 
									</span>
									
									<br><br><br><br>
									<!-- 사용한 포인트 -->
									<span class="stext-110 cl2">
										UsePotint :  
									</span>
								</div>
								
								<!-- 사용 포인트 입력 -->
								<div class="size-209">	
									<div>
										<div class="p-t-5 p-b-12 m-l-50" style="font-size:15pt">
											<span id="currentPoint" class="mtext-110 cl2">${customer.point}</span><span class="mtext-110 cl2">P</span>
										</div>
										<br><br>
										<div class="bor8 bg0">
											 <input class="stext-111 cl8 plh3 size-111 p-lr-15" type="number" name="point" id="point" placeholder="사용할 포인트 입력">
										</div>
									</div>
								</div>
							</div>
							
							<!-- 총 금액 -->
							<div class="flex-w flex-t p-t-27 p-b-33">
								<div class="size-208">
									<span class="mtext-101 cl2">
										Total : 
									</span>
								</div>
								<div class="size-209 p-t-1 mtext-110 cl2">
									<span class="mtext-110 cl2" id="totalPrice">
										${order.orderPrice}
									</span>
									￦
								</div>
							</div>
							<button type="button" class="flex-c-m stext-101 cl0 size-116 bg3 bor14 hov-btn3 p-lr-15 trans-04 pointer" id="addOrderBtn">주문</button>
						</div>
					</div> <!-- 포인트 적용 끝 -->
				</div> <!-- row 끝 -->
			</div>
		</form>
		
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