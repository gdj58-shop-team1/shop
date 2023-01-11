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


	<h1>상품등록 페이지</h1>
	<form enctype="multipart/form-data" action="${pageContext.request.contextPath}/AddGoodsList" method="post">
		<div>상품이름 : <input type="text" name="goodsName"></div>
		<div>상품사진 : <input type="file" name="goodsImg"></div>
		<div><button type = "submit"> 상품등록 </button></div>
	</form>
</body>
</html>

