<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>noticeList</title>
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
		
		<h1>NOTICE LIST</h1>
		<table>
			<tr>
				<th>공지번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
			<c:forEach var="n" items="${noticeList}">
				<tr>
					<td>${n.noticeCode}</td>
					<td>
						<a href="${pageContext.request.contextPath}/NoticeOne?noticeCode=${n.noticeCode}">${n.noticeTitle}</a>
					</td>
					<td>${n.empId}</td>
					<td>${n.createdate}</td>
				</tr>
			</c:forEach>
		</table>
		<c:if test="${loginMember.level == 1}"> <!-- 레벨이 1 이고 -->
			<c:if test="${loginMember.authCode >= 2}"> <!-- 사원레벨이 2 이상일 때 -->
				<a href="${pageContext.request.contextPath}/AddNotice">새 공지 추가</a>
			</c:if>
		</c:if>
	</body>
</html>