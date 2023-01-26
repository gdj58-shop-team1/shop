<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	
		<!-- 세션 정보별로 메뉴 분기 -->
		<c:if test="${loginMember == null}"> <!-- 비로그인 -->
			<jsp:include page="/inc/menu.jsp"></jsp:include>	
		</c:if>
		
		<c:if test="${loginMember.level == 0}"> <!-- 로그인(회원) -->
		<jsp:include page="/inc/menuForCustomer.jsp"></jsp:include>	
				
			<h1>고객 탈퇴</h1>
			<form action="${pageContext.request.contextPath}/RemoveMember" method="post" id = "removeCustomer">
				<table>
					<tr>
						<th>ID</th>
						<td><input type="text" id="customerId" name="customerId" readonly="readonly" value="${loginMember.customerId}"></td>
					</tr>
					<tr>
						<th>NAME</th>
						<td><input type ="text" id ="customerName" name="customerName" readonly="readonly" value="${loginMember.customerName}"></td>
					</tr>
					<tr>
						<th>PASSWORD</th>
						<td><input type="password" id="customerPw" name="customerPw" value="${loginMember.customerPw}"></td>
					</tr>
				</table>
				
				<button type="submit" id="customerBtn">회원탈퇴</button>
			</form>
	</c:if>
	
	
	<c:if test="${loginMember.level == 1}"> <!-- 로그인(사원) -->
		<jsp:include page="/inc/menuForEmp.jsp"></jsp:include>	
			<h1>사원 탈퇴</h1>
			<form action="${pageContext.request.contextPath}/RemoveMember" method="post" id = "removeEmp">
				<table>
					<tr>
						<th>ID</th>
						<td><input type="text" id="empId" name="empId" readonly="readonly" value="${loginMember.empId}"></td>
					</tr>
					<tr>
						<th>NAME</th>
						<td><input type ="text" id ="empName" name="empName" readonly="readonly" value="${loginMember.empName}"></td>
					</tr>
					
					<tr>
						<th>PASSWORD</th>
						<td><input type="password" id="empPw" name="empPw"  value="${loginMember.empPw}"></td>
					</tr>
				</table>
				
				<button type="submit" id="empBtn">사원탈퇴</button>
			</form>
	</c:if>



</body>
</html>