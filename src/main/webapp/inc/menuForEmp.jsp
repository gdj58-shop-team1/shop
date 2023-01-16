<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div>
	<a href="${pageContext.request.contextPath}/Home">로고</a>
	<a href="${pageContext.request.contextPath}/MyPage">마이페이지</a>
	<a href="${pageContext.request.contextPath}/Logout">로그아웃</a>
</div>

<div>	
	<c:if test="${loginMember.authCode == 1}">
		<a href="${pageContext.request.contextPath}/Home">HOME</a>
		<a href="${pageContext.request.contextPath}/">ADMIN</a>
		<a href="${pageContext.request.contextPath}/GoodsList">내 상품관리</a>
	</c:if>
	
	<c:if test="${loginMember.authCode == 2}">
		<a href="${pageContext.request.contextPath}/Home">HOME</a>
		<a href="${pageContext.request.contextPath}/">ADMIN</a> <!-- 리스트 구현예정(상품관리) -->
		<a href="${pageContext.request.contextPath}/GoodsList">내 상품관리</a>
		<span>주문관리</span>
		<span>공지관리</span>
	</c:if>
	
	<c:if test="${loginMember.authCode == 3}">
		<a href="${pageContext.request.contextPath}/Home">HOME</a>
		<a href="${pageContext.request.contextPath}/">ADMIN</a> <!-- 리스트 구현예정(상품관리) -->
		<a href="${pageContext.request.contextPath}/GoodsList">내 상품관리</a>
		<a href = "${pageContext.request.contextPath}/GoodsListForAdmin3">상단노출</a>
		<span>주문관리</span>
		<span>공지관리</span>
				<a href = "${pageContext.request.contextPath}/EmpList">사원관리</a>
		
	</c:if>
	
	<a href="${pageContext.request.contextPath}/">CATEGORY</a> <!-- 리스트 구현예정 -->
	<a href="${pageContext.request.contextPath}/Cart">CART</a>
	<a href="${pageContext.request.contextPath}/CartList">CART</a>
	<a href="${pageContext.request.contextPath}/OrderList">ORDER</a>
	<a href="${pageContext.request.contextPath}/NoticeList">NOTICE</a>
	<div>${loginMember.empName}님 환영합니다.</div>
	<div>관리자 레벨 : ${loginMember.authCode}</div>
	<div>오늘의 접속자 : ${todaySiteCounter}</div>
	<div>총 접속자 : ${totalSiteCounter}</div>
	
</div>

