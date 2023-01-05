<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>noticeList</title>
	</head>
	<body>
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
		<a href="${pageContext.request.contextPath}/NoticeAdd">새 공지 추가</a>
	</body>
</html>