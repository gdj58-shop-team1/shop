<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>reviewList</title>
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
		<h1>REVIEW LIST</h1>
		<c:if test="${loginMember.level == 0}"> <!-- 로그인(회원) -->
			<table>
				<tr>
					<th>주문번호</th>
					<th>주문상품</th>
					<th>리뷰내용</th>
					<th>수정</th>
					<th>작성일</th>
				</tr>
				<c:forEach var="r" items="${reviewList}">
					<tr>
						<td>${r.orderCode}</td>
						<td>${r.goodsName}</td>
						<td>${r.reviewMemo}</td>
						<td>
							<a href="${pageContext.request.contextPath}/ReviewModify?orderCode=${r.orderCode}">리뷰수정</a>
						</td>
						<td>${r.createdate}</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
		<c:if test="${loginMember.level == 1}"> <!-- 로그인(사원) -->
			<table>
				<tr>
					<th>주문번호</th>
					<th>등록상품</th> <!-- 상품이름으로 나오게 수정 : Dao 쿼리 수정(goods 테이블 조인) -->
					<th>리뷰내용</th>
					<th>작성일</th>
				</tr>
				<c:forEach var="r" items="${reviewList}">
					<tr>
						<td>${r.orderCode}</td>
						<td>${r.goodsName}</td>
						<td>${r.reviewMemo}</td>
						<td>${r.createdate}</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
	</body>
</html>