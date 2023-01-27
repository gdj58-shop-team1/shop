<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<c:forEach var="e" items="${empList}">
	<script>
		// form을 2개로 나눴을 때 
		$(document).ready(function() {
			
			const empCode = '<c:out value="${e.empCode}"/>';
			const empCodeWithActive = '#active' + empCode;
			const empCodewithForm = '#empListForAdminForm' + empCode;
			
			
			console.log('empCode '+empCode);
			console.log('empCodeWithActive '+empCodeWithActive);
			console.log('empCodewithForm'+empCodewithForm);
			
			$(empCodeWithActive).change(function() {
					$(empCodewithForm).submit();			
			});
			
		});
		
		$(document).ready(function() {
			
			const empCode = '<c:out value="${e.empCode}"/>';
			const empCodeWithAuthCode = '#authCode' + empCode;
			const empCodewithForm2 = '#empListForAdminForm2' + empCode;
			
			console.log('empCode '+empCode);
			console.log('empCodeWithAuthCode '+empCodeWithAuthCode);
			console.log('empCodewithForm2'+empCodewithForm2);
			
			$(empCodeWithAuthCode).change(function() {
					$(empCodewithForm2).submit();			
			});
			
		});
		
		
		// form을 1개로 합쳤을 때
		/*
		$(document).ready(function() {
			
			const empCode = '<c:out value="${e.empCode}"/>';
			
			const empCodeWithActive = '#active' + empCode;
			const empCodeWithAuthCode = '#authCode' + empCode;
			
			const empCodewithForm = '#empListForAdminForm' + empCode;
			
			
			$(empCodeWithActive).change(function() {
					$(empCodewithForm).submit();			
			});
			
			$(empCodeWithAuthCode).change(function() {
					$(empCodewithForm).submit();			
			});
			
		});
		*/
		
	</script>
</c:forEach>
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
		
		
	
	<h1>사업자 리스트</h1>
	
		<table border="1">
			<thead>
				<tr>
					<th>사업자NO</th>
					<th>사업자ID</th>
					<th>사업자NAME</th>
					<th>활동</th>
					<th>관리자레벨</th>
					<th>가입날짜</th>
					
				</tr>
			</thead>
			<tbody>
				<c:forEach var="e" items="${empList}">
				
					<tr>
						<td>
							<input type = "hidden" name = "empCode" value = "${e.empCode}">
							${e.empCode}
						</td>						
						<td>${e.empId}</td>
						<td>${e.empName}</td>
						
						<!-- active -->
						<td>
							<form  id="empListForAdminForm${e.empCode}" action="${pageContext.request.contextPath}/EmpList?empCode=${e.empCode}" method="post" >
								<input type = "hidden" name = "authCode" value = "${e.authCode}">
								<select name = "active" id ="active${e.empCode}">
									<c:if test = "${e.active eq 'Y'}">
										<option value ='Y' selected="selected">활동계정</option>
										<option value ='N'>휴면계정</option>
									</c:if>
									<c:if test = "${e.active eq 'N'}">
										<option value ='Y'>활동계정</option>
										<option value ='N' selected="selected">휴면계정</option>
									</c:if>
								</select>
							</form>
						</td>
						
						<!-- authCode -->
						<td>		
							<form  id="empListForAdminForm2${e.empCode}" action="${pageContext.request.contextPath}/EmpList?empCode=${e.empCode}" method="post" >
								<input type = "hidden" name = "active" value = "${e.active}">
								<select name = "authCode" id ="authCode${e.empCode}">
									<c:if test = "${e.authCode == 1}">
										<option value ='1' selected="selected">관리자레벨1</option>
										<option value ='2'>관리자레벨2</option>
										<option value ='3'>관리자레벨3</option>
									</c:if>
									<c:if test = "${e.authCode == 2}">
										<option value ='1' >관리자레벨1</option>
										<option value ='2' selected="selected">관리자레벨2</option>
										<option value ='3'>관리자레벨3</option>
									</c:if>
									<c:if test = "${e.authCode == 3}">
										<option value ='1' >관리자레벨1</option>
										<option value ='2'>관리자레벨2</option>
										<option value ='3' selected="selected">관리자레벨3</option>
									</c:if>
								</select>
							</form>
						</td>
						
						<!-- 
						<form  id="empListForAdminForm${e.empCode}" action="${pageContext.request.contextPath}/EmpList?empCode=${e.empCode}" method="post" >
							<td>
							
								<select name = "active" id ="active${e.empCode}">
									<c:if test = "${e.active eq 'Y'}">
										<option value ='Y' selected="selected">활동계정</option>
										<option value ='N'>휴면계정</option>
									</c:if>
									<c:if test = "${e.active eq 'N'}">
										<option value ='Y'>활동계정</option>
										<option value ='N' selected="selected">휴면계정</option>
									</c:if>
								</select>
							</td>
							
					
							<td>
							<select name = "authCode" id ="authCode${e.empCode}">
								<c:if test = "${e.authCode == 1}">
									<option value ='1' selected="selected">관리자레벨1</option>
									<option value ='2'>관리자레벨2</option>
									<option value ='3'>관리자레벨3</option>
								</c:if>
								<c:if test = "${e.authCode == 2}">
									<option value ='1' >관리자레벨1</option>
									<option value ='2' selected="selected">관리자레벨2</option>
									<option value ='3'>관리자레벨3</option>
								</c:if>
								<c:if test = "${e.authCode == 3}">
									<option value ='1' >관리자레벨1</option>
									<option value ='2'>관리자레벨2</option>
									<option value ='3' selected="selected">관리자레벨3</option>
								</c:if>
							</select>
							</td>
						</form>
						 -->
							
						<td>${e.createdate}</td>
					</tr>	
				</c:forEach>
			</tbody>
		</table>

	<!--  페이지 -->
	<div>
		<c:if test="${currentPage > 1}">
			<span><a href="${pageContext.request.contextPath}/EmpList?currentPage=${currentPage-1}">이전</a></span>
		</c:if>
		<c:if test="${currentPage == 1}">
			<span>이전</span>
		</c:if>
		
		<span>${currentPage}</span>
						
		<c:if test="${currentPage < endPage}">
			<span><a href="${pageContext.request.contextPath}/EmpList?currentPage=${currentPage+1}">다음</a></span>
		</c:if>
		<c:if test="${currentPage == endPage}">
			<span>다음</span>
		</c:if>
	
	</div>

	
	
	
		
		
		
		
		
		

</body>
</html>