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
	<form action="${pageContext.request.contextPath}/ModifyQuestion" method="post">
		<input type="number" id="questionCode" name="questionCode" value="${question.questionCode}" hidden="hidden">
		
		<table border="1">
			<thead>
				<tr>
					<th>상품명</th>
					<th>문의유형</th>
					<th>제목</th>
					<th>내용</th>
					<th>작성자</th>
				</tr>
			</thead>
			
			<tbody>
					<tr>
						<td>${question.goodsName}</td>
						<!-- select 로 구현예정 -->
						<td><input type="text" id="category" name="category" value="${question.category}"></td>
						<td><input type="text" id="questionTitle" name="questionTitle" value="${question.questionTitle}"></td>
						<td><textarea id="questionMemo" name="questionMemo">${question.questionMemo}</textarea></td>
						<td>${question.customerId}</td>
					</tr>
			</tbody>
		</table>
		
		<button type="submit">수정완료</button>
	</form>
</body>
</html>