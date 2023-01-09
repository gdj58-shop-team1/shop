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
						<td>주문번호</td>
						<td>주문번호</td>
						<td>주문번호</td>
						<td>주문번호</td>
						<td>주문번호</td>
						<td>주문번호</td>
						<td>주문번호</td>
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
						<td>주문번호</td>
						<td>주문번호</td>
						<td>주문번호</td>
						<td>주문번호</td>
						<td>주문번호</td>
						<td>주문번호</td>
						<td>주문번호</td>
						<td>주문번호</td>
					</tr>
				</c:forEach>
			</table>	
		</c:if>
	</body>
</html>