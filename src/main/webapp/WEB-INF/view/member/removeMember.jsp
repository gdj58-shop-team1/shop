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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(document).ready(function() { // 이벤트 : <body>~</body>태그가 로드되고 나면 
		
		// customer 유효성 검사
		$('#customerBtn').click(function() {
				
			
			// customerId 미입력시
			if($('#customerId').val().length < 1) {
				
				alert('아이디를 입력해주세요');
				
				$('#customerId').focus();
				
				return false;
			}
			// customerPw 미입력시
			if($('#customerPw').val().length < 1) {
				
				alert('비밀번호를 입력해주세요');
				
				$('#customerPw').focus();
				
				return false;
			}
			alert('회원탈퇴에 성공했습니다');
			
			
			
		});
		// emp 유효성 검사
		$('#empBtn').click(function() {
				
			
			// empPw 미입력시
			if($('#empId').val().length < 1) {
				
				alert('아이디를 입력해주세요');
				
				$('#empId').focus();
				
				return false;
			}
			// empPw 미입력시
			if($('#empPw').val().length < 1) {
				
				alert('비밀번호를 입력해주세요');
				
				$('#empPw').focus();
				
				return false;
			}
			
			alert('회원탈퇴에 성공했습니다');
			
		});

	});

</script>
<title>My Page</title>
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

			<a href="${pageContext.request.contextPath}/MyPage" class="stext-109 cl8 hov-cl1 trans-04">
				My page
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>
			<span class="stext-109 cl4">
				Remove member
			</span>

		</div>
	</div>		
	

	<div class="container" >
	
		<!-- side menu -->
		
		<div class="row">
			<div class="col-md-3 col-lg-3 p-b-80">
				<c:if test="${loginMember.level == 0}"> <!-- 로그인(회원) -->
					<jsp:include page="/inc/MyPageSideMenuForCustomer.jsp"></jsp:include>	
				</c:if>
				
				<c:if test="${loginMember.level == 1}"> <!-- 로그인(사원) -->
					<jsp:include page="/inc/MyPageSideMenuForEmp.jsp"></jsp:include>	
				</c:if>
			</div>
			
		
			<c:if test="${loginMember.level == 0}"> <!-- 로그인(회원) -->
				<div class="col-md-9 col-lg-9 p-b-80 p-t-55">
					<h3 class="mtext-109 cl2 p-b-10" >회원탈퇴 </h3>
					
					<form action="${pageContext.request.contextPath}/RemoveMember" method="post" id="removeCustomer">
						<table class="table text-center stext-110 cl2">
							<tr>
								<th class="text-center">NAME</th>
								<td align="center">
									<input type ="text" id ="customerName" name="customerName" readonly="readonly" value="${loginMember.customerName}">
								</td>
							</tr>
							<tr>
								<th class="text-center">ID</th>
								<td align="center">
									<input type="text" id="customerId" name="customerId"  placeholder="ID를 입력해주세요">
								</td>
							</tr>

							<tr>
								<th class="text-center">PASSWORD</th>
								<td align="center">
									<input type="password" id="customerPw" name="customerPw"  placeholder="PASSWORD를 입력햊쉐요">
								</td>
							</tr>	
						</table>
						<div class="col-sm-10 col-lg-7 col-xl-5 m-lr-auto m-b-50 p-t-27" >
							<button 
								class="flex-c-m stext-101 cl0 size-116 bg3 bor14 hov-btn3 p-lr-15 trans-04 pointer"
								
								type="submit" id="customerBtn">회원탈퇴
							</button>
						</div>	
					</form>
				</div>
			</c:if>
				
			<c:if test="${loginMember.level == 1}"> <!-- 로그인(사원) -->
				
				<div class="col-md-6 col-lg-6 p-b-80 p-t-55">
					<h3 class="mtext-109 cl2 p-b-10" >회원탈퇴 </h3>
					<form action="${pageContext.request.contextPath}/RemoveMember" method="post" id = "removeEmp">
						<table class="table text-center stext-110 cl2">
							<tr>
								<th class="text-center">NAME</th>
								<td align="center">
									<input type ="text" id ="empName" name="empName" readonly="readonly"  value="${loginMember.empName}">
								</td>
							</tr>
							<tr>
								<th class="text-center">ID</th>
								<td align="center">
									<input type="text" id="empId" name="empId"  placeholder="ID를 입력해주세요">
								</td>
							</tr>
		
							<tr>
								<th class="text-center">PASSWORD</th>
								<td align="center">
									<input type="password" id="empPw" name="empPw"  placeholder="PASSWORD를 입력해주세요" >
								</td>
							</tr>	
						</table>
						
						<div class="col-sm-10 col-lg-7 col-xl-5 m-lr-auto m-b-50 p-t-27" >
							<button 
								class="flex-c-m stext-101 cl0 size-116 bg3 bor14 hov-btn3 p-lr-15 trans-04 pointer"
								
								type="submit" id="empBtn">사원탈퇴
							</button>				
						</div>
					</form>
				</div>

			</c:if>
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