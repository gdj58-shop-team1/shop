<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>orderComplete</title>
	</head>
	<body>
		<!-- 
			주문완료 페이지
			주문자 정보(이름 주소 번호)
			주문상품 정보(주문번호, 상품이름, 상품 갯수, 결제 금액)
			결제 완료 안내 문구(무통장 입금)
		 -->
		 <h1>주문완료 페이지</h1>
		 
		 
		 <div>${address}</div>
		 
	</body>
</html>