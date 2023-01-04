<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>home</title>
	</head>
	<body>
		<h1>HOME - GOODS LIST</h1>
		<table>
			<tr>
				<c:forEach var="g" items="${goodsList}">
					<!-- c:if 사용 : 4*5로 -->
					<td>
						<div>
							<img src="" width="200" height="300">
						</div>
						<div>${g.goodsName}</div>
						<div>${g.goodsPrice}</div>
					</td>
				</c:forEach>
			</tr>
		</table>
		
		<!-- 페이징 -->
		<a></a>
	</body>
</html>