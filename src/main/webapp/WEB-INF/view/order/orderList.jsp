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
					
					if($(idWithIndex).val() == '주문취소'){
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
		<!-- 세션 정보별로 메뉴 분기 -->
		<c:if test="${loginMember.level == 0}"> <!-- 로그인(회원) -->
			<jsp:include page="/inc/menuForCustomer.jsp"></jsp:include>	
		</c:if>
		<c:if test="${loginMember.level == 1}"> <!-- 로그인(사원) -->
			<jsp:include page="/inc/menuForEmp.jsp"></jsp:include>	
		</c:if>
		
		<!-- 본문 -->
		<h1>ORDER LIST</h1>
		<c:if test="${loginMember.level == 0}"> <!-- 회원일 때 -->
			<table>
				<tr>
					<th>주문번호</th>
					<th>주문상품</th>
					<th>상품금액</th>
					<th>상품옵션</th>
					<th>주문수량</th>
					<th>주문금액</th>
					<th>주문상태</th>
					<th>문의</th>
					<th>주문일자</th>
				</tr>
				<c:forEach var="o" items="${orderList}">
					<tr>
						<td>${o.orderCode}</td>
						<td>
							<a href="${pageContext.request.contextPath}/GoodsOne?goodsCode=${o.goodsCode}">${o.goodsName}</a>
						</td>
						<td>${o.goodsPrice}</td>
						<td>${o.goodsOption}</td>
						<td>${o.orderQuantity}</td>
						<td>${o.orderPrice}</td>
						<c:if test="${o.orderState.equals('구매확정')}"> <!-- 주문상태가 구매확정이고 -->
							<c:if test="${o.reviewMemo != null}"> <!-- 작성된 리뷰가 있으면 -->
								<td>${o.orderState}</td>
							</c:if>
							<c:if test="${o.reviewMemo == null}"> <!-- 작성된 리뷰가 없으면 -->
								<td>
									${o.orderState}
									<a href="${pageContext.request.contextPath}/AddReview?orderCode=${o.orderCode}">리뷰작성</a>
								</td>
							</c:if>
						</c:if>
						
						<c:if test="${o.orderState.equals('주문완료')}"> <!-- 주문상태가 주문완료이면 -->
							<td>
								${o.orderState}
								<a href="${pageContext.request.contextPath}/RemoveOrder?orderCode=${o.orderCode}&goodsPrice=${o.goodsPrice}&orderPrice=${o.orderPrice}&orderQuantity=${o.orderQuantity}">주문취소</a>
							</td>
						</c:if>
						
						<c:if test="${!o.orderState.equals('구매확정') && !o.orderState.equals('주문완료')}"> <!-- 주문상태가 구매확정도, 결제완료, 주문완료도 아니면 -->
							<td>${o.orderState}</td>
						</c:if>
						<td>
							<a href="${pageContext.request.contextPath}/AddQuestion?orderCode=${o.orderCode}">문의작성</a>
						</td>
						<td>${o.createdate}</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
		
		<c:if test="${loginMember.level == 1}"> <!-- 관리자일 때 -->
			<table>
				<tr>
					<th>주문번호</th>
					<th>주문상품</th>
					<th>상품금액</th>
					<th>주문수량</th>
					<th>주문금액</th>
					<th>주문회원</th>
					<th>주문상태</th>
					<th>주문일자</th>
				</tr>
				<c:forEach var="o" items="${orderList}">
					<tr>
						<td>${o.orderCode}</td>
						<td>
							<a href="${pageContext.request.contextPath}/GoodsOne?goodsCode=${o.goodsCode}">${o.goodsName}</a>
						</td>
						<td>${o.goodsPrice}</td>
						<td>${o.orderQuantity}</td>
						<td>${o.orderPrice}</td>
						<td>${o.customerId}</td>
						<td> <!-- select로 주문상태 업데이트 -->
							<form action="${pageContext.request.contextPath}/OrderList?orderCode=${o.orderCode}" method="post" id="orderStateForm${o.orderCode}"> <!-- 자바스크립트 적용 -->					
								<input type="hidden" name="orderCode" value="${o.orderCode}">
								<input type="hidden" name="goodsPrice" value="${o.goodsPrice}">
								<input type="hidden" name="orderPrice" value="${o.orderPrice}">
								<input type="hidden" name="orderQuantity" value="${o.orderQuantity}">
								<input type="hidden" name="customerId" value="${o.customerId}">
								
								<select name="orderState" id="orderState${o.orderCode}">
									<c:if test="${o.orderState.equals('주문완료')}">
										<option value="주문완료" selected="selected">주문완료</option>
										<option value="결제완료">결제완료</option>
										<option value="주문취소">주문취소</option>
										<option value="배송중">배송중</option>
										<option value="배송완료">배송완료</option>
										<option value="구매확정">구매확정</option>
									</c:if>
									<c:if test="${o.orderState.equals('결제완료')}">
										<option value="주문완료">주문완료</option>
										<option value="결제완료" selected="selected">결제완료</option>
										<option value="주문취소">주문취소</option>
										<option value="배송중">배송중</option>
										<option value="배송완료">배송완료</option>
										<option value="구매확정">구매확정</option>
									</c:if>
									<c:if test="${o.orderState.equals('주문취소')}">
										<option value="주문완료">주문완료</option>
										<option value="결제완료">결제완료</option>
										<option value="주문취소" selected="selected">주문취소</option>
										<option value="배송중">배송중</option>
										<option value="배송완료">배송완료</option>
										<option value="구매확정">구매확정</option>
									</c:if>
									<c:if test="${o.orderState.equals('배송중')}">
										<option value="주문완료">주문완료</option>
										<option value="결제완료">결제완료</option>
										<option value="주문취소">주문취소</option>
										<option value="배송중" selected="selected">배송중</option>
										<option value="배송완료">배송완료</option>
										<option value="구매확정">구매확정</option>
									</c:if>
									<c:if test="${o.orderState.equals('배송완료')}">
										<option value="주문완료">주문완료</option>
										<option value="결제완료">결제완료</option>
										<option value="주문취소">주문취소</option>
										<option value="배송중">배송중</option>
										<option value="배송완료" selected="selected">배송완료</option>
										<option value="구매확정">구매확정</option>
									</c:if>
									<c:if test="${o.orderState.equals('구매확정')}">
										<option value="주문완료">주문완료</option>
										<option value="결제완료">결제완료</option>
										<option value="주문취소">주문취소</option>
										<option value="배송중">배송중</option>
										<option value="배송완료">배송완료</option>
										<option value="구매확정" selected="selected">구매확정</option>
									</c:if>
								</select>
							</form>
						</td>
						<td>${o.createdate}</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>

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