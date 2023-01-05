<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>modifyNotice</title>
	</head>
	<body>
		<!-- 메뉴 -->
		<jsp:include page="/inc/menuForEmp.jsp"></jsp:include>
		
		<h1>MODIFY NOTICE</h1>
		<!-- 유효성 검사 -->
		<form action="${pageContext.request.contextPath}/NoticeModify" method="post">
			<input type="hidden" name="noticeCode" value="${notice.noticeCode}">
			<table>
				<tr>
					<th>제목</th>
					<td>
						<input type="text" name="noticeTitle" value="${notice.noticeTitle}">
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea name="noticeContent">${notice.noticeContent}</textarea>
					</td>
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
			<button type="submit">공지수정</button>
		</form>
	</body>
</html>