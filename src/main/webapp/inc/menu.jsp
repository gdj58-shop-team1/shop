<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div>
	<a href="${pageContext.request.contextPath}/Home">로고</a>
	<a href="${pageContext.request.contextPath}/Signin">회원가입</a>
	<a href="${pageContext.request.contextPath}/Login">login</a>
</div>

<div>
	<a href="${pageContext.request.contextPath}/Home">HOME</a>
	<a href="${pageContext.request.contextPath}/">CATEGORY</a>
	<a href="${pageContext.request.contextPath}/CartList">CART</a>
	<a href="${pageContext.request.contextPath}/OrderList">ORDER</a>
	<a href="${pageContext.request.contextPath}/NoticeList">NOTICE</a>
</div>

<div>오늘의 접속자 : ${todaySiteCounter}</div>
<div>총 접속자 : ${totalSiteCounter}</div>