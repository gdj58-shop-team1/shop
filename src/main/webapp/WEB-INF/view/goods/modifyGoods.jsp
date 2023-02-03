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
<!-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/loginCss/assets/css/tailwind.output.css" />  -->
<!--===============================================================================================-->




<meta charset="EUC-KR">
<title>Insert title here</title>
 <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
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
		
		<div class="container"  >
			<div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
				<a href="${pageContext.request.contextPath}/Home" class="stext-109 cl8 hov-cl1 trans-04">
					Home
					<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
				</a>
	
				<a href="${pageContext.request.contextPath}/" class="stext-109 cl8 hov-cl1 trans-04">
					Admin
					<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
				</a>
				<a href="${pageContext.request.contextPath}/GoodsList" class="stext-109 cl8 hov-cl1 trans-04">
					Goods list
					<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
				</a>
	
				<span class="stext-109 cl4">
					Update goods
				</span>
			</div>
		</div>

		
		<div class="container"  >	
			<div class="row">
			
				<!-- side menu -->
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
					
					<jsp:include page="/inc/SideMenuFeaturedProducts.jsp"></jsp:include> <!-- 추천메뉴 -->
				</div>
				
				

				
				
				<!-- table -->
				<div class="col-md-9 col-lg-9 p-b-80 p-t-55">
					<h3 class="mtext-109 cl2 p-b-10">Update goods</h3>
					<form action="${pageContext.request.contextPath}/ModifyGoods" method="post">
					<input type="hidden" name="goodsCode" value="${goods.goodsCode}">
					
					
						<table class="table stext-110 cl2">
							<tr  class="table_head">
								<th class="text-center">상품코드</th>
								<td class="column-1">${goods.goodsCode}</td>
							</tr>
							
							<tr class="table_head">
								<th class="text-center">상품명</th>
								<td class="text-center align-middle">
									<div class="bor13 of-hidden pos-relative col-lg-6" >
										<input class="stext-103 cl2 plh3 size-105 p-l-10 p-r-25 "  
											type="text" name="goodsName" id = "goodsName" placeholder="Goods name" value="${goods.goodsName}" class="form-control">
									</div>
								</td>
							</tr>
							<tr class="table_head">
								<th class="text-center">판매가격</th>
								<td class="text-center align-middle" >
									<div class="bor13 of-hidden pos-relative col-lg-6" >
										<input class="stext-103 cl2 plh3 size-105 p-l-10 p-r-25 " 
											type="text" name="goodsPrice" id = "goodsPrice"  placeholder="Goods price"  value ="${goods.goodsPrice}" class="form-control">
									</div>
								</td>
							</tr>
							<tr class="">
								<th class="text-center">솔드아웃</th>
								<td class="text-left align-middle">
									<c:if test="${goods.soldout eq 'Y'}">
										<input  type="radio" name="soldout"  value="Y" checked="checked">
										<label for="soldout">판매중</label> 
										<input type="radio" name="soldout"  value="N">
										<label for="soldout">sold out</label> 
									</c:if>
									<c:if test="${goods.soldout eq 'N'}">
										<input type="radio" name="soldout" value="Y">
										<label for="soldout">판매중</label>
										<input type="radio" name="soldout" value="N" checked="checked">
										<label for="soldout">sold out</label>
									</c:if>
								</td>
							</tr>
							<tr class="table_head">
								<th class="text-center">카테고리</th>
								<td class="align-middle">
									<select name = "goodsCategory" id = "goodsCategory" class="">
										<c:if test="${goods.goodsCategory eq '육류'}">
											<option value='육류' selected="selected">육류</option>
											<option value='육가공류'>육가공류</option>
											<option value='과일'>과일</option>
											<option value='기름'>기름</option>
											<option value='건강식품'>건강식품</option>
										</c:if>
										<c:if test="${goods.goodsCategory eq '육가공류'}">
											<option value='육류' >육류</option>
											<option value='육가공류' selected="selected">육가공류</option>
											<option value='과일'>과일</option>
											<option value='기름'>기름</option>
											<option value='건강식품'>건강식품</option>
										</c:if>
										<c:if test="${goods.goodsCategory eq '과일'}">
											<option value='육류' >육류</option>
											<option value='육가공류' >육가공류</option>
											<option value='과일' selected="selected">과일</option>
											<option value='기름'>기름</option>
											<option value='건강식품'>건강식품</option>
										</c:if>
										<c:if test="${goods.goodsCategory eq '기름'}">
											<option value='육류' >육류</option>
											<option value='육가공류' >육가공류</option>
											<option value='과일' >과일</option>
											<option value='기름' selected="selected">기름</option>
											<option value='건강식품'>건강식품</option>
										</c:if>
										<c:if test="${goods.goodsCategory eq '건강식품'}">
											<option value='육류' >육류</option>
											<option value='육가공류' >육가공류</option>
											<option value='과일' >과일</option>
											<option value='기름' >기름</option>
											<option value='건강식품' selected="selected">건강식품</option>
										</c:if>
									</select>
								</td>
							</tr>
							<tr class="table_head">
								<th class="text-center">상품사진</th>
								<td class="">
									<div  id="image_preview" >
										<label for = "image">
			                        	 	<img src="${pageContext.request.contextPath}/upload/${goods.fileName}" width="300" height="300">	
				                     	</label>
			                     	</div>
	                            </td>
							</tr>
							<tr class="table_head">
								<th class="text-center">관리자</th>
								<td class="text-center align-middle"><input type="text" name="empId" id = "empId" value="${loginMember.empId}" readonly="readonly"></td>
							</tr>
						</table>
						<div class="col-sm-10 col-lg-7 col-xl-3 m-lr-auto m-b-50 p-t-27" style="float:right">
						<button 
							class="flex-c-m stext-101 cl0 size-116 bg3 bor14 hov-btn3 p-lr-15 trans-04 pointer"
							type="submit">상품수정</button>
						</div>
					</form>
					
					
				
				 			
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
	
<!--===============================================================================================-->	

<!--===============================================================================================-->	
	<!-- 숫자 자동 ,되는 스크립트 -->
	<!--  
	<script>
		 function inputNumberFormat(obj) {
		     obj.value = comma(uncomma(obj.value));
		 }
	
		 function comma(str) {
		     str = String(str);
		     return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
		 }
	
		 function uncomma(str) {
		     str = String(str);
		     return str.replace(/[^\d]+/g, '');
		 }
	
	
	
	
	</script>
	-->
</body>
</html>