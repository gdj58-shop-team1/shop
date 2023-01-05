<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>goodsOne</title>
	</head>
	<body>
	<jsp:include page="/inc/menu.jsp"></jsp:include>
		<h1>GOODS ONE</h1>	
		<a href="${pageContext.request.contextPath}/Home">상품목록으로</a>
		<!-- 상품상세보기 -->
		<table border="1">
			<tr>
				<!-- 상품 사진 -->
				<td>
					<div>
						<img src="" width="500" height="500"> <!-- soldout이면 이미지 흐리게 등 구분할 수 있게 -->
					</div>
					
				</td>
				<!-- 상품 정보 + 장바구니 추가, 상품 옵션 추가 -->
				<td>
					<h2>${goodsMap.get('goodsName')}</h2>
					<h4>${goodsMap.get('goodsPrice')}원</h4>
					<div>품절여부: ${goodsMap.get('soldout')}</div>
				</td>
			</tr>
		</table>
	</body>
</html>