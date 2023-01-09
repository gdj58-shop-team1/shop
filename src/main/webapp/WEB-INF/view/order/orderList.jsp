<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>orderList</title>
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
		<c:if test="${loginMember.level == 0}"> <!-- 로그인(회원) -->
			<table>
				<tr>
					<th>주문번호</th>
					<th>주문상품</th>
					<th>상품금액</th>
					<th>주문수량</th>
					<th>주문금액</th>
					<th>주문상태</th>
					<th>주문일자</th>
				</tr>
				<c:forEach var="o" items="${orderList}">
					<tr>
						<td>${o.orderCode}</td>
						<td>${o.goodsName}</td>
						<td>${o.goodsPrice}</td>
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
						
						<c:if test="${o.orderState.equals('결제')}"> <!-- 주문상태가 결제이면 -->
							<td>
								${o.orderState}
								<a href="${pageContext.request.contextPath}/AddQuestion?orderCode=${o.orderCode}">문의작성</a>
							</td>
						</c:if>
						
						<c:if test="${!o.orderState.equals('결제') && !o.orderState.equals('구매확정')}"> <!-- 주문상태가 구매확정도 아니고, 결제도 아니면 -->
							<td>${o.orderState}</td>
						</c:if>
						<td>${o.createdate}</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
		
		<c:if test="${loginMember.level == 1}"> <!-- 로그인(사원) -->
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
						<td>${o.goodsName}</td>
						<td>${o.goodsPrice}</td>
						<td>${o.orderQuantity}</td>
						<td>${o.orderPrice}</td>
						<td>${o.customerId}</td>
						<td>${o.orderState}</td> <!-- select로 주문상태 업데이트 -->
						<td>${o.createdate}</td>
					</tr>
				</c:forEach>
			</table>	
		</c:if>
	</body>
</html>