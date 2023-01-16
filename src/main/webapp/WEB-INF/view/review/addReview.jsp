<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>addReview</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(document).ready(function(){
				$('#reviewBtn').click(function(){
					if($('#reviewMemo').val() == ''){
						alert('내용을 입력하세요.');
						return;
					}
					
					$('#reviewForm').submit();
				});
			});
		</script>
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
		<h1>ADD REVIEW</h1>
		<form action="${pageContext.request.contextPath}/AddReview" method="post" id="reviewForm">
			<input type="hidden" name="orderCode" value="${order.orderCode}">
			<input type="hidden" name="orderPrice" value="${order.orderPrice}">
			<table>
				<tr>
					<th>주문번호</th>
					<td>${order.orderCode}</td>
					<th>주문일자</th>
					<td>${order.createdate}</td>
				</tr>
				<tr>
					<th>주문상품</th>
					<td>${order.goodsName}</td>
					<th>주문금액</th>
					<td>${order.orderPrice}</td>
				</tr>
				<tr>
					<th>리뷰내용</th>
					<td colspan="3">
						<textarea name="reviewMemo" id="reviewMemo"></textarea>
					</td>
				</tr>
			</table>
			<button type="button" id="reviewBtn">리뷰작성</button>
		</form>
	</body>
</html>