<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
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
					<c:forEach var="g" items="${goodsList}">
					
						<tr>
							<td>
								<input type = "hidden" name = "empCode" value = "${e.empCode}">
								${e.empCode}
							</td>						
							<td>${e.empId}</td>
							<td>${e.empName}</td>
							<td>
								<form  id="empList${e.empCode}" action="${pageContext.request.contextPath}/EmpList?empCode=${e.empCode}" method="post" >
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
							<td>${e.authCode}</td>
								
							<td>${e.createdate }</td>
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