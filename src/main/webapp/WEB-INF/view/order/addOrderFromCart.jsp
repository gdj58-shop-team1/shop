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
				
				var optionCk = $('select option:selected').val(); // 선택된 옵션의 값
				console.log(optionCk);
				
				$('#addressCode').change(function(){ // 주소 선택 값이 바뀌면
					optionCk = $('select option:selected').val(); // 선택된 옵션의 값을 가져오기
					if(optionCk != 0){ // 주소 선택 값이 있으면
						$('#newAddress').val(''); // 새 주소 입력칸을 비우고
						$("#newAddress").attr("disabled",true); // 비활성화
					} else { // 선택 안하면
						$("#newAddress").attr("disabled",false); // 활성화
					}
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
					$('#addOrderForm').submit();
				});
				
				$('#usePoint').change(function(){
					let orderPoint = "<c:out value='${orderCustomer.point}'/>";
					let usePoint = Number($('#usePoint').val());
					
					if(usePoint < 0) { // 사용하려는 point가 음수 일경우
						$('#orderPoint').text("<c:out value='${orderCustomer.point}'/>");
						$('#usePoint').val(0);
						alert('0 이상의 포인트를 입력해주세요');
						
						return;
					}
					
					if(orderPoint < usePoint) { // 사용하려는 point가 보유 포인트 보다 클 경우
						$('#orderPoint').text(0);
						$('#usePoint').val("<c:out value='${orderCustomer.point}'/>");
						alert('보유 포인트가 모자랍니다.');
						return;
					}

					// 포인트 처리
					console.log('orderPoint : ' + orderPoint);
					console.log('usePoint : ' + usePoint);
					let tempPoint = orderPoint - usePoint;
					$('#orderPoint').text(tempPoint);
					console.log(usePoint);
					console.log($('#orderPoint').val());
					
					// 포인트 사용으로 인해 변경된 가격 처리
					
					// 전체 가격 처리
					let totalPrice = "<c:out value='${totalPrice}'/>";
					$('#totalPrice').text(totalPrice - usePoint);
					
					// 상품별 가격처리
					let orderPriceList = document.querySelectorAll('.orderPrice');
					let orderPriceHiddenList = document.querySelectorAll('.orderPriceHidden');
					let shareUsePointList = document.querySelectorAll('.shareUsePotint');
					let remainderUsePointList = document.querySelectorAll('.remainderUsePoint');
					let pointAfterList = document.querySelectorAll('.pointAfter');
					let pointAfterDetailList = document.querySelectorAll('.pointAfterDetail');
					
					let listLength = orderPriceList.length;
					
					let shareUsePoint = Math.floor(usePoint / listLength);
					let remainderUsePoint = usePoint % listLength;
					console.log(shareUsePoint);
					console.log(remainderUsePoint);
					for(let i = 0; i<listLength; i++) {
						
						let finalOrderPrice = $(orderPriceHiddenList[i]).val();
						let orderPrice = $(orderPriceHiddenList[i]).val();
						
						if(i == 0) {
							orderPrice = orderPrice - shareUsePoint - remainderUsePoint;
							$(orderPriceList[i]).val(orderPrice);
							$(shareUsePointList[i]).val(shareUsePoint + remainderUsePoint);
							$(pointAfterList[i]).text(orderPrice);
							$(pointAfterDetailList[i]).text('(' + finalOrderPrice + ' - ' + (shareUsePoint + remainderUsePoint) + ' = ' + orderPrice + ')');
						} else {
							orderPrice = orderPrice - shareUsePoint;
							$(orderPriceList[i]).val(orderPrice);
							$(shareUsePointList[i]).val(shareUsePoint);
							$(pointAfterList[i]).text(orderPrice);
							$(pointAfterDetailList[i]).text('(' + finalOrderPrice + ' - ' + shareUsePoint + ' = ' + orderPrice + ')');
						}
					}
					
					$('#usePoint').val(usePoint);
					$('#shareUsePoint').val(shareUsePoint);
					$('#remainderUsePoint').val(remainderUsePoint);
					$('#totalPrice').val(totalPrice - usePoint);
					$('#totalPriceSpan').text(totalPrice - usePoint);
					
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

		
		
		<form class="bg0 p-t-50 p-b-85" action="${pageContext.request.contextPath}/AddOrderFromCart" method="post" id="addOrderForm">
			
		<div class="container p-l-40 p-r-57" style="text-align:center">
			<div class="wrap-table-shopping-cart">			
				<table class="table-shopping-cart">
					<tr>
						<th colspan="4" class="font-th">CUSTOMER INFO</th>
					</tr>
					<tr>
						<th class="font-th w-25">NAME</th>
						<td class="font-td w-25">${orderCustomer.customerName}</td>
						<th class="font-th w-25">PHONE</th>
						<td class="font-td w-25">${orderCustomer.customerPhone}</td>
					</tr>
					

					
					<tr>
						<th colspan="1" class="font-th">ADDRESS</th>
						<td colspan="3" class="font-td">
			 				<c:if test="${fn:length(addressList) == 0}"> <!-- 리스트에 데이터가 없으면 -->
				 				<select name="addressCode" class="form-control">
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
			
		<div class="container">
			<div class="row">
				<div class="col-md-7">
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

								<c:forEach var="map" items="${cartList}">
					 				<input type="hidden" name="fileName" value="${map.fileName}">
					 				<input type="hidden" name="goodsCode" value="${map.goodsCode}">
					 				<input type="hidden" name="goodsName" value="${map.goodsName}">	
								 	<input type="hidden" name="goodsOption" value="${map.goodsOption}">
								 	<input type="hidden" name="orderQuantity" value="${map.orderQuantity}">
						 			<tr class=:table_row>
						 				<td><img src="${pageContext.request.contextPath}/upload/${map.fileName}" width="100" height="100"></td>
							 			<td>${map.goodsName}</td>
							 			<td>${map.goodsOption}</td>
							 			<td>${map.orderQuantity}</td>
							 			<td>
							 				<input type="hidden" id="orderPrice" class="orderPrice" name="orderPrice" value="${map.orderPrice}" readonly="readonly">
							 				<input type="hidden" id="orderPriceHidden" class="orderPriceHidden" value="${map.orderPrice}" readonly="readonly">
							 				<div class="p-t-25"><span class="pointAfter">${map.orderPrice}</span></div>
							 				<div><span class="pointAfterDetail" style="color: #6c7ae0; font-size:14px;">(${map.orderPrice} - 0 = ${map.orderPrice})</span></div>
							 			</td>
							 		</tr>
					 			</c:forEach>
							</table>
						 	
						</div>
					</div>
				</div>

				<div class="col-md-5">
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
									  &nbsp;&nbsp;&nbsp;&nbsp; ${totalPrice} ￦
								</span>
							</div>
						</div>

						<div class="flex-w flex-t bor12 p-t-45 p-b-30">
							<div class="size-208 w-full-ssm p-t-10">
								<span class="stext-110 cl2">
									Customer Point : 
								</span>
								
								<br><br><br><br>
								
								<span class="stext-110 cl2">
									UsePotint :  
								</span>

							</div>

							<div class="size-209">	
								<div>
									<div class="p-t-5 p-b-12 m-l-50" style="font-size:15pt">
										<span id="orderPoint" class="mtext-110 cl2">${orderCustomer.point}</span><span class="mtext-110 cl2">P</span>
									</div>
									<br><br>
									<div class="bor8 bg0">
										 <input class="stext-111 cl8 plh3 size-111 p-lr-15" type="number" name="usePoint" id="usePoint" placeholder="사용할 포인트 입력">
									</div>
								</div>
							</div>
						</div>

						<div class="flex-w flex-t p-t-27 p-b-33">
							<div class="size-208">
								<span class="mtext-101 cl2">
									Total : 
								</span>
							</div>

							<div class="size-209 p-t-1 mtext-110 cl2">
								<span class="mtext-110 cl2" id="totalPriceSpan">
									${totalPrice}
								</span>
								￦
							</div>
						</div>

						<button type="button" class="flex-c-m stext-101 cl0 size-116 bg3 bor14 hov-btn3 p-lr-15 trans-04 pointer" id="addOrderBtn">
							주문하기
						</button>
					</div>
				</div>
			</div>
		</div>
			
		<input type="hidden" name="usePoint" id="usePoint" value="0">
		<input type="hidden" name="shareUsePoint" id="shareUsePoint" value="0">
	 	<input type="hidden" name="remainderUsePoint" id="remainderUsePoint" value="0">
	 	<input type="hidden" name="totalPrice" id="totalPrice" class="totalPrice" value="${totalPrice}">
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