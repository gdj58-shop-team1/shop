<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
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
	
	<h1>고객 로그인</h1>
	<form action="${pageContext.request.contextPath}/Login" method="post" id = "cartListForm">
		<table border="1">
			<thead>
				<tr>
					<th>상품이미지</th>
					<th>상품명</th>
					<th>상품 옵션</th>
					<th>수량</th>
					<th>가격</th>
				</tr>
			</thead>
			<c:forEach var="map" items="${cartList}" varStatus="vs" begin=0 end="${cartList.size}" step=1>
				<input type="text" id="${cartList}GoodsCode" name="goodsCode" value="${map.goodsCode}" hidden="hidden">
				
				<tr>					
					<td><img src="${pageContext.request.contextPath}/upload/${map.fileName}" width="250" height="250"></td>

					<td><input type="text" id="goodsName${vs}" name="goodsName" value="${map.goodsName}"></td>

					<td><input type="text" id="goodsOption${vs}" name="goodsOption" value="${map.goodsOption}"></td>

					<td><input type="text" id="cartQuantity${vs}" name="cartQuantity" value="${map.cartQuantity}"></td>

					<td>${(map.goodsOption + map.goodsPrice) * map.cartQuantity}</td>
				</tr>
					
			</c:forEach>
		</table>
	</form>
</body>
</html>