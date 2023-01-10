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
		// customerLogin 유효성 검사
		$('#customerBtn').click(function() {
				
			// customerPw 미입력시
			if($('#customerPw').val().length < 1) {
				
				alert('비밀번호를 입력해주세요');
				
				$('#customerPw').focus();
				
				return;
			}
			$('#customerConfirmForm').submit();
			
		});
		
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
			<h1>고객 정보 변경</h1>
			<form action="${pageContext.request.contextPath}/ConfirmMember" method="post" id="customerConfirmForm">
				<table>
					<tr>
						<th>ID</th>
						<td><input type="text" id="customerId" name="customerId" readonly="readonly" value="${loginMember.customerId}"></td>
					</tr>
					
					<tr>
						<th>PW</th>
						<td><input type="password" id="customerPw" name="customerPw" ></td>
					</tr>
				</table>
				
				<button type="submit" id="customerBtn">회원수정</button>
			</form>
	</c:if>
	
	<c:if test="${loginMember.level == 1}"> <!-- 로그인(사원) -->
		<jsp:include page="/inc/menuForEmp.jsp"></jsp:include>	
			<h1>사원 정보 변경</h1>
			<form action="${pageContext.request.contextPath}/ConfirmMember" method="post" id = "empConfirmForm">
				<table>
					<tr>
						<th>ID</th>
						<td><input type="text" id="empId" name="empId" readonly="readonly" value="${loginMember.empId}"></td>
					</tr>
					
					<tr>
						<th>PW</th>
						<td><input type="password" id="empPw" name="empPw" ></td>
					</tr>
				</table>
				
				<button type="submit" id="empBtn">회원수정</button>
			</form>
	</c:if>
	

		
	


</body>
</html>