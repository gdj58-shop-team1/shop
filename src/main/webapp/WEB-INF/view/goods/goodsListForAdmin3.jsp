<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<c:forEach var="g" items="${goodsList}">
			<script>
				$(document).ready(function() {
					
					const goodsCode = '<c:out value="${g.goodsCode}"/>';
					const goodsCodeWithHit = '#hit' + goodsCode;
					const goodsCodewithForm = '#goodsListForAdminForm' + goodsCode;
					
					console.log('goodsCode '+goodsCode);
					console.log('goodsCodeWithHit '+goodsCodeWithHit);
					console.log('goodsCodewithForm'+goodsCodewithForm);
					
					$(goodsCodeWithHit).change(function() {
							$(goodsCodewithForm).submit();			
					});
					
				});
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
		
		
	
	<h1>최상위 관리자 상품목록 페이지</h1>
		
			<table border="1">
				<thead>
					<tr>
						<th>상품코드</th>
						<th>상품명</th>
						<th>판매가</th>
						<th>카테고리</th>
						<th>솔드아웃</th>
						<th>hit</th>
						<th>관리자</th>
						
					</tr>
				</thead>
				<tbody>
					<c:forEach var="g" items="${goodsList}">
						
							
							<tr>
								<td>
									<input type = "hidden" name = "goodsCode" value = "${g.goodsCode}">
									${g.goodsCode}
								</td>						
								<td>
									<a>
										<img src="${pageContext.request.contextPath}/upload/${g.fileName}" width="100px" height="100px" alt="상품 이미지"/>
										${g.goodsName}
									</a>
								</td>
								<td>${g.goodsPrice}</td>
								<td>${g.goodsCategory}</td>
								<td>${g.soldout}</td>
								
								
								<td>
									<form id="goodsListForAdminForm${g.goodsCode}" action="${pageContext.request.contextPath}/GoodsListForAdmin3?goodsCode=${g.goodsCode}" method="post">
										<select name = "hit" id = "hit${g.goodsCode}">
											<c:if test="${g.hit == 0}">
												<option value='0' selected="selected">상단노출x</option>
												<option value='1'>상단노출o</option>
			
											</c:if>
											<c:if test="${g.hit == 1}">
												<option value='0'>상단노출x</option>
												<option value='1'selected="selected">상단노출o</option>
			
											</c:if>
										</select>
									</form>
								</td>
				
								
								<td>${g.empId}</td>
								
							</tr>
						</form>
					</c:forEach>
				</tbody>
			</table>
		</form>
		<!--  페이지 -->
		<div>
			<c:if test="${currentPage > 1}">
				<span><a href="${pageContext.request.contextPath}/GoodsListForAdmin3?currentPage=${currentPage-1}">이전</a></span>
			</c:if>
			<c:if test="${currentPage == 1}">
				<span>이전</span>
			</c:if>
			
			<span>${currentPage}</span>
							
			<c:if test="${currentPage < endPage}">
				<span><a href="${pageContext.request.contextPath}/GoodsListForAdmin3?currentPage=${currentPage+1}">다음</a></span>
			</c:if>
			<c:if test="${currentPage == endPage}">
				<span>다음</span>
			</c:if>
		
		</div>


</body>
</html>