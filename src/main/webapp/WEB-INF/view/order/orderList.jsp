<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
	<title>orderList</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<c:forEach var="o" items="${orderList}">
		<script>
			$(document).ready(function() {
				
				const index = '<c:out value="${o.orderCode}"/>';
				const idWithIndex = '#orderState' + index;
				const idWithIndexForm = '#orderStateForm' + index;
				
				console.log('index '+index);
				console.log('idWithIndex '+idWithIndex);
				console.log('idWithIndexForm '+idWithIndexForm);
				
				if($(idWithIndex).val() == '????????????'){
					$(idWithIndex).attr("disabled",true);
				}
				
				$(idWithIndex).change(function() {
					$(idWithIndexForm).submit();			
				});
				
			});
		</script>
	</c:forEach>
</head>
<body>

	<!-- ?????? ???????????? ?????? ?????? -->
	<c:if test="${loginMember.level == 0}"> <!-- ?????????(??????) -->
		<jsp:include page="/inc/menuForCustomer.jsp"></jsp:include>	
	</c:if>
	<c:if test="${loginMember.level == 1}"> <!-- ?????????(??????) -->
		<jsp:include page="/inc/menuForEmp.jsp"></jsp:include>	
	</c:if>
	
	<!-- ???????????? -->
	<section class="bg-img1 txt-center p-lr-15 p-tb-92" style="background-image: url('images/bg-06.jpg');" >
		<h2 class="ltext-105 cl0 txt-center">
			<!-- text -->
		</h2>
	</section>
	
	<!-- ??????????????? -->
	<div class="container">
		<div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
			<a href="${pageContext.request.contextPath}/Home" class="stext-109 cl8 hov-cl1 trans-04">
				Home
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>

			<span class="stext-109 cl4">
				Orders
			</span>
		</div>
	</div>
	
	<!-- ?????? -->
	<div class="container">
		<div class="row">
			<!-- ????????? ?????? -->
			<div class="col-md-3 col-lg-2 p-b-80">
				<c:if test="${loginMember.level == 0}"> <!-- ?????????(??????) -->
					<jsp:include page="/inc/MyPageSideMenuForCustomer.jsp"></jsp:include>	
				</c:if>
				
				<c:if test="${loginMember.level == 1 && loginMember.authCode != 3}"> <!-- ?????????(??????) -->
					<jsp:include page="/inc/AdminSideMenuForEmp.jsp"></jsp:include>	
				</c:if>
				
				<c:if test="${loginMember.level == 1 && loginMember.authCode == 3}"> <!-- ?????????(??????) -->
					<jsp:include page="/inc/AdminSideMenuForEmp3.jsp"></jsp:include>	
				</c:if>
				
				<jsp:include page="/inc/SideMenuFeaturedProducts.jsp"></jsp:include>
			</div>
			
			<!-- ???????????? -->
			<div class="col-md-9 col-lg-9 p-b-80 p-t-55">
				<h3 class="mtext-109 cl2 p-b-10">Orders</h3>
				
				<c:if test="${loginMember.level == 0}"> <!-- ????????? ??? -->
					<table class="table text-center stext-110 cl2">
						<tr>
							<th class="text-center">No</th>
							<th class="text-center w-25">Product</th>
							<th class="text-center">Price</th>
							<th class="text-center">Option</th>
							<th class="text-center">Quantity</th>
							<th class="text-center">Total</th>
							<th class="text-center">State</th>
							<th class="text-center">QnA</th>
							<th class="text-center">Date</th>
						</tr>
						<c:forEach var="o" items="${orderList}">
							<tr>
								<td class="align-middle">${o.orderCode}</td>
								<td class="align-middle">
									<a href="${pageContext.request.contextPath}/GoodsOne?goodsCode=${o.goodsCode}" class="cl6">${o.goodsName}</a>
								</td>
								<td class="align-middle"><fmt:formatNumber value="${o.goodsPrice}" pattern="#,###"/>???</td>
								<td class="align-middle">${o.goodsOption}</td>
								<td class="align-middle">${o.orderQuantity}</td>
								<td class="align-middle"><fmt:formatNumber value="${o.orderPrice}" pattern="#,###"/>???</td>
								<c:if test="${o.orderState.equals('????????????')}"> <!-- ??????????????? ?????????????????? -->
									<c:if test="${o.reviewMemo != null}"> <!-- ????????? ????????? ????????? -->
										<td class="align-middle">${o.orderState}</td>
									</c:if>
									<c:if test="${o.reviewMemo == null}"> <!-- ????????? ????????? ????????? -->
										<td class="align-middle">
											${o.orderState}<br>
											<a href="${pageContext.request.contextPath}/AddReview?orderCode=${o.orderCode}" class="cl6 bor4 bg2 hov-btn1">
												<span class="p-r-5 p-l-5">????????????</span>
											</a>
										</td>
									</c:if>
								</c:if>
								
								<c:if test="${o.orderState.equals('????????????')}"> <!-- ??????????????? ?????????????????? -->
									<td class="align-middle">
										${o.orderState}<br>
										<a href="${pageContext.request.contextPath}/RemoveOrder?orderCode=${o.orderCode}&goodsPrice=${o.goodsPrice}&orderPrice=${o.orderPrice}&orderQuantity=${o.orderQuantity}" class="cl6 bor4 bg2 hov-btn1">
										<span class="p-r-5 p-l-5">????????????</span>
										</a>
									</td>
								</c:if>
								
								<c:if test="${!o.orderState.equals('????????????') && !o.orderState.equals('????????????')}"> <!-- ??????????????? ???????????????, ????????????, ??????????????? ????????? -->
									
									<c:if test="${o.orderState.equals('????????????')}"> <!-- ??????????????? ?????????????????? -->
										<td style="color:pink;" class="align-middle"><del>${o.orderState}</del></td>
									</c:if>
									<c:if test="${!o.orderState.equals('????????????')}"> <!-- ??????????????? ?????????????????? -->
										<td class="align-middle">${o.orderState}</td>
									</c:if>
								</c:if>
								
								<td class="align-middle">
									<a href="${pageContext.request.contextPath}/AddQuestion?orderCode=${o.orderCode}" class="cl6">
										<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-quora" viewBox="0 0 16 16">
										<path d="M8.73 12.476c-.554-1.091-1.204-2.193-2.473-2.193-.242 0-.484.04-.707.142l-.43-.863c.525-.45 1.373-.808 2.464-.808 1.697 0 2.568.818 3.26 1.86.41-.89.605-2.093.605-3.584 0-3.724-1.165-5.636-3.885-5.636-2.68 0-3.839 1.912-3.839 5.636 0 3.704 1.159 5.596 3.84 5.596.425 0 .811-.046 1.166-.15Zm.665 1.3a7.127 7.127 0 0 1-1.83.244C3.994 14.02.5 11.172.5 7.03.5 2.849 3.995 0 7.564 0c3.63 0 7.09 2.828 7.09 7.03 0 2.337-1.09 4.236-2.675 5.464.512.767 1.04 1.277 1.773 1.277.802 0 1.125-.62 1.179-1.105h1.043c.061.647-.262 3.334-3.178 3.334-1.767 0-2.7-1.024-3.4-2.224Z"/>
										</svg>
									</a>
								</td>
								<td class="align-middle">${o.createdate}</td>
							</tr>
						</c:forEach>
					</table>
				</c:if>
				
				<c:if test="${loginMember.level == 1}"> <!-- ???????????? ??? -->
					<table class="table text-center stext-110 cl2">
						<tr>
							<th class="text-center">No</th>
							<th class="text-center w-25">Product</th>
							<th class="text-center">Price</th>
							<th class="text-center">Quantity</th>
							<th class="text-center">Total</th>
							<th class="text-center">Customer ID</th>
							<th class="text-center">State</th>
							<th class="text-center">Date</th>
						</tr>
						<c:forEach var="o" items="${orderList}">
							<tr>
								<td class="align-middle">${o.orderCode}</td>
								<td class="align-middle">
									<a href="${pageContext.request.contextPath}/GoodsOne?goodsCode=${o.goodsCode}" class="cl6">${o.goodsName}</a>
								</td>
								<td class="align-middle"><fmt:formatNumber value="${o.goodsPrice}" pattern="#,###"/>???</td>
								<td class="align-middle">${o.orderQuantity}</td>
								<td class="align-middle"><fmt:formatNumber value="${o.orderPrice}" pattern="#,###"/>???</td>
								<td class="align-middle">${o.customerId}</td>
								<td class="align-middle"> <!-- select??? ???????????? ???????????? -->
									<form action="${pageContext.request.contextPath}/OrderList?orderCode=${o.orderCode}" method="post" id="orderStateForm${o.orderCode}"> <!-- ?????????????????? ?????? -->					
										<input type="hidden" name="orderCode" value="${o.orderCode}">
										<input type="hidden" name="goodsPrice" value="${o.goodsPrice}">
										<input type="hidden" name="orderPrice" value="${o.orderPrice}">
										<input type="hidden" name="orderQuantity" value="${o.orderQuantity}">
										<input type="hidden" name="customerId" value="${o.customerId}">
										
										<select name="orderState" id="orderState${o.orderCode}" class="form-control">
											<c:if test="${o.orderState.equals('????????????')}">
												<option value="????????????" selected="selected">????????????</option>
												<option value="????????????">????????????</option>
												<option value="????????????">????????????</option>
												<option value="?????????">?????????</option>
												<option value="????????????">????????????</option>
												<option value="????????????">????????????</option>
											</c:if>
											<c:if test="${o.orderState.equals('????????????')}">
												<option value="????????????">????????????</option>
												<option value="????????????" selected="selected">????????????</option>
												<option value="????????????">????????????</option>
												<option value="?????????">?????????</option>
												<option value="????????????">????????????</option>
												<option value="????????????">????????????</option>
											</c:if>
											<c:if test="${o.orderState.equals('????????????')}">
												<option value="????????????">????????????</option>
												<option value="????????????">????????????</option>
												<option value="????????????" selected="selected">????????????</option>
												<option value="?????????">?????????</option>
												<option value="????????????">????????????</option>
												<option value="????????????">????????????</option>
											</c:if>
											<c:if test="${o.orderState.equals('?????????')}">
												<option value="????????????">????????????</option>
												<option value="????????????">????????????</option>
												<option value="????????????">????????????</option>
												<option value="?????????" selected="selected">?????????</option>
												<option value="????????????">????????????</option>
												<option value="????????????">????????????</option>
											</c:if>
											<c:if test="${o.orderState.equals('????????????')}">
												<option value="????????????">????????????</option>
												<option value="????????????">????????????</option>
												<option value="????????????">????????????</option>
												<option value="?????????">?????????</option>
												<option value="????????????" selected="selected">????????????</option>
												<option value="????????????">????????????</option>
											</c:if>
											<c:if test="${o.orderState.equals('????????????')}">
												<option value="????????????">????????????</option>
												<option value="????????????">????????????</option>
												<option value="????????????">????????????</option>
												<option value="?????????">?????????</option>
												<option value="????????????">????????????</option>
												<option value="????????????" selected="selected">????????????</option>
											</c:if>
										</select>
									</form>
								</td>
								<td class="align-middle">${o.createdate}</td>
							</tr>
						</c:forEach>
					</table>
				</c:if>
			</div>
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