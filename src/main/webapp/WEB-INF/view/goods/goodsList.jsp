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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/loginCss/assets/css/tailwind.output.css" />
<!--===============================================================================================-->
<meta charset="EUC-KR">
<title>Insert title here</title>
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
		
		<!-- 상단배너 -->
		<section class="bg-img1 txt-center p-lr-15 p-tb-92" style="background-image: url('images/bg-06.jpg');" >
			<h2 class="ltext-105 cl0 txt-center">
				<!-- text -->
			</h2>
		</section>
		
		<!-- 페이지위치 -->
		<div class="container">
			<div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
				<a href="${pageContext.request.contextPath}/Home" class="stext-109 cl8 hov-cl1 trans-04">
					Home
					<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
				</a>
	
				<a href="${pageContext.request.contextPath}/" class="stext-109 cl8 hov-cl1 trans-04">
					Admin
					<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
				</a>
				<span class="stext-109 cl4">
					Goods list
				</span>
			</div>
		</div>

		<!-- 본문 -->
		<div class="container" >
			<div class="row">
				<!-- 사이드 메뉴 -->
				<div class="col-md-3 col-lg-2 p-b-80">
					<c:if test="${loginMember.level == 0}"> <!-- 로그인(회원) -->
						<jsp:include page="/inc/MyPageSideMenuForCustomer.jsp"></jsp:include>	
					</c:if>
					
					<c:if test="${loginMember.level == 1 && loginMember.authCode != 3}"> <!-- 로그인(사원) -->
						<jsp:include page="/inc/AdminSideMenuForEmp.jsp"></jsp:include>	
					</c:if>
					
					<c:if test="${loginMember.level == 1 && loginMember.authCode == 3}"> <!-- 로그인(사원) -->
						<jsp:include page="/inc/AdminSideMenuForEmp3.jsp"></jsp:include>	
					</c:if>
					
					<jsp:include page="/inc/SideMenuFeaturedProducts.jsp"></jsp:include>
				</div>
				
				<!-- 상품목록 -->
				<div class="col-md-9 col-lg-9 p-b-80 p-t-55">
					<h3 class="mtext-109 cl2 p-b-10">Goods</h3>
					<table class="table-shopping-cart">
						<thead>
							<tr class="table_head">								
								<th class="column-1">GoodsName</th> <!-- 왼쪽정렬 -->
								<th class="column-1">GoodsName</th>
								<th class="column-1">Price</th>
								<th class="column-1">category</th>
								<th class="column-1">soldout</th>
								<th class="column-1">Admin</th>
								<th class="column-5">action</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="g" items="${goodsList}">
								<tr class="table_row">
															
									<td class="column-1">
										<div >
											<img src="${pageContext.request.contextPath}/upload/${g.fileName}" width="200px" height="200px" alt="상품 이미지"/>
										</div>
									</td >
									<td class="column-1">${g.goodsName}</td>
									<td class=column-1>${g.goodsPrice}원</td>
									<td class="column-1">${g.goodsCategory}</td>
									<td class="column-1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${g.soldout}</td>
									
									<td class="column-1">${g.empId}</td>
							
									<td class="column-1">
										<div class="flex items-center space-x-3 text-sm">
											
											<!--수정  -->
											<button
											class="flex items-center justify-between px-2 py-2 text-sm font-medium leading-5 text-purple-600 rounded-lg dark:text-gray-400 focus:outline-none focus:shadow-outline-gray"
											aria-label="Edit"
											onclick = "location.href='${pageContext.request.contextPath}/ModifyGoods?goodsCode=${g.goodsCode}&fileName=${g.fileName}'"
											>
												<svg
												class="w-5 h-5"
												aria-hidden="true"
												fill="currentColor"
												viewBox="0 0 20 20"
												>
													<path
													d="M13.586 3.586a2 2 0 112.828 2.828l-.793.793-2.828-2.828.793-.793zM11.379 5.793L3 14.172V17h2.828l8.38-8.379-2.83-2.828z"
													></path>
												</svg>
											</button>
											<!-- 삭제버튼 -->
											<button
												class="flex items-center justify-between px-2 py-2 text-sm font-medium leading-5 text-purple-600 rounded-lg dark:text-gray-400 focus:outline-none focus:shadow-outline-gray"
												aria-label="Delete"
												
												onclick = "location.href='${pageContext.request.contextPath}/DeleteGoods?goodsCode=${g.goodsCode}&fileName=${g.fileName}'"
												>
												<svg
												class="w-5 h-5"
												aria-hidden="true"
												fill="currentColor"
												viewBox="0 0 20 20"
												>
													<path
													fill-rule="evenodd"
													d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z"
													clip-rule="evenodd"
													></path>
												</svg>
											</button>
										</div>						
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

					
					<!--  페이지 -->
					<div class="flex-w flex-sb-m p-t-18">
						<span class="flex-w flex-m stext-200 cl2 p-r-30 m-tb-10">
							<c:if test="${currentPage > 1}">
								<span class="cl4">
									<a href="${pageContext.request.contextPath}/GoodsList?currentPage=${currentPage-1}">이전</a>
								</span>
							</c:if>
							<c:if test="${currentPage == 1}">
								<span class="cl8">이전</span>
							</c:if>
								<a href="#" class="flex-c-m how-pagination1 trans-04 m-all-7 active-pagination1">
									${currentPage}
								</a>
							<c:if test="${currentPage < endPage}">
								<span><a href="${pageContext.request.contextPath}/GoodsList?currentPage=${currentPage+1}">다음</a></span>
							</c:if>
							<c:if test="${currentPage == endPage}">
								<span class="cl8">다음</span>
							</c:if>
						</span>
						<a href ="${pageContext.request.contextPath}/AddGoods" class="stext-101 cl2 hov-cl1 trans-04 m-tb-10">
							Add goods
							<i class="fa fa-long-arrow-right m-l-9"></i>
						</a>
					</div>
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