<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>addNotice</title>
	</head>
	<body>
		<h1>ADD NOTICE</h1>
		<!-- 유효성 검사 -->
		<form action="${pageContext.request.contextPath}/NoticeAdd" method="post">
			<table>
				<tr>
					<th>제목</th>
					<td>
						<input type="text" name="noticeTitle">
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea name="noticeContent"></textarea>
					</td>
				</tr>
			</table>
			<button type="submit">공지추가</button>
		</form>
	</body>
</html>