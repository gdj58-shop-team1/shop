<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(document).ready(function() { // 이벤트 : <body>~</body>태그가 로드되고 나면 
		
		
	});
</script>
<title>Insert title here</title>
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
	
	<div>
		<a type="button" id="customerBtn" href="LoginCustomerController">회원 로그인</a>
		<a type="button" id="empBtn" href="LoginEmpController">직원 로그인</a>
	</div>
	
	<form action="${pageContext.request.contextPath}/Login" method="post">
		<table>
			<tr>
				<th>ID</th>
				<td><input type="text" id="customerId" name="customerId"></td>
			</tr>
			
			<tr>
				<th>PW</th>
				<td><input type="password" id="customerPw" name="customerPw"></td>
			</tr>
		</table>
		
		<button type="submit" id="loginCustomerBtn">로그인</button>
	</form>
	
	<form action="${pageContext.request.contextPath}/Login" method="post">
		<table>
			<tr>
				<th>ID</th>
				<td><input type="text" id="empId" name="empId"></td>
			</tr>
			
			<tr>
				<th>PW</th>
				<td><input type="password" id="empPw" name="empPw"></td>
			</tr>
		</table>
		
		<button type="submit" id="LoginEmpBtn">로그인</button>
	</form>
</body>
</html>