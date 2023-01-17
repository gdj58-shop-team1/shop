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
					$('#changePriceMsg').text(orderPrice+' - '+Number($('#point').val())+' = '+ $('#orderPrice').val());
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

		<h1>Add Order Direct</h1>
		<form action="${pageContext.request.contextPath}/AddOrderDirect" method="post" id="addOrderForm">
			<input type="hidden" name="goodsCode" value="${goodsCode}">
		 	<input type="hidden" name="orderPrice" id="orderPrice" value="${order.orderPrice}">
		 	
		 	<!-- 상품코드, (상품가격), 아이디, 옵션, 주소코드, 주문수량, 총가격 -->
		 	<table border="1" style="width:50%;"> <!-- 주문고객정보 -->
	 			<tr>
	 				<th colspan="4">주문회원 정보</th>
	 			</tr>
		 		<tr>
		 			<td>이름</td>
		 			<td>${customer.customerName}</td>
		 			<td>전화번호</td>
		 			<td>${customer.customerPhone}</td>
		 		</tr>
		 		<tr>
		 			<td colspan="1">주소</td>
		 			<td colspan="3">
		 				<c:if test="${fn:length(addressList) == 0}"> <!-- 리스트에 데이터가 없으면 -->
			 				<select name="addressCode">
			 					<option value="0">====주소 선택====</option>
			 				</select>
		 				</c:if>
		 				<c:if test="${fn:length(addressList) > 0}"> <!-- 리스트에 데이터가 있으면 -->
			 				<select name="addressCode" id="addressCode">
			 					<option value="0">====주소 선택====</option>
			 					<c:forEach var="address" items="${addressList}">
			 						<option value="${address.addressCode}">${address.address}</option>
			 					</c:forEach>
			 				</select>
		 				</c:if>
		 			</td>
		 		</tr>
		 		<tr>
		 			<td colspan="1">
	 					새 주소 추가
	 				</td>
	 				<td colspan="3">
	 					<input type="text" name="newAddress" id="newAddress" placeholder="추가할 주소지 작성">
	 				</td>
		 		</tr>
		 		<tr>
		 			<td colspan="4">사용가능 포인트: <span id="currentPoint">${customer.point}</span>P</td>
		 		</tr>
		 	</table>
		 	<br>
		 	<table border="1" style="width:50%;"> <!-- 주문상품정보 -->
	 			<tr>
	 				<th colspan="5">주문상품</th>
	 			</tr>
	 			<tr>
	 				<th colspan="2">상품</th>
		 			<th>상품금액</th>
		 			<th>갯수</th>
		 			<th>상품옵션</th>
	 			</tr>
	 			<tr>
	 				<td>
	 					<img src="${pageContext.request.contextPath}/upload/${fileName}" width="100" height="100">
	 				</td>
		 			<td>${goodsName}</td>
		 			<td>
		 				<div><span id="goodsPriceWO">${orderPrice}</span></div>
		 				<div><span id="changePriceMsg" style="color:blue;">${orderPrice} - 0 = ${orderPrice}</span></div>
		 			</td>
		 			<td>${order.orderQuantity}</td>
		 			<td>${order.goodsOption}</td>
		 		</tr>
		 		<tr>
		 			<td colspan="1">사용할 포인트</td>
		 			<td colspan="2">
		 				<input type="number" name="point" id="point" max="${customer.point}" placeholder="사용할 포인트 입력">P
		 			</td>
	 				<td colspan="2">총 주문금액: <span id="totalPrice">${order.orderPrice}</span>원</td> <!-- 자바스크립트로 수정 -->
	 			</tr>
		 	</table>

			<button type="button" id="addOrderBtn">주문</button>
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