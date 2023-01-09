<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>addReview</title>
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
		<form action="${pageContext.request.contextPath}/AddReview" method="post"> <!-- 자바스크립트로 유효성 검사 -->
			<input type="hidden" name="orderCode" value="${order.orderCode}">
			<table>
				<tr>
					<th>주문번호</th>
					<td>${order.orderCode}</td>
				</tr>
				<tr>
					<th>주문상품</th>
					<td>${order.goodsName}</td>
				</tr>
				<tr>
					<th>주문일자</th>
					<td>${order.createdate}</td>
				</tr>
				<tr>
					<th>리뷰내용</th>
					<td>
						<textarea name="reviewMemo"></textarea>
					</td>
				</tr>
			</table>
			<button type="submit">리뷰작성</button> <!-- 자바스크립트 사용 시 type="button"으로 수정 -->
		</form>
	</body>
</html>