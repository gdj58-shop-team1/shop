<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div>
	<a href="${pageContext.request.contextPath}/Home">로고</a>
	<a href="${pageContext.request.contextPath}/MyPage">마이페이지</a>
	<a href="${pageContext.request.contextPath}/Logout">로그아웃</a>
</div>

<div>
	<a href="${pageContext.request.contextPath}/Home">HOME</a>
	<a href="${pageContext.request.contextPath}/">CATEGORY</a>
	<a href="${pageContext.request.contextPath}/Cart">CART</a>
	<a href="${pageContext.request.contextPath}/Order">ORDER</a>
	<a href="${pageContext.request.contextPath}/NoticeList">NOTICE</a>
	<div>${loginMember.customerName}님 환영합니다.</div>
</div>