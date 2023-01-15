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
	<form action="${pageContext.request.contextPath}/AddQuestion" method="post">
		<input type="hidden" id="orderCode" name="orderCode" value="${map.orderCode}">
		
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
					<td>${map.goodsName}</td>
					<!-- select 로 구현예정 -->
					<td>
						<select id="category" name="category">
							<option value="배송">배송</option>
							<option value="반품">반품</option>
							<option value="교환">교환</option>
							<option value="기타">기타</option>
						</select>
					</td>
					<td><input type="text" id="questionTitle" name="questionTitle"></td>
					<td><textarea id="questionMemo" name="questionMemo"></textarea></td>
					<td>${loginMember.customerId}</td>
				</tr>
			</tbody>
		</table>
		<br>
		<button type="submit">문의 작성</button>
	</form>
</body>
</html>