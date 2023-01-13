<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>orderComplete</title>
	</head>
	<body>
		<!-- 
			주문완료 페이지
			주문자 정보(이름 주소 번호)
			주문상품 정보(주문번호, 상품이름, 상품 갯수, 결제 금액)
			결제 완료 안내 문구(무통장 입금)
		-->
		 
		<!-- 로그인(회원) -->
		<jsp:include page="/inc/menuForCustomer.jsp"></jsp:include>
		
		<!-- 본문 -->
		<h1>주문완료 페이지</h1>
		<table border="1" style="width:50%;">
 			<tr>
 				<th colspan="5">주문정보</th>
 			</tr>
 			<tr> <!-- 주문자 정보 -->
 				<th colspan="2">주문자 이름</th>
	 			<th>상품금액</th>
	 			<th>주문자 번호</th>
	 			<th>상품옵션</th>
 			</tr>
 			<tr> <!-- 주문상품정보 -->
 				<th colspan="2">상품</th>
	 			<th>상품금액</th>
	 			<th>갯수</th>
	 			<th>상품옵션</th>
 			</tr>
 			<c:forEach var="map" items="${cartList}">
	 			<tr> <!-- c:forEach 사용 -->
	 				<td><img src="${pageContext.request.contextPath}/upload/${map.fileName}" width="100" height="100"></td>
		 			<td>${map.goodsName}</td>
		 			<td>${map.orderPrice}</td>
		 			<td>${map.orderQuantity}</td>
		 			<td>${map.goodsOption}</td>
		 		</tr> <!-- c:forEach 사용 -->
	 		</c:forEach>
	 		<tr>
 				<td colspan="5" id="totalPrice">총 주문금액: ${totalPrice}원</td>
 			</tr>
	 	</table>
		 
		<div>${address}</div>
		 
	</body>
</html>