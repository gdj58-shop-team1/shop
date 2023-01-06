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
	<c:if test="${loginMember.level == 0}">
		<table>
			<thead>
				<tr>
					<th>주문번호</th>
					<th>상품명</th>
					<th>문의유형</th>
					<th>제목</th>
					<th>작성일</th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach var="q" items="${questionList}">
					<tr>
						<td>${q.orderCode}</td>
						<td>${q.goodsName}</td>
						<td>${q.category}</td>
						<td><a href="${pageContext.request.contextPath}/QuestionOne?questionCode=${q.questionCode}">${q.questionTitle}</a></td>
						<td>${q.createdate}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>
	
	<c:if test="${loginMember.level == 1}">
			<table>
				<thead>
					<tr>
						<th>주문번호</th>
						<th>상품명</th>
						<th>문의유형</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach var="q" items="${questionList}">	
						<tr>
							<td>${q.orderCode}</td>
							<td>${q.goodsName}</td>
							<td>${q.category}</td>
							<td><a href="${pageContext.request.contextPath}/QuestionOne?questionCode=${q.questionCode}">${q.questionTitle}</a></td>
							<td>${q.customerId}</td>
							<td>${q.createdate}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
	</c:if>
	<br>
	<div>
		<a href="${pageContext.request.contextPath}/AddQuestion">문의 작성</a>
	</div>
</body>
</html>