<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>home</title>
	</head>
	<body>
	<jsp:include page="/inc/menu.jsp"></jsp:include>
		<h1>HOME - GOODS LIST</h1>
		<!-- 정렬 선택(기본, 최근, 인기, 높은가격, 낮은가격) -->
		<div>
			<span><a href="${pageContext.request.contextPath}/Home?sort=g.goods_Name ASC">기본순</a></span>
			&nbsp;
			<span><a href="${pageContext.request.contextPath}/Home?sort=g.createdate DESC">최근순</a></span>
			&nbsp;
			<span><a href="${pageContext.request.contextPath}/Home?sort=g.hit DESC">인기순</a></span>
			&nbsp;
			<span><a href="${pageContext.request.contextPath}/Home?sort=g.goods_Price DESC">높은 가격순</a></span>
			&nbsp;
			<span><a href="${pageContext.request.contextPath}/Home?sort=g.goods_Price ASC">낮은 가격순</a></span>
		</div>
		
		<!-- 검색폼 -->
		<form action="${pageContext.request.contextPath}/Home" method="get">
			<div>
				<span>
					<c:if test="${searchWord == null}"> <!-- 세션에서 받은 검색값이 없으면 일반 input -->
						<input type="text" name="searchWord" placeholder="상품명 검색">
					</c:if>
					<c:if test="${searchWord != null}"> <!-- 세션에서 받은 검색값이 있으면 input에 value값 넣기 -->
						<input type="text" name="searchWord" value="${searchWord}">
					</c:if>
				</span>
				<span><button type="submit">검색</button></span>
			</div>
		</form>
		
		<!-- 상품목록 -->
		<table border="1">
			<tr>
				<!-- 
					${status.index} 0부터의 순서
					${status.count} 1부터의 순서
				-->
				<!-- c:if 사용 : 4*5로 -->
				<c:forEach var="g" items="${goodsList}" varStatus="s">
					<c:if test="${s.index != 0 && s.index%5 == 0}"> <!-- count를 쓰게되면 1%4 == 0이 성립안됨 -->
						</tr><tr>
					</c:if>
					<td>
						<div>
							<img src="" width="200" height="250"> <!-- soldout이면 이미지 흐리게 등 구분할 수 있게 -->
						</div>
						<div>${g.soldout}</div>
						<div>${g.goodsCode} ${g.goodsName}</div>
						<div>${g.goodsPrice}</div>
					</td>
				</c:forEach>
			</tr>
		</table>
		
		<!-- 페이징 (검색값 분기)-->
		<div>
			<!-- 검색값 있으면 -->
			<c:if test="${searchWord == null}">
				<!-- currentPage가 1보다 크면 이전 링크O, 1이면 글자만 -->
				<c:if test="${currentPage > 1}">
					<span><a href="${pageContext.request.contextPath}/Home?currentPage=${currentPage-1}&sort=${sort}">이전</a></span>
				</c:if>
				<c:if test="${currentPage == 1}">
					<span>이전</span>
				</c:if>
				
				<span>${currentPage}</span>
				
				<!-- endPage가 보다 currentPage크면 다음 링크O, 같으면 글자만 -->
				<c:if test="${currentPage < endPage}">
					<span><a href="${pageContext.request.contextPath}/Home?currentPage=${currentPage+1}&sort=${sort}">다음</a></span>
				</c:if>
				<c:if test="${currentPage == endPage}">
					<span>다음</span>
				</c:if>
			</c:if>
			
			<!-- 검색값 없으면 -->
			<c:if test="${searchWord != null}">
				<c:if test="${currentPage > 1}">
					<span><a href="${pageContext.request.contextPath}/Home?currentPage=${currentPage-1}&searchWord=${searchWord}&sort=${sort}">이전</a></span>
				</c:if>
				<c:if test="${currentPage == 1}">
					<span>이전</span>
				</c:if>
				
				<span>${currentPage}</span>
								
				<c:if test="${currentPage < endPage}">
					<span><a href="${pageContext.request.contextPath}/Home?currentPage=${currentPage+1}&searchWord=${searchWord}&sort=${sort}">다음</a></span>
				</c:if>
				<c:if test="${currentPage == endPage}">
					<span>다음</span>
				</c:if>
			</c:if>
		</div>
	</body>
</html>