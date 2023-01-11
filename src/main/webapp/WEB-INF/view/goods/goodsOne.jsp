<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>goodsOne</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(document).ready(function(){
				
				// orderQuantity, cartQuantity, orderPrice 초기값 설정
				var goodsPrice = Number('<c:out value="${goodsMap.get('goodsPrice')}"/>');
				$('#orderQuantity').attr('value', 1);
				$('#cartQuantity').attr('value', 1);
				$('#orderPrice').attr('value', goodsPrice);

				// plusBtn 클릭시
				$('#plusBtn').click(function(){
					$('#orderQuantity').attr('value', Number($('#orderQuantity').val())+Number(1));
					$('#cartQuantity').attr('value', Number($('#cartQuantity').val())+Number(1));
					$('#orderPrice').attr('value', goodsPrice*Number($('#orderQuantity').val()));
				});
				
				// minusBtn 클릭시
				$('#minusBtn').click(function(){
					if(Number($('#orderQuantity').val()) == 1){ // minusBtn 클릭시 orderQuantity 1이면 '-' 못하게
						return;
					} else {
						$('#orderQuantity').attr('value', Number($('#orderQuantity').val())-Number(1));
						$('#cartQuantity').attr('value', Number($('#cartQuantity').val())-Number(1));
						$('#orderPrice').attr('value', goodsPrice*Number($('#orderQuantity').val()));
					}
				});
				
				// 옵션 선택시
				$('#goodsOrderOption').change(function(){
					goodsPrice = Number('<c:out value="${goodsMap.get('goodsPrice')}"/>');
					// 가격 변경
					if($('#goodsOrderOption').val() == '고급포장'){
						goodsPrice = goodsPrice+2500;
						$('#orderPrice').attr('value', goodsPrice*Number($('#orderQuantity').val()));
						// console.log(goodsPrice);
					} else if ($('#goodsOrderOption').val() == '보자기'){
						goodsPrice = goodsPrice+5900;
						$('#orderPrice').attr('value', goodsPrice*Number($('#orderQuantity').val()));
						// console.log(goodsPrice);
					} else if($('#goodsOrderOption').val() == '일반포장'){
						goodsPrice = goodsPrice;
						$('#orderPrice').attr('value', goodsPrice*Number($('#orderQuantity').val()));
					}
						
					// 카트폼의 goodsCartOption 속성(value값) 변경
					$('#goodsCartOption').attr('value', $('#goodsOrderOption').val());
				});
				
				$('#orderBtn').click(function(){
					$('#orderForm').submit();
				});
				
				$('#cartBtn').click(function(){
					$('#cartForm').submit();
				});
			});
		</script>
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
		
		<!-- 본문 : 상품상세보기 -->
		<h1>GOODS ONE</h1>	
		<a href="${pageContext.request.contextPath}/Home">상품목록으로</a>
		<table border="1">
			<tr>
				<td> <!-- 상품 사진 -->
					<div>
						<img src="${pageContext.request.contextPath}/upload/${goodsMap.get('fileName')}" width="400" height="400"> <!-- soldout이면 이미지 흐리게 등 구분할 수 있게 -->
					</div>
				</td>
				<td> <!-- 상품 정보 + 장바구니 추가, 상품 옵션 추가 -->
					<div>
						<h2>${goodsMap.get('goodsName')}</h2>
						<h4>${goodsMap.get('goodsPrice')}원</h4>
						<div>품절여부: ${goodsMap.get('soldout')}</div>
						
						<!-- 주문폼 -->
						<form action="${pageContext.request.contextPath}/AddOrder" method="post" id="orderForm">
							<input type="hidden" name="goodsCode" value="${goodsMap.get('goodsCode')}">
							<input type="hidden" name="goodsName" value="${goodsMap.get('goodsName')}">
							<input type="hidden" name="fileName" value="${goodsMap.get('fileName')}">
							<input type="hidden" name="customerId" value="${customerId}">
							<div> <!-- 상품 갯수 -->
								<span>상품갯수: </span>
								<button type="button" id="minusBtn">-</button>
								<input type="text" name="orderQuantity" id="orderQuantity" readonly="readonly">
								<button type="button" id="plusBtn">+</button>	
							</div>
							<div> <!-- 상품 옵션 -->
								<span>상품옵션: </span>
								<select name="goodsOption" id="goodsOrderOption">
									<option value="일반포장">1) 일반포장(+0원)</option>
									<option value="고급포장">2) 고급포장(+2,500원)</option>
									<option value="보자기">3) 보자기(+5,900원)</option>
								</select>
							</div>
							<div> <!-- 상품 합계 -->
								<span>합계: </span>
								<input type="text" name="orderPrice" id="orderPrice" readonly="readonly">
							</div>
							<button type="button" id="orderBtn">바로 구매</button>
						</form>
						
						<!-- 카트폼 -->
						<form action="${pageContext.request.contextPath}/AddCart" method="post" id="cartForm">
							<input type="hidden" name="goodsCode" value="${goodsMap.get('goodsCode')}">
							<input type="hidden" name="goodsName" value="${goodsMap.get('goodsName')}">
							<input type="hidden" name="fileName" value="${goodsMap.get('fileName')}">
							<input type="hidden" name="cartQuantity" id="cartQuantity">
							<input type="hidden" name="goodsOption" id="goodsCartOption">
							<button type="button" id="cartBtn">장바구니 담기</button>
						</form>
					</div>
				</td>
			</tr>
		</table>
		
		<!-- 상품 리뷰 리스트 -->
		<h2>REVIEW LIST(goodsOne)</h2>
		<c:if test="${fn:length(reviewList) > 0}"> <!-- 작성된 리뷰가 있을 시 -->
			<table>
				<tr>
					<th>작성일</th>
					<th>리뷰내용</th>
					<th>작성자</th>
				</tr>
				<c:forEach var="r" items="${reviewList}">
					<tr>
						<td>${r.createdate}</td>
						<td>${r.reviewMemo}</td>
						<td>${r.customerId}</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
		<c:if test="${fn:length(reviewList) == 0}"> <!-- 작성된 리뷰가 없을 시 -->
			<table>
				<tr>
					<th>작성된 리뷰가 없습니다.</th>
				</tr>
			</table>
		</c:if>
	</body>
</html>