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
					<th>솔드아웃</th>
					
					<th>관리자</th>
					<th>action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="g" items="${goodsList}">
					<tr>
						<td>${g.goodsCode}</td>						
						<td>
							<a>
								<img src="${pageContext.request.contextPath}/upload/${g.fileName}" width="100px" height="100px" alt="상품 이미지"/>
								${g.goodsName}
							</a>
						</td>
						<td>${g.goodsPrice}</td>
						<td>${g.goodsCategory}</td>
						<td>${g.soldout}</td>
						
						<td>${g.empId}</td>
						<td>
							<a href="${pageContext.request.contextPath}/ModifyGoods?goodsCode=${g.goodsCode}&fileName=${g.fileName}">수정</a>
							<a href="${pageContext.request.contextPath}/DeleteGoods?goodsCode=${g.goodsCode}&fileName=${g.fileName}">삭제</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<!--  페이지 -->
		<div>
			<c:if test="${currentPage > 1}">
				<span><a href="${pageContext.request.contextPath}/GoodsList?currentPage=${currentPage-1}">이전</a></span>
			</c:if>
			<c:if test="${currentPage == 1}">
				<span>이전</span>
			</c:if>
			
			<span>${currentPage}</span>
							
			<c:if test="${currentPage < endPage}">
				<span><a href="${pageContext.request.contextPath}/GoodsList?currentPage=${currentPage+1}">다음</a></span>
			</c:if>
			<c:if test="${currentPage == endPage}">
				<span>다음</span>
			</c:if>
		
		</div>


</body>
</html>