<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	<title>noticeOne</title>
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
	
	<!-- 본문 -->
	<div class="container">
		<div class="row">
			<!-- 공지 -->
			<div class="col-md-10 col-lg-10 p-b-80 p-t-55 mx-auto">
				<h3 class="mtext-109 cl2 p-b-10">Notice</h3>	
				<table class="table stext-110 cl2">
					<tr>
						<th class="text-center" colspan="1">공지번호</th>
						<td colspan="3">${notice.noticeCode}</td>
					</tr>
					<tr>
						<th class="text-center" colspan="1">제목</th>
						<td colspan="3" class="w-50">${notice.noticeTitle}</td>
					</tr>
					<tr>
						<th colspan="1" class="text-center align-middle" style="height:300px;">내용</th>
						<td colspan="3">${notice.noticeContent}</td>
					</tr>
					<tr>
						<th class="text-center w-25">작성자</th>
						<td class="w-25">${notice.empId}</td>
						<th class="text-center w-25">작성일</th>
						<td class="w-25">${notice.createdate}</td>
					</tr>
					<c:if test="${loginMember.level == 1}"> <!-- 레벨이 1 이고 -->
						<c:if test="${loginMember.authCode >= 2 && (notice.empId == loginMember.empId)}"> <!-- 사원레벨이 2 이상이고, 작성자와 세션 정보가 일치할 때 -->
							<tr>
								<td class="text-left align-middle">
									<a href="${pageContext.request.contextPath}/NoticeList" class="cl6">Back</a>
								</td>
								<td class="w-75"></td>
								<td>
									<button type="button" onclick="location.href='${pageContext.request.contextPath}/ModifyNotice?noticeCode=${notice.noticeCode}'" class="stext-101 cl6 size-101 bg2 bor1 hov-btn1">수정</button>
								</td>
								<td>
									<button type="button" onclick="location.href='<!-- 그 외의 조건들 -->?noticeCode=${notice.noticeCode}'" class="stext-101 cl6 size-101 bg2 bor1 hov-btn1">삭제</button>
								</td>
							</tr>
						</c:if>
						<!-- 그 외의 조건들 -->
						<c:if test="${notice.empId != loginMember.empId}">
							<tr>
								<td colspan="4" class="text-left align-middle">
									<a href="${pageContext.request.contextPath}/NoticeList" class="cl6">Back</a>
								</td>
							</tr>
						</c:if>
					</c:if>
					<c:if test="${loginMember.level == 0}"> 
						<tr>
							<td colspan="4" class="text-left align-middle">
								<a href="${pageContext.request.contextPath}/NoticeList" class="cl6">Back</a>
							</td>
						</tr>
					</c:if>
				</table>
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