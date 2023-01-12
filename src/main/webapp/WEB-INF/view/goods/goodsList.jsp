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
		
		
	<a href ="${pageContext.request.contextPath}/AddGoods">상품추가하기</a>	
	<h1>상품목록 페이지</h1>
		<table border="1">
			<thead>
				<tr>
					<th>상품코드</th>
					<th>상품명</th>
					<th>판매가</th>
					<th>카테고리</th>
					<th>솔드아웃<th>
					<th>hit</th>
					<th>관리자</th>
					<th>action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="goodsList" items="${goodsList}">
					<tr>
						<td>${goodsList.goodsCode}</td>
						<td>
							<a href="${pageContext.request.contextPath}/goodsOne?goodsCode=${goodsList.goodsCode}">
								<img src="${pageContext.request.contextPath}/upload/${goodsList.filename}" width="100px" height="100px" alt="상품 이미지"/>
								${goodsList.goodsName}
							</a>
						</td>
						<td>${goodsList.goodsPrice}</td>
						<td>
							<a href="${pageContext.request.contextPath}/removeGoods?goodsCode=${goodsList.goodsCode}&filename=${goodsList.filename}">삭제</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>





</body>
</html>