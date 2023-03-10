<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Create account</title>
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="./loginCss/assets/css/tailwind.output.css" />
    <script
      src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js"
      defer
    ></script>
    <script src="./loginCss/assets/js/init-alpine.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
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
	
	<br>
	
	<!-- form 노출 버튼 -->
	<div>
		<a type="button" href="" id="customerBtn">고객 회원가입</a>
		<a type="button" href="" id="empBtn">사원 회원가입</a>
	</div>
	
	<br>
	
	<h1>고객 회원가입</h1>
	<form action="${pageContext.request.contextPath}/Signin" method="post">
		<table>
			<tr>
				<th>ID</th>
				<td><input type="text" id="customerId" name="customerId"></td>
			</tr>
			
			<tr>
				<th>PW</th>
				<td><input type="password" id="customerPw" name="customerPw"></td>
			</tr>
			
			<!-- 유효성 검사 필요(비밀번호 체크) -->
			<tr>
				<th>PWCHECK</th>
				<td><input type="password" id="customerPwCheck" name="customerPwCheck"></td>
			</tr>
			
			<tr>
				<th>NAME</th>
				<td><input type="text" id="customerName" name="customerName"></td>
			</tr>
			
			<tr>
				<th>PHONE</th>
				<td><input type="text" id="customerPhone" name="customerPhone"></td>
			</tr>
		</table>
		
		<button type="submit" id="signinBtn">회원가입</button>
	</form>
	
	<br>
	
	
</body>
</html>