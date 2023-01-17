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
		
		let numberList = document.querySelectorAll('.orderQuantity');
		let numberListLength = numberList.length;
		
		console.log(numberList);
		for(let i = 0; i<numberListLength; i++) {
			$(numberList[i]).change(function(){
			    $("#cartListForm").attr("action", "${pageContext.request.contextPath}/CartList");
			    $('#cartListForm').submit();   
			});
		}
		
		$('.orderBtn').click(function(){
			$("#cartListForm").attr("action", "${pageContext.request.contextPath}/CartList");
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
	
	<br><br><br>
	<div class="container">
		<h1>장바구니</h1>
		<form method="post" id = "cartListForm">
			<table border="1">
				<thead>
					<tr>
						<th>상품이미지</th>
						<th>상품명</th>
						<th>상품 옵션</th>
						<th>수량</th>
						<th>가격</th>
						<th>삭제</th>
					</tr>
				</thead>
				<c:forEach var="map" items="${cartList}">
					<input type="hidden" id="GoodsCode" name="goodsCode" value="${map.goodsCode}">
					<input type="hidden" id="goodsName" name="goodsName" value="${map.goodsName}">
					<input type="hidden" id="goodsOptionPrice" name="goodsOptionPrice" value="${map.goodsOptionPrice}">
					<input type="hidden" id="goodsPrice" name="goodsPrice" value="${map.goodsPrice}">
					<input type="hidden" id="fileName" name="fileName" value="${map.fileName}">
					<tr>					
						<td><img src="${pageContext.request.contextPath}/upload/${map.fileName}" id="fileName" name="fileName" width="100" height="100"></td>
	
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
							<input type="number" name="orderQuantity" id="orderQuantity" class="orderQuantity" value="${map.orderQuantity}" min="1">
						</td>
	
						<td>${map.orderPrice}</td>
						<td><a href="${pageContext.request.contextPath}/RemoveCartOne?goodsCode=${map.goodsCode}&goodsOption=${map.goodsOption}">삭제</a></td>
					</tr>
						
				</c:forEach>
			</table>
			<div><a href="${pageContext.request.contextPath}/RemoveCartAll">장바구니 비우기</a></div>
			<div><a href="${pageContext.request.contextPath}/GetOrderInfoFromCart">주문하기</a></div>
		</form>
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