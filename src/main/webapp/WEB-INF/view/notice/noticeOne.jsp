<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>noticeOne</title>
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
		
		<h1>NOTICE ONE</h1>
		<table>
			<tr>
				<th>공지번호</th>
				<td>${notice.noticeCode}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${notice.noticeTitle}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${notice.noticeContent}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${notice.empId}</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td>${notice.createdate}</td>
			</tr>
		</table>
		<c:if test="${loginMember.level == 1}"> <!-- 레벨이 1 이고 -->
			<c:if test="${loginMember.authCode >= 2 && (notice.empId == loginMember.empId)}"> <!-- 사원레벨이 2 이상이고, 작성자와 세션 정보가 일치할 때 -->
				<a href="${pageContext.request.contextPath}/ModifyNotice?noticeCode=${notice.noticeCode}">수정</a>
				<a href="${pageContext.request.contextPath}/RemoveNotice?noticeCode=${notice.noticeCode}">삭제</a>
			</c:if>
		</c:if>
	</body>
</html>