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
<title>Insert title here</title>
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
	
	<!-- ?????? -->
	<div class="container">
		<div class="row">
			<!-- ????????? ?????? -->
			<div class="col-md-3 col-lg-3 p-b-80">
				<c:if test="${loginMember.level == 0}"> <!-- ?????????(??????) -->
					<jsp:include page="/inc/MyPageSideMenuForCustomer.jsp"></jsp:include>	
				</c:if>
				
				<c:if test="${loginMember.level == 1}"> <!-- ?????????(??????) -->
					<jsp:include page="/inc/MyPageSideMenuForEmp.jsp"></jsp:include>	
				</c:if>
			</div>
			
			<!-- ???????????? -->
			<div class="col-md-9 col-lg-9 p-b-80 p-t-55">
				<h3 class="mtext-109 cl2 p-b-10">Question</h3>
				<table class="table stext-110 cl2">
					<tr>
						<th class="text-center">????????????</th>
						<td>${question.goodsName}</td>
						<th class="text-center">????????????</th>
						<td>${question.category}</td>
					</tr>
					<tr>
						<th class="text-center">?????????</th>
						<td>${question.customerId}</td>
						<th class="text-center">?????????</th>
						<td>${question.createdate}</td>
					</tr>
					<tr>
						<th class="text-center">?????? ??????</th>
						<td colspan="3">${question.questionTitle}</td>
					</tr>
					<tr>
						<th class="text-center align-middle">?????? ??????</th>
						<td colspan="3">
							<textarea id="questionMemo" name="questionMemo" class="form-control" rows="10" readonly="readonly">${question.questionMemo}</textarea>
						</td>
					</tr>
					
					<c:if test="${loginMember.level == 0}">
						<tr>
							<td colspan="4" class="text-right">
								<a href="${pageContext.request.contextPath}/ModifyQuestion?questionCode=${question.questionCode}">
									<button type="button" id="reviewBtn" class="stext-101 cl6 size-101 bg2 bor1 hov-btn1">?????? ??????</button>
								</a>
							</td>
						</tr>
					</c:if>
				</table>
				
				<br><br>
				
				<c:if test="${loginMember.level == 0}">
					<h3 class="mtext-109 cl2 p-b-10">Comment</h3>
					<table class="table stext-110 cl2">
						<tr>
							<th>??????</th>
							<th>?????????</th>
						</tr>
						
						<c:forEach var="l" items="${list}">
							<tr>
								<th style="width:80%">${l.commentMemo}</th>
								<th style="width:20%">${l.createdate}</th>
							</tr>
						</c:forEach>
					</table>
				</c:if>
				
				<c:if test="${loginMember.level == 1}">
					<h3 class="mtext-109 cl2 p-b-10">Comment</h3>
					<form action="${pageContext.request.contextPath}/AddQuestionComment" method="post">
						<input type="hidden" name="questionCode" value="${question.questionCode}">
						
						<table class="table stext-110 cl2">
							<tr>
								<th style="text-align:center; width:70%">??????</th>
								<th style="text-align:center; width:20%">?????????</th>
								<th style="text-align:center; width:10%">??????</th>
							</tr>
							
							<c:forEach var="l" items="${list}">
								<tr>
									<th style="text-align:center; width:70%">${l.commentMemo}</th>
									<th style="text-align:center; width:20%">${l.createdate}</th>
									<th style="text-align:center; width:10%">
										<a href="${pageContext.request.contextPath}/RemoveQuestionComment?questionCode=${question.questionCode}&commentCode=${l.commentCode}">?????? ??????</a>
									</th>
								</tr>
							</c:forEach>
							
							<tr>
								<th colspan="2"><textarea class="form-control" name="commentMemo" style="width:100%"></textarea></th>
								<th><button type="submit" class="stext-101 cl6 size-101 bg2 bor1 hov-btn1">?????? ??????</button></th>
							</tr>
							
						</table>
					</form>
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