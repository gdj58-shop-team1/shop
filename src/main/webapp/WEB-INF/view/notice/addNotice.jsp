<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>addNotice</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(document).ready(function(){
				$('#noticeBtn').click(function(){
					if($('#noticeTitle').val() == ''){
						alert('제목을 입력하세요.');
						return;
					}
					
					if($('#noticeContent').val() == ''){
						alert('내용을 입력하세요.');
						return;
					}
					
					$('#noticeForm').submit();
				});
			});
		</script>
	</head>
	<body>
		<!-- 메뉴 -->
		<jsp:include page="/inc/menuForEmp.jsp"></jsp:include>
		
		<h1>ADD NOTICE</h1>
		<form action="${pageContext.request.contextPath}/AddNotice" method="post" id="noticeForm">
			<table>
				<tr>
					<th>제목</th>
					<td>
						<input type="text" name="noticeTitle" id="noticeTitle">
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea name="noticeContent" id="noticeContent"></textarea>
					</td>
				</tr>
			</table>
			<button type="button" id="noticeBtn">공지추가</button>
		</form>
	</body>
</html>