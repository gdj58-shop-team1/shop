<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>addOrderDirect</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(document).ready(function(){
				$('#addOrderBtn').click(function(){
					$('#addOrderForm').submit();
				});
			});
		</script>
	</head>
	<body>
		<!-- 
			주문 페이지 ->(이 시점에 DB orders 테이블로 넘어감) 주문완료
			사용자 정보(사용자 포인트 readonly, 이름readonly, 번호readonly, 주소)
			주문 상품 정보(상품 코드, 상품 이름readonly, 상품 갯수readonly, 총 주문 금액readonly - 사용자 포인트 사용 여부에 따라 달라짐)
		 -->
		 <h1>Add Order Direct</h1>
		 <form action="${pageContext.request.contextPath}/AddOrderDirect" method="post" id="addOrderForm">
		 	<input type="hidden" name="goodsCode" value="${order.goodsCode}">
		 	<input type="hidden" name="cutomerId" value="${order.customerId}">
		 	
		 	<table> <!-- 주문고객정보 -->
	 			<tr>
	 				<th colspan="4">주문회원 정보</th>
	 			</tr>
		 		<tr>
		 			<td>이름</td>
		 			<td>${customer.customerName}</td>
		 			<td>전화번호</td>
		 			<td>${customer.customerPhone}</td>
		 		</tr>
		 		<tr>
		 			<td colspan="1">주소</td>
		 			<td colspan="3">select로 처리</td>
		 		</tr>
		 		<tr>
		 			<td></td>
		 		</tr>
		 	</table>
		 	
		 	<table> <!-- 주문상품정보 -->
	 			<tr>
	 				<th colspan="5">주문상품</th>
	 			</tr>
	 			<tr>
	 				<td>상품이미지</td>
		 			<td>상품명</td>
		 			<td>상품금액</td>
		 			<td>갯수</td>
		 			<td>상품옵션</td>
	 			</tr>
	 			<tr>
	 				<td>>${fileName}</td>
		 			<td>${goodsName}</td>
		 			<td>${goodsPrice}</td>
		 			<td>${order.orderQuantity}</td>
		 			<td>${order.goodsOption}</td>
		 		</tr>
		 		<tr>
	 				<td colspan="5">총 주문금액: ${order.orderQuantity}</td>
	 			</tr>
		 	</table>

		 	<button type="button" id="addOrderBtn">주문</button>
		 </form>
	</body>
</html>