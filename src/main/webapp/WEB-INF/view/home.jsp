<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>home</title>
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
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<c:if test="${loginMember.level == 1}">
	<script>
		$(document).ready(function(){
			let level = "<c:out value='${loginMember.level}'/>";
			let active = "<c:out value='${loginMember.active}'/>";
			
			if(level == 1 && active === 'N') {
				alert("??????????????? ??????????????????. ???????????? ??????????????????.");
				let logout = "<c:out value='${pageContext.request.contextPath}/Logout'/>";
				location.replace(logout);
			}
		});
	</script>
</c:if>
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

	<!-- ?????? -->
	<div class="bg0 m-t-23 p-b-140">
		<div class="container">
			<!-- ?????? ??????, ?????? ??? -->
			<div class="flex-w flex-sb-m p-b-52">
				<!-- ?????? -->
				<div class="flex-w flex-l-m filter-tope-group m-tb-10">
					<a href="${pageContext.request.contextPath}/Home?sort=g.goods_Name ASC&category=${category}&searchWord=${searchWord}" class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5">?????????</a>
					
					<a href="${pageContext.request.contextPath}/Home?sort=g.createdate DESC&category=${category}&searchWord=${searchWord}" class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5">?????????</a>
					
					<a href="${pageContext.request.contextPath}/Home?sort=g.hit DESC&category=${category}&searchWord=${searchWord}" class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5">?????????</a>
					
					<a href="${pageContext.request.contextPath}/Home?sort=g.goods_Price DESC&category=${category}&searchWord=${searchWord}" class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5">?????? ?????????</a>
					
					<a href="${pageContext.request.contextPath}/Home?sort=g.goods_Price ASC&category=${category}&searchWord=${searchWord}" class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5">?????? ?????????</a>
				</div>

				<!-- ?????? ??? -->
				<div class="flex-w flex-c-m m-tb-10">
					<form action="${pageContext.request.contextPath}/Home" method="get">
						<input type="hidden" name="category" value="${category}">
						<div class="stext-107 cl6 size-107 m-tb-4">
							<div class="flex-w flex-sb-m p-b-52">
								<c:if test="${searchWord == null}"> <!-- ???????????? ?????? ???????????? ????????? ?????? input -->
									<input type="text" name="searchWord" class="stext-107 cl2 size-107 bor4" placeholder="????????? ??????">
								</c:if>
								<c:if test="${searchWord != null}"> <!-- ???????????? ?????? ???????????? ????????? input??? value??? ?????? -->
									<input type="text" name="searchWord" class="stext-107 cl2 size-107 bor4" value="${searchWord}">
								</c:if>
								<button type="submit" class="pointer hov-btn1 p-r-15 p-l-15 p-tb-6 bg2 bor4">??????</button>
							</div>
						</div>
					</form>
				</div>
			</div>
			<!-- ?????? ??????, ?????? ??? ??? -->
		
			<!-- ?????? ?????? -->
			<div class="row isotope-grid">
				<c:forEach var="g" items="${goodsList}" varStatus="s">
					<div class="col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item">
						<div class="block2">
							<!-- ?????? ????????? -->
							<div class="block2-pic hov-img0">
								<a href="${pageContext.request.contextPath}/GoodsOne?goodsCode=${g.goodsCode}">
									<img src="${pageContext.request.contextPath}/upload/${g.fileName}">
								</a>
							</div>
							
							<!-- ????????????, ?????? -->
							<div class="block2-txt flex-w flex-t p-t-14">
								<div class="block2-txt-child1 flex-col-l ">
									<a href="${pageContext.request.contextPath}/GoodsOne?goodsCode=${g.goodsCode}" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
										${g.goodsName}
									</a>
									<span class="stext-105 cl3">
										${g.goodsPrice}???
									</span>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>

			<!-- ????????? -->
			<div class="flex-c-m flex-w w-full p-t-45">
				<!-- ??????, ????????? ????????? -->
				<c:if test="${searchWord == null && sort == null}">
					<!-- currentPage??? 1?????? ?????? ?????? ??????O, 1?????? ????????? -->
					<c:if test="${currentPage > 1}">
						<span><a href="${pageContext.request.contextPath}/Home?currentPage=${currentPage-1}" class="stext-101 cl5 p-r-15 p-l-15 p-tb-6 hov-btn1">prev</a></span>
					</c:if>
					<c:if test="${currentPage == 1}">
						<span class="stext-101 cl6 p-r-15 p-l-15 p-tb-6">prev</span>
					</c:if>
					
					<span class="stext-101 cl6 p-r-15 p-l-15 p-tb-6">${currentPage}</span>
					
					<!-- endPage??? ?????? currentPage?????? ?????? ??????O, ????????? ????????? -->
					<c:if test="${currentPage < endPage}">
						<span><a href="${pageContext.request.contextPath}/Home?currentPage=${currentPage+1}" class="stext-101 cl5 p-r-15 p-l-15 p-tb-6 hov-btn1">next</a></span>
					</c:if>
					<c:if test="${currentPage == endPage}">
						<span class="stext-101 cl6 p-r-15 p-l-15 p-tb-6">next</span>
					</c:if>
				</c:if>
				
				<!-- ????????? ????????? -->
				<c:if test="${searchWord != null && !searchWord.equals('')}">
					<c:if test="${currentPage > 1}">
						<span><a href="${pageContext.request.contextPath}/Home?currentPage=${currentPage-1}&category=${category}&searchWord=${searchWord}&sort=${sort}" class="stext-101 cl5 p-r-15 p-l-15 p-tb-6 hov-btn1">prev</a></span>
					</c:if>
					<c:if test="${currentPage == 1}">
						<span class="stext-101 cl6 p-r-15 p-l-15 p-tb-6">prev</span>
					</c:if>
					
					<span class="stext-101 cl6 p-r-15 p-l-15 p-tb-6">${currentPage}</span>
									
					<c:if test="${currentPage < endPage}">
						<span><a href="${pageContext.request.contextPath}/Home?currentPage=${currentPage+1}&category=${category}&searchWord=${searchWord}&sort=${sort}" class="stext-101 cl5 p-r-15 p-l-15 p-tb-6 hov-btn1">next</a></span>
					</c:if>
					<c:if test="${currentPage == endPage}">
						<span class="stext-101 cl6 p-r-15 p-l-15 p-tb-6">next</span>
					</c:if>
				</c:if>
				
				<!-- ????????? ????????? -->
				<c:if test="${sort != null}">
					<c:if test="${currentPage > 1}">
						<span><a href="${pageContext.request.contextPath}/Home?currentPage=${currentPage-1}&category=${category}&searchWord=${searchWord}&sort=${sort}" class="stext-101 cl5 p-r-15 p-l-15 p-tb-6 hov-btn1">prev</a></span>
					</c:if>
					<c:if test="${currentPage == 1}">
						<span class="stext-101 cl6 p-r-15 p-l-15 p-tb-6">prev</span>
					</c:if>
					
					<span class="stext-101 cl5 p-r-15 p-l-15 p-tb-6">${currentPage}</span>
									
					<c:if test="${currentPage < endPage}">
						<span><a href="${pageContext.request.contextPath}/Home?currentPage=${currentPage+1}&category=${category}&searchWord=${searchWord}&sort=${sort}" class="stext-101 cl5 p-r-15 p-l-15 p-tb-6 hov-btn1">next</a></span>
					</c:if>
					<c:if test="${currentPage == endPage}">
						<span class="stext-101 cl6 p-r-15 p-l-15 p-tb-6">next</span>
					</c:if>
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