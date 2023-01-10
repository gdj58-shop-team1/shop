<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(document).ready(function() { // 이벤트 : <body>~</body>태그가 로드되고 나면 
		
		
	});
</script>
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
	

		
	<h1>고객 정보 변경</h1>
	<form action="${pageContext.request.contextPath}/ModifyMember" method="post">
		<table>
			<tr>
				<th>ID</th>
				<td><input type="text" id="customerId" name="customerId" readonly="readonly" value="${customer.customerId}"></td>
			</tr>
			
			<tr>
				<th>NAME</th>
				<td><input type="text" id="customerName" name="customerName" placeholder="${customer.customerName}"></td>
			</tr>
			
			<tr>
				<th>PHONE</th>
				<td><input type="text" id="customerPhone" name="customerPhone" placeholder="${customer.customerPhone}"></td>
			</tr>
		</table>
		
		<button type="submit" id="">정보변경</button>
	</form>
	
	<h1>사원 정보 변경</h1>
	<form action="${pageContext.request.contextPath}/ModifyMember" method="post">
		<table>
			<tr>
				<th>ID</th>
				<td><input type="text" id="empId" name="empId" readonly="readonly" value="${emp.empID}"></td>
			</tr>
			
			<tr>
				<th>NAME</th>
				<td><input type="text" id="empName" name="empName" placeholder="${emp.empName}"></td>
			</tr>
			<tr>
				<th>LEVEL</th>
				<td><input type="text" id="level" name="level" readonly="readonly" value="${emp.level}"></td>
			</tr>
		</table>
		
		<button type="submit" id="">정보변경</button>


</body>
</html>