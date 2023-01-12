<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script language=javascript>
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
				<input type="text" id="GoodsCode" name="goodsCode" value="${map.goodsCode}" hidden="hidden">
				<input type="text" id="goodsOptionPrice" name="goodsOptionPrice" value="${map.goodsOptionPrice}" hidden="hidden">
				<input type="text" id="goodsPrice" name="goodsPrice" value="${map.goodsPrice}" hidden="hidden">
				<input type="text" id="fileName" name="fileName" value="${map.fileName}" hidden="hidden">
				<tr>					
					<td><img src="${pageContext.request.contextPath}/upload/${map.fileName}" id="fileName" name="fileName" width="100" height="100"></td>

					<td><input type="text" id="goodsName" name="goodsName" value="${map.goodsName}"></td>

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
</body>
</html>