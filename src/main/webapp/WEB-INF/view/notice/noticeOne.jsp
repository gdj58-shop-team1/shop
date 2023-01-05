<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>noticeOne</title>
	</head>
	<body>
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
		<a href="${pageContext.request.contextPath}/NoticeModifyController?noticeCode=${notice.noticeCode}">수정</a>
		<a href="${pageContext.request.contextPath}/NoticeRemoveController?noticeCode=${notice.noticeCode}">삭제</a>
	</body>
</html>