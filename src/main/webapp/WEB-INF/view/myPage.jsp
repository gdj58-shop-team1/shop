<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<title>Insert title here</title>
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
	
	
	<c:if test="${loginMember.level == 0}"> <!-- 로그인(회원) -->
		<h1>회원</h1>
		<table>
			<tr>
				<th>ID</th>
				<td>${loginMember.customerId}</td>
			</tr>
			
			<tr>
				<th>NAME</th>
				<td>${loginMember.customerName}</td>
			</tr>	
		</table>
		
		<a href="${pageContext.request.contextPath}/OrderList">주문 목록</a>
		<a href="${pageContext.request.contextPath}/ReviewList">리뷰 목록</a>
		<a href="${pageContext.request.contextPath}/QuestionList">문의사항</a>
		<a href="${pageContext.request.contextPath}/ConfirmMember">정보 변경</a>
		<a href="${pageContext.request.contextPath}/AddressList">배송지 변경</a>
		<a href="">회원 탈퇴</a>
	</c:if>
	
	<c:if test="${loginMember.level == 1}"> <!-- 로그인(사원) -->
		<h1>사원 (레벨 : ${loginMember.authCode})</h1>
		<table>
			<tr>
				<th>ID</th>
				<td>${loginMember.empId}</td>
			</tr>
			
			<tr>
				<th>NAME</th>
				<td>${loginMember.empName}</td>
			</tr>	
		</table>
		
		<a href="">상품 관리</a>
		<a href="${pageContext.request.contextPath}/ReviewList">리뷰 관리</a>
		<a href="${pageContext.request.contextPath}/QuestionList">문의 관리</a>
		<a href="${pageContext.request.contextPath}/ConfirmMember">정보 변경</a>
		<a href="">사원 탈퇴</a>
	</c:if>
	
</body>
</html>