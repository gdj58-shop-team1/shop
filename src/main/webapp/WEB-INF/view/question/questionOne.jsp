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
				<td>${question.category}</td>
				<td>${question.questionTitle}</td>
				<td><textarea id="questionMemo" name="questionMemo" readonly="readonly">${question.questionMemo}</textarea></td>
				<td>${question.customerId}</td>
			</tr>
		</tbody>
	</table>
			
	<c:if test="${loginMember.level == 0}">
		<a type="button" href="${pageContext.request.contextPath}/ModifyQuestion?questionCode=${question.questionCode}">수정</a>
		
		<h3>댓글</h3>
		<table border="1">
			<tr>
				<th>내용</th>
				<th>작성일</th>
			</tr>
		
			<c:forEach var="l" items="${list}">
				<tr>
					<th>${l.commentMemo}</th>
					<th>${l.createdate}</th>
				</tr>
			</c:forEach>
		</table>		
	</c:if>
	
	<c:if test="${loginMember.level == 1}">
		<h3>댓글</h3>
		<table border="1">
			<tr>
				<th>내용</th>
				<th>작성일</th>
				<th>삭제</th>
			</tr>

			<c:forEach var="l" items="${list}">
				<tr>
					<th>${l.commentMemo}</th>
					<th>${l.createdate}</th>
					<th>
						<a href="${pageContext.request.contextPath}/RemoveQuestionComment?questionCode=${question.questionCode}&commentCode=${l.commentCode}">댓글 삭제</a>
					</th>
				</tr>
			</c:forEach>
		</table>
		
		<br><br>
		<form action="${pageContext.request.contextPath}/AddQuestionComment" method="post">
			<input type="hidden" name="questionCode" value="${question.questionCode}">			
			<table border="1">
				<tr>
					<th>내용</th>
					<th>댓글 쓰기</th>
				</tr>
			
				<tr>
					<th><textarea name="commentMemo"></textarea></th>
					<th><button type="submit">댓글 쓰기</button></th>
				</tr>
			</table>
		</form>
	</c:if>
</body>
</html>